Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB730791C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhA1PGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhA1PFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:05:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C33C061574;
        Thu, 28 Jan 2021 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i2BpbjiEMy/uoZsV+pGyxXHIRXV75JS+gpJXaA6/Vt8=; b=uVQQCvvuifCvUNXxKzqoRVkwCg
        EsPu11izlSdVbGdWwh4F+y57Z2DPUgDJPXg3NePMa092xK+QeqQ8ov3tLWJeJbnRIVVHScPtdd/dB
        pNEhjfVmx5qzUx9y50jFU84q0vf1eY8GW9YXZJ9bzbIJQSVkMrYysBXdjCpurDVoGURqNuM2KSHRD
        NLZRZHr37qIy2UirH5j+biqJRZ/zAYA5zpbVQQWueuvy+d7nNSk7vjeGD3ysYBq78+XMM5BfovMfn
        vPcQV29IHOWLJIYfgbg4wS13zfzu0RSCjGAWfmXQ73wo2pRbHS09QjG8NW+gbzIFn3kwqII4h6mnf
        vpl+50Kg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l58qi-008bRt-3T; Thu, 28 Jan 2021 15:04:48 +0000
Date:   Thu, 28 Jan 2021 15:04:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Saravanan D <saravanand@fb.com>
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        songliubraving@fb.com
Subject: Re: [PATCH V5] x86/mm: Tracking linear mapping split events
Message-ID: <20210128150444.GY308988@casper.infradead.org>
References: <20210128045153.GW308988@casper.infradead.org>
 <20210128104934.2916679-1-saravanand@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128104934.2916679-1-saravanand@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:49:34AM -0800, Saravanan D wrote:
> One of the many lasting (as we don't coalesce back) sources for huge page
> splits is tracing as the granular page attribute/permission changes would
> force the kernel to split code segments mapped to huge pages to smaller
> ones thereby increasing the probability of TLB miss/reload even after
> tracing has been stopped.

You didn't answer my question.

Is this tracing of userspace programs causing splits, or is it kernel
tracing?  Also, we have lots of kinds of tracing these days; are you
referring to kprobes?  tracepoints?  ftrace?  Something else?
