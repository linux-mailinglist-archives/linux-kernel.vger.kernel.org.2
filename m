Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45933CD11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhCPFVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhCPFUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:20:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38DBC06174A;
        Mon, 15 Mar 2021 22:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ghCVJsTrlHMG4p9O3S38i1mhCzDfxp7I2wI1zLBETBE=; b=3e9I+Fi2bKf/TEbU/PyNUfbYMl
        Mjs7kqrgsJf77Tnfns1S00E02TdxV0FzcVpyXkVnF4sbImuTZ3bPnu4HkpS6/fLHst3MxrEZ9GxHv
        uxI/F61REt2rFV4thEXq4hmkbInSHSpNW2cLgBX4ZbsWBao2/thP+rVwXitEvxPw6YQYPF4BSrnDz
        K61CQFP3QU3zXy1teXUQwNYZ65QMm/RGlMtSI2XjdVdBI0S5PujkwI6EcbvzZuPc6qUp6ZDPZ4afm
        ulZtou2eOC+g1P7qBnvnGnKLMz1NO+qw8DlKkz2faFWtNxg6d46HWfnK0JEz0VzXMaLbqWu9/EejB
        mAUMG0IQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM28Q-001PSD-W0; Tue, 16 Mar 2021 05:20:51 +0000
Subject: Re: [PATCH] usb: host: Mundane spello fix in the file sl811_cs.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210316045243.3500228-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4913517e-5d69-0a78-4bb0-981362ffab1e@infradead.org>
Date:   Mon, 15 Mar 2021 22:20:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316045243.3500228-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 9:52 PM, Bhaskar Chowdhury wrote:
> 
> s/seting/setting/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/usb/host/sl811_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
> index 72136373ffab..16d157013018 100644
> --- a/drivers/usb/host/sl811_cs.c
> +++ b/drivers/usb/host/sl811_cs.c
> @@ -94,7 +94,7 @@ static int sl811_hc_init(struct device *parent, resource_size_t base_addr,
>  		return -EBUSY;
>  	platform_dev.dev.parent = parent;
> 
> -	/* finish seting up the platform device */
> +	/* finish setting up the platform device */
>  	resources[0].start = irq;
> 
>  	resources[1].start = base_addr;
> --


-- 
~Randy

