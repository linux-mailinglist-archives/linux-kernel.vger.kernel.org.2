Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AC3AC029
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 02:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhFRAqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 20:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232027AbhFRAqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 20:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20C266120A;
        Fri, 18 Jun 2021 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623977062;
        bh=BH7cSMvCFZpOajnaEX4oiTYblz1wH8Z8rmAGTo9a48w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQQ0T7IBaWitPyRQjZYnlby+ZwKf5HcKpIHgAYIk09sqan6DvLyb45STAmdNxyOg9
         7FZ9YqB8oN6NB5HfLkUQvDCqSeCoWlJyvz8fAy1k2IlGBbs6uwcGsWM0Xr7GUZuXlR
         PMlRIUmKWVfYw2TOUY1E7I7mmSgG6NP4p7sah5X/z1Xb1qTAQnxWCO2STcfHw1Z024
         /EoPSZD6eTHQOdmYZOFLTMLDlHJbV7nSZYWacNx6MhnbLE/C9kYBK/wAYdNL4ncQec
         lH+zRBHiaulqXmbdt85IeqKBIOQdRy/YcDgeu5fATKfq9A7/+yCCy8qUW8lazzWA0/
         NPjrTCzuc9SSg==
Date:   Thu, 17 Jun 2021 17:44:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, sjenning@redhat.com, ddstreet@ieee.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/zbud: don't export any zbud API
Message-ID: <YMvsYm8b+yTIrqBC@archlinux-ax161>
References: <20210608114515.206992-1-linmiaohe@huawei.com>
 <20210608114515.206992-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608114515.206992-3-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:45:15PM +0800, Miaohe Lin wrote:
> The zbud doesn't need to export any API and it is meant to be used via
> zpool API since the commit 12d79d64bfd3 ("mm/zpool: update zswap to use
> zpool"). So we can remove the unneeded zbud.h and move down zpool API
> to avoid any forward declaration.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

This patch causes several new warnings when CONFIG_ZPOOL is disabled:

mm/zbud.c:222:26: warning: unused function 'zbud_create_pool' [-Wunused-function]
mm/zbud.c:246:13: warning: unused function 'zbud_destroy_pool' [-Wunused-function]
mm/zbud.c:270:12: warning: unused function 'zbud_alloc' [-Wunused-function]
mm/zbud.c:345:13: warning: unused function 'zbud_free' [-Wunused-function]
mm/zbud.c:417:12: warning: unused function 'zbud_reclaim_page' [-Wunused-function]
mm/zbud.c:499:14: warning: unused function 'zbud_map' [-Wunused-function]
mm/zbud.c:509:13: warning: unused function 'zbud_unmap' [-Wunused-function]
mm/zbud.c:520:12: warning: unused function 'zbud_get_pool_size' [-Wunused-function]

It seems to me like all of these functions should be sunk into their
callers and eliminated entirely as part of this refactoring. I took a
whack at it but got lost with the kernel docs so someone who is familiar
with this should probably do it.

Cheers,
Nathan
