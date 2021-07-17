Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65E3CC407
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhGQPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:24:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:50105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234255AbhGQPYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626535259;
        bh=tXXoy5Es0Q0dbPeU2KJ+zym9Mkvw55FFtd8u2Cxp5YY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=aRZJSREtIzE+4uiC05gQOYr9GnIq2TFZ0SG6BwZs8NValU6x8uX9PUXm/MBt5D5Ew
         /xu0Som9b+Km9uTkR82mR1ZKGzQDYGp/iVkbf6LNWY0vNZy4iBgzFrKe8hGwnW+KSw
         wc3rVQz9o8ntOHXW864VYU2dNTlg/ZxZ5+l1mnxY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MGhuU-1lqycK47sY-00DqtD; Sat, 17 Jul 2021 17:20:59 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging/wlan-ng: Remove all strcpy() uses in favor of strscpy()
Date:   Sat, 17 Jul 2021 17:20:32 +0200
Message-Id: <20210717152032.10164-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ONFjZjKHXxiFZ6UXDTigslUGgSmZsTB07Y4R78L8upIGy0s3Fj+
 c8k1BVcFhjIU4AdpW8BICQgnRQtlEQEQoHX/0nAsofh9K3EYtMQ7lUQdgiFcVASeIKv7ICz
 y/MKO0iVcs8ho/d0Rmflx+U3q/7xyEN3BKFZ3H/xlVERvEp0rl4s+SFLAgQxFMoeAet3HVl
 UolEp85WIKQTkkKqzlYzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:orMTpdMwofI=:EY6CrNuKcyvelk8IYc0BDk
 5xRr6kj2wkhqmgvWYMm+06095dB/SO0//lH/UMqKEu1cTU973XlqU/JEaC5Roz1xxtYUQtubv
 sCgSYa9+fr69qankVmb/YKnhAtM+4/rK6+f1bL0+s8PrYMfxhHyEs71B3iam63B/cm6jyjUaW
 Zem4ZmN+zhruuwprL5aVIKB8ecgBOmB/GfglrO9sg8CGWskcNp61VU0S5nkOihoMYv058FSrB
 h1TDs9GB5iPhWcho7ulubsdpzXNDL1/0G0yWIqt3aw5DvmVoRlN1JLWbXopWQMReB8tycL1yP
 lxJQCvv22Dql+28FUrYwAmME3eMcVZPJqJPq3/VeVXuFI8VkWhEPdTWxUbixRfxz2JDRyoQ2P
 6q/MWlaHIVXrJH0Hgywk9FAw+hAdg1C2/thy++ov6LP+Z5BOsogfat5hCL1OrJVCx7QoxIRdR
 AuWg93/pgNOX7oyLRCGSQ+8/uXQr50WZSL5LFszDZAjjUmBKUxaR5y7RpqlKesUhSocdid/BU
 6API1kOt23rLIwj7Ei+sEoee2IVvHN8TLrJYxzLs3L7sPPgfPB4LRCaQpv0c5uQEpUF1S9BJR
 Vz/AyM5VDDNfIXkV2mMfWBPyo33HVcOS2p1EiQzcX1olRSAlXqfLtzIYMTRDhFMMXG1ghdIhW
 p6O3j7kqRX8cQ/aaYrt3BTGY95vD+twO/VwbhoQqM/JHml2GYPU2odMh1QDebOQqApQWLe+hT
 w4HgmLe5c9q9Pfa9FTCC7nSkdB39r/wcx63YUbwFuKtbzsZm0orCx7U5mGGSmxdmXJZCmjhjY
 9vY3KEJ1FC3hKcWgX+jkP4AnCzaLvL7nvzYb/0E/pvSFOPsAO44vNlqF5k2cBsoNKIPjBlTfu
 +QO/X+7ozPBG0w7WiejEbn+FeipkZdkG0Mt0ItxWRpqQvi7st6JAw68LYeN1F2CwIu/X33Ggz
 AIJ16KSl7qkknzRj2YTgu2sFRsU4TTFbGNmdbcuNNnHyHsseeQaQ5qaXL+RLtkR4twfCwV9W4
 JIVYam/Oi1axrfaQyCKl2VDSVYljYru9JoI2LSI5zkx6hBAUNssnb1HuTmJxNl/8oxityTYBg
 FAQbOmyoqnojss3Mg90i0uv4Aap4IH8KLuz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/wlan-ng/prism2fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/=
prism2fw.c
index 94800c007162..02a2191d5c4d 100644
=2D-- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -296,7 +296,7 @@ static int prism2_fwapply(const struct ihex_binrec *rf=
ptr,
 	memset(&getmsg, 0, sizeof(getmsg));
 	getmsg.msgcode =3D DIDMSG_DOT11REQ_MIBGET;
 	getmsg.msglen =3D sizeof(getmsg);
-	strcpy(getmsg.devname, wlandev->name);
+	strscpy(getmsg.devname, wlandev->name, sizeof(getmsg.devname));

 	getmsg.mibattribute.did =3D DIDMSG_DOT11REQ_MIBGET_MIBATTRIBUTE;
 	getmsg.mibattribute.status =3D P80211ENUM_msgitem_status_data_ok;
@@ -786,7 +786,7 @@ static int read_cardpda(struct pda *pda, struct wlande=
vice *wlandev)
 	/* set up the msg */
 	msg->msgcode =3D DIDMSG_P2REQ_READPDA;
 	msg->msglen =3D sizeof(msg);
-	strcpy(msg->devname, wlandev->name);
+	strscpy(msg->devname, wlandev->name, sizeof(msg->devname));
 	msg->pda.did =3D DIDMSG_P2REQ_READPDA_PDA;
 	msg->pda.len =3D HFA384x_PDA_LEN_MAX;
 	msg->pda.status =3D P80211ENUM_msgitem_status_no_value;
@@ -1017,7 +1017,7 @@ static int writeimage(struct wlandevice *wlandev, st=
ruct imgchunk *fchunk,
 	}

 	/* Initialize the messages */
-	strcpy(rstmsg->devname, wlandev->name);
+	strscpy(rstmsg->devname, wlandev->name, sizeof(rstmsg->devname));
 	rstmsg->msgcode =3D DIDMSG_P2REQ_RAMDL_STATE;
 	rstmsg->msglen =3D sizeof(*rstmsg);
 	rstmsg->enable.did =3D DIDMSG_P2REQ_RAMDL_STATE_ENABLE;
@@ -1030,7 +1030,7 @@ static int writeimage(struct wlandevice *wlandev, st=
ruct imgchunk *fchunk,
 	rstmsg->exeaddr.len =3D sizeof(u32);
 	rstmsg->resultcode.len =3D sizeof(u32);

-	strcpy(rwrmsg->devname, wlandev->name);
+	strscpy(rwrmsg->devname, wlandev->name, sizeof(rwrmsg->devname));
 	rwrmsg->msgcode =3D DIDMSG_P2REQ_RAMDL_WRITE;
 	rwrmsg->msglen =3D sizeof(*rwrmsg);
 	rwrmsg->addr.did =3D DIDMSG_P2REQ_RAMDL_WRITE_ADDR;
=2D-
2.25.1

