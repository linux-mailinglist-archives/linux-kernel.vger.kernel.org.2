Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C161B3A0383
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhFHTSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:18:02 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com ([40.107.21.121]:19169
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235662AbhFHTG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:06:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSz/PgLLl8f40Tcy+n3cNWaRPnneDBH4qc3ys3mG7ikkbjrpPSztQBONDS74iAc7awcFEH3Hwu6mxUmKlWeTBNj/8Afduv//cQSm4Ai91SLU8GqodVgL0oUiQfzn1s66xNDHo37PyAUHHMFHe+A6I5rVHDNMJz+NGQVb04whrB4KRK+JPSOXVLoVypIs9JnoKXL/WJbmS41a+sa6mUf8qMeLTDBWM5tAbT2tjUN49IxaF8/vcSk+fe/E/b/mIUM4x0G8NAMxL03lE0LZe5igVE4asWCTPgItNzmXSZq4vn5i4MYpXcnwX1SvunJ+E2WCtwfON0YRb8Dx7KP3XPJO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRc2y//4XF07krqjdC4jXc8SMY8cBUzbDLaIYVquW1Y=;
 b=d7V7tx4fKAt/+ONkVcqPFeC3Qg07ZUucXM7rN/vjwspwnD+JRhiU6b9DZFJK49zkpAciSTm4Ms7wkoS+PnFkN80886Fvr2voUbH1DdBDukOnEYsi1IDCrsm5fBjoqcgyYQ62+rnfguBCQX0bv2BnBAIG16Yvul0Mfejo1mWZrkxQA/IpOVKvEc4TlSvRQMHmlr87JczItcfYcDwE6xacPLh8JnQFfvNREWlE8WBRuX6l2MMBaJeUfQh6U8Mfw5BkX7UYEGlU5a9PQ2gh365RlhRasHEVlSZiUcU2KF5juzzH/EPfyeY9f8iPj6tcdjIuLOx9kHQMJmiakTR58IW6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRc2y//4XF07krqjdC4jXc8SMY8cBUzbDLaIYVquW1Y=;
 b=lOPy7NK1h5esJ7guEqMkq6yHJQxV7eESQlE6csc0vIAoJHMyK9JpSGrPP7OIlKD8LZmsrboU8ddZjtTF89R56UCT6zqcr18cdjpB96PjEZJpB/EiAegwJBKO3vjSaaVPjkwOanZiNxRXTjPVskNKK8nqQyoDinzQ7JgTS5OpA98=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0331.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.29; Tue, 8 Jun 2021 19:04:26 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 19:04:26 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 3/3] nvmem: add ONIE nvmem cells parser
Date:   Tue,  8 Jun 2021 22:03:27 +0300
Message-Id: <20210608190327.22071-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608190327.22071-1-vadym.kochan@plvision.eu>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-Originating-IP: [217.20.186.93]
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 19:04:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf78756-faf9-4eb4-8eb2-08d92ab03c70
X-MS-TrafficTypeDiagnostic: HE1P190MB0331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0331E17A86F32DFF148C0FE795379@HE1P190MB0331.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /psZFIYKdlsDWrljUuyMIXCx6kaiBD5qr9c+q7p/ialU+wpOBkS5bdGWtKBerQyMkYLh6+NuVDRkgWVS9hHN4L+Xz3IUVmOV7scSyf1gnHm3MrpleJ0oXj4aHgoJqMFttTU0X+5BOF+uKhOGnL6gNbeMwCBg1KNjKzLuwMmXI13audL4XR5GotQJs9ridiZ7WujQWWYlkEIHhlMF8A5yJyCCejAxrK06LfrQwhYQh5FnaoWHXxi1bFpBpnYu1OH4D59lMJrWggGaBjbYeay4QSS8g10HsudTvXQvz7k376fSoUydUORYUS/6o8BYIoSI2z+tBF1WBjR2CeN5LgN1KOlZKUXzo9YnKFRsAGPTCXZxFtwy3EDtv0uAqEu7Hw8Xkjao8vF9GfeHw9nkC0/6GRnanRJMJAzMYYQZO6mvofjFfukjW38rMvY/5mFNbTeu4jhjOFUwtJmlHWplo9p5AE/FMUj4LnhvhjMFn5laJZdWY3+XkjIcQYuq2NQDyuexZBrbDdT+eThDRc9IHXe9yw7AYtNosCJ6FLyWynPpffIEAv3PU6rmWCqUAFcjjRLaJ/U8L2uDdxH+Ywwtn/QYN9FP4KC4qZPIjSZhsFqVIrMn6VdqnHaZPiXykZZb7lHmM+KnmxbN0AaSw8Z+vDjybw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(136003)(366004)(396003)(16526019)(52116002)(44832011)(1076003)(86362001)(26005)(38100700002)(66946007)(38350700002)(5660300002)(36756003)(8936002)(316002)(2616005)(6486002)(2906002)(186003)(107886003)(54906003)(478600001)(6512007)(83380400001)(8676002)(110136005)(66556008)(66476007)(4326008)(956004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6X6gjh5FeL43cw412ocUXzl9dtBJYIEKMiDo9IMrtHhf4vwVbPhdWTe2QuPv?=
 =?us-ascii?Q?r9V0EjYlNYPXvTH9ZbgI4epmQNw02a/pPuopSmLynVZIhEhKulr7Uwncs0S5?=
 =?us-ascii?Q?UsXCX9P/vNrZ/7CQ0Xh3qZg0Hk1fjNcN8tLWljJF40gp3aspwaXuNECN5dXr?=
 =?us-ascii?Q?G3DO47wpZiVTCjPjLyOtS17kozxbaf+lj2VsFEzmRLItBJ/lPqieI6Jv1C4y?=
 =?us-ascii?Q?4g51OhoWY0nD/G5FO0+NCbstnA1KnLVs8eXG+sQriFd5EA62LT0ZAJql8KQ+?=
 =?us-ascii?Q?nzK7YRWywD0J7Tazbdnb1b+LpSFopBO9OKH9laYN3gCE+zOz4+yF+jluJ/Zo?=
 =?us-ascii?Q?2xYxI5fxOSsxbkHliwd0JBa6SvKjNkL7rlLqmnKtCktv1+rPc74d3xNFbD++?=
 =?us-ascii?Q?bpRi5HArDn2DiDt9Y8f8CQVPKO4pKAkS1bffpdUt0x9ASg7u/mSPWa6L1DJe?=
 =?us-ascii?Q?WEXx90N5bH9rYAGhDrDN+ZuJ3/R1pMuY0xmfFLx5us2jKjw5E5Ic8+BcMCLg?=
 =?us-ascii?Q?U8DKVW/h32Q5QmL2zqNybCuEINhr8NJFGD0gml8LR5ruR8ug2HbC7zzu7qOF?=
 =?us-ascii?Q?6hL4oX5MxhJMOocN1JbMn5MaO7ev2EBMWgWjxNVyJbvYLBGivkgMcQifbkFP?=
 =?us-ascii?Q?yYWy38jIWMxe8XmckoLJ9TMs7uQJO+o0FEVCl1hIXyZPnI6KgQwCPtJDaM5q?=
 =?us-ascii?Q?BkC6mQ2yDRZD88l6PjxWbkeSsDD5He8tEeEzU2P1tYzP7jAClnMmScaGcsqr?=
 =?us-ascii?Q?QvzRUNdvePP+hVsukYkVWXRGB/B83Nap9MVXWyXALSADVnUdqq8MVEv/2uH1?=
 =?us-ascii?Q?gcSB5l9oWE4uY9YEm06fV7yrHLJrZQjloTtsDxZbI563BycvpAJRpFd+nmkO?=
 =?us-ascii?Q?lIP74Ux4u9+PNq+vGTWqZnRJm06KWZkYEuaBmHwhbXYjfNF/SSqWI68RwCUT?=
 =?us-ascii?Q?1mer9Jb1D/UxlNfKR8toXlr92+5PoTil6o2zLzj1yqtqHUJDSQierlFt40NV?=
 =?us-ascii?Q?z1efBJPIphVtogsLWSKh6XBfRxsHV0qyn8vMydWsPu4rIy78CXvBPWwn0ixB?=
 =?us-ascii?Q?C+PTFc4Z61bhFm9E4jCMYrgUfMOWIKJHJqSkXuUmhNvYziRloEdvES9uAAGY?=
 =?us-ascii?Q?lSd95adPSlWU6DcU4S3/rg8LUEbwEEc4FifhA7QzYRDn5kNyXhhpGhiDHCuK?=
 =?us-ascii?Q?aP0xhDiyI8miTFhOWebZSGBa/mwP3ofudP/HHPtEWvexrxsN2Pln3u0B81Gw?=
 =?us-ascii?Q?qWddqm7fk0Tw1YUMeSuCkKoKqsYMT0Tce7H8hFX+TS8W+MI1huWD0MGoL/fa?=
 =?us-ascii?Q?znfJrycwRWTw/k9OaP5pQ2yw?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf78756-faf9-4eb4-8eb2-08d92ab03c70
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:04:26.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/suCWHHI8imvb2fvxOU98ltJw7M8qnR4aLDVJKPBARkzCyk2H63n+YOAg2cgTbdo+s45AGm27RKLOmHtk/aKtlTxFoCuGKmNNnM5vujGNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ONIE is a small operating system, pre-installed on bare metal network
switches, that provides an environment for automated provisioning.

This system requires that NVMEM (EEPROM) device holds various system
information (mac address, platform name, etc) in a special TLV layout.

The driver registers ONIE TLV attributes as NVMEM cells which can be
accessed by other platform driver. Also it allows to use
of_get_mac_address() to retrieve mac address for the netdev.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
    1) onie-cells.c renamed to onie-tlv-cells.c

    2) Do not register onie cells parser via platform driver,
       but via module_init().

    3) Simplified cells table & lookups registration by just filling
       all this in nvmem_parser_data.

 drivers/nvmem/Kconfig          |   9 +
 drivers/nvmem/Makefile         |   2 +
 drivers/nvmem/onie-tlv-cells.c | 302 +++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 drivers/nvmem/onie-tlv-cells.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index dd2019006838..a08ff087361b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -288,4 +288,13 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_ONIE_TLV_CELLS
+	tristate "ONIE TLV cells support"
+	help
+	  This is a driver to provide cells from ONIE TLV structure stored
+	  on NVME device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-onie-tlv-cells.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index bbea1410240a..f70d7b817377 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -59,3 +59,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_ONIE_TLV_CELLS)	+= nvmem-onie-tlv-cells.o
+nvmem-onie-tlv-cells-y		:= onie-tlv-cells.o
diff --git a/drivers/nvmem/onie-tlv-cells.c b/drivers/nvmem/onie-tlv-cells.c
new file mode 100644
index 000000000000..85b1c92da0c5
--- /dev/null
+++ b/drivers/nvmem/onie-tlv-cells.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ONIE NVMEM cells provider
+ *
+ * Author: Vadym Kochan <vadym.kochan@plvision.eu>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/slab.h>
+
+#define ONIE_NVMEM_TLV_MAX_LEN	2048
+
+#define ONIE_NVMEM_HDR_ID	"TlvInfo"
+
+struct onie_tlv_hdr {
+	u8 id[8];
+	u8 version;
+	__be16 data_len;
+} __packed;
+
+struct onie_tlv {
+	u8 type;
+	u8 len;
+	u8 val[0];
+} __packed;
+
+struct onie_nvmem_attr {
+	struct list_head head;
+	const char *name;
+	unsigned int offset;
+	unsigned int len;
+};
+
+struct onie_tlv_parser {
+	unsigned int attr_count;
+	struct list_head attrs;
+	struct device *dev;
+
+	struct nvmem_cell_lookup *lookup;
+	int			nlookups;
+};
+
+static struct nvmem_parser *nvmem_parser;
+
+static bool onie_nvmem_hdr_is_valid(struct onie_tlv_hdr *hdr)
+{
+	if (memcmp(hdr->id, ONIE_NVMEM_HDR_ID, sizeof(hdr->id)) != 0)
+		return false;
+	if (hdr->version != 0x1)
+		return false;
+
+	return true;
+}
+
+static void onie_nvmem_attrs_free(struct onie_tlv_parser *parser)
+{
+	struct onie_nvmem_attr *attr, *tmp;
+
+	list_for_each_entry_safe(attr, tmp, &parser->attrs, head) {
+		list_del(&attr->head);
+		kfree(attr);
+	}
+}
+
+static const char *onie_nvmem_attr_name(u8 type)
+{
+	switch (type) {
+	case 0x21: return "product-name";
+	case 0x22: return "part-number";
+	case 0x23: return "serial-number";
+	case 0x24: return "mac-address";
+	case 0x25: return "manufacture-date";
+	case 0x26: return "device-version";
+	case 0x27: return "label-revision";
+	case 0x28: return "platforn-name";
+	case 0x29: return "onie-version";
+	case 0x2A: return "num-macs";
+	case 0x2B: return "manufacturer";
+	case 0x2C: return "country-code";
+	case 0x2D: return "vendor";
+	case 0x2E: return "diag-version";
+	case 0x2F: return "service-tag";
+	case 0xFD: return "vendor-extension";
+	case 0xFE: return "crc32";
+
+	default: return "unknown";
+	}
+}
+
+static int onie_nvmem_tlv_parse(struct onie_tlv_parser *parser, u8 *data, u16 len)
+{
+	unsigned int hlen = sizeof(struct onie_tlv_hdr);
+	unsigned int offset = 0;
+	int err;
+
+	parser->attr_count = 0;
+
+	while (offset < len) {
+		struct onie_nvmem_attr *attr;
+		struct onie_tlv *tlv;
+
+		tlv = (struct onie_tlv *)(data + offset);
+
+		if (offset + tlv->len >= len) {
+			pr_err("TLV len is too big(0x%x) at 0x%x\n",
+				tlv->len, hlen + offset);
+
+			/* return success in case something was parsed */
+			return 0;
+		}
+
+		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		if (!attr) {
+			err = -ENOMEM;
+			goto err_attr_alloc;
+		}
+
+		attr->name = onie_nvmem_attr_name(tlv->type);
+		/* skip 'type' and 'len' */
+		attr->offset = hlen + offset + 2;
+		attr->len = tlv->len;
+
+		list_add(&attr->head, &parser->attrs);
+		parser->attr_count++;
+
+		offset += sizeof(*tlv) + tlv->len;
+	}
+
+	if (!parser->attr_count)
+		return -EINVAL;
+
+	return 0;
+
+err_attr_alloc:
+	onie_nvmem_attrs_free(parser);
+	return err;
+}
+
+static int onie_nvmem_decode(struct onie_tlv_parser *parser, struct nvmem_device *nvmem)
+{
+	struct onie_tlv_hdr hdr;
+	u8 *data;
+	u16 len;
+	int ret;
+
+	ret = nvmem_device_read(nvmem, 0, sizeof(hdr), &hdr);
+	if (ret < 0)
+		return ret;
+
+	if (!onie_nvmem_hdr_is_valid(&hdr)) {
+		pr_err("invalid ONIE TLV header\n");
+		return -EINVAL;
+	}
+
+	len = be16_to_cpu(hdr.data_len);
+
+	if (len > ONIE_NVMEM_TLV_MAX_LEN)
+		len = ONIE_NVMEM_TLV_MAX_LEN;
+
+	data = kmalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = nvmem_device_read(nvmem, sizeof(hdr), len, data);
+	if (ret < 0)
+		goto err_data_read;
+
+	ret = onie_nvmem_tlv_parse(parser, data, len);
+	if (ret)
+		goto err_info_parse;
+
+	kfree(data);
+
+	return 0;
+
+err_info_parse:
+err_data_read:
+	kfree(data);
+	return ret;
+}
+
+static int onie_nvmem_cells_parse(struct onie_tlv_parser *parser,
+				  struct nvmem_device *nvmem,
+				  struct nvmem_cell_table *table)
+{
+	struct nvmem_cell_info *cells;
+	struct onie_nvmem_attr *attr;
+	unsigned int ncells = 0;
+	int err;
+
+	INIT_LIST_HEAD(&parser->attrs);
+	parser->attr_count = 0;
+
+	err = onie_nvmem_decode(parser, nvmem);
+	if (err)
+		return err;
+
+	cells = kmalloc_array(parser->attr_count, sizeof(*cells), GFP_KERNEL);
+	if (!cells) {
+		err = -ENOMEM;
+		goto err_cells_alloc;
+	}
+
+	parser->lookup = kmalloc_array(parser->attr_count,
+				     sizeof(struct nvmem_cell_lookup),
+				     GFP_KERNEL);
+	if (!parser->lookup) {
+		err = -ENOMEM;
+		goto err_lookup_alloc;
+	}
+
+	list_for_each_entry(attr, &parser->attrs, head) {
+		struct nvmem_cell_lookup *lookup;
+		struct nvmem_cell_info *cell;
+
+		cell = &cells[ncells];
+
+		lookup = &parser->lookup[ncells];
+		lookup->con_id = NULL;
+
+		cell->offset = attr->offset;
+		cell->name = attr->name;
+		cell->bytes = attr->len;
+		cell->bit_offset = 0;
+		cell->nbits = 0;
+
+		lookup->cell_name = cell->name;
+		lookup->con_id = cell->name;
+
+		ncells++;
+	}
+
+	table->ncells = ncells;
+	table->cells = cells;
+
+	parser->nlookups = ncells;
+
+	onie_nvmem_attrs_free(parser);
+
+	return 0;
+
+err_lookup_alloc:
+	kfree(cells);
+err_cells_alloc:
+	onie_nvmem_attrs_free(parser);
+
+	return err;
+}
+
+static int onie_cells_parse(struct nvmem_device *nvmem,
+			    struct nvmem_parser_data *data)
+{
+	struct onie_tlv_parser parser;
+	int err;
+
+	err = onie_nvmem_cells_parse(&parser, nvmem, &data->table);
+	if (err) {
+		pr_err("failed to parse ONIE attributes\n");
+		return err;
+	}
+
+	data->nlookups = parser.nlookups;
+	data->lookup = parser.lookup;
+
+	return 0;
+}
+
+static int __init onie_tlv_init(void)
+{
+	struct nvmem_parser_config parser_config = { };
+
+	parser_config.cells_parse = onie_cells_parse;
+	parser_config.owner = THIS_MODULE;
+	parser_config.name = "onie-tlv-cells";
+
+	nvmem_parser = nvmem_parser_register(&parser_config);
+	if (IS_ERR(nvmem_parser)) {
+		pr_err("failed to register %s parser\n", parser_config.name);
+		return PTR_ERR(nvmem_parser);
+	}
+
+	pr_info("registered %s parser\n", parser_config.name);
+
+	return 0;
+}
+
+static void __exit onie_tlv_exit(void)
+{
+	nvmem_parser_unregister(nvmem_parser);
+}
+
+module_init(onie_tlv_init);
+module_exit(onie_tlv_exit);
+
+MODULE_AUTHOR("Vadym Kochan <vadym.kochan@plvision.eu>");
+MODULE_DESCRIPTION("ONIE TLV NVMEM cells parser");
+MODULE_LICENSE("GPL");
-- 
2.17.1

