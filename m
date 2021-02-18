Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7FA31E42E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBRCDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhBRCDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613613737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s59KdTmSQrBsPD+fUMSiJY2kWYO8ArD+gPj0+UsCDBk=;
        b=OLmfRZi/t6XRr3bwjRSYWvAhFLuXXFYukNOxA0mWstOGs2H43xfi+T7RRrmbO6n/oHl/nr
        am80nwz0Kv9w4bajyU5T1nRoYNcm9l5K+5a/bw6pZ1T/uMfO/us8hlGtibiMMKZU7gnxAp
        QRUCynbtSipmtycM59X8bz04pB9WGxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-Rduto0FTMjKAg80OdDaLGA-1; Wed, 17 Feb 2021 21:02:13 -0500
X-MC-Unique: Rduto0FTMjKAg80OdDaLGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C555154;
        Thu, 18 Feb 2021 02:02:10 +0000 (UTC)
Received: from localhost (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51C0D6F13C;
        Thu, 18 Feb 2021 02:02:06 +0000 (UTC)
Date:   Thu, 18 Feb 2021 10:02:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     john.p.donnelly@oracle.com, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
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
Message-ID: <20210218020203.GC2871@MiWiFi-R3L-srv>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/21 at 10:08am, Saeed Mirzamohammadi wrote:
> This adds crashkernel=auto feature to configure reserved memory for
> vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
> different kernel distributions and different archs based on their
> needs.
> 
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst     |  3 ++-
>  .../admin-guide/kernel-parameters.txt         |  6 +++++
>  arch/Kconfig                                  | 24 +++++++++++++++++++
>  kernel/crash_core.c                           |  7 ++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..e55cdc404c6b 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -285,7 +285,8 @@ This would mean:
>      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>      3) if the RAM size is larger than 2G, then reserve 128M
>  
> -
> +Or you can use crashkernel=auto to choose the crash kernel memory size
> +based on the recommended configuration set for each arch.
>  
>  Boot into System Kernel
>  =======================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7d4e523646c3..aa2099465458 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -736,6 +736,12 @@
>  			a memory unit (amount[KMG]). See also
>  			Documentation/admin-guide/kdump/kdump.rst for an example.
>  
> +	crashkernel=auto
> +			[KNL] This parameter will set the reserved memory for
> +			the crash kernel based on the value of the CRASH_AUTO_STR
> +			that is the best effort estimation for each arch. See also
> +			arch/Kconfig for further details.
> +
>  	crashkernel=size[KMG],high
>  			[KNL, X86-64] range could be above 4G. Allow kernel
>  			to allocate physical memory region from top, so could
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..f87c88ffa2f8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
>  config CRASH_CORE
>  	bool
>  
> +if CRASH_CORE
> +
> +config CRASH_AUTO_STR
> +	string "Memory reserved for crash kernel"
> +	depends on CRASH_CORE
> +	default "1G-64G:128M,64G-1T:256M,1T-:512M"
> +	help
> +	  This configures the reserved memory dependent
> +	  on the value of System RAM. The syntax is:
> +	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> +	              range=start-[end]
> +
> +	  For example:
> +	      crashkernel=512M-2G:64M,2G-:128M
> +
> +	  This would mean:
> +
> +	      1) if the RAM is smaller than 512M, then don't reserve anything
> +	         (this is the "rescue" case)
> +	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> +	      3) if the RAM size is larger than 2G, then reserve 128M
> +
> +endif # CRASH_CORE

Wondering if this CRASH_CORE ifdeffery is a little redundent here
since CRASH_CORE dependency has been added. Except of this, I like this
patch. As we discussed in private threads, we can try to push it into
mainline and continue improving later.


> +
>  config KEXEC_CORE
>  	select CRASH_CORE
>  	bool
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..ab0a2b4b1ffa 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -7,6 +7,7 @@
>  #include <linux/crash_core.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
>  	if (suffix)
>  		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>  				suffix);
> +#ifdef CONFIG_CRASH_AUTO_STR
> +	if (strncmp(ck_cmdline, "auto", 4) == 0) {
> +		ck_cmdline = CONFIG_CRASH_AUTO_STR;
> +		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> +	}
> +#endif
>  	/*
>  	 * if the commandline contains a ':', then that's the extended
>  	 * syntax -- if not, it must be the classic syntax
> -- 
> 2.27.0
> 

