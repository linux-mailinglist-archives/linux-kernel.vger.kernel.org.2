Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15517324194
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhBXQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236207AbhBXPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614181590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LOjIWreQoJfAnxovsPGI1EvM93YpjjYx3q/VF0cdRbM=;
        b=MLWMk8Dsyb02CRoemesPIM5kQzdNJtBkXGYHShehVeP79gtgRxzV+x/32Az2KyEYp4Mo2q
        p8tMCgKT8Gany0jyfNLKV63TxaIcB8Dy2TbtbLZAwYfpppFmSRNRHhHR+BhY3pCy0O6Ptn
        bFvjG1dCW898p3w8ug5y18JT0Sz2gX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-VxgQ8n2IOXylo_39ZPNIuQ-1; Wed, 24 Feb 2021 10:45:56 -0500
X-MC-Unique: VxgQ8n2IOXylo_39ZPNIuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11DFA8D22D4;
        Wed, 24 Feb 2021 15:18:08 +0000 (UTC)
Received: from treble (ovpn-118-134.rdu2.redhat.com [10.10.118.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 427BA19C71;
        Wed, 24 Feb 2021 15:18:07 +0000 (UTC)
Date:   Wed, 24 Feb 2021 09:18:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] x86/unwind/orc: Silence warnings caused by missing
 ORC data
Message-ID: <20210224151805.zrujocamlb5pxf7m@treble>
References: <cover.1612534649.git.jpoimboe@redhat.com>
 <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
 <YDZoEehURLLI/lWq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDZoEehURLLI/lWq@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:52:01PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 05, 2021 at 08:24:03AM -0600, Josh Poimboeuf wrote:
> > The ORC unwinder attempts to fall back to frame pointers when ORC data
> > is missing for a given instruction.  It sets state->error, but then
> > tries to keep going as a best-effort type of thing.  That may result in
> > further warnings if the unwinder gets lost.
> > 
> > Until we have some way to register generated code with the unwinder,
> > missing ORC will be expected, and occasionally going off the rails will
> > also be expected.  So don't warn about it.
> 
> I recently ran into another variant of missing ORC data, some files are
> simply not processed by objtool, eg. arch/x86/realmode/init.c. Would it
> make sense to have the vmlinux pass (when it isn't used to generate orc
> in the first place) also check that all code it finds has ORC data?
> 
> It's not fool proof, but it should help find files we're missing for
> some raisin.

Doesn't validate_reachable_instructions() basically already do that?

-- 
Josh

