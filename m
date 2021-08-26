Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE43F88FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbhHZNbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:31:20 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47686 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242545AbhHZNbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:31:14 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPSA id D306740A2BAC;
        Thu, 26 Aug 2021 13:30:22 +0000 (UTC)
Subject: Re: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable() in
 probe
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <20210825170902.11234-1-novikov@ispras.ru>
 <20210825172937.GD192480@rowland.harvard.edu>
From:   Evgeny Novikov <novikov@ispras.ru>
Message-ID: <c22d943a-581c-c1bd-d453-3f0f6176c8a5@ispras.ru>
Date:   Thu, 26 Aug 2021 16:30:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210825172937.GD192480@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 25.08.2021 20:29, Alan Stern wrote:
> On Wed, Aug 25, 2021 at 08:09:02PM +0300, Evgeny Novikov wrote:
>> ehci_orion_drv_probe() did not account for possible errors of
>> clk_prepare_enable() that in particular could cause invocation of
>> clk_disable_unprepare() on clocks that were not prepared/enabled yet,
>> e.g. in remove or on handling errors of usb_add_hcd() in probe. Though,
>> there were several patches fixing different issues with clocks in this
>> driver, they did not solve this problem.
>>
>> Add handling of errors of clk_prepare_enable() in ehci_orion_drv_probe()
>> to avoid calls of clk_disable_unprepare() without previous successful
>> invocation of clk_prepare_enable().
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Fixes: 8c869edaee07 ("ARM: Orion: EHCI: Add support for enabling clocks")
>> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
>> Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
>> Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
>> ---
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> Do you intend to submit patches for the other EHCI drivers that don't
> check for errors in clk_prepare_enable()?  It looks like
> ehci-atmel.c, ehci-mv.c, and ehci-spear.c all need some attention.
>
> The same is true for a bunch of the OHCI drivers: ohci-at91.c,
> ohci-exynos.c, ohci-s3c2410.c, and ohci-spear.c.
>
> Didn't the Linux Driver Verification project identify this problem in
> all of these drivers?
Our verification framework report numerous issues like the one for which 
I sent the given patch. There are many warnings for different USB 
drivers and other types of device drivers as well. We sent several 
patches that were acknowledged by the developers already, though, after 
the Andrew's reply [1] I have doubts that we need to treat these 
warnings as potential bugs and fix them. The verification framework 
performs static analysis in a way that I described before [2]. Regarding 
the clock API it uses such models of clk_prepare() and clk_enable() that 
can fail independently on underlying hardware since is not easy to 
either model all such hardware or try to relate and consider 
corresponding drivers in addition to drivers using clocks at 
verification. Thus, potentially the verification framework can produce 
warnings for all drivers that invoke clk_prepare(), clk_enable() or 
clk_prepare_enable(), but do not check for their return values.

I look forward whether you will confirm that it makes sense to handle 
errors from mentioned functions anyway or it would be better not to sent 
such bug reports unless we will be strictly sure that they can happen. 
In the former case it would be better if somebody will teach built-in 
Linux kernel static analyzers to detect these issues on a regular basis.

[1] https://lkml.org/lkml/2021/8/25/794
[2] https://lkml.org/lkml/2021/8/17/239

Best regards,
Evgeny Novikov
> Alan Stern
>
>>   drivers/usb/host/ehci-orion.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
>> index a319b1df3011..3626758b3e2a 100644
>> --- a/drivers/usb/host/ehci-orion.c
>> +++ b/drivers/usb/host/ehci-orion.c
>> @@ -264,8 +264,11 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>>   	 * the clock does not exists.
>>   	 */
>>   	priv->clk = devm_clk_get(&pdev->dev, NULL);
>> -	if (!IS_ERR(priv->clk))
>> -		clk_prepare_enable(priv->clk);
>> +	if (!IS_ERR(priv->clk)) {
>> +		err = clk_prepare_enable(priv->clk);
>> +		if (err)
>> +			goto err_put_hcd;
>> +	}
>>   
>>   	priv->phy = devm_phy_optional_get(&pdev->dev, "usb");
>>   	if (IS_ERR(priv->phy)) {
>> @@ -311,6 +314,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>>   err_dis_clk:
>>   	if (!IS_ERR(priv->clk))
>>   		clk_disable_unprepare(priv->clk);
>> +err_put_hcd:
>>   	usb_put_hcd(hcd);
>>   err:
>>   	dev_err(&pdev->dev, "init %s fail, %d\n",
>> -- 
>> 2.26.2
>>
