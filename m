Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3378731DFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhBQT1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhBQT1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:27:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A05264E3E;
        Wed, 17 Feb 2021 19:26:55 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:26:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     john.p.donnelly@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for
 vmcore creation
Message-ID: <20210217142653.0fcd9ce3@gandalf.local.home>
In-Reply-To: <77fcb8e8-c3ec-6161-14a8-c142e02a9061@oracle.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
        <77fcb8e8-c3ec-6161-14a8-c142e02a9061@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 12:40:43 -0600
john.p.donnelly@oracle.com wrote:

> Hello.
> 
> Ping.
> 
> Can we get this reviewed and staged ?
> 
> Thank you.

Andrew,

Seems you are the only one pushing patches in for kexec/crash. Is this
maintained by anyone?

-- Steve
