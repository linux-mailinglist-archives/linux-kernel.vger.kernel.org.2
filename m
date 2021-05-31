Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4115396957
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhEaVnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhEaVnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:43:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F7F761005;
        Mon, 31 May 2021 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622497289;
        bh=H2WLMsKJwsJTdkHL+YrGxee/qD2u+/tQaEtbrsoPLmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0zenZpS8clh6zjSsj3W3sDHD397nXxO4EI4+r60fm4T23eznAe0wgGWqqoF8lN2By
         CTXgCJdhkrIQvxIu3ViDsJSmY/csqYeUTuBDx0OLQDkiO5OQQfaGmFmEna2hnbm09g
         4C37AeWwJMB+iBpSo1AStoa2Htx/1/AWzs4xFfSU=
Date:   Mon, 31 May 2021 14:41:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
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
Subject: Re: [v3 PATCH 0/3] mm/mempolicy: some fix and semantics cleanup
Message-Id: <20210531144128.e69aaf2904e83ae170f00f06@linux-foundation.org>
In-Reply-To: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 22:05:53 +0800 Feng Tang <feng.tang@intel.com> wrote:

> We've posted v4 patchset introducing a new "perfer-many" memory policy
> https://lore.kernel.org/lkml/1615952410-36895-1-git-send-email-feng.tang@intel.com/ ,
> for which Michal Hocko gave many comments while pointing out some
> problems, and we also found some semantics confusion about 'prefer'
> and 'local' policy, as well as some duplicated code. This patchset
> tries to address them. Please help to review, thanks!
> 
> The patchset has been run with some sanity test like 'stress-ng'
> and 'ltp', and no problem found.

None of the above is suitable for the [0/n] overall description.  I
copied-n-pasted the v1 cover letter from the above link.  Please check
that it is all still correct and up to date.  If not, please send along
replacement text, thanks.

