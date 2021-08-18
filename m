Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F33F0925
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhHRQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:32:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60834 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhHRQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:32:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IGHvWl030871;
        Wed, 18 Aug 2021 16:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=l/uNM1bOSxuNhSJpKggnE7ZCT2UogBAjI+ZxKY3OFa0=;
 b=czG2gTV/VwjiVWsyAgYPjaKdJW4ajdCTRXTJXbDwFZHupRrGhFqLH3NmtBl3qQKgF1tf
 eyb0C3wTeq90wreXegdk6maaF4/VBL4kBO/HFIXR5ZrONiR2lNuDFrq8yN2ni3xehu0H
 QRtRN4pajuXGs6vez7tBBeoI8r3HSuST4yD5quMD/9exqFPUWebSBJ2yYaw/m7TJSTgz
 qcXiY8tJr6nUzFtcb4Agei7uxywN2rxpZtof88lYyeV5ddP6QQUuSnIEapvnuUpGOwCT
 DkwjYad/RqH8wcNDx164pRyPmGeIXaiFFYgapqb7RSGcscO2QjDiMtZ7vNAjH5qfKamd lw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=l/uNM1bOSxuNhSJpKggnE7ZCT2UogBAjI+ZxKY3OFa0=;
 b=EBBX4HMRyadvIJ0yDmv71Iq23ZmaCkWL3syY24K3oyT+ielGv4ZJeoxANUg6wEoAjrCE
 1lRAQbbhUipcYXE5L6Nw7V2xvyt8FWPAyQnpL8Wxp8K9JYMD26fa13HZ4c0+vS5Zuyk6
 fCVyI58UCl1P+GEUf883ENqPlMSxh4vpCdXcQip00/r/ZRwxiEGCc2auDXhZwGbakfeH
 EBXSNL6VYwl07gppZFI/q58bzOoVWqT0YPvBwcMxr+ngvre2bJhj4N7lExZoAoj5703+
 Qhsw94qdHMw8oshwX+8F78QvXx6SQ2/AIu3h6AjqWh/1D8U3HvaysmVcjCB2JJqGGmxS Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7db78m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 16:31:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17IGL6q0086584;
        Wed, 18 Aug 2021 16:31:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3ae2y2gwdr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 16:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhJYtvV33sDhzrgaftiA9WDHEXiyHl5nEYQgXvzKwsRJxqibo5I4EDSl3I7nRAAlWU1LEB9C3QLMECWlcFHnzCxpzMSFspzJfhnSkAhokcXaOpGhj7rf6in8lqQ0gARYaOgcfZYtnOV4EEr0/r+cd/5/63Fb81mDRWBhgYr2/6PlxDwWFTfjz1+uyICXG83odXAHLDrUB8I2WuLCXCHdZlIuE21CsX41/SligtGjxyYW5J4DvmGlBULsE/0cGR8BY5MjG7M0xIv1EOoWGgpULAgGyDpKdcyJg6ovFumckufFMONtli1QkeMSUeymxbhaK98RyhDiq/sHSCFg0wKLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/uNM1bOSxuNhSJpKggnE7ZCT2UogBAjI+ZxKY3OFa0=;
 b=dzsNxZLeHxiUV0SMkUsS04BKGSY0BmYO0C6zA4THIe0NTtLsmzbThnS3bk6qHexlCce1IwMnFaBsvf2kXBbPSmKTuAAnzvxTQu40hAJkKAjPJWkgZeCM5wmCGHaTBt4J3lEofEhjUtYCn/1/KzSZcURc5JmNWspcTYf0fJqeZneCRY+vMEe34C5BmC8OsXNXNmHZW272EM/BAJzXqtFAf+lHGnc5xj8lGtM1fGCyealKwh0aDZLErpT4tUO76DRSE12Rm9Xnqr48p2swsQbiDqKJYIMtoxoGSUAmtKxMNfFCciS81V5LH+DJy76Gtp7+OVwh6fMkPO7rzb4pxTcUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/uNM1bOSxuNhSJpKggnE7ZCT2UogBAjI+ZxKY3OFa0=;
 b=IWtQAOUC6oV9yJedhqbBLuMVJ5amuLMgysn7sRTzF3oqTo+UqYhmD3NgGOQwzpVlSjwd0FSvmJEenhvtOt4NeINZZLt9jF5HeancQl5JUqjs5daHyBxli6qPh17/bZ4aR1suS4qCXDNxgPYL5tYGMXiSHXAV5TP6kWQbSVvqLXg=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1854.namprd10.prod.outlook.com
 (2603:10b6:300:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 16:31:18 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 16:31:18 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        mihai.carabas@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] misc/pvpanic: fix set driver data
Date:   Wed, 18 Aug 2021 18:38:30 +0300
Message-Id: <1629301110-2714-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629301110-2714-1-git-send-email-mihai.carabas@oracle.com>
References: <1629301110-2714-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihai.localdomain (138.3.201.25) by BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 16:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f657d7-b05b-4192-96fc-08d962659b19
X-MS-TrafficTypeDiagnostic: MWHPR10MB1854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18544C742A492FD36A98D74F88FF9@MWHPR10MB1854.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xg3Uspf9EV0VehEJRKTl/XhNh6GmrYCQZmC8C9QQvwtQN8g8tnEsYWyc3zuURDuCDdDcjEhiTYLG0lCpfwaGlvWf/+Uscws5qR+2xnHz6SZZVB0VR00nLi1LVYn4JRFSNrvyFhwdzVon5KlrrgfqwA4BxA7N6LKbnA55yEnhwtmjXe1/jkgGQYE1xJh82CnzFxbPoNhqNQjjfvir/AtuTSvc8rZj9CFTlZipNrymzxN/KbKb44HAjLeJLYiE42oFy0Suw8gaVjL/+m9aa7ddtEcbMIJOj6PoscKLZa0rCnjqi8zo/bG2mZ9LSboHVzQSG0mMcThaiak3/AV/lRdO6MUxG1e0tSr6Un0b9PW2789Eu6voECa4DwAE9y0BdPOLffffZ2Rh6cBNTFReUTlmLb7dMDGFmCXozbqakCFG9kgATFsKir412oGepVO76osuMTuBqowwcUl0IAbI2F1JfUIdlQMKPiCyYenW1IN3E9hbMyfReD9UZErdGjZEmzPKTNaxKCazdElIw7noQ24bpte0r1oszR/C1uozR9dnVgx+ug0xKJEDZ7FBgCsN/6wS39PP4Eru0GtPwDTtxt9RXYYzv8ie7+2aJnYVSO5IWV+/La2adoM1ECf3wQlbcnn5ZETBmppS7iRj4N0sROT1jX8zEWk7Lfn3oQ7Zf0h+mpC/zgDdn/kqJoeITiHAQ6Pcc1V8zMe/cqE8FzG2kY8LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(6486002)(44832011)(6666004)(36756003)(316002)(186003)(38100700002)(38350700002)(26005)(86362001)(8676002)(8936002)(52116002)(5660300002)(6512007)(6506007)(2906002)(956004)(66476007)(478600001)(66556008)(66946007)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJylWWQDW0ZTVM9+IkhrVHlBFxLHTeOQtQTBtUMZ9H+15yZzP0t3MfT5LIwh?=
 =?us-ascii?Q?tzAV0CUBdm99REgBoH1g2s+fayrt5cHp7ub0kkCRzQMvtQx6l9G9n8g+KR6l?=
 =?us-ascii?Q?wr56XP7Zh8Vzw974pPFCuYqfaTPsSjrq3+ivIos8AqariQGwa4DoVXtBQFDm?=
 =?us-ascii?Q?BOrugFR166/cRdni8+tNd+m7kgVVQbhVvLCawPQYeKs+Dr6d/b1uq5M7KphD?=
 =?us-ascii?Q?8w2qkXdMG3mP+CthdMRxxbW+mHpAi4/Ei/w3bQ6C8MWn8O74h+vZNvV08GEo?=
 =?us-ascii?Q?2hXj/fJOws4RNSVyMw2Z1a4sUlCOHNvBTmP82Q/RCuzos8XHQBuDj1Z7e/SN?=
 =?us-ascii?Q?8ymuSlMD1/O4oxvbR4tfLcB2f/WjqspJx/tUJn5KG+wOocGQ+jzZCQgJDXPk?=
 =?us-ascii?Q?Lqa+M7/s0Pq2aXgPxZwMuOqKPsNUwcgvnOHw9rRcVP1lOm3QgirsxcgnJsNx?=
 =?us-ascii?Q?hU1PX/4Sb6LnyAUSXKXdUy3rT0h6lMjhfJwUU31IbETXeYncBt5jzkYZR8a5?=
 =?us-ascii?Q?yjg2wOZbcvaH4TX3dQU7IuwRLDNauKgQSJlybADQRxYYdtNvqYbGeN2DxGe2?=
 =?us-ascii?Q?DRpDpskXA+xQ5It6coJD5bsgRK6uh07XiRdxhAGNyC4gvjU7p3ATc6wdwFNk?=
 =?us-ascii?Q?QhvZlLVN3WXUY0njXlofLTGaMzUOLOeMhPp/SHgoUyftVc42arMqSi9jwi0L?=
 =?us-ascii?Q?0KGBK4JX2IpPxOkl0+V09woRDKmgAicGy/xWuEvejIk0z/GZpiCe/v1v7OIx?=
 =?us-ascii?Q?omiO5GepRtOe3IZgXGSaNpjTIsMYvnxgcgk79NLD+YASzAKnHJ8HkBPfoZGw?=
 =?us-ascii?Q?TnC6Cghewuvxu8AmcqcvQ3u23xIp+OKUvaZTJ1D8S/sIvj7D3u5GrkqUl+4D?=
 =?us-ascii?Q?15ZsjPuVWoLG6NjoJ/pZri5qf0fKblXQIn1J/4u6w3uyQpuZINwy/OyZNFfh?=
 =?us-ascii?Q?YOnYzC/EheSuyU/CpuCNXaOsLBPulSmcQUrflkHJo+SauT5JqHwYP25+1j2F?=
 =?us-ascii?Q?7yw23ZAjZBfiJrwo9lTDcs0tIJyqIhQbdFhKzczHp91OiOkmeS5v1uF7HDdm?=
 =?us-ascii?Q?ldFDW8Ho6IPKugbDs62Ku0LrwPIhoM9HY755AfQsF4jgXCizdmFJTxyqpywX?=
 =?us-ascii?Q?RFPqdauew2XhooMDTFXzpkZ/pVYqS5KccmUJeiS27V3Hv0+7Yn/YdzPCBOQl?=
 =?us-ascii?Q?77YyolGuI9FneDf40ZxmFeNO1gstzGR/yu4Ci0y7apJnoQDNJivlM3fGQL1H?=
 =?us-ascii?Q?pBOFHZducocamHEXLoJhWrzW/7QsxR3rtBcxsDvivGK4BaNyvJj8zfBNDTTI?=
 =?us-ascii?Q?bxYl79mxTIb4Q7iBGEdXkSbB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f657d7-b05b-4192-96fc-08d962659b19
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 16:31:18.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVMZwvwgL/tOBdbFuW0NLpb8YlAtb5D1ZoBOSA69Ur2VjSG0bhiD8PetZ6VKuUUqxaeD0Kc7Jg6vzqnUNDgNKR2rMTQd5QOmYX6c9AIjlh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1854
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180103
X-Proofpoint-GUID: IGJq_YUhMpY9AIelf1jFE1oh5Oe2E1im
X-Proofpoint-ORIG-GUID: IGJq_YUhMpY9AIelf1jFE1oh5Oe2E1im
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add again dev_set_drvdata in order for dev_get_drvdata to not return NULL.

Fixes: 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 2 ++
 drivers/misc/pvpanic/pvpanic-pci.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index be40160..874f94e 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -104,6 +104,8 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	pi->capability &= ioread8(base);
 	pi->events = pi->capability;
 
+	dev_set_drvdata(dev, pi);
+
 	return devm_pvpanic_probe(dev, pi);
 }
 
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index a43c401..2a26db8 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -96,6 +96,8 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
 	pi->capability &= ioread8(base);
 	pi->events = pi->capability;
 
+	dev_set_drvdata(dev, pi);
+
 	return devm_pvpanic_probe(&pdev->dev, pi);
 }
 
-- 
1.8.3.1

