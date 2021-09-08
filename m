Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878E24033C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhIHFaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:30:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23144 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhIHFaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:30:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1884EESQ018110;
        Wed, 8 Sep 2021 05:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=KFYSULSSYlqkgqcx3VbxOMnQM6W16J1XZJX4Y7H3L9w=;
 b=wokuHobxbaWB2wCyIXfGzKr3wnC9erKeGUu3+hFQM5ybSKWPufEDH0SS+ePnMJsn4AsS
 IjXRTNndcqgKb74nmZ9dfLmWefMC3Ey4iAAE6VeySpY4bUB9oazTl7s0fUkBrs/zaGbZ
 f0ZC1bg+aRCvP1czGOSk3KQD0+Xa/Z4Sew/C6EqbxMfL/iF42G6G3YZEI0iW2d2nojxm
 Ms2xh2Icr4PAIgVK9upFg/ITe2oMdKUSZsmx7JO/BpopN9YgNZGX/EzrhAEwvcHWjlS4
 NdgbttTKaIbaecgd30rnkW5DEXyOIWO0Kaw76T6M4T36EHiosLKqfZZsvCYfOSCVER1R uQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=KFYSULSSYlqkgqcx3VbxOMnQM6W16J1XZJX4Y7H3L9w=;
 b=PBsfA4m8ArDzjgAHKHWNQIYrUQekSUbdfoOiWAlNy3AFBp7vRN1kcktkrUzm7TMUzrGL
 9ZMN28yHn2LUkqCnHjB1r3mB/wpKQI403etSzJ8hsYk84QRk4Xh7PUmRIhOy/a0GBW4X
 +m7QBQeDvAkpZAD1zH2nJoIgmsqlGGaDGmLJmOYCpMTwSfkTZqJ0WpHuv0WFiJG6Sl84
 6elJPXt9les2ldEVuQk4WLU4QwgwJ4+8O1eg7jyvKRLwn8sgv/kpPJQ0PJOJ7Sby2BPU
 tiqJ9/TgZzpqj5XVcDPoBo1vnJy/Za2eN0QTzPfgwaV3+AVoCLx5lR3YZQBA/wFjbol6 Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs19cd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 05:29:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1885Ko9G086908;
        Wed, 8 Sep 2021 05:29:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by userp3030.oracle.com with ESMTP id 3axcq0t4ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 05:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3imtzurAOgCi81f4Lh3FC7OwsK2F0VfgK3/bn0969JzCkk8utb/hlNU0bGCQLDOmClzhwM7BbgR8ug4/jsoGRrusnyxs+bI4/rVZ2bbWyk/N+mV7Zltxjc80wJN4m5zeTDIxA5K9Z+ZmXBqAdfNCQ9+VeFgqSYvnG2Zu/f9bcOLVAfjc9Sh2EZS2bvsn9FzU1RPhy8tIB2ITuNtjQy1PknD5dqKsLQgK1Ot3YxdcGAVVa+bX+4bzngpTDCqiqZV0tYj6Dc4F8yXIMFtGlH9roOo9RwgqLUf2pK5lJXGFA8FryPieSKoewOY+lOuk33tTNquen7gklq5sxVoHqcPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KFYSULSSYlqkgqcx3VbxOMnQM6W16J1XZJX4Y7H3L9w=;
 b=JJ7XAAeSZceiMHx0IlptJa+Slpah8KZ/DEzL3JPR78RTJWc4+XddRWV4qTuCgERmV2P4dFpKIIn/rA0e8+xMQlHSiyxaVYRGJDhU94FuRiBV+8TNL4eNAmTggeYCHIigA95hVHdnErIDQ1ymRu8WhK0JVUJbO+u9grAYY2FE2fgNWgH+31XznKCGPraDP0fbbgzvSBLF3u37yYu39Q76+4DnAmswNJI+U9T4of9VeA4XhBnbYWYdZOR7tfjJJVzGpf5HYKXzbh0pBnIMj23P2U3CwK5tRw2+jQawIsfeFd1kGK8TpUSHcbqyzn+4ElIpd2CX/Pgb6vjG5USF4x2JfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFYSULSSYlqkgqcx3VbxOMnQM6W16J1XZJX4Y7H3L9w=;
 b=LRCBF54pkbmy9CRaH8JRhxquAX8+8UgZxTvASfRdaiB3z84yCn0KtAiDotVVNs16EoV/5qidRYdwxIC3vTmm7sjwE++H/a1/XSfWmmOUixIkr39dHueuVinEZ3s8/CZisxe9K5+lcwP7bmJfSfks2HpcjX+PeHrRWtKG5bTJXa4=
Authentication-Results: linux.ie; dkim=none (message not signed)
 header.d=none;linux.ie; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 05:29:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 05:29:01 +0000
Date:   Wed, 8 Sep 2021 08:28:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] agp: fix a couple integer overflows in agp_allocate_memory()
Message-ID: <20210908052855.GA28725@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO3P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO3P265CA0014.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bb::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 05:28:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dadc074-1950-4073-a974-08d972899093
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB16640CAD2B3468714E49FA7E8ED49@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T91HTLIfPBXlOCzL1ttLOtbuk2tCf29M5fKYrvKRWZtSXDgXfeFCKjsTJyeh5pzSB9GHJnerOgHqQikcbJNqJ+4c+JrUdl8EXr6ZXwdn9K8y+rQNM+rFSIyojFOZG44wyaA9s9NLhdyGQiqZTgV9yzs3Q+Yow11zRVUQPlIzEI0cFcT4mciznkiQiO4mI0h0+d2RGkk8nMcCzPCeCNi+5lCc6QTXHAFVX+d/393ZYyQkXAwXwpsqRCTAhJybwlSjZd7QcNZZ3tTXqQdomzpxTV9+aftkKwBRoIZjoIvtIdaMMZHDSFCbuxXtxBNJAZJOUQMGj6Dq3+pIID1gEAnWPzk45XVTXyruIbWHms76cywfnD5FIpwKkf9QOzpbS85LnVaksEfiHS2t+Xv+x+O6WKkL5UCCWklccKaW9oUDwkPJwqGK3vUIoiM2EwXURLSQnqIsSBCZDzpj+Ro9GzUvxlHk0q2fp8SsT30DgaW5psq19lTUgp6ux+HOs6itT3sVPRsI/czi2fwTGvvev2I0mxibc7IV9uvbl8/3VPgN0DhRKDXs+l5+gmIWpHINEdLEUjFneQVUX+7WgE9A10aDyq4Z9dOKzE1fRfgK6QFhZ11jSLfrDGXj+oit8ebjYizoXg+XL4hQAu+HayS+PiBiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(33716001)(6666004)(66946007)(66476007)(66556008)(1076003)(478600001)(38100700002)(86362001)(4326008)(186003)(8676002)(9576002)(6916009)(83380400001)(6496006)(52116002)(8936002)(5660300002)(33656002)(44832011)(55016002)(2906002)(316002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/rSGNkj8X1f48x9lNPbIg7p3BcIkc1J/ZC1QDUJO7nuzWbaDEGd/slL9vr+?=
 =?us-ascii?Q?YbkjeCuWhcDVfepoV6uwFFV+GkEZtOiYsqxzMI+36DNz/hak/c8WhHPAvxHX?=
 =?us-ascii?Q?tDA0c1XbWr7075YWhB+SjOgysgOEEP5mdFjBkzzkZM7w6eiQWF5bmFK9SOa+?=
 =?us-ascii?Q?6XGS/THHoK1iMpiiMfoNkBr7w1v51Czk81uXsC3OL++G/PLXqSdKbeODRUSS?=
 =?us-ascii?Q?w3vJgp0wCebwly2x0omKA/xLJfEzi8BHv1LZ7JF74hn9U02qzt0OZ4B5o40N?=
 =?us-ascii?Q?+BMKbYH9lXC+5DG6ENDgBJVsDqRIV6CyoGg+QsakbyyiGSYshtVldWG4/1uc?=
 =?us-ascii?Q?wNsZ/SMNasROo9fz46j3LjWvp/8xThUbMr0SuXJjnJWTvnbbYyD8xFZWUA5k?=
 =?us-ascii?Q?j9QGHdqMQkIrm6OEyb9XYXRvZZi40fjekCYACAKlV6BeFm/r8SsOAM/+9V3g?=
 =?us-ascii?Q?qfulorzrewo+VyFtZ4Ur9mS79PrrwmUne6ItYGrtX3Y9FxLeoJ3iipWIGN7w?=
 =?us-ascii?Q?bRXqy9XnigVizGEo5ZxjJ+ZH6aiAZGFVmRKWG1ZOyy55+LZrGPA6hA7CSPbc?=
 =?us-ascii?Q?HnmtSxDmYzy5iS5qbAA41pnuLxfBpA4DSTX+0099/mi6syyDV3eYeIXfowCl?=
 =?us-ascii?Q?yLhvSmjUaP09vaFHNpD8Zf3zbwajyO/N5t7BrIoeLjXKHM0NkgiQ/CX3IUp5?=
 =?us-ascii?Q?ttqkj9hJKJ3tz22hxUIPIdUcITnl8M2gemSCpH1AEfTW8PgGMAxSMqfoeo2B?=
 =?us-ascii?Q?Aa6AGSpS1hvOZNmmbiyL1e+tKVz4pwUJzwnKtsgX5vNOSD2/xeGMQD84ATYy?=
 =?us-ascii?Q?IR32i1ubfFioFI+xU4S23teCfQCj0XwHgYRFfZv6HKP8Kf7g1YEqPVss/yjL?=
 =?us-ascii?Q?oKxRmjLAwO0c3wado4coxrzXYo4Z6REOU46yXudhH9T29wG2OnAMcQbfztJL?=
 =?us-ascii?Q?dw8wQRj9e1EDThpRDExeezI6jbCjjcHhanyXbytOuvkKmX/orFArkGuDkHmq?=
 =?us-ascii?Q?maw+edcpfKNNsIe93mu3qcmdM4xe2mNjKGKGTQysqkUEYPUuOIeIOrbmhHa3?=
 =?us-ascii?Q?bbATz/Qo+AGo5Ak1SpdsCzGYTSMBxzsJRlxzjxrveQW67aAjEB8q4PByaYur?=
 =?us-ascii?Q?D3gYBpu8+iheziddciVkGWZYDLCkjImI9C2Eg7NCcG5rx5111aNS5wHqezfr?=
 =?us-ascii?Q?YhAsyri9uknd5D7Km1m2C/62NhiommvWd+OWkz6a7KhH11of4LIQXUm+PjDI?=
 =?us-ascii?Q?sOkE7LSNKZ0vDZ3zL9liy09sNox5mcKtl5yuvqkmHBJDuS2auP10Zf5aN4Iv?=
 =?us-ascii?Q?8BVvaIY4uOeheLq6m0BYLeO5li/N2O2opRzq5JZ8/NHdK5d2nKDvVj+z5SKE?=
 =?us-ascii?Q?A/GhPas=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dadc074-1950-4073-a974-08d972899093
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 05:29:01.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYTNdld64OsMKiW21qyoiKRcLNU/BnHDGnos/YWuUG+RKxlk7SvEODsNvyBOFmsFFbaD1aPvHTj4EVTXSAMhBHH4jg7U4mlO8VmJ0Hxr6vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080034
X-Proofpoint-ORIG-GUID: aJkfQ81uMiVjn4-05zln3weaLaEEHYkV
X-Proofpoint-GUID: aJkfQ81uMiVjn4-05zln3weaLaEEHYkV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "page_count" variable comes from the user in agpioc_allocate_wrap().
The agp_allocate_memory() function has one integer overflow check
already but there are a couple other ways that this can overflow and
we need to check for that as well.

I used INT_MAX as the limit because "scratch_pages" is type int and
because kvmalloc() function will WARN() now if you try to allocate
more than INT_MAX.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/char/agp/generic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 3ffbb1c80c5c..59aa4f61c66f 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -127,6 +127,9 @@ struct agp_memory *agp_create_memory(int scratch_pages)
 {
 	struct agp_memory *new;
 
+	if (scratch_pages > INT_MAX / PAGE_SIZE)
+		return NULL;
+
 	new = kzalloc(sizeof(struct agp_memory), GFP_KERNEL);
 	if (new == NULL)
 		return NULL;
@@ -228,7 +231,8 @@ struct agp_memory *agp_allocate_memory(struct agp_bridge_data *bridge,
 
 	cur_memory = atomic_read(&bridge->current_memory_agp);
 	if ((cur_memory + page_count > bridge->max_memory_agp) ||
-	    (cur_memory + page_count < page_count))
+	    (cur_memory + page_count < page_count) ||
+	    (page_count > INT_MAX - ENTRIES_PER_PAGE - 1))
 		return NULL;
 
 	if (type >= AGP_USER_TYPES) {
-- 
2.20.1

