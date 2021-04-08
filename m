Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE76435850F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhDHNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhDHNpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:45:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3154C610FA;
        Thu,  8 Apr 2021 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617889506;
        bh=9FNIvInpTS6HUpBnyUxir6ITIuqpettnjGY9a35wojM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXe9b2Thz45thpa/PTP+rH1UBRKczfYqgfd+nWDHB6XyELSr8VjI7XwsttlOWBSa7
         aEFeuW3YBFQMfT9CCNeRPNw8RvVVRlWcEFvS3C3g/VXWMJVc3RE62Mdzd2UgWI+C52
         fVm4DgjAGeA60sMzRpMHzJmnnHtRZspTQkRZ9o9Wnxixh0mWreGjg2vtdrw3R9IdOU
         1ip1HjTN5Cz174jmpb0aVqqrlCbQ9iaWFAvzQbW2QU038XPzlWxq7GB7Zj9Mo50s2J
         ejzp6iUjaPVCliR1TuMuGP1R7yv2kM+7faKBgY72nT2YeaGt1LjG0fvy/skdeBzAZm
         nYJ6aCVlktqBg==
Date:   Thu, 8 Apr 2021 15:44:57 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YG8I2dQWkOIkypqO@gunter>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210331030520.3816265-5-swboyd@chromium.org>
X-OS:   Linux gunter 5.11.6-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Stephen Boyd [30/03/21 20:05 -0700]:
[snipped]
>diff --git a/kernel/module.c b/kernel/module.c
>index 30479355ab85..6f5bc1b046a5 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -13,6 +13,7 @@
> #include <linux/trace_events.h>
> #include <linux/init.h>
> #include <linux/kallsyms.h>
>+#include <linux/buildid.h>
> #include <linux/file.h>
> #include <linux/fs.h>
> #include <linux/sysfs.h>
>@@ -2770,6 +2771,20 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
> 	}
> 	mod->core_kallsyms.num_symtab = ndst;
> }
>+
>+static void init_build_id(struct module *mod, const struct load_info *info)
>+{
>+	const Elf_Shdr *sechdr;
>+	unsigned int i;
>+
>+	for (i = 0; i < info->hdr->e_shnum; i++) {
>+		sechdr = &info->sechdrs[i];
>+		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
>+		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
>+					sechdr->sh_size))
>+			break;
>+	}
>+}

Why not just look for the .note.gnu.build-id section instead of trying
to parse each note section? Doesn't it always contain the build id? At
least the ld man page seems to suggest this section name should be
consistent.

Jessica
