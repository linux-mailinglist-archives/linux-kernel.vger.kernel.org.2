Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D526144AC12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbhKILBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:01:34 -0500
Received: from verein.lst.de ([213.95.11.211]:49658 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241381AbhKILBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:01:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B81E67373; Tue,  9 Nov 2021 11:58:40 +0100 (CET)
Date:   Tue, 9 Nov 2021 11:58:40 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] i915/gvt: seperate tracked MMIO table from
 handlers.c
Message-ID: <20211109105840.GA9675@lst.de>
References: <20211108212718.10576-1-zhi.a.wang@intel.com> <875yt17qzs.fsf@intel.com> <5dd106e7-e62f-dfcd-bfa1-3f92794b8e3e@intel.com> <87o86t636f.fsf@intel.com> <20211109103622.GA7607@lst.de> <ddff22c4-fa19-24b4-c5e5-9910abb02bf6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddff22c4-fa19-24b4-c5e5-9910abb02bf6@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 10:51:27AM +0000, Wang, Zhi A wrote:
> Can you elaborate more about this? We need the hash query from the table 
> ASAP when the hypervisor trapped a mmio access. It's a critical path and 
> we tried different data structure in the kernel and the hash table gives 
> the best performance.

Ok, I misunderstood the hashtable.h interface.  hash_for_each_possible
actually does a hash lookup instead of an interation despite the rather
misleading name.
