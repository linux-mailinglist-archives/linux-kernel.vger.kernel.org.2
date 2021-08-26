Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930A3F9014
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243710AbhHZVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:16:41 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:64383 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbhHZVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:16:35 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20210826211547usoutp0134779bf08945a74b891f7df1a88fd241~e98aB1cvJ2507725077usoutp01H;
        Thu, 26 Aug 2021 21:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20210826211547usoutp0134779bf08945a74b891f7df1a88fd241~e98aB1cvJ2507725077usoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630012547;
        bh=sm2LA01+hgkQNLmHJig+tdHL7U+svZjhE9tJ7kweohE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pYe6SpF+BDoqiktqDMxKr4koDalnsTIplONS1Pcr8nRvmJJTBDGfYldXDYOCIZcL+
         WzISFA8ZdhZ8lfKNOAsQbdBv5RkdC33rhUlhiqit0le+aNfUlvEXAPk/Hm9fywvArM
         V4gsGh+XJZekW9anfpmMX/FgH9z8huediTPiPxZs=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210826211546uscas1p1adfd4780a4b4715cbeeed510a8438cbe~e98Z2JSX70253102531uscas1p1L;
        Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id A9.7A.19318.28408216; Thu,
        26 Aug 2021 17:15:46 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec~e98ZmwPkV1097710977uscas1p23;
        Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
X-AuditID: cbfec370-c4fff70000014b76-71-612804820ba0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 63.DD.47905.28408216; Thu,
        26 Aug 2021 17:15:46 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 26 Aug 2021 14:15:45 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407]) by
        SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407%7]) with mapi id
        15.01.2242.008; Thu, 26 Aug 2021 14:15:45 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adam Manzanares" <a.manzanares@samsung.com>
Subject: [PATCH 1/2] nvme: move nvme_multi_css into nvme.h
Thread-Topic: [PATCH 1/2] nvme: move nvme_multi_css into nvme.h
Thread-Index: AQHXmr+I0SsiXld9u0SAu8oWTXUGdg==
Date:   Thu, 26 Aug 2021 21:15:45 +0000
Message-ID: <20210826211522.308649-2-a.manzanares@samsung.com>
In-Reply-To: <20210826211522.308649-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djXc7pNLBqJBl/3Gln833OMzWLW7dcs
        FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPic3v2D3O39vI4rFpVSebx+Yl9R67bzaw
        eXzeJOfRfqCbKYA9issmJTUnsyy1SN8ugSvj8OdPTAW/uSomrpzA3sC4nrOLkZNDQsBE4vKj
        L0wgtpDASkaJU0fDuxi5gOxWJomeWR3MMEUd5z4wQSTWMkpMffseyvnIKPH+9VoWCOcAo8TG
        ddvBZrEJGEj8Pr6RGSQhIrCHSaLv9AewBLNAocTetZ9ZQGxhASuJGX//s4PYIgL2EgfWHGXt
        YuQAsvUkXjbUgYRZBFQlXm38DnYGr4CdxIMn+8DKOYHKX856CjaGUUBM4vupNVDjxSVuPZnP
        BHG2oMSi2XugXhCT+LfrIRuErShx//tLdoh6PYkbU6ewQdjaEssWvobaJShxcuYTFoh6SYmD
        K26APSkhcIVD4uYjmAUuEkeW9bFC2NISV69PZYYousYosfzRHFYI5z6jRGvPX0aIKmuJhX/W
        Q53KJ/H31yPGCYzKs5BcPgvJVbOQXDULyVULGFlWMYqXFhfnpqcWG+ellusVJ+YWl+al6yXn
        525iBKan0/8OF+xgvHXro94hRiYOxkOMEhzMSiK8C76rJQrxpiRWVqUW5ccXleakFh9ilOZg
        URLnnRs5MV5IID2xJDU7NbUgtQgmy8TBKdXA1HFj9/vU2f/enPabvXrOGrdisYldDftlVMUn
        Hbv5Osoh5dJKoTdv53/sSZwbUT1lZX6lkum0C7P8PZ9/2TOp+td5RunfiReSJ77dr7jHZd7M
        yXG/5FeeU9c+uvdE2gNVuWDOnzO4e1N/RE21nRChaXTl0cU6a+cTu1etWfOc42KundLyKwLb
        wifa7vDfsO4Yk8OOu7Ey1c+/VqQdM7JZMavrbdfFZdeEH/pfWn1gZbC+LZOYJW/g+lvbio4V
        GLaLcGwOfOz0oGoyq1/JgyfWF3dyvZ7dxvP86P8lO5J7m23ddWZ6G/edVrRZGcaTxPBY/nPj
        h3vxWQZhwTd6ZbM1sow8NBJXTa4Xd3qzaeatJSVKLMUZiYZazEXFiQBlfqBUvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWS2cA0UbeJRSPRYMNfSYv/e46xWcy6/ZrF
        YuXqo0wWkw5dY7S4vGsOm8X8ZU/ZLda9fs/iwO4xsfkdu8f5extZPDat6mTz2Lyk3mP3zQY2
        j8+b5DzaD3QzBbBHcdmkpOZklqUW6dslcGUc/vyJqeA3V8XElRPYGxjXc3YxcnJICJhIdJz7
        wNTFyMUhJLCaUWLt7IusEM5HRon/kx6xQDgHGCVu39/CCtLCJmAg8fv4RmaQhIjAHiaJvtMg
        /ZwczAKFEnvXfmYBsYUFrCRm/P3PDmKLCNhLHFhzFKiZA8jWk3jZUAcSZhFQlXi18TsziM0r
        YCfx4Mk+sHIhILtzwWywOCdQ68tZT8FGMgqISXw/tQZqlbjErSfzmSBeEJBYsuc8M4QtKvHy
        8T9WCFtR4v73l+wQ9XoSN6ZOYYOwtSWWLXwNtVdQ4uTMJywQ9ZISB1fcYJnAKD4LyYpZSNpn
        IWmfhaR9ASPLKkbx0uLi3PSKYsO81HK94sTc4tK8dL3k/NxNjMD4Pf3vcOQOxqO3PuodYmTi
        YDzEKMHBrCTCu+C7WqIQb0piZVVqUX58UWlOavEhRmkOFiVxXiHXifFCAumJJanZqakFqUUw
        WSYOTqkGJo8j7/xtYr/UVzEFnt/Q8CnEhrf2r+m1aVzGv46+cxcM2CEwwXLTVTMGkc6fl53b
        9XL+ra1Nlf3TWuRrmhGq9CvX6FTY7HYlx5WtCy2ep/H9elIWl805ddpk+VKrzTf82xXvvt7q
        35N3OaN7n2a15p613K9s36qeuDaX40XtHrb2c/uTzl8Vue9jv8Dc5MiZhhXCTVO3XhMyCfHg
        vxLTW+iwMm2lcqCnhG3XrTAZz43y91smLRRaIyUtqG9z4exkl6S/C/PuXNZ/faHUqSg2+bv6
        KaM1H8wfxx88Up3nWvNRUaVP3PDpyz89J438TDRKP7Oy9Gv7iQTy3X7lsmlq6Nc69ae3nlfK
        rT2p28umxFKckWioxVxUnAgAnFLDMk4DAAA=
X-CMS-MailID: 20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec
CMS-TYPE: 301P
X-CMS-RootMailID: 20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec
References: <20210826211522.308649-1-a.manzanares@samsung.com>
        <CGME20210826211546uscas1p2488ecd33269aa6f71f1fe8271fad3cec@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparatory patch in order to reuse nvme_multi_css in the nvme target code

Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
---
 drivers/nvme/host/core.c | 5 -----
 drivers/nvme/host/nvme.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42b69f3c6e20..cd5dc104d4b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1303,11 +1303,6 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev,=
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
index 8fd30ef19757..9871c0c9374c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -892,4 +892,9 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file=
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
--=20
2.25.1
