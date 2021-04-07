Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24345356814
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbhDGJbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhDGJbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:31:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF60C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:30:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u17so20267521ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M+6GqVIlsluT7FdXsJJtXy1o3ui55E+ovW1gQ+7xpPg=;
        b=nNHDkWuLX/g4T/aj4MaRROG2kPyKXlNHUwQt84bH3xItx7AxDuTmIv4w+f2xmUKMBX
         zFtve5MOj9P8EvjMKt9gJsEhsnSzOPlfP6RX2dKfbsw1Fui+4J10fjo6Kz2stsucJ8tb
         FsFIA0pI66uvtx0ZTTnv060kr+nGzWYCc+H8A1VRLvAsR0GSfb5mujFyEHrAFnbaWyw9
         GSeMaFsQsZHE1ELJJ7cGuJSJk756gN9WQFxAonq9DJ80ZoIncCk9dm94aPv0ExpCC5Ob
         cJqx9Ah/iPXzeS4/bPfdoScxHBZbYrdncz9gx2ruUo3/ra0PW+f3cLd/PhRMX1sJfmKS
         xQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+6GqVIlsluT7FdXsJJtXy1o3ui55E+ovW1gQ+7xpPg=;
        b=MhDhibCt/OPFFJLJDa2N4pcQZ/+IeTrNv/6nzbj9mNlldNCaly0StTo8f/Mrma/5EN
         1Xa/XLn2xvEGa4LgI1RDDv5HhByBrb/hHeRPdr6iiuckxP++VlIa1BhwcmjwiYwsfMw2
         WyAPL/abpy6t4vu1NZe5j7mpKmon8Ow1ueTEO3BtbAndqvZmBHlhqMPcSjnKRE3SpBud
         IL6eOZXT4229ObikWoUGXP7DpDCiT0MU6+JBFa9ke6v0QRSmDqAfMXEp4r4q44oudsLx
         afly+EmtRhR3jMzLNJ2W6Vzxaltrh9HVlZ190/o5mZI3bLs1LdVxv/wfbkxijEApWcqU
         8GSA==
X-Gm-Message-State: AOAM533lUG9gNCZhCo2piTK+JKtAP6c31s1EISfzCZaiYpBGLPCQ+RxZ
        oA9u8gncZVupwymFx+pAbfk=
X-Google-Smtp-Source: ABdhPJx2HalNQq9m4Ca4QrilDp2cOmq8egJ4MaGEcMb1zYgwOdLqv0iYKd2NZlJFi1qEILwH+YdEDg==
X-Received: by 2002:a17:906:4a5a:: with SMTP id a26mr2736461ejv.8.1617787850692;
        Wed, 07 Apr 2021 02:30:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id lm24sm12287231ejb.53.2021.04.07.02.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:30:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Remove camelcase
Date:   Wed, 07 Apr 2021 11:30:48 +0200
Message-ID: <2654358.BPhQiNMsfF@localhost.localdomain>
In-Reply-To: <20210407091752.27350-1-fmdefrancesco@gmail.com>
References: <20210407091752.27350-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 7, 2021 11:17:52 AM CEST Fabio M. De Francesco wrote:
> Remove camelcase. Issue detected by checkpatch.pl. The symbols aren't
> used in other files, so this change doesn't break the driver's code.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This is a necessary v2 patch because v1 cannot anymore apply to the current staging/testing tree
> 
>  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
> index b9aca99478db..616d20106392 100644
> --- a/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
> +++ b/drivers/staging/rtl8723bs/hal/Hal8723BReg.h
> @@ -112,7 +112,7 @@
>  #define REG_RSVD3_8723B					0x0168
>  #define REG_C2HEVT_MSG_NORMAL_8723B	0x01A0
>  #define REG_C2HEVT_CMD_SEQ_88XX		0x01A1
> -#define REG_C2hEVT_CMD_CONTENT_88XX	0x01A2
> +#define REG_C2HEVT_CMD_CONTENT_88XX	0x01A2
>  #define REG_C2HEVT_CMD_LEN_88XX		0x01AE
>  #define REG_C2HEVT_CLEAR_8723B			0x01AF
>  #define REG_MCUTST_1_8723B				0x01C0
> @@ -429,13 +429,13 @@
>  #define	IMR_RXFOVW_8723B		BIT8	/*  Receive FIFO Overflow */
>  
>  /* 2 ACMHWCTRL 0x05C0 */
> -#define	AcmHw_HwEn_8723B		BIT(0)
> -#define	AcmHw_VoqEn_8723B		BIT(1)
> -#define	AcmHw_ViqEn_8723B		BIT(2)
> -#define	AcmHw_BeqEn_8723B		BIT(3)
> -#define	AcmHw_VoqStatus_8723B		BIT(5)
> -#define	AcmHw_ViqStatus_8723B		BIT(6)
> -#define	AcmHw_BeqStatus_8723B		BIT(7)
> +#define	ACMHW_HWEN_8723B		BIT(0)
> +#define	ACMHW_VOQEN_8723B		BIT(1)
> +#define	ACMHW_VIQEN_8723B		BIT(2)
> +#define	ACMHW_BEQEN_8723B		BIT(3)
> +#define	ACMHW_VOQSTATUS_8723B		BIT(5)
> +#define	ACMHW_VIQSTATUS_8723B		BIT(6)
> +#define	ACMHW_BEQSTATUS_8723B		BIT(7)
>  
>  /*        8195 (RCR) Receive Configuration Register	(Offset 0x608, 32 bits) */
>  #define	RCR_TCPOFLD_EN			BIT25	/*  Enable TCP checksum offload */
> 
I'm sorry I put the wrong patch version number in the subject and in the body.
Please diregard this patch. I'm about to send v4.

Thanks,

Fabio




