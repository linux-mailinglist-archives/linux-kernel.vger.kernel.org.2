Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7B30E26B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhBCSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhBCSXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:23:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74E2C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:22:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d3so514990lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHlcDRyvhM2zqRm1jI9KcvPDEhFiC7NxP8UtufY4OdQ=;
        b=cp0i8wlOP684R3nD42KVLWe3kexEopR7T1+w4UxH+3IIhkP09n3s6eozE2WjsFfXGP
         omABT1Ufx/64ClZx8w4FJ9iRW0lWcLwmpHeGORJlH+/DdHbB/jazrc2jeys5LMKz7uM9
         mDMxxLO8dEnHf/mToYXEdOGWSFTFROEq9pMhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHlcDRyvhM2zqRm1jI9KcvPDEhFiC7NxP8UtufY4OdQ=;
        b=qgkU0w1lkpge6dtBRG1vApF0owD3zfJ816reb9mLqbXFmYh+Aa6WvKEeA0iN6nGXMm
         pHQSNhE78nhmce0151KpiEdSB4NpmCaf6Wf/5XBl/6QZtejHLFk1sA/+hzkTGc2a87C4
         Qp1Y9pm2iz9bbzmllDCHtuIyAvVHzFQCU6QwvRJPRWYzqaFdkUgZOWPS3a5jUcHMQyMs
         baYgbpothiMkkwhytPo2EAyBYRpVhgxmI736qx9j1/i4vB08YMQihULSRsaWPuNaQYZq
         TOFSN+s7FaZrD2fx3mQDaLKxZ8CUTc3WWWfLbBv21U+52e0InKsOUVPMTO/oyPZUE2/4
         d/uQ==
X-Gm-Message-State: AOAM530CIKBvZLDDwW83+40evHDwFzy8fLNwoKJdO/goMxBH7v/eCa9K
        +FqupDhgsjlR/YlXeMfveP2T1aSHa37GKg==
X-Google-Smtp-Source: ABdhPJywFR282sMGgNIKw3utUtebH8FbDk9vjdYZyr3NNH5dkRPLzSo8pV2vx3qHAamBin42iVlIsg==
X-Received: by 2002:ac2:43ce:: with SMTP id u14mr2490545lfl.93.1612376545723;
        Wed, 03 Feb 2021 10:22:25 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o18sm331270ljc.44.2021.02.03.10.22.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:22:24 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u25so594536lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:22:24 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr2375495lfu.40.1612376544422;
 Wed, 03 Feb 2021 10:22:24 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net> <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
 <CAP045ApWnr=UQrBrv3fHj-C6EweukMWEyrCgsiY6Bt_i1Vdj6A@mail.gmail.com>
 <CAHk-=wgqRgk0hjvpjHNixK7xSOS_F3fpt3bL9ZUJVhCL3oGgyw@mail.gmail.com>
 <CAHk-=wgOp10DO9jtMC=B=RoTLWe7MFTS5pH4JeZ78-tbqTY1vw@mail.gmail.com>
 <87h7mtc9pr.fsf_-_@collabora.com> <CAHk-=wjFV8j03vyvuY4qhKnJ6Vy2DLfjzgTJ1n+LO9EsVsJmDg@mail.gmail.com>
 <CALCETrWpouBd+DqVu594B-94MQH_D0D7sECXZHEoAa+=X-_0=A@mail.gmail.com>
In-Reply-To: <CALCETrWpouBd+DqVu594B-94MQH_D0D7sECXZHEoAa+=X-_0=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Feb 2021 10:22:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3j8Fb-5FM8y+Oz+QWQ61ZxS5JW7da+dQeXrOYnOc19Q@mail.gmail.com>
Message-ID: <CAHk-=wj3j8Fb-5FM8y+Oz+QWQ61ZxS5JW7da+dQeXrOYnOc19Q@mail.gmail.com>
Subject: Re: [PATCH] entry: Fix missed trap after single-step on system call return
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:18 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> So if we want to reliably single-step a system call and trap after the
> system call, we just need to synthesize a trap on the way out.

Well, I think Gabriel's patch does exactly that, due to how
SYSCALL_EXIT_TRAP is set. It looks like subsequent system calls will
work exactly the way the concurrent system call case (that Kyle's test
did) does.

So it all _looks_ sane to me, but this is one of those "it needs testing".

               Linus
