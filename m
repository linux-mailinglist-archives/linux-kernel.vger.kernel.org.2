Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73433956A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhCLRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233096AbhCLRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:47:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E7D764E90;
        Fri, 12 Mar 2021 17:47:53 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:47:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210312124751.5e6aee98@gandalf.local.home>
In-Reply-To: <CA+icZUUpQWtLcqjK+07ktO5PCoJ+2HEHzyp4tRRqHZpAOatq5g@mail.gmail.com>
References: <20210312113253.305040674@infradead.org>
        <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
        <20210312144726.GA22098@zn.tnic>
        <20210312122622.603bd82c@gandalf.local.home>
        <CA+icZUUpQWtLcqjK+07ktO5PCoJ+2HEHzyp4tRRqHZpAOatq5g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 18:35:45 +0100
Sedat Dilek <sedat.dilek@gmail.com> wrote:


> Hey Steve, you degraded me to a number :-).

It's the internet, everyone is a number.

> 
> I dunno which Git tree this patchset applies to, but I check if I can
> apply the patchset to my current local Git.

Try Linus's latest.

> Then build a kernel in the same build-environment.
> Lemme see.
> 
> To say with Linus's words:
> "Numbers talk - bullshit walks."

Exactly.

-- Steve
