Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA435A11C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhDIOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:33:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56089 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231946AbhDIOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:33:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139EWmYC019758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 10:32:48 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0A5C315C3B12; Fri,  9 Apr 2021 10:32:48 -0400 (EDT)
Date:   Fri, 9 Apr 2021 10:32:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] bit_spinlock: Prepare for split_locks
Message-ID: <YHBlj3AjYbQHfsc0@mit.edu>
References: <20210409025131.4114078-1-willy@infradead.org>
 <20210409025131.4114078-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409025131.4114078-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:51:17AM +0100, Matthew Wilcox (Oracle) wrote:
> Make bit_spin_lock() and variants variadic to help with the transition.
> The split_lock parameter will become mandatory at the end of the series.
> Also add bit_spin_lock_nested() and bit_spin_unlock_assign() which will
> both be used by the rhashtable code later.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This changes the function signature for bit_spin_lock(), if I'm
reading this correctly.  Hence, this is going to break git
bisectability; was this patch series separated out for easy of review,
and you were planning on collapsing things into a single patch to
preserve bisectability?

					- Ted
