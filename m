Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5611371F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhECSMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECSMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:12:17 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D97C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1620065478; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=8QAzgcLcfOhBS/UmKEur87fyiT1U9pVQU00I/q7tLbk=;
 b=KmCtLmriwnj5Uv+bGnVT5elfkvv25CS/+N+m2NsTridlN1+DO1Nm35FesY/eQWlsskFKn
 jdjldU9dZhwQEgpBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1620065478; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=8QAzgcLcfOhBS/UmKEur87fyiT1U9pVQU00I/q7tLbk=;
 b=fKWQKT2CguXliWQEIWigsVq4nkHC4u0vOyUxpXvX7Y5EmViDyrT+gyYXLZFfwGTM7mEgt
 i3GaBrCSbbHrtMZm0FuhW1sAycQ83tQJ10cGlCKVP7TVsZbR+sTv7i7oKHvRrv6WRBTV/ML
 4FBmDPZzMIzxetQhRMhJbfFCqpInNN4xDAMWNH2QiUMkgxhByMC+05NotR7cZweBw4PvTxx
 muJZm+idx9+V7cEy2KiDMujxVugsj4QaDzywoahBihoHppk4I7asnvjrbVXTqj/o2jW6SAl
 wYtVj/EwPKXyvRAnhh96Z2Y4ovI3F3JltnQMoIE9kI+YGoNjusi5hkX+PKAA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 659A5160056; Mon,  3 May 2021 11:11:18 -0700 (PDT)
Date:   Mon, 3 May 2021 11:11:18 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
Message-ID: <20210503181118.GA21048@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
 <20210430224649.GA29203@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430224649.GA29203@lespinasse.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:46:49PM -0700, Michel Lespinasse wrote:
> I- Maple tree
> 
> I do not think there is any fundamental conflict between the maple
> tree patches currently being considered, and this patchset.
> I actually have a (very lightly tested) tree merging the two together,
> which was a fairly easy merge. For those interested, I made this
> available at my github, as the v5.12-maple-spf branch.

People were still confused about it, so the instructions to fetch this are:
git fetch https://github.com/lespinasse/linux.git v5.12-maple-spf

--
Michel "walken" Lespinasse
