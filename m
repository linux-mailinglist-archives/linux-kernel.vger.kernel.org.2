Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4F437906
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhJVO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhJVO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:28:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E95C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 07:26:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c29so3794608pfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JhwFuccVZQeiwvNuHNQ1RS7yIFWPLwTUxexiIKglluM=;
        b=Z4u24KMLF/8Ym9rkji3BWniCuaq4Qc7CR11xwyizB+rQcVNYj05t0WbBDBmi0wZkB/
         M2FzT5a0jpdsgEIW+TwVATCsXGR8mzfRywoqD0fF02bgM+DAgOTjhdObYu6ujxfBk/yN
         7W4sj6mS59Ilm1u+Jm/+0vyNko45GJoV0NiwBxZm3BcZZSbHMKwDFMgO+i9XcHeuDSmh
         gyTsiIql7khMX8Cq/kc6i3Lh/TDPdSOzKsqfcu3JvsnM4coJvp22QNdmkdscpWuRrqQd
         HKbrphcur2Qum/YZRI5yFrztx40OrO+Ngq+xUtIvYJrttdnBisWd7StdVNFJuOBk+68b
         s1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JhwFuccVZQeiwvNuHNQ1RS7yIFWPLwTUxexiIKglluM=;
        b=jN7cI++6PnmzdSTVLieULl61Mo1zWxV28hqTaOo0/zDeNQFKRps56YdHV2XgvRZ8tz
         1R5eIVoC6cwsHkv5U3nAZ44XgS8z32iZXFmsWxooULPLtHZVaa51tiPZnruhHsbP9xe9
         GCto7brmMzw2ayPyo/aViogRRBlVtAfO40E6gjO6phfGGq7DJczc16g/mJtRpUjW/eb5
         Uejs07Qdc89x+hiELUzCjLq2YOg2pNhpwRcrPhefVc1inTdL1PVvYcNPFII3374G3O4L
         LRTqJhf4O1dJlCo585iAGFzX4mvYNGtPAc5fkazUtOq8j3VJMF/q6SrPl3QJW8YUevim
         e3Kw==
X-Gm-Message-State: AOAM531cMXX1/W4AO6uYFHTf36N7he9IH4xwwVIq/I/hcyUarXBqLPRC
        8FRCVuLe9ZSA9Is/HrbCUAM=
X-Google-Smtp-Source: ABdhPJyVzouQUApdOVABmW7iJ2tSCJcNx2TQaGYfivjl8SeHFtmuXCqilAWvZnpPOds1wNpJzGvYqQ==
X-Received: by 2002:a63:8f4a:: with SMTP id r10mr22860pgn.337.1634912795519;
        Fri, 22 Oct 2021 07:26:35 -0700 (PDT)
Received: from [192.168.1.122] ([122.181.48.19])
        by smtp.gmail.com with ESMTPSA id g5sm1238858pfc.65.2021.10.22.07.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 07:26:35 -0700 (PDT)
Message-ID: <049d4b3e-ed32-9b48-0c2e-19f9af95ca37@gmail.com>
Date:   Fri, 22 Oct 2021 19:56:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [Outreachy kernel] [PATCH 5/5] staging: vt6655: Rename `byRFType`
 variable
Content-Language: en-US
To:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
 <f0b6818d2b15982081bebaf14f830f4646f61fe2.1634826774.git.karolinadrobnik@gmail.com>
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
In-Reply-To: <f0b6818d2b15982081bebaf14f830f4646f61fe2.1634826774.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-2021 15:07, Karolina Drobnik wrote:
> Drop Hungarian notation in `byRFType` variable in
> `RFvWriteWakeProgSyn` function. Change it to use snake case.
> 
> Fix issue detected by checkpatch.pl:
>   CHECK: Avoid CamelCase: <byRFType>
> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/rf.c | 4 ++--
>  drivers/staging/vt6655/rf.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index 0dd91b0433f6..3f57834901a6 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -676,7 +676,7 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
>   * Return Value: None.
>   *
>   */
> -bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
> +bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
>  			 u16 channel)
>  {
>  	void __iomem *iobase = priv->port_offset;
> @@ -685,7 +685,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
>  	unsigned char sleep_count = 0;
>  
>  	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
> -	switch (byRFType) {
> +	switch (rf_type) {
>  	case RF_AIROHA:
>  	case RF_AL2230S:
>  
> diff --git a/drivers/staging/vt6655/rf.h b/drivers/staging/vt6655/rf.h
> index d3f2b8dd6afc..0939937d47a8 100644
> --- a/drivers/staging/vt6655/rf.h
> +++ b/drivers/staging/vt6655/rf.h
> @@ -60,7 +60,7 @@
>  bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData);
>  bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType, u16 byChannel);

IMO, probably we can sync RFbSelectChannel as well with similar notation in another patch.

>  bool RFbInit(struct vnt_private *priv);
> -bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType, u16 channel);
> +bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type, u16 channel);
>  bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH);
>  bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
>  		    unsigned int rate);
> 

Regards,

~Praveen.
