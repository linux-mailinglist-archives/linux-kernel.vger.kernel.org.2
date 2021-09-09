Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B24047E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhIIJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:41:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhIIJlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:41:03 -0400
Received: from zn.tnic (p200300ec2f0e450038bb8d0575207cd8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4500:38bb:8d05:7520:7cd8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 390D71EC04EC;
        Thu,  9 Sep 2021 11:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631180389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bnOSlvgwo3fcQLh9riyT6ozqojd3R2De1EiMDBDp+mE=;
        b=lz6ZxGNWTQXEXVjbIOwGQdJS9eL6Oo/eyylPuVbtJg1UUgoWHJCH9DLPLv3vYI8SpieXLq
        BgHd6YzJh6QvYvFEWm/K/gTIgbiXO52Yo119glP3CoVNf7cXU6coc2ZxvE3X9MSAgFPfPC
        cbCP5j5uHQ6ar8e2jlvoDIETpkYvzyI=
Date:   Thu, 9 Sep 2021 11:39:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jinhua Wu <wujinhua@linux.alibaba.com>
Cc:     x86@kernel.org, zelin.deng@linux.alibaba.com,
        jiayu.ni@linux.alibaba.com, ak@linux.intel.com,
        luming.yu@intel.com, fan.du@intel.com,
        artie.ding@linux.alibaba.com, tony.luck@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        pawan.kumar.gupta@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, ricardo.neri-calderon@linux.intel.com,
        peterz@infradead.org
Subject: Re: [PATCH] perf: optimize clear page in Intel specified model with
 movq instruction
Message-ID: <YTnWXIB42sCLbM2k@zn.tnic>
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 04:45:51PM +0800, Jinhua Wu wrote:
> Clear page is the most time-consuming procedure in page fault handling.
> Kernel use fast-string instruction to clear page. We found that in specified
> Intel model such as CPX and ICX, the movq instruction perform much better
> than fast-string instruction when corresponding page is not in cache.
> But when the page is in cache, fast string perform better. We show the test
> result in the following:

What you should do is show the extensive tests you've run with
real-world benchmarks where you really can show 40% performance
improvement.

Also, the static branch "approach" you're using ain't gonna happen. If
anything, another X86_FEATURE_* bit.

Good luck.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
