Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD63423554
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 03:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhJFBG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 21:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhJFBGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 21:06:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AE2C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 18:05:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k23so963434pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 18:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:date:message-id:mime-version;
        bh=A4VJniHKXgRvhM9CB9NqAoMDuZnGdMIB2tESsniPS5Y=;
        b=TH36DqQf1moGQssfh4QgEdwXQvhAEmenHRbwdfAHRx7OYEjvUKPDIvA65DiWpKadfr
         jgR+P2cUnr/DFKc+ZhfOGY2pHijmE2lPE9a/szbwDNJ0qofyiUQQz9wlTGcCGJqTlgWm
         mf1KomYOTZNqPDKQyDhgqLAvvKvMyIrlfn8d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=A4VJniHKXgRvhM9CB9NqAoMDuZnGdMIB2tESsniPS5Y=;
        b=c7H5nGV2FN2kASr5S00tr5azu85Ea3cfbxYN/8I1igV8vgYEqh5jKR/I9zdVs3DCV8
         ncV5IQGDnIMK6FOoAjs1tigkBE3I0KbttbT+CKXPg5SfelBuKblFE2GpGOC/5jEdJLep
         e7LFDej8bx3dfEqjmZYGcrHvFcSn3lzIpqnKavXvpK1qHGrnKXFfrFGTxO5vxKZELoyw
         sz9SYMyYiUjy+7VhGvFNdWJyYtpgBNXvd8MpE75SRApoZPuo5Nd+vP7Fad6gr1lR7Rl4
         LAg8bfCfTE8CUhEvRp/1w1upRnzTzDxtcVg1iQUh458YEApunkDB0UlkyvYMj+DzSObz
         bUHg==
X-Gm-Message-State: AOAM531u5OFz3RNNKEfG1qeck0vS/jAFPTrZ4eW801CnrLm77os2QOWF
        jKeCPR637LZmvVP3ddBITIvI1Q==
X-Google-Smtp-Source: ABdhPJwMdryG4AdKdWKK2MFAk/p+BOVs/L4iZbITxjJxjI2CqYrwvdF8NvcHiMlf0GMa3woH2FXn5w==
X-Received: by 2002:a17:90b:4a07:: with SMTP id kk7mr7417246pjb.37.1633482303184;
        Tue, 05 Oct 2021 18:05:03 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:ce15:427:ed6f:99de])
        by smtp.gmail.com with ESMTPSA id e4sm14781238pfj.130.2021.10.05.18.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:05:02 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org
Subject: instrument_atomic_read()/_write() in noinstr functions?
Date:   Wed, 06 Oct 2021 12:05:00 +1100
Message-ID: <871r4z55fn.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

commit b58e733fd774 ("rcu: Fixup noinstr warnings") adds some
instrument_atomic_read calls to rcu_nmi_enter - a function marked
noinstr. Similar calls are added to some other functions as well.

This is causing me some grief on powerpc64 while trying to enable
KASAN. powerpc64 book3s takes some NMIs in real mode, and in real mode
we can't access where I'm proposing to put the KASAN shadow - we can
only access it with translations on. So I end up taking a fault in the
kasan_check_read path via rcu_nmi_enter.

As far as I can tell `instrumentation_begin()` and
`instrumentation_end()` don't make it safe to call instrumentation, they
just tell the developer that instrumentation is safe. (And they are used
to check the balance of _begin()/_end() blocks.)

Is the underlying assumption that the KASAN shadow will always be safe
to access, even in functions marked noinstr? It seems to undercut what
an architecture can assume about a function marked noinstr...

Kind regards,
Daniel

P.S. On a more generic note instrumentation_begin()/_end() is now
scattered across the kernel and it makes me a bit nervous. It's making a
statement about something that is in part a property of how the arch
implements instrumentation. Are arches expected to implement things in
such a way as to make these blocks accurate? For example in
arch/powerpc/include/asm/interrupt.h::interrupt_nmi_enter_prepare we
currently sometimes call nmi_enter in real mode; should we instead only
call it when we have translations on?
