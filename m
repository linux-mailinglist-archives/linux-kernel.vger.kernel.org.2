Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32D93C2140
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhGIJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:11:35 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:33629 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhGIJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:11:34 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id CC1321C5B59
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:08:50 +0100 (IST)
Received: (qmail 7687 invoked from network); 9 Jul 2021 09:08:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jul 2021 09:08:50 -0000
Date:   Fri, 9 Jul 2021 10:08:49 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
Message-ID: <20210709090848.GW3840@techsingularity.net>
References: <20210708191128.153796-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210708191128.153796-1-mcroce@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:11:28PM +0200, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
> 
> Fix an unresolved symbol error when CONFIG_DEBUG_INFO_BTF=y:
> 
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED unresolved symbol should_fail_alloc_page
> make: *** [Makefile:1199: vmlinux] Error 255
> make: *** Deleting file 'vmlinux'
> 
> Fixes: f7173090033c ("mm/page_alloc: make should_fail_alloc_page() static")
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
