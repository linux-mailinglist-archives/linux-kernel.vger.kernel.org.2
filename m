Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB2A40D568
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhIPJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235404AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85EB16126A;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=dSJX2IR3RAsOp8wxSPdYwoe8edX3ghFisEX9/16FN5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chbZRJUDy5LJ7qpdflk88zXyKppr261ckoloU/fznsNuEMTVHmiP2u7Buv6zhLH/i
         +P5YvAbsTNiWOemw2b7TB5dg+nG8iNHF5bHEhGdrQyv8F6AHfF7BHSJ2bwN4cj4NXJ
         Xo/APkDNsGXLdiQRA15yyX6ELqS4kDp2Ef5RFzZqw5Q7v+jM9jUCk8mA1HMXCQXNT7
         4ajytrUKqxrZMQLLnSPejL+RkWk3aXFRDtLZEyNwKnc+RCfLYbT6yL042fwnkrI3bE
         s9+62fa0zTLcbB0dIetD5aB46qjqlqvxs1Uu84ZA0GzbdW4puZZ3NcylnX2FnTDYas
         yliFJc86VXR9Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qkB-ND; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Colin Cross <ccross@android.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/30] ABI: pstore: Fix What field
Date:   Thu, 16 Sep 2021 10:59:37 +0200
Message-Id: <e19daafb779bd3a8f9ae1c15f670752355e5d40f.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both /sys/fs/pstore/... and /dev/pstore/... are possible,
it should use, instead, two What: fields.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/pstore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
index 5b02540781a2..d3cff4a7ee10 100644
--- a/Documentation/ABI/testing/pstore
+++ b/Documentation/ABI/testing/pstore
@@ -1,4 +1,5 @@
-What:		/sys/fs/pstore/... (or /dev/pstore/...)
+What:		/sys/fs/pstore/...
+What:		/dev/pstore/...
 Date:		March 2011
 KernelVersion: 2.6.39
 Contact:	tony.luck@intel.com
-- 
2.31.1

