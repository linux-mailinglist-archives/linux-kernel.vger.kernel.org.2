Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB033A1BE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 23:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhCMWmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 17:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhCMWmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 17:42:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25FC964ECC;
        Sat, 13 Mar 2021 22:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615675331;
        bh=BpMQLkhOmUy9SuPUTQ7hdseZoFh1p1xwYMwTVxtiVtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpAusPkbRx8QGatD97kpvnhS7XxMqDjJXgdo/JHnKhAL59Kt4+WDCZkDAKwXrsXob
         blrsFnPPEqN+C07H+9YycmXNmkOc2jrzBJsiMvfp+WIyJtSkjePryxWlXcBE0neC1l
         BHLL+dJwMRatmrxNteHqT2ELcYrUslNwpoBRdh6DecFILzaeRRG0tauWGnn7fHC6OY
         oQY2XDnmh+w8LNDialk+NEksEJBTuqtldLqjCmmsPMExaeMuniC6P6wlvMjeJnvb34
         P+xWTvvxBZG0nHxakbT1VBaBWtfVecwprnBuIBJl4K1puS78LHPLsURF7xkdiYUO2b
         Qo8xG10L0ZfQA==
Date:   Sat, 13 Mar 2021 15:42:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     namratajanawade <namrata.janawade@gmail.com>,
        anupamakpatil123@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: andriod: ashmem: Declared file operation with
 const keyword
Message-ID: <20210313224205.ubnwecxyyas5qtvk@archlinux-ax161>
References: <20210313172636.18234-1-namrata.janawade@gmail.com>
 <CAAhDqq31B6ZJmmrUeqTD7u9znrCNScc37SBR_4N=DBthu3iajA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhDqq31B6ZJmmrUeqTD7u9znrCNScc37SBR_4N=DBthu3iajA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 10:59:43PM +0530, B K Karthik wrote:
> On Sat, Mar 13, 2021 at 10:57 PM namratajanawade
> <namrata.janawade@gmail.com> wrote:
> >
> > Warning found by checkpatch.pl script.
> 
> That doesn't tell what you did or why you did it. Please write an
> appropriate commit description and resend the patch.
> 
> karthik

This patch will not even build, it has been sent several times before...

https://lore.kernel.org/r/20201016051111.1947-1-kirank.suren@gmail.com/
https://lore.kernel.org/r/20200328151523.17516-1-sandeshkenjanaashok@gmail.com/
https://lore.kernel.org/r/20201128121627.GA27317@worker-node1/
https://lore.kernel.org/r/20201227112645.256943-1-senguptaangshuman17@gmail.com/
https://lore.kernel.org/r/20201228051301.14983-1-jovin555@gmail.com/
https://lore.kernel.org/r/20210214023136.8916-1-thaiscamachoo@gmail.com/
https://lore.kernel.org/r/20210219101338.2670-1-amritkhera98@gmail.com/
https://lore.kernel.org/r/20210306063817.674041-1-nabil.ibn.mahmud@gmail.com/

I once considered adding a comment above it saying that it should not be
marked const but it is a good benchmark for seeing if people compile
their patches before sending them out.

Cheers,
Nathan
