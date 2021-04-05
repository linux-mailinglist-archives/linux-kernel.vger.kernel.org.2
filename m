Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BF3546D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhDESuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhDESut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:50:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C54C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pRQfujLgDot1kiIem/5XbHyxFit7Ph17hs4/MTFlKFY=; b=bUrNcXqsJSoO/Qd1ABZk/AFEM5
        HilEtcXnE82Q1HyOP0leHdMZuQExMd7XF5OCVKUh4DlDt0dQRZYqLfl3PdOIo8XJjU7esXMVOa9xs
        9c+kUNzO19s5k6GGMLq/lM+2nR46Z8Mi6xuEeOYFg9E2pZ0Z0gLTvdotHFzpdxTSppzmfogGh+M84
        T1pQHU1MVhQrmkcftynMysoSJlHGWRapfOpUmP24PWRMoVINFE8iXH6796qny5ALjqbnhVmqlWIaV
        YpzqonteKQSbTeRcAqCD7w7+824JwNonOr/HIAzUZx8IizTTVcfeSI93f4TimofSz0iyRG0mxnivM
        MXZcFsww==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTUIn-00BkwH-Gv; Mon, 05 Apr 2021 18:50:27 +0000
Date:   Mon, 5 Apr 2021 19:50:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] minor cleanups of include/linux/mm.h
Message-ID: <20210405185021.GK2531743@casper.infradead.org>
References: <20210405151355.9867-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405151355.9867-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 06:13:53PM +0300, Mike Rapoport wrote:
> I've also noticed that except page_mapping_file() we have somewhat similar
> page_file_mapping(), which seems superfluous, but I didn't dig further to
> see how one of them can be dropped. 

They can't ;-(  I looked at it, and they do different things.

+ * folio_file_mapping - Find the mapping this folio belongs to.
+ * @folio: The folio.
+ *
+ * For folios which are in the page cache, return the mapping that this
+ * page belongs to.  Folios in the swap cache return the mapping of the
+ * swap file or swap device where the data is stored.  This is different
+ * from the mapping returned by folio_mapping().  The only reason to
+ * use it is if, like NFS, you return 0 from ->activate_swapfile.

page_mapping_file() returns NULL for pages which are in the swap cache,
as they no longer need the dcache flushed.
