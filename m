Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60903BD7D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhGFNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhGFNch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:32:37 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 06:29:58 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a11so20709124ilf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TW8wcAmW1BVZHtf7PSR5jLkU2ZPwHh9zsrN0G4Fp5Yg=;
        b=njCuqbMVIqLWE4tRqoECsUECy4JagnCjPp5Wog2d0WaWaafTQEaBW4tC2NxEX3czH8
         0abxRjdZFbN+Lax7PC4i7UJc3hqEw2CZQJ3yG0juvGToqaypBny8Fl6vVBCma9YXKu4x
         qrYSlgdYOObYs4DmEUoI6+DOu4ae2cxvdjHhehpxktNxlRA94540Z5ZXvDAWNcOIFHdO
         UtIrVepGs5+7Qx/LEzJcUdUWVAlvy9jwKzL000RFtaS0N9owUDbVjmUG9qwUnxvnzKJY
         zSsFBrY6+FMrclzoAaIvThQVU3V7HUqUcOO91CBRWmyl/RaNA+s0vEo0lC9i2+IBWlpi
         R7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TW8wcAmW1BVZHtf7PSR5jLkU2ZPwHh9zsrN0G4Fp5Yg=;
        b=JF2ihxraDl5IHoujF6zwzOuy3GA2Ebyb3DeptKexLH9gYwGZ4K42h+aSsSfN/8Ly38
         1eilqdwFxdeaT50fcftHb+1o0nCdYyrlMmTBAN83HNPFUqupNI4VL+IK09UUJo6vRYUy
         GTNCd82mDg5ejprTIytbR7C0hqeIZglf/VltpVmz4FdV2hyp656zQeIy8g/kdnF7dU0F
         7Ixx541pcHN62eKWptxCZO1q9hIOhOS//tdF6d8SDKu22jIZWFybXSP1lkJpOYc4gwL9
         c3MeuevcdalYkwGwMpvdhEuQ1kdYSd7BAP2Q/8gYj8kVohDktMHAj4NxmPa7IMWbi1Em
         ITMA==
X-Gm-Message-State: AOAM53287kJCg3ineQjbCCT9Sf1Ct2ZLV8V9LYj8Z+G8DEKmvHA89wyk
        lTRnSSQO52moQtwrEBiYa1Y=
X-Google-Smtp-Source: ABdhPJwTYed321RXfR2SL6NlCHp3zXTNV0RFZAFMJ4lfSVr+PQojqnhH+hyM6fhUkmInqN3vjRf9LA==
X-Received: by 2002:a05:6e02:5a6:: with SMTP id k6mr1281423ils.213.1625578198004;
        Tue, 06 Jul 2021 06:29:58 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p6sm3435507iop.35.2021.07.06.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 06:29:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A867927C0054;
        Tue,  6 Jul 2021 09:29:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 06 Jul 2021 09:29:56 -0400
X-ME-Sender: <xms:01rkYGL-h6LbzpGNg3I80Ik4fJvF9twDrSxY_DZ0ApL54mCu5iTJcQ>
    <xme:01rkYOJ3wSgcAwdUarBTtNjxn1TsN-e2zduqqWGeTabW51VHwho1Xo6B_BV6foZwD
    ZHucbAIbbX0RL26pQ>
X-ME-Received: <xmr:01rkYGtvzaObCiSMB2I-HmKkDA5AVGPfVADlphbXLwbT9-SRwvQ-OA1ldXuf0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:01rkYLb-GRbQu6VDCPfj7GOSWK2pA12K2KPAas2MZX0oehpD-UX_OA>
    <xmx:01rkYNa79KOyPvD_hcKSyiOjeUf3Gn92-ROQUkJ6pQ0_BHVP3wO27g>
    <xmx:01rkYHDaJO6iOFbcZXJ2h-7fHrfFLu-iUKDjCh8d2Cesi17yCfGHhA>
    <xmx:1FrkYJ6-4OCAI4Nnogly4j4UUmACtv8NAYxeu7pQLP8sbHIt8SZPUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 09:29:55 -0400 (EDT)
Date:   Tue, 6 Jul 2021 21:28:38 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] rcu: Remove needless preemption disablement in
 rcu_all_qs()
Message-ID: <YORahrFT56utjlc/@boqun-archlinux>
References: <20210705234344.104239-1-frederic@kernel.org>
 <20210705234344.104239-2-frederic@kernel.org>
 <YOQLZR3lESyLVkex@hirez.programming.kicks-ass.net>
 <20210706123058.GB107277@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706123058.GB107277@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 02:30:58PM +0200, Frederic Weisbecker wrote:
> On Tue, Jul 06, 2021 at 09:51:01AM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 06, 2021 at 01:43:44AM +0200, Frederic Weisbecker wrote:
> > > The preemption is already disabled when we write rcu_data.rcu_urgent_qs.
> > > We can use __this_cpu_write() directly, although that path is mostly
> > > used when CONFIG_PREEMPT=n.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 27b74352cccf..38b3d01424d7 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -871,7 +871,7 @@ void rcu_all_qs(void)
> > >  		preempt_enable();
> > >  		return;
> > >  	}
> > > -	this_cpu_write(rcu_data.rcu_urgent_qs, false);
> > > +	__this_cpu_write(rcu_data.rcu_urgent_qs, false);
> > 
> > There's another subtle difference between this_cpu_write() and
> > __this_cpu_write() aside from preempt. this_cpu_write() is also
> > IRQ-safe, while __this_cpu_write() is not.
> > 
> > I've not looked at the usage here to see if that is relevant, but the
> > Changelog only mentioned the preempt side of things, and that argument
> > is incomplete in general.
> 
> You're right, I missed that. I see this rcu_urgent_qs is set by
> RCU TASKS from rcu_tasks_wait_gp() (did I missed another path?).
> Not sure if this is called from IRQ nor if it actually matters to
> protect against IRQs for that single write.

I think __this_cpu_write() being IRQ-unsafe means it may overwrite
percpu writes to other bytes in the same word? Let's say the
rcu_urgent_qs is the lowest byte in the word, the pseduo asm code of
__this_cpu_write() may be:

	__this_cpu_write(ptr, v):
		long tmp = *ptr;
		tmp &= ~(0xff);
		tmp |= v;
		*ptr = tmp;

and the following sequence introduces an overwrite:

	__this_cpu_write(ptr, v): // v is 0, and *ptr is 1
		long tmp = *ptr; // tmp is 1
		<interrupted>
		this_cpu_write() // modify another byte of *ptr, make it
				 // 0xff01
		<ret from interrupt>
		tmp &= ~(0xff) // tmp is 0
		tmp |=v;       // tmp is 0
		*ptr = tmp;    // *ptr is 0, overwrite a percpu write on
			       // another field.

I know that many archs have byte-wise store, so compilers don't really
have the reason to generate code as above, but __this_cpu_write() is
just a normal write, nothing prevents this from happenning, unless I'm
missing something here?

Regards,
Boqun

> 
> I'm not quite used to rcu_tasks. Paul?
