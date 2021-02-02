Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B630BA2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhBBInk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhBBInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:43:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F0C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LMKxm51u7GIF4wA49UhO1hNwr0RMWL6oQDYDdCQ2lqA=; b=pTRuAtx0tyR2wbUH6x4nowryFU
        eV/JKZXX//FXeE3tex/7f8qWwJ4S0a3tb2Ayvh86QiZu3Yxmke5s5OP0w9bBpXx1j7w3fKlS6nqoU
        XdiVJSaH0mDrei83j756AWK028ZtSf6KTi/NZIh/8XtF0YCeVAs/J0XTsqcDHec8TMVFzPokIm+I0
        JF7ez2PdA7RlnlIxt6WU5htjx3zUMqEysdVq65mdQWAYkYSgJkOcMUvpK4xuG1HPSSWvxi5EZQZPh
        +QXZ+wEXfLODQI2RM7VV9kKLp5TP02dxzBoxbFqpaRwmKaKp238fXjuswEyJcBYAmgYiKx2sp1LL9
        1JTdWgmA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6rGl-00EwIn-AX; Tue, 02 Feb 2021 08:42:44 +0000
Date:   Tue, 2 Feb 2021 08:42:43 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, mark.rutland@arm.com, steve.capper@arm.com,
        rfontana@redhat.com, selindag@gmail.com,
        tyhicks@linux.microsoft.com
Subject: Re: [PATCH 1/1] arm64: hibernate: add __force attribute to gfp_t
 casting
Message-ID: <20210202084243.GA3558964@infradead.org>
References: <20210201150306.54099-1-pasha.tatashin@soleen.com>
 <20210201150306.54099-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201150306.54099-2-pasha.tatashin@soleen.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:03:06AM -0500, Pavel Tatashin wrote:
> Two new warnings are reported by sparse:
> 
> "sparse warnings: (new ones prefixed by >>)"
> >> arch/arm64/kernel/hibernate.c:181:39: sparse: sparse: cast to
>    restricted gfp_t
> >> arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from
>    restricted gfp_t
> 
> gfp_t has __bitwise type attribute and requires __force added to casting
> in order to avoid these warnings.
> 
> Fixes: 50f53fb72181 ("arm64: trans_pgd: make trans_pgd_map_page generic")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

What about just passing the gfp_t value by reference which would be much
cleaner?
