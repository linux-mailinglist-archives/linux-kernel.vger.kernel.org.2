Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33F42DD93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJNPJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234287AbhJNPIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:08:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CA5E600CC;
        Thu, 14 Oct 2021 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634223995;
        bh=hFiS/lWJR0rZJ3gTMLH+dhCLmu92hT1dPGV0B7uQJEE=;
        h=Date:From:To:Cc:Subject:From;
        b=QohxdhlQ4ZT2T0L/gSclIrvg6iUC5/miBAEFlmX7RJLkYZoTGrmpJaPkJ3noEG2FO
         B8E2I/fZPLUs8g72eBpsdL/9cIDnEeD62vurF7WQRDnlQTvu2ikLMGtLSA9KTL9f3t
         DPnmX3/ORj+zGHtqnSN+SFqjkNHy5E1cJgmc2XHs9XxRv5qp7LttElyxJ0ej37ATGA
         NrR1/i6VQ7u9Q/TwTvhKFpVUAh3GNZ5E4yldFqnWW/4FnfLgdvqfy5MoowFVby5SwR
         tmGZ0MjdvdHleV1eFmreuyjadwgqVv/fRC3ZFXHm/vVzWQYRDFKHRL2X7oanO2N3I4
         M6i7Eqvu+nXSA==
Date:   Thu, 14 Oct 2021 17:06:10 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH] Compiler Attributes: remove GCC 5.1 mention
Message-ID: <20211014150610.GA22151@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 5.1 is now the minimum version.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/compiler_attributes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index e6ec63403965..87d1e773400c 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -104,7 +104,6 @@
 #define __deprecated
 
 /*
- * Optional: only supported since gcc >= 5.1
  * Optional: not supported by clang
  * Optional: not supported by icc
  *
-- 
2.33.1

