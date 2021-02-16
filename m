Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C931CD22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBPPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhBPPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613490345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86vWmVPfoSGSBR3M7oLmyUrscE6/3lgafW3QD8JX7cw=;
        b=KdjZQQpCJsxcifaBVHa0oGHABOc3NspqHfD0YZsJCYdwat/38K6PV8VSALOSfVRg3Dwwox
        EwMglVCWSx3mszcCs7cStloh/B2qLhhUMLnQ58zk+oVcHVeBzu/KwhqcbtOanoHLHQHiPJ
        zbyD4nBYpm5ve35TsbETMv+UvzDMvIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-lLdBOu2jPMaaW2HlVzcBcA-1; Tue, 16 Feb 2021 10:45:44 -0500
X-MC-Unique: lLdBOu2jPMaaW2HlVzcBcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8530100CCC0;
        Tue, 16 Feb 2021 15:45:42 +0000 (UTC)
Received: from treble (ovpn-117-118.rdu2.redhat.com [10.10.117.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AEED1975F;
        Tue, 16 Feb 2021 15:45:41 +0000 (UTC)
Date:   Tue, 16 Feb 2021 09:45:39 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without size
Message-ID: <20210216154539.qac763oef4czrtss@treble>
References: <20210215164446.530f6311@gandalf.local.home>
 <20210216000504.axm3k4xho47c6drz@treble>
 <20210215200639.67141685@oasis.local.home>
 <20210215210057.4ceb6339@oasis.local.home>
 <YCumppsKxaheg/II@kroah.com>
 <20210216095121.4fe321dc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216095121.4fe321dc@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:51:21AM -0500, Steven Rostedt wrote:
> On Tue, 16 Feb 2021 12:04:06 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > Thanks for this.
> > 
> > Should I also queue these up for 4.9 and 4.14 which do not have these
> > commits in them either (but somehow do not show the problem, yet)?
>
> This bothers me. I want to know exactly why this is a problem.

I actually see the same problem with 4.9 and 4.14, using the same
config.

It's very config-specific.  Something has to convince the toolchain to
not reference those two weak functions by section.

> That said, it is fine to backport those patches, and I would include 4.9
> and 4.14, as I would think you have a similar requirement that we have in
> the stable-rt trees. That is you shouldn't experience a regression going
> from an older kernel to a newer one because the older one had a fix
> backported to it that a newer one did not. Basically the same rationale that
> all fixes go into Linus's tree before backporting. We do the same on the
> stable-rt, where all fixes go in all maintained stable trees that are newer
> than the one you are backporting to.
> 
> Although, it does allow more to be traced than what recordmcount enables.
> But hopefully it doesn't cause any issues. Maybe I should do some ftrace
> testing before you go and release any of those stables with those patches.
> 
> I'm looking to see if this new "feature" of binutils isn't causing trouble
> elsewhere. I'm thinking that ftrace is just the canary here.

It already caused quite a bit of trouble with objtool (as did a previous
similar change by the Clang assembler).

-- 
Josh

