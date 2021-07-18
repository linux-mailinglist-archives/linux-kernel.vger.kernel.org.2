Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1933F3CC94B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 15:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhGRNQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 09:16:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:36851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhGRNQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 09:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626613967;
        bh=CMvGExjMQupZPMM62nT0Q6JQOogckE+ME36zM5PHuC8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RTunmgyV+vLhQr3GLSNe+8yCGuvuj/oyle9SRy+kcJHqI2xoC05WSP3nEmuFGtu2t
         2avtZSC7+8iVDW80mauCcOaQOZVkQMYNync8tOfcWhxFmPilvYi38E0DQSk17El7yB
         TUIKh++cVOB7sRT70pOjdf7nKxO/WsZD9Ug4MAh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MOREc-1lkq9p1MKs-00PwA5; Sun, 18 Jul 2021 15:12:47 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Len Baker <len.baker@gmx.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/vc04_services: Remove all strcpy() uses in favor of strscpy()
Date:   Sun, 18 Jul 2021 15:12:17 +0200
Message-Id: <20210718131217.3806-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4CWYGQVn1yChMQul7TO5K5N/vYGRpc5gC1NngggoplhCLQvq7UR
 Z/HWFm+d+hcQkbIxIBasqT68H7KghdhPfDoEwZXfqRQMHyfxew4AXTZZDgrS8fpcnssK6DH
 W4V5u7iImiY9vaTuTNYLFph00vhSYuu5PWhUOGhJIKl4OPGrxh8o/2gZlCceTasze/aOe2i
 gF4kCIz1mIVAM7ILbQlhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6S41qTiwtB8=:8/PB9bpLTNhvOD307p5f5m
 qAR7TmxiE5IeX1VSkkeNG+N1SCzLdK0rD7iVYRE/mWrJGPMQRAG/xbLNkMWFGGFQOQONZ93kI
 cjH0MnbrVB3+DqTajN26pTH68IvJ1xxtVybFelcQQiM9W2j7QPO0LDkMRUkj4Z3LMWJMkuc9G
 YXVyCfisG+IMtdkOG5Ud/l1CRd92SjIlbqt2sXSgLVgtcdwQrOBNz5tJDgNYuLtAqpOgAJNng
 Wa2PWH4wuy+H/k/r+d1Vqeo1gVfoXC9HchmKplG2m7Vv0kJqLXu6esIjHWQD11wVW+2zs7GrT
 zdMN21BIBDTJCJ2CSm71poakUtC7xhnMyBAVTpkyyw/VjGKbei6dxprm0W/y1GO+geOK38lk8
 vg1yWwuQEziy31IMsnBjxrkzAOcTeoWfo1PSEwchbskRIguAIWyQ+tStjIe6gLfDDXa+DSTUa
 RDFQ4cpHUH+phhMUIAsesr9Ug8cXbbTrV883f4KVINRmVL3f5KFDPQjrjkRRe3FmQyzrPiZso
 lwwtnMvr0F5s49JDIgjH3gR+X+nyogkoEFOo9QKKTDUyswj3VeMNAh+CwNHissBoR0LDWEJLn
 H4kzTKG5QVe+Db6Z3JdjMGO+uIT5cyw86N2dd9/4WDnct6g2f8VKEoUUrcg8tJjlEusuyJL2i
 tlH7qtEwZqOS4sb6vDhGP5lWk33GU7zJwEbhVoUdyQuzvTMSCqwmJPYf54tfLLi6PxkY+mf+N
 HNVqEV6osjVT09uG0ThYk2cD8BRNTYijVuUt46Bkf5eiphpsBb5l+3w5gxnGFJ1V1adt/7ADw
 bX2roppqSR7M6nZysQEY/phrzUlJfJWb6ImZTLUu2raNLUp4+z00U6HUAsGd3ib9Ye3eMK6SD
 r8EZoU+OFnCGKkpH1edwVzlNu0fWAV9gVlCek0XKT+NQXOkC7itr5WWQ5Z1nlcKk8ELubPki8
 8eWwHmI9ezL72rPK6Bu23atfD/7VmkhONWbYlM4ABl/wF7ch2HbSlfzgSR1gcLyVRNRR0CqzA
 3r8j5oUSH840OEQIkBBh4BNz84ezFFw0qRx2rwuXjW4ZmM43c78AFtFwy6MgxA7zXtPYILO5z
 iOMiVuvhtKwwYiopnQh7BXM0UCFGkcnP7FI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c  | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c=
 b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index df90c1f9d148..1b184d5c6b82 100644
=2D-- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -884,7 +884,7 @@ static int vidioc_querycap(struct file *file, void *pr=
iv,

 	vchiq_mmal_version(dev->instance, &major, &minor);

-	strcpy((char *)cap->driver, "bm2835 mmal");
+	strscpy(cap->driver, "bm2835 mmal", sizeof(cap->driver));
 	snprintf((char *)cap->card, sizeof(cap->card), "mmal service %d.%d",
 		 major, minor);

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.=
c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 4f43e4213bfe..9429b8a642fb 100644
=2D-- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3716,7 +3716,7 @@ int vchiq_dump_service_state(void *dump_context, str=
uct vchiq_service *service)
 					sizeof(remoteport) - len2,
 					" (client %x)", service->client_id);
 		} else {
-			strcpy(remoteport, "n/a");
+			strscpy(remoteport, "n/a", sizeof(remoteport));
 		}

 		len +=3D scnprintf(buf + len, sizeof(buf) - len,
=2D-
2.25.1

