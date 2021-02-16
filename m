Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5431CAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBPMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBPMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:45:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HNYmnnE9hb1DpR2jiQ0nTh4E9QMSHiebWiR28sDe+fQ=; b=qDP1DNL9S9JUpchSescIXHPbsf
        fGWVtYNyG+lQshEOOoNzXk1hmcZEgKyXDTzjc1sMEGqJb07ZcDfFtIJVEdF9LO40LuDRNi2oqg8Rx
        dpNon6nLKF4JtxTQZUL1jAqM6g8Tfa435NGz0LnGlyQE1+eL6r+6Uq3MSsNaudpcOvbOSTLuJV/OD
        pY0ZfpQEB/6hHIaiEXA95+hPYCpKULQim3jg/OFn7Njjd4J/oHcxP5D11crSkdtf4b/LGYpCCrKyi
        n5GcMImT/XNAg00xla2L3UJT3B8lWfnhc0hPGKwZHzrEi05+LsuLQQxX7XxUFQIHbBTEjtwTC33+F
        wnSnCdyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBzi1-00GrhA-Jz; Tue, 16 Feb 2021 12:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 342863003E5;
        Tue, 16 Feb 2021 13:44:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BAC22BBF4D2E; Tue, 16 Feb 2021 13:44:05 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:44:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     mingo@redhat.com, will@kernel.org, apw@canonical.com,
        joe@perches.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mutex: nuke mutex_trylock_recursive
Message-ID: <YCu+FWMXsX6Mfs5T@hirez.programming.kicks-ass.net>
References: <20210216082146.69286-1-christian.koenig@amd.com>
 <YCuQXAllh91JEZ+Y@phenom.ffwll.local>
 <YCuaup4u1ZE6crE0@hirez.programming.kicks-ass.net>
 <e8374454-4c2b-b718-a0fc-0e25662c3f44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8374454-4c2b-b718-a0fc-0e25662c3f44@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 01:38:49PM +0100, Christian König wrote:
> 
> 
> Am 16.02.21 um 11:13 schrieb Peter Zijlstra:
> > On Tue, Feb 16, 2021 at 10:29:00AM +0100, Daniel Vetter wrote:
> > > On Tue, Feb 16, 2021 at 09:21:46AM +0100, Christian König wrote:
> > > > The last user went away in the 5.11 cycle.
> > > > 
> > > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > Nice.
> > > 
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > 
> > > I think would be good to still stuff this into 5.12 before someone
> > > resurrects this zombie.
> > Already done:
> > 
> >    https://lkml.kernel.org/r/161296556531.23325.10473355259841906876.tip-bot2@tip-bot2
> 
> One less bad concept to worry about.
> 
> But your patch is missing to remove the checkpatch.pl check for this :)

The next patch does that, look at the "Thread overview:" at the bottom
of the things.
