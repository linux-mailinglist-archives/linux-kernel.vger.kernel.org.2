Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960F842E636
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhJOBoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:44:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:18332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhJOBo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:44:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="288695890"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="288695890"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:42:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="592827275"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:42:21 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     dave.hansen@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: make demotion knob depend on migration
References: <20211015005559.246709-1-shy828301@gmail.com>
Date:   Fri, 15 Oct 2021 09:42:19 +0800
In-Reply-To: <20211015005559.246709-1-shy828301@gmail.com> (Yang Shi's message
        of "Thu, 14 Oct 2021 17:55:59 -0700")
Message-ID: <875ytznjwk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> The memory demotion needs to call migrate_pages() to do the jobs.  And
> it is controlled by a knob, however, the knob doesn't depend on
> CONFIG_MIGRATION.  The knob could be truned on even though MIGRATION is
> disabled, this will not cause any crash since migrate_pages() would just
> return -ENOSYS.  But it is definitely not optimal to go through demotion
> path then retry regular swap every time.
>
> And it doesn't make too much sense to have the knob visible to the users
> when !MIGRATION.  Move the related code from mempolicy.[h|c] to migrate.[h|c].

Sounds reasonable to me.  Thanks!

> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying
