Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4736D556
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbhD1KDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238428AbhD1KD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619604164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=id68obkVrtWS6HXPvkWeXSQyvZyR++NmzAuxtZLxn7A=;
        b=WO+3HTk83qmFOp+qU9OCdyxQGQf8K+SjyZv17RI98XbgQFm+E03OEkvBzZcwK7WFvpduXH
        /wqzMufb4ApHKD6bSRR3HF8a5VjQuZyOc42GD0w/jhEfJnMFmU5xQtTGFm4+jdrffSiv+s
        Mwp5zfmy7s4ifzC//ya2rr0U6fliV80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-ZqXsWSWtMkG_TuH05OLV4Q-1; Wed, 28 Apr 2021 06:02:42 -0400
X-MC-Unique: ZqXsWSWtMkG_TuH05OLV4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E2FC18B615D;
        Wed, 28 Apr 2021 10:02:33 +0000 (UTC)
Received: from localhost (ovpn-13-87.pek2.redhat.com [10.72.13.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 761CB6B8D4;
        Wed, 28 Apr 2021 10:02:32 +0000 (UTC)
Date:   Wed, 28 Apr 2021 18:02:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v5 03/13] buildid: Stash away kernels build ID on init
Message-ID: <20210428100229.GA8374@localhost.localdomain>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420215003.3510247-4-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/21 at 02:49pm, Stephen Boyd wrote:
> Parse the kernel's build ID at initialization so that other code can
> print a hex format string representation of the running kernel's build
> ID. This will be used in the kdump and dump_stack code so that
> developers can easily locate the vmlinux debug symbols for a
> crash/stacktrace.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: <kexec@lists.infradead.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/buildid.h |  3 +++
>  init/main.c             |  1 +
>  lib/buildid.c           | 15 +++++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index ebce93f26d06..f375900cf9ed 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -10,4 +10,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  		   __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
>  
> +extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
> +void init_vmlinux_build_id(void);
> +
>  #endif
> diff --git a/init/main.c b/init/main.c
> index 53b278845b88..eaede2f41327 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -857,6 +857,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	set_task_stack_end_magic(&init_task);
>  	smp_setup_processor_id();
>  	debug_objects_early_init();
> +	init_vmlinux_build_id();
>  
>  	cgroup_init_early();
>  
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 6aea1c4e5e85..1103ed46214f 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/buildid.h>
> +#include <linux/cache.h>
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> @@ -172,3 +173,17 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
>  {
>  	return parse_build_id_buf(build_id, NULL, buf, buf_size);
>  }
> +
> +unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
> +
> +/**
> + * init_vmlinux_build_id - Compute and stash the running kernel's build ID
> + */
> +void __init init_vmlinux_build_id(void)
> +{
> +	extern const void __start_notes __weak;
> +	extern const void __stop_notes __weak;
> +	unsigned int size = &__stop_notes - &__start_notes;
> +
> +	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
> +}

LGTM, thx.

Acked-by: Baoquan He <bhe@redhat.com>

