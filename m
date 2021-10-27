Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F163343BF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhJ0CYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238285AbhJ0CYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdOuNDX3/xmLdrBREE9VW7efZLufc82SxJkpEXQ7fj8=;
        b=Q2HpPPE4+ytP/YdFJdVu6yxU7RSJ2PZ9lrNvv8MKviupgrd/69Rbm8O0oKD8rW58Bpzzdy
        90nV39056AeTqBrJQ6Gk45cqPEDnXEd3EqsD4TVgPB4XxCJS6NJR4Eah4XYPkTqaDVGAa2
        E+RX66BfL198j/hsgxCkm702Z9v9T6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-wJk4akncN0CN9spdiRSsJw-1; Tue, 26 Oct 2021 22:21:44 -0400
X-MC-Unique: wJk4akncN0CN9spdiRSsJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E2A8802B61;
        Wed, 27 Oct 2021 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-228.pek2.redhat.com [10.72.13.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D851D19729;
        Wed, 27 Oct 2021 02:21:33 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V5 4/4] virtio-scsi: don't let virtio core to validate used buffer length
Date:   Wed, 27 Oct 2021 10:21:07 +0800
Message-Id: <20211027022107.14357-5-jasowang@redhat.com>
In-Reply-To: <20211027022107.14357-1-jasowang@redhat.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never tries to use used length, so the patch prevents the virtio
core from validating used length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 07d0250f17c3..03b09ecea42d 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -977,6 +977,7 @@ static unsigned int features[] = {
 static struct virtio_driver virtio_scsi_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
+	.suppress_used_validation = true,
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
-- 
2.25.1

