Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04E83EAC49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhHLVN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:13:56 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:50005 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHLVNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:13:54 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2021 17:13:54 EDT
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210812210404usoutp012f14dc587a274116b41ddd5c23743bcf~aqwMNx-q02641426414usoutp01t;
        Thu, 12 Aug 2021 21:04:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210812210404usoutp012f14dc587a274116b41ddd5c23743bcf~aqwMNx-q02641426414usoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628802244;
        bh=KkZrPnnxTlrZl034L1ZdnIQMa6s208lhoVFS01ToQDc=;
        h=From:To:CC:Subject:Date:References:From;
        b=m3sdFQbG7migqYSz+NpxUZi4bY/S0Mg/bPTk9klPCVaJ3hvWXzm2PTirnoCv6ByGa
         M5QvWccOHHnUJ/pdM8WKVcKa3TAEw1xQU1nLTyYZVMC6FfPeaxWBC7hYm4tTjlDAkD
         GFE/u6A26KNfjxc3sLL4Nfcp6t1jQzh/HN5WvyRc=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210812210404uscas1p1582150be1bb7d7ba707a0bdca2462494~aqwL4Rgsy1694316943uscas1p1H;
        Thu, 12 Aug 2021 21:04:04 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 73.CB.36945.4CC85116; Thu,
        12 Aug 2021 17:04:04 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210812210404uscas1p19e91deb256e3baf6071788a70e35ab6f~aqwLlLl6J1500115001uscas1p1P;
        Thu, 12 Aug 2021 21:04:04 +0000 (GMT)
X-AuditID: cbfec36d-bb9ff70000019051-2d-61158cc4a6ff
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 57.83.56110.3CC85116; Thu,
        12 Aug 2021 17:04:04 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 12 Aug 2021 14:04:03 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::1014:4c20:6d82:fe0e]) by
        SSI-EX1.ssi.samsung.com ([fe80::1014:4c20:6d82:fe0e%7]) with mapi id
        15.01.2242.008; Thu, 12 Aug 2021 14:04:03 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Adam Manzanares <a.manzanares@samsung.com>
Subject: [RFC PATCH] nvmet: Fix conventional passthru
Thread-Topic: [RFC PATCH] nvmet: Fix conventional passthru
Thread-Index: AQHXj72UZFnrJBc9tESJZFLWZwqF+w==
Date:   Thu, 12 Aug 2021 21:04:03 +0000
Message-ID: <20210812210313.262432-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djXc7pHekQTDXqfylj833OMzWLW7dcs
        FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPic3v2D3O39vI4rFpVSebx+Yl9R67bzaw
        eXzeJOfRfqCbKYA9issmJTUnsyy1SN8ugSujof0SW8Em8YrfV5vZGhjvCXcxcnJICJhI/N64
        lr2LkYtDSGAlo8SZE39ZIZxWJomVUy4xwlRdXXyQGSKxllFi7rcdUM5HRokfS86wQDgHGCW2
        L/jFAtLCJmAg8fv4RrAqEYElTBLXLy0Dm8UsoCex9c8MNhBbWMBU4saHLmYQW0TASmLKvU5W
        CFtPYnXHSSYQm0VAVeL7iXawGl4BO4kp/UvZQWxGATGJ76fWMEHMFJe49WQ+E8StghKLZu9h
        hrDFJP7tesgGYStK3P/+kh3mhhtTp7BB2NoSyxa+hpovKHFy5hMWiHpJiYMrboB9JiGwh0Pi
        9uv3UAtcJFbPfANVJC0xfc1lKHsXo8T7yz4QDYcZJY6/egQNPWuJhX/WQ13KJ/H3F0icAyjO
        K9HRJjSBUWkWkh9mIblvFpL7ZiG5bwEjyypG8dLi4tz01GLDvNRyveLE3OLSvHS95PzcTYzA
        9HT63+HcHYw7bn3UO8TIxMF4iFGCg1lJhHennFCiEG9KYmVValF+fFFpTmrxIUZpDhYlcd5P
        hhPjhQTSE0tSs1NTC1KLYLJMHJxSDUwNs90u+7Fc1Mi5deh38VXepF+zvezU98vklaRt5TO4
        4x+aZ6j3belcrrpL8ltCSw5x/eo+3v/rEI/LFJXcdc9SZBi/mxlEa2uueT5v54vMtClzVafn
        bnr+9vXXhtzy27Lvzf7+isxTTLM0eSbe+d7yYTf748n3bn43L8z92G1Ru+3gu6mHHwUfvLn9
        1VaFs+FzZX3qKsounYm1seNX84z5YiNkHF7xuHASu5H6267rf8KiQoNnTGzZl/pW3uy7zbwK
        5wcKrEpcc8/OfpB1YX94/hOXVVPl70/Zx6ceeoHb/dGcrcbp1yWKplWt7PqSl/dw00ThnoyZ
        H9Tmf+ue0Dl5ZiGz6Qlz4XmX/Q8pB85UYinOSDTUYi4qTgQAkcID/r4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWS2cA0UfdIj2iiweHNbBb/9xxjs5h1+zWL
        xcrVR5ksJh26xmhxedccNov5y56yW6x7/Z7Fgd1jYvM7do/z9zayeGxa1cnmsXlJvcfumw1s
        Hp83yXm0H+hmCmCP4rJJSc3JLEst0rdL4MpoaL/EVrBJvOL31Wa2BsZ7wl2MnBwSAiYSVxcf
        ZO5i5OIQEljNKLHizSQo5yOjxPvzn1kgnAOMEk8WP2QGaWETMJD4fXwjWJWIwBImieuXljGC
        JJgF9CS2/pnBBmILC5hK3PjQBdYgImAlMeVeJyuErSexuuMkE4jNIqAq8f1EO1gNr4CdxJT+
        pewgNqOAmMT3U2uYIGaKS9x6Mp8J4lYBiSV7zjND2KISLx//Y4WwFSXuf3/JDnPDjalT2CBs
        bYllC19DzReUODnzCQtEvaTEwRU3WCYwis5CsmIWkvZZSNpnIWlfwMiyilG8tLg4N72i2Dgv
        tVyvODG3uDQvXS85P3cTIzAiT/87HLOD8d6tj3qHGJk4GA8xSnAwK4nw7pQTShTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTO6xE7MV5IID2xJDU7NbUgtQgmy8TBKdXANO/DnY8CeSzdj/1f3FXO
        WM0xU2NVZm/yDOYVMsv3BE3z/q315Hf2mswKmfJP3XuO1suElU6ebz39+jz3v9sXZhpMWXJZ
        5nFvt5RzbRrf7FvpvJ7f8s/Y+C2Wfb31n2JVxz39E4vyvr73M2bgu7PrfFFtYUdJRPvzhi/M
        PatvVR454P4i6LwRv1SY0f4D96+LBz3UVYw85fnplrZv2sxFGjo5ezvkZO9e/9I7Z90rztOR
        7T1L1/eEvprKkHJQ7cDk86zPFl24/zMitv7kp1XyPOf3/DlZnnH9Tv3nxt3dz0//C5rLKZaX
        kxDlkvHAeIqxWsp/jpuGR+5MPiB/92rC9l9Lw8W8ildP5cs83LeppV+JpTgj0VCLuag4EQBv
        +e2kNwMAAA==
X-CMS-MailID: 20210812210404uscas1p19e91deb256e3baf6071788a70e35ab6f
CMS-TYPE: 301P
X-CMS-RootMailID: 20210812210404uscas1p19e91deb256e3baf6071788a70e35ab6f
References: <CGME20210812210404uscas1p19e91deb256e3baf6071788a70e35ab6f@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently nvme_init_cap unconditionally sets support for one or more comman=
d
sets. When namespace identify descriptors are parsed it is expected that
the command set identifier is present, which is not always true for a
conventional namespace.

Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
---
 drivers/nvme/host/core.c   |  5 -----
 drivers/nvme/host/nvme.h   |  5 +++++
 drivers/nvme/target/core.c | 12 +++++++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f0cbaba12ac..dd6c01105c11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1306,11 +1306,6 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev,=
 struct nvme_id_ctrl **id)
 	return error;
 }
=20
-static bool nvme_multi_css(struct nvme_ctrl *ctrl)
-{
-	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) =3D=3D NVME_CC_CSS_CSI;
-}
-
 static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids=
 *ids,
 		struct nvme_ns_id_desc *cur, bool *csi_seen)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 26511794629b..dc93d2bd68b8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -919,4 +919,9 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file=
);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
=20
+static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) =3D=3D NVME_CC_CSS_CSI;
+}
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 66d05eecc2a9..d8eac7ccb54c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -9,6 +9,7 @@
 #include <linux/rculist.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
+#include "../host/nvme.h"
=20
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1196,12 +1197,13 @@ void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 n=
ew)
 	mutex_unlock(&ctrl->lock);
 }
=20
-static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
+static void nvmet_init_cap(struct nvmet_ctrl *ctrl, struct nvme_ctrl *ptct=
rl)
 {
 	/* command sets supported: NVMe command set: */
 	ctrl->cap =3D (1ULL << 37);
 	/* Controller supports one or more I/O Command Sets */
-	ctrl->cap |=3D (1ULL << 43);
+	if ((ptctrl && nvme_multi_css(ptctrl)) || !ptctrl)
+		ctrl->cap |=3D (1ULL << 43);
 	/* CC.EN timeout in 500msec units: */
 	ctrl->cap |=3D (15ULL << 24);
 	/* maximum queue entries supported: */
@@ -1363,7 +1365,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const ch=
ar *hostnqn,
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
=20
-	nvmet_init_cap(ctrl);
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+	nvmet_init_cap(ctrl, subsys->passthru_ctrl);
+#elif
+	nvmet_init_cap(ctrl, NULL);
+#endif
=20
 	ctrl->port =3D req->port;
=20
--=20
2.25.1
