Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC241B25E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbhI1Oxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:53:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241152AbhI1Oxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:53:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SETu7q014357;
        Tue, 28 Sep 2021 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9cKgsHe0XV/iAH3qH8WDT5gFGSH+IhQxodqelKx/Ymc=;
 b=WNrEI51SqTm7saoAHPlxt6bEsRnjk6WWAkxzwX69uilC7bPXAlR7nr33qNJMZLKLaOTW
 1ZIwRl/pNPU/s8PCBXsAvfbzygi9O12pdCsfbdtGCD5tQ3i6RjNKj0TFXhf08Gh8a86W
 mEqQEsUtGO6XZ7PglgSX6CimzKUSq1C9fq4r3HPkrnUARQUhLMbqjgiYw23ZJf9g9Wac
 Hky9IG1WP07D3yPA7kE+UIFyAB5AlNYEgKqDyZdAk7oenJZJseCTz/kFrpHX/KlgOXfB
 vidw5YgNyaS+bppRlZo955eywhGhHCcCIEqHb/eG1j7oj9tyPCEAmP+HDxYhomhccWXq SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbhvbyg8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 14:51:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18SEo77g134404;
        Tue, 28 Sep 2021 14:51:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3020.oracle.com with ESMTP id 3bc3ccpety-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 14:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDwKr06rdbl8t0wLIAT6ytItOipbHgh7+eU1ACM9vHNhtMoKyQHeZWqbKQhbtD7S18o8xtqSb0qwh+mzTLLZJlG3i14RurNjWhXrQ1CEbuZ+KlYzuxssnwKf8ioIrP7T4lpNsyBbDDbYETg643OIUxRhAmCjuDB05nBHOaeDx1uAja3vz8Ky2XSXKz8XVEafyLQtvYWK2yq8l65CYwoiN077MB4cd4rMDmGze0rThvwC4E7QXHCh85tvZddg/4eCrxVRQAuUOzB2sg+7l+5iaLxqQ1lv5/oFqLNsmvA3NHeRMVQpRmZNIiQLdq8PPCojbBy3k+DM8go+EzGo16dbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9cKgsHe0XV/iAH3qH8WDT5gFGSH+IhQxodqelKx/Ymc=;
 b=l/301F3bcbN4gAVABjH0GaoCqSTBctNb5hD+Fs0Xc1BZFc5w+Il8aGWum4fXb6UqKAdybxPnETzYdyI/EN6N/mCsDtnk7SCM8vZML2i9rgUx+vD1MD++Qpgzp+JY5y4oB4pKj7gl86F1Z2bfubHAD6+aO2fu66UT0wpsw1nTaeuyK0YPpDC+Z3CbuxV14nuONAlWwv4ydvuwcsWvO6vYiTkVmCk9gpHBCY9q1gunb2DMWYrKZLmf/bRsSeu8OQHDGObMQOp8Flb6u29GzzGMAxbtTUTt1fsMui3lVeH0sG94Ms+n2KDaXZtVPhdRRx5OM1pAbPC95U3nOCf3u7u9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cKgsHe0XV/iAH3qH8WDT5gFGSH+IhQxodqelKx/Ymc=;
 b=LiIOhDdSxXKMFME3WgdS1ry+c9Wr0lAVELv5DKzKBSLmCOBxNP5gJbJxKWQpKJxBCe02CHsEGf80KrAQlOOmeN0v8kox2HSDmuXs/IlVjei6MEKBByrRXRofDhu8SbvA+svhd9W25U2vFT/YveNf0SOAVbrrjLdhQw+Lu8zC+CM=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1776.namprd10.prod.outlook.com
 (2603:10b6:301:4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 14:51:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 14:51:46 +0000
Date:   Tue, 28 Sep 2021 17:51:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Oskar Senft <osk@google.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/hwmon/nct7802.c:714 nct7802_temp_is_visible() warn: compare
 has higher precedence than mask
Message-ID: <202109282205.p0MlELts-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0050.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0050.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Tue, 28 Sep 2021 14:51:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288a6c1b-2da7-444f-70b0-08d9828f7e1c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1776D477A68E17640C18A15E8EA89@MWHPR10MB1776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvF8uR7O8/xtAC3i7JvjwwX6/R0TwPyXHeN/itTQQcRuVexRUZcI/cpQezEwekOZAvHpZNtmluTXm+X7JTcq024ZelssHYVv6KFAGDvvDK4UEBHzcZROJ2aGw9sT2Ja80Uvptlf5V/1F7b+bu52P+9tXD4ORrGjKezDlToGRv9vx/KJPEIhU487+tJ5WUT6kMRJjKNBm77MRpJ3+YN0GZ7NLLw5PGa/12mm68IFxVqwXO5ZgKhQ9vulGyWzsWMzVENeYD9DAcVvsmZKIoZQH7AXPtG9rtdsCUqT4GuOqQZ/6ztNs3zbVKD8sA4UfJGtXA8cd6t6egCnakny+et5F0LYSgAScuEUnGocqTOx+Yp9DC4xom2YSOUzyms0WTX34xns6J8hCHAZDbmnnLGrCJDfWYkhQqWcq8KpDWqVgOe4m421YqUnNz6CNxzctVzvqsbzjXgESK/46JPomhrAkGfP2TThPpErQbXQ2wW+1zc7JiUbe/p7f2K05uMeI6eB3zr8JUZCNPHfz/blzkEr7S3bRozpQ0oDox/tsPb4hCSdn3hlQ0gc4PtQ6tDQJ8rO5l+vwyDQT05+DHdnjWhFMy9goTsTbEqv6Ufx/zKwGBwK0b9z9EC+I6d1XZfJN7xsEcQIGjBfqvOfiY/putg+YxdU9fLe3e6yP5lJBxmlfGYAdVM8Mm06ytFoBYOUOyqQ3yeDjbjfxxw1pYT34xsQpZmMc9KLFrkTO7uyAo7H4cXeiKj6cIIOGVbGcYHFuhcYDK2iWGoykdZtGmyzdf7QfLzA4Zktpd7Os+1H+c0ApkeuDJBWZhxt+YpM5ViHqExI75VPVshbXgGekZDaK5gbh8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6496006)(5660300002)(186003)(6916009)(66476007)(66556008)(86362001)(36756003)(1076003)(52116002)(6666004)(66946007)(8676002)(9686003)(26005)(38350700002)(4326008)(2906002)(316002)(956004)(83380400001)(44832011)(8936002)(966005)(508600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+m22rgU5uuipSNMuIdWZd2WUOMaDhqvEKcY4p6m3U1/oOtyABsSwMGunOdpb?=
 =?us-ascii?Q?k4K9DrA9WTU50N3C8yUoQjvMBpzHMm6pocBPqBMJb5vDyQ/+NTOJofMKpwPv?=
 =?us-ascii?Q?ye3LMwvfj6jgYvQcSviuCHEZadlAjLstt33XvdJU3HC1AtWjqBQcDlU9csCG?=
 =?us-ascii?Q?ruJA4ruOsuUxgwBfLJ7L482qoumDbPnXP7QhZKeQg3tLvsLoYR1B8wmViE9P?=
 =?us-ascii?Q?j7NQEifiSlPgN0eC0oMh2SqhTK/aijjplYcg01xwFg8B9l88YbKaZKmEnD+5?=
 =?us-ascii?Q?EiWsFt8cxFFvCg273fQC+2rSK54ytB4f5vAoQWGuqJjqVPLBeEOq2bLniwpv?=
 =?us-ascii?Q?lkQq3eDrfNzLJV+tdNvRdUoZ8sgylf6LR5zhhnP+WzmpiB2WW7/ep7MarETK?=
 =?us-ascii?Q?s65kkv3DVj6n++tEXZmvhoyeXqEiC7ihW+nTlyhG1o0EB8AakfG/YnnB5bd+?=
 =?us-ascii?Q?JFLHdBeJsgpITKjgrTDZ0yrqTGyRdR4CTB4zUR35aPDEHeQsR5cUMebg77vT?=
 =?us-ascii?Q?xvRXCSau8B18ecH/8QOPON8BjcgDsbECEoxXMrZDfUVzY/6cIyaXzWeOSTlu?=
 =?us-ascii?Q?No6R6PLwJIMItzV9MyIWNAYgDe+RjGHBDBNqPcYeEcJsZvv5Rz6FeYVHvKtc?=
 =?us-ascii?Q?ki4ESyUlxY77Uk5em8iCNITFaRHOlp96Z8eZUkHtvKeco8t6kkCTJxJ7190c?=
 =?us-ascii?Q?NJHvGrHAYXD73Y9oRSQV/FXeRRKy6hzTlzcnMcsfVfB57FlG5bvL7r6c6nVe?=
 =?us-ascii?Q?ttbYh/+i7MJbOLAK57AaDiYHmu4Td8LYENtZXZB85SvyW33sTnGmlmGS29L4?=
 =?us-ascii?Q?as1BXBVZCo4mZPDhdKfokCuOYRseIRopLqYkf2W64WwoXookpEk8VuDoIbwb?=
 =?us-ascii?Q?CwvzQhYxAFEU8zIzEeDN8G1MuCnUcpZFylryardD2hLnxLn2M3fOW2OpZzva?=
 =?us-ascii?Q?+a5x5+dtZSfAlccqNMoXYGp13nZqH0W1bzvaOxWYLN7EEcKJQoZrI10ZLsX2?=
 =?us-ascii?Q?jqivXmUaNk3moUpSOGFVDRa6DgEpMVCz0ZtncgjSAjdRWr2hLgEZn7jw5wKB?=
 =?us-ascii?Q?xJCKZ2s63LBF2BQx1Fw23EbKAoz1ZQ09LLQ/BjNYkUguu7JsflSHTQZMvY1z?=
 =?us-ascii?Q?04KnSECx5qam1wFio9iUYX/UsHylLvwrUemxcVQNx8GXrAXNcafhSpX4f1cP?=
 =?us-ascii?Q?7h30OI8QWuEnEGH1SgIpFuvYCYlkCWsz3Tcm9wVlbuMuN3KDHOgW4C/Qlt2J?=
 =?us-ascii?Q?R5QZvUxDn0cm44/e8WQ2ZQDFC3ydCAmxJOp+ddxdDUm9p3XnVeqCuMycqh/A?=
 =?us-ascii?Q?jffnaLVIVlHoBr/0YpY/e5Vy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288a6c1b-2da7-444f-70b0-08d9828f7e1c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 14:51:45.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDMvfvD24lJMI9xoRJm0H5LIclbbQ+5nrffDyn+iUGzWSS24Y3px6robbagkl4fJ91ITN15sTlB4VyuXuMG6YfP6kttiDsNqjyvjFKCDRrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1776
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280085
X-Proofpoint-ORIG-GUID: zXjzlGjd7rNmAl1fF8UfFmUpplMi699t
X-Proofpoint-GUID: zXjzlGjd7rNmAl1fF8UfFmUpplMi699t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/Oskar-Senft/dt-bindings-hwmon-Add-nct7802-bindings/20210922-121927
head:   0654ba359c66a776f243b53f407f200f9e53a9ba
commit: 0654ba359c66a776f243b53f407f200f9e53a9ba hwmon: (nct7802) Make temperature sensors configurable.
config: i386-randconfig-m021-20210927 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/hwmon/nct7802.c:714 nct7802_temp_is_visible() warn: compare has higher precedence than mask
drivers/hwmon/nct7802.c:714 nct7802_temp_is_visible() warn: add some parenthesis here?
drivers/hwmon/nct7802.c:1136 nct7802_configure_temperature_sensors_from_device_tree() error: uninitialized symbol 'type'.

vim +714 drivers/hwmon/nct7802.c

3434f378358043 Guenter Roeck         2014-06-29  696  static umode_t nct7802_temp_is_visible(struct kobject *kobj,
3434f378358043 Guenter Roeck         2014-06-29  697  				       struct attribute *attr, int index)
3434f378358043 Guenter Roeck         2014-06-29  698  {
d06f9e6c8960d1 hailizheng            2020-05-19  699  	struct device *dev = kobj_to_dev(kobj);
3434f378358043 Guenter Roeck         2014-06-29  700  	struct nct7802_data *data = dev_get_drvdata(dev);
3434f378358043 Guenter Roeck         2014-06-29  701  	unsigned int reg;
3434f378358043 Guenter Roeck         2014-06-29  702  	int err;
3434f378358043 Guenter Roeck         2014-06-29  703  
3434f378358043 Guenter Roeck         2014-06-29  704  	err = regmap_read(data->regmap, REG_MODE, &reg);
3434f378358043 Guenter Roeck         2014-06-29  705  	if (err < 0)
3434f378358043 Guenter Roeck         2014-06-29  706  		return 0;
3434f378358043 Guenter Roeck         2014-06-29  707  
0654ba359c66a7 Oskar Senft           2021-09-20  708  	if (index >= 0 && index < 20 &&				/* RD1, RD 2*/
0654ba359c66a7 Oskar Senft           2021-09-20  709  	    ((reg >> MODE_BIT_OFFSET_RTD(index / 10)) & MODE_RTD_MASK) != 0x01 &&
0654ba359c66a7 Oskar Senft           2021-09-20  710  	    ((reg >> MODE_BIT_OFFSET_RTD(index / 10)) & MODE_RTD_MASK) != 0x02)
3434f378358043 Guenter Roeck         2014-06-29  711  		return 0;
fcdc5739dce03d Constantine Shulyupin 2015-07-01  712  
0654ba359c66a7 Oskar Senft           2021-09-20  713  	if (index >= 20 && index < 30 &&			/* RD3 */
0654ba359c66a7 Oskar Senft           2021-09-20 @714  	    (reg >> MODE_BIT_OFFSET_RTD(index / 10) & MODE_RTD_MASK != 0x02))
                                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a precedence bug.  There are extra parentheses here but they're
in the wrong place.  It should be:

	if (index >= 20 && index < 30 && /* RD3 */
	    (reg >> MODE_BIT_OFFSET_RTD(index / 10) & MODE_RTD_MASK) != 0x02)
		return 0;

3434f378358043 Guenter Roeck         2014-06-29  715  		return 0;
fcdc5739dce03d Constantine Shulyupin 2015-07-01  716  
0654ba359c66a7 Oskar Senft           2021-09-20  717  	if (index >= 30 && index < 38 &&			/* local */
0654ba359c66a7 Oskar Senft           2021-09-20  718  	    (reg & MODE_LTD_EN) != MODE_LTD_EN)
0654ba359c66a7 Oskar Senft           2021-09-20  719  		return 0;
3434f378358043 Guenter Roeck         2014-06-29  720  
3434f378358043 Guenter Roeck         2014-06-29  721  	err = regmap_read(data->regmap, REG_PECI_ENABLE, &reg);
3434f378358043 Guenter Roeck         2014-06-29  722  	if (err < 0)
3434f378358043 Guenter Roeck         2014-06-29  723  		return 0;
3434f378358043 Guenter Roeck         2014-06-29  724  
fcdc5739dce03d Constantine Shulyupin 2015-07-01  725  	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
3434f378358043 Guenter Roeck         2014-06-29  726  		return 0;
3434f378358043 Guenter Roeck         2014-06-29  727  
fcdc5739dce03d Constantine Shulyupin 2015-07-01  728  	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
3434f378358043 Guenter Roeck         2014-06-29  729  		return 0;
3434f378358043 Guenter Roeck         2014-06-29  730  
3434f378358043 Guenter Roeck         2014-06-29  731  	return attr->mode;
3434f378358043 Guenter Roeck         2014-06-29  732  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

