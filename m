Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA0346DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 01:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhCXACe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 20:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhCXACb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 20:02:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95540C061763;
        Tue, 23 Mar 2021 17:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5Vt+TAwMe378ofN6U2aBy22sSeSREO/ErRFpkq+OhMQ=; b=ULVny95p+D4U3qnM1zvKJKv28O
        j8Pba3vd8Bxo9rzDD+DTnU4YyWEO0NeL6XQRYFxIuj9d9mAwca/GrVjW7Epx+9W7uouefLdkpM6nz
        +GhOq9x9ox+H5YsTgAxWUZyDGNF0Rg3jiJ6pfDz8ydu8zjHcxH+ZuHgPSm2EMuJMlRG/9qi5fXOB3
        mivnSE6sNWowwQ9BJ4hy0jfacYkAsGvsaODQSZp6RqWQUSxvhlBTcmexVmOf8LfaM87ieieMiG3U2
        N2cRi8u64NYOwxzhLgpBhjRIbnF/0v9QbmPTFRqsE/LISF/OwXJhtXUDV7r25PHQAJjQgZPbZjle+
        nuBdf+JQ==;
Received: from [2601:1c0:6280:3f0::3ba4] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOqyi-00G0Xl-89; Wed, 24 Mar 2021 00:02:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] tools: usbip: list.h: fix kernel-doc for list_del()
Date:   Tue, 23 Mar 2021 17:02:23 -0700
Message-Id: <20210324000223.22043-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In list.h, the kernel-doc for list_del() should be immediately
preceding the implementation and not separated from it by
another function implementation.

Eliminates this kernel-doc error:
list.h:1: warning: 'list_del' not found

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 tools/usb/usbip/libsrc/list.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20210323.orig/tools/usb/usbip/libsrc/list.h
+++ linux-next-20210323/tools/usb/usbip/libsrc/list.h
@@ -77,17 +77,17 @@ static inline void __list_del(struct lis
 #define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
 #define LIST_POISON2  ((void *) 0x00200200 + POISON_POINTER_DELTA)
 
+static inline void __list_del_entry(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
+
 /**
  * list_del - deletes entry from list.
  * @entry: the element to delete from the list.
  * Note: list_empty() on entry does not return true after this, the entry is
  * in an undefined state.
  */
-static inline void __list_del_entry(struct list_head *entry)
-{
-	__list_del(entry->prev, entry->next);
-}
-
 static inline void list_del(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
