Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE94458C02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhKVKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239142AbhKVKFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:05:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E53C60E08;
        Mon, 22 Nov 2021 10:02:31 +0000 (UTC)
Date:   Mon, 22 Nov 2021 11:02:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 07/10] io_uring: switch to kernel_worker
Message-ID: <20211122100228.wdeovpqxg6gl3ldb@wittgenstein>
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-8-michael.christie@oracle.com>
 <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 11:17:11AM -0700, Jens Axboe wrote:
> On 11/21/21 10:49 AM, Mike Christie wrote:
> > Convert io_uring and io-wq to use kernel_worker.
> 
> I don't like the kernel_worker name, that implies it's always giving you
> a kernel thread or kthread. That's not the io_uring use case, it's
> really just a thread off the original task that just happens to never
> exit to userspace.
> 
> Can we do a better name? At least io_thread doesn't imply that.

Yeah, I had thought about that as well and at first had kernel_uworker()
locally but wasn't convinced. Maybe we should just make it
create_user_worker()?

Christian
