Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64283A03A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhFHTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:19:33 -0400
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com ([40.107.21.91]:45657
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236448AbhFHTH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRYUiWwmjrpinlz04GcL8A9X22LY/I+IwvFY7NgKl/m5DQJpwNMD4V2RbkW+P3Yh4xM2lveO59FYhkXudml236m57a0V8rQfQgkKU+TqXu/WpJlBaQylKLh3cq2TQSoDf3QeNZIYptdcv29hVVZ57F60yICNrE6evWt/aiD/RJgPsSMDM7KZO7oOvzdFX7QqzTQ93nWGPmwMQaBwF4Y4lvyGr+0wkfrlXSipL7GUp7wJmdwzrQbNjHEvW+R/5QnU/cB4tNKuTRF3PKM/t+ztle8qVgz5H6pkDzlaMQgfiVnPhR4yyw4UCBPCViuYxGLVfJPX0Bda7i0pt1+i6lQbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZqf5M1O9p8zYxPlGWO4DChVFdYEqZR8ykiM1vbtJD0=;
 b=CEicpVV9vhHs26SiC6gdFJPNc2UkychWv6x8KeOkmU3yDlpa0/UHI9sLjnbKcfN1UmKCJL9W6hjZVv86NdIcZiAfLnJEWV+VPx0ZhxLlq17jEfzgCE52mbw1W3Td5bxBhfhD1QAj9lDjxIBc8tRGnZno0lc/ZpH/XXK5ESRFEOiBiblEE+JaMpOD2OMnzpcm7vjVaJPWlWYbkBnbY/VMGNMnaG5ujf0iZktp4dnw2oqAIfsgywKsDAr/glP4O5hceiPK49JjBM7scZu0I5Vc059MJgVmhmuAlmhz69Xu3SFfETs+cCZZjgX3Pstm7ZuUPKJ59j+LnjnVnM6STLTafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZqf5M1O9p8zYxPlGWO4DChVFdYEqZR8ykiM1vbtJD0=;
 b=xA2yHWabJkvpXXXvsctEWejSzLxbfHa/+/Ll2ZpUdy7S/eIOsJMon/wxDJLMSi7+ewbssIOHl+Y2+ixBACz+C7joQ8btq2NRb8ZTBjinnDrlkMAepH0lpPYS2Qjyp8WpAqAUhtONQFiAuf/wnyO34WVnlNJnDVNqIx7A7DZT/aA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0331.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.29; Tue, 8 Jun 2021 19:04:24 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::edb4:ae92:2efe:8c8a%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 19:04:24 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 0/3] nvmem: add ONIE NVMEM cells parser
Date:   Tue,  8 Jun 2021 22:03:24 +0300
Message-Id: <20210608190327.22071-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [217.20.186.93]
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM0PR06CA0107.eurprd06.prod.outlook.com (2603:10a6:208:fa::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend Transport; Tue, 8 Jun 2021 19:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00ea6b31-0ab8-4ddf-84bd-08d92ab03ac9
X-MS-TrafficTypeDiagnostic: HE1P190MB0331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0331594873018945617311C095379@HE1P190MB0331.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jW9zVswGosAx5GGVd/R3k6YTPx1xh3I6qa2mErQp73sZMtg80w3mY1QNakcxYXJeaGJSPBgamuMXE1vGPI3GpG5ocq0pylg3Aqk02vK1tRz9tGWY7PlGSwmjwDLcGtSzDZKjuVhLZZJPEdbPPP6cj439DVxKxeNhuGeq89bVuR2ObLWCIxJHERxDBFSZLBSfXcfy0JTuAvZc3UFvD9fymYkQPUF7vQqdjEppoA8z8k3m2QPr7IZl8f5C7jKH2j471bebox7vBVa+67nZ1CvQ1CXjHhVYO2GdCcmrJQxCmyKYBjWIbK9P+k1UuBXQUS0fUqYu4otMe3f5Q2QGdo6/NjGZ1yKdJbAnio+8QSdW917BgXsvNRpd8a325jrFdGS9hJ6OAm5Pe5da1b2lGVu3UNU7z+j9zVjTqEhjOlBYXBEycj7tYGUPFIxoD2BOWeJhIAsjcnDkpaABHu/5qIHl4sZITJqZeI0WlFdVWmIb0pagQR2RhotoLUbqznSwCnkqjJi4xTqYEGodqOHZI8An4ogrdMAIcQsLXXbRQvmtth4qDyw+SDz1rBdnP6lTXRqxJKeBBiu4qwhXp6JWZWRj4FUOk4LEboAnONFuxijhWbUQWvOD6TgrKmT4RUp2BP6WQKRS9X2QVTt8ESBULrXrsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(136003)(366004)(396003)(16526019)(52116002)(44832011)(1076003)(86362001)(26005)(38100700002)(66946007)(38350700002)(5660300002)(36756003)(8936002)(316002)(2616005)(6486002)(2906002)(186003)(107886003)(54906003)(478600001)(6512007)(8676002)(110136005)(66556008)(66476007)(4326008)(956004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bIGhnkj7FHY9XG2fIXVbC0KS2/AIZbvGRFvNE+UCgLDVwroC0I67S+iW3Ai9?=
 =?us-ascii?Q?Wv/MVuN22Iby0lUvRI66RGY3mbxQBzLO/vXyPtZOD3sJNaxtDFMNklB9+7jD?=
 =?us-ascii?Q?mE62fQQG0cT54iO1eP8MXakaKImjlzxdFGHInYocpsCUXqTHD6bJ2xfwg3Ql?=
 =?us-ascii?Q?Nw+UBz5ebBKtlGcyRtfzIap7aHCvwphNKzX4BhdJt8qmPH0JBMf6sGLQ/hom?=
 =?us-ascii?Q?aVGNotcJ6AJcjKDIMceVaqwYzaUOpc/VTjRahdZysQRHzwJ8p5RgCFaKsss6?=
 =?us-ascii?Q?a7e+RmWliFDPl+YpIt9nUo/l/Pl4LVPWP85hdxMOO5nkbZPLzFVfDaPnr6ao?=
 =?us-ascii?Q?d9lhM91jlUSsrkTIYW+BGb3XeW11dZfqeDFY95SGe4kItYcy5PrPLMegcOfa?=
 =?us-ascii?Q?WYXStIc/lENYbP+XnBOtSxqT3P8b5fBvyBEYg65CAeGypiWVywgfEFTuv4or?=
 =?us-ascii?Q?jKSKw/cmwMT/Cwty5S1AUu23vxSdBXLJEpqSbNaLHXrFsFNG/BKAjI2Zvfpn?=
 =?us-ascii?Q?5tDfhcwp4KKOjcaSYzvvRDlSubQ6hbkBHGwUksJZ/EeMG4p6GzBRLfeDrti4?=
 =?us-ascii?Q?6T9+5paWusWxjtXahi18Np9SJIIzTFM1/wcfA2LP1xdevsTNPd8kKzEwELa8?=
 =?us-ascii?Q?6WVXD3kU424Qlq0znvMhbW6g5Ipt8YyXpHhOmGqipiir5Z3SZCj6q12u6JRW?=
 =?us-ascii?Q?BBKFXA2yLEGmYc44QCDX49gq4Bf7FuEQZzASNP+VskSRFVpBQNRNjL41b+qf?=
 =?us-ascii?Q?/fgFmCkU70boy/o7GsR0edVAi5Ijy8A0AasUGML4nF2WseZx5w1QZs2P/kCx?=
 =?us-ascii?Q?EGarYMSTb0m3eonsC7q+lLv6/bInqe+7EHaj9yj3pJvb59vmtDj7FwCoZ3Jx?=
 =?us-ascii?Q?eU6DU8Yc7nQzicqosT62Fw0kGVqi/i09j7j/+8CcaUEWOs6vRHDNx0o5mYIl?=
 =?us-ascii?Q?xiBKiS4e2v4te5Q9ti9q1pwzitNhgcs+uwULBlQP7WIP/I6y4+kHtp5UGEvc?=
 =?us-ascii?Q?N/ML4TXt+oYsj/6T874STUeHCqTF12bd9Fs0S54aiSOK/aStDWZF2BDt6f4X?=
 =?us-ascii?Q?nLDpjBhIzx0saQuZthp0iH//mkUBJzQ/9n8Mm2ipWWidtzMYOU3syd5wGisf?=
 =?us-ascii?Q?tk4sX0XHVCE5J+bUW+toVAWaiLoDXeylyN8zbj2rkojqG3vweWonQw26+R7k?=
 =?us-ascii?Q?7r/ZwKzFskkufEqQiX1zknPgwjz7mT6aoQ+ZGaQjfkysJKsSHoXwS9E3aB9P?=
 =?us-ascii?Q?TBNi7hdp29T2MeKk8GKBGuP4/UZMcKvKStWcRz1oTudff+0GYbYQw7w1rYfq?=
 =?us-ascii?Q?LORJw7UlWc7vFHXZ78f+Du/7?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ea6b31-0ab8-4ddf-84bd-08d92ab03ac9
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:04:24.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQloIEwVHaF4/cqsdrgyUAevptFHKoXqZbMfSIVxgYgK2V4fYq0pLSxtWNN4WocIs85dDSxhlLtp3WAXYFOxpDFi2KaoAp33qBUClFLa5Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds cells parser for the ONIE TLV attributes which are
stored on NVMEM device. It adds possibility to read the mac address (and
other info) by other drivers.

Because ONIE stores info in TLV format it should be parsed first and
then register the cells. Current NVMEM API allows to register cell
table with known cell's offset which is not guaranteed in case of TLV.

To make it properly handled the NVMEM parser object is introduced. The
parser needs to be registered before target NVMEM device is registered.
During the registration of NVMEM device the parser is called to parse
the device's cells and reister the cell table.

v2:
    1) Series title changed, "provider" is replaced by "parser".

    2) onie-cells.c renamed to onie-tlv-cells.c

    3) Do not register onie cells parser via platform driver,
       but via module_init().

    4) Removed cells_remove callback from nvmem_parser_config because
       now cells table and lookups are registered by core.c

    5) Introduced nvmem_parser_data which is passed to parser
       handler/driver to fill cells table & lookups.

    6) core.c registers cells table & lookups to simplify the parser
       handler logic.

    7) parser's module refcount is incremented/decremented on each parser
       bind/unbind to nvmem device.

    8) core.c relies on parser name which is obtained via
       device_property API, instead of of_node which was used
       in previous version.

    9) nvmem-cell-parser-name DT nvmem property was added to bind
       cells parser to nvmem device during the nvmem registration.

P.S.
I marked it with v2 as relative to series which was sent as:

    "nvmem: add ONIE NVMEM cells provider"
    
Vadym Kochan (3):
  nvmem: core: introduce cells parser
  dt-bindings: nvmem: document nvmem-cells-parser-name property
  nvmem: add ONIE nvmem cells parser

 .../devicetree/bindings/nvmem/nvmem.yaml      |   5 +
 drivers/nvmem/Kconfig                         |   9 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/core.c                          | 178 +++++++++++
 drivers/nvmem/onie-tlv-cells.c                | 302 ++++++++++++++++++
 include/linux/nvmem-provider.h                |  31 ++
 6 files changed, 527 insertions(+)
 create mode 100644 drivers/nvmem/onie-tlv-cells.c

-- 
2.17.1

