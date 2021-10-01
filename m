Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184541EDA3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353803AbhJAMju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJAMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:39:49 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED16C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 05:38:04 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CEA412FF; Fri,  1 Oct 2021 14:38:00 +0200 (CEST)
Date:   Fri, 1 Oct 2021 14:37:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] x86/mm: Flush global TLB when switching to
 trampoline page-table
Message-ID: <YVcBGYKQU5dFggvy@8bytes.org>
References: <20210929145501.4612-1-joro@8bytes.org>
 <20210929145501.4612-4-joro@8bytes.org>
 <18be825f-b3f3-3e05-1b14-82712d9a6c0d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18be825f-b3f3-3e05-1b14-82712d9a6c0d@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 08:07:10AM -0700, Dave Hansen wrote:
> 	/*
> 	 * The CR3 writes above may not flush global TLB entries.
> 	 * Stale, global entries from previous sets of page tables may
> 	 * still be present.  Flush those stale entries.
> 	 *
> 	 * This ensures that memory accessed while running with
> 	 * trampoline_pgd is *actually* mapped into trampoline_pgd.
> 	 */

Yes, this is better. I replaced my comment with this one (only did some
minor rewording).

Thanks,

	Joerg
