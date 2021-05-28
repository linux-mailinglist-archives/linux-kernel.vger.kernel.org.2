Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77780393EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhE1Ip7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhE1Ip4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:45:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qocte5ZDDxyg+nBx07Z66plFtADe+KJYZN5F/bbZXMg=; b=qcScMB+S66DxYRxXKRflJuDWII
        /scoQsPaBPBYUP9hX5FVw2+QIfUSWKNFVXsQ0ctUzmluMv30a+VWPZe6TUv9ibOvqcO49yz/Xj2t9
        2LRlM2WxFAGvyIaXtDhRk0ehH2Ma93w+EqrjmtO+rj+QXPm14ftbVVVduZPcRptzFrAPxib3+bTvy
        CVrIW+7m4OiLUB0Vb6+P0BJubDOZZN2R7v0x84d0yWLXvht0lCKodxL0XVGI57mfcLp/h1CNlBWX4
        AoacQoh/lgDm2UxXpiJezQE25KJZFhhtpTP95JI6VgfYXW6Pj+DJzvjrlsUc2AAa/LPjdagbDVD/u
        059JRtmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmY5b-006OiA-4d; Fri, 28 May 2021 08:43:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A580300221;
        Fri, 28 May 2021 10:43:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50B76201DEF05; Fri, 28 May 2021 10:43:23 +0200 (CEST)
Date:   Fri, 28 May 2021 10:43:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Subject: Re: [PATCH 1/3] sched/topology: Allow archs to populate distance map
Message-ID: <YLCtKziUgPTvPh1j@hirez.programming.kicks-ass.net>
References: <20210520154427.1041031-1-srikar@linux.vnet.ibm.com>
 <20210520154427.1041031-2-srikar@linux.vnet.ibm.com>
 <YKaw33d71FpHjGnR@hirez.programming.kicks-ass.net>
 <20210521023802.GE2633526@linux.vnet.ibm.com>
 <YKdr0g6+eIHncqej@hirez.programming.kicks-ass.net>
 <20210521092830.GF2633526@linux.vnet.ibm.com>
 <87k0no6wuu.mognet@arm.com>
 <20210524161829.GL2633526@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524161829.GL2633526@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 09:48:29PM +0530, Srikar Dronamraju wrote:
> * Valentin Schneider <valentin.schneider@arm.com> [2021-05-24 15:16:09]:

> > I suppose one way to avoid the hook would be to write some "fake" distance
> > values into your distance_lookup_table[] for offline nodes using your
> > distance_ref_point_depth thing, i.e. ensure an iteration of
> > node_distance(a, b) covers all distance values [1]. You can then keep patch
> > 3 around, and that should roughly be it.
> > 
> 
> Yes, this would suffice but to me its not very clean.
> static int found[distance_ref_point_depth];
> 
> for_each_node(node){
> 	int i, nd, distance = LOCAL_DISTANCE;
> 		goto out;
> 
> 	nd = node_distance(node, first_online_node)
> 	for (i=0; i < distance_ref_point_depth; i++, distance *= 2) {
> 		if (node_online) {
> 			if (distance != nd)
> 				continue;
> 			found[i] ++;
> 			break;
> 		}
> 		if (found[i])
> 			continue;
> 		distance_lookup_table[node][i] = distance_lookup_table[first_online_node][i];
> 		found[i] ++;
> 		break;
> 	}
> }
> 
> But do note: We are setting a precedent for node distance between two nodes
> to change.

Not really; or rather not more than already is the case AFAICT. Because
currently your distance table will have *something* in it
(LOCAL_DISTANCE afaict) for nodes that have never been online, which is
what triggered the whole problem to begin with.

Only after the node has come online for the first time, will it contain
the right value.

So both before and after this proposal the actual distance value changes
after the first time a node goes online.

Yes that's unfortunate, but I don't see a problem with pre-filling it
with something useful in order to avoid aditional arch hooks.


