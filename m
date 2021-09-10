Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02E406C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhIJM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:58:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14026 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231843AbhIJM6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:58:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A9c5cb023692;
        Fri, 10 Sep 2021 12:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QSnJ4PjBuW5AlV1jTOxg0jUH8/sHOanN0eM41GsGjWc=;
 b=Pc0WvNApVoQY8HGaw1vnIpqzhwue/quFHfhgBuJa1f+OPaoJGM0EEoP/MVYTlISteodQ
 xL+S9eGSQbLLs2fle7tEwHq3pSEwSzPp+SI5XACo9I4aQw8Ji795ac0J/eZKcYq1m153
 uAcLTHlL41rem9ydUjKo8FgUAQU6FGTFII34BKn4kM9JvN6YAysFEFv1SQGkhkgILwO6
 Y7WpzcqN+w0EBz4gPXLwQ8MJzcATJK21ibuqAAYLgaLnmFudzH7CFE3nkBJDY1XFQoE7
 JDUMfkrM+N3E8RxPrbYtai0XGe1K+wrrWk743MfV1WnPn1gDOnKV7lxGnCXRKGR12mRM HQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=QSnJ4PjBuW5AlV1jTOxg0jUH8/sHOanN0eM41GsGjWc=;
 b=v6/5SyQgJtOENZWPic7Iy6zVVc4/tvWEo78yVJ5P7pxLnl4G3Gs2A+xsMQ6NHs9e6TCr
 khYr1pfd9l45AV3SjnEm6osw8fonvWILM6cYrAygnCyWPydQfaML/cQVTgpOF2tJWYzv
 CmFF/oOekgkyKxjXSj+uk9sJPQHCtyzbv+WWwcTGx/CGzPJy7NSOLiai/9wtCWBwrwTJ
 dxdY13NRvqIU7Qb0uBanJNTUzlDeydR9q0q98iuxTjrdlrlnjuAM+mpsxCEEtWYItJo0
 lgdZBIWjyMXS1rTb/GWxDBMoTstwjOMxFCxgCt1HbxAitiXAsGK0mGcf27Hqt6D0oVmJ Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytfk9ryp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 12:57:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ACoxpF081943;
        Fri, 10 Sep 2021 12:57:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by userp3020.oracle.com with ESMTP id 3aytfdcd8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 12:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqRSGJn7n2utr9Br2CUIx6qYhZPk1Gt3min/peVbPqbBdf2cL8PyVy+Gjxu+v27YFDJLfPuDDANnUXTCj69JZ2DVXitlPrOy4V8z1kL+wPhfilMeIvKqZAzAR9JCUxN1cTjQtmGmjz7s4xrerc/ksnj7suyxAcRDnRD+1dblDRbwEQQIcId3XR5X7xWo8FL8cbj72avaf5oNjJZa+dNokoV3waXPRAPUrJGQHFvCUQ9kz2/QkUNoKlct7hzL2V+ZnABr6gf3X5dkCfQ7PXdRgTbzo1iFvhwRE2SUgJuztzRh8sh1Bx2+kWRvFdxMBmtE9ywwAwus5wZHn3QvjpoG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QSnJ4PjBuW5AlV1jTOxg0jUH8/sHOanN0eM41GsGjWc=;
 b=Um3FYJnN9CNh7R6/pZlx1tokh6akdS1CT/BtOJp0ZV0ftxZg7C4sNfMCcL9fYABKb5rZnfHBQQrJC3qEDiLP3+Y9T5Vbe0wAV3Pjz8fuGRasKJP9QRU4VnxjRXP7IEyQ8Zi0VvmrhIX9fB5czDqqYGPXcr0GkM8UJ5Br6HjNq1N7f9B66aS2/7v5U4nxT7d4T9yGUrmz4EX+hO28EAaWJ1SNV04AGwoJER555d31znb6isDF8kvAK6ceH5mflDvMJt/+sP8yaCcnCppn65FP0wUPrxWmwQFf565F6s647NzY+N3FxjYkX7GzS0RaJ/N1IruFbhizeELEBy+dY7qJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSnJ4PjBuW5AlV1jTOxg0jUH8/sHOanN0eM41GsGjWc=;
 b=ceu6xw/cUytnRpx2PFHkYOSFXzBpE/SnIAYKtH1XdpvW13IOZ4j/MJkDnb8kDAOpX+8rdxTf3Wth/cmvpAIdDrDS+G/rORwl6AiXpyYAwfxBLNgjfDFmS/xW/JcnH8JeE4vembLtyUUUD8VVti7U2b/PQBoTmEVj90kBaeQJBFA=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1358.namprd10.prod.outlook.com
 (2603:10b6:300:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 12:56:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 12:56:59 +0000
Date:   Fri, 10 Sep 2021 15:56:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:fscache-iter-2 51/75] fs/cachefiles/namei.c:295
 cachefiles_create_file() warn: signedness bug returning '(-4095)'
Message-ID: <202109102002.qDxA71G9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 12:56:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7558eea6-f2ed-42ba-30bb-08d9745a79bb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB135848BE81D6DAA8B491CDF38ED69@MWHPR10MB1358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9EZ7IPUcAx1P8F9cbk7UEsp6oLnaPbmQBIxTZzVix/PabSH8rQ5ybU+5yt2r9Skf5SWurWQeTMQeBXkh4d1ZXHf8bIl2uLLW7AZPGSH6mfNpXoUuHqvyzikiGMUvgv9dvSrPebMC7rArDb9nYX0izML0ck7/o2PfdIIM6ykNLzqAXROVUGb0AYz3yEb3q7NU1sJ+tjZg4NRlZ6b3Y9gB8xqQzePU6FgdHmnvq85YXC5Wzu8dzH5i9+nn6wQTLazIETHWyCqai2Y6FLoTht3TPRCMDfI2kr6eNP/SlEZ9TDr0IhBc7nsYLZ3/ZRLlMhjUKtcOUHQxdZa0OO7VLXJEzlHU3GaDsIVFb5Z0vA2wmyHgpVSb/KUV3WLoP1sCa7tkrXDm9xqfAXBGVPnE5X5WhesTDikgmgIOZo0lRGPvi2blWNEVypXc2MHUmvWpi110f9rafMofOpwIVXa6A+F+i4WSP+BXCz10yi7KrDqT1CksxSmaEl9DiwhgB1LAssuEzZ44JBli3dXC4fkkA9u1YABBvfRqzW54DPuq6yIk6IqkCyXTAvG89mHYmEJzDReI+UGqS0NLuQAug/mqwYpkfJIHwWcLX53YzVTp1sm3TawIPBYuoC3D3FxbPi7hpYs+66cGzGceDvz3NJz00KOSePdTtxSObu+9fTYuCvDLt7nSrbBBj1duf8Kfp0i/yQpqnQ+7zFA1gNpXHvjdEXIt08x8ImpHSQPNKUn4Q5L+f4b3OwW9f7KBP7mRHyJ1iVdRuCDh4shJv3NO0hY7PVhrBbKq7zRL2O2NeXPYdx3M1laeVboHFaYQmG6/rzIs6fyY05amTEySZGfz57uCesFOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(2906002)(6666004)(44832011)(38100700002)(38350700002)(316002)(4326008)(36756003)(86362001)(186003)(66946007)(478600001)(66476007)(52116002)(966005)(6916009)(6496006)(66556008)(8676002)(5660300002)(956004)(1076003)(9686003)(83380400001)(8936002)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6xlSvIWj9d6T364LtGuGQGSVtEgmm9Pxz01ljZms7IMo38iZxV4T21fQpJQ?=
 =?us-ascii?Q?UVnUT/mQYC3LM0U85G1pYtuOcwI5c4qi6gDmDuBuasWLRAYZK94XwbqM8UN9?=
 =?us-ascii?Q?rXmcsqKjtlZSruVd547+BBi2B7ZQhXyEpRDS9qcCaUmZ3bu5bdOFqTnqRtzo?=
 =?us-ascii?Q?OuvAt3lYFGBndv7rd2Wq4laRSOy/osmN6OoJQjNzJkAm20h677cyMtrQJagT?=
 =?us-ascii?Q?YzF/6BIO22JdpW2y6dYEFc83cTcOZXCzO84geQQTomRMsNjMiBA4Z73P5R1r?=
 =?us-ascii?Q?rZcxPiUH5NmIamafudQL6Nw6pTO6nBhBpqMeBxMv4fzseewWflKzKYpyvHU+?=
 =?us-ascii?Q?+QwKNNRMcitA7Bt0UtNd9iugDjuMpwcV9Rx/zF/Nt6FN7UdECAo2AP3Pu92J?=
 =?us-ascii?Q?lAfcKG2tVq4PEhYWkSFhrucUAtoO97F0HGeSBApP2eUiD8g5vGKljbLOls4V?=
 =?us-ascii?Q?4+AdVKPNXLwSyquAdy3/83jhIy4H6nlRq17vFvlijcNg+jxzLc5hqCxLpbdY?=
 =?us-ascii?Q?HzkNnGyqIBC6THJgU8AG63hrmhnVi2Pa/RsKnTn3JUDovld07t0sexyXsLSU?=
 =?us-ascii?Q?C70x6WF5xgiSuZip8Gewlw/LPhAeb4e5xf2zRhYb+aVbMRz+WcX7DYrxY9WC?=
 =?us-ascii?Q?tAcVb4t4xWVbImGvcTE+8ZuUVk9Bw/QZhoQDXOcD1jRJ5TOlyFL65HIYO453?=
 =?us-ascii?Q?lA9MrGffEQnFh3pG2Mvq5XRuy5Zls5tOS3g9H1f7iMVB85p1s9pXwqrt/DC0?=
 =?us-ascii?Q?wBXFLxWZxIsSBnoEX5i6h0lcT+JzQUgN5qdAlDxR0J5/iIQ7wdxdNvhehi5X?=
 =?us-ascii?Q?WGGHlJcCWCIhkSkYd6iWbdIvnRUP46xuaVTeQrZXbs/PtI+QgGDnI6Bi8nAA?=
 =?us-ascii?Q?drjKYeYmd5ZyF+4FY/KreZ8gVjmANV+X1lG1qB04/2fof4ulOouS3OVFbQa+?=
 =?us-ascii?Q?W4dK+GPgz0GDNcuafH2wV28YmL+k7n7n4sqLca4miH3ryKrDEI9c/SxOGxcP?=
 =?us-ascii?Q?HA76LFEgxOoHpdv+PkbaWYS7gjJUDGmxImwgdItSIVnWtMJH0Srek/iIhRrP?=
 =?us-ascii?Q?TAyuPWqLe+4DsEeaMIjV45uC3RG8U9cPE5MeStKra+45gKnMQ2gnUup2oj78?=
 =?us-ascii?Q?E9zUgUwfFPDyJ5LVybMWj33Jh7P0QMBxGvyNy9VWLa+ellaMQa8yO2jC8I2S?=
 =?us-ascii?Q?C3fz3/IXZEdRGtlHysoHDzAhAF7kS8ymTaJE18LRxDbZU/1Xmpq3+62ygdGV?=
 =?us-ascii?Q?37YcgOH7LFN7Sm2omdZAZb9CVak1kH7w+gM2A9dZqijM0oKb1lAlyWMp0pjT?=
 =?us-ascii?Q?qJd5xAqY0spxNDFfyxOZ3mQn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7558eea6-f2ed-42ba-30bb-08d9745a79bb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 12:56:59.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrxE6R2ZY5tH+hn0LyV1A6F/DrXUH5zcD/I5n9BnD6/OQMfm3opFEerPUiC9uDb/yRAvi7BqTdd8sEahYCu8uPRf4unEsWkr1hXPASG4+x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100076
X-Proofpoint-GUID: dGby27ClcCUDBYFl0ql73h519hXNTRyP
X-Proofpoint-ORIG-GUID: dGby27ClcCUDBYFl0ql73h519hXNTRyP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-iter-2
head:   7c7521adffeb04466a42e8e1956353b9d9038d02
commit: 8a939333f451cb4296510d0c9783edf1b915ad9e [51/75] cachefiles: Rearrange file lookup/creation/check to simplify
config: i386-randconfig-m021-20210910 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/cachefiles/namei.c:295 cachefiles_create_file() warn: signedness bug returning '(-4095)'

vim +295 fs/cachefiles/namei.c

8a939333f451cb David Howells 2021-06-09  282  static bool cachefiles_create_file(struct cachefiles_object *object)
9ae326a69004de David Howells 2009-04-03  283  {
8a939333f451cb David Howells 2021-06-09  284  	struct file *file;
c8e2ee13a8662a David Howells 2021-05-20  285  	int ret;
9ae326a69004de David Howells 2009-04-03  286  
8a939333f451cb David Howells 2021-06-09  287  	fscache_cookie_lookup_negative(object->cookie);
9ae326a69004de David Howells 2009-04-03  288  
8a939333f451cb David Howells 2021-06-09  289  	ret = cachefiles_has_space(object->volume->cache, 1, 0);
c8e2ee13a8662a David Howells 2021-05-20  290  	if (ret < 0)
8a939333f451cb David Howells 2021-06-09  291  		return false;
9ae326a69004de David Howells 2009-04-03  292  
8a939333f451cb David Howells 2021-06-09  293  	file = cachefiles_create_tmpfile(object);
8a939333f451cb David Howells 2021-06-09  294  	if (IS_ERR(file))
8a939333f451cb David Howells 2021-06-09 @295  		return PTR_ERR(file);

This should be "return false;"

9ae326a69004de David Howells 2009-04-03  296  
8a939333f451cb David Howells 2021-06-09  297  	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
8a939333f451cb David Howells 2021-06-09  298  	_debug("create -> %pD{ino=%lu}", file, file_inode(file)->i_ino);
8a939333f451cb David Howells 2021-06-09  299  	object->file = file;
8a939333f451cb David Howells 2021-06-09  300  	return true;
a18feb55769b70 David Howells 2018-04-04  301  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

