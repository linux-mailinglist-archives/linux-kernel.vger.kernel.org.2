Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812AD31A934
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBMBDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBMBDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:03:34 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B919DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:02:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f1so2064427lfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ug7HArqGmF1vWBXzbZZtTb4cswmqCb7RnJ5VpB42MFk=;
        b=CzASO3uZRA9mULKSb2Xk4vctqLx9m57xjZ/1jQnWrTk2/27hzIlTZfMQwR3I5PEdes
         aE8oyFOhfvB80kSaMpp9Yb5ARtlz8x5M2QRJI44mcuQmFnA8X4SbFxEFLcX029G6OFJ+
         LcCvdR9L9FxvZ/Tw5v2D2uOlo/jgRmT3ciroA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ug7HArqGmF1vWBXzbZZtTb4cswmqCb7RnJ5VpB42MFk=;
        b=TqLZx7LZbHqRt4R+rQDXT14oDAuYA3g0Q9MsgeEywAm1x3gxWwWJ4/0nD1FdSp4faH
         2i5yuQF76qYrGZLdq+cSF5Eyaur1ouHwfnAiO3BiQi3utscO6HqWILB35RehQ7Z22jb9
         B+NvQOOf+tDo5pzdAHFVI8yCx1HcPAzZ5sD9ZiWxorvw1gLaJkELxxxkoWeZ2I0k59Ej
         0xFe33dvv6qCK8X9zr3dJ//7TeZNOowcELRHOSJtKBpGrWR8o/H9IM7oTXudVLaD/CKg
         Lu/dIWa50Nwc2OtUxggf5lRcyTBIqoqB8y3v+2fNitrn+7j2bgMDTVaPEsgs6RdHqch3
         JoDA==
X-Gm-Message-State: AOAM533pDbm7FVEzbYFHi0yE1aCj4Y7CmBoQPOIt2Psec2eRJ5ZKNzGy
        KCZ/KxJvyWqyfn9Emy3Mvqpiyp+MPBqYtA==
X-Google-Smtp-Source: ABdhPJzyXkt0hJ5XXkvx5pX8pP6xIjKpD3UXKJYrtypKM/Ddr01MVcXrVFqAv1awUbT9hpB/+Fzn3Q==
X-Received: by 2002:a19:ec1a:: with SMTP id b26mr2833968lfa.123.1613178171855;
        Fri, 12 Feb 2021 17:02:51 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u12sm805617lfb.16.2021.02.12.17.02.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 17:02:51 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id v30so2027574lfq.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:02:50 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr2767877lfu.40.1613178170443;
 Fri, 12 Feb 2021 17:02:50 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mtYEj+WLy+oPSXEwS5sZ8+TNk_dU3PVx3ieBz2DFS94Sg@mail.gmail.com>
 <CAHk-=wja1Y8r5UKrmXcMFrS=VPkTPbkyK-vt8B9MBkEU4+-WLw@mail.gmail.com>
 <CAH2r5mtj+-xGDy-YN0JwSJAsgvB+HpQFCBi-zdTNXTRBY_Mteg@mail.gmail.com> <592ad76a-866e-f932-5a82-1af4a2ba4880@samba.org>
In-Reply-To: <592ad76a-866e-f932-5a82-1af4a2ba4880@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Feb 2021 17:02:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8n15NOcHkuxD=rXnMZCcsYD316JjRDdHUFwcFi8vq6g@mail.gmail.com>
Message-ID: <CAHk-=wh8n15NOcHkuxD=rXnMZCcsYD316JjRDdHUFwcFi8vq6g@mail.gmail.com>
Subject: Re: [GIT PULL] cifs fixes
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Steve French <smfrench@gmail.com>,
        =?UTF-8?B?QmrDtnJuIEpBQ0tF?= <bjacke@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 4:26 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> The machine is running a 'AMD Ryzen Threadripper 2950X 16-Core Processor'
> and is freezing without any trace every view days.

I don't think the first-gen Zen issues ever really got solved. There
were multiple ones, with random segfaults for the early ones (but
afaik those were fixed by an RMA process with AMD), but the "it
randomly locks up" ones never had a satisfactory resolution afaik.

There were lots of random workarounds, but judging by your email:

> We played with various boot parameters (currently we're using
> 'mem_encrypt=off rcu_nocbs=0-31 processor.max_cstate=1 idle=nomwait nomodeset consoleblank=0',

I suspect you've seen all the bugzilla threads on this issue (kernel
bugzilla 196683 is probably the main one, but it was discussed
elsewhere too).

I assume you've updated to latest BIOS and looked at various BIOS
power management settings too?

Zen 2 seems to have fixed things (knock wood - it's certainly working
for me), But many people obviously never saw any issues with Zen 1
either.

           Linus
