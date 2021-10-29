Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72C243F7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhJ2H1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232207AbhJ2H1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635492295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=GlXWTC+ly6Ou+HZ4gxEdHU2FwWlri9nVtckWKDMYyFI=;
        b=Gqw9qzHdHCrb3oqUaCcArNMbhM8XId/9XRxkjm1Qta/kXfLa8s/tEx39ORUlrNMTZvZarB
        aH7VXE2kC23dXQafxhdU0DlYGtMJqGVku56k+dgg4XprOQcrntS1CtNsMIfgwfKrJPMDeq
        K1vgfHB7XpgS0KQvIEjS5VNxZhFkwos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-KKqqpD-hPViAh54vUL9fYQ-1; Fri, 29 Oct 2021 03:24:52 -0400
X-MC-Unique: KKqqpD-hPViAh54vUL9fYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F169A8018AC;
        Fri, 29 Oct 2021 07:24:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-171.pek2.redhat.com [10.72.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D378A5FC13;
        Fri, 29 Oct 2021 07:24:47 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, dyoung@redhat.com,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/3] x86/kexec: remove incorrect elf header buffer freeing
Date:   Fri, 29 Oct 2021 15:24:23 +0800
Message-Id: <20211029072424.9109-3-bhe@redhat.com>
In-Reply-To: <20211029072424.9109-1-bhe@redhat.com>
References: <20211029072424.9109-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling arch specific kexec_file loading function, the image
instance has been initialized. So 'image->elf_headers' must be NULL.
It doesn't make sense to free the elf header buffer in the place.

So remove it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index fd8223fa2de5..dc8b17568784 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -373,9 +373,6 @@ void machine_kexec(struct kimage *image)
 #ifdef CONFIG_KEXEC_FILE
 void *arch_kexec_kernel_image_load(struct kimage *image)
 {
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
 
-- 
2.17.2

