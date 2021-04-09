Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0345335A90A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhDIWxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 18:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234880AbhDIWxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 18:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618008812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jf6jPmlzNbpAjoJ0oKjh2RDzB4kN600asH4kKxtngY8=;
        b=X23ZMhBbNrkOLmoOfwi1kr/QEjkvhYM8hhqp53k3/DOIws+c0Czp/ik+QqInWcTby06iSH
        g7dUzn+ynicct4kbrh9aTg/FccL8pN+5FDQsYqPag7h4xOOl4cUJycWY+fe7C/ZSbOn4Fi
        l+j1yqhed79IOpWvzOJXJ+6gN2DXqqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-k-qExt-ANg2MUVpDE77G1g-1; Fri, 09 Apr 2021 18:53:28 -0400
X-MC-Unique: k-qExt-ANg2MUVpDE77G1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B760189C446;
        Fri,  9 Apr 2021 22:53:27 +0000 (UTC)
Received: from treble (ovpn-112-2.rdu2.redhat.com [10.10.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1E45D9E3;
        Fri,  9 Apr 2021 22:53:22 +0000 (UTC)
Date:   Fri, 9 Apr 2021 17:53:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
        jthierry@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 0/4] arm64: Implement stack trace reliability
 checks
Message-ID: <20210409225321.2czbawz6p2aquf5m@treble>
References: <705993ccb34a611c75cdae0a8cb1b40f9b218ebd>
 <20210405204313.21346-1-madvenka@linux.microsoft.com>
 <20210409120859.GA51636@C02TD0UTHF1T.local>
 <20210409213741.kqmwyajoppuqrkge@treble>
 <8c30ec5f-b51e-494f-5f6c-d2f012135f69@linux.microsoft.com>
 <20210409223227.rvf6tfhvgnpzmabn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210409223227.rvf6tfhvgnpzmabn@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 05:32:27PM -0500, Josh Poimboeuf wrote:
> On Fri, Apr 09, 2021 at 05:05:58PM -0500, Madhavan T. Venkataraman wrote:
> > > FWIW, over the years we've had zero issues with encoding the frame
> > > pointer on x86.  After you save pt_regs, you encode the frame pointer to
> > > point to it.  Ideally in the same macro so it's hard to overlook.
> > > 
> > 
> > I had the same opinion. In fact, in my encoding scheme, I have additional
> > checks to make absolutely sure that it is a true encoding and not stack
> > corruption. The chances of all of those values accidentally matching are,
> > well, null.
> 
> Right, stack corruption -- which is already exceedingly rare -- would
> have to be combined with a miracle or two in order to come out of the
> whole thing marked as 'reliable' :-)
> 
> And really, we already take a similar risk today by "trusting" the frame
> pointer value on the stack to a certain extent.

Oh yeah, I forgot to mention some more benefits of encoding the frame
pointer (or marking pt_regs in some other way):

a) Stack addresses can be printed properly: '%pS' for printing regs->pc
   and '%pB' for printing call returns.

   Using '%pS' for call returns (as arm64 seems to do today) will result
   in printing the wrong function when you have tail calls to noreturn
   functions on the stack (which is actually quite common for calls to
   panic(), die(), etc).

   More details:

   https://lkml.kernel.org/r/20210403155948.ubbgtwmlsdyar7yp@treble

b) Stack dumps to the console can dump the exception registers they find
   along the way.  This is actually quite nice for debugging.


-- 
Josh

