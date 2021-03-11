Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4233769C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhCKPMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhCKPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:12:11 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4082C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:12:11 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f20so22218797ioo.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uzWR98tr30jTjAvujuKHcBKWh4iZ4wgejl+7WugCPs=;
        b=Fcy+PPYqjKJEoxOQ2vElnvB1kN93O7t/tAbO2fozxIuJSzwELE6AeFpO8Fqz2FQE7s
         m4FICO3nlvO00TFPAkSntfmWcCl0QIGQ4gTWf7aOcF1fliF86HnKTAoF8YMVYGkTzpeM
         gi8WZ6pOBLsF5MYtqBJDo/zx/GLLTQz9cUn/dMDEHgnBsOI0O2gp7Ivvh0/svwbLCPGv
         0VVBMwCegLfiFBAjGOMuE2r99gwnqqa8KuvxJcPS0c9+3xoFQY6vyHsiKqIwfV/F34n7
         0/ZYJQfT/af/RTrovanNMwfVJBDYSA0uXkwIMtrX3ehf/LKEnOcj7sm/MNnqAIpRZFZI
         jtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uzWR98tr30jTjAvujuKHcBKWh4iZ4wgejl+7WugCPs=;
        b=RGkFGq1gjFSuJoMNrxKxEmQydVTS7o4LTXTSdvS7R1c0mQmGJIBLJZYRu181STrTlU
         UhFMwFXIWN2K/Dy6CyoYPnOJee16THM1TFG5mcxF2tiyenncIJQcHoQ+RS6sq660H6nK
         53HUNr3iD67d3t/ip00VLwODKJlU2OHw7JSpKGTLGlWWclLnuTL2mqr/glBuEXOlh7Rr
         w1nUoPDszTYTAjzUeiBfZQL3WI/tGgT2qJeK+GZuibsy0ntPeZlpYgotlGlnm94ElZtS
         wP7TONewM95+qKIEMWSc6rQla2IObLiXMf7Ri0iqja9wlKwAZJPXSu+jfG4sDIC8OaAd
         7Iaw==
X-Gm-Message-State: AOAM532ZPS1pgepFBCj1LAKT/YOB1jEvTSMK3mGFGHSNWJAJMshrvGpN
        ihe1QpyzVthuVEp2e+yCjFp3VyMqzevXmw==
X-Google-Smtp-Source: ABdhPJz1TleSAlCcpEHwXGi4dk1lb/CpLc/h59zEp0RM2ifcqF9OCZ03Hcn2cdJEzumDie7ZXCG3zw==
X-Received: by 2002:a02:cb48:: with SMTP id k8mr4118806jap.52.1615475531036;
        Thu, 11 Mar 2021 07:12:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m15sm1369443ilh.6.2021.03.11.07.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 07:12:10 -0800 (PST)
Subject: Re: [PATCH] ide: fix warning comparing pointer to 0
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        davem@davemloft.net
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1615456086-127803-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <034a3feb-27b3-a349-6dcf-75cb36a34e23@kernel.dk>
Date:   Thu, 11 Mar 2021 08:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1615456086-127803-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 2:48 AM, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/ide/pmac.c:1680:38-39: WARNING comparing pointer to 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/ide/pmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index ea0b064..d5171e0 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -1677,7 +1677,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
>  	/* We won't need pci_dev if we switch to generic consistent
>  	 * DMA routines ...
>  	 */
> -	if (dev == NULL || pmif->dma_regs == 0)
> +	if (!dev || pmif->dma_regs)
>  		return -ENODEV;

This looks utterly broken - the warning is most definitely about
dma_regs, not dev, and you swapped the condition (failing on dma_regs
being set, not NULL).

I'd just leave this one alone, drivers/ide/ should be going away soon.

-- 
Jens Axboe

