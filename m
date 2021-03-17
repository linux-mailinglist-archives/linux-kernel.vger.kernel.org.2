Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6117033F7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhCQSBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:01:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37741 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCQSAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:00:54 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMaTS-0001oJ-Bj; Wed, 17 Mar 2021 18:00:50 +0000
Date:   Wed, 17 Mar 2021 19:00:48 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Li Li <dualli@chromium.org>
Cc:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com, joel@joelfernandes.org, kernel-team@android.com,
        jannh@google.com
Subject: Re: [PATCH v3 0/3] Binder: Enable App Freezing Capability
Message-ID: <20210317180048.inzdursqmnvxkgwp@wittgenstein>
References: <20210316011630.1121213-1-dualli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316011630.1121213-1-dualli@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 06:16:27PM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> To improve the user experience when switching between recently used
> applications, the background applications which are not currently needed
> are cached in the memory. Normally, a well designed application will not
> consume valuable CPU resources in the background. However, it's possible
> some applications are not able or willing to behave as expected, wasting
> energy even after being cached.
> 
> It is a good idea to freeze those applications when they're only being
> kept alive for the sake of faster startup and energy saving. These kernel
> patches will provide the necessary infrastructure for user space framework
> to freeze and thaw a cached process, check the current freezing status and
> correctly deal with outstanding binder transactions to frozen processes.
> 
> Changes in v2: avoid panic by using pr_warn for unexpected cases.
> Changes in v3: improved errcode logic in binder_proc_transaction().
> 
> Marco Ballesio (3):
>   binder: BINDER_FREEZE ioctl
>   binder: use EINTR for interrupted wait for work
>   binder: BINDER_GET_FROZEN_INFO ioctl
> 
>  drivers/android/binder.c            | 198 ++++++++++++++++++++++++++--
>  drivers/android/binder_internal.h   |  18 +++
>  include/uapi/linux/android/binder.h |  20 +++
>  3 files changed, 224 insertions(+), 12 deletions(-)

[+Cc Jann]

Christian
