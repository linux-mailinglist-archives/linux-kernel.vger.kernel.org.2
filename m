Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB213BB58D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 05:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGEDXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 23:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhGEDXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB13C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 20:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uyi3dGXOAbIOJd7YWHBSfk15jYVVRDs3BwEnju0HB+g=; b=iCDc5WaFLUOylkXScUecwCi8xL
        luN19mrIQDU4G+Y0GREridkhZtrH8YBG+1+abFaOpeZO7VxyvF92UqRyQb6nP535rJ+gc+Tf7cB5a
        /FoKo/8TokUJOYSP6XH2TeWQRsdOXT4TKXZsdPxFfZHuq2N1AqYqXHnr1zHJd5EKNeLXJIT8tHo2B
        ZPlLpZvpT2urW9fzh8qeIp2LrrBclfsH/kPiY7glKG1xtPSxHoI7xXX5c7WyRoDCjL1XQAunLGBzV
        QYa6UCtiPYX0SIyhesPZtoXgaqtne5IGbwbEB8xVgYxyNyof9xL/kYqXzsjB4JN0INA9oVE7rynFD
        kxUF2BNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0F9U-009qSU-3E; Mon, 05 Jul 2021 03:20:20 +0000
Date:   Mon, 5 Jul 2021 04:20:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     yee.lee@mediatek.com
Cc:     linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        nicholas.Tang@mediatek.com, Kuan-Ying.lee@mediatek.com,
        chinwen.chang@mediatek.com, Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v5 1/2] mm: introduce helper to check slub_debug_enabled
Message-ID: <YOJ6aPuNOtzjVhBC@casper.infradead.org>
References: <20210705024101.1567-1-yee.lee@mediatek.com>
 <20210705024101.1567-2-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705024101.1567-2-yee.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 10:40:57AM +0800, yee.lee@mediatek.com wrote:
> From: Marco Elver <elver@google.com>
> 
> Introduce a helper to check slub_debug_enabled, so that we can confine
> the use of #ifdef to the definition of the slub_debug_enabled_unlikely()
> helper.

We don't usually embed '_unlikely' in function names; we
just do:

static inline bool slub_debug_enabled(void)
{
	return static_branch_unlikely(&slub_debug_enabled);
}

eg:

static inline bool cpusets_enabled(void)
{
        return static_branch_unlikely(&cpusets_enabled_key);
}

#define cgroup_bpf_enabled(type) static_branch_unlikely(&cgroup_bpf_enabled_key[type])

static inline int ip_tunnel_collect_metadata(void)
{
        return static_branch_unlikely(&ip_tunnel_metadata_cnt);
}

static inline bool frontswap_enabled(void)
{
        return static_branch_unlikely(&frontswap_enabled_key);
}

