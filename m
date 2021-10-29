Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F812440156
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhJ2RiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:38:22 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33042
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbhJ2RiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:38:21 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 70EC43F179
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635528948;
        bh=jvV6mA1s9hOJyCsNlRY4ar4PhiLrM2nEHfaCHa+wtwI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=TRysrsLPHcqxR7esUa3LCDjvbaubjeiqZ6WhCEwJ6BQ0wKTOSPvgk5KTWdWLkTIXB
         7uMoJCNebomP1t9ULSm65wxOAl3Iv0QSNXCZ1bWzpUrDozA5sHBsgEHmbWnPdIIGHx
         T7xxE/+Prs6cNpEyp0d7fyaXNYJl3Cs0UkGwaqhgFSQeP9FtTqz18Puk/6kGMvIJh+
         mvWqfm+wDECuVmtbTPFN4FiXhCYkRLcvL+wfo1F70V0c6QX76082i7VMtqPW7Hf68y
         8/PuD0wHANpL4+2eqErNbYKdxUqrc8z5D0pBtnVd7hWwtQhv09rPXEZFhR8wNHowNB
         A+nvVjjcDXd9w==
Received: by mail-lf1-f71.google.com with SMTP id h21-20020a0565123c9500b003ffa23a0577so4346831lfv.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvV6mA1s9hOJyCsNlRY4ar4PhiLrM2nEHfaCHa+wtwI=;
        b=nMqQomvcSOQr0t+MQKrJ4GypPX6/TFOHOqg98ZoEAUlQ51Y+7y3DeW/t5xVtjOV1Yk
         +EzjRRLYEsKQt86lqkQRU2BheX4frPpN9nZxpY5rpiKqH1ILT1Yy9KoyMxifMDmWZZ8q
         T/za/r1b4GIcrjgZUYS8EScLIWcjOV/UtfGFmTwOs9k8tTU/ZqBn4FrEnv/dSLhffGn6
         jgilvLF1rymgkdp4938HGhhbIiFf+sCib/pi3v3fe+etVKeXwEHmlTZyzTXT52Q7NQGF
         8SVi1f0+I5rmPQ/OkTnH03B7roGSYmHecR7HLfHssLGe/tiJu/f1CzpBUgm2+orHXChv
         ryYg==
X-Gm-Message-State: AOAM530uP7xNLHfqd0lro7jyVnyzhs5Dx6F+CsY5XO5G1nsrlNVyWQ66
        TLTvCcOWrjBzcqmlyH5yFCPxlEpOLrngv1YxmTJuutwNlbn88S+Umzh4Z1jhUwSkkkJppEiIHFo
        1awZ6wZKJM513EKh5foEgWbiI6qJiR9p+BvrDKCT6nA==
X-Received: by 2002:a2e:7617:: with SMTP id r23mr12947350ljc.187.1635528947766;
        Fri, 29 Oct 2021 10:35:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBv6+kvbnDwAjjNuXfYL+0ezjFAhs3r2BkTi8MNivnnR7id+AwsxbYbbuG2Mbqzl68kUEMrA==
X-Received: by 2002:a2e:7617:: with SMTP id r23mr12947326ljc.187.1635528947569;
        Fri, 29 Oct 2021 10:35:47 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s4sm182963lfi.180.2021.10.29.10.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 10:35:47 -0700 (PDT)
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com, Ikjoon Jang <ikjn@chromium.org>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
Date:   Fri, 29 Oct 2021 19:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028055056.26378-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2021 07:50, Yong Wu wrote:
> We add the ostd setting for mt8195. It introduces a abort for the
> previous SoC which doesn't have ostd setting. This is the log:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000080
> ...
> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> lr : mtk_smi_larb_resume+0x54/0x98
> ...
> Call trace:
>  mtk_smi_larb_config_port_gen2_general+0x64/0x130
>  pm_generic_runtime_resume+0x2c/0x48
>  __genpd_runtime_resume+0x30/0xa8
>  genpd_runtime_resume+0x94/0x2c8
>  __rpm_callback+0x44/0x150
>  rpm_callback+0x6c/0x78
>  rpm_resume+0x310/0x558
>  __pm_runtime_resume+0x3c/0x88
> 
> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it is
> also a valid value, thus, use the larb->larb_gen->ostd as the condition
> inside the "for" loop.

You need to write more clearly, what you are fixing here.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Krzysztof,
> Could you help review and conside this as a fix for the mt8195 patchset?
> The mt8195 patchset are not in mainline, thus, I don't know its sha-id,
> and don't add Fixes tag.
> Thanks
> ---
>  drivers/memory/mtk-smi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..0262a59a2d6e 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -257,7 +257,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>  	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
>  		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
>  
> -	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> +	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd && !!larbostd[i]; i++)
>  		writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));

The code does not look good. You have already a dereference at line 244:

	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];

You are not fixing the NULL pointer dereference.

>  
>  	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> 


Best regards,
Krzysztof
