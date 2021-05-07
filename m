Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09F037690F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhEGQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:52:11 -0400
Received: from one.firstfloor.org ([193.170.194.197]:41412 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhEGQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:52:09 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 7381786BFB; Fri,  7 May 2021 18:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1620406267;
        bh=1SHUiq3gjiLNW1J025jR8iyEh/0h6hOYbR9YLHddU54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmN8YvU7weSe+ZVBiKfZ7XUcLtOg7hYfgWrd9Dr78f48KP1gsWGMU3GV0qW+usvSj
         yt7V7NCBO4z1j0ekXKJ+VH6Z8au9N/RODUOZYFc8c9OYLXmrL/u9cnmGHg73HB8Gnw
         UcOGGEIs6NAUr9ZyVsirh7mCMElSKhM4GsbOcCC0=
Date:   Fri, 7 May 2021 09:51:07 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        mbenes@suse.de
Subject: Re: [PATCH] objtool: Allocate CFI state lazily
Message-ID: <20210507165106.hs57ozffut32y5ub@two.firstfloor.org>
References: <20210505033835.1282751-1-ak@linux.intel.com>
 <YJUvmt1vXN9FeTrV@hirez.programming.kicks-ass.net>
 <20210507164925.GC54801@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507164925.GC54801@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> allyesconfig/vmlinux.o
> 
> orig:	6:17.83 real,   150.43 user,    88.55 sys,      29189972 mem
> prev:	2:38.22 real,   105.06 user,    51.97 sys,      17869952 mem
> this:	2:29.80 real,   105.18 user,    44.61 sys,      16170064 mem

Great progress. Thanks!

I'll test it in my setup once I fixed the other problems.

-Andi
