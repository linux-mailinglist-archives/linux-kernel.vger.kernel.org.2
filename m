Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02D337F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 21:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhCKUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 15:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 15:47:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B57CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ADqGp1Gf8Bq27BfvbsQdN1h9JeqIc1TYdbcW6KXgZiU=; b=meJG81HkB3dvziV2l8qNhIZUIc
        xOz8pKFaYIBCaNkGnGGLzfqYMSYotK2AfSMMWWz9NtW63pCOsVkjqm4SbcImwf2Q6J7tgvYR7UFz8
        ruuIy/H8ZUyE5M250cKoCBjxJkamkp2YGfLE9EYGI9YY+rG0v5R+DBiwh3mVe+eVq1mnInC3DQLP8
        Ed4cv1eUVuvKV3xmMKsPVhjSXmdb6DUcWVnmSk+SqnoOnY7u3A1eyy6fnYYQHTXL4JLv1b/QmabXM
        kNgJj01uQNedmfUH61S9eZ1d71l7hbo9c5sNFsGtvrpKlH6a5IzB2zRSLhefF+Edj81UUSb3MKb2S
        /LZQii+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKSDf-00A4wj-7X; Thu, 11 Mar 2021 20:47:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDA629864D0; Thu, 11 Mar 2021 21:47:42 +0100 (CET)
Date:   Thu, 11 Mar 2021 21:47:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, namhyung@kernel.org, jolsa@redhat.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Mark Rutland <mark.rutland@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        tony.luck@intel.com
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <20210311204742.GM4746@worktop.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
 <01176076-049b-0129-4865-8c49cd002060@linux.intel.com>
 <20210311195832.GK4746@worktop.programming.kicks-ass.net>
 <400dbd6e-389c-899d-6d11-14b5a8f8f90e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400dbd6e-389c-899d-6d11-14b5a8f8f90e@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:32:44PM -0500, Liang, Kan wrote:
> I think the "sapphire_rapids" is the code name for the server platform.

If that's really the case, then:

#define INTEL_FAM6_SAPPHIRERAPIDS_X     0x8F

is wrong, those things should be uarch name, not platform name. Tony?

