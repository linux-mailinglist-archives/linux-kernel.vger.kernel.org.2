Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1469D3BA3A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhGBRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhGBRbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:31:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F186661430;
        Fri,  2 Jul 2021 17:28:35 +0000 (UTC)
Date:   Fri, 2 Jul 2021 13:28:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Austin Kim <austin.kim@lge.com>,
        Chunguang Xu <brookxu@tencent.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ed Tsai <ed.tsai@mediatek.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Burton <paulburton@google.com>,
        Qiujun Huang <hqjagain@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.14
Message-ID: <20210702132834.5da875b3@gandalf.local.home>
In-Reply-To: <20210702132151.6f4e5e69@gandalf.local.home>
References: <20210702095047.75807884@gandalf.local.home>
        <20210702132151.6f4e5e69@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 13:21:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Linus,
> 
> Please hold off on pulling this. I just noticed that my test machines are
> running osnoise threads on boot up. I'm currently debugging why now.

Never mind. I found the culprit. It was a test script that kicked it off,
and crashed due to a bug in a tracing library I'm working on.

So it should be still good to go.

-- Steve
