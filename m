Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF539BC1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFDPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:41:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:45009 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFDPlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:41:39 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154FZJvk020323;
        Fri, 4 Jun 2021 10:35:19 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154FZIOg020322;
        Fri, 4 Jun 2021 10:35:18 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 10:35:18 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604153518.GD18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:44:37PM +0200, Peter Zijlstra wrote:
> On naming (sorry Paul for forgetting that in the initial mail); while I
> think using the volatile qualifier for the language feature (can we haz
> plz, kthxbai) makes perfect sense, Paul felt that we might use a
> 'better' name for the kernel use, ctrl_dep_if() was proposed.

In standard C statements do not have qualifiers.  Unless you can
convince the ISO C committee to have them on "if", you will have a very
hard time convincing any serious compiler to do this.


Segher
