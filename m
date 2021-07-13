Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F963C69EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhGMFzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGMFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:55:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF3C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 22:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WatLwdUn+MRC+mUmfvS6Uq3Tmp2WWST7/esRxh48uXU=; b=a+pOJjw0ES3TbCZhvHqNczuvvV
        3LRDNxUB3xGvV/SUN/7rK9+efUSdPnO8A9MfKLY+gjvIE2YLeGmK7oaImZlX8SCTsfMaDzZGOpeym
        k7N6do0ZPNoERYNgSGSLa3/eCwsGx2SZAToEe/uL6YjPYt+XdUn9pnCfAOvz6Y7K70qC//DAMDO2r
        3FNWTuwQBgRTx9IkIqdzcR+F2GfxNX9q4f4I/PE7OSoN9a+EhMEEY+vEOFhf4mEdTKsPUgZTC+veG
        yYIr/jtcCprXvD5xJ6UtkPZ3eHdShs8JpxdeX+dya70P8q5EfxKRUjjPlYj0O/DCz26FuIlwaYAVz
        rrP4Bqwg==;
Received: from [2001:4bb8:184:8b7c:e5e6:2d8f:6506:596e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3BLM-000mbE-TH; Tue, 13 Jul 2021 05:52:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: fix memcpy_to_page and memzero_page
Date:   Tue, 13 Jul 2021 07:52:29 +0200
Message-Id: <20210713055231.137602-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we need to call flush_dcache_page on any kmapped page, and on any page
we write to that may be mapped into the page cache, which can happen
quite frequently for anything we use raw pages for.

Patch 1 make sure memcpy_to_page and memzero_page to do the right thing
for that, and patch 2 fixes up the lost switch to kmap_local_page for
memzero_page.
