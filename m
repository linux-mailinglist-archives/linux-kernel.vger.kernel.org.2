Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E633120C3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 02:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBGBqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 20:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhBGBqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 20:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612662294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dsog5JErkbZWHcF1hTfD4LXVYTt/LhPseo2hrtLMy/Q=;
        b=PLq9AfYgMuuBOpB049jXXyEUc//ylMCB3re5FyTOdj0M50XjHKP1UVwUjZ46vlW0f0HN22
        nJHls67ZWlKhaKR1qRv0BGld5LEmb1BwIq7hqdEkofYVwkMkUSrYpiOtbTj2frPu/cXGtt
        cwBaAYWqEbMXSBoh1237q725Hd2JrE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-UAEp5ZtUMR2bEgZRc-hkYQ-1; Sat, 06 Feb 2021 20:44:49 -0500
X-MC-Unique: UAEp5ZtUMR2bEgZRc-hkYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA0D804022;
        Sun,  7 Feb 2021 01:44:47 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16F3719CBC;
        Sun,  7 Feb 2021 01:44:39 +0000 (UTC)
Date:   Sun, 7 Feb 2021 09:44:36 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     john.p.donnelly@oracle.com, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] kernel/crash_core: Add crashkernel=auto for
 vmcore creation
Message-ID: <20210207014436.GA3372@dhcp-128-65.nay.redhat.com>
References: <20210204004347.41918-1-saeed.mirzamohammadi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204004347.41918-1-saeed.mirzamohammadi@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,
On 02/03/21 at 04:43pm, Saeed Mirzamohammadi wrote:
> This adds crashkernel=auto feature to configure reserved memory for
> vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
> different kernel distributions and different archs based on their
> needs.
> 
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst |  5 +++++
>  arch/Kconfig                              | 24 +++++++++++++++++++++++
>  kernel/crash_core.c                       |  7 +++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 75a9dd98e76e..f95a2af64f59 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -285,7 +285,12 @@ This would mean:
>      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>      3) if the RAM size is larger than 2G, then reserve 128M
>  
> +Or you can use crashkernel=auto if you have enough memory. The threshold
> +is 1G on x86_64 and arm64. If your system memory is less than the threshold,
> +crashkernel=auto will not reserve memory. The size changes according to
> +the system memory size like below:
>  
> +    x86_64/arm64: 1G-64G:128M,64G-1T:256M,1T-:512M

This part should be updated since you do not make the default value arch
dependent.

The format of the auto str is documented well in kernel-parameters.txt
below part:
crashkernel=range1:size1[,range2:size2,...][@offset]

The crashkernel=auto should be also documented in kernel-parameters.txt
and do not need to explain the threshold etc again, just refer to the
"crashkernel=range1:size1[,range2:size2,...][@offset]" format would be
fine.

>  
>  Boot into System Kernel
>  =======================
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..a772eb397d73 100644
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

Thanks
Dave

