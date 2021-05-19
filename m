Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F1388628
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhESEwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhESEwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:52:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A2C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:50:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t20so9260064qtx.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHbccBU9IRXs2xtFkBTkzqPe/xGXz7IwTFv0ptmDULM=;
        b=Edf6wPi6a7Vx2OFQLinBcRoKNZAy9DrvPcHoLuxoEOD3EE4RE/LkU3OJFqPCzie8bD
         JotdzILXMwGMTUkm2tcVFtbo0aAb2B05BUOS0g4tDJvwlnZe76LHmmeZXBdz8zmPfH37
         AywGZy2XSYYhQm59DaB1h+eiCzZSHzlham1+s6ngkvg96R/xF2pKgU89ubZMxGZP9nco
         vBvrS0EAfhOrSoXXU4kKzDDglUfEsAZ9k6k4/8N/H0v+L+V5cbC3zqFz1D1uXsB6CIpA
         hcbjuV9tRMffHxyHVMBV3YUrPjFdaB7bYQNVu0B43YU9ibN+ezK+hlekdzaDA+17fJxn
         n71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHbccBU9IRXs2xtFkBTkzqPe/xGXz7IwTFv0ptmDULM=;
        b=iUggJyzvQ+mD1auaUHhr7VMxUUTnRvo34FNMyjl3Ida+0sojSFVBgGAqam0EfNy5wp
         eCQIBt6HyjguZMllDfJdaD2YTFdYvcd9sCTrNTkZ2TAyo1DBIySlucFGvPqoAlGPbXb6
         OeMnrc7Q9XkjmzVluL1LN3A7Ijrlha3T6ruQO1vePB4foy531qCDEnRdDYBn/6rPKHDj
         DSrDLE2luNt6TBi/+k4eBPgKexrMdJY8L5YFdj+JzrKjH9iF/9PvKzyBAe3/9DZ6T9zT
         OSX17j5jiyN4fwl+B9v6fgjbMRbsNXcCSuvuaraFk8fRrUA9R0mxeoIA4O1ybvTbvH78
         nVcw==
X-Gm-Message-State: AOAM531+TcJsmsehBAZS0HmiYuUDoZiU45PdrPKd7VWQtJ4Dmwc36KP0
        dlj7TGdBJhN45yy2VhERzYU=
X-Google-Smtp-Source: ABdhPJwnau4qg2SQ8W2Ab4nYoGg/fps4SlStpKqP3ZOSp0HP/vRoJrL3tuIA7PEq3TsDtaIK4a5V2w==
X-Received: by 2002:ac8:a49:: with SMTP id f9mr9089853qti.157.1621399851252;
        Tue, 18 May 2021 21:50:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a131sm2855574qkg.99.2021.05.18.21.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:50:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id CBE5227C0054;
        Wed, 19 May 2021 00:50:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 May 2021 00:50:49 -0400
X-ME-Sender: <xms:KJmkYDlgvd6z9gZwNMtrCRVtk6_dRlJ6_XN-t46M8HU4V6CJiLgw9w>
    <xme:KJmkYG1Kl2XNpn9HVZEBGdh41Yg5wZTf8QkmBZxy1mvo_x7QA31INAtphpSY_d5yp
    x5d3_UsbxGHI0hhxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeikedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepudejtdduudevheeltdekhedvkeegtddtjeeffffgjeegfeetkeeuueejhfdu
    gedunecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomhenucfkphepudefud
    druddtjedruddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:KJmkYJr2JEgilToiLSweF1hMLO91qln9egQKZ7f-7nB5ar660On-mQ>
    <xmx:KJmkYLnHJhQwcBXB728xUEOqjh-0HQ8sXBQwiZwapCzVEuREcr9azg>
    <xmx:KJmkYB0EwzRea2PW7oRSW2ftCKNa4OMTAOv5LeeuOJkqViBXyCL7SA>
    <xmx:KZmkYMTCIlFN_Jt6AD49GPBqrN-9rEUimoMsXrJt-1AkNQMlr1JLFWvObyk>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 19 May 2021 00:50:48 -0400 (EDT)
Date:   Wed, 19 May 2021 12:50:27 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: Silencing false lockdep warning related to seq lock
Message-ID: <YKSZE1HfOk1nh/5A@boqun-archlinux>
References: <CAJWu+orW9PA7m_s5LHhQv-bEO0xFq7n+9-fznd79boKkmQUR6g@mail.gmail.com>
 <YKHvUkxpytzSewEC@boqun-archlinux>
 <YKMd99hE78xdUkQk@google.com>
 <YKMlWIPMLFU0vzF6@boqun-archlinux>
 <CAEXW_YTiL_hsqw9f0fiXWYen8i8R=Uj+eYM8tBaV-K6Hw1CRSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTiL_hsqw9f0fiXWYen8i8R=Uj+eYM8tBaV-K6Hw1CRSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:53:57AM -0400, Joel Fernandes wrote:
> On Mon, May 17, 2021 at 10:24 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > [...]
> > > > > After apply Laurent's SPF patchset [1] , we're facing a large number
> > > > > of (seemingly false positive) lockdep reports which are related to
> > > > > circular dependencies with seq locks.
> > > > >
> > > > >  lock(A); write_seqcount(B)
> > > > >   vs.
> > > > > write_seqcount(B); lock(A)
> > > > >
> > > >
> > > > Two questions here:
> > > >
> > > > *   Could you provide the lockdep splats you saw? I wonder whether
> > > >     it's similar to the one mentioned in patch #9[1].
> > >
> > > Sure I have appended them to this email. Here is the tree with Laurent's
> > > patches applied, in case you want to take a look:
> > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4
> > >
> > > Yes, the splat is similar to the one mentioned in that patch #9, however the
> > > first splat I appended below shows an issue with lockdep false positive -
> > > there is clearly problem with lockdep where it thinks following sequence is
> > > bad, when in fact it is not:
> > >
> > >     init process (skipped some functions):
> > >     exec->
> > >      flush_old_exec->
> > >       exit_mmap ->
> > >         free_pgtables->
> > >           vm_write_begin(vma) // Y: acquires seq lock in write mode
> > >              unlink_anon_vmas // Z: acquires anon_vma->rwsem
> > >
> > >     exec->
> > >     load_elf_binary->
> > >       -> setup_arg_pages
> > >         -> expand_downwards (in the if (grow <=) block)
> > >            mm->page_table_lock // X
> > >            vm_write_begin(vma) // Y: acquires seq lock
> > >
> > >     exec->
> > >      do_execve_file->
> > >        ->get_user_pages
> > >          -> handle_pte_fault
> > >           -> anon_vma_prepare
> > >               -> acquire anon_vma->rwsem  // Z
> > >               -> acquire mm->page_table_lock // X
> > >
> > >     If vm_write_begin ever had to wait, then it could lockup like this if following happened concurrently:
> > >     Acquire->TryToAcquire
> > >     Y->Z
> > >     X->Y
> > >     Z->X
> > >
> > >     But Y can never result in a wait since it is a sequence lock. So this is
> > >     a lockdep false positive.
> > >
> > > >
> > > > *   What keeps write_seqcount(vm_seqcount) serialized? If it's only
> > > >     one lock that serializes the writers, we probably can make it
> > > >     as the nest_lock argument for seqcount_acquire(), and that will
> > > >     help prevent the false positives.
> > >
> > > I think the write seqcount is serialized by the mmap_sem in all the code
> > > paths I audited in Laurent's patchset.
> > >
> > > I am not sure how making it nest_lock argument will help though? The issue is
> > > that lockdep's understanding of seqcount needs to relate seqcount readers to
> >
> > The thing lockdep will not report deadlock for the following sequences:
> >
> >         T1:
> >         lock(A);
> >         lock_nest(B, A);
> >         lock(C);
> >
> >         T2:
> >         lock(A);
> >         lock(C);
> >         lock_nest(B, A);
> >
> > because with the nest_lock, lockdep would know A serializes B, so the
> > following case cannot happen:
> >
> >         CPU 0                   CPU 1
> >         ============            ============
> >         lock_nest(B,A);
> >                                 lock(C);
> >         lock(C);
> >                                 lock_nest(B, A);
> >
> > becaue either CPU 0 or CPU 1 will already hold A, so they are
> > serialized. So nest_lock can solve part of the problem if all the
> > writers of vm_seqcount are serialized somehow.
> >
> > Yes, seqcount writers cannot block each other, however, they are
> > supposed to be seralized with each other, right? So if we have the
> > reason to believe the above two CPUs case can happen, though it's not
> > a deadlock, but it's a data race, right?
> >
> > I think the proper fix here is to annotate vm_seqcount with the correct
> > locks serializing the writers.
> >
> 
> I agree with you now and that's the best way forward. I will work on
> something like this (unless you already did), thanks Boqun!
> 

Go ahead! I haven't started anything yet, although I did read a little
to understand what is needed to change.

Regards,
Boqun

> -Joel
