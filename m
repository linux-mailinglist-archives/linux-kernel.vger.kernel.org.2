Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE07338CA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhEUPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhEUPqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:46:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD34A613EC;
        Fri, 21 May 2021 15:44:48 +0000 (UTC)
Date:   Fri, 21 May 2021 17:44:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        Mauricio =?utf-8?Q?V=C3=A1squez?= Bernal <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v2 0/4] Atomic addfd send and reply
Message-ID: <20210521154445.yz26ja35t3ux7m6j@wittgenstein>
References: <20210517193908.3113-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210517193908.3113-1-sargun@sargun.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 12:39:04PM -0700, Sargun Dhillon wrote:
> This is somewhat of a respin of "Handle seccomp notification preemption"
> but without the controversial parts.
> 
> 
> This patchset addresses a race condition we've dealt with recently with
> seccomp. Specifically programs interrupting syscalls while they're in
> progress. This was exacerbated by Golang's recent adoption of "async
> preemption", in which they try to interrupt any syscall that's been running
> for more than 10ms during GC. During certain syscalls, it's non-trivial to
> write them in a reetrant manner in userspace (socket).
> 
> It focuses on one use cases, which is adding file descriptors to a process
> "atomically" during the seccomp reply, as opposed to discretizing the calls
> which may result in a potential file descriptor leak and inconsistent
> program state.

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
