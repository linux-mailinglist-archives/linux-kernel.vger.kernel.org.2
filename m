Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DFA30BAE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhBBJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBBJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:26:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KVcoQAis9qpVojAZk6ftMIgV9FoGH70poOL+UM2Palk=; b=jMFN/LuTCF7Kdzd7ADLDJY8w77
        kYruwQQOCl92kCYLWcT6G6gsZ4lb6WoIq0XO5t7sMpAgU+dhvG/bxYiuBIX9anxZUA0xB16l/w/rV
        axXK9F72kAjhwioKmfXwWPyHP5mGv+XG0oCRe2YSYswVjstt4zqMuZ3X8VdtmFU4rf1Sh78YSgbQN
        NhwvcLLMpQWitqEsf+d1xQMXOkq/HuBda1CPDlG/DuD5E5sG0YVF3EAssj07IXfaGRfMO2DdprKbP
        DHG07wnBGP/nG+aiINHZ2PpxnqN3da6maJiFOCrQF3q6DnrSrGHU/B2AK6g5okQfE+ovWRdzKtiAi
        XEQZMjHA==;
Received: from [2001:4bb8:198:6bf4:7f38:755e:a6e0:73e9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6rw8-00Ez5i-Fu; Tue, 02 Feb 2021 09:25:30 +0000
Date:   Tue, 2 Feb 2021 10:25:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for 5.11
Message-ID: <YBkahgjZ1hnpplH1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.11-1

for you to fetch changes up to d17405d52bacd14fe7fdbb10c0434934ea496914:

  dma-mapping: benchmark: fix kernel crash when dma_map_single fails (2021-01-27 17:18:38 +0100)

----------------------------------------------------------------
dma-mapping fix for 5.11

 - fix a kernel crash in the new dma-mapping benchmark test (Barry Song)

----------------------------------------------------------------
Barry Song (1):
      dma-mapping: benchmark: fix kernel crash when dma_map_single fails

 kernel/dma/map_benchmark.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
