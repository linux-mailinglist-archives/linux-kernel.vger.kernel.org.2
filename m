Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14C533D1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhCPKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:31:16 -0400
Received: from smtp124.ord1c.emailsrvr.com ([108.166.43.124]:34367 "EHLO
        smtp124.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236599AbhCPKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1615890645;
        bh=HKRipzT9Y4Y7AD4RUtA9VrCLd8S8c4Q7++26hm0spEw=;
        h=Subject:To:From:Date:From;
        b=WgWzVeUpqrSjo13ZutIqGnZXQ5rmm3R7o09WbmaFKzalD5jkK++RmXpD5m1kG9lPR
         cN9NuZfJ/20i+iXTaj7BmgSt13a4I4s3+NPdesKXMOu8jBwmAcYbfMY4/V7NqdBgDS
         8kSR3WUztKlBiEf+WNe1t+Z8jy/TLxwsbRa6s8zg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EA9DBC0172;
        Tue, 16 Mar 2021 06:30:44 -0400 (EDT)
Subject: Re: [PATCH v2] staging: comedi: cb_pcidas: fix request_irq() warn
To:     Tong Zhang <ztong0001@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <393f3925-9dbf-72e5-4d9b-2e213a6a71cb@mev.co.uk>
 <20210315195914.4801-1-ztong0001@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <e33c1059-cb89-5798-1030-bb1c13994198@mev.co.uk>
Date:   Tue, 16 Mar 2021 10:30:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315195914.4801-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 1c471611-caf7-4948-a24b-76b433eb8e78-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2021 19:59, Tong Zhang wrote:
> request_irq() wont accept a name which contains slash so we need to
> repalce it with something else -- otherwise it will trigger a warning
> and the entry in /proc/irq/ will not be created
> since the .name might be used by userspace and we don't want to break
> userspace, so we are changing the parameters passed to request_irq()
> 
> [    1.630764] name 'pci-das1602/16'
> [    1.630950] WARNING: CPU: 0 PID: 181 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
> [    1.634009] RIP: 0010:__xlate_proc_name+0x93/0xb0
> [    1.639441] Call Trace:
> [    1.639976]  proc_mkdir+0x18/0x20
> [    1.641946]  request_threaded_irq+0xfe/0x160
> [    1.642186]  cb_pcidas_auto_attach+0xf4/0x610 [cb_pcidas]
> 
> Suggested-by: Ian Abbott <abbotti@mev.co.uk>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
> v2: revert changes to .name field so that we dont break userspace
> 
>   drivers/staging/comedi/drivers/cb_pcidas.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/cb_pcidas.c b/drivers/staging/comedi/drivers/cb_pcidas.c
> index d740c4782775..2f20bd56ec6c 100644
> --- a/drivers/staging/comedi/drivers/cb_pcidas.c
> +++ b/drivers/staging/comedi/drivers/cb_pcidas.c
> @@ -1281,7 +1281,7 @@ static int cb_pcidas_auto_attach(struct comedi_device *dev,
>   	     devpriv->amcc + AMCC_OP_REG_INTCSR);
>   
>   	ret = request_irq(pcidev->irq, cb_pcidas_interrupt, IRQF_SHARED,
> -			  dev->board_name, dev);
> +			  "cb_pcidas", dev);
>   	if (ret) {
>   		dev_dbg(dev->class_dev, "unable to allocate irq %d\n",
>   			pcidev->irq);
> 

Looks good.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
