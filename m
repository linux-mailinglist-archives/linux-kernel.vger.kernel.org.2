Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8716237BD74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhELM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhELMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A87E6192C;
        Wed, 12 May 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=a2ciNHKQtdy9yKU7hgq+HbZ1G3BlRKUgnhBsmHQl52Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FhOgSFeSes/0Y4VigsXGqH46I33Iif1FNXc8PCR5FWAYIq0aY0AQAYxB6d7q+zxvC
         4DOh6Y8pnik83uGrWspdaaxkO4jSqtSMz0TZb4X7jZrjjP8f8gCiyBPHoiSnU90yRH
         XsnVdToIuqUqOUVE4H3QO3Dir5vCd/GOpoMJIPSuVV6iTLGfo0e8oeg1gJXnocgLYn
         vaIhea9QJyjaUZu5Xlj5XDt6ogA2nqcr1rko0GAlYrAJDunmW9okqoJS7V0kzOBk7I
         ONys0cf7Fihlp2kOAHTRMuPFFpb9uFDj+FaOoUDJOqmk2n81eKk5Hj5zTswx7rFr7r
         65GtdzwtYbRwQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018hB-9I; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/40] docs: trace: coresight: coresight-etm4x-reference.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:10 +0200
Message-Id: <14c34b8034d4916c5f81c59b6c7f28d622a84bb4.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE
	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

