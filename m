Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2707A3AFEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFVIJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhFVII7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D2A861351;
        Tue, 22 Jun 2021 08:06:40 +0000 (UTC)
Date:   Tue, 22 Jun 2021 10:06:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com>,
        axboe@kernel.dk, christian@brauner.io, ebiederm@xmission.com,
        elver@google.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
        pcc@google.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] signal: Prevent sigqueue caching after task got released
Message-ID: <20210622080639.nk5buzset4ucchnk@wittgenstein>
References: <000000000000148b4b05c419cbbb@google.com>
 <878s32g6j5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878s32g6j5.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:08:30AM +0200, Thomas Gleixner wrote:
> syzbot reported a memory leak related to sigqueue caching. This happens
> when a thread group leader with child tasks is reaped.
> 
> The group leader's sigqueue_cache is correctly freed. The group leader then
> reaps the child tasks and if any of them has a signal pending it caches
> that signal. That's obviously bogus because nothing will free the cached
> signal of the reaped group leader anymore.
> 
> Prevent this by setting tsk::sigqueue_cache to an error pointer value in
> exit_task_sigqueue_cache().
> 
> Add comments to all relevant places.
> 
> Fixes: 4bad58ebc8bc ("signal: Allow tasks to cache one sigqueue struct")
> Reported-by: syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
