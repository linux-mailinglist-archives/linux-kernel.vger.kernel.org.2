Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C077A35A18E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhDIOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:55:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60535 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233687AbhDIOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:55:49 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139EtO36030262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 10:55:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36D7A15C3B12; Fri,  9 Apr 2021 10:55:24 -0400 (EDT)
Date:   Fri, 9 Apr 2021 10:55:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] bit_spinlock: Prepare for split_locks
Message-ID: <YHBq3Lutxdfz6qyq@mit.edu>
References: <20210409025131.4114078-1-willy@infradead.org>
 <20210409025131.4114078-4-willy@infradead.org>
 <YHBlj3AjYbQHfsc0@mit.edu>
 <20210409143555.GV2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409143555.GV2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:35:55PM +0100, Matthew Wilcox wrote:
> > This changes the function signature for bit_spin_lock(), if I'm
> > reading this correctly.  Hence, this is going to break git
> > bisectability; was this patch series separated out for easy of review,
> > and you were planning on collapsing things into a single patch to
> > preserve bisectability?
> 
> It's perfectly bisectable.
> 
> Before: bit_spin_lock takes two arguments
> During: bit_spin_lock takes at least two arguments, ignores all but the first two
> After: bit_spin_lock takes three arguments

Ah, got it, thanks for the clarification!

					- Ted
