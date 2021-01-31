Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B19309CED
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhAaO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhAaOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:08:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340D8C061573;
        Sun, 31 Jan 2021 06:07:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e15so10937715wme.0;
        Sun, 31 Jan 2021 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vpo/YLEC9aCyTz6KjobMCzq+82sKuMKIXEWEt+YC14E=;
        b=OlJOa4jS477uJ7EGNMHHHo06AzD3gWf9Ggn7Yl+4kMCxOZ7sarG+gnPbqG65bMLpAy
         zrIecsk0tUiZrEkUOX33tjVsDNJFOE2RPNNe0lYaScEgAfTYu/X3H1eva4HZEVd2373c
         3crbm9ObgLuScp0cS2kd3jwhW5fWuqLtXITjCGrcTPHIIniDwiQcf8dRcsBtQbufrZsH
         EDjobqXEZ7SR44KDq4C0UdS7IPqWzqQm9e1zyy2Hh+nEmthY139EssNDTr3eP1+J4lMu
         kD+bg/qn7U2xEUARVLR61rT/P4S7tGL1hrRGDW1g27y96lfPfkzLWBszO7tt8pXN9GNr
         TN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vpo/YLEC9aCyTz6KjobMCzq+82sKuMKIXEWEt+YC14E=;
        b=rY/7eDCvTBGON2aJUc6N9mcXIy5fJko3e/norODgGURc450qdTuCTuyrAMtip5Y3sQ
         zdkliyhv07XIPxIeO9zGGSv48sq3MAgdCdzOoYklea16x551b9TyXvAU1Ts6HiAmkR+t
         Aln4B5Cxj23FDIFBUmnBBpn6dN383OXw+9tpR+VEHBRjzdYihLMAe1iW0U+ab41kFOqh
         7whX8G7JVyU8GDDwinFLK3p4IKvdV9MxICvrr1kgMhyUeR2xk1Lv50d8hrW7z8IVH95E
         i8vkIredH40vDkiR3rqhX/SC06dEgQoqgda4tYd56vmfvyL+4UStusxO8EMMq2fZ/4xs
         HGTQ==
X-Gm-Message-State: AOAM532JdW9IwI14IOsxpSPAaEI8Qus2lgwdNuOdZQgwkdfGMZA0wTdw
        ZhOB5hEk1UVBcZPadLOYlBpgMOiUn4MFjqrK
X-Google-Smtp-Source: ABdhPJyUzLGZ44ueTOjnLv5xrehDKINnxZ+xuSyonqd1VMxtcLkaGvmwKgpdsE5Q8iAy+4LLAe9/jw==
X-Received: by 2002:a05:600c:4f50:: with SMTP id m16mr11148122wmq.175.1612102048930;
        Sun, 31 Jan 2021 06:07:28 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id r16sm23529682wrx.36.2021.01.31.06.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:07:28 -0800 (PST)
Subject: Re: [PATCH v1 2/2] arm64: configs: Support DEVAPC on MediaTek
 platforms
To:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Hanks Chen <Hanks.Chen@mediatek.com>,
        Jackson-kt Chang <Jackson-kt.Chang@mediatek.com>,
        wsd_upstream@mediatek.com
References: <1608713092-26952-1-git-send-email-neal.liu@mediatek.com>
 <1608713092-26952-3-git-send-email-neal.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <68442164-d649-aee0-cfe8-c9ebb868612d@gmail.com>
Date:   Sun, 31 Jan 2021 15:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608713092-26952-3-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/12/2020 09:44, Neal Liu wrote:
> Support DEVAPC on MediaTek platforms by enabling CONFIG_MTK_DEVAPC.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  arch/arm64/configs/defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 17a2df6..a373776 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -257,6 +257,7 @@ CONFIG_MTD_NAND_MARVELL=y
>  CONFIG_MTD_NAND_FSL_IFC=y
>  CONFIG_MTD_NAND_QCOM=y
>  CONFIG_MTD_SPI_NOR=y
> +CONFIG_MTK_DEVAPC=m
>  CONFIG_SPI_CADENCE_QUADSPI=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_NBD=m
> 

From my understanding, defconfig is for a minimal config that allows to boot a
machine. As MTK_DEVAPC is a rather exotic driver to detect bus access
violations, I think it's not a good candidate for inclusion in defconfig.

In any case, I added the SoC maintainer, so that they can correct me, if I'm
wrong :)

Regards,
Matthias
