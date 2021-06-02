Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37A03994D4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFBUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:51:52 -0400
Received: from server.lespinasse.org ([63.205.204.226]:53013 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBUvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:51:52 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-18-ed;
 t=1622667008; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=wZSLmJuPNLOP2qajTfRR0wx8clik8apNZqIGUoT6zfs=;
 b=HRnLOjikf+ulqbOwZ6bQo1E/sO1gkW+64apy+OS8ERPlU4VcywnAy8ZGOCF4sBVs8M151
 a9bSC097wzUMDiOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-18-rsa; t=1622667008; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=wZSLmJuPNLOP2qajTfRR0wx8clik8apNZqIGUoT6zfs=;
 b=BsXqBPw307Q9WU+zvWt9zUhlAG617bFrMvSXH0gfMuJ2GryXfjKC9W0kD8sU7A3PAnrUo
 M28T4Jb93f/zciafctYMKJ9K8XEO9WRHyqFgiZ+f9gRKZFG6wiDp/+yqhm54bP24YoTrFPP
 WBZ/inVCDNOywHVkN0OGWaxBEWrm8k+3aEIupydWV1giZjwXVldfusD6bjfrw93o2I/Q1tV
 UcHaBbbnbATD3+/v1XGbeEHceeylPzl/QuvK3EIV10GvgAIUkvb9JCR3KPp8VygMrNH5ure
 JO49NRbnSzSrH9mpqm9L5/Mi9QWFVo5oO1UC5v97grBMHaI0bPceHbHRAswA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 2081616078E; Wed,  2 Jun 2021 13:50:08 -0700 (PDT)
Date:   Wed, 2 Jun 2021 13:50:08 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] rbtree: repair some kernel-doc whining
Message-ID: <20210602205008.GA8615@lespinasse.org>
References: <20210602062542.8188-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602062542.8188-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 11:25:42PM -0700, Randy Dunlap wrote:
> Clean up some kernel-doc warnings and use the documented
> Return: notation for function return values.
> 
> rbtree_latch.h:64: warning: cannot understand function prototype: 'struct latch_
> tree_ops '
> rbtree.h:343: warning: Function parameter or member 'node' not described in 'rb_
> next_match'
> rbtree.h:343: warning: Excess function parameter 'tree' description in 'rb_next_
> match'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> ---
>  include/linux/rbtree.h       |   14 +++++++-------
>  include/linux/rbtree_latch.h |    2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)

Looks fine to me, thanks!

Acked-By: Michel Lespinasse <michel@lespinasse.org>

--
Michel "walken" Lespinasse
