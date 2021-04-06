Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32235585C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbhDFPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:45:00 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34720 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbhDFPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:44:57 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 719BB72C8B1;
        Tue,  6 Apr 2021 18:44:47 +0300 (MSK)
Received: from example.org (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by imap.altlinux.org (Postfix) with ESMTPSA id 16D4F4A4729;
        Tue,  6 Apr 2021 18:44:45 +0300 (MSK)
Date:   Tue, 6 Apr 2021 17:44:44 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v9 4/8] Reimplement RLIMIT_NPROC on top of ucounts
Message-ID: <20210406154444.icpvezlq3izzxf5t@example.org>
References: <cover.1616533074.git.gladkov.alexey@gmail.com>
 <8f0c2888b4e92d51239e154b82d75972e7e39833.1616533074.git.gladkov.alexey@gmail.com>
 <m1y2dwllfg.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y2dwllfg.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 11:56:35AM -0500, Eric W. Biederman wrote:
>
> Also when setting ns->ucount_max[] in create_user_ns because one value
> is signed and the other is unsigned.  Care should be taken so that
> rlimit_infinity is translated into the largest positive value the
> type can hold.

You mean like that ?

ns->ucount_max[UCOUNT_RLIMIT_NPROC] = rlimit(RLIMIT_NPROC) <= LONG_MAX ?
	rlimit(RLIMIT_NPROC) : LONG_MAX;
ns->ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = rlimit(RLIMIT_MSGQUEUE) <= LONG_MAX ?
	rlimit(RLIMIT_MSGQUEUE) : LONG_MAX;
ns->ucount_max[UCOUNT_RLIMIT_SIGPENDING] = rlimit(RLIMIT_SIGPENDING) <= LONG_MAX ?
	rlimit(RLIMIT_SIGPENDING) : LONG_MAX;
ns->ucount_max[UCOUNT_RLIMIT_MEMLOCK] = rlimit(RLIMIT_MEMLOCK) <= LONG_MAX ?
	rlimit(RLIMIT_MEMLOCK) : LONG_MAX;

-- 
Rgrds, legion

