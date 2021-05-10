Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67673378223
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhEJKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhEJK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:29:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88EA361585;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=wRCPZxwcb4aQlpdTldV62EU+oqlKIy6S2oX2pJUR1hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYzB/ilWd4xxS5j4uvGTw4fSvsRTkp9c6MH9MwAA+58CS5uAqXLAjTtL+D2VrX0fn
         PNYioxfJQJxpVgG4ATLkNtVdag8fJ4TRytLHub6crU0GDljl7xCSXQ/6jxfRCXD9Tk
         84/H3XhuCNSp8Ux34Q1A3gfuZL2gy4u0+XlkkgLE0zY8NGjNYR9fHbGmGFjw+rfAOn
         wVRMsOCvuh6WRtxNYkIJiVbc/xnUshuFLu+6tsOAWmPdvvklyArbSTylNSPYV4UYUI
         8WYq6TqndBu4vzbRHpyaTfib5LVpPJkVcjYXSYc0Foq6CfN33VNV0FG4ADr6TIBbVF
         vIhPQ/a47jQ/w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UP2-RV; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/53] docs: trace: coresight: coresight-etm4x-reference.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:23 +0200
Message-Id: <859218d35d495d5d2c2893bf8e6e087394a107a7.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE
	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../coresight/coresight-etm4x-reference.rst      | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
index b64d9a9c79df..e8ddfc144d9a 100644
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -15,14 +15,14 @@ Root: ``/sys/bus/coresight/devices/etm<N>``
 
 The following paragraphs explain the association between sysfs files and the
 ETMv4 registers that they effect. Note the register names are given without
-the ‘TRC’ prefix.
+the 'TRC' prefix.
 
 ----
 
 :File:            ``mode`` (rw)
 :Trace Registers: {CONFIGR + others}
 :Notes:
-    Bit select trace features. See ‘mode’ section below. Bits
+    Bit select trace features. See 'mode' section below. Bits
     in this will cause equivalent programming of trace config and
     other registers to enable the features requested.
 
@@ -89,7 +89,7 @@ the ‘TRC’ prefix.
 :Notes:
     Pair of addresses for a range selected by addr_idx. Include
     / exclude according to the optional parameter, or if omitted
-    uses the current ‘mode’ setting. Select comparator range in
+    uses the current 'mode' setting. Select comparator range in
     control register. Error if index is odd value.
 
 :Depends: ``mode, addr_idx``
@@ -277,7 +277,7 @@ the ‘TRC’ prefix.
 :Trace Registers: VICTLR{23:20}
 :Notes:
     Program non-secure exception level filters. Set / clear NS
-    exception filter bits. Setting ‘1’ excludes trace from the
+    exception filter bits. Setting '1' excludes trace from the
     exception level.
 
 :Syntax:
@@ -427,7 +427,7 @@ the ‘TRC’ prefix.
 :Syntax:
     ``echo idx > vmid_idx``
 
-    Where idx <  numvmidc
+    Where idx <  numvmidc
 
 ----
 
@@ -628,7 +628,7 @@ the reset parameter::
 
 
 
-The ‘mode’ sysfs parameter.
+The 'mode' sysfs parameter.
 ---------------------------
 
 This is a bitfield selection parameter that sets the overall trace mode for the
@@ -696,7 +696,7 @@ Bit assignments shown below:-
     ETM_MODE_QELEM(val)
 
 **description:**
-    ‘val’ determines level of Q element support enabled if
+    'val' determines level of Q element support enabled if
     implemented by the ETM [IDR0]
 
 
@@ -780,7 +780,7 @@ Bit assignments shown below:-
 ----
 
 *Note a)* On startup the ETM is programmed to trace the complete address space
-using address range comparator 0. ‘mode’ bits 30 / 31 modify this setting to
+using address range comparator 0. 'mode' bits 30 / 31 modify this setting to
 set EL exclude bits for NS state in either user space (EL0) or kernel space
 (EL1) in the address range comparator. (the default setting excludes all
 secure EL, and NS EL2)
-- 
2.30.2

