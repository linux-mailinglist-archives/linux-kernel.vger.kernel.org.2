Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF06041E56F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351058AbhJAAPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbhJAAPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:15:31 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81554C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:13:48 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t15so6326516ilj.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rz3iVRNrBx6QCCFEtqMwWXAspi2yN/SPUIz5zbJgxkk=;
        b=d9EJ5JQMwQiweXF6S2yHw5181ORUgUfFdM32d93l9AdBRJwKwPb7iLTvcrN3ANpnOD
         F7T6CvFYnz+hbc6aGo++GLW8WtM0rrrnpxrR2pbc7LmwouHuUT4EEx7kFJffayeGq3Nh
         Sc2h3iC/zKayR8i+I+GSDSrPeiALkvBjZ5FLkKy1yj14AXU+aUs9rmA150WI+mzkBePd
         TmBDcGjuieXFbTqXI1Yt0PA12VvYJn6ftD44A3yybQr1xd5Fq9WRkPjeWY7s/SbfB0kR
         n399J7c6YspdJURSLvybkwVJQJ15ygzt4sqzFj5Owi6lyqMxAGUd/bLRkWFi0j3vEmlN
         71wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rz3iVRNrBx6QCCFEtqMwWXAspi2yN/SPUIz5zbJgxkk=;
        b=ViOnb7bQzIpfeaR4YK7xwrEQui94eDXNz9ZJ4Wu8TN+m5SZeiDgRoiJP/uEb55n6wY
         YvNKkMhCuKNJ1g2gw9KK/BonojSwe6NEOZCF7xtrnaCMesb6Too/ljI4mdtdFTsdq/B5
         Bi4MDXrLWPrO8tP8UeAZPVs69fq6dF+hLgPmReRyd5OydMyPFTifsdFjg9WQ6XIU4K++
         rpgktuqENnJX53L99WbxXM+p6Pz+uHzUN3vjHSKO6LI2ZpCjaLBMHNx/EkTV4SOQSR2A
         CqOFCELj+YHrVU0Lu/7tRjmoMJhP90xiEcCFP2wdjH7zh61vWi1zajqURO+St30W73Pt
         Y7vg==
X-Gm-Message-State: AOAM533nHBpgCAO+to8VeW5DnDR0R6FXhF0WK9pyMSlDpCAsV5RWy3xA
        lPi8tkCjsFSB8/MOtRQQa/4=
X-Google-Smtp-Source: ABdhPJzgA62JGGuqF1PfsgFyV9XcLBA9QXONH/ptEuk97iELMxWagJ+rJcKzeyQrRsWqt61uZP/qoQ==
X-Received: by 2002:a05:6e02:194c:: with SMTP id x12mr6147767ilu.128.1633047227950;
        Thu, 30 Sep 2021 17:13:47 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id u18sm2449265ilj.24.2021.09.30.17.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 17:13:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8809C27C0054;
        Thu, 30 Sep 2021 20:13:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 Sep 2021 20:13:45 -0400
X-ME-Sender: <xms:t1JWYeOWQ_xKIwIfjW-3zyr7zRc6glLHO0H31m-f4_Dxb190M3SDPQ>
    <xme:t1JWYc9MkV2mqEsbZct9VK2kCZNyJtDuUKdGHo_1btUwblvJPsPQh-64vYY9xsklz
    ZtBtIMwbjwXi6tqQg>
X-ME-Received: <xmr:t1JWYVQGFKojTBckxPOyJi1KjJTXbMpU-_IMwA1WqlA75Mg5-TcEY-v9Q6zUzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekhedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:t1JWYeuViVqJhRaJmUTAGrXRW4iwndhUPiGbS1MApi6IzZa16FVa_Q>
    <xmx:t1JWYWe7LWQuxIdIUXPcPU2b__wsR4_Q4ls_OXyS1rKU0NB1lTXDFw>
    <xmx:t1JWYS3xsVPKJyDFmt1cclhfKGL-6wWkv57NWlgwPATjRuWOTb9kxA>
    <xmx:uVJWYZVABsTJi39GGgKhO3UOhBkneGpVp3Tt3OSE6uJn8HFnQ4DZBPjuVAo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Sep 2021 20:13:43 -0400 (EDT)
Date:   Fri, 1 Oct 2021 08:12:56 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au
Subject: Re: [PATCH] tools/memory-model: Provide extra ordering for
 unlock+lock pair on the same CPU
Message-ID: <YVZSiCFAc2RdmeD9@boqun-archlinux>
References: <20210930130823.2103688-1-boqun.feng@gmail.com>
 <20210930152033.GD464826@rowland.harvard.edu>
 <20210930181753.GH880162@paulmck-ThinkPad-P17-Gen-1>
 <20210930204634.GB482974@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930204634.GB482974@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 04:46:34PM -0400, Alan Stern wrote:
> On Thu, Sep 30, 2021 at 11:17:53AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 30, 2021 at 11:20:33AM -0400, Alan Stern wrote:
> > > On Thu, Sep 30, 2021 at 09:08:23PM +0800, Boqun Feng wrote:
> > > > A recent discussion[1] shows that we are in favor of strengthening the
> > > > ordering of unlock + lock on the same CPU: a unlock and a po-after lock
> > > > should provide the so-called RCtso ordering, that is a memory access S
> > > > po-before the unlock should be ordered against a memory access R
> > > > po-after the lock, unless S is a store and R is a load.
> > > > 
> > > > The strengthening meets programmers' expection that "sequence of two
> > > > locked regions to be ordered wrt each other" (from Linus), and can
> > > > reduce the mental burden when using locks. Therefore add it in LKMM.
> > > > 
> > > > [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
> > > > 
> > > > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > > Alan,
> > > > 
> > > > I added the "Co-developed-by" and "Signed-off-by" tags since most of the
> > > > work is done by you. Feel free to let me know if you want to change
> > > > anything.
> > > 
> > > It looks good to me.  However, do we really want to add these litmus
> > > tests to the kernel source, or would it be better to keep them with
> > > the thousands of other tests in Paul's archives?
> > 
> > Either way works for me.  But if they are referred to from within the
> > kernel, it is best to have them in the kernel source.  Which might be seen
> > as a reason to minimize referring to litmus tests from the kernel.  ;-)
> 
> In this case the litmus tests are not referred to within the kernel 
> source.
> 

I'm OK to drop the litmus tests, but the reason I add the two litmus
tests is that they directly describe one of our memory model rules. The
two litmus tests tells developers "you can use unlock+lock on the same
CPU to order READ->WRITE or WRITE->WRITE", so they are kind of part of
the manual of our memory model. Thoughts?

Regards,
Boqun


> Alan
