Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615A6406353
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 02:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbhIJAq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 20:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232550AbhIJATA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:19:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AFE2611EF;
        Fri, 10 Sep 2021 00:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233058;
        bh=PywQY83TtiMI0PdTcLzgo31hypntOHwyDabvvSB0vbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcCc+dsJ3fcFOPOFA8AvwCSykEd/JkHubtPj8E1M4ZPg/55smrtXmVCR95I7G8yKX
         otBezZfynPsasgqQE6liqfW8ixP0mklq8KBPUoPhgHqQ0GocSPI0s1Hxjf4LHY27xV
         wvUBlSzsq6RTEuaGbJBjAaIaFNMVj4XmMxcFcz1QMgz2ANHP/O2DUy9jz8Ks2bNfH5
         XwHiVxGJpeop9YmlfXTdH6wj04C7/xf1hEjpuO94yjUSjbQLMdKsPD12X0Rg0++l1H
         VexNp9iETluDvNx567bgC+LwlvYKv1X7dSxibaHF1KgXLC+QrcU7/ckxbvFzWUc3zG
         WXDetiWUJxGsA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: [PATCH v4 3/3] x86/sgx: Document SGX_MemTotal to Documentation/x86/meminfo.rst
Date:   Fri, 10 Sep 2021 03:17:26 +0300
Message-Id: <20210910001726.811497-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910001726.811497-1-jarkko@kernel.org>
References: <20210910001726.811497-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document SGX_MemTotal field of /proc/meminfo to
Documentation/x86/meminfo.rst. This is a new file for x86 specific
meminfo fields.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
* A new patch.
 Documentation/x86/meminfo.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/x86/meminfo.rst

diff --git a/Documentation/x86/meminfo.rst b/Documentation/x86/meminfo.rst
new file mode 100644
index 000000000000..999b676a04a8
--- /dev/null
+++ b/Documentation/x86/meminfo.rst
@@ -0,0 +1,11 @@
+This document describes x86 specific fields of /proc/meminfo.
+
+Supplemental fields for /proc/meminfo
+=====================================
+
+SGX_MemTotal
+                Total usable physical SGX memory, also known as Enclave
+                Page Cache (EPC), in kB's. This is the physical memory
+                used for enclave pages. It is below the amount set in
+                the BIOS: a portion of that memory is required for
+                the state of the enclave pages.
-- 
2.25.1

