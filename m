Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC353FEF16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbhIBOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:04:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18156 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234331AbhIBOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:04:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182AmToX011043;
        Thu, 2 Sep 2021 14:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ampIWHcOGFM4fHCOAWB03efX+T0PwMqcBwnTGOW2kOk=;
 b=ikXNfDq2JLs5mKA0obAFfowrC/vNux7tdlQtWKzT9Zh3xhHoO2f13vbfORiSBVBX0K42
 tugmDEcOYztpL+0+dykvF/ejQQIok7gfE5Ihwn6hiaFNgqnwXwFOlPLFVpmF7H1gRo9U
 vhoHafX0dANJwcBt5PiNB+0JzI5Mg26TCpWSRve5L3N59JB2PzG4qEk0ZH+AVDe0JTUm
 V+NFCGJPeSa/407GGJMWYSVtEmKZ6A4E4d6Mt+IBJ9ZRHtBeeAjyV2vbYNUsruS25ipo
 ow1zGGNKPzJ3fDEYxoPAvl3Y4/CDGdymFJwOv+j/IIPux4Am84YZElyahmX4GnF5WRvs FQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=ampIWHcOGFM4fHCOAWB03efX+T0PwMqcBwnTGOW2kOk=;
 b=MuFjn2EFi+cORz1ONzp4SbQbhYg918MpmJPAmQTx77JS8ELfsqobOIa7fL6nQisKMLaG
 yVX+gQ/fu+TDcCSnI/F7WUPjkz1gdwsfGp8Dvib3u2zbVqbdKnETDCfUh/Zr0GXzcwzs
 7uoMoycyeCo4iy+l9QhUzJtbZ+S/bGp8vGhTNJuqGHBJ6F6XW02Y66VTYz5sL1TWnFUD
 TrsH0npVVQwNT6TT2Of6Hb2LOcXeXsEQq8jFsFOHZhx3LyiEf5Ca8ESnEAwOXA7UGAbN
 rxBt76vMNFvjVwbm80LoONwO7Swt9FAee6Bl+oEa+Ydc10VsMVAFok1J68sifEwHcr58 Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw5atc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 14:03:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182E0XSL113737;
        Thu, 2 Sep 2021 14:03:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3ate05vved-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 14:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SduLilewzpFED9vx41YIzMCDpOfRO8qguE9YpSuk32hO0qKQImHF1qhIIaMMbq/Jv1Fxlbi3GzSBkOoT5qRUw27yccgbY6HWpi62JHTVTs2DZBsoOi/edmw03pwZDVRp6LiuiTeClSqHcg4fsUztkUOXsFff91s84UywY81eLiGoEAWwzPnaHtByMbpPpwnoymCtOXAdaXkNv+ZTZnEvI1fZFeBFLW1vhX2yFpNnt2bq2IdoMuNLiRAC7/H/fiNZFGjx5q1HFZrtTfJCO0vFDQ17G2DmjfHlZ3YnIti/YrLqAxPT9P5bUULbdg2cap/DF4n3z1WD/kCklS5NortMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ampIWHcOGFM4fHCOAWB03efX+T0PwMqcBwnTGOW2kOk=;
 b=Mj+YPb1GC4FIyk3GwWVuj5BnQVQUI9XlQ7BobknUuF2GgpXhHsAg/qObh/B8q8+2fOlL9QHpMSElhG30Kj+Ir4s43bOo2X+SoMOfbmqiZIHfUL06T1sn1/xNSm7yTn4y6teFvWrdmCPKg3xOjGZn9PVDIImoPjUbkOHewhVbeB5XTE1DoFiKxUgMLjX61oZvQF+TIwWmCVuRF83Ko4suqWU5YJobM0NpjDB7J3zjn5WxKaI4Kt8p0/IQ3INIXuxPsYdp+RUhl9Hh51PE6rtnXbkBqxxlhfT2pt7YFJ10G0Dx9JwdbF5lcWOME05z/XvV3z6i/gfK2eVGneJKyO576g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ampIWHcOGFM4fHCOAWB03efX+T0PwMqcBwnTGOW2kOk=;
 b=DRItgj1V18DNkAl2/8aB7P8XNUX3F3sIQIgXwE7WYfPlXdMuK8keqFYVOEdex1PHw/L7KW435tXlNeVzzLT6c9Y+s0Cv3ny0S4QolQCfjtP3+IOqmVw+ecc/DIEmIx2XD1wWdNjmVaioIUSsK8qz13NcWN4CLdi9jx1K7EQaNzg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Thu, 2 Sep
 2021 14:03:27 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4457.024; Thu, 2 Sep 2021
 14:03:26 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     linux-kernel@vger.kernel.org, vijayendra.suman@oracle.com,
        mlombard@redhat.com, rppt@kernel.org, pjones@redhat.com
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iscsi_ibft: Fix isa_bus_to_virt not working under ARM
Date:   Thu,  2 Sep 2021 14:03:13 +0000
Message-Id: <20210902140313.1555053-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902140313.1555053-1-konrad.wilk@oracle.com>
References: <20210902140313.1555053-1-konrad.wilk@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (209.17.40.42) by SN6PR2101CA0001.namprd21.prod.outlook.com (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend Transport; Thu, 2 Sep 2021 14:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d842abab-498d-4efe-6514-08d96e1a6f0c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46866A0A7AB11D639DB4372089CE9@SJ0PR10MB4686.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUMw0yZgEVyE53v0EoPZH/x2Sr8l/BA7YWQVLm9p4zxCCOfwduaddnFJWSrqCpBEXJThI3Pzqbfpz0JETTGNkWZceRE6DHF/EdBlaSgBXeM9w4I4XFFyKjGH0zrwWwt5FnhmWKaTKj/oHbvB97vSSMqoS2ewRzompBJVbiTKsKsWSN8DcMOhcT2p3oCugUe1GQ5M27RoA3Mhdknib5BhCwBUZJcgVQroB3NA9L6MaV5+rSa+icaaqGZ+DBHpnoft+yTdW4UqGijrVR7a1dYF4HQSKcSvqbVaEUJKnK9I5eNYQA/5UEJg/1eBHa/lR/xxnsAuRUvKkQvJCn30ZpJZZ1ks6m214mr9wktSnjPqm+yiCiPOWz5D2t5uem2ytjm0CRL58ZTD3Q2JBVyMRlNsrRlH+04+KrZjm+SHwVjd1vQ0XubN5x0AMCaL2ZIVMlQBYKytuMv4rWBLxoyC7cqQm8VGNtDreiRxAQMhCAgJIu8tvn0zeNI3yq2O+bBGnv3Dp32eXXjxtkt+OtDLLJEDVsgb+d8+w0W1cB9Y9BiyNcg/OQZtMTBMmQcLc7TMqoC/INn9RW5bC7BPDS5iZxo5oMolJhM5GTJUQ9MqSEHqsuSyI6QPbjWISfU9yPTBFuu7vJb3oNPHZkENauMqRSnTA7brynY0QdkpK1pvKwSwM6h0yCz7fs4S1Evhv2/jLaebq3KqAz5lGpC907XTVWH1ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(376002)(366004)(66476007)(86362001)(66946007)(1076003)(5660300002)(38100700002)(2906002)(83380400001)(316002)(478600001)(4326008)(2616005)(956004)(54906003)(186003)(6506007)(52116002)(6666004)(66556008)(38350700002)(26005)(8676002)(6512007)(8936002)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hv2G8Y89OjO8bleYDovqop1fb1N29fKLjlNFupgqNdbw8e99Lu4qetWh/s3q?=
 =?us-ascii?Q?GHG3g06GfpQrmTlZ8h5Cli9oaJcg3HyI5YpQemgSFW/e+2eFepccUy9OdEKL?=
 =?us-ascii?Q?ekG0/q98zYd/Z60iqdT7oWFTTNQ+SY4Lk20NUU3V4YpaKDaKCCWolk5DHn5M?=
 =?us-ascii?Q?tp46hSZc5v89rA/K7oIJ2gtpvLAYlDQVE2K/DADNwO0XZFFdIWx/oFlZbt1k?=
 =?us-ascii?Q?audBDNII4qWkir/80BJPXt2FXT3GXamAbZgAFPoOwBZT0N7RJYIz3DTYJcoY?=
 =?us-ascii?Q?wuXmBqAhARih3g9Pk2cdm7X27yUIYJiYqd32jf1wsqxLIciyE6vM03JIWWlT?=
 =?us-ascii?Q?P4qfoVA/8sFruEHFN22NUwzQP0YM3eegyIkNx2qMhqNeh7LKbuJ3wusguWGT?=
 =?us-ascii?Q?SkW+Ln8RMRBGY3KIe+212p7YOTxQa5pQjSVkcQrybzDe+j8wn2VLHjxpizTv?=
 =?us-ascii?Q?pYXWVeerh+OmTTQnYiszQQmAaFTR29JUW6zEf7gybiLd8AuAD/JoatbN8NIl?=
 =?us-ascii?Q?b/Oq1B3I7Sqa9reblDk+PkC9N6C7HzA8Nd1aAIPdPNzoTfuAydrxC++8xjaS?=
 =?us-ascii?Q?h8BBE8x2BKOPcQ86oYwfCPRWAB1SRdw9UU80QK7e0ImRjULswWOUHeRBhq9j?=
 =?us-ascii?Q?D/TMWXNwZ2SWK+KB816pirHUAibzvh0qexlGOhxe1u1BEtuRn5A7TQyD8Z6k?=
 =?us-ascii?Q?pLHnn1ZqAp4l4W8lXNUQ5kpwwh+I2NgeX1IK1dYiZdCnZ5X6eDbAdxXgWoin?=
 =?us-ascii?Q?pCrkgtMvSVTQJFp1vSWl5D+RtM4lzjWZIJXFWJ847BC6AYMu9gftkJqGZpB3?=
 =?us-ascii?Q?h8WcfO6Idwpz4ukkEdraOSSDmXNsADJU7jXmqEgzatXKr6It2RW9ZSETByud?=
 =?us-ascii?Q?32KW9ScqcbsliKufoyfA5mrvnuTpMyrBWVl7qZopf+0HWGpw3t+COeR8WF3d?=
 =?us-ascii?Q?jGSwksusurI3j+m9Mt0snxg7OMZiSzDTYzlwUeCCHe7Ji755csZuax/RNn1H?=
 =?us-ascii?Q?KI9wLQfmo+nz7n8JMFch0D9IG0lYs5IoMQashaLpRGi2eeC15XdbgHjVESE/?=
 =?us-ascii?Q?p4VMPYm/zoMN18m8d24QeIG890k9XjCAMvKQOZvo9e3whwJYCgZUDBHRFFtE?=
 =?us-ascii?Q?VRUYKJqOMtWqIcdbDFUYVuf5mc6+SAWgDxk3WEWnDavkaFWP2JIrtRn0vibk?=
 =?us-ascii?Q?QH9Li23Ap/YPnHWmYwelHvWcA4HXy7ka3l6MhSwiIxOyai5clTMaPdIKQjrL?=
 =?us-ascii?Q?3dM2kRYCBOnDrvJv39w5CPCSlf7y0ZKEs3qNnsLAV41xEJKPAfXxldzVjUYy?=
 =?us-ascii?Q?4IPmYSHuoJpJ4tIWOrng7Pin?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d842abab-498d-4efe-6514-08d96e1a6f0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 14:03:26.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xbLZd8cI0Ud8jXn/HCP+JwAPICPmcuhYLU0LxqwoCqq00rknE+z3hoi0com4ymZjFhPo0nDWgocmeIg7vz7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4686
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020086
X-Proofpoint-GUID: Go150lm6YP-jdxwkt5zjpsXy-GrhL_bm
X-Proofpoint-ORIG-GUID: Go150lm6YP-jdxwkt5zjpsXy-GrhL_bm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isa_bus_to_virt is only needed under X86 and in fact the code
that sets the ibft_phys_addr is only compiled under X86.

As such lets just ifdef the code.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Vijayendra Suman <vijayendra.suman@oracle.com>
CC: Maurizio Lombardi <mlombard@redhat.com>
CC: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/firmware/iscsi_ibft.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 612a59e213df..7cde1a7a3ab1 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -86,7 +86,7 @@ MODULE_VERSION(IBFT_ISCSI_VERSION);
 
 static struct acpi_table_ibft *ibft_addr;
 
-#ifndef CONFIG_ISCSI_IBFT_FIND
+#ifdef CONFIG_ISCSI_IBFT_FIND
 phys_addr_t ibft_phys_addr;
 #endif
 
@@ -851,7 +851,21 @@ static void __init acpi_find_ibft_region(void)
 {
 }
 #endif
-
+#ifdef CONFIG_ISCSI_IBFT_FIND
+static int __init acpi_find_isa_region(void)
+{
+	if (ibft_phys_addr) {
+		ibft_addr = isa_bus_to_virt(ibft_phys_addr);
+		return 0;
+	}
+	return -ENODEV;
+}
+#else
+static int __init acpi_find_isa_region(void)
+{
+	return -ENODEV;
+}
+#endif
 /*
  * ibft_init() - creates sysfs tree entries for the iBFT data.
  */
@@ -864,9 +878,7 @@ static int __init ibft_init(void)
 	   is called before ACPI tables are parsed and it only does
 	   legacy finding.
 	*/
-	if (ibft_phys_addr)
-		ibft_addr = isa_bus_to_virt(ibft_phys_addr);
-	else
+	if (acpi_find_isa_region())
 		acpi_find_ibft_region();
 
 	if (ibft_addr) {
-- 
2.27.0

