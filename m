Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E6F30DD5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhBCO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233289AbhBCO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612364157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rS+uT6I7CZvs7rA5cJQRTM4ulgel3uvO4ETs7pNUH30=;
        b=DCDwz0iujMzr0iVyaKxrIolJcgDNUO1nHjCRdgJVynWuc5jcJFNtNVLDI95Pv+0xsgo0Op
        NcriphN2S23U5uAdqb4AHKvWPj09nWe2NGRJF/5z6IbY1b3SCt/TJjlRKACedbnZd8U65P
        ynG/RBNRRCnNRQ/8hYBogeN9CdbgI7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-OYu2hsbDOzqHBxOOun8Kew-1; Wed, 03 Feb 2021 09:55:55 -0500
X-MC-Unique: OYu2hsbDOzqHBxOOun8Kew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22402801962;
        Wed,  3 Feb 2021 14:55:54 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F50357;
        Wed,  3 Feb 2021 14:55:53 +0000 (UTC)
Date:   Wed, 3 Feb 2021 08:55:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] objtool: Change REG_SP_INDIRECT
Message-ID: <20210203145549.p2alqmtbbo3z75nl@treble>
References: <20210203120222.451068583@infradead.org>
 <20210203120401.062155900@infradead.org>
 <20210203144215.4ledy6srx7zwfxde@treble>
 <YBq33lMgoUOnCXPW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBq33lMgoUOnCXPW@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:49:02PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 03, 2021 at 08:42:15AM -0600, Josh Poimboeuf wrote:
> > On Wed, Feb 03, 2021 at 01:02:23PM +0100, Peter Zijlstra wrote:
> > > Currently REG_SP_INDIRECT is unused but means (%rsp + offset),
> > > change it to mean (%rsp) + offset.
> > > 
> > > This is somewhat unfortunate, since REG_BP_INDIRECT is used (by DRAP)
> > > and thus needs to retain the current (%rbp + offset).
> > 
> > Offset is going to be zero, should it not work either way?
> 
> For DRAP? I couldn't tell in a hurry. I'm ever quite clear on how DRAP
> works. Some day, when I figure it out, i'll write a comment.
> 
> Anyway, if it's always 0 for DRAP, then yes, I'll change both.

No, what I meant to say is that UNWIND_HINT_INDIRECT is used with no
arguments, which means that sp_offset is always zero.

-- 
Josh

