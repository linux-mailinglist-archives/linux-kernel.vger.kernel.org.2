Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3230142DA42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJNN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhJNN1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:27:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8E2610CC;
        Thu, 14 Oct 2021 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634217908;
        bh=f1U17lI/SG3Xtkx8l82Y51XiQPdYrJgA9xNytnxUdvg=;
        h=Date:From:To:Cc:Subject:From;
        b=fdPjx+zgbWP0/AQqTSFcwHC7T11+SIgyDZeXZ8TuxMozmtOmOdWr/RcCUb0xe5gNf
         nu1xQdT7BaEASOPuajx0/NXdLTtHXFQj84Xpy1QI8l8VtWgwrpT0ne+32cxHFQCBXj
         e8jRBfx146GQ2DrB3Dgr89lfTpldx7afZgKVcYGRMsAtGAtOwdRKQF72NFDJLitL3i
         43QjAnFdw17RzeQOF6B/qGYFcwIgpvhwmTVPvqqGg0DwsL3SOLi80ECaoBYavgUk6u
         Yu3ulnQ39UaR0PxNkcbGTkBygAJrYeS7Ow5Nl7IBjXU/oXc+k3lE24yw6272eUtHuC
         xIBnYHrKzAQgg==
Date:   Thu, 14 Oct 2021 15:23:31 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] compiler_types: mark __compiletime_assert failure as
 __noreturn
Message-ID: <20211014132331.GA4811@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`__compiletime_assert` declares a fake `extern` function
which appears (to the compiler) to be called when the test fails.

Therefore, compilers may emit possibly-uninitialized warnings
in some cases, even if it will be an error anyway (for compilers
supporting the `error` attribute, e.g. GCC and Clang >= 14)
or a link failure (for those that do not, e.g. Clang < 14).

Annotating the fake function as `__noreturn` gives them
the information they need to avoid the warning,
e.g. see https://godbolt.org/z/x1v69jjYY.

Link: https://lore.kernel.org/llvm/202110100514.3h9CI4s0-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/linux/compiler_types.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b6ff83a714ca..ca1a66b8cd2f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -298,7 +298,13 @@ struct ftrace_likely_data {
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
 	do {								\
-		extern void prefix ## suffix(void) __compiletime_error(msg); \
+		/*							\
+		 * __noreturn is needed to give the compiler enough	\
+		 * information to avoid certain possibly-uninitialized	\
+		 * warnings (regardless of the build failing).		\
+		 */							\
+		__noreturn extern void prefix ## suffix(void)		\
+			__compiletime_error(msg);			\
 		if (!(condition))					\
 			prefix ## suffix();				\
 	} while (0)
-- 
2.33.1

