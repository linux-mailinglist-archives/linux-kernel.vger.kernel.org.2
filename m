Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E78337E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCKTyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCKTyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:54:33 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E927C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ITttnLIDAjW6p8jFI8G92Yf0vP+JR8tXEfhzMuCRptE=; b=CJjA8dllvncZBx4LedSwtL3Rn4
        v0ydgN56OVVq2uoW2IbcFHXg/dxBdum3UGQMpQJY7IzfF19sxYpEB05SN359DqyaUP353kdVj4Z0a
        rJkIyWDjHg8pYFj0jnYr21JJkJzMkX4jwRV8GvPYkB7uRCcrL6wjeUUXSOHL7K2VRW5wGBNxIqI/Q
        X6AbXfW+14+FkEmb4tFU39owoYmik4t9JVpKWV9SclXi/9EOL80scMk7qYsd1avVCI6C83HuEhaye
        wsWS2k7z93EMiF4GhGV5VpTnFbqGSkz/RDwSPBwk12l76UU+PEGn45RIaQzCQDOfCgex5F1wGaTfI
        hg9A1tzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKRNv-00A20e-9x; Thu, 11 Mar 2021 19:54:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C32F9864D0; Thu, 11 Mar 2021 20:54:08 +0100 (CET)
Date:   Thu, 11 Mar 2021 20:54:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, namhyung@kernel.org, jolsa@redhat.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <20210311195408.GJ4746@worktop.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
 <YEoOVTVhN3DpQXl2@hirez.programming.kicks-ass.net>
 <20210311175358.GF203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311175358.GF203350@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:53:58AM -0800, Andi Kleen wrote:
> > AFAICT we could register them all here. That instantly fixes that
> > CPU_STARTING / CPU_DEAD fail elsewhere in this patch.
> 
> This would mean a system that only has Atoms or only has big cores
> would still show the other CPU's PMU. We expect those to exist.

Well, barring enumeration in ACPI/SRAT or thereabout, there's simply no
way to know.

Also, what's the point of making an alderlake with only big cores? Isn't
that what we're supposed to call saphire rappids? Same with only Atoms,
we're supposed to call that a temont.

Anyway, if people want to do weird things and not enumerate it sanely,
they'll get whatever we can make of it.
