Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39AD429E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhJLGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233690AbhJLGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzRx2MNhRgyMZdCdlWXIwUyzg9b7lQf3CHvnXsY/pfA=;
        b=Wf79MG9IRVcIERqjlRDyZouOmHz1CgAJg9eUyUUeHxHRBvJigvDiYuyZHvpf7flq04/FYX
        Nan0STbYXlOLKaoUg0hG1TpRFh1h54DMZ0FlthSQ6eL26I5VduCvhoFjleHvkgM/KFPuS+
        UuBb8v79K73FRXvI3gw2QkzWQTf4wQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-IrcA9wbzOmySRwJ9h72gDQ-1; Tue, 12 Oct 2021 02:53:22 -0400
X-MC-Unique: IrcA9wbzOmySRwJ9h72gDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01696801A93;
        Tue, 12 Oct 2021 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E81C5F4E0;
        Tue, 12 Oct 2021 06:53:11 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V2 12/12] virtio-scsi: don't let virtio core to validate used buffer length
Date:   Tue, 12 Oct 2021 14:52:27 +0800
Message-Id: <20211012065227.9953-13-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index c25ce8f0e0af..2af33fc36f8a 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -977,6 +977,7 @@ static unsigned int features[] = {
 static struct virtio_driver virtio_scsi_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
+	.validate_used = true,
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
-- 
2.25.1

