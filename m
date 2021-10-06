Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08742452C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbhJFRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbhJFRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:51:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C797BC061764
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:49:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n2so2131129plk.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20210112.gappssmtp.com; s=20210112;
        h=date:to:cc:subject:from:references:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XOrLreEsAuVDxgUxU0x2eSWaOLostnJXpsKIuIcC4bY=;
        b=O64bnKH6KoKyvWVSyqsE/LKur6GdHTj0Y+7e5nyW8QRvasi2/E6oSdzxy+t0qnj4Xp
         COFS13bw8Nc/5nXiOjUWGNciFr7Q24v659AECXVa89pDdoG9I8sczFxW9ExlVQFTBEkh
         8BTS2GwYBT99RYUJSupN7so85Jx0cN11OqU1+Onri0yO/GrB8HFzSzDOa2szyKasKyl4
         HPKDu2XGcsUOMdBC9zGj1AhuHThAOyduETNOD93ZscYsX9MuzfhQ9VQNVxRCgEH/5IwE
         DIvJV2AXKyRhrRj3W6kw/1LE2dzsvDONt+mkKGh9NLuHB/cQeRodbeEv9LkTFzT1NRMq
         c/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:to:cc:subject:from:references:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XOrLreEsAuVDxgUxU0x2eSWaOLostnJXpsKIuIcC4bY=;
        b=k7g760b6qft5jj68SEtT4ZcwD8g2iGjX95X1zeHtcsJqRQDPnf+0kwhrikDfJDedAO
         u60pDEc4bxqmYijtu2iazhE+UkIuEFr6WEpuHjl8j0iCJ/rZZ3gJS2dQEnnib3tCmYmz
         k6f3ilmIGN6Ic4l0s4lngeDK42O/oJ3jMCuIeJIB9T3CxKHdQ2X0sTRRA/q99qhqrqTI
         pNsUJJyfUnEhOhr56bI1jCXCBDvz4+YGAYp+MWcPXmZ3Osh/D6uazjiKSLyjEvg3b1tk
         4jLPKtGMwB+8T4WqT/kQm418JQEbnXQA5L3GlGiDraa1W2/1sT79bOt9xKl/cYMKwKux
         ZJAA==
X-Gm-Message-State: AOAM532rRInjyII1u2/lW24B1DGsmxmeWD+VNMzvhP6DHcqkoPtl5Wcm
        Oyd7jkJFvBs6N2vjHYn02oIkPqmLMzteLdlS6tpz+Q==
X-Google-Smtp-Source: ABdhPJz5bzd0Ll3u46SkBJss+W4S4Nr59Wl1BFpeQCxvVpqg12wwq7XaF2OPnMoJnGmqYHr4xnQO4Q==
X-Received: by 2002:a17:90a:ac0d:: with SMTP id o13mr86949pjq.74.1633542558298;
        Wed, 06 Oct 2021 10:49:18 -0700 (PDT)
Received: from localhost ([98.45.152.168])
        by smtp.gmail.com with ESMTPSA id z10sm20718583pfn.70.2021.10.06.10.49.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Oct 2021 10:49:18 -0700 (PDT)
Date:   Wed, 06 Oct 2021 10:49:17 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit layout for
 snd_pcm_mmap_status/control
From:   Michael Forney <mforney@mforney.org>
References: <20191211212025.1981822-1-arnd@arndb.de>
 <20191211212025.1981822-9-arnd@arndb.de>
In-Reply-To: <20191211212025.1981822-9-arnd@arndb.de>
Message-Id: <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org>
User-Agent: mblaze/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:
> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER =3D=3D __BIG_ENDIAN : defined(_=
_BIG_ENDIAN)
> +typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_=
t)];
> +typedef char __pad_after_uframe[0];
> +#endif
> +
> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER =3D=3D __LITTLE_ENDIAN : define=
d(__LITTLE_ENDIAN)
> +typedef char __pad_before_uframe[0];
> +typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t=
)];
> +#endif
> +
> +struct __snd_pcm_mmap_status64 {
> +	__s32 state;			/* RO: state - SNDRV_PCM_STATE_XXXX */
> +	__u32 pad1;			/* Needed for 64 bit alignment */
> +	__pad_before_uframe __pad1;
> +	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
> +	__pad_after_uframe __pad2;
> +	struct __snd_timespec64 tstamp;	/* Timestamp */
> +	__s32 suspended_state;		/* RO: suspended stream state */
> +	__u32 pad3;			/* Needed for 64 bit alignment */
> +	struct __snd_timespec64 audio_tstamp; /* sample counter or wall clock *=
/
> +};
> +
> +struct __snd_pcm_mmap_control64 {
> +	__pad_before_uframe __pad1;
> +	snd_pcm_uframes_t appl_ptr;	 /* RW: appl ptr (0...boundary-1) */
> +	__pad_before_uframe __pad2;

I was looking through this header and happened to notice that this
padding is wrong. I believe it should be __pad_after_uframe here.

I'm not sure of the implications of this typo, but I suspect it
breaks something on 32-bit systems with 64-bit time (regardless of
the endianness, since it changes the offset of avail_min).

> +
> +	__pad_before_uframe __pad3;
> +	snd_pcm_uframes_t  avail_min;	 /* RW: min available frames for wakeup *=
/
> +	__pad_after_uframe __pad4;
> +};
