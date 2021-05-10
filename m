Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ABD378259
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEJKec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhEJKao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBDF56192D;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=1pGsLkW90Hkv2TIwTQmqfigD/Ezq8Ys098ssjaqakVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBYtzJpJ/BKC79x9zApyNZgnF0mVm+qYeRZ33rfwMX7E+ddHqqyqLarw45XiuaNFv
         +SUld8LGfHOsp3V1VOxVlEcLNbJC7Mg4IeKfRSRPF+tOMdlp6UVF9fSKggfsyaqQm1
         h3Dj1PeFWDx3v6KaExWLT4837Jb/pZcUSp0WFba4kPR756AOH5Lw5fulLf8AbQFWjy
         kWCBPzoDT6taDyHL6L+p8h9yqqEc+t4EYcJkX3wMVBooYrxjdgUI342EYNhQMRIMyX
         qSZFJI6xMzyEc4MtM6n3V4XEBTUKNSxOWfOSYo4yQx2pf2USsNqclcLMo2AC85O6i0
         IO+SHgA4D1gRw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UQS-Ui; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 33/53] docs: riscv: vm-layout.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:45 +0200
Message-Id: <050eb90d1cfe167f6cc2e25608d825c18aa7c559.1620641727.git.mchehab+huawei@kernel.org>
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

	- U+2013 ('–'): EN DASH

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/riscv/vm-layout.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 329d32098af4..545f8ab51f1a 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -22,7 +22,7 @@ RISC-V Linux Kernel 64bit
 =========================
 
 The RISC-V privileged architecture document states that the 64bit addresses
-"must have bits 63–48 all equal to bit 47, or else a page-fault exception will
+"must have bits 63-48 all equal to bit 47, or else a page-fault exception will
 occur.": that splits the virtual address space into 2 halves separated by a very
 big hole, the lower half is where the userspace resides, the upper half is where
 the RISC-V Linux Kernel resides.
-- 
2.30.2

