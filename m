Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557B53A03A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhFHTUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:20:09 -0400
Received: from mail-vi1eur05on2124.outbound.protection.outlook.com ([40.107.21.124]:22624
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236743AbhFHTHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMCudsTjOXibqF+60MYBKBrFdkY7Ku3quYX4D8vPnJfjBm/tRx6h1v38hDEBrgs2uQDflVPHbYsezb9ArKuro+bUybLaBZFj4YCSyREs4k3/bl8LgBL/g1jb/Ikjy1xwocBnsRDkiB22VUodz1ZhcUQVISxr1bJujcbwGCeFVy8Jr6wy0GLOM/sBVN9FQNlZHf0Vve4e7v9DCS5rGNAv1cK/MrnCYDEKhyw6lQqsNFiW7yT9yxlTfrtThEb9aGBbSbZt4Bj8Sd7JzvLYW6jFsF+tuNHH8Pn8ZW+GAYAO/7RQZtf2Nt/vkDFfyasvMX1E/0DUBTjZY5K4l5LrOIOtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKXinOGFTestUNe4t7IgMUYMHGOo5qwpXnr1orl8q84=;
 b=h2TlYVryXhfu3So9nyJAlTx1gAQ783vW49cfLcxB/yXC39KF5tpYeaBSq0SgcwSfhWkJK38wnIDj38JFsDMaATnpnnE3XXMUW1IRKE2BtYfeYhmkWJbbc19Gv5NBOhwlt6syPxXcZiQ6MZEqibpIhnWvohrPihYxQS2zoU63zYSm/LxCLfH85jMSdKys/tJEp0Ufywl1G/jDXLSew8NJWHe67WiDO7XAWquxkfrGFLJXQyztB4ru50K5sMdGgFv8TfA/vI0Ae82w8/MALmbjPgIfmzSScKWNCIgRTQDdsi7msgJsFTTlGPMnWWYLb7P6yuXnFyTHXIcaZl10gpvJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKXinOGFTestUNe4t7IgMUYMHGOo5qwpXnr1orl8q84=;
 b=d1c2CZaK1y2RcJCU2tiECpuHbEB5c0+iCBURHYV7R2c9oXG9IvHOyNeTovieCPZ+A8wMDr29INjIX923mEzIKm7mCxbRzCCERZPJ0HEQIN+XH0tBeYeRVSCRkLAf1t+pllLKmHaPZDrxy7vHjOyaVi87l6dQIlrXBY2LXvb2+5Y=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0331.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.29; Tue, 8 Jun 2021 19:04:25 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 19:04:25 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 1/3] nvmem: core: introduce cells parser
Date:   Tue,  8 Jun 2021 22:03:25 +0300
Message-Id: <20210608190327.22071-2-vadym.kochan@plvision.eu>
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
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 19:04:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3396a1a-87ad-40cc-2c45-08d92ab03b59
X-MS-TrafficTypeDiagnostic: HE1P190MB0331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0331A3F09D14B7CFCDD2CA1595379@HE1P190MB0331.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+Ll6mwoNK1CtQAvXde7AW5fU9MtGuphkiUvEMIhpJgiw8/n2JNOSvm7vxJ+jymklWEQkkoSemH7OOgZ9j7Er8vova49X3KkdoNaHlPD/QKR1/6/bDz+SrHlx8aHIZKWaaSZ7oL6SLZQiA+l03kPAK3IbghwFsqCQ3Ww+MxuFw5WZ0cUBlUOcq+rWVMXD8Y5BpMOsdoP4sUxzg6qqcL/UJjY8T5KEgNjpPzIkfSQo2FeomSMfFUJaqmL+uvMphOrI97thWOhfwID/ZiBNMcXQ/G+uwE0OUeFtE1/bUAZnh6MAPpRodJhaRX+KxmtC03nMh6ebUi96tGEwaFZMxZYnsXluzPtt9BHQbSVXfQqvgTKCv4RWorL9OnmcdASFP5lznVxlfqbM/w0TELVe8G9doZijYAi6JQS0Srxnkt7rEDUkf4wNtU1ofUV/FnpxyHyJjYLgrVFLlskN+mmJlQRJdSFzD/icb94PGaZh86xppy/Uk5I6cMMGwOjz7zCCr5KO+Y8vN+sDiN/FCOFTWmz9a0Yve4oHPPg8ztGF6NN3ch/K2pDL+v3+pZlnosMmAAn+Qad7CFUEBbG7MHzvXk/uvGfqYvgzkH4NZKT6WX8frqQBO4Xiemm30GiK63aJOImYHwWfHKxIIvsvf62U9QbNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(136003)(366004)(396003)(16526019)(52116002)(44832011)(1076003)(86362001)(26005)(38100700002)(66946007)(38350700002)(5660300002)(36756003)(8936002)(316002)(2616005)(6486002)(2906002)(186003)(107886003)(54906003)(478600001)(6512007)(83380400001)(8676002)(110136005)(66556008)(66476007)(4326008)(956004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WtFte24duWGeM8T3dLBXZybejdxZOUGvyb1iNig63ZPjR3AvuPXqr+G76wNV?=
 =?us-ascii?Q?JwmgdJgw9Vq6K9gnyB9lzC7pbkYdDJwCUl5g4elK91AraOyXV58uFqlEYyCp?=
 =?us-ascii?Q?c2jhoTCo9aA1mRIBSCB1dhLK5P9ffO+57wVqTAKWHlzsMqT66p/TsfrbaukG?=
 =?us-ascii?Q?QGxMcuGqosInb3/8lwyPvSJkXoGP3gHGBe8dz6trScooi6vJNjjUlK9THwVP?=
 =?us-ascii?Q?mPjwK4fYGZ7ez5KWq40aWjJfAoeAiqW3dXvu2IdCCgWDpg4sCprroF9raFVB?=
 =?us-ascii?Q?U6U08Ov7idmN7xH+T5MrKcTbttFUs2e3U6b0jLTqxNjhTOlhm/dUdQyRwrYD?=
 =?us-ascii?Q?uCJbcUbdIxwZd7KX1RtkcR5LxnUguwO09vtN3O8sjRECcYqSilc7sARheJvY?=
 =?us-ascii?Q?PwgqYRg3lN0gnCH5JZcDdm+mQ53xmah8SFN+PwmFE+owihxbCwSE14YeRiBj?=
 =?us-ascii?Q?4gfkxmuCyVG3P0k4oklMCj0BAEiEHHvQZgzfUfQNlbq5v+gBdsSgV51QV1Ps?=
 =?us-ascii?Q?ADN6hnUfumv/PYjX63TXBK6g+i+OiH9Un9Z8evMS/D+DxW9oBDCp7vD26Mp4?=
 =?us-ascii?Q?jJUsbayFOhgCkOADC2Vq+MJUnxPHwCbxuL58H7n72N9sxO0NuFfJz2UtA97/?=
 =?us-ascii?Q?IyPkRuPhMBIMjdphSZmacs+P55/WnqvwRk89U9w1hET6gkjGbKACy6t9TxJf?=
 =?us-ascii?Q?jyxPbPVpCxYsMPdFA1xK5TtgtGXhz4wA2qwKyqkUgg3MCaj7B4jVcZPidQof?=
 =?us-ascii?Q?0nNn0QTDi18QE+52tJcdzZ8bWYnLrft3OyVtypFU9Ik0AV+XZpbAAwXwAUvI?=
 =?us-ascii?Q?yPbTmGkGDTQH0+zZV/rrWTaodtou5jFPXXsDzqKjRbu5jAYd3Opo2GyE71Ni?=
 =?us-ascii?Q?3+CzM/AlFTq9cJnCHwGB7woBSw7LFeQYLO0lmIL2GUwtTkU4cD+KtX1bYhRN?=
 =?us-ascii?Q?ULm0+kfLU4npWxa7VvxZpKK2c5K0UwB3xTi0dwBnSJJ0mGhikgm72GGC0CKe?=
 =?us-ascii?Q?7U3gQphrWJBs9cAzO41cJmY7h6s7pKwRFPL8Y3E8Ca9+T/aB372dw0MxTXaT?=
 =?us-ascii?Q?2fyO97E1Unxh4LRo4ETCd0f5lhQlYlVhTTm3uMGhdOkxPnbV1LTBNTV1qXOZ?=
 =?us-ascii?Q?KBPVgNUtsUsrfHWjcupc1FhoRNBhl1rhvTew4R0OA4tf6ihmXrjPozMaaroc?=
 =?us-ascii?Q?KgrIlbrWZ3C4y/BnUp4q1K21SkhADj/Lc5Re/WdYELI/NXTrO9vUahXX1idv?=
 =?us-ascii?Q?0t7adP7HVgy4VLIdEJ/BogMFshYWJkBbrBwCiYTqhdDO86HHRDwNfxQ2vVtU?=
 =?us-ascii?Q?zpAf0va+Y1IITTWwK/ZJ1QfW?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a3396a1a-87ad-40cc-2c45-08d92ab03b59
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:04:24.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCT0QLmMutUq8zJglSNRijwVWT66AKPSdOKvFziSQ4hbLKl7xwo1L7q86f6hEkY7QgdqE99dZiBLXEg4p2GCIjocDejcXIJAe5OWdHlrP+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation does not allow to register cells for already
registered nvmem device and requires that this should be done before. But
there might a driver which needs to parse the nvmem device and after
register a cells table.

Introduce nvmem_parser API which allows to register cells parser which
is called during nvmem device registration. During this stage the parser
can read the nvmem device and register the cells table.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
    1) Added nvmem_parser_data so parser implementation
       should fill it with cells table and lookups which
       will be registered by core.c after cells_parse was
       succeed.

    2) Removed cells_remove callback from nvmem_parser_config which
       is not needed because cells table & lookups are
       registered/unregistered automatically by core.

    3) Use new device property to read cells parser name during nvmem
       registration. Removed of_node usage.

    4) parser's module refcount is incremented/decremented on each parser
       bind/unbind to nvmem device.

 drivers/nvmem/core.c           | 178 +++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h |  31 ++++++
 2 files changed, 209 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bca671ff4e54..648373ced6d4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -39,6 +39,7 @@ struct nvmem_device {
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	struct gpio_desc	*wp_gpio;
+	struct nvmem_parser_data *parser_data;
 	void *priv;
 };
 
@@ -57,6 +58,13 @@ struct nvmem_cell {
 	struct list_head	node;
 };
 
+struct nvmem_parser {
+	struct list_head	head;
+	nvmem_parse_t		cells_parse;
+	const char		*name;
+	struct module		*owner;
+};
+
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
@@ -66,6 +74,9 @@ static LIST_HEAD(nvmem_cell_tables);
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 static LIST_HEAD(nvmem_lookup_list);
 
+static DEFINE_MUTEX(nvmem_parser_mutex);
+static LIST_HEAD(nvmem_parser_list);
+
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
@@ -418,6 +429,118 @@ static struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 
+static struct nvmem_parser *__nvmem_parser_get(const char *name)
+{
+	struct nvmem_parser *tmp, *parser = NULL;
+
+	list_for_each_entry(tmp, &nvmem_parser_list, head) {
+		if (strcmp(name, tmp->name) == 0) {
+			parser = tmp;
+			break;
+		}
+	}
+
+	if (!parser)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	if (!try_module_get(parser->owner)) {
+		pr_err("could not increase module refcount for parser %s\n",
+		       parser->name);
+		return ERR_PTR(-EINVAL);
+
+	}
+
+	return parser;
+}
+
+static void nvmem_parser_put(const struct nvmem_parser *parser)
+{
+	module_put(parser->owner);
+}
+
+static int nvmem_parser_bind(struct nvmem_device *nvmem, const char *name)
+{
+	struct nvmem_parser_data *data;
+	struct nvmem_parser *parser;
+	int err;
+
+	mutex_lock(&nvmem_parser_mutex);
+
+	parser = __nvmem_parser_get(name);
+	err = PTR_ERR_OR_ZERO(parser);
+	if (!err) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (data) {
+			data->parser = parser;
+			nvmem->parser_data = data;
+		} else {
+			nvmem_parser_put(parser);
+			err = -ENOMEM;
+		}
+	}
+
+	mutex_unlock(&nvmem_parser_mutex);
+
+	return err;
+}
+
+static void nvmem_parser_unbind(const struct nvmem_device *nvmem)
+{
+	struct nvmem_parser_data *data = nvmem->parser_data;
+
+	if (data->table.cells) {
+		nvmem_del_cell_table(&data->table);
+		kfree(data->table.cells);
+	}
+	if (data->lookup) {
+		nvmem_del_cell_lookups(data->lookup, data->nlookups);
+		kfree(data->lookup);
+	}
+
+	nvmem_parser_put(data->parser);
+}
+
+static void nvmem_parser_data_register(struct nvmem_device *nvmem,
+				       struct nvmem_parser_data *data)
+{
+	if (data->table.cells) {
+		if (!data->table.nvmem_name)
+			data->table.nvmem_name = nvmem_dev_name(nvmem);
+
+		nvmem_add_cell_table(&data->table);
+	}
+
+	if (data->lookup) {
+		struct nvmem_cell_lookup *lookup = &data->lookup[0];
+		int i = 0;
+
+		for (i = 0; i < data->nlookups; i++, lookup++) {
+			if (!lookup->nvmem_name)
+				lookup->nvmem_name = nvmem_dev_name(nvmem);
+
+			if (!lookup->dev_id)
+				lookup->dev_id = data->parser->name;
+		}
+
+		nvmem_add_cell_lookups(data->lookup, data->nlookups);
+	}
+}
+
+static void nvmem_cells_parse(struct nvmem_device *nvmem)
+{
+	struct nvmem_parser_data *data = nvmem->parser_data;
+	struct nvmem_parser *parser = data->parser;
+	int err;
+
+	mutex_lock(&nvmem_parser_mutex);
+
+	err = parser->cells_parse(nvmem, data);
+	if (!err)
+		nvmem_parser_data_register(nvmem, data);
+
+	mutex_unlock(&nvmem_parser_mutex);
+}
+
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
@@ -435,6 +558,9 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 
 	list_for_each_entry_safe(cell, p, &nvmem->cells, node)
 		nvmem_cell_drop(cell);
+
+	if (nvmem->parser_data)
+		nvmem_parser_unbind(nvmem);
 }
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
@@ -739,6 +865,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 {
 	struct nvmem_device *nvmem;
+	const char *parser_name;
 	int rval;
 
 	if (!config->dev)
@@ -809,6 +936,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
+	if (!device_property_read_string(config->dev, "nvmem-cell-parser-name",
+					 &parser_name)) {
+		rval = nvmem_parser_bind(nvmem, parser_name);
+		if (rval) {
+			ida_free(&nvmem_ida, nvmem->id);
+			kfree(nvmem);
+			return ERR_PTR(rval);
+		}
+	}
+
 #ifdef CONFIG_NVMEM_SYSFS
 	nvmem->dev.groups = nvmem_dev_groups;
 #endif
@@ -837,6 +974,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_teardown_compat;
 	}
 
+	if (nvmem->parser_data)
+		nvmem_cells_parse(nvmem);
+
 	rval = nvmem_add_cells_from_table(nvmem);
 	if (rval)
 		goto err_remove_cells;
@@ -857,6 +997,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
+	if (nvmem->parser_data)
+		nvmem_parser_unbind(nvmem);
 	put_device(&nvmem->dev);
 
 	return ERR_PTR(rval);
@@ -1891,6 +2033,42 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+struct nvmem_parser *
+nvmem_parser_register(const struct nvmem_parser_config *config)
+{
+	struct nvmem_parser *parser;
+
+	if (!config->cells_parse)
+		return ERR_PTR(-EINVAL);
+
+	if (!config->name)
+		return ERR_PTR(-EINVAL);
+
+	parser = kzalloc(sizeof(*parser), GFP_KERNEL);
+	if (!parser)
+		return ERR_PTR(-ENOMEM);
+
+	parser->cells_parse = config->cells_parse;
+	parser->owner = config->owner;
+	parser->name = config->name;
+
+	mutex_lock(&nvmem_parser_mutex);
+	list_add(&parser->head, &nvmem_parser_list);
+	mutex_unlock(&nvmem_parser_mutex);
+
+	return parser;
+}
+EXPORT_SYMBOL(nvmem_parser_register);
+
+void nvmem_parser_unregister(struct nvmem_parser *parser)
+{
+	mutex_lock(&nvmem_parser_mutex);
+	list_del(&parser->head);
+	kfree(parser);
+	mutex_unlock(&nvmem_parser_mutex);
+}
+EXPORT_SYMBOL(nvmem_parser_unregister);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index e162b757b6d5..447241706554 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -15,10 +15,15 @@
 
 struct nvmem_device;
 struct nvmem_cell_info;
+struct nvmem_cell_table;
+struct nvmem_parser_data;
+
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
+typedef int (*nvmem_parse_t)(struct nvmem_device *nvmem,
+			     struct nvmem_parser_data *data);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -117,6 +122,19 @@ struct nvmem_cell_table {
 	struct list_head	node;
 };
 
+struct nvmem_parser_config {
+	const char	*name;
+	nvmem_parse_t	cells_parse;
+	struct module	*owner;
+};
+
+struct nvmem_parser_data {
+	struct nvmem_cell_table		table;
+	struct nvmem_cell_lookup	*lookup;
+	int				nlookups;
+	struct nvmem_parser		*parser;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -130,6 +148,11 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 void nvmem_add_cell_table(struct nvmem_cell_table *table);
 void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
+struct nvmem_parser *
+nvmem_parser_register(const struct nvmem_parser_config *config);
+
+void nvmem_parser_unregister(struct nvmem_parser *parser);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -154,5 +177,13 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
 static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
+static inline struct nvmem_parser *
+nvmem_parser_register(const struct nvmem_parser_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void nvmem_parser_unregister(struct nvmem_parser *parser) {}
+
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.17.1

