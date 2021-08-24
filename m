Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC73F5F73
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhHXNsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhHXNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:48:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F87C061757;
        Tue, 24 Aug 2021 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ILj4XmfWQXIyzl8A5H+kdT/BqqpNT9Em5fDQ/6CntDo=; b=hDmbCCBH672Cm7KZMqVkOl5puv
        gEwrlzbPC/sOnFf0o4JoRgzedBbMA02vRIp257K+VOzm/UIW6MLs5accdCbuh4rhX9HgMg3qblcdC
        lOdPE6HOWLwppLnbxFx8RkNJUSA44ysCPy13PzgAJv4CKD9ttn5O3NI7G5/PuZX7dMWnte05il//x
        U4HzHq3iHf7PPigiwutlyOe21HXuIw4Y1rk3+xWmv/vpLyvPP1bVk9uY/zM2u7f7UBBnnMpQRa7sd
        vmVzULrmpWdpi9lms53EVJahkzCx7Fwf4UWmDg2//ZtnXypVf7U+uIQh6HnY0NvyLYlLPwnBZn2dz
        FSTVFSnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIWlu-00CbXe-Sj; Tue, 24 Aug 2021 13:47:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4DD5300252;
        Tue, 24 Aug 2021 15:47:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87CEF2C5B4A97; Tue, 24 Aug 2021 15:47:21 +0200 (CEST)
Date:   Tue, 24 Aug 2021 15:47:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH][RFC] lockdep: improve comments in wait-type checks
Message-ID: <YST4aWMArEBsKW07@hirez.programming.kicks-ass.net>
References: <20210810210319.6564-1-zhouzhouyi@gmail.com>
 <YRM5heBfgNtEGvoC@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRM5heBfgNtEGvoC@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:44:21AM +0800, Boqun Feng wrote:
> Hi,
> 
> On Wed, Aug 11, 2021 at 05:03:19AM +0800, Zhouyi Zhou wrote:
> > Hi Peter,
> >   I think comments in wait-type checks may benifit from some comments
> > improvement.
> 
> Thanks for looking into this!
> 
> Even for an RFC patch, it's better that you write a proper commit log,
> and note that you can put all this background information right after
> the "---" line, if you think that will help people review it.
> 
> >   I recklessly add Paul to signed-off-by, because I asked his opinion
> > about comment in rcu_read_lock_bh part.
> > 
> 
> Probably a Suggested-by will suffice, but I leave that to Paul ;-)

This, also since Paul never actually touched the patch.

> > Thanks a lot
> > Zhouyi
> > 
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Please make you the last one in the "Signed-off-by" list, see
> Documentation/process/submitting-patches.rst:
> 
> "Notably, the last Signed-off-by: must always be that of the developer
> submitting the patch."

The first sob should be that of the author, and given that's the same
person as the submitter in this case, he's got a problem at his hands
;-)

