Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8D3546B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhDESRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhDESRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:17:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD8C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=++XNFzPyzd//NZ9BB9jWIKjHqHx8qgMkSHioi3eojXM=; b=MekK+rs8zjfA+vfgMWfe1SJsuY
        zlEnHx35ARMQkUg8o0cC7pFO7EAKs1KXMgrEKOnOryxPdKpGEswbPG1OqKx+vrmiunM60M3gUSwWd
        Q2tgYMsRHkO/qYVhc9XefxFuuEC3VpWUsT2zDz7WgIoCvsX1tXWFysYs96rAeFvecLrihaXbVF6CV
        rwEMPuDX68tXr8aEiROdT3pIxh9b5axB8egeG1QS82G5VuQ2Hb+5HY1pk3GRvimNgR432DRvH/BGO
        +BOY2rADrNPHwu6OUbnV57MyNSjKXmWOOQWUVijvP5tBY8jAHj9oOB/7QT8sSIT1i64YSAZVfLxFt
        eyDgQMaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTTmA-00Bj2Y-LN; Mon, 05 Apr 2021 18:16:41 +0000
Date:   Mon, 5 Apr 2021 19:16:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] include/linux/mm.h: remove duplicated declaration of
 page_mapping()
Message-ID: <20210405181638.GI2531743@casper.infradead.org>
References: <20210405151355.9867-1-rppt@kernel.org>
 <20210405151355.9867-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405151355.9867-3-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 06:13:55PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are two declarations of page_mapping() in include/linux/mm.h a dozen
> lines apart.
> 
> Remove the older one with unnecessary "extern".

This conflicts with
https://lore.kernel.org/linux-mm/20210331184728.1188084-14-willy@infradead.org/

Andrew, please can we get the folio patches in?
