Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D330C048
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhBBNxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhBBNrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:47:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E33A864F95;
        Tue,  2 Feb 2021 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612273312;
        bh=3tsrlpPeSYjCRQFX/Kko3V86vLDgJBvIC0KszJLfEng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfFN21vlqYW0ZeEBk0WG484L7DVlBlYftEG/COh/WIHd6Hbzsd5tGWWVQbdkUw4k0
         XIFxGHZNTASpGg5S+uiHA1Ngwo7EJliaUU9ay+Y2TJdvtAbnUVEXX+9uZKBdIZcKva
         nwxnlhNMhgSrazAY5GLxcTVhRUqs7laZc1rPOICw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 5.10 059/142] drm/nouveau/svm: fail NOUVEAU_SVM_INIT ioctl on unsupported devices
Date:   Tue,  2 Feb 2021 14:37:02 +0100
Message-Id: <20210202133000.153752372@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202132957.692094111@linuxfoundation.org>
References: <20210202132957.692094111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karol Herbst <kherbst@redhat.com>

commit dcd602cc5fe2803bf532d407cde24ba0b7808ff3 upstream.

Fixes a crash when trying to create a channel on e.g. Turing GPUs when
NOUVEAU_SVM_INIT was called before.

Fixes: eeaf06ac1a558 ("drm/nouveau/svm: initial support for shared virtual memory")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_svm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -315,6 +315,10 @@ nouveau_svmm_init(struct drm_device *dev
 	struct drm_nouveau_svm_init *args = data;
 	int ret;
 
+	/* We need to fail if svm is disabled */
+	if (!cli->drm->svm)
+		return -ENOSYS;
+
 	/* Allocate tracking for SVM-enabled VMM. */
 	if (!(svmm = kzalloc(sizeof(*svmm), GFP_KERNEL)))
 		return -ENOMEM;


