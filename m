Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9E32C9EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbhCDBPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344028AbhCDBNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:13:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2242064F72;
        Thu,  4 Mar 2021 01:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614820341;
        bh=sDMsuyroAM4Dr89dR9qRBdSjF4cx7se980bqsh/ms3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=blg3CYhel1Xr5b7L9LBwmPAmkLPi4LzX86fWS7FvMc7pGgPd2hrxHUrA7ye2hQxmc
         lh2mhGWmpceneiLmtDuq+ufDyZ5lOjUg1dn+hyEz+cuXsRV2eiX6v1mnxCMrT5duvv
         jdbUOLZd437hqvZmA4I40BDVTCV57CMCUx6R7RgI=
Date:   Wed, 3 Mar 2021 17:12:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric Gao <eric.tech@foxmail.com>
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] ipc/msg: add msgsnd_timed and msgrcv_timed syscall for
 system V message queue
Message-Id: <20210303171220.79faee7108f846b8e140e44d@linux-foundation.org>
In-Reply-To: <tencent_E0772A5A82FD941DB0B488DF366F3F509F07@qq.com>
References: <tencent_E0772A5A82FD941DB0B488DF366F3F509F07@qq.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 23:11:43 +0800 Eric Gao <eric.tech@foxmail.com> wrote:

> sometimes, we need the msgsnd or msgrcv syscall can return after a limited
> time, so that the business thread do not be blocked here all the time. In
> this case, I add the msgsnd_timed and msgrcv_timed syscall that with time
> parameter, which has a unit of ms.

Please cc Manfred and Davidlohr on ipc/ changes.

The above is a very brief description for a new syscall!  Please go to
great lengths to tell us why this is considered useful - what are the
use cases?

Also, please fully describe the proposed syscall interface right here
in the changelog.  Please be prepared to later prepare a full manpage.

> ...
> +SYSCALL_DEFINE5(msgsnd_timed, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
> +		int, msgflg, long, timeoutms)

Specifying the timeout in milliseconds is problematic - it's very
coarse.  See sys_epoll_pwait2()'s use of timespecs.
