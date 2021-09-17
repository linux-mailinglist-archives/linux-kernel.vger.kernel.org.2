Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DD40F1D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbhIQGEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhIQGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:04:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KAOT1QriVAB4eECc9vz5PA1mRndKDvWQNMUrIEYWTzY=; b=jCZORZklm63UqwMLJXpjQ2dudy
        DYOj986Ojkr/OVt9ajFXRE8UE3zvbrF2FnBbfnN2JiljfGCOl+cxXH07SwrL8oFywRMkUiVnDKg5x
        CoL+AHQMfH3sOyqhCz5sIKvyTSE4EGUMdPBzEjoRafaG8YssbtlAmPZMgMvyKetgiFMo8NvCRMe8c
        MqvV8YtiHzSGESvrBSad03r3TxJhYuDpE1UeJdpK4M3zdNx17K33n9YRHxYD1CRuKOv5emRrZFKeH
        xYYX/FC+qRm4F9rWKjvBDbm6Ul2KYDBWS4CaVGpEH7pkH3dCR05nP0Jf5ITd0eNywEnUxBzvq72cj
        VDAh08BQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mR6vL-00HYMi-IS; Fri, 17 Sep 2021 06:01:06 +0000
Date:   Fri, 17 Sep 2021 07:00:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] fork: add helper to clone a process
Message-ID: <YUQvAy8HDh5oYyqn@infradead.org>
References: <20210916212051.6918-1-michael.christie@oracle.com>
 <20210916212051.6918-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916212051.6918-2-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:20:44PM -0500, Mike Christie wrote:
> The vhost layer has similar requirements as io_uring where its worker
> threads need to access the userspace thread's memory, want to inherit the
> parents's cgroups and namespaces, and be checked against the parent's
> RLIMITs. Right now, the vhost layer uses the kthread API which has
> kthread_use_mm for mem access, and those threads can use
> cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
> other items.
> 
> This adds a helper to clone a process so we can inherit everything we
> want in one call. It's a more generic version of create_io_thread which
> will be used by the vhost layer and io_uring in later patches in this set.
> 
> This patch also exports __set_task_comm and wake_up_new_task which is
> needed by modules to use the new helper. io_uring calls these functions
> already but its always built into the kernel so was not needed before.

Can you build proper APIs please?  e.g. the set_task_comm users
generally want a printf-like varargs caling conventions.  I'd also
much prefer to hide as much as possible in the actual helper.  That is
build a helper that gets the name, a flag to ignore the singals etc
instead of exporting all these random low-level helpers.
