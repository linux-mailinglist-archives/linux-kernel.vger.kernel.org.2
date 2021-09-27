Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF15419809
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhI0PkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:40:23 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:44352 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235213AbhI0PkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:40:22 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 266A819F5C9;
        Mon, 27 Sep 2021 17:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HW+K9MGsOwiuhJGOMR4EWAfWgBQlSS2wTcYbHrTtHxE=; b=jJzJOfWxbEvjiiYQjt7NUT4ufT
        JWVF89e/Ei3VN3Q5K7qVkgzRiuvh6PS3BPfB66zJZXSposP2GNiREwXhFFAK9ZZe+KTKCeKdM3okL
        y50mwzXOUVyMiv5J0sZNxJEdb4KLqNc1hZRzyFHzZFcdPN3/7n/Jc2tcRWSsHVXOSkqU=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mUsiI-0004MJ-PY; Mon, 27 Sep 2021 17:38:42 +0200
Date:   Mon, 27 Sep 2021 17:38:42 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210927153842.GA12620@bender.morinfr.org>
References: <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
 <20210917213404.GA14271@bender.morinfr.org>
 <20210917220700.GV4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918003933.GA25868@bender.morinfr.org>
 <20210918040035.GX4156@paulmck-ThinkPad-P17-Gen-1>
 <20210918070836.GA19555@bender.morinfr.org>
 <20210919163539.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <20210920160540.GA31426@bender.morinfr.org>
 <20210922191406.GA31531@bender.morinfr.org>
 <20210922192448.GB880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922192448.GB880162@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Sep 12:24, Paul E. McKenney wrote:
> On Wed, Sep 22, 2021 at 09:14:07PM +0200, Guillaume Morin wrote:
> > I am little afraid of jinxing it :) but so far so good. I have the a
> > patched kernel running on a few machines (including my most "reliable
> > crasher") and they've been stable so far.
> > 
> > It's definitely too early to declare victory though. I will keep you
> > posted.
> 
> Here is hoping!  ;-)

Things are still stable. So I am pretty optimistic. How are you planning
to proceeed?

The first patch is already in your rcu tree and my gut feeling is that
it is the one that fixes the issue but you're the expert here... Though
I think it should be probably fast tracked and marked for stable?

Are you planning on committing the 2nd patch to your tree?

-- 
Guillaume Morin <guillaume@morinfr.org>
