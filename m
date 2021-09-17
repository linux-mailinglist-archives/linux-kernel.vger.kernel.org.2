Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2A40F374
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhIQHqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhIQHqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:46:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B04C60F38;
        Fri, 17 Sep 2021 07:44:42 +0000 (UTC)
Date:   Fri, 17 Sep 2021 09:44:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] fork: add helper to clone a process
Message-ID: <20210917074440.qwo6anrtxa7lj657@wittgenstein>
References: <20210916212051.6918-1-michael.christie@oracle.com>
 <20210916212051.6918-2-michael.christie@oracle.com>
 <YUQvAy8HDh5oYyqn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUQvAy8HDh5oYyqn@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 07:00:35AM +0100, Christoph Hellwig wrote:
> On Thu, Sep 16, 2021 at 04:20:44PM -0500, Mike Christie wrote:
> > The vhost layer has similar requirements as io_uring where its worker
> > threads need to access the userspace thread's memory, want to inherit the
> > parents's cgroups and namespaces, and be checked against the parent's
> > RLIMITs. Right now, the vhost layer uses the kthread API which has
> > kthread_use_mm for mem access, and those threads can use
> > cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
> > other items.
> > 
> > This adds a helper to clone a process so we can inherit everything we
> > want in one call. It's a more generic version of create_io_thread which
> > will be used by the vhost layer and io_uring in later patches in this set.
> > 
> > This patch also exports __set_task_comm and wake_up_new_task which is
> > needed by modules to use the new helper. io_uring calls these functions
> > already but its always built into the kernel so was not needed before.
> 
> Can you build proper APIs please?  e.g. the set_task_comm users
> generally want a printf-like varargs caling conventions.  I'd also
> much prefer to hide as much as possible in the actual helper.  That is
> build a helper that gets the name, a flag to ignore the singals etc
> instead of exporting all these random low-level helpers.

Yes, I think that's really what we want here.
