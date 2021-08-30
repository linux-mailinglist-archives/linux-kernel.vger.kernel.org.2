Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518EC3FBEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbhH3WNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbhH3WNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:13:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3637C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:12:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w4so28379765ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/wJoxG+i27oKrP3cLakziJxV0qVvhUy/gmxpm7mduk=;
        b=MAt9ZAiyMAMatDdPJvAfiKfJJXabP2nn30Sq/tL3gFwRDEMkaw/Ao71akLjCtsx/de
         fkZENWkXI4qiIv/TVIrKCgurVEQaY9eGRALaN+kPCUUXgK1tqxqCQWkLhK7QObP6eGME
         sgONDssS2VOy6f32TGrqfUxG0cUNOal0g4Xcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/wJoxG+i27oKrP3cLakziJxV0qVvhUy/gmxpm7mduk=;
        b=GBSJhFOap3E4H8uVADLIArp9PqtiC1M4vLxZpVfaTayqMOekauu75BRrrJURXN6Yzj
         vcZRxg1dDSMh+aIQ6SVhxzFm4j1sWSRnGU0gNRa4FsR6O/dA3RTWuTLRWOlM6ev+9OiR
         jFHq/gexYEe4orbxAUOcbtrnv4v8d0OyJ+EmW7mASDoc0cj1V4s5blRAzxo4Lr6B4ghZ
         BwCwXX+BGGTp0GtIchRsfpUXDzSvkDBAiYlBY6wDRKXy2BypvMkxnyLo7CCylYGpvSlJ
         d4j0Bvr5F3GiKPrrKXkqrc+BbEL7INIP45mv+8gkPxwS4q5sXuNYLtlO9PEaZDZA6t9G
         q7QQ==
X-Gm-Message-State: AOAM533GotnThy6/w5RVvvmtHVFjA21W4c/EJ7UEzh+Fdmf57ym4IL/C
        IPYL05MVHJVbl8kGhXcU7b4/D870Sxg7bJNMirM=
X-Google-Smtp-Source: ABdhPJzwuvPpJClwtUg+3EVrIa08hexpNvsztA9Dts11Afq8ectND4l0vwbD271xDsL3gc89UuzbJQ==
X-Received: by 2002:a05:651c:1121:: with SMTP id e1mr22020349ljo.468.1630361535910;
        Mon, 30 Aug 2021 15:12:15 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id bt42sm1516093lfb.118.2021.08.30.15.12.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 15:12:15 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id q21so28381535ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:12:15 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr21908833ljh.61.1630361535140;
 Mon, 30 Aug 2021 15:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210830154702.247681585@linutronix.de> <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic> <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com> <87r1eafv7k.ffs@tglx>
In-Reply-To: <87r1eafv7k.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 15:11:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJPH2fQOckAK0+ZThMgHSsXvAG+iYk7C9+zsnqMWUbrw@mail.gmail.com>
Message-ID: <CAHk-=wgJPH2fQOckAK0+ZThMgHSsXvAG+iYk7C9+zsnqMWUbrw@mail.gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in restore_fpregs_from_user()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 3:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> So yes, the negation does not matter, but the ability to check whether
> the fail was caused by #PF or not matters.

See my secopd email with a note on access granularity, and why this
kind of model doesn't seem to work in general and seems dangerous.

             Linus
