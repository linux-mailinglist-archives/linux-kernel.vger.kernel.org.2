Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C896B379AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhEJXYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 19:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJXYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 19:24:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EFDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lXDf9Pk30zye0BIE8FOubq2RQnAv0zcP4E7U1AqJ5jE=; b=S1kJvn1SXaA7R+bJjReEpGURSo
        PESuut+4W+oAGuT2GEq0a2m87zvLcu/6ErubvTYJvRY1FiuDbPt+PS9sFCJdaeYQ1pxbZXMjFqw/n
        wCCFwZ9hyNt2UZ/3YQWf3EHYkhdHpyA8NWPvcw6K7aQe2v532tnolkDXD/FLU9lQlTAOdE6VmTtQK
        rubqLfW5fneihNSJ9Abf6NFVy/F8zYVYZCOG73zYqCF2uhj9V3QmZ4vRicTHm2nB3/S64UmfUZXm3
        dBFSV31twIEmB9bE2NqFgIlmY4Ox5AYx6mbumzqq++JXyNLvydTHhKgwABS4WlzW/OF8rViaC8QQn
        DW0FBY0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgFF4-006gMs-U8; Mon, 10 May 2021 23:23:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Folio migration
Date:   Tue, 11 May 2021 00:23:05 +0100
Message-Id: <20210510232308.1592750-1-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be part of the folio v10 patch set, but I thought I'd post
them separately to give them a bit of exposure and get early feedback
before I send out v10.

Matthew Wilcox (Oracle) (3):
  mm/migrate: Add folio_migrate_mapping
  mm/migrate: Add folio_migrate_flags
  mm/migrate: Add folio_migrate_copy

 include/linux/ksm.h        |   4 +-
 include/linux/migrate.h    |   4 +
 include/linux/page_owner.h |   8 +-
 mm/folio-compat.c          |  23 ++++
 mm/ksm.c                   |  31 +++--
 mm/migrate.c               | 239 +++++++++++++++----------------------
 mm/page_owner.c            |  10 +-
 7 files changed, 154 insertions(+), 165 deletions(-)

-- 
2.30.2

