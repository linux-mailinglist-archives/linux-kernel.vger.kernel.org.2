Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17F43CE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhJ0QUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238167AbhJ0QUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:20:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B26460F92;
        Wed, 27 Oct 2021 16:17:51 +0000 (UTC)
Date:   Wed, 27 Oct 2021 12:17:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Guo Ren <guoren@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Abaci <abaci@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Wang <yun.wang@linux.alibaba.com>
Subject: Re: [for-next][PATCH 14/15] ftrace: disable preemption when
 recursion locked
Message-ID: <20211027121749.43036285@gandalf.local.home>
In-Reply-To: <20211027161002.350042850@goodmis.org>
References: <20211027160940.084904334@goodmis.org>
        <20211027161002.350042850@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 12:09:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: =?UTF-8?q?=E7=8E=8B=E8=B4=87?= <yun.wang@linux.alibaba.com>

This is just a artifact from my scripts that use quilt to send the email
(quilt is at fault here). But my git repo has it correctly encoded.

-- Steve
