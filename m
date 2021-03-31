Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32B234FAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhCaHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234211AbhCaHoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:44:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9209A619B1;
        Wed, 31 Mar 2021 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617176655;
        bh=QLhMVNo2EWVnmQgedHdlIv6jKMUqEuJktTqjCz2h9ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjHS+2vo9NLN/Ktr+PSGIJDvqVDBlowfN3j/jo+88M0uHmN2/3pVpyF9kwW8DKlyq
         MphZspuI8hLxHTNOibPoWhl8IMcWU/Q44mZcNPLGR42XZt219sv5Sfm5nqI+PCnawq
         1uVlUGH3rUzTAFt+5RSyiR6Akw0tdA6k+VP7Uy8s=
Date:   Wed, 31 Mar 2021 09:44:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hang Lu <hangl@codeaurora.org>
Cc:     tkjos@android.com, maco@android.com, arve@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: tell userspace to dump current backtrace when
 detecting oneway spamming
Message-ID: <YGQoTPnndiJ5+mk3@kroah.com>
References: <1617176056-1440-1-git-send-email-hangl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617176056-1440-1-git-send-email-hangl@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 03:34:16PM +0800, Hang Lu wrote:
> When async binder buffer got exhausted, some normal oneway transaction
> will also be discarded and finally caused system/app stop. By that time,
> the binder debug information we dump may not relevant to the root cause.
> And this issue is difficult to debug if without the backtrace of thread
> sending spam.
> 
> This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when detecting
> oneway spamming, request to dump current backtrace. The detection will
> happened only once when exceeding the threshold (target process dips
> below 80% of its oneway space, and current process is responsible for
> either more than 50 transactions, or more than 50% of the oneway space).
> And the detection will restart when the async buffer has returned to a
> healthy state.
> 
> Signed-off-by: Hang Lu <hangl@codeaurora.org>
> ---
>  drivers/android/binder.c            | 25 ++++++++++++++++++++++---
>  drivers/android/binder_alloc.c      | 15 ++++++++++++---
>  drivers/android/binder_alloc.h      |  8 +++++++-
>  drivers/android/binder_internal.h   |  1 +
>  include/uapi/linux/android/binder.h |  8 ++++++++
>  5 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736..28ceaf9 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -87,6 +87,7 @@ static DEFINE_SPINLOCK(binder_dead_nodes_lock);
>  static struct dentry *binder_debugfs_dir_entry_root;
>  static struct dentry *binder_debugfs_dir_entry_proc;
>  static atomic_t binder_last_id;
> +static bool oneway_spam_detection_enabled;

Why is this a "whole system" value and not a "per binder instance"
value?  You just allowed one binder instance to affect another one,
which does not seem like a good idea to me :(

thanks,

greg k-h
