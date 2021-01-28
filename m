Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EE8307767
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhA1Nq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:46:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:34654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhA1Nqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:46:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B504AF78;
        Thu, 28 Jan 2021 13:46:13 +0000 (UTC)
Date:   Thu, 28 Jan 2021 14:46:10 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
Message-ID: <20210128134610.GB8136@localhost.localdomain>
References: <20210127101813.6370-1-david@redhat.com>
 <20210127101813.6370-3-david@redhat.com>
 <20210128102234.GB5250@localhost.localdomain>
 <2246d657-4f6d-c27d-4ae2-853a8437cda9@redhat.com>
 <20210128134458.GA8136@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128134458.GA8136@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:44:58PM +0100, Oscar Salvador wrote:
> Btw, should linux-uapi be CCed, as /proc/vmstat layout will change?

I meant /proc/zoneinfo

> 
> -- 
> Oscar Salvador
> SUSE L3
> 

-- 
Oscar Salvador
SUSE L3
