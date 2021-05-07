Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015E637610A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhEGHQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhEGHQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D004613D6;
        Fri,  7 May 2021 07:15:21 +0000 (UTC)
Date:   Fri, 7 May 2021 09:15:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hang Lu <hangl@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Return EFAULT if we fail
 BINDER_ENABLE_ONEWAY_SPAM_DETECTION
Message-ID: <20210507071519.et56j3kqcxrhykqo@wittgenstein>
References: <20210506193726.45118-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210506193726.45118-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 09:37:25PM +0200, Luca Stefani wrote:
> All the other ioctl paths return EFAULT in case the
> copy_from_user/copy_to_user call fails, make oneway spam detection
> follow the same paradigm.
> 
> Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace
> when detected oneway spamming")
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
