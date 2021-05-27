Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70DF392E15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhE0Mhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234949AbhE0Mhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B60D60698;
        Thu, 27 May 2021 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622118965;
        bh=LkW/jbMrzKXy/H0G+XYfVrIBFEu8oxng20TYT+qC1Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRxQcVlXHbiptEcESmshvr91jfheDvH/Awibly2O/UWi1J7Q3nDSNcNaCWCh+Qvze
         xcQwmJuTwnf9ncbDJiVMGdDphXA1pukt/HH8XTM+aSUVzMUoqCs1r7HdReH8l96FaQ
         AcO9wmVHVulPgTSzQJTa0W282nUzJ2k0/yueS/J7XrDOBc5STWVgkbc6US18/7P4Gf
         U9eFrf1b6wZaqiH12fQBi8r5OsNB113WWSy+wQ/huOJbZrgyT3EcOL8s/N3lwZvMjk
         izmkO9l4ANEJOJAf/cmKqzMDIB8BzAAVjb9V+5qBZTgi1Wbi/1rQW8kk+fNY8KwcTL
         BrGOvG4gtKHJA==
Date:   Thu, 27 May 2021 14:36:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] module: fix compile error that sect_empty() is not
 defined in init_build_id()
Message-ID: <YK+SMJRDDCZqQJ26@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <20210527111453.195014-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210527111453.195014-1-yukuai3@huawei.com>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Yu Kuai [27/05/21 19:14 +0800]:
>If 'CONFIG_SYS' is not enabled while 'CONFIG_KALLSYMS' is enabled,
>fix following compile error:
>
>kernel/module.c:2805:8: error: implicit declaration of function ‘sect_empty’;
>did you mean ‘desc_empty’? [-Werror=implicit-function-declaration]
>
>Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Hi,

This has already been fixed in linux-next, see:

     https://lore.kernel.org/r/20210525105049.34804-1-cuibixuan@huawei.com

>---
> kernel/module.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index decf4601e943..173acb2aecc7 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2794,7 +2794,8 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
> }
> #endif /* CONFIG_KALLSYMS */
>
>-#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
>+#if IS_ENABLED(CONFIG_SYSFS) && IS_ENABLED(CONFIG_KALLSYMS) &&\
>+	IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> static void init_build_id(struct module *mod, const struct load_info *info)
> {
> 	const Elf_Shdr *sechdr;
>-- 
>2.25.4
>
