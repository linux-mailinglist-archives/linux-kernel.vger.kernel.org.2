Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2D39C08A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFDTmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:42:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36380 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhFDTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:42:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154JeCRm116407;
        Fri, 4 Jun 2021 19:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=EikyZZFc7oVASGhZOIDYITWVlhHG6BoML2KIfhHugFs=;
 b=eAhVdmG03U8dovi+w3ZuTtFGWc1iQfYt34syAAnyRfYSwwCFchc2uc+cehpSwP68r2mY
 7SSWHI0gNBr+LPyA4W3W7b7urklntBQovg9X+KpaAGFc5bW0hE5/1fofIMTWwl0iepSW
 OElnS4LB+izbvWOHxavbOAnEbLjU9XfLGFeaRgzUa8jjY2LEfNS22yK7ATcIrLnudsAG
 oXi+IurhrNUSvB73KFqcJs7DXk4p863ytUiyv8jRLCtuuKgK+CwltxkpZPhmwwmSG+bS
 eGL9eC2Fq8ZhAMY9Q2gkcI8dUz3AMobDSdrUZXT3/KDNvOtn7XHCU9jfQ1kka3GAW+wh 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38ub4cxsrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 19:40:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154Je8XM075026;
        Fri, 4 Jun 2021 19:40:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 38uar0gv88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 19:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuhP6yGckKH4m4iUhbz64Pnov24Hsp4jA3+d1Dw1S46lSt+Y2x9ZzaC6asiXLNhx9UMr2SNi8SX47/WioygTbUjIC3QIkp2pOdRbKdEQG9JDGkMqBOHPmixvVqU/6nnDvQfb5kVYX7Chepx/gWOvMpvjp7iTM/UGNElS1Faev94lejnepxyYCLqiyYokysx3+X0hmc2c/IpiT5Qc5XxEgYz0Mc/usGQ0tCfu5ox08IMMDzOEXV6sOOBaTbSMzhEypCMAANBMWrcWGA9SQ+6UvKr8h4c65SzdELzLh8N2zD9AqqaseaNAQUDhB5M3JCCHj0Xj2FN/o94avuHdUNiJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EikyZZFc7oVASGhZOIDYITWVlhHG6BoML2KIfhHugFs=;
 b=WYKViSkeyz/Zgl0QTBCWu2gCIHqXZfiHFSvcbuhRc3DiJs3+OS2KwgWhai9cCSVdcIUXAIWvOdbz5uUnC8a/V39t/dgQiOFMhowK+UrMTSiSpDNnAW79nAJDQXzGwjTRyvNupahevPJXKGaQ8Sr2DpMnIFX/PSDBNDg6vxstpNlwDZkCbRzgp4S+ce+Kx3Eq2BiZUQObFtc1D+nXx3RIW0APF6p4qnR0P2NgZpWbgQHeMBCbRBsTGC+/6XXR5LTTXGSlkZSBrZxc9BgtwNEBsYxAvDRfaw4CrytfR6hdxUXMWUk4DdzVWSEczR1Qyr0OfUs8h1ZaRz8bXD0+gA2Oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EikyZZFc7oVASGhZOIDYITWVlhHG6BoML2KIfhHugFs=;
 b=vnLd7jDUapd0FVq1eMamjzU+/ZDx2yhSzXb7XPy0ArgeFgFtLwjrBLr5B4bgXW38Ia3l2ZJcRbo7sTcJdU0ooprvVdBAqjGx0UQD3QqXCkq1PvK5r0owogVhfLpSAXmxHqlbBJdX5wO3tioj5hK7Nb1i96kKdaiFjtiK5aR9JmI=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM5PR10MB2009.namprd10.prod.outlook.com (2603:10b6:3:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Fri, 4 Jun
 2021 19:40:17 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::b8b4:5900:668b:c9c2]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::b8b4:5900:668b:c9c2%5]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 19:40:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/nommu: unexport do_munmap()
Thread-Topic: [PATCH] mm/nommu: unexport do_munmap()
Thread-Index: AQHXWXlxNKpqM94mJkGUHZBaSOpXaw==
Date:   Fri, 4 Jun 2021 19:40:16 +0000
Message-ID: <20210604194002.648037-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf31199a-3e20-4f48-a555-08d927909416
x-ms-traffictypediagnostic: DM5PR10MB2009:
x-microsoft-antispam-prvs: <DM5PR10MB2009AA9A4F69A9487A957454FD3B9@DM5PR10MB2009.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qtZ/dDOcnjECZ3HxVKLkHIFFQof4TTpA6+TsotIQmm7dtVGcSQnU1LUViE9dM9e9ZjjJ16e/Ndd6oOqD9Ta7bd70dXrPUP/QO5OYK8tZnAtq3KEMGq7n/xsQsfV7BuQR1ahVmQ+8qd6KEPy9t+fzzw23VJbG8gSqSFCnKLBAMGEknMaJwuGO/VT6UbEL/x6w2c2ndGZ6K7UhH3KGB1d+SmzL9DIJ5kY3G166BDMj5yWoMyrBs520vSix3pIJZnYGHHHqh/t4Jqjuwb5e2rkepgHFX3xyQap4edhA3XKn3pvJQf9ZMyPz3m8YVn0qRZCiPUyPBU2PcaWGtTlMcHyhtA+SpB2GCFunY5Cum92ZCeabod/sQPN6Wg2lajYcJtgojT2ELnEx2JcBumQGWtDlypb97OGvrXH7W+WnDCkJi7OqERQnh2utszAcnyYp0AQ1mf/IWRwIY3OZoa7fYW/pxx9Ip6lf/JmRCNvHFWyhj47LTfSJDBPjBFBTILbMgHczKxYInmjKIAVjR4+H7U0nxTQvGi7sZV4gGqYD0X/HbCKSiWKJhQ0dn+AVBpNZk2hng6HkyHwXZCvlIafNBkFa1MquDusRXTpZSuwo3OwNWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(66446008)(316002)(6506007)(66556008)(91956017)(64756008)(66946007)(66476007)(44832011)(2616005)(76116006)(26005)(186003)(5660300002)(4744005)(1076003)(478600001)(110136005)(8676002)(122000001)(2906002)(6486002)(8936002)(86362001)(38100700002)(71200400001)(6512007)(36756003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?s/tz1iogt12KG90qFwm5r5pIuHgCxpv2P9T0XPwKmXSK/+3aeHqxkNqf0v?=
 =?iso-8859-1?Q?l+k7nhHhNm5vxylXZDwckGo2veuYRbwNb+QIo6Zix8I9UW8iqdFiMxCYxQ?=
 =?iso-8859-1?Q?DWw/4TJrmBCwO0dwZglT+4Cd6HveqbkhnNkklw0c4qWwcqxD5pEVN+1ISn?=
 =?iso-8859-1?Q?hbqlfvpKLeST8NVYBAz3plCYoTB0TFhvQ1hZO3CzBwg9PSN97qsIoHudlp?=
 =?iso-8859-1?Q?POQiTAWXd1i5kW9H8gtIf30H6ApzVu9Ybv3/0+xK+vvD9/qZBEdmimfhK4?=
 =?iso-8859-1?Q?5TCkIYxRjAnCDjmkJVRv2bydkhfR2CMZk+IlMHlbZSkdzfG9frZm1HPiyI?=
 =?iso-8859-1?Q?5987rJ5PMWx3Mz1IOu07/ywtwehnb1K3GJMR0zPz/sssZGEzqimEQqeeKk?=
 =?iso-8859-1?Q?3+GKLLVWBHxihKowQYDkahuwL/OcJdXoxSsUYtds9aGJH//jDQ6KZhYkCe?=
 =?iso-8859-1?Q?0ZMOkEy5puKcRp9DGwRLhyc5cSkukQFJ3B0bqyAwZNubfEEFn+f/k1sWNK?=
 =?iso-8859-1?Q?tgr6GEWzLOskYFuFGpxTMIVT8i1XW+IsFoAXFBUvtDFLCGtLQNW8Q+5vSs?=
 =?iso-8859-1?Q?BQfm4oKJB5BGXjXSuC7bBH4OrUuWOpo+7ftFbSU9TxELwCEzIA2GIWuI6q?=
 =?iso-8859-1?Q?onI2wKkwK9VrZY8Vqn74Vh7sSEVmrlQujYlOBx20O9XV9AZ6p+OYq0nUtx?=
 =?iso-8859-1?Q?KEWzRygHVjvsznfvEQLvIcYcSZViWUeQvt0DQ1dmS9Blse/XYb+wFELOVf?=
 =?iso-8859-1?Q?tNaEJhu4HPSgwQbJXbfhWmkWoEK3YiD9PR7NdnrPqr316OdzXn9is2/rGv?=
 =?iso-8859-1?Q?71npTb4SfjJlPGNbw+mTHw2RuTxp7kyUNMhKuYbJS0qlH1vZMHEJBjoZR6?=
 =?iso-8859-1?Q?IbWTDVXwzYbIsvmP0GqPALB74Pp7KUF/tXa20QgpsozLfFXdFGs/0lL9zX?=
 =?iso-8859-1?Q?TnBGaitM9LSAL3N0vAZQIprgqHTGdKNhPL5ijj422uAf1yIQ/a1LNHjRMx?=
 =?iso-8859-1?Q?vEi1VTyJr/BxWbD22WovowA3WmO9k53HTn3QOyM3aoC5+oSuV5ATUO6GAh?=
 =?iso-8859-1?Q?sr3abwcGbupGBPLAtOZ5FxNW3Z3qNe35VAnhPWclejdpPEJyaFyEnD3IU5?=
 =?iso-8859-1?Q?35p3pUjeavMh+H+CDmEaqARn3KHQJDCyqdLYgFP+qn0Rg11QZSC0ARgYvA?=
 =?iso-8859-1?Q?+Z9co6IW0j6bjaNyUfZ5n1MPJG2FrUafebke/xFpxIhV4SNViL2MMJ4wei?=
 =?iso-8859-1?Q?f4T/llIBwm7hNF8mscFZNBuA/J4ObDbWwc91VIgrtpxx4FxBP35gq21e9d?=
 =?iso-8859-1?Q?M+Mn8D3M5J6QhK94WpPUKATO2Zp78+cH5Eeb2DITOKQpblm0HwYYQWImpT?=
 =?iso-8859-1?Q?MGSDoSbIhX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf31199a-3e20-4f48-a555-08d927909416
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 19:40:16.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8xW1PfkpkFlUmgLtLVM8xoXkmu0qqtgjm/s1PSjza7qZYhiNrVWK20iUSk17/R48DAHVDnuPP1UzHCkvQE1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2009
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040138
X-Proofpoint-GUID: jCcvM22d7KX9004JgrOMu6r4QOAXddKT
X-Proofpoint-ORIG-GUID: jCcvM22d7KX9004JgrOMu6r4QOAXddKT
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_munmap() does not take the mmap_write_lock().  vm_munmap() should be
used instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/nommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 0997ca38c2bd..3a93d4054810 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1501,7 +1501,6 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	delete_vma(mm, vma);
 	return 0;
 }
-EXPORT_SYMBOL(do_munmap);
=20
 int vm_munmap(unsigned long addr, size_t len)
 {
--=20
2.30.2
