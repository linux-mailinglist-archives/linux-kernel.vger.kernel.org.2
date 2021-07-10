Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5D3C2C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 03:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhGJBP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 21:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhGJBP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 21:15:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2D56613C2;
        Sat, 10 Jul 2021 01:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625879561;
        bh=8C2HRs3eIFIr1CQbCC8Pz27G0ibVeUXMSPTvqYy2wFM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S/QZQASL9Fy6yA1LR+TmZtuhwoALmZhPvkMDeIUoGlXugMlHsUuRUsMyaPSBklmFX
         s4Rol3W1xJ7zXXTbCj0rbWDquD5+P1zKQx3o/0cuy7hDwArctBsK2rCd/8a+T/kW63
         t+NOJthSfHzwToMcE5IJ2bVo5QGcuMsx1yNSN5oc=
Date:   Fri, 9 Jul 2021 18:12:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace
 was changed
Message-Id: <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
In-Reply-To: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Jul 2021 16:22:57 +0300 Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com> wrote:

> Hello,
> 
> Task IPC namespace shm's has shm_rmid_forced feature which is per IPC namespace
> and controlled by kernel.shm_rmid_forced sysctl. When feature is turned on,
> then during task exit (and unshare(CLONE_NEWIPC)) all sysvshm's will be destroyed
> by exit_shm(struct task_struct *task) function. But there is a problem if task
> was changed IPC namespace since shmget() call. In such situation exit_shm() function
> will try to call
> shm_destroy(<new_ipc_namespace_ptr>, <sysvshmem_from_old_ipc_namespace>)
> which leads to the situation when sysvshm object still attached to old
> IPC namespace but freed; later during old IPC namespace cleanup we will try to
> free such sysvshm object for the second time and will get the problem :)
> 
> First patch solves this problem by postponing shm_destroy to the moment when
> IPC namespace cleanup will be called.
> Second patch is useful to prevent (or easy catch) such bugs in the future by
> adding corresponding WARNings.
> 

(cc's added)

I assume that a

Fixes: b34a6b1da371ed8af ("ipc: introduce shm_rmid_forced sysctl") is
appropriate here?

A double-free is serious.  Should this fix be backported into earlier
kernels?
