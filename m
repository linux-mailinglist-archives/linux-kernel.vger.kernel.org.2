Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9B36B20B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhDZLFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:05:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhDZLFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:05:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619435068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jhkDCiDbD3dtlOrKi/5BJLtDDAnpNEhS5Hg5hY/KW74=;
        b=F/L2H45PgMTLn/0UXVDSHCqeu1VpNDUD6+kzRnoL4tmCWMJiUXKho1maND2JFBn3IT62Yl
        qcF7tBnAvZ1yIvU2blCl3+9O1NwkQob4a5VvimqbiIfsz0IiNoygskbQHfI53WTlGyAxkG
        izV0O9xiHLiCtzGQQvLsmCssL3HB+Qk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B804BAD69;
        Mon, 26 Apr 2021 11:04:28 +0000 (UTC)
Date:   Mon, 26 Apr 2021 13:04:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 04/13] dump_stack: Add vmlinux build ID to stack traces
Message-ID: <YIaePJGgD+FEQAUF@alley>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420215003.3510247-5-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-04-20 14:49:54, Stephen Boyd wrote:
> Add the running kernel's build ID[1] to the stacktrace information
> header.  This makes it simpler for developers to locate the vmlinux with
> full debuginfo for a particular kernel stacktrace. Combined with
> scripts/decode_stracktrace.sh, a developer can download the correct
> vmlinux from a debuginfod[2] server and find the exact file and line
> number for the functions plus offsets in a stacktrace.
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index f375900cf9ed..3b7a0ff4642f 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -10,7 +10,11 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  		   __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
>  
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)

Why is this enabled for CONFIG_CRASH_CORE, please?

Is some crash_core code going to printk it id even when
CONFIG_STACKTRACE_BUILD_ID is disabled?

Anyway, this condition should be added in the patch when a code is
really going to depend on it. Or the intention should be explained
in the commit message at least.


>  extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
>  void init_vmlinux_build_id(void);
> +#else
> +static inline void init_vmlinux_build_id(void) { }
> +#endif

Otherwise, the patch looks good to me.

Best Regards,
Petr
