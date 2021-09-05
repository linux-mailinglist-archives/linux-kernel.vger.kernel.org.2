Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A456D400EF8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhIEKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 06:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbhIEKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 06:09:20 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF7C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 03:08:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bk29so3869682qkb.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c75hFZr/XeaK+lcPWUQ4lmbB3uG6TjdKCLthgOQGD1M=;
        b=nG1qycdmdY4iVLzpN98U90ite2n+QXRoYQy1uj7/ynX57Gwevtry54HuTRrMxAwMVD
         kwvChSU92Q9azIKevzK4FbJJLz0rdAGxfd+NwUxtuJeCAK6CEcHz8oydaqU2Ba6rOsdn
         fEntsSsvJ1IUPjiQWJFNwJai4Sbs88J/PjPXGwQupgkxW8I51neHC2RRDh7i0VQU/ErO
         p50LE9n43JBhEo8lnM5+ZpqAPvA+MOZwD5z3cT3h8Y5uA4mvfQAmC8ms2+aw40TTaLFx
         wcb2Ilb0xspdaQU5G+agABWnEwlawdfIfGyB5wHmAJ20dSQvIDyFf2IaZqoPw1X0iCpz
         D3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c75hFZr/XeaK+lcPWUQ4lmbB3uG6TjdKCLthgOQGD1M=;
        b=Hrx7xmd5ZvezZzkKY1KCVbSLPwg5/yT/ePMkofP7wCcudrgznfCsYqpXytClAX55pd
         S5jLwAkqkmKqgnzAD3H0fqcfY4u6+XINNbekVygB8hkiyeQOvQ6JpXDYhnSegQqQzroR
         gv50sVhh5Xm3xjMlYuoJVN/gQB2OngyKutTImEVOkd7fgtqeszjfCm8ACBoUMk8sjacV
         V5fmzP32acfqvuWwt4CBFQ3DM9yIZSdpiM2e7QF7lTXJhrRowfXu92IAFkPs5e6neJTC
         cgPN00ogZSphr2mTm1E/8TYP5g3QX3LQvujIFA7vMiSqxjADeUI0aU7s9o0GrcCl8pSq
         nbfQ==
X-Gm-Message-State: AOAM533TJGDn7++Sg8wt5fS4BNez3OYPtQfEvsPjV2/Rkhdxrc8DYi2w
        Gqsl2m71LLokP+BDr7eKUX6pCHYQ6MxlTpSoiA==
X-Google-Smtp-Source: ABdhPJyK8BRIzpN3j1ImslAQfJKfI9hh/MztB0XZmmXnNovOaP50vji8ofLnBBYRzqu3AH7Pm+t3SjSe6QAKQ0eEb4M=
X-Received: by 2002:a37:6297:: with SMTP id w145mr6429170qkb.258.1630836496400;
 Sun, 05 Sep 2021 03:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000a9f3605cb1d2455@google.com> <20210904042010.5henc6pn5zotdq6v@treble>
In-Reply-To: <20210904042010.5henc6pn5zotdq6v@treble>
From:   Jussi Maki <joamaki@gmail.com>
Date:   Sun, 5 Sep 2021 12:08:05 +0200
Message-ID: <CAHn8xcnF5FT+i5jwsZGswyYt9Q9Amnj8N07wK08Fe_doGsBBaA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __static_key_slow_dec
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     syzbot <syzbot+30622fb04ddd72a4d167@syzkaller.appspotmail.com>,
        ardb@kernel.org, jbaron@akamai.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 6:20 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Looks like a jump label usage bug ("jump label: negative count!") may
> have been introduced, presumably with the following commit:
>
>   9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>
> Jussi, any idea?

Hey, thanks for looping me in.

The code in bond_xdp_set is unsafely assuming that it won't get called
multiple times with prog=NULL and that's likely the issue here. The
assumption seems to mostly hold as I haven't been able to reproduce
this locally yet, even with nested bonding or with non-XDP slaves in
the mix. I'll look into this more next week and try to decipher what
steps syzbot is doing. As soon as I have a repro + fix I'll send it to
the net tree.
