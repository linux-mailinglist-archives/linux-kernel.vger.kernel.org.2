Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2173D48EC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 19:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGXQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 12:58:02 -0400
Received: from shark2.inbox.lv ([194.152.32.82]:55144 "EHLO shark2.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXQ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 12:58:01 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jul 2021 12:58:01 EDT
Received: from shark2.inbox.lv (localhost [127.0.0.1])
        by shark2-out.inbox.lv (Postfix) with ESMTP id 3B457C012E;
        Sat, 24 Jul 2021 20:32:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1627147934; bh=gb4bG5oTJzx9VePKJzccG9FQrlxnmNsnsq0VHH6oyoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To;
        b=gXIRgf8khMRigt+mZ9XFp7fzHT/rPLcINwgj0iUDZ9EbWHzg5tVe504AhP959V928
         jir01qe64SzHJrlhUcqIS5GoMU5CHkkwX05E0/AXw3wPum5+GYJo81MI1Bv0m06qW0
         JNScucJ7/7X198jVb36S8qPG/GXDWFROxd6a+/jA=
Received: from localhost (localhost [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 22668C010C;
        Sat, 24 Jul 2021 20:32:14 +0300 (EEST)
Received: from shark2.inbox.lv ([127.0.0.1])
        by localhost (shark2.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id c6U9VI91D12e; Sat, 24 Jul 2021 20:32:11 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id A5496C00F3;
        Sat, 24 Jul 2021 20:32:11 +0300 (EEST)
Received: from mail.inbox.lv (unknown [79.105.117.119])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id A4C7C3E60195;
        Sat, 24 Jul 2021 20:32:09 +0300 (EEST)
Date:   Sun, 25 Jul 2021 02:32:01 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     ndrw.xf@redhazel.co.uk
Cc:     akpm@linux-foundation.org, aros@gmx.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, surenb@google.com, vbabka@suse.cz
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20210725023201.13f0d2f2@mail.inbox.lv>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
In-Reply-To: <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZqEIBwB+w1Luca/KI1r7+Xnw8rRJVcqoV6aw7o593NZs63AstlrcW6cB/eRFELmMn8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be possible to reserve a fixed (configurable) amount of RAM 
> for caches, and trigger OOM killer earlier, before most UI code is 
> evicted from memory?

Yes! Try this patch: https://github.com/hakavlad/le9-patch

The patch provides sysctl knobs for protecting the specified amount of 
clean file pages under memory pressure.
