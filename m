Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92184446421
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKENab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:30:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23226 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229925AbhKENa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:30:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5CIfiQ009142;
        Fri, 5 Nov 2021 13:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=IFHORrLAmmTyE9t8+4KB61sTvVz03TA2NZ5JmibacIU=;
 b=jPsVUAj7TtvlQ8ZHQKqpXhULNaFW7nZBZvYt4Gz+YF7a2N73uknygnwV9E1LVyV1aK3U
 vwMYO9hdz/aBuUK1i9wXdG+LxYoRs8a+45M0rxFHv+mhxnUp6odU9s5HQTNRqkYJYU5r
 jQWGIOXlJfpYIAA0J5XKpsqGKERxoTtQPYzAcL/1gHzhvOhADrsZOiv+MRWt1s9CV5Vl
 5F8irz1hA7/Pl+8Dk0kCDewoJzrxVIuPrV3VyQiKsEIwxIop29SLmRKoJgYWjLGdIMxk
 IMyr7cqTeSY/x6dZJfOVarrKl6FkYvWtLBfe4nPpLW/2Z7l5E2izA4KrIUzB+URgcZAu ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7htjj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:27:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5D5o3G018226;
        Fri, 5 Nov 2021 13:27:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3c4t5nn67c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq/LGlonz7n7FAMy6CquiPqZ9pErP3Qv3TVwOIKKC4nRoaqMa8yQNaRwnf2O7mpa3Qf4v/4KTczgYFfcCA6Wtma9XBIVLwT8ksMstTJtq7KSCXpS77LMDBs88dYnBXGJ7ahFKpUEpi9dgl4JtU1dGHXHSLfdO7en7ZIbReMeZdFLH+lLSVveQxYJ19R90971/cwzHobOCy4LnA9DfkGSNfF8gwpHe0+CNRKRUGmFJDfftGnfRjjCVcCpQqpvnS363b4WdYKcaWbilS6VD4dwZa/xHcbxPAIaj90yOokQEByiB0b4CDH43jtQawmglQtJhg69Q5YXgfYvByvFXwwJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFHORrLAmmTyE9t8+4KB61sTvVz03TA2NZ5JmibacIU=;
 b=gmu5FXht/F3o6G5/PfJJkyvPHjNKOJjDaoAMxuqR4ajA2YQbmXzYxBFHHQglKqKx1LdA/zsQ/5wTEpTSBkvLRj01YQbBUaTckkbNI11m0za1TZhrK1V7NQ+x01t5pdevksRrtbQVehyS4oKKxgIeFjK9yoVGFw4mrxFskmHdnb9gdLI6qWvTJKSYVieOkoy+0O9OBM5ML9Nbl24npdhELr2Nx8ZbOzHaHV2x87LHgr/WwmDwRt+2ZIClLEfSoMXlqw06A2yU9H+1+24iIRyTb6E5Nm0guaeL5C8Kt2vZkZBZlExsIRNKlsjLa0YrbAFtbzL89eyS7TdjE+Qqvf+fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFHORrLAmmTyE9t8+4KB61sTvVz03TA2NZ5JmibacIU=;
 b=IL4HJBd7c+yFnwfvJauPnwSlzLmHdDXz5+9hKvi4Xq9k+GrTUzWMgN8SM6N58LyQHrfy8k+w+nCWlP1sk9oa9lO9UhB7/X7FpHTD1gaeWIPLx1NUeyAIsKaOJE3MFsmz+d0PH6k9/DXP8ymlrH9z3rd4zUnCfeX+VWYrG16DRU0=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4417.namprd10.prod.outlook.com
 (2603:10b6:303:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 13:27:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 13:27:37 +0000
Date:   Fri, 5 Nov 2021 16:27:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, zhangyiru <zhangyiru3@huawei.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/hugetlbfs/inode.c:1467 hugetlb_file_setup() error: potentially
 dereferencing uninitialized 'ucounts'.
Message-ID: <202111020447.1sqPrmgi-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 13:27:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: effcf98d-ddf4-479a-9ed1-08d9a06008eb
X-MS-TrafficTypeDiagnostic: CO1PR10MB4417:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4417653109F4F846F4B3DC188E8E9@CO1PR10MB4417.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQqRZ4J7W1biZO3cXtnan/R02L/6CTdXwtniXTZLrDyiT9fYSltGt23A6XK5gRzY0dFj4kfsTlrm8kgMHZG2Rc+wSY1sFwCbD361FfbsNMQEQbYvVN31y5VLOVH5RZ2KWzanZ+t128EXhvlXwTDYCmFQSUGU0lP9FU8v05gaApGXL/fIrpoj+gl+ugjDzqhK3siXq8jcOAxWvkZpghTMaWzM18MLfzzkNWd6CmPmLcqgj30EB+RXGlOOoNdbxgbC9t+amT+mra0zroXtlseA2tGocCnXxAb298/gLl6whqNft3X7aRrmcwO1dbr5EAmXQqkHoQB6CC2zj7zJ0lJ6bnEgUVkInN2XkhvRqf9z6zdWipIRXqn7D2Su5fNyfhJjzB09J1e/aYuyYdMeiG8Dd06t0Zt3BTxse5OcAWJyGn/fRK87kCIznxt6kI7f8wSxx2HZ31FSv6DcIBRwj7cosf2BLFpauA3ub3ILxQS7Rc2Ict6lWX3cE7NilAYrVf60E+k7O6lvHFrOok+MTOwAPVzRHkIMGCvr9CBF7vWz+UILiiOUnPhyZR+Y8hOyJCWgGCzkZsFByWLDS7si4YdUzlEc+XxoDab+Q1eAl/rKyc6dSslOyItug9vK/4gTVvKO+6iBxOF0vNFddHKuu8IDLUvCXpvCZ4uwK5WEiL3T7MJiRT6r01UCEqUvxxf0SPSlsL2x6CtZhMXRz7O8cl7elESwQVUgMjPWLSC7ibPvWUc0MfGdeBK0YMvQr2W9L2ptcyZ3gw0fj77CtOopceb3FKfuP0JscfnBMTqZAbPbelXGS10Wd/cU8b/fXm4DszTV4uIV4znMa29v+DOpquBopw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(186003)(36756003)(26005)(38100700002)(6496006)(83380400001)(2906002)(9686003)(44832011)(5660300002)(6916009)(6486002)(956004)(4001150100001)(86362001)(38350700002)(1076003)(8676002)(316002)(6666004)(66946007)(66556008)(66476007)(508600001)(8936002)(966005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVGTcNwQ5OqQFG30wawcHoT3+7BhChNpJkhuYshEpbU30QF0IpGmjNQdocTs?=
 =?us-ascii?Q?vFq8/oLzVNDT9cB2sAH+EhMCYE/5k9T9vuWFw0xWzhFrYoqpEclmeOyEOupf?=
 =?us-ascii?Q?aTwoay4HMV0oNWL/ifacZOk0aEtTF2IuS/754bfumqkD1B1N3LjotzIZfyVZ?=
 =?us-ascii?Q?+nKTwHaBM/H5yHInEV+tWh3DqeO8iJVcMLt1W7l27RmCqRSwmpEcW6cnek0J?=
 =?us-ascii?Q?0qzOPnUV5S931cFwRK1BjM47J8yiwCMDhV2B8Dr0X5+U4evxpoR1248FYh5W?=
 =?us-ascii?Q?5tB7H4+txqXWCWv1PNx6QTnd+9K2mNHKf1sZeMc4iyBm1Y1SiB7QtpO85G+V?=
 =?us-ascii?Q?nW61jCCg1HM16h/dn0rLs6epxg4SiH2/KBdD427RpgnSsgt4nA8dUO63YJg1?=
 =?us-ascii?Q?gauloZHTOqL/wS8MUoA4YClSu0tp2l9brzB9lA5OZ3tefhd4yy9D5RRTH0MF?=
 =?us-ascii?Q?EXDEJOQ0BtIDvuccA0bArzxDEyojQL8e4Vxkj/7jOuMl59yp8AlVIHbFwfwO?=
 =?us-ascii?Q?2o0w2GEbwJ2ZtSf5G9QIbNvuYD2JfD+q7FDi6S7PtAZBGo+A6cCHGxzn1pMq?=
 =?us-ascii?Q?MweDnWZrt5dshjnI4QsvmdGZ5CA/bOiCyPiiCy+a0ExbwjIuw+hbuwyud54F?=
 =?us-ascii?Q?HVhoiYwDZWJSLrD/9HzfKAls6rQN5OVP3q4aAk0pSzFE17LAh46WhEqvAxzB?=
 =?us-ascii?Q?9Vy8QK6Sk3d1U6tJU4CWObwynUpvF3wXPWQo/9mJ0XAa2kXX/uszHwpG0uOt?=
 =?us-ascii?Q?bwJmkJNqz1ZtZBcD9cpCDTrSLtUMRMKu2Ia09qRPYlSE7H0vCP6PuepcLz0Q?=
 =?us-ascii?Q?BH5gzpZZmHBO/CcO7Z7ueR3FS/+2Po85WOqbV7F3J6S9ML4uJq3f7u94ZUm5?=
 =?us-ascii?Q?bgMddv8aoiz8yyjKnR5rDT3rcM5CX9JDMNPANRGUNBJ7kA92ImzQPh8IsuIn?=
 =?us-ascii?Q?Cu4GGggOSr8/0owkYRSrav/G5g5zDmIZU40Bn1+dmvBSU4ETdVP7l8DkVs9C?=
 =?us-ascii?Q?yjDdXkIahFVizZ2Cd/Q93Bb/WcfOMZ+HouRi+n639N8msrWJfjNVZdrvSXUI?=
 =?us-ascii?Q?9lYrfl4PYz1B23X+YO3+gbSU0JlfolyCzpfeuzm5bkVSHFCPwl8Tgy+9oRIs?=
 =?us-ascii?Q?1+daxD1eJeF0f0qs5V3W7q3zJInUkmXSUB5OylUKUDUXfXH6A4vi0zJ0/0im?=
 =?us-ascii?Q?ZtqfQe5/GXsF6jrrIIQxjVa9AmP1QSa8et1GGzwiqS254akXNGieVkXxCjXS?=
 =?us-ascii?Q?e+HvW/8itRFrTt0cy9fh+yO4pWgp/KG4nBDvmzp+4aI32DREvC5hCL8aDCVa?=
 =?us-ascii?Q?91PYF6ooDgxQTZ/JSFLdU1w7N8phds/EizClCO5cjln2ij6qC2GYylV2vvkT?=
 =?us-ascii?Q?mYK6a9wfrhS/rPzCzCTCReoUjuxNc7QBcDSmH8T6MG05okzvJ3bV8iiAR0fE?=
 =?us-ascii?Q?KekmK0oEu8MLfH6ZtjgpKppUEgCHwrvEx4JcfCY23/zGBA8/AlHhzZUVAvyf?=
 =?us-ascii?Q?o0etp57tA7TO7zvwtxZc7ehe9Jxz0ZOtqmeo2yINFJxyQmVAyB+7XR2ECGpr?=
 =?us-ascii?Q?/S2MT38MynJ+iE+lvrRFQxGzUzh74BPQ8GHAADTipJlTxV/hmJYk3xbBy1/8?=
 =?us-ascii?Q?fBKF+gdYN2LUALKPqJcA9ITAPEFhhszWAOSqAZCikosK/uE1h/k6j3IhiNSQ?=
 =?us-ascii?Q?SQ5j1rdOE2Jrqawh94/gVuDZqaI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effcf98d-ddf4-479a-9ed1-08d9a06008eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 13:27:37.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEQQX0EHdJvpDk2yiW4E/sC9kCoZqK7uo4redRzO7BxcOI+AkwFXyn2iQcPmtoJyH8f1CefmPyXWN5eUBrUp/6iu0nOJe56ayygfqT0aGVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050077
X-Proofpoint-GUID: 29DEdo1rZvYjSlfvT6nQRA55ZjYiAFBU
X-Proofpoint-ORIG-GUID: 29DEdo1rZvYjSlfvT6nQRA55ZjYiAFBU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211101-211012/zhangyiru/mm-hugetlb-remove-mlock-ulimit-for-SHM_HUGETLB/20211009-094538
head:   52edddc18d9541ad72912b32edd74baacc94d504
commit: 52edddc18d9541ad72912b32edd74baacc94d504 mm,hugetlb: remove mlock ulimit for SHM_HUGETLB
config: i386-randconfig-m021-20211101 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/hugetlbfs/inode.c:1467 hugetlb_file_setup() error: potentially dereferencing uninitialized 'ucounts'.

Old smatch warnings:
fs/hugetlbfs/inode.c:1498 hugetlb_file_setup() error: potentially dereferencing uninitialized 'ucounts'.

vim +/ucounts +1467 fs/hugetlbfs/inode.c

af73e4d9506d3b Naoya Horiguchi        2013-05-07  1448  struct file *hugetlb_file_setup(const char *name, size_t size,
52edddc18d9541 zhangyiru              2021-11-01  1449  				vm_flags_t acctflag, int creat_flags,
52edddc18d9541 zhangyiru              2021-11-01  1450  				int page_size_log)
^1da177e4c3f41 Linus Torvalds         2005-04-16  1451  {
^1da177e4c3f41 Linus Torvalds         2005-04-16  1452  	struct inode *inode;
e68375c850b0d5 Al Viro                2018-06-09  1453  	struct vfsmount *mnt;
42d7395feb56f0 Andi Kleen             2012-12-11  1454  	int hstate_idx;
e68375c850b0d5 Al Viro                2018-06-09  1455  	struct file *file;
52edddc18d9541 zhangyiru              2021-11-01  1456  	struct ucounts **ucounts;
                                                                               ^^^^^^^^^^

42d7395feb56f0 Andi Kleen             2012-12-11  1457  
42d7395feb56f0 Andi Kleen             2012-12-11  1458  	hstate_idx = get_hstate_idx(page_size_log);
42d7395feb56f0 Andi Kleen             2012-12-11  1459  	if (hstate_idx < 0)
42d7395feb56f0 Andi Kleen             2012-12-11  1460  		return ERR_PTR(-ENODEV);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1461  
e68375c850b0d5 Al Viro                2018-06-09  1462  	mnt = hugetlbfs_vfsmount[hstate_idx];
e68375c850b0d5 Al Viro                2018-06-09  1463  	if (!mnt)
5bc98594d59672 Akinobu Mita           2007-05-06  1464  		return ERR_PTR(-ENOENT);
5bc98594d59672 Akinobu Mita           2007-05-06  1465  
ef1ff6b8c08954 From: Mel Gorman       2009-09-23  1466  	if (creat_flags == HUGETLB_SHMFS_INODE && !can_do_hugetlb_shm()) {
d7c9e99aee48e6 Alexey Gladkov         2021-04-22 @1467  		*ucounts = current_ucounts();
                                                                        ^^^^^^^^^
Uninitialized.



d7c9e99aee48e6 Alexey Gladkov         2021-04-22  1468  		if (user_shm_lock(size, *ucounts)) {
9b857d26d08f00 Andrew Morton          2014-06-04  1469  			pr_warn_once("%s (%d): Using mlock ulimits for SHM_HUGETLB is deprecated\n",
21a3c273f88c9c David Rientjes         2012-03-21  1470  				current->comm, current->pid);
52edddc18d9541 zhangyiru              2021-11-01  1471  			user_shm_unlock(size, *ucounts);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1472  			return ERR_PTR(-EPERM);
2584e517320bd4 Ravikiran G Thirumalai 2009-03-31  1473  		}
353d5c30c66658 Hugh Dickins           2009-08-24  1474  	}
^1da177e4c3f41 Linus Torvalds         2005-04-16  1475  
39b65252745745 Anatol Pomozov         2012-09-12  1476  	file = ERR_PTR(-ENOSPC);
e68375c850b0d5 Al Viro                2018-06-09  1477  	inode = hugetlbfs_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1478  	if (!inode)
e68375c850b0d5 Al Viro                2018-06-09  1479  		goto out;
e1832f2923ec92 Stephen Smalley        2015-08-06  1480  	if (creat_flags == HUGETLB_SHMFS_INODE)
e1832f2923ec92 Stephen Smalley        2015-08-06  1481  		inode->i_flags |= S_PRIVATE;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1482  
^1da177e4c3f41 Linus Torvalds         2005-04-16  1483  	inode->i_size = size;
6d6b77f163c7ea Miklos Szeredi         2011-10-28  1484  	clear_nlink(inode);
ce8d2cdf3d2b73 Dave Hansen            2007-10-16  1485  
33b8f84a4ee784 Mike Kravetz           2021-02-24  1486  	if (!hugetlb_reserve_pages(inode, 0,
e68375c850b0d5 Al Viro                2018-06-09  1487  			size >> huge_page_shift(hstate_inode(inode)), NULL,
e68375c850b0d5 Al Viro                2018-06-09  1488  			acctflag))
e68375c850b0d5 Al Viro                2018-06-09  1489  		file = ERR_PTR(-ENOMEM);
e68375c850b0d5 Al Viro                2018-06-09  1490  	else
e68375c850b0d5 Al Viro                2018-06-09  1491  		file = alloc_file_pseudo(inode, mnt, name, O_RDWR,
ce8d2cdf3d2b73 Dave Hansen            2007-10-16  1492  					&hugetlbfs_file_operations);
e68375c850b0d5 Al Viro                2018-06-09  1493  	if (!IS_ERR(file))
^1da177e4c3f41 Linus Torvalds         2005-04-16  1494  		return file;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1495  
b45b5bd65f668a David Gibson           2006-03-22  1496  	iput(inode);
e68375c850b0d5 Al Viro                2018-06-09  1497  out:
d7c9e99aee48e6 Alexey Gladkov         2021-04-22  1498  	if (*ucounts) {
d7c9e99aee48e6 Alexey Gladkov         2021-04-22  1499  		user_shm_unlock(size, *ucounts);
d7c9e99aee48e6 Alexey Gladkov         2021-04-22  1500  		*ucounts = NULL;
353d5c30c66658 Hugh Dickins           2009-08-24  1501  	}
39b65252745745 Anatol Pomozov         2012-09-12  1502  	return file;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1503  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

