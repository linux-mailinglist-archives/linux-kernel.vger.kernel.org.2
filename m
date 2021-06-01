Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55154397D61
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhFAX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235308AbhFAX5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F0A961245;
        Tue,  1 Jun 2021 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622591770;
        bh=yfFiRAO2qzwt5suTD0OP/PHywsQqYWDiS6yVtZxYxuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AF2HWHiQ/HgixS6nlEbcoC/W67IRk7fk9n5/lg/x9tnH+k+XQNqO1AdeJEKMa7MZ7
         +OsX1V7Jhab6T5NoTmV0qA2Aj9V1t19Y8BQoRFwBjtNB77NPZlqbwSIV5/NqdWXHsi
         cRm2+M16N1FJsB1UYQsizSAMeJrwdcqb3PPiySgw=
Date:   Tue, 1 Jun 2021 16:56:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [v3 PATCH 1/3] mm/mempolicy: cleanup nodemask intersection
 check for oom
Message-Id: <20210601165609.b3b7bfef54a5f1aad381afb1@linux-foundation.org>
In-Reply-To: <20210601110840.GA80730@shbuild999.sh.intel.com>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
        <1622469956-82897-2-git-send-email-feng.tang@intel.com>
        <YLXtjRYUcaXcYfua@dhcp22.suse.cz>
        <20210601110840.GA80730@shbuild999.sh.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 19:08:40 +0800 Feng Tang <feng.tang@intel.com> wrote:

> This is much clearer, thanks!
> 
> Will change this and the descrition in over-letter.

I pasted Michal's changelog into -mm's
mm-mempolicy-cleanup-nodemask-intersection-check-for-oom.patch.
