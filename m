Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9D329FA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhCBDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhCAUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:45:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F1EC06178C;
        Mon,  1 Mar 2021 12:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YUYva8CDKxOpu0p3oNxBRvTwbXZx6qUfbDB3s9PPyW0=; b=RfOvodCj29KghMJ/VGhTiCzKRs
        m3LmQu48Rw3Wt5ddU7QJdT3pCxtvtPc0d/ZOv0OmmeukNxcPn/drNczbsQ6OOdVpmIpzvL119t/vD
        rilYZWkEANXFOJXRQCS80EgM7SFFhTx+ecs2gnBW1n+/Pn2l9+ettoux/280S0NAn3rSz34mmEJOd
        lIAAvHvP9nHab+HQNvzneWPZXag+rOrtVVqhBJr7NB/pcwKKot7clj4FYTep/RQEW+8HlJ164KKGG
        ozhUhVMIny2r5F6crHA43u06q+r1Y1zafmreylIDncHsZtbwOC4dafC7f01LZdAM01x67Slt/m2ob
        5W1Xa7uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lGpOy-00GCkN-N3; Mon, 01 Mar 2021 20:44:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 509F83060C5;
        Mon,  1 Mar 2021 21:44:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 437222215BD3A; Mon,  1 Mar 2021 21:44:20 +0100 (CET)
Date:   Mon, 1 Mar 2021 21:44:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <YD1SJNDeGcNOO00s@hirez.programming.kicks-ass.net>
References: <20210301101336.7797-1-jgross@suse.com>
 <20210301101336.7797-4-jgross@suse.com>
 <YD0fTLnQTQ7/M7fx@hirez.programming.kicks-ass.net>
 <c7c1eeb5-21b3-339b-4b25-a6c8df820146@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7c1eeb5-21b3-339b-4b25-a6c8df820146@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:16:12PM +0100, J=FCrgen Gro=DF wrote:
> >    https://lkml.kernel.org/r/20210220231712.2475218-2-namit@vmware.com
>=20
> They are already in tip locking/core (Ingo applied them).

I'm very tempted to undo that :-(
