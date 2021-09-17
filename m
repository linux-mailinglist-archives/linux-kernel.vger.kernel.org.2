Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E871D40F453
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhIQIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233688AbhIQIof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:44:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE8360EE0;
        Fri, 17 Sep 2021 08:43:11 +0000 (UTC)
Date:   Fri, 17 Sep 2021 10:43:09 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] fork: add helper to clone a process
Message-ID: <20210917084309.rmlly66jpikx7h4q@wittgenstein>
References: <20210916212051.6918-1-michael.christie@oracle.com>
 <20210916212051.6918-2-michael.christie@oracle.com>
 <YUQvAy8HDh5oYyqn@infradead.org>
 <20210917074440.qwo6anrtxa7lj657@wittgenstein>
 <YURLQvJAO2mCX0zJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YURLQvJAO2mCX0zJ@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:01:06AM +0100, Christoph Hellwig wrote:
> On Fri, Sep 17, 2021 at 09:44:40AM +0200, Christian Brauner wrote:
> > > generally want a printf-like varargs caling conventions.  I'd also
> > > much prefer to hide as much as possible in the actual helper.  That is
> > > build a helper that gets the name, a flag to ignore the singals etc
> > > instead of exporting all these random low-level helpers.
> > 
> > Yes, I think that's really what we want here.
> 
> In a way this would mean enhancing the kthread API to also support I/O
> threads.

Kinda, it's a kthread in so far as it has been created by the kernel and
not through a regular syscall path. But it's not really using any of the
kthread.c stuff.

I think the general push of the series is right. We should aim for a
helper that allows a driver - similar to what uring already does - to
create a task with the context of the caller.

After the fork/clone rework that I did it shouldn't be that difficult to
do. The uring patch did show that it's fairly straightforward.
