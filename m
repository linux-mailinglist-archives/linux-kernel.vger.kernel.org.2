Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE13705DD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhEAGO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 02:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhEAGOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 02:14:25 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619849615; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=xPSpvQ0vttQgx8vc8QjpV7QF/EF3iUal+uGRHaKvlj0=;
 b=jUnjHtkSxb7nb0OZ37iv4gYEshItyzYBHm0FDbN9mDJnhcmm06HsKu9mZcZ96rnLKXig5
 WWSAj6zduZ8qM/CBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619849615; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=xPSpvQ0vttQgx8vc8QjpV7QF/EF3iUal+uGRHaKvlj0=;
 b=WeoTKebCC/3VeDmCMTrygVvWJTQDvus+H+s7pfqy9UhH1vWDDireyvUoYtWmbsXxsmTP/
 vZa0ESgLCFh440zJozXX3aFbZYsusiwe0fq5cuY8vpf32j7Waeio7/m48knfyfFPMQxeP8a
 tfeKYP33OjoEBHaxBjWVJc6lAaiUrD8unRfsTyVVcp2+NOSsyY0ppkcboyhLhn7fASdFR3j
 HV+oPzAVlan6uidHPIk6iwo3N/wE0gI4CJZi4GIsVMB/Nqd8eZRQk5IirQX4alENP3yuL0B
 VKtR6Sner2DIgp/Q24MwT0+nMpsFcjM5fBLYVHV1IJgXN/4x/sPtKOJCnvAg==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id E0F29160324; Fri, 30 Apr 2021 23:13:35 -0700 (PDT)
Date:   Fri, 30 Apr 2021 23:13:35 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 94/94] mm: Move mas locking outside of munmap() path.
Message-ID: <20210501061335.GD5188@lespinasse.org>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-95-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428153542.2814175-95-Liam.Howlett@Oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:36:32PM +0000, Liam Howlett wrote:
> Now that there is a split variant that allows splitting to use a maple state,
> move the locks to a more logical position.

In this patch set, is the maple tree lock ever held outside of code
sections already protected by the mmap write lock ?

--
Michel "walken" Lespinasse
