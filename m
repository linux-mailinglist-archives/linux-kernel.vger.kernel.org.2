Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A8337F26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCKUiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhCKUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:38:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3I1yRRdhTBLHc0OA8DvywSl+Ns+3R5dNieYIUVq/gHo=; b=rdBLWI2nuU+Ye9GvN6AjPfMPZP
        Nzbja38yEHTAj+XFQUa7t55qcgE/Bu8NdvbSBl1XOOLCHiUMc9y2QBhxq/b3Nq9jeelpMO7rDZIKL
        5rxXFnSfn4Px+SBX3hXNi65KS6nbKhtZR8XX84g4fR/1zC+s14I80+07o26nODB4VvoF7mZ967liw
        TuxeBQisII1fM2SgRGC06pSgmhJ6c3dvRPBbliTjyeSCYvkmeZ6Q975IacDgs9hKWEzFSaRYqxEt7
        fH/9lTSuHGAE9AtAUZTAQextezozw7/RX6sa0thm86Heka30r4GBGOXuh739F7tA8SmFwRNheOSeI
        VQ25FN9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKS43-008ZxL-Qd; Thu, 11 Mar 2021 20:37:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7F999864D0; Thu, 11 Mar 2021 21:37:46 +0100 (CET)
Date:   Thu, 11 Mar 2021 21:37:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, namhyung@kernel.org, jolsa@redhat.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <20210311203746.GL4746@worktop.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
 <20210311195832.GK4746@worktop.programming.kicks-ass.net>
 <20210311203053.GK203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311203053.GK203350@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:30:53PM -0800, Andi Kleen wrote:

> But what would you do with the information that the core is related
> to some other core.

Reduce mental clutter I suppose... there are simply too many variations
of all this about :-(

> In the end you need to know that Alderlake is Alderlake.

*sigh*, okay.
