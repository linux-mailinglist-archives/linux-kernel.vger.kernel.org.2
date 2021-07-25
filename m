Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05EC3D50AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 01:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhGYXEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 19:04:54 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37393 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhGYXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 19:04:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 05C955807D5;
        Sun, 25 Jul 2021 19:45:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 25 Jul 2021 19:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bUaoxm
        Us8Q89tzAaaWrITizZDB7ZNjUyiLAre6mVMUw=; b=o0pjfCN8VLX4lvyuYcHs6D
        hwUobXh5IJOMavo2dyrluS8rqrUqtmmI1GL+Q7pXjpTOpY1b0VJHYM3WeQreYxjn
        Bb6zD8mebvl4c0dk2oG6Ax6c5tNW9FqG9YI8dfj++aOFafhKSSqFluPvLYa8a6NH
        JNynO5r8t2iwVscPW5OCF5RCF9evJ3KGSBe1kZP2CAiDPcLs/ko+jZkJGi1kt7Ny
        jw/jZzflpg8g/BL69VMrydp1qH0eTsUJzwb519K56pvsJ2P2o9cIDkiVlZ5u/Cl+
        6WfEJgJQufnQ7NG0NjRKMIBh3/YbV2mXIG+tZtziC4dmXqu8mja3zcSK0qBOKIYw
        ==
X-ME-Sender: <xms:kff9YGo38BN2_So8_lmb4kasM7jan25K6kvwiXAccu_3UVDLt1Jitw>
    <xme:kff9YErwvpgAiLfOnNvj00KEADbcaOASgBa9J7QVSoLUNL7CfRENeDkEnQlokU9K7
    nh_Vx1ITduGZ3zBzfQ>
X-ME-Received: <xmr:kff9YLMjxzxgiUFuG4iCN02vReeFPWVGkXNKzAKb-TUGsfnx3FoWh5Wie0nUvBGxhugCjubfwNoPvH3pn-lrfP_12KpxyGjv_VM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeeggddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeffudfhgeefvdeitedugfelueegheekkeefveffhfeiveetledvhfdtveffteeu
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:kff9YF5xxDI_9lUFEJe4mfI45locrFtWwr6XtVUqlCgJjy-r24susg>
    <xmx:kff9YF59al5SCVFhECBI8yzuarAQkxJH42ZysZV03uRelnhQ2n5HtQ>
    <xmx:kff9YFhxiHeGgKH8TO_EE64VDC54l4-2LFrlGvXGZ2s6zXgu1K4AXA>
    <xmx:k_f9YPteooEd3v56lCWtwv3ZGcerPhZS3-4yLMCpjHav2_tg6N-Gtg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jul 2021 19:45:18 -0400 (EDT)
Date:   Mon, 26 Jul 2021 09:44:27 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Greg Ungerer <gerg@uclinux.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Fix asm register constraints for atomic ops
In-Reply-To: <20210725104618.365790-1-geert@linux-m68k.org>
Message-ID: <db2de193-a10-598-a21e-3a305b91d191@linux-m68k.org>
References: <20210725104618.365790-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2021, Geert Uytterhoeven wrote:

> Fixes: d839bae4269aea46 ("locking,arch,m68k: Fold atomic_ops")
> ...
> Technically, the issue was present before, but I doubt adding pre-v3.18
> Fixes tags would make any difference for stable...

There is a better way to constrain backporting, that is Cc: 
stable@vger.kernel.org # 3.12+

The reason I mention it is that Fixes tags could be seen as a way to 
identify commits that introduce bugs, e.g. for the purposes of training 
AIs, or attributing blame, or measuring quality etc. I think it would be 
unfair to point the finger at Peter's commit.
