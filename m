Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83236AB55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 06:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhDZECO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 00:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDZECM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 00:02:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BC1C611CD;
        Mon, 26 Apr 2021 03:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619409043;
        bh=I9fsr+FCOqT25zb38jORajkZPfS5+6OzhCIRs+NLa6k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MfjmWumHGqNtv0sGFiAuiqxhHxeignubw+vmyMYowInwLgjur5/uBSVyz7umoEd8K
         Wtkvz5UcO59pyMvcw+Be84j7oV3ShwnfgVEuV685AWL9wqVTwyvNidFzbp3OTVX2v3
         yL6lgE6/6Ouol5kIXSKB3ejMp7Eu0bdp7sQTi/Ch+s+umH3W/YdzuJoMKmPv2CYuS+
         XJLd+M67VQr/WL6u4pZJLomZbn7YVI4pwQ8E0DpxL2rYY64JVv39q8r2vFAeUHLr/8
         5IXnCp+Ut8P3qHHl+nNCjkXu3upWCY62NuHAyXrWWHY3MQh48CKIpuCwVqcDRsE7xd
         f+1dsi+mcMaMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1E6BF5C00FC; Sun, 25 Apr 2021 20:50:43 -0700 (PDT)
Date:   Sun, 25 Apr 2021 20:50:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     szyhb810501.student@sina.com
Cc:     stern <stern@rowland.harvard.edu>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        peterz <peterz@infradead.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/memory-barriers.txt: Is "stores are not
 speculated" correct?
Message-ID: <20210426035043.GW975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210426022309.2333D4640475@webmail.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426022309.2333D4640475@webmail.sinamail.sina.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:23:09AM +0800, szyhb810501.student@sina.com wrote:
> 
> Hello everyone, I have a question."Documentation/memory-barriers.txt"
> says:However, stores are not speculated.  This means that ordering -is-
> providedfor load-store control dependencies, as in the following example:
	q = READ_ONCE(a);
	if (q) {
		WRITE_ONCE(b, 1);
	}
> Is "stores are not speculated" correct? I
> think store instructions can be executed speculatively.
> "https://stackoverflow.com/questions/64141366/can-a-speculatively-executed-cpu-branch-contain-opcodes-that-access-ram"
> says:Store instructions can also be executed speculatively thanks to the
> store buffer. The actual execution of a store just writes the address and
> data into the store buffer.Commit to L1d cache happens some time after
> the store instruction retires from the ROB, i.e. when the store is known
> to be non-speculative, the associated store-buffer entry "graduates"
> and becomes eligible to commit to cache and become globally visible.

From the viewpoint of other CPUs, the store hasn't really happened
until it finds its way into a cacheline.  As you yourself note above,
if the store is still in the store buffer, it might be squashed when
speculation fails.

So Documentation/memory-barriers.txt and that stackoverflow entry are
not really in conflict, but are instead using words a bit differently
from each other.  The stackoverflow entry is considering a store to have
in some sense happened during a time when it might later be squashed.
In contrast, the Documentation/memory-barriers.txt document only considers
a store to have completed once it is visible outside of the CPU executing
that store.

So from a stackoverflow viewpoint, stores can be speculated, but until
they are finalized, they must be hidden from other CPUs.

From a Documentation/memory-barriers.txt viewpoint, stores don't complete
until they update their cachelines, and stores may not be speculated.
Some of the actions that lead up to the completion of a store may be
speculated, but not the completion of the store itself.

Different words, but same effect.  Welcome to our world!  ;-)

							Thanx, Paul
