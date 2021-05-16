Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B322381F11
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhEPNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 09:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhEPNV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 09:21:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09C3F61057;
        Sun, 16 May 2021 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621171211;
        bh=2nKhWSdNaznlT9Qj0k9QpAEScdSYLJ22W+74tQs2xJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qx9mzqwDaf4oVeez9cKMY6ZiE5DCWLX8vI7u8DrkV9YpfmGwBr2TgnGAsS2HPaMc4
         Fo6NPbMoLETyy8P7MBGpDHaKOL1rp7rKLesqc2md5AIgF/WxHYMvL1IJFzQBglSzzG
         OCvLF+tgP8BQaflW64DktFWklVAlc1Bs1/shKeR8grtAVvK67VCIJ9zLgXRxTE+PG3
         vl/4RCF/VXOoB3HT/NUKxqCnCfB27GEgIePLKr9dO1jrQczDRdJs6Sv+k+umQm9L6Q
         3P+s8Pcb4NWNVhMcrzb8i2/5R7tULCnumMHEIGiO+wEzYkkWgclqyFkGk5h1PUlJU3
         kkR1/qzJYkdIg==
Date:   Sun, 16 May 2021 22:20:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Randy Dunlap <randy.dunlap@oracle.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3] samples/kprobes: Fix typo in handler_{post,fault}()
Message-Id: <20210516222003.29086ea4f04a956edb47b032@kernel.org>
In-Reply-To: <81d398b86b1c7214e64a0dd25a9ef090f86bc16c.camel@perches.com>
References: <1621046346-7855-1-git-send-email-yangtiezhu@loongson.cn>
        <20210516190201.790f4f2085e2691bbb96c58c@kernel.org>
        <81d398b86b1c7214e64a0dd25a9ef090f86bc16c.camel@perches.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2021 06:14:58 -0700
Joe Perches <joe@perches.com> wrote:

> On Sun, 2021-05-16 at 19:02 +0900, Masami Hiramatsu wrote:
> > On Sat, 15 May 2021 10:39:06 +0800
> > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > 
> > > It should use post_handler instead of pre_handler in handler_post().
> > > 
> > > As Joe Perches suggested, it would be better to use pr_fmt and remove
> > > all the embedded pre/post strings. This would change the style of the
> > > output through.
> > > 
> > 
> > NAK, this also shows which handler cought the event.
> > If you wanna change it. Please replace it with __func__ instead.
> []
> > > diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> []
> > > @@ -10,6 +10,8 @@
> > >   * whenever kernel_clone() is invoked to create a new process.
> > >   */
> > >  
> > > +#define pr_fmt(fmt) "%s: " fmt, __func__
> 
> It does that already via the pr_fmt which uses __func__.

Oops, I missed that. OK then it is good to me.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
