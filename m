Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA247323448
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhBWXi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233725AbhBWXZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:25:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE84E64E7C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614122672;
        bh=KP288goND8M4n+LhyazQ7ab4gsFaGAFzzE584UPD1iM=;
        h=From:Date:Subject:To:From;
        b=FMCHZcvnzRhWfLWiDCxJvKlBYnB30wJTSuwjs6oSUdZvwyiC/ZvFLYNLqDgtZkQy6
         mhrekxItrf0QBCzKI05JXFwbzBkxrk+sgAAaXpE2r42tfVnYkl8ELIUtaevGNNY7pm
         GaRyoihatR5Sgq2PGXixvajShiy9NjiORv9uFuNHChV9wnwuyM+lBrvyqpIsyozyms
         e6YiFJIvTDn8SAq1keDZSpPJbslxQDEWx0epSpgAauvzJBKWmj58FzhES/0Gb5DWXy
         k+Js8h9qbXAd7rH2WYSAsRaQdlGr6OMYGHPoJm/Wrno3vwsBpxlhdkovmtVgnT3a4V
         pga1Aa+pm03pA==
Received: by mail-lf1-f41.google.com with SMTP id j19so192514lfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:24:31 -0800 (PST)
X-Gm-Message-State: AOAM533YRau7MuAQ63SPjDhmnr7aWsDrdyWSPjHEfvc4nxRB6cfk2WQu
        zsQgPt7SQ8Zfi5+4cUAbJjqzSMHyIGn2ijW7r2hT6g==
X-Google-Smtp-Source: ABdhPJwARxpYankk7/UpOTZMy2AiL9dmKWTwmvoL1SvZiInLS0WFF7nqN0IqsTInH5BdIPvzFdiz0ICAed767j37esA=
X-Received: by 2002:a19:810c:: with SMTP id c12mr18485404lfd.244.1614122669974;
 Tue, 23 Feb 2021 15:24:29 -0800 (PST)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Feb 2021 15:24:19 -0800
X-Gmail-Original-Message-ID: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
Message-ID: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
Subject: Why do kprobes and uprobes singlestep?
To:     Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while back, I let myself be convinced that kprobes genuinely need to
single-step the kernel on occasion, and I decided that this sucked but
I could live with it.  it would, however, be Really Really Nice (tm)
if we could have a rule that anyone running x86 Linux who single-steps
the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
when the system falls apart around them.  Specifically, if we don't
allow kernel single-stepping and if we suitably limit kernel
instruction breakpoints (the latter isn't actually a major problem),
then we don't really really need to use IRET to return to the kernel,
and that means we can avoid some massive NMI nastiness.

But I was contemplating the code, and I'm no longer convinced.
Uprobes seem to single-step user code for no discernable reason.
(They want to trap after executing an out of line instruction, AFAICT.
Surely INT3 or even CALL after the out-of-line insn would work as well
or better.)  Why does kprobe single-step?  I spend a while staring at
the code, and it was entirely unclear to me what the purpose of the
single-step is.

--Andy
