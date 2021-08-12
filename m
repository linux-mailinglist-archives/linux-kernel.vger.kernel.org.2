Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E435E3EAA96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhHLTGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:06:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhHLTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:06:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D8EF222C4;
        Thu, 12 Aug 2021 19:05:35 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3842613C71;
        Thu, 12 Aug 2021 19:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TIz7A/1wFWFLTAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Thu, 12 Aug 2021 19:05:33 +0000
Date:   Thu, 12 Aug 2021 12:05:26 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     longman@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -tip] locking: Move CONFIG_LOCK_EVENT_COUNTS into Kernel
 hacking section
Message-ID: <20210812190526.mfrz5ifdodbncz3w@offworld>
References: <20210330020636.112594-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210330020636.112594-1-dave@stgolabs.net>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Mon, 29 Mar 2021, Davidlohr Bueso wrote:

>It's a lot more intuitive to have it in the locking section of the kernel
>hacking part rather than under "General architecture-dependent options".
>
>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>---
> arch/Kconfig      | 9 ---------
> lib/Kconfig.debug | 9 +++++++++
> 2 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/arch/Kconfig b/arch/Kconfig
>index ecfd3520b676..d6f9aeaaf9f2 100644
>--- a/arch/Kconfig
>+++ b/arch/Kconfig
>@@ -1113,15 +1113,6 @@ config HAVE_ARCH_PREL32_RELOCATIONS
> config ARCH_USE_MEMREMAP_PROT
> 	bool
>
>-config LOCK_EVENT_COUNTS
>-	bool "Locking event counts collection"
>-	depends on DEBUG_FS
>-	help
>-	  Enable light-weight counting of various locking related events
>-	  in the system with minimal performance impact. This reduces
>-	  the chance of application behavior change because of timing
>-	  differences. The counts are reported via debugfs.
>-
> # Select if the architecture has support for applying RELR relocations.
> config ARCH_HAS_RELR
> 	bool
>diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>index 2779c29d9981..76639ff5998c 100644
>--- a/lib/Kconfig.debug
>+++ b/lib/Kconfig.debug
>@@ -1401,6 +1401,15 @@ config DEBUG_LOCKING_API_SELFTESTS
> 	  The following locking APIs are covered: spinlocks, rwlocks,
> 	  mutexes and rwsems.
>
>+config LOCK_EVENT_COUNTS
>+	bool "Locking event counts collection"
>+	depends on DEBUG_FS
>+	help
>+	  Enable light-weight counting of various locking related events
>+	  in the system with minimal performance impact. This reduces
>+	  the chance of application behavior change because of timing
>+	  differences. The counts are reported via debugfs.
>+
> config LOCK_TORTURE_TEST
> 	tristate "torture tests for locking"
> 	depends on DEBUG_KERNEL
>-- 
>2.26.2
>
