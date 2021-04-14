Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72AE35EF54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349988AbhDNIPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349976AbhDNIPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:15:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B83BAED7;
        Wed, 14 Apr 2021 08:14:47 +0000 (UTC)
Date:   Wed, 14 Apr 2021 10:14:44 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Xu <weixugc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration
 order
Message-ID: <20210414081444.GC20886@linux>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183219.DC1928FA@viggo.jf.intel.com>
 <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com>
 <20210414080849.GA20886@linux>
 <926bd5f9-bf05-2e01-26da-da3f66439d3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926bd5f9-bf05-2e01-26da-da3f66439d3b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:12:29AM +0200, David Hildenbrand wrote:
> My guest best is that fast class is something like HBM (High Bandwidth
> Memory), medium class is ordinary RAM, slow class is PMEM.

I see, thanks for the hint David ;-)

-- 
Oscar Salvador
SUSE L3
