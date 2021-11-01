Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96548441D29
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhKAPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAPLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:11:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 616E160E90;
        Mon,  1 Nov 2021 15:09:18 +0000 (UTC)
Date:   Mon, 1 Nov 2021 11:09:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rostedt-trace:for-next 58/100]
 samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous prototype
 for function 'my_direct_func'
Message-ID: <20211101110916.47de8ccc@gandalf.local.home>
In-Reply-To: <YX/88QsleYGkt7PG@krava>
References: <202111010507.F9ud1mUL-lkp@intel.com>
        <YX/thIXtDzfhljX7@krava>
        <20211101102434.47e84754@gandalf.local.home>
        <YX/88QsleYGkt7PG@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 15:42:57 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> ok, I'll send it.. should be on top of you for-next branch?

Yes please. I'm about to push it to Linus, with a note that I'll be sending
him another pull request later this week.

-- Steve
