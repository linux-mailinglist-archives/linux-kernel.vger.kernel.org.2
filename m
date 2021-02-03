Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75FE30DD35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhBCOuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhBCOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:49:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CEC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q5yIzcjFFGMD5Gmak358b/nkkqOjGxCgXaPOO2AW0ms=; b=lesWGBdhwB2V0dWkJr6332TBUR
        MHt/e+LE+gcSRU8YnKGTPi1knVebEeFym8hGMeB3hKl/BI+wMn4S6A4RuAV4CK43/QaqElQsop8BH
        L0K179MfOZ5ozdcSkiyS/OO1HDYcAfu8soL6l5i6lMXzP4MKzztY4hZfbuMVVN0cAUhfNMdFiKvrs
        i+/h75ie7zkK4f4l3N7iZGTNCL2KJDtW9V35gu7HcOURERJ61WL+WYHTPzBayHiVTxFdHR+HJZ5nd
        zpgrXHkszj5Lo558C+hyVYavCpsHK6wfj06TzpUbPRQ+oi/PHs4n5gL00n53ixxM3E5Qoh2dkYUG2
        +m7kTFmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7JSo-00H38b-SL; Wed, 03 Feb 2021 14:49:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8850030066E;
        Wed,  3 Feb 2021 15:49:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7337120C633CC; Wed,  3 Feb 2021 15:49:02 +0100 (CET)
Date:   Wed, 3 Feb 2021 15:49:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] objtool: Change REG_SP_INDIRECT
Message-ID: <YBq33lMgoUOnCXPW@hirez.programming.kicks-ass.net>
References: <20210203120222.451068583@infradead.org>
 <20210203120401.062155900@infradead.org>
 <20210203144215.4ledy6srx7zwfxde@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203144215.4ledy6srx7zwfxde@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 08:42:15AM -0600, Josh Poimboeuf wrote:
> On Wed, Feb 03, 2021 at 01:02:23PM +0100, Peter Zijlstra wrote:
> > Currently REG_SP_INDIRECT is unused but means (%rsp + offset),
> > change it to mean (%rsp) + offset.
> > 
> > This is somewhat unfortunate, since REG_BP_INDIRECT is used (by DRAP)
> > and thus needs to retain the current (%rbp + offset).
> 
> Offset is going to be zero, should it not work either way?

For DRAP? I couldn't tell in a hurry. I'm ever quite clear on how DRAP
works. Some day, when I figure it out, i'll write a comment.

Anyway, if it's always 0 for DRAP, then yes, I'll change both.
