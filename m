Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C594035F469
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351019AbhDNM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:59:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhDNM7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:59:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618405123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LdKFu9B1ttnJUcjp1tP1KvNZ4bFQ4ZCDRyCzjQcBJc=;
        b=gymcCEr9pp2rQ6NTQyeeLND8/5HtaCElUhpTS/yJwi8+tpPw1EsvMmna67RzPmrhaycDs4
        uCRWlfwby7B9PUhzi4+7Q/bfXDBm0MHx1doeKikLggVnaIR1sJYeIx87txIsMK3umvTES1
        mDyGXDFIvs4aRRwWaPxtVkqaoCgnH3g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80AA6AFCF;
        Wed, 14 Apr 2021 12:58:43 +0000 (UTC)
Date:   Wed, 14 Apr 2021 14:58:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 06/13] mm/mempolicy: kill v.preferred_nodes
Message-ID: <YHbnAii50shoetsp@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-7-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-7-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 11:40:03, Feng Tang wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Now that preferred_nodes is just a mask, and policies are mutually
> exclusive, there is no reason to have a separate mask.
> 
> This patch is optional. It definitely helps clean up code in future
> patches, but there is no functional difference to leaving it with the
> previous name. I do believe it helps demonstrate the exclusivity of the
> fields.

Yeah, let's just do it after the whole thing is merged. The separation
helps a bit to review the code at this stage because it is so much
easier to grep for preferred_nodes than nodes.
-- 
Michal Hocko
SUSE Labs
