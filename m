Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228933582D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhDHMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhDHMFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:05:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D89B161159;
        Thu,  8 Apr 2021 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617883542;
        bh=PkD/GSaUvqTOVLvxjobLh4KOvXJrzJDPIsbDstqOgkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peVZyEdp9E0PsT0Nbh8YQwgv5kFuqJ1Ta8lDbS0KP/uT7B02e6DPud4czkNgGccTu
         H2V46zxkZJrp2+U6vnAtQlmTNxfFqP+9sLx4C2vMUdQXe+HBGIS7LHIAWy3MAguaV/
         D22RZmE0M75ke261BPhV7V6ud41ivoPDSNFbrQCpE3ALQjyGJP5YEIzIshTN8Gy/Zh
         AeIfphkRB5XAPAE/WC7QWTuJt0eWlTUCnr+BIl3kCBzdnxGqF1TrgHQyStE3bke5kc
         KNljcAWby2fYP6Phj4qRBikK3aVJCAWB4F2fugicQkIR7paIhMqsFOqk1BwrXjHbh6
         xHZxFV//lfgXg==
Date:   Thu, 8 Apr 2021 14:05:33 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v3 02/12] buildid: Stash away kernels build ID on init
Message-ID: <YG7xjbIEmrCco14F@gunter>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210331030520.3816265-3-swboyd@chromium.org>
X-OS:   Linux gunter 5.11.6-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Stephen Boyd [30/03/21 20:05 -0700]:
[snipped]
>diff --git a/lib/buildid.c b/lib/buildid.c
>index 010ab0674cb9..b939bbc59233 100644
>--- a/lib/buildid.c
>+++ b/lib/buildid.c
>@@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
>
> #include <linux/buildid.h>
>+#include <linux/cache.h>
> #include <linux/elf.h>
> #include <linux/kernel.h>
> #include <linux/pagemap.h>
>@@ -171,3 +172,19 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
> {
> 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
> }
>+
>+unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
>+
>+/**
>+ * init_vmlinux_build_id - Get the running kernel's build ID
>+ *
>+ * Return: Running kernel's build ID
>+ */

Hm, init_vmlinux_build_id() doesn't return anything, so this comment is
not accurate - maybe "Get the running kernel's build ID and store it in
vmlinux_build_id"?

>+void __init init_vmlinux_build_id(void)
>+{
>+	extern const void __start_notes __weak;
>+	extern const void __stop_notes __weak;
>+	unsigned int size = &__stop_notes - &__start_notes;
>+
>+	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
>+}
