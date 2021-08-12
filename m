Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3E3EAB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhHLUT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234307AbhHLUTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC44B6101E;
        Thu, 12 Aug 2021 20:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628799564;
        bh=Met7BhuqN1q9Po3dqJQJ6Y0ovIYXHRZjV39nyIWR2KY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MHlUhKi3mZoE9MhFJwD6k376NqkGX3yv1mGuBfyiWDaFkimvMJ4XLGvJurLQFvCSw
         xJ42KQGRuWpefErVY7wS7Xy93VJ+Z6ihqAsNfczrle46YuuX4b70aWb0Yvb3eZl0GZ
         +u1c8rNyWDP6ZDc5aU0heOiQ5vLJABtPDUcp8bxg=
Date:   Thu, 12 Aug 2021 13:19:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     =?UTF-8?Q? "Valdis_Kl=C4=93tnieks" ?= <valdis.kletnieks@vt.edu>,
        SeongJae Park <sjpark@amazon.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re:
Message-Id: <20210812131921.a1c5c85213290e1729cc72a3@linux-foundation.org>
In-Reply-To: <20210812094240.4492-1-sjpark@amazon.de>
References: <144813.1628760117@turing-police>
        <20210812094240.4492-1-sjpark@amazon.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 09:42:40 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> > +config PAGE_IDLE_FLAG
> > +       bool "Add PG_idle and PG_young flags"
> > +       help
> > +         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> > +         Accessed bit writers can set the state of the bit in the flags to let
> > +         other PTE Accessed bit readers don't disturbed.
> > 
> > This needs to be converted to proper, or at least comprehensible, English....
> 
> Thank you for the comment.
> 
> How about below?
> 
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -743,9 +743,9 @@ config PAGE_IDLE_FLAG
>         bool "Add PG_idle and PG_young flags"
>         select PAGE_EXTENSION if !64BIT
>         help
> -         This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
> -         Accessed bit writers can set the state of the bit in the flags to let
> -         other PTE Accessed bit readers don't disturbed.
> +         This feature adds 'PG_idle' and 'PG_young' flags in 'struct page'.
> +         PTE Accessed bit writers can save the state of the bit in the flags
> +         to let other PTE Accessed bit readers don't get disturbed.

How about this?

--- a/mm/Kconfig~mm-idle_page_tracking-make-pg_idle-reusable-fix-fix
+++ a/mm/Kconfig
@@ -743,9 +743,9 @@ config PAGE_IDLE_FLAG
 	bool "Add PG_idle and PG_young flags"
 	select PAGE_EXTENSION if !64BIT
 	help
-	  This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
-	  Accessed bit writers can set the state of the bit in the flags to let
-	  other PTE Accessed bit readers don't disturbed.
+	  This adds PG_idle and PG_young flags to 'struct page'.  PTE Accessed
+	  bit writers can set the state of the bit in the flags so that PTE
+	  Accessed bit readers may avoid disturbance.
 
 config IDLE_PAGE_TRACKING
 	bool "Enable idle page tracking"

Also, is there any way in which we can avoid presenting this option to
the user?  Because most users will have real trouble understanding what
this thing is for.  Can we simply select it when needed, as dictated by
other, higher-level config options?

