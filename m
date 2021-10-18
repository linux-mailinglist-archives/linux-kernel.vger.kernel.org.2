Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE043163A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJRKhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhJRKhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:37:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33C6B6103B;
        Mon, 18 Oct 2021 10:35:26 +0000 (UTC)
Date:   Mon, 18 Oct 2021 12:35:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        jannh@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: don't detect sender/target during buffer cleanup
Message-ID: <20211018103523.dn5rnrefulhd2gzc@wittgenstein>
References: <20211015233811.3532235-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211015233811.3532235-1-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 04:38:11PM -0700, Todd Kjos wrote:
> When freeing txn buffers, binder_transaction_buffer_release()
> attempts to detect whether the current context is the target by
> comparing current->group_leader to proc->tsk. This is an unreliable
> test. Instead explicitly pass an 'is_failure' boolean.
> 
> Detecting the sender was being used as a way to tell if the
> transaction failed to be sent.  When cleaning up after
> failing to send a transaction, there is no need to close
> the fds associated with a BINDER_TYPE_FDA object. Now
> 'is_failure' can be used to accurately detect this case.
> 
> Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

Looks good to me.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
