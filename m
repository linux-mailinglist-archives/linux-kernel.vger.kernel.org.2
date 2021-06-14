Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6783A71E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 00:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhFNW3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFNW3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:29:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 15:27:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v22so23626191lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyMEdvibDhNly5uv8Pg1ye0etmkB4AI1saE08dXRZGQ=;
        b=CieIEi/iGNQyWJNFbKIHRIgbLgNnYag7g5rwxBwWEodRzQ4LnFGHePWi4p05Wor4PG
         hpkU1XMCTuwbEl0SkJxr7of+mSAKPT9pviUumSarrCyLLWKx3vWPk+Jxey6rZRi8oIuU
         4bul0vRlbBzzA6JY3I51ReoS0LXJwjsGCqvnWoRCnoN0Fte6LYqa/eRBIaDEqoAEI27C
         +Bk8zJMOGtA12aYNVcKFZmbH7UJg0b7RfB5RubDr638V5ReoxQRcHeV0LqcTTPuS4VXb
         KYZnn4TX9qMBF2LCG2iIx8MiWYQm9VeMU8Vxa6uCmesxrxR8KP20c8U7iSNOA+lze1S6
         eF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyMEdvibDhNly5uv8Pg1ye0etmkB4AI1saE08dXRZGQ=;
        b=IFFTUu/WJCloEsTlC5n/hURJ8q9paHrgdFtHG78QKRiSLeMAJA0jCOomUChOMHRLor
         xOX1oUDXZEhM7f+9C6FgMiL7xeeLSiIkB5b2kS3IK0i5m9KsW8Zkb/shXvH+1fbPA8Mq
         lMGN9oI9izUD1xPaUZwq4FXoopysIQJg7ZOkBCJZgOCek5wg7gWBfFgL25fpkgfD5heT
         kLY4MKmvzdItOJnr44atfMgphxeYpRXjoj0YyXrl+aeLY7Dtpd+Aigbgse88WWfFDiqJ
         lsSKXEn6k1oqJIOnnFu0hZZY/21GM5M8HGOc/VrPNF/7Jf+0gCGjoRpwZ1P6e+eM2uJ2
         Mq8g==
X-Gm-Message-State: AOAM530XMOZlQ73HN1rGvVkMUtPSJLuYr+due5Or6YzbEds1MuOp6Dfc
        770YIr6iFHh6Uqzds6wtHoY=
X-Google-Smtp-Source: ABdhPJxKLMnzGgglyYmSVpkXVmtvE+RBZRJ6kBszwfAfWjHDGpBFQq+c9i1QDt8DaAEQE5rRA/Y9Bw==
X-Received: by 2002:a19:ec14:: with SMTP id b20mr13726725lfa.244.1623709649642;
        Mon, 14 Jun 2021 15:27:29 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4yffpgq---2xhdgy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:8461:5bff:fed3:30ca])
        by smtp.gmail.com with ESMTPSA id y5sm1603918lfs.265.2021.06.14.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 15:27:29 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [RFC PATCH 0/5] pgo: Add PGO support for module profile data
Date:   Tue, 15 Jun 2021 01:27:28 +0300
Message-ID: <2164227.uJ0V1KJIEf@hyperiorarchmachine>
In-Reply-To: <202106141455.45C7B198D7@keescook>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com> <202106140904.484E2337C@keescook> <202106141455.45C7B198D7@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote tiistaina 15. kes=C3=A4kuuta 2021 0.57.46 EEST:
> On Sat, Jun 12, 2021 at 06:24:21AM +0300, Jarmo Tiitto wrote:
> > [...]
> > The patches itself are based on Kees/for-next/clang/features tree
> > where I have two of my bug fix patches already in. :-)
>=20
> BTW, due to the (soon to be addressed) requirements of noinstr[1],
> I've removed PGO from my -next tree, and moved it into its own tree in
> "for-next/clang/pgo".
>=20
> -Kees
>=20
> [1] https://lore.kernel.org/lkml/202106140921.5E591BD@keescook/
>=20
> --
> Kees Cook

Yeah, I noticed that. Actually, I think we really should wait for that noin=
str=20
stuff since:

> There is an lockup that only occurs during bare metal run after +15min, s=
o I=20
> haven't been able to catch it in VM.
> I suspect this is caused by the RCU locking I added such that it results =
in=20
> recursive calls into __llvm_profile_instrument_target()

That basically means LLVM is instrumenting code that I call from
__llvm_profile_instrument_target() resulting in nice cycle of doom.
Sigh...

I wrote fix for this but it would be nice to be sure the compiler
doesn't pull the rug under my toes. :-)
=2D-
Jarmo


