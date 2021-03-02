Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F332AA44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581785AbhCBTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839639AbhCBQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB401C06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:10:27 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id r17so36224311ejy.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJDGGYw7tvcK+titjb5UUUKjKogKFbuBWfwBQn8pnpY=;
        b=BlJkHpJ9gb2T6xH4d7E6DsfDVr0uh9W/Z84RVzgIuhv/Qy8ZfKayi3gWppMi4kMSXj
         LErYX2rZn36FwdYsyG3kZGhKii9OoE6QpO+PUmmCSk5lI0YW5riJfIK1VIJMyxoFUqoG
         379zxil7FtYzj0JPDQ2/87FgaXDypPkhU6TdwiaOl1WwN7NDqt+HBSgJOKFX9abjwpm+
         cmJg9XDLYsaLp3xMOouOx7bqSBYoOvemqiKQ9XQXF+QPWZWPgXYG8shXQT06TnlRZRY4
         x1zbduD4zPKj1TxcyaFrvvER8rnfiuu4G4X+MFT1K2gnsJTkZqi8JDtf5Sb59DPOWwEh
         pHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJDGGYw7tvcK+titjb5UUUKjKogKFbuBWfwBQn8pnpY=;
        b=YMHJstKqLErzzHh3UdKw3QdX+MwJyoj5/ujn9/+KZRPCoFPEhQGCkU1xE4ZjTOKwbX
         QpGmevlzToi1hvF2FX9lgm1rw/N7KvdP2mFlPsrZXJ9iuMsMIBGzyj8675ZH4Wktt/y+
         ci/6G5NY6Demh+BPQBWKWOTp056LGxwudAJXvdcqp0XoHayPXXQkilqUSq0GP+uN/xgT
         DhInhxxZEKXawrSdYeKRTSc1HdoTnVVvPwVV9SrByEUsZUEqZjW8EWu88eSNvixiJFp2
         6yvE7hwzCs7UAAHRXWuewHr6Xp/THEqIGPEKv5cSQXpPzhTObAV9SOo23sbYvLBgoRt8
         QBOQ==
X-Gm-Message-State: AOAM532kUloG6HSIaVfm4QNeNmWYAl28coIwPkQfLyaeVwuWeQR4Xcw6
        +fzEDAnhO4T0sP4ntzZHBhtdwP6ez2i0i5RiKDXq
X-Google-Smtp-Source: ABdhPJx8PQFaZgOM2xUwSD8DpzvBCZqhortPrXsbuQRmYKE4KenPCbP0EoVbTKZ9wj1YIut8Zj0gMSbUKh7l4apxoGg=
X-Received: by 2002:a17:906:7056:: with SMTP id r22mr6639665ejj.106.1614701426386;
 Tue, 02 Mar 2021 08:10:26 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006305c005bc8ba7f0@google.com> <CACT4Y+YFtUHzWcU3VBvxsdq-V_4hN_ZDs4riZiHPt4f0cy8ryA@mail.gmail.com>
In-Reply-To: <CACT4Y+YFtUHzWcU3VBvxsdq-V_4hN_ZDs4riZiHPt4f0cy8ryA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Mar 2021 11:10:15 -0500
Message-ID: <CAHC9VhTxrGgBDW_439HeSP=_F9Jt2_cYrrQ7DtAXtKG4evGb9g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cipso_v4_genopt
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9ec037722d2603a9f52e@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>, dsahern@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 6:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>

...

> Besides these 2 crashes, we've also seen one on a 4.19 based kernel, see below.
> Based on the reports with mismatching stacks, it looks like
> cipso_v4_genopt is doing some kind of wild pointer access (uninit
> pointer?).

Hmm, interesting.  Looking quickly at the stack dump, it appears that
the problem occurs (at least in the recent kernel) when accessing the
cipso_v4_doi.tags[] array which is embedded in the cipso_v4_doi
struct.  Based on the code in cipso_v4_genopt() it doesn't appear that
we are shooting past the end of the array/struct and the cipso_v4_doi
struct appears to be refcounted correctly in cipso_v4_doi_getdef() and
cipso_v4_doi_putdef().  I'll look at it some more today to see if
something jumps out at me, but obviously a reproducer would be very
helpful if you are able to find one.

It's also worth adding that this code really hasn't changed much in a
*long* time, not that this means it isn't broken, just that it might
also be worth looking at other odd memory bugs to see if there is
chance they are wandering around and stomping on memory ...

-- 
paul moore
www.paul-moore.com
