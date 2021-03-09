Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC73330DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhCIVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhCIVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:25:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LgewzQA3xUk9kmLICc7ceJEbICsBxv0UaXPJiUdEAuA=; b=mMVewxL/w883DRQutIv8BNJrRw
        DTjbUWuy/ChVtWQKXCxM4/2tfg4nVOGTX+f5GG9KC+GtWutNT0TT5GZWrKrZM56gpfnmfnSSUI0hi
        wZqCTer7zdfSwVEO6LRgKIgfNrnwXYELJpeSYIhh27z1BgGqFwAq9TNjo/fv4MKgKG8fbmC0cq9Nh
        EznC//2wB1fUHHtlbEnh3Od0UAdPi1xvrfoJNnG9IlWJ6tCAxgBItRwM+e43tLv/VXhUbz/jS/Ych
        wqvVyHwDC12aV1WmIUbdWFLf6gf5K03duFpw/RBLaGCripXJ/tdAlu8PJl1wBHzC0tb7EfrZYP5ta
        zu51Xi4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJjqP-001R0d-SW; Tue, 09 Mar 2021 21:24:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 758283010CF;
        Tue,  9 Mar 2021 22:24:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33EAD2027A4B1; Tue,  9 Mar 2021 22:24:44 +0100 (CET)
Date:   Tue, 9 Mar 2021 22:24:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The killing of ideal_nops[]
Message-ID: <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
 <20210309120519.7c6bbb97@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309120519.7c6bbb97@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 12:05:19PM -0500, Steven Rostedt wrote:
> On Tue, 9 Mar 2021 17:58:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Hi,
> > 
> > AFAICT everything made in the past 10 years ends up using p6_nops. Is it
> > time to kill off ideal_nops[] and simplify life?
> > 
> 
> Well, the one bug that was reported recently was due to a box that uses a
> different "ideal_nops" than p6_nops. Perhaps we should ask him if there's
> any noticeable difference between using p6_nops for every function than the
> ideal_nops that as found for that box.

If the machine is more than a decade old, I'm not really caring about
optimal performance. If it is 32bit, I really couldn't be arsed as long
as it boots.
