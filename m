Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935C345A58B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbhKWO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237611AbhKWO01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:26:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 997BB6052B;
        Tue, 23 Nov 2021 14:23:16 +0000 (UTC)
Date:   Tue, 23 Nov 2021 15:23:13 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     michael.christie@oracle.com
Cc:     Jens Axboe <axboe@kernel.dk>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 07/10] io_uring: switch to kernel_worker
Message-ID: <20211123142313.otzajzobhuacuwe5@wittgenstein>
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-8-michael.christie@oracle.com>
 <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
 <20211122100228.wdeovpqxg6gl3ldb@wittgenstein>
 <f2a421da-1bb0-c65a-d8e2-7cbbb2cccfab@kernel.dk>
 <766e8487-c83f-5ed1-1e49-0f17ef5ad97d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <766e8487-c83f-5ed1-1e49-0f17ef5ad97d@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 10:47:28AM -0600, michael.christie@oracle.com wrote:
> On 11/22/21 8:20 AM, Jens Axboe wrote:
> > On 11/22/21 3:02 AM, Christian Brauner wrote:
> >> On Sun, Nov 21, 2021 at 11:17:11AM -0700, Jens Axboe wrote:
> >>> On 11/21/21 10:49 AM, Mike Christie wrote:
> >>>> Convert io_uring and io-wq to use kernel_worker.
> >>>
> >>> I don't like the kernel_worker name, that implies it's always giving you
> >>> a kernel thread or kthread. That's not the io_uring use case, it's
> >>> really just a thread off the original task that just happens to never
> >>> exit to userspace.
> >>>
> >>> Can we do a better name? At least io_thread doesn't imply that.
> >>
> >> Yeah, I had thought about that as well and at first had kernel_uworker()
> >> locally but wasn't convinced. Maybe we should just make it
> >> create_user_worker()?
> > 
> > That's better, or maybe even create_user_inkernel_thread() or something?
> > Pretty long, though... I'd be fine with create_user_worker().
> > 
> 
> Ok, I'll do:
> 
> create_user_worker()
> start_user_worker()
> 
> since you guys agree. It will also match the PF flag naming.
> 
> I'll also add more details to the commit message you requested.

Thanks!
