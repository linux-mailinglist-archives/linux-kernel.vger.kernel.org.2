Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8EB3BAEB7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhGDUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhGDUN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:13:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9547C613C2;
        Sun,  4 Jul 2021 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429452;
        bh=7hI9g9AS2W9NBj9AZzq1i/Rcz6W3JA1J7E4tIpW9DPE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gn32HjVDKEXLvChNCYuT+4+NH9HzL/e4O5zi9KnebEyeymt47m5h1ttIGIwm7cD0+
         GGAB92MjBQBvumSwbyU0ws/Bwf4CDJ5rP0ITzcixGbgqo88+4g3m6iQ/FJOyywlK+c
         05P4RPEbF3ZmmznogJ8BOGa0vSJDw2bLto8KYprmhfsRkKFGO6lzBuSdMBi57+Ue63
         ZecMbZw7qUiL+j8ZQ4eS6LsaSewXJCAVSLQk++3kwibw9+F3zW2RK1KaqIM9jSoNxz
         Vd3vrM8vDdMOAZHaetq5s6mWAhjLML/8DIeUBNTIW+T7gRgRZVxdeICQZ59S+VkaIT
         Lpwcl2oNj0YrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 61AAD5C0138; Sun,  4 Jul 2021 13:10:52 -0700 (PDT)
Date:   Sun, 4 Jul 2021 13:10:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] KCSAN changes for v5.14
Message-ID: <20210704201052.GS4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210704172912.GA2969733@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wip1WgNAi-MfVUj0R+-BGch62dmJKdyWENpYw_xEq8GNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wip1WgNAi-MfVUj0R+-BGch62dmJKdyWENpYw_xEq8GNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 12:31:10PM -0700, Linus Torvalds wrote:
> On Sun, Jul 4, 2021 at 10:29 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Please pull the latest KCSAN tree from:
> 
> I've pulled this, but I'd _really_ like an overview of the changes for
> the merge log and my own perusal.
> 
> Even if it's just something "Minor bug fixes and cleanups" because
> there's nothing in particular that stands out, that's the kind of
> thing I want to be able to then document for the merge.

Please accept my apologies for failing to provide the overview, and I
will provide one in the future.

							Thanx, Paul
