Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89836A1DA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhDXPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhDXPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 11:54:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D12C061574;
        Sat, 24 Apr 2021 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=d2RmiEfndsgboRmxT8nIWdmur/ZNr8KeEQ/UVKy2IYM=; b=AGwh8Q85mGlgvm259/fkQgjJXK
        CEjQ02A3ZYPB9etyplVwIwKEBt8L9brTwwIv1TDKB4GWY1ui5oYeeOZGTGRGA+kFDJPrJPJRQp/JE
        VCxhOsVT45Z5bt4oqlPY0zOtQO5vxt8usRyZ0i1vK5cf8gPR1J5LHoQokSCRxZR7nMPhFqJubulbh
        iCyODxjGmZRCvYeKiIa0DZdLCJ18KfYfPbOtIaDV8IxMsxA7eD406HhKZ+sPhVhnKhtpYsh/7C1Z2
        tdmBFKTxljQmC6bICieoPVfVLeHvtl0coDxeZ7/6xnDp1/B6+s/snjGDgv6tnGLnbp6rFuTXGzl7L
        lnA4VZ2w==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1laKaw-0044lr-S1; Sat, 24 Apr 2021 15:53:23 +0000
Subject: Re: [PATCH] usb: cdns3: Corrected comment to align with kernel-doc
 comment
To:     Souptick Joarder <jrdr.linux@gmail.com>, peter.chen@kernel.org,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619263801-5319-1-git-send-email-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6aeb87ba-4a45-909a-65e4-370cc193f8db@infradead.org>
Date:   Sat, 24 Apr 2021 08:53:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1619263801-5319-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/21 4:30 AM, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> 
> drivers/usb/cdns3/cdns3-gadget.c:487: warning: This comment starts with
> '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> This patch will silence the warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 9b1bd41..0280a38 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -483,7 +483,7 @@ static void __cdns3_descmiss_copy_data(struct usb_request *request,
>  	}
>  }
>  
> -/**
> +/*
>   * cdns3_wa2_descmiss_copy_data copy data from internal requests to

Please just insert a hyphen/dash between the function name and its description.

>   * request queued by class driver.
>   * @priv_ep: extended endpoint object
> 

thanks.
-- 
~Randy

