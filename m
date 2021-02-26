Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E649032624C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBZMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:07:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZMHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:07:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 387D7B13D;
        Fri, 26 Feb 2021 12:06:52 +0000 (UTC)
Date:   Fri, 26 Feb 2021 13:06:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 4/7] mm,memory_hotplug: Enforce struct page size to be
 multiple of PMD
Message-ID: <20210226120649.GC3661@localhost.localdomain>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-5-osalvador@suse.de>
 <13253f19-d0e9-e27c-046a-c2669c5ee33d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13253f19-d0e9-e27c-046a-c2669c5ee33d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:26:50PM +0100, David Hildenbrand wrote:
> Squash that into #1 - it's part of basic operation.

Ok, will do.


-- 
Oscar Salvador
SUSE L3
