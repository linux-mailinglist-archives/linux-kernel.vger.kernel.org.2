Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC03FC3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbhHaHZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239538AbhHaHZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 764D76023E;
        Tue, 31 Aug 2021 07:24:18 +0000 (UTC)
Date:   Tue, 31 Aug 2021 09:24:16 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: make sure fd closes complete
Message-ID: <20210831072416.y4fvshvjeo7eh2dr@wittgenstein>
References: <20210830195146.587206-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210830195146.587206-1-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 12:51:46PM -0700, Todd Kjos wrote:
> During BC_FREE_BUFFER processing, the BINDER_TYPE_FDA object
> cleanup may close 1 or more fds. The close operations are
> completed using the task work mechanism -- which means the thread
> needs to return to userspace or the file object may never be
> dereferenced -- which can lead to hung processes.
> 
> Force the binder thread back to userspace if an fd is closed during
> BC_FREE_BUFFER handling.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

Looks good. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
