Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA4437FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 23:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhJVVFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 17:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhJVVFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 17:05:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA12C60F57;
        Fri, 22 Oct 2021 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634936596;
        bh=OQnE0h9dtpBNEgRKExwAhKEMVV5FKbUCHpApDBSVYF4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=E5KBdBY23Py7agn40J6l75rn+7bq1+ekctdWpDCCtA4zhAVuR9gQLzF7v/SmZhV4S
         mFEZTM+hQQmIJA0UasgjYODRyD7K50tWxLJJmhXheK00ZRWtO5CHM2i2Q6uIp9qc6T
         Zk0TJFyO2HfeHvKTBIiACehKmyEdE7nqHF8Mbz3xLDVGkG2/vekjBonxDNBbUV0/Jo
         jiLdaFVi+IkBxAApRZBC8tQA38bA2DNubmNQiTS5XZPdlr8EaotoN7pBTX8f2tu6vx
         apSS9MiOrnqrE9YpgXLw4VgAtP1HWeZWubP2NMU7GxLTCIYtsJy55XKLNmfSOCpAtZ
         j5yPzgBSCoF/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B58515C0BF4; Fri, 22 Oct 2021 14:03:15 -0700 (PDT)
Date:   Fri, 22 Oct 2021 14:03:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     gregkh@linuxfoundation.org, tglx@linutronix.de, clm@fb.com,
        corbet@lwn.net
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, miguel.ojeda.sandonis@gmail.com,
        wedsonaf@google.com, boqun.feng@gmail.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: "Using Rust for kernel development": Memory model
Message-ID: <20211022210315.GA2582977@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This email is in response to the Rust memory-model discussion at
Maintainers Summit (https://lwn.net/Articles/870555/).

My blog series entitled "So You Want to Rust the Linux Kernel?" [1] is now
feature complete, and a big "thank you" for all the great feedback that
this series received.  I have recommendations at "TL;DR: Memory-Model
Recommendations for Rusting the Linux Kernel" [2], and this email is
therefore TL;DR(TL;DR).

Given the Rust-for-Linux's focus on device drivers, the Linux-kernel
features requiring special Linux-kernel-memory-model features can be
avoided within Rust code.  For example, code using RCU, sequence locking,
or control dependencies can remain written in C, and higher-level APIs
based on that code can be exported to Rust in manner consistent with
Rust's current ownership models.

This approach reasonably straightforwardly accommodates the more likely
short-term choices for the Rust memory model, which would presumably be
the C/C++ memory model or some stronger subset thereof, for example, one
that excludes consume and relaxed accesses.  If the Rust community chooses
a less mainstream memory model, the code that makes C-code functionality
available to Rust code would need to take up any slack.  For example,
memory barriers might need to be inserted into this wrapper code.

Longer term, I hope that the core Rust community will become interested
in supporting modern techniques, and to that end I have suggested some
longer-term goals in the TL;DR post.

There is already plenty of interest in modern techniques within the
greater Rust community, and number of people produced prototype wrappers
for various sequence-locking and RCU use cases.  I am grateful to all
who took on this challenge.

However, arriving at good wrappers requires a sufficient understanding
of Rust to be combined with sufficient knowledge of the Linux kernel's
wide variety of sequence-locking and RCU use cases, and unfortunately
this combining seems to be some ways off [3].  It therefore makes sense to
defer the need for such wrappers in order to allow time for this diffusion
of knowledge to take place.  So, in the near term, if a Rust-code project
were to request direct access to RCU APIs, I would instead ask them to
create higher-level APIs so that the RCU APIs would remain within C code.
I am also working to better document the wide range of RCU use cases
that are present in the Linux kernel, which I hope will speed up the
process of working out what a Rust-language RCU API should look like.

Of course, the corresponding choices for sequence locking are in the
capable hands of the relevant maintainers, who are CCed.

Thoughts?

						Thanx, Paul

[1] https://paulmck.livejournal.com/62436.html

[2] https://paulmck.livejournal.com/65341.html

[3] This process took four years in the C/C++ standards committees,
    but perhaps things will go faster with the Rust community.
