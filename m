Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341173584D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhDHNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhDHNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:38:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2154C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DPHvcYZSD+MsWQ3TsSjZDXwfsctCvj9nA7oAeU6axoA=; b=N9ZE5Cl9pDhTV6MNufjUp4OFof
        rGL/sKH9cTP/Rs62/k47u76DRsTkT4YHlsJpFXSHlbF2HEWtxurhMtlWo5X8xcmXb6sFV//YrS8iR
        clDdBh5hQ9IWTkoGzJNVwTbhgk+lJE70WXSKTBxSvreLKEwvWX1Q+U8CJcdORjqCY6WW02T2Akdno
        5viPpBCKKwZPR7mcV/aGFw35yhIzmIqxqhrblUaMatpGHd5kPPx/3IgKU/QhBSD3+y1YS76LL4+DY
        pXaokQfVpJrYh3VGYG21j7w96bkNT7pxWw8MecNvk2MBS9Kjg0QeykaHh7FxKhkJusiFmIwshX/OG
        SArDbUHA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUUq3-00GG9s-5L; Thu, 08 Apr 2021 13:37:19 +0000
Date:   Thu, 8 Apr 2021 14:36:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/8] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Message-ID: <20210408133651.GA3875084@infradead.org>
References: <20210408121804.10440-1-osalvador@suse.de>
 <20210408121804.10440-8-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408121804.10440-8-osalvador@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 02:18:03PM +0200, Oscar Salvador wrote:
> Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
> +	def_bool y

This needs to go into a common file, with the architectures just
selecting the symbol.
