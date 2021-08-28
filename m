Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857063FA502
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhH1KiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:38:05 -0400
Received: from mail.ispras.ru ([83.149.199.84]:41922 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbhH1KiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:38:04 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3924040D403D;
        Sat, 28 Aug 2021 10:37:10 +0000 (UTC)
Subject: Re: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable() in
 probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <20210825170902.11234-1-novikov@ispras.ru>
 <20210825172937.GD192480@rowland.harvard.edu>
 <c22d943a-581c-c1bd-d453-3f0f6176c8a5@ispras.ru>
 <20210826152438.GB228824@rowland.harvard.edu>
 <4d91f982-99df-29d2-c335-1df0c23acbc8@ispras.ru>
 <20210827115156.GK7722@kadam>
From:   Evgeny Novikov <novikov@ispras.ru>
Message-ID: <2290efca-b6c9-6964-7b5c-7ad5d53d719c@ispras.ru>
Date:   Sat, 28 Aug 2021 13:37:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210827115156.GK7722@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 27.08.2021 14:51, Dan Carpenter wrote:
> On Thu, Aug 26, 2021 at 07:26:22PM +0300, Evgeny Novikov wrote:
>> I added Dan to the discussion since he is a developer of one of such
>> tools.
> Thanks for that...  :P
>
> I never warn about "forgot to check the return" bugs except in the case
> of error pointers or allocation failures.  There are too many false
> positives.  If people want to do that they should add a __must_check
> attribute to the function.
Maybe you will be able to convince the developers of the clock framework 
to add this attribute to some of their functions. For instance, this is 
already the case, say, for clk_bulk_prepare() and clk_bulk_enable() that 
seem to represent a number of clk_prepare() and clk_enable(). For those 
functions the __must_check attribute was added in commit 6e0d4ff4580c 
without providing any specific reasons why it is necessary for them and 
is not necessary for usual clk_prepare() and clk_enable().
> You linked to another thread: https://lkml.org/lkml/2021/8/17/239
>
> That patch isn't correct.  Miquel was on the right track but not 100%.
> The nand_scan() calls mxic_nfc_clk_enable() so we should disable it
> until it has been successfully enabled.  The current code can trigger a
> WARN() in __clk_disable().  In other words it should have been:
>
> diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
> index da1070993994..87aef98f5b9d 100644
> --- a/drivers/mtd/nand/raw/mxic_nand.c
> +++ b/drivers/mtd/nand/raw/mxic_nand.c
> @@ -535,11 +535,11 @@ static int mxic_nfc_probe(struct platform_device *pdev)
>   	err = devm_request_irq(&pdev->dev, irq, mxic_nfc_isr,
>   			       0, "mxic-nfc", nfc);
>   	if (err)
> -		goto fail;
> +		return err;
>   
>   	err = nand_scan(nand_chip, 1);
>   	if (err)
> -		goto fail;
> +		return err;
>   
>   	err = mtd_device_register(mtd, NULL, 0);
>   	if (err)
Thank you for this explanation. Now I understand better the Miquel's 
comment. Nevertheless, I still have doubts that your fix is completely 
correct since  mxic_nfc_set_freq() invokes mxic_nfc_clk_disable() first 
that still should raise a warning. It seems that the driver developers 
are looking on this issue, so, let's wait a bug fix from them. At least 
they will be able to test that everything is okay after all.
> nand_scan() error handling is still leaky, but it's hard to fix without
> re-working the API.
>
> Anyway, thanks for the fixes.  I've been inspired by the Linux Driver
> Verification project work.
It would be great to collaborate with each other. For instance, for the 
aforementioned clock API your tool can perform better checking and find 
more potential bugs in some (maybe even all) cases due to a number of 
reasons. Unless it will be possible to detect all target issues 
automatically with static analysis tools, we can try to reveal some of 
the remaining ones with our heavyweight approach.

Best regards,
Evgeny Novikov
> regards,
> dan carpenter
