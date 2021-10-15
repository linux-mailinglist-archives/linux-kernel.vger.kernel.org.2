Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC37F42F50D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhJOOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237269AbhJOOUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:20:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF6D61090;
        Fri, 15 Oct 2021 14:18:16 +0000 (UTC)
Date:   Fri, 15 Oct 2021 10:18:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zong Li <zong@andestech.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Alan Kao <alankao@andestech.com>, kclin@andestech.com
Subject: Re: [PATCH] nds32/ftrace: Fix Error: invalid operands (*UND* and
 *UND* sections) for `^'
Message-ID: <20211015101814.6b372c10@gandalf.local.home>
In-Reply-To: <CAEbi=3d=yO+D_SjQavqizc2tHyWda3t9zXbN84cbvYYNP=epKA@mail.gmail.com>
References: <20211014143507.4ad2c0f7@gandalf.local.home>
        <CAEbi=3d=yO+D_SjQavqizc2tHyWda3t9zXbN84cbvYYNP=epKA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 08:54:35 +0800
Greentime Hu <green.hu@gmail.com> wrote:

> loop in Alan and KC

Any thoughts?

This has passed my tests, and I want to send it off to Linus. But it would
be nice to have an acked by from one of the nds32 maintainers.

If I don't hear back today, I'll just send my queue without this update to
Linus, as I want to get my changes in before the next rc release.

Thanks!

-- Steve
