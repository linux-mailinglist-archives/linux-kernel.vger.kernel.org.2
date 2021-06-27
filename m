Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7A3B558F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhF0WjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhF0WjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:39:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D187C061574;
        Sun, 27 Jun 2021 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZAptBywAoHBGwItSc5F6X3/jFjFcVjPnCyB17Chtz8A=; b=ffgjZk2YVg4c5jyGsWHCo1SfYB
        r/MKcYi/mEchr0HKJskO8arPmLmFrs1VxZyXCz+Xs0nH7gQ4c1txTEFZkZNxbj3MMA68ZgofT5Qz7
        3a3l2qof4b6YOrEpe7pg/X9Lvm5g60lIMQTZ2kKHXfQbC53wGsD8zfWDVoXKT9tgtObo2Yuznglsk
        +U4WEu3NWP10zZi3pULm+SQ1Yq/Yucl+RMEbwnJfeRpTtZymsBzLkpReVmK54OE/WWeKbttnNGizQ
        NCM7893RQnkLKLTyeXFcwU2jhQhlfjPgA3dFAnBTZH3YnrBF5/2bk0zBPqFnyJOVA5LVZo0F9TRl6
        cQrGxNxg==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxdOK-006FR6-NC; Sun, 27 Jun 2021 22:36:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org
Subject: [PATCH] x86/SGX: drop spurious kernel-doc notation
Date:   Sun, 27 Jun 2021 15:36:39 -0700
Message-Id: <20210627223639.27714-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop mistaken kernel-doc notation where plain C comments
should be used instead.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-sgx@vger.kernel.org
---
 arch/x86/kernel/cpu/sgx/encl.h  |    2 +-
 arch/x86/kernel/cpu/sgx/encls.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210625.orig/arch/x86/kernel/cpu/sgx/encl.h
+++ linux-next-20210625/arch/x86/kernel/cpu/sgx/encl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * Copyright(c) 2016-20 Intel Corporation.
  *
  * Contains the software defined data structures for enclaves.
--- linux-next-20210625.orig/arch/x86/kernel/cpu/sgx/encls.h
+++ linux-next-20210625/arch/x86/kernel/cpu/sgx/encls.h
@@ -11,7 +11,7 @@
 #include <asm/traps.h>
 #include "sgx.h"
 
-/**
+/*
  * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
  *
  * ENCLS has its own (positive value) error codes and also generates
