Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954FA31C890
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBPKPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPKP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:15:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00144C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 02:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=XZQnqYULb/gl4wKI0dnM+AVrQ2LyQklzX1J3h5QDRII=; b=TPdPeYYTIHFKdHhMA6FBieZUR1
        56rbc/Q+FobY51DRosYrVPsDsPUKaKfVkfCJSIwJXKCZQ77xp479j3hu7yH8woN7IGjBt7Hk2vioi
        xeV71s19Hq9mFL4YECb49KzYcMpPQcR0hPDmezYW4qgzpG3NWHU9a8/ksFxp3+vSjK6mUjegvrn1y
        11FJp3d04ADNvoLcMqdIV/30/2poIIQwsF8TXl8sr01svS4u4xiDxrI+POR0z27yhi9qbFAUI5kMM
        /ymHv9eU/yUjU8bIh1l2hXoaydgNF5q1MMOw3ycZ5k6l8KumXn86c74ODr2VBJTX7JcaFDWsY2WCL
        UiDNQB5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBxM2-00GjfB-Sq; Tue, 16 Feb 2021 10:13:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F0DF3011E6;
        Tue, 16 Feb 2021 11:13:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A8112058B522; Tue, 16 Feb 2021 11:13:14 +0100 (CET)
Date:   Tue, 16 Feb 2021 11:13:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, mingo@redhat.com,
        will@kernel.org, apw@canonical.com, joe@perches.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mutex: nuke mutex_trylock_recursive
Message-ID: <YCuaup4u1ZE6crE0@hirez.programming.kicks-ass.net>
References: <20210216082146.69286-1-christian.koenig@amd.com>
 <YCuQXAllh91JEZ+Y@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCuQXAllh91JEZ+Y@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 10:29:00AM +0100, Daniel Vetter wrote:
> On Tue, Feb 16, 2021 at 09:21:46AM +0100, Christian König wrote:
> > The last user went away in the 5.11 cycle.
> > 
> > Signed-off-by: Christian König <christian.koenig@amd.com>
> 
> Nice.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I think would be good to still stuff this into 5.12 before someone
> resurrects this zombie.

Already done:

  https://lkml.kernel.org/r/161296556531.23325.10473355259841906876.tip-bot2@tip-bot2
