Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2E41E763
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 08:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352084AbhJAGGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 02:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhJAGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 02:06:07 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BAC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:04:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y17so1127913ilb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rwySDSKRRsXslYbKXYJa76oaTvMhveH8tikguFBiHvY=;
        b=jBCw0IV5em7m+jkf3uXMg8qlulGpsCKRgxxmh5SSG58uz4eGSqHcP0t9eCbB+MiqSB
         7ixH02iEw4phN4nXr1VybWTwmyIctcQV8cF6hcUyG5s4jwLwLHxwJEhpjbfxr0CBtDv4
         5488znKDkNBgzteJU/05iDoafsPQ2M/UeWyXZ3+GMOGOpq2rAjMdjXVxy1PpPTgR4kDw
         TAchRGDCvrEzx8aEktGgrV4nYUrNFW932Asg9iNmr6rPgxBEqqvzbAoS8BmP2iO9Fhb7
         NczLlBe4gMp0ePHhW6ZySsXsOBSC9hrawjlmJmY7gANXjmu1TvCW6+IYXn6fpuWl3JjW
         uWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rwySDSKRRsXslYbKXYJa76oaTvMhveH8tikguFBiHvY=;
        b=qJNmEKhL8szp0CU1bylKD9A5gDRvSIhnS1TqnXVVTv9kIF6Zvfcf11o05CBcxMOMw5
         hhlcHaqrAEaw3cAxMrRSMGDYryGm5GASHfGoxRqknevpDOUf1YsxI5GzEeljaM9ULWxJ
         wNwcpCk4E0HDoTKyKsaCzYsSk4ZiYOuxiLlreoFQGcIT7psSbdCWYuiIe9fnGqQrqeED
         aZZw9yNu4CGXia0LetS0HVrOEEq8r9PXxUxRH9XAx2nQTNoyA6MiK8ou1Y8uFKWnBY8A
         3fPPIwTpP8x7Mky8uPs3gnaGkCPKqNx8wpce3Bg0IiRBeEIi74elM/I6Q3E5JVca/F/q
         60iA==
X-Gm-Message-State: AOAM532F9nSiSSjs8GLztf5xxlmVZTQz9iWFSCyNUjR+tsM1P69qu2Ca
        wB7Z/DmKOJlE/8amJH/0gu8=
X-Google-Smtp-Source: ABdhPJy5GWMXpyo7i3E81FoNj02lC558KOBunhBrBrRh/JI2yRKmuTrvg0W2kTVWb1NrMXfGuW0RJA==
X-Received: by 2002:a05:6e02:1807:: with SMTP id a7mr6062144ilv.310.1633068263860;
        Thu, 30 Sep 2021 23:04:23 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id e9sm2824190iob.52.2021.09.30.23.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 23:04:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 75C1127C0054;
        Fri,  1 Oct 2021 02:04:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 01 Oct 2021 02:04:21 -0400
X-ME-Sender: <xms:4qRWYfbPMh5IcPzDZQuyaf-oNKZb21meYZT25ZiK-cYRVW3IGQaXlg>
    <xme:4qRWYearN9UtsFrChBksQHUk3bifaF-R0s0KM6D-WS-Wpj8GDbIDLsb8z6nyNbo7Q
    nfAKsPCpD2gi34T4A>
X-ME-Received: <xmr:4qRWYR8tjbA2UJvojVMed-iF9k0--vOx2s5LEmjAASGWyn5UoYObKBiRdriIOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggedutefhkeeludetleefveffudehjeelhfffgfefgfekueeiieevjedu
    gffhffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4qRWYVp8HcLPEEr3r4Q40W7triYfzbNMA9sXIKOCYrxdUV5qUDRoeA>
    <xmx:4qRWYaqSgg-5lxV-gWLgYYBMG4POK3brE7CNY_gAHFqZQ5RFRv-v4A>
    <xmx:4qRWYbTK-wvLWyFszKr9mytpJQxRZR0i3BHzdWgykyLdYio3xozD5Q>
    <xmx:46RWYfgLRFY9c3iRfIb0Vya0bab9ssLIgzSJ6HiVG5kBa4ZvdwAMnESeLZU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Oct 2021 02:04:18 -0400 (EDT)
Date:   Fri, 1 Oct 2021 14:03:30 +0800
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
Message-ID: <YVakskMQGrnOUHsa@boqun-archlinux>
References: <20210930130823.2103688-1-boqun.feng@gmail.com>
 <20210930152033.GD464826@rowland.harvard.edu>
 <20210930181753.GH880162@paulmck-ThinkPad-P17-Gen-1>
 <20210930204634.GB482974@rowland.harvard.edu>
 <YVZSiCFAc2RdmeD9@boqun-archlinux>
 <20211001013055.GA489012@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001013055.GA489012@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 09:30:55PM -0400, Alan Stern wrote:
> On Fri, Oct 01, 2021 at 08:12:56AM +0800, Boqun Feng wrote:
> > On Thu, Sep 30, 2021 at 04:46:34PM -0400, Alan Stern wrote:
> > > On Thu, Sep 30, 2021 at 11:17:53AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Sep 30, 2021 at 11:20:33AM -0400, Alan Stern wrote:
> > > > > On Thu, Sep 30, 2021 at 09:08:23PM +0800, Boqun Feng wrote:
> > > > > > A recent discussion[1] shows that we are in favor of strengthening the
> > > > > > ordering of unlock + lock on the same CPU: a unlock and a po-after lock
> > > > > > should provide the so-called RCtso ordering, that is a memory access S
> > > > > > po-before the unlock should be ordered against a memory access R
> > > > > > po-after the lock, unless S is a store and R is a load.
> > > > > > 
> > > > > > The strengthening meets programmers' expection that "sequence of two
> > > > > > locked regions to be ordered wrt each other" (from Linus), and can
> > > > > > reduce the mental burden when using locks. Therefore add it in LKMM.
> > > > > > 
> > > > > > [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
> > > > > > 
> > > > > > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > > > ---
> > > > > > Alan,
> > > > > > 
> > > > > > I added the "Co-developed-by" and "Signed-off-by" tags since most of the
> > > > > > work is done by you. Feel free to let me know if you want to change
> > > > > > anything.
> > > > > 
> > > > > It looks good to me.  However, do we really want to add these litmus
> > > > > tests to the kernel source, or would it be better to keep them with
> > > > > the thousands of other tests in Paul's archives?
> > > > 
> > > > Either way works for me.  But if they are referred to from within the
> > > > kernel, it is best to have them in the kernel source.  Which might be seen
> > > > as a reason to minimize referring to litmus tests from the kernel.  ;-)
> > > 
> > > In this case the litmus tests are not referred to within the kernel 
> > > source.
> > > 
> > 
> > I'm OK to drop the litmus tests, but the reason I add the two litmus
> > tests is that they directly describe one of our memory model rules. The
> > two litmus tests tells developers "you can use unlock+lock on the same
> > CPU to order READ->WRITE or WRITE->WRITE", so they are kind of part of
> > the manual of our memory model. Thoughts?
> 
> The explanation.txt file already contains example litmus tests (not 
> in a form acceptable to herd7, though) for these things.
> 

Agreed. I just think that runnable litmus tests may be more accurate
than words. But again, I'm OK to drop them.

While we are at it, maybe it's worthwhile to discuss what kind of litmus
tests should be put in tools/memory-model/litmus-tests. Selftests for
.cat changes? Documented patterns for developers to follow? Or something
else?

Regards,
Boqun

> Alan
