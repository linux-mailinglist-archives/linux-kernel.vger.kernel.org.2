Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD1843C783
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbhJ0KVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:21:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:56455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232533AbhJ0KVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635329904;
        bh=0/xQALMRmDMXg28cl7m2Q8kQ0DMZEqmZ9WnjNozXkKY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IfjaCIxyVScwaWY9tG/6eRou8+pIIGvV6kCwtIGTYeh53wMnUj3L4XQkNomFwTN2e
         vQn20zgpVboEfBdhYoxabiPC1rY/hHKmpvinyJLn1MC4/kS0X8YYx2kYoGkVfyCJOJ
         VmbJ2i5Df7osmYz6VY4Mwi8/YcihLjK82CX3wAqU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.126]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1mq11L2WYx-011fyR; Wed, 27
 Oct 2021 12:18:24 +0200
Message-ID: <e5c43bbf7ff6c9c9ba5ac5d0a2b8a981e2abf96e.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Oct 2021 12:18:22 +0200
In-Reply-To: <20211027090020.GO3959@techsingularity.net>
References: <20211021145603.5313-2-mgorman@techsingularity.net>
         <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
         <20211022110534.GJ3959@techsingularity.net>
         <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
         <20211026081817.GM3959@techsingularity.net>
         <4105fd08f84c60698b38efcb4d22e999de187d6e.camel@gmx.de>
         <b53de0da7c863ec4c883a92b2526a0f9132a24cb.camel@gmx.de>
         <20211026115707.GN3959@techsingularity.net>
         <65e20ad92f2580c632f793eafce59140b8b4c827.camel@gmx.de>
         <93033bdc35fb2ddd374700b76324de88639ef5ae.camel@gmx.de>
         <20211027090020.GO3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NWJFT/8n7JuoCprytQiCxEM/iiCQ/FNXAllKX3ifdyx8CKmNhTL
 xtEnGoSAWHeOrOwwjUp/VzcZMHcviWpUIr/vjIS1lHvX2w9gPieIc6BfzWI3pVxf7/8jwKc
 ruYXG95jM2MYXnfXRpSwdVTzBu9Y5LQIjJW/CbgEKqD1es5MhKTVqJjHtq2YEdSCVHn4COa
 Jtu+rUIurjDd3Ld/IzEOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ul/76pTy9Xo=:2CYFfdmmKTMFBGWHpQfkMu
 KACi/agJWiPfXc0A7sGXhAGevyBIaQOItzUr5ddDoELLPtP3opyw/QpgjYRrNOl9KNhfJgiag
 ZwlguQl4yStbv8CuJOj9fYCa+9OxLY/+C8A7LZXtK/OHCGBWUXjHDEBpF5e/nCAZZQpgAl07j
 wuRROyyaOdRPKKKLT71bVMkXB5X/IjGY9toQHPIG3+TYmh3bj+A7+ZOHXuDjU4wioc7Xw9Rg8
 49BgjpBvj7PT/82fpTpkbU4lDq67e2hQqmIwbKratrJ3q7izdyLFo+BHc8yiD0Mw46WqVYHoh
 ETzpuAX4Gd5/vuxDTknsvHEQ2XHtpVrKJmTTMnoF5J8Lw2vimQo2fFFASj9HIZIv5x9EowMEO
 C3CuoiJ4U4qRCI4cz/fVd8VsCkE8/yVaZNLtlRTL76rnGqT8OR7nPCprhHATZI4ckXPSn9QjL
 cbnxRriOOoPgGs9fChYRSyVQKNnqMJIVlKxAP1K5yRUIvCx5uiPqNcg0vCyXRmO8VMLz5gCIu
 8TjHu+3og2SM8TmjYNaXHt48dnVckWR1sS+YvBCtTFUqrurzf+OwAilLvRMlVU0dWk9w5k/j0
 oWpxGa5WfEXZBG8ikW3COkBTEsnQescvWyiEam1PwKWQRkbsbVD54Oe4DiZQ+4EFbYeP/XTM/
 /b7d4Jo+UoIdVikinUy1OZH9i6PQH/xYIhB96xkV32/D890XMBIZpdY8hgYCV7+MgXt8rzOFP
 /7Fvz/nj//gLH7bWdyXQCBlBJEid7R1B9OGKoUPm99ebhLull1Fx2sMLn9xX/LgBko0S9xS0F
 i8m0B0YwpyFzB09RdSqQ6kw+kjrqoBea3VRZKRqLmKRzbfsDD60Pe/YooJF1LWo94hQ4EtlRe
 2WQQ7icXpgH/iTHDxZNE2WT6oKWU0R7SUJNS8MUkiaGfxuV6Iy1qto3mOnaJAVjtp0Fh/kLoa
 6l3EmOjUDqbyOVRqQHa1nkFOjzuysXhGRRjziM0n+oSmZm/g0Xa+IEhAietR3kJtrv2FYHJCP
 bS1GiSGSmIDmb7qxjmuvBtvsyPpqfqLptq56d/LuOoGgVN9EGT83n/MNH3U6UMEMCH3M2pkxi
 EmPygjMJGHXxzQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-27 at 10:00 +0100, Mel Gorman wrote:
>
> How about patch 2?

This version doesn't slam the door, so no worries wrt kthread/control
thread latencies etc.  Doing a brief tbench vs hogs mixed load run
didn't even show much of a delta.

	-Mike

