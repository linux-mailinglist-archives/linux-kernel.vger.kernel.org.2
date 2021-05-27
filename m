Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33792392F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhE0NIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236336AbhE0NIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:08:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 151D360FE3;
        Thu, 27 May 2021 13:06:45 +0000 (UTC)
Date:   Thu, 27 May 2021 15:06:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        containers@lists.linux.dev, Tycho Andersen <tycho@tycho.pizza>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Mauricio =?utf-8?Q?V=C3=A1squez?= Bernal <mauricio@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] selftests/seccomp: More closely track fds being assigned
Message-ID: <20210527130643.zbkcupofjwryjjm5@wittgenstein>
References: <20210527032948.3730953-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210527032948.3730953-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:29:48PM -0700, Kees Cook wrote:
> Since the open fds might not always start at "4" (especially when
> running under kselftest, etc), start counting from the first assigned
> fd, rather than using the more permissive EXPECT_GE(fd, 0).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
