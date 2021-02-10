Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE7316F20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhBJSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbhBJSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:35:24 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6FDC06178B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=H3b8asjlHtFl+HYad0gJTj6GpEbBH6qUuuT5omw3lO8=; b=veQQfaI6K+oscjlLAcSUGLDoHn
        2UWbIQ3BofSOTMQ4WKLxtwwFxNKqaiOVR/hRV7emy7i0lrPT3e4Jm7+PzMrl/QQ9MI0jDjXkabDlA
        sza6pzBTzX2M9vknpdSA9/Y9T6cTKL94kMSmauG/ldv+feyzcExu5usdlOiUtCF0iZlN804c292jp
        kQEEG6DkS+9JbcgBNzKKaFkSMdhnN0/hUzsQ/2lchspH7DvwdbB2/8SJE2yXws16MwnkyjOD3z3rY
        6cyfgBTSxJN7qd7Znzbpid3JgTp2fyYop2pBWfhYDwO5UuKl0akVfu7+0vXXBkkILJiRKrSpixmRV
        gG60mdpA==;
Received: from [2601:1c0:6280:3f0::cf3b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9uJy-0006qX-J2; Wed, 10 Feb 2021 18:34:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Shuo Liu <shuo.a.liu@intel.com>,
        acrn-dev@lists.projectacrn.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH -next] ACRN: update MAINTAINERS: mailing list is subscribers-only
Date:   Wed, 10 Feb 2021 10:34:33 -0800
Message-Id: <20210210183433.18746-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the acrn-dev mailing list as subscribers-only.

Evidence from a previous patch:
  acrn-dev@lists.projectacrn.org
    SMTP error from remote mail server after end of data:
    510 5.1.1 Your email address, rdunlap@infradead.org, is not subscribed to that group.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Shuo Liu <shuo.a.liu@intel.com>
Cc: acrn-dev@lists.projectacrn.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210210.orig/MAINTAINERS
+++ linux-next-20210210/MAINTAINERS
@@ -438,7 +438,7 @@ F:	include/uapi/linux/wmi.h
 
 ACRN HYPERVISOR SERVICE MODULE
 M:	Shuo Liu <shuo.a.liu@intel.com>
-L:	acrn-dev@lists.projectacrn.org
+L:	acrn-dev@lists.projectacrn.org (subscribers-only)
 S:	Supported
 W:	https://projectacrn.org
 F:	Documentation/virt/acrn/
