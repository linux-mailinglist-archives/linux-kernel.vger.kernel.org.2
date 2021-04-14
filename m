Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CEA35F462
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347975AbhDNM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:49020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245302AbhDNM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:57:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618405023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+w+doFRnM6iY+fRIpERpdwIg1rc2U9HH42pADKqP4j8=;
        b=JdoQpDwjnQsJnIYwOIXXZz0RGzSfSrvtqMvebSvU89RDO+cST3wMf+RwWF9IahH0CnAzpw
        JawBFBBCaopLjxs06SbuCyi7SVgAkp+oC9khvOOjOZFC6jXLHxDiZ0O9c81oJkeEpzMceG
        IXVHMrDbV48/8azeCFhGNxAhG8RrDQI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCB9BAFCF;
        Wed, 14 Apr 2021 12:57:02 +0000 (UTC)
Date:   Wed, 14 Apr 2021 14:57:02 +0200
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
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 05/13] mm/mempolicy: refactor rebind code for
 PREFERRED_MANY
Message-ID: <YHbmnrR1bwkm9XLd@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-6-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-6-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 11:40:02, Feng Tang wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Again, this extracts the "only one node must be set" behavior of
> MPOL_PREFERRED.  It retains virtually all of the existing code so it can
> be used by MPOL_PREFERRED_MANY as well.
> 
> v2:
> Fixed typos in commit message. (Ben)
> Merged bits from other patches. (Ben)
> annotate mpol_rebind_preferred_many as unused (Ben)

I am giving up on the rebinding code for now until we clarify that in my
earlier email.
-- 
Michal Hocko
SUSE Labs
