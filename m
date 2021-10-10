Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2742809A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhJJK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhJJK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:59:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41840C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lAhR6HL9yrTgsRteyx/m4GYqb0D0402HoRTg/lIVH2A=; b=le24S/qvpsuOjd9rqDTCF18sAH
        HssyzGn+hbElEhXQbkEjfuX7+SRAJOLx749vHjCthSDkZFf3VNEO3uvKJ0YMe1ncwt6ddy8xyA4dv
        xEc8equC4WNe9xD7v5HWwtmvUhFnu+a7WbKMZi+uVM6XsgHcViaVFDSP59iJ4kFHdJipbBpD2ci79
        zQUNpXFGs+nAy9IyzBO95ytErxqfGQGjY0ktv94M8Bfy5IgwhngcvANuuJddLzZyoXglEcXDQYTej
        Vx3aDvgXbeVUp3VT+U5jpHUVZpwvGVx0lhaP8pR9Wi+vjO8egG+yiD/Q3SatNDQo4pBO7g6djnREU
        L2z/OWUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZWWI-0090ge-Gp; Sun, 10 Oct 2021 10:57:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C71A83000A9;
        Sun, 10 Oct 2021 12:57:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACD5E2D15F6CA; Sun, 10 Oct 2021 12:57:28 +0200 (CEST)
Date:   Sun, 10 Oct 2021 12:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        arnd@kernel.org
Subject: Re: [tip:sched/core 13/47] kernel/sched/core.c:10400:42: error:
 variable 'stats' set but not used
Message-ID: <YWLHGOSkzaCFi3/a@hirez.programming.kicks-ass.net>
References: <202110100928.bK8nPf4x-lkp@intel.com>
 <CALOAHbAo91dYPtHFH8E9cXPbn-pY960z06908-twAMb1xWUM_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAo91dYPtHFH8E9cXPbn-pY960z06908-twAMb1xWUM_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 05:59:54PM +0800, Yafang Shao wrote:
> On Sun, Oct 10, 2021 at 9:38 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > head:   b2d5b9cec60fecc72a13191c2c6c05acf60975a5
> > commit: ceeadb83aea28372e54857bf88ab7e17af48ab7b [13/47] sched: Make struct sched_statistics independent of fair sched class
> > config: microblaze-buildonly-randconfig-r002-20211010 (attached as .config)
> > compiler: microblaze-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> 
> It is a  W=1 warning.
> It seems that we don't need to fix the warning.

Right, and I asked 0day people to stop sending W=1 warnings, but they
just keep going on and on.

Arnd, any way we can 'promote' that warning to W=2?
