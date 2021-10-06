Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9304247ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhJFUbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJFUa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:30:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B46BC061746;
        Wed,  6 Oct 2021 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=f+7pNJVIdJVibgfPLSCv/f+yDUP48wbFM1/ma1uhFjg=; b=Ogm6pNPXdME5gAs0wNEr+Wj30b
        fPTa/NAwwNJQa00AQL9dWyvTpT6FHp2bP2CR8cCdAZp5zsTJarPeZnQae0GxfZaQThA+r4JGZivlF
        u2az0ImavUx2gGxcv/ny8iialIURoUnmnJqc1EilxOjebsvhwGuu9A8m5VashhfR1j2QHpuDjaNPu
        pUBjbu9FqrmbQeGsy2zgme6Q2pXc8b1AoaTSOv3jeee6Wcc7luOkpOD7hiKyzWg3DFlILM8vTyHqv
        gn8mM/QYmX+iIUu9N0Main2nWJU7v/biu1fYPxT83VRiGejnpNQU3mNQ1jUYRa8Zn4QKrhZfbFRw9
        Qg+77kNA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYDXF-00FV0W-Ef; Wed, 06 Oct 2021 20:29:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Xie Yongji <xieyongji@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] VDUSE: fix documentation underline warning
Date:   Wed,  6 Oct 2021 13:29:04 -0700
Message-Id: <20211006202904.30241-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a VDUSE documentation build warning:

Documentation/userspace-api/vduse.rst:21: WARNING: Title underline too short.

Fixes: 7bc7f61897b6 ("Documentation: Add documentation for VDUSE")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/userspace-api/vduse.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-515-rc4.orig/Documentation/userspace-api/vduse.rst
+++ lnx-515-rc4/Documentation/userspace-api/vduse.rst
@@ -18,7 +18,7 @@ types can be added after the security is
 is clarified or fixed in the future.
 
 Create/Destroy VDUSE devices
-------------------------
+----------------------------
 
 VDUSE devices are created as follows:
 
