Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74B23331B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhCIWne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:43:34 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:45669 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhCIWnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:43:21 -0500
Received: from localhost.localdomain ([82.142.6.26]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mw9oq-1la3X63Hq0-00s9mF; Tue, 09 Mar 2021 23:43:16 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] virtio-mmio: read[wl]()/write[wl] are already little-endian
Date:   Tue,  9 Mar 2021 23:43:13 +0100
Message-Id: <20210309224313.956065-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ITmUmGCS3nWgVU/IhWzhXwzYcphE6+u+PQ+RqX0F7lBZs2r5D3d
 LwcP9pCAwPx5wSBQ/jfC3Rb8feTvfVVIuyJBH3f+HOnSvcFD4tB3gVBWQSx57ebUgJGKw2K
 fF8RI1VuHRg/paoP1xSrkF7Ikw+UicrNPMr8/y0lN06+JPzWxqIC8zd0QvPOMpGTRUupGo8
 ZRjxuvcOn6rLTQlLAPIOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b0KFvs3LQIw=:qg38kt8UuUOL9wUKSu3ZtN
 S2dROXLjgX3V6ctZH+ZBoRiCoHhsyQ6+GAJ4qTpyuEz5eye2FP5bq3JoF8j7P+b8w8ysrJ9nC
 OWqOJKh7GX938hcd3fmf7H+FnTVVNI/rMfCWpMTJp3AGJ0RlDFInRsYHXqBMPOS5iKjcBXnXS
 2LZF/I48LMbqJ89vdBVUWzIFm/FgeEz7/WBR0UziI42h3ibn1GdC+RZ2gGghVJJBRndWC+I6x
 Mb01gEjFNnCFK3yRA2vntvNp+qVt9fs35bp6Rzos/CCfRT9EcpKz6De1E2IT0MiQqG7hBTY7e
 M6LwmOT50T3mfZznFKjiXrWoQx+K1G1/yIdTndqDw3emSYQFsHLM+SfXXUzt6YQAuqRbChVAb
 d+rnLmgLDFaEU76rnPonPacq8wZuyEYjDrrerV3SX5CPoalBo3BbJeVIciB9k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read[wl]()/write[wl] already access memory in little-endian mode.
No need to convert the value with cpu_to_leXX()/leXX_to_cpu()

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/virtio/virtio_mmio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index a286d22b6551..3f6a5588f77d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -168,17 +168,17 @@ static void vm_get(struct virtio_device *vdev, unsigned offset,
 		memcpy(buf, &b, sizeof b);
 		break;
 	case 2:
-		w = cpu_to_le16(readw(base + offset));
+		w = readw(base + offset);
 		memcpy(buf, &w, sizeof w);
 		break;
 	case 4:
-		l = cpu_to_le32(readl(base + offset));
+		l = readl(base + offset);
 		memcpy(buf, &l, sizeof l);
 		break;
 	case 8:
-		l = cpu_to_le32(readl(base + offset));
+		l = readl(base + offset);
 		memcpy(buf, &l, sizeof l);
-		l = cpu_to_le32(ioread32(base + offset + sizeof l));
+		l = ioread32(base + offset + sizeof l);
 		memcpy(buf + sizeof l, &l, sizeof l);
 		break;
 	default:
@@ -212,17 +212,17 @@ static void vm_set(struct virtio_device *vdev, unsigned offset,
 		break;
 	case 2:
 		memcpy(&w, buf, sizeof w);
-		writew(le16_to_cpu(w), base + offset);
+		writew(w, base + offset);
 		break;
 	case 4:
 		memcpy(&l, buf, sizeof l);
-		writel(le32_to_cpu(l), base + offset);
+		writel(l, base + offset);
 		break;
 	case 8:
 		memcpy(&l, buf, sizeof l);
-		writel(le32_to_cpu(l), base + offset);
+		writel(l, base + offset);
 		memcpy(&l, buf + sizeof l, sizeof l);
-		writel(le32_to_cpu(l), base + offset + sizeof l);
+		writel(l, base + offset + sizeof l);
 		break;
 	default:
 		BUG();
-- 
2.29.2

