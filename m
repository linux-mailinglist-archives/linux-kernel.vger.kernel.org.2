Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D43603BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhDOHyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhDOHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:54:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F02C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fQSaKqfHXsydzEO757KlFYiV/nEVO1igCa5PgxiPGBo=; b=pnJGXgH2l6VGfPpcE0duoO0Djk
        xxGrqle3mNplxviVZI+sBSjyytRGga0YpgNX1d/EvTxsKZLKN1GVlQUtGziilflIAeXqAWOEDL5wK
        rCLatCfDErPUejS1O6fjE07w1PVgqh1rXRgzMWPFCqzppzmwiAXs9VgymSz4MMsxaK4k/It8Hcpmu
        gQ6sM87GghIRZfCcwUG1I13BolUTVHAh0s/P0pFcq0yWkjKcUt9u7z2KzY1mNlATXHVW+67YORqAd
        dGHTLUEx/Dw5ibfDMnFifSb8wwZ0FGLf/EhD4y8ywFCRq9FlcM5o4WAZStfPsKRxQcLL19EpyHm1l
        jB04gz1A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWwoh-008FsS-Db; Thu, 15 Apr 2021 07:53:43 +0000
Date:   Thu, 15 Apr 2021 08:53:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] x86/events/amd/iommu: Fix sysfs type mismatch
Message-ID: <20210415075335.GA1954964@infradead.org>
References: <20210415001112.3024673-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415001112.3024673-1-nathan@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:11:11PM -0700, Nathan Chancellor wrote:
> dev_attr_show() calls _iommu_event_show() via an indirect call but
> _iommu_event_show()'s type does not currently match the type of the
> show() member in 'struct device_attribute', resulting in a Control Flow
> Integrity violation.

While the fix looks fine I think we need to solve this kind of problem
by better type checking.  The fact that we can use the wong type here
without a compiler warning is the real issue.
