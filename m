Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A543779A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 03:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhEJBNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 21:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhEJBNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 21:13:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A1C5610A5;
        Mon, 10 May 2021 01:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620609126;
        bh=x2gGptb1afI/ezHs0O8XaEYRbGWZuQr1p1oLQy4q6Iw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PsykP65fPWil10yBdaN+TV260LHnVIO1GNUlokxYTLJMTuFAZPqNqBv6VpL7/Sgi/
         /zkHwCxNsoOGgzUV5inffKDhjte3h3bbkthKv8CHeyjrtXVrkzQg4Gs/OGe1ChG0Dc
         LT3ukFWo/2VAKyRLC0xJMbfHIL9B/26I5ra0PP0s=
Date:   Sun, 9 May 2021 18:12:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     legion@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v11 0/9] Count rlimits in each user namespace
Message-Id: <20210509181205.f0ce806919858efa0e0e0d20@linux-foundation.org>
In-Reply-To: <cover.1619094428.git.legion@kernel.org>
References: <cover.1619094428.git.legion@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 14:27:07 +0200 legion@kernel.org wrote:

> These patches are for binding the rlimit counters to a user in user namespace.

It's at v11 and no there has been no acking or reviewing activity?  Or
have you not been tracking these?

