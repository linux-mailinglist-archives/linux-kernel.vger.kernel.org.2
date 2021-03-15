Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3433C346
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhCOREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233992AbhCORDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615827811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmU5haEHnIZc+DxPghKYzLaT4DInhUzR0hiClj3ycII=;
        b=R6xZKnyEtkwvPCI5d9YCD3ME1b92NJAkbq3PyMuS9A9E5kusasTexD+JP+dBMQXipFFx14
        bCAdy1y7h2nZd2LR8p4Q6kxOLqoqBDdt9/DalsaOxmbfopgZ1lhi9ib6/HeEFBGQgf5LT4
        5ScOZL/e4vy7tM4Rtt3HEt3blbFgoQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-GStMljpDMsSv9vZtwlBujQ-1; Mon, 15 Mar 2021 13:03:27 -0400
X-MC-Unique: GStMljpDMsSv9vZtwlBujQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FD53801817;
        Mon, 15 Mar 2021 17:03:26 +0000 (UTC)
Received: from treble (ovpn-118-162.rdu2.redhat.com [10.10.118.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74F1E50AD5;
        Mon, 15 Mar 2021 17:03:24 +0000 (UTC)
Date:   Mon, 15 Mar 2021 12:03:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <20210315170321.ndeqgjzdfupvuiak@treble>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
 <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
 <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net>
 <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
 <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net>
 <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:08:27PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 15, 2021 at 12:26:12PM +0100, Peter Zijlstra wrote:
> > Ooooh, modules don't have this. They still have regular
> > .static_call_sites sections, and *those* are unaligned.
> > 
> > Section Headers:
> > [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
> > 
> > [16] .static_call_sites PROGBITS        0000000000000000 008aa1 0006f0 00  WA  0   0  1
> > 
> > And that goes *BOOM*.. Let me ses if I can figure out how to make
> > objtool align those sections.
> 
> The below seems to have cured it:
> 
> [16] .static_call_sites PROGBITS        0000000000000000 008aa8 0006f0 00  WA  0   0  8
> 
> 
> So, anybody any opinion on if we ought to do this?

I'd say yes to alignment, for the sake of consistency with vmlinux.

Though instead of using objtool, it can be done in the module linker
script:

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..73345cbfe100 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -17,6 +17,7 @@ SECTIONS {
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
+	.static_call_sites	0 : ALIGN(8) { KEEP(*(.static_call_sites)) }
 
 	__patchable_function_entries : { *(__patchable_function_entries) }
 

