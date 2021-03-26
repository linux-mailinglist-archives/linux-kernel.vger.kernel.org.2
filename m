Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4862349F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCZCSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:18:07 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43782 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhCZCRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:17:46 -0400
Received: by mail-ot1-f43.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so3900432otn.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pN6nWQzQZ6AQx0kJQTtGWLMXZDRLpSHjIhqC/t+YFhY=;
        b=e291Q4y7IVdaWADI4uiq+C6gctV/yNiZSbxaG2MbSeAa1L4umtmuJ5qq50b68xdL/5
         qlS0HRjUBtP3uEzHPKUd0Qny1NKCyWVz+/WjZ8udZ95eNC6NI6bRpjM/I8TgXceB+Dco
         IgvTsMTzhH5S4slKgUINXAg+eGO7aVftav04keJKUb78S7UTc5f+n9b5OT8NiAL2J4Km
         AV90rEz7JAMB3kn883vc3ExlbppgIcVv9BnRSSFsrSlACMsOZz9wsKQjrbfKGOapsRC5
         0i0K2tIQj5DzFARYvV8IzW9/xrLAkCSnNw3VLQoGHhK8QEgVFlcIB8YE5LVzKBME/9wG
         xxDw==
X-Gm-Message-State: AOAM530vq3GZ1BikTN4FpAxVBrEP3hJasLfotsN8z03cIt/JHiLbY+eg
        Ah8oZDnvZqoBTH+m20t16IQC76lMjk0=
X-Google-Smtp-Source: ABdhPJzxxtd8AY/HlDoi1lELNCM5Z5bF0pZVTtJxN8+AG2D86WzyPJlLuEfi30WvIY/HyT5grkXuKQ==
X-Received: by 2002:a05:6830:11a:: with SMTP id i26mr10046940otp.91.1616725065662;
        Thu, 25 Mar 2021 19:17:45 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id g2sm1757002otn.32.2021.03.25.19.17.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 19:17:44 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so3917421ota.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:17:44 -0700 (PDT)
X-Received: by 2002:a05:6830:20da:: with SMTP id z26mr10108692otq.74.1616725064425;
 Thu, 25 Mar 2021 19:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210323131530.2619900-1-arnd@kernel.org>
In-Reply-To: <20210323131530.2619900-1-arnd@kernel.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 25 Mar 2021 21:17:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNQJfJ=KmRGkX5Uo6VfWDsihrMUKV7OkQ7jtb3+Byb0RLQ@mail.gmail.com>
Message-ID: <CADRPPNQJfJ=KmRGkX5Uo6VfWDsihrMUKV7OkQ7jtb3+Byb0RLQ@mail.gmail.com>
Subject: Re: [PATCH] soc/fsl: qbman: fix conflicting alignment attributes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Roy Pledge <roy.pledge@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Scott Wood <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>, soc@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 8:17 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When building with W=1, gcc points out that the __packed attribute
> on struct qm_eqcr_entry conflicts with the 8-byte alignment
> attribute on struct qm_fd inside it:
>
> drivers/soc/fsl/qbman/qman.c:189:1: error: alignment 1 of 'struct qm_eqcr_entry' is less than 8 [-Werror=packed-not-aligned]
>
> I assume that the alignment attribute is the correct one, and
> that qm_eqcr_entry cannot actually be unaligned in memory,
> so add the same alignment on the outer struct.
>
> Fixes: c535e923bb97 ("soc/fsl: Introduce DPAA 1.x QMan device driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/fsl/qbman/qman.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index a1b9be1d105a..fde4edd83c14 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -186,7 +186,7 @@ struct qm_eqcr_entry {
>         __be32 tag;
>         struct qm_fd fd;
>         u8 __reserved3[32];
> -} __packed;
> +} __packed __aligned(8);

The EQCR structure is actually aligned on 64-byte from the manual.
But probably 8 is enough to let the compiler not complain.

>  #define QM_EQCR_VERB_VBIT              0x80
>  #define QM_EQCR_VERB_CMD_MASK          0x61    /* but only one value; */
>  #define QM_EQCR_VERB_CMD_ENQUEUE       0x01
> --
> 2.29.2
>
