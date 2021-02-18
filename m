Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F0031F21E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBRWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBRWMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:12:12 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F419CC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:11:31 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 189so2310081pfy.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2BNm2Sy2P6jkCZbThkkqBfZaxS28xMnq4sQPLlpKVSc=;
        b=oPxQ3zEatebLUJOzFuvXtpdBFNS1aXVvmULx3Vq1K7IH02cgp5JVRon+523RsysY4Q
         NL9J7g0zml/wR7e9fBS7psfKr4ArmYBon9T+bDMYbNqhpJYgrSpSkKosODNPPkDQPOGs
         wvHzGkgxOAD0cNO2WG5HTNhMPGRJKfRs66zqmc+9vYJqtewa44HvMOIvSAI5XHj96DFP
         b3W41c7fU72hO0md5JE3DaJf0oXfJT0xL4E5F8AdwUg6wOi1UBryWr7rQv5nWFMHXe3R
         5kqiD+FtAkgFcYepvCsIbm+E0j0rdwGm1ZnPuG6pN46/vdEZ5greAcqJkUL/27EBRFYW
         gBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2BNm2Sy2P6jkCZbThkkqBfZaxS28xMnq4sQPLlpKVSc=;
        b=JC5sU4orIVDuyoArJ1lL5ZXx15lw/42IqNUM7p3r1avtbDoZfsyRoT5ktoDidUD+2X
         5PyFIY8k2Ho3rd5OOYTayQpmHel5iqBtofTfI8n3gcBRcS4+TrXNtkXD6yQtsCWyiLwk
         3PWELQ6UfJLXwjGZc6ufCkm0ER9QV9siU2lhFqmJkupjC0SGzG1Iq5CqqxinPDEpRP+Q
         tZu3beQ2ec3UO0uxY/zERqOxS4SUu3Yf8XmL1ewDgB0Jn4C7jjd4xLytCF9Ld6TFP5IA
         /2gXKmYespFt0uzybE4kl2cYI097FKo8qGdyg+ggjna2r/YasD/6z4w8AX1PPx0tjfJ5
         sNaQ==
X-Gm-Message-State: AOAM530cMhGrpmVuLDKDWXctuO2DTxR7f6LKV/Z18GX5hXHrQT2LXls1
        CtsaT3LuiMum9QwxvEZFyiY3lnKQr+RzCA==
X-Google-Smtp-Source: ABdhPJxunsRgQ2CCJLlBTWsCnLsHP+9AYoritUi0UOKmRkBpaGRwAA8k6z+KtBvdBCqVxt4KqfftJw==
X-Received: by 2002:a62:154a:0:b029:1e6:ca6b:d5c6 with SMTP id 71-20020a62154a0000b02901e6ca6bd5c6mr6133870pfv.47.1613686291089;
        Thu, 18 Feb 2021 14:11:31 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:184:e9f:a921:953a? ([2001:df0:0:200c:184:e9f:a921:953a])
        by smtp.gmail.com with ESMTPSA id w3sm6233935pjt.24.2021.02.18.14.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 14:11:30 -0800 (PST)
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
To:     Arnd Bergmann <arnd@kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com>
 <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com>
 <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com>
 <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com>
 <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
 <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a8595ec5-88db-072c-9cc3-7a3a301fe191@gmail.com>
Date:   Fri, 19 Feb 2021 11:11:20 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/21 12:19 am, Arnd Bergmann wrote:

> drivers/net/ethernet/8390/apne.c
> drivers/net/ethernet/8390/ax88796.c
> drivers/net/ethernet/8390/hydra.c
> drivers/net/ethernet/8390/mac8390.c
> drivers/net/ethernet/8390/ne.c
> drivers/net/ethernet/8390/zorro8390.c
[...]
> Most of these are normal short-lived interrupts that only transfer
> a few bytes or schedule deferred processing of some sort.
> Most of the scsi and network drivers process the data in
> a softirq, so those are generally fine here, but I do see that 8390
> (ne2000) ethernet and the drivers/ide drivers do transfer their
> data in hardirq context.
>
>          Arnd

8390 ethernet drivers are widely used on m68k platforms (Amiga and 
Atari). At least on Amiga, the corresponding interrupt is a hardirq so 
I'd advise caution. That said, the 8390 drivers might benefit from some 
refactoring (the way these drivers are compiled does prevent e.g. the 
APNE driver from being used with two different variants of PCMCIA 
interfaces. I had begun some work on making IO primitives runtime 
selected two years ago but that ended up looking too ugly ...).

Can't recall what IPL the 8390 interrupts operate at - Geert?

Regarding allowing preemption of hardirqs - at least in 2017, that was 
considered perfectly OK (see Linus' comment on 
https://lore.kernel.org/patchwork/patch/794954/). I concur with Finn on 
this one - we did look for potential issues with the way irqs_disabled() 
is defined on m68k (for me, in the context of the above bug that caused 
memory corruption on my system), and found none.

Cheers,

     Michael

