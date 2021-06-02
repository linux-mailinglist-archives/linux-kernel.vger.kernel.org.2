Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80139921B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhFBSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhFBSDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:03:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA90661DAB;
        Wed,  2 Jun 2021 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622656889;
        bh=fQXm9BykRQ8de1JVkzMk/o4tmQnGcumbAyoAQWoZBKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HwuAZH9Kp+fW1hYa5V+RoK5DFGxmNn2AKmm6YCnOVLTm4lAV7N7R7qBYrUPnhoOUy
         R2ZFPihfo7LvQm3BpisTQH2KltgzU5J4RLuxq188Lf4UnPi0yTHJTrV8pXWKFVTzGX
         IEPddKr+LRz+PmPIQBQdNWzmt55APK900yd3IEDMN4fmHrKlGDMrh8eSr0+W8s0WWT
         1HQuULJ6dQJWCloF230gKEQfqQAJF5HSI4r6mzRA0TnhwibFInkXlcTIm8ckxl424w
         7kRkfhz7E80hvVqLm4V3mtrDrLawOa3a/MCHPVuvtcE6AVmT3u5sK4HeblhXXDRngq
         C8LsFeoDHb1tQ==
Date:   Wed, 2 Jun 2021 20:01:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: accounting: update delay-accounting.rst
 reference
Message-ID: <20210602200121.64a828a1@coco.lan>
In-Reply-To: <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
        <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
        <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 2 Jun 2021 18:38:29 +0200
Peter Zijlstra <peterz@infradead.org> escreveu:

> On Wed, Jun 02, 2021 at 05:43:13PM +0200, Mauro Carvalho Chehab wrote:
> > When :doc: is used, the .rst should be removed. Also, the patches
> > are relative to the current directory.
> > 
> > So, the right reference should be:
> > 
> > 	:doc:`/accounting/delay-accounting`
> > 
> > Fixes: fcb501704554 ("delayacct: Document task_delayacct sysctl")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > index b2057173fe07..7f36cba3204b 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -1097,7 +1097,7 @@ task_delayacct
> >  ===============
> >  
> >  Enables/disables task delay accounting (see
> > -:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
> > +:doc:`/accounting/delay-accounting`). Enabling this feature incurs  
> 
> This breaks any chance of using 'goto file' like features in text
> editors :/ 

This is a feature of your favorite text editor. Not all have it.

> Can we please not do crap like this.

See, this is not the only place on this document using :doc:``. It is just
the one using it wrong:

	$ git grep :doc: Documentation/admin-guide/sysctl/kernel.rst
	Documentation/admin-guide/sysctl/kernel.rst:For general info and legal blurb, please look in :doc:`index`.
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/power/video`. This allows the video resume mode to be set,
	Documentation/admin-guide/sysctl/kernel.rst::doc:`/x86/boot` for additional information.
	Documentation/admin-guide/sysctl/kernel.rst::doc:`/x86/boot` for additional information.
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/driver-api/firmware/fallback-mechanisms`.
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/trace/ftrace`.
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/admin-guide/lockup-watchdogs` for more information.
	Documentation/admin-guide/sysctl/kernel.rst:to the guest kernel command line (see :doc:`/admin-guide/kernel-parameters`).
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/admin-guide/initrd`.
	Documentation/admin-guide/sysctl/kernel.rst::doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/userspace-api/seccomp_filter`.
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/admin-guide/sysrq`.
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/admin-guide/tainted-kernels` for more information.
	Documentation/admin-guide/sysctl/kernel.rst:  See :doc:`/admin-guide/kernel-parameters` for more details on that particular
	Documentation/admin-guide/sysctl/kernel.rst:When set, disables tracing (see :doc:`/trace/ftrace`) when a
	Documentation/admin-guide/sysctl/kernel.rst:See :doc:`/admin-guide/kernel-parameters` and
	Documentation/admin-guide/sysctl/kernel.rst::doc:`/trace/boottime-trace`.

-

That's said, automarkup.py has a rule to convert Documentation/<foo>.rst
into :doc:`<foo>`. So, an alternative approach would be to convert
treewide all :doc:`<foo>` into Documentation/<foo>.rst and add something 
at checkpatch.pl to recommend to avoid :doc: notation.

Tests are needed, though, to be sure that automarkup.py won't miss
something, as the regex there might require tweaks to cover some
border cases.

Thanks,
Mauro
