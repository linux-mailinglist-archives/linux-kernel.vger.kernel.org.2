Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89737A984
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhEKOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhEKOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:37:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A1C061574;
        Tue, 11 May 2021 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INAkIN4SBQvoIBYvJ03SumbjRNWdtamuLnKi9O35Hxc=; b=Uv1dwxn5bh2d/tg/FP0HBf+mqY
        NEQBgZwWFCoph900CFGJ6NE4qFrtVmwssRC92hw4fjI9xfykBbinku1r+3waXe3hGG0igMHXtlQcf
        84vEFr/lv1EkydVj+IbjB6z4DcDMtoTXr0csjCfDN7hHsYqR3t9wFlYSUOdC4X+NLypjuyDnKPxVf
        Oxib7suJdC08HbdjrkyqO1l6zeDvwNhd+zt1xGOzNIb7A4Kbdi306RN+5ajt5qfLoO1+KIPE2EBol
        hcB5/IL1rZPgO++DBXlz5tiN9wYSyjDrvbqjKfHYaTjexZMo5F1G5uemEgUTpPtkqsPN6l+MgWQwF
        Gt0T+LQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgTTu-007Mpv-Ly; Tue, 11 May 2021 14:35:39 +0000
Date:   Tue, 11 May 2021 15:35:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Petr Mladek' <pmladek@suse.com>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        'Stephen Boyd' <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>, Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        peter enderborg <peter.enderborg@sony.com>
Subject: Re: [PATCH v6 00/13] Add build ID to stacktraces
Message-ID: <YJqWMgiirWPNNvnX@casper.infradead.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
 <b30f6d396edf4db5974a2b90364b6314@AcuMS.aculab.com>
 <20210511085235.09bc38a7@gandalf.local.home>
 <37ca7834a8514a5695ed002e073a83b6@AcuMS.aculab.com>
 <YJqTB5pJiRqS1yGY@alley>
 <f09e9d68e4b14de58e881050a3c78ec1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09e9d68e4b14de58e881050a3c78ec1@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 02:31:38PM +0000, David Laight wrote:
> Actually, for the use case, the id could be trimmed significantly.
> It is only trying to differentiate between builds of a specific module.
> So even 8 digits would be plenty.

asked and answered.  please review the bidding.
