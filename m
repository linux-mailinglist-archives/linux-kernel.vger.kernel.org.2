Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4030B3B7EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhF3I3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:29:07 -0400
Received: from muru.com ([72.249.23.125]:59306 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbhF3I3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:29:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C0BC080E5;
        Wed, 30 Jun 2021 08:26:48 +0000 (UTC)
Date:   Wed, 30 Jun 2021 11:26:33 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/4] memblock, arm: fixes for freeing of the memory map
Message-ID: <YNwquYgqR4PZtE+/@atomide.com>
References: <20210630071211.21011-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630071211.21011-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Mike Rapoport <rppt@kernel.org> [210630 07:12]:
> From: Mike Rapoport <rppt@linux.ibm.com>
> v3: 
> * Add patch 3/4 to ensure there is no overflow in memblock_overlaps_region()

This series boots for me, so:

Tested-by: Tony Lindgren <tony@atomide.com>
