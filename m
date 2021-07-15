Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07B3C98D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhGOGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhGOGiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:38:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D74C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CBl2VbaTdlKaH4VdQOVbFJXpYe5+X4n0PYeP3gGFhmw=; b=HVx5UynZUPZuFSLz1peXEzSiui
        fHGlitA5xB/4BNt7w4RTcKEKAgwaLusWMwKEzR5DcPnKgA042rT0ykbOH2gd5iyb0lak+N2DeEKbX
        /Cp8E78iwPXeic83+AOir9G5hKZr/NpKW/xPtL6+NR68k1TA32s8th1Yc1ZI8CoeFKFw362DKfIKv
        xN1ESk5G3ObdxLzTD4f+boNFRjZC+GI0XelAWbo+tG/27DAVoJKHjB5q8IF/8ix40WjRUPp5guFJQ
        an62NYznW4UVydbRgLN0jNhebePBI3caQ4TPRo8FSDjPc5dtA7xY50PkhozSqarP4C6J2GXxQKr1F
        v5I4p7fg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3uxR-0033qb-UF; Thu, 15 Jul 2021 06:35:00 +0000
Date:   Thu, 15 Jul 2021 07:34:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
Message-ID: <YO/XDUoj1N7tlZKa@infradead.org>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
 <20210713135625.7615-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713135625.7615-5-mgorman@techsingularity.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 02:56:25PM +0100, Mel Gorman wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
> 
> Fix an unresolved symbol error when CONFIG_DEBUG_INFO_BTF=y:

I still fundamentally disagreed with this "fix".  Whatever code requires
a function to be non-static without a prototype and reference is
completely fucked up beyond rescue and needs to be disabled util
it can be fixed instead of worked around like this.
