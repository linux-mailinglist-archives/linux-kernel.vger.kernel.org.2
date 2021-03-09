Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044543328A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhCIOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:30:45 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:57348 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhCIOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:30:29 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJdIm-004JBQ-G7; Tue, 09 Mar 2021 14:25:36 +0000
Date:   Tue, 9 Mar 2021 14:25:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Palash Oswal <oswalpalash@gmail.com>
Cc:     akpm@linux-foundation.org, dave@stgolabs.net,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rppt@linux.vnet.ibm.com, sds@tycho.nsa.gov,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel panic: Attempted to kill init!
Message-ID: <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk>
References: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
 <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk>
 <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 11:29:14AM +0530, Palash Oswal wrote:

> I observe the following result(notice the segfault in systemd):
> root@sandbox:~# ./repro
> [    9.457767] got to 221
> [    9.457791] got to 183
> [    9.459144] got to 201
> [    9.459471] got to 208
> [    9.459773] got to 210
> [    9.462602] got to 270
> [    9.488551] systemd[1]: segfault at 7ffe59fd7fb8 ip
> 000055be8f20b466 sp 00007ffe59fd7fc0 error 6 in
> systemd[55be8f15f000+ed000]
> [    9.490723] Code: 00 00 00 00 41 57 41 56 41 55 41 54 55 53 89 fd
> 48 81 ec 48 01 00 00 64 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00
> 00 31 c0 <e8> f5 bf f7 ff 83 f8 01 0f 84 b7 00 00 00 48 8d 9c 240
> [    9.492637] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b

Lovely.  So something in that sequence of syscalls manages to trigger
segfault in unrelated process.  What happens if you put it to sleep
right after open_by_handle_at() (e.g. by read(2) from fd 0, etc.)?
