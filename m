Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FEA44BC31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 08:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhKJHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 02:41:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhKJHlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:41:35 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA77Mtj028340;
        Wed, 10 Nov 2021 07:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1gymEY5k1LP7W8nZuRWnG2oh80ByoOoo3/36gF46IWY=;
 b=QqpgpGLXSUENcrJ3sSv63TjHS3MpuFlsuNnElLE6jxOUa9aP8MlirdNokIamANvxw+1p
 6czJ7qamvKvumTnzDPuS5F8YPupBEdHcvigBBmShLtRk8OknK6m77wpRyfFwtEtJpqNt
 9Yx1AUY98HtbfRrSvK+mVEPyvj+vk+UmpZhrSIvnf17i3Ie+2Jo1D2Q9ZMQ+bR/MQw9A
 4pmhkqUFup0hG4RIuECQBwK68PLBEpqyi1+98dIaOPlEw8VfnxpG1RKE6FbkUybJeN4Q
 +/KW+OieEGS3Be3GC4ztcdedFoSHKKzoEgAVA7q9ESKDcnuq/62gHOFip0MTaHITUD1z eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c880rrjsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 07:38:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA7UJGT087914;
        Wed, 10 Nov 2021 07:38:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3020.oracle.com with ESMTP id 3c5hh4vweu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 07:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEqRxx/FCe5bvEhIgQQmLLINDtFGtgOWH3Cey8q6+KZ3zh3pK6wekOkPIUiMFFo8OzXpQUjkhsauzgPgnCUy3Of4NtRzoMQITyyr7bSzHeQLOP2c8ec2qHDUqnS2Rlm/dxO3IEL1sQL4GHsw3j/VMUyn/DNUAwZYJ4r+fqoAB631+Oqy/heR6oo+WvqpQP9aOwQT4KPpOcrp4B5paR8tNizl6BISKJI0K0ScvohRR0dqrFMEbxhy8gMYl1dgjOcfSaVVir4IHGbRJYmXIBi69Ni8dHz8+RobAKAUP8UqKHue78tLqFyNm7Qp6s3jzi9Hwv0sI7w3qfIexWh37BM6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gymEY5k1LP7W8nZuRWnG2oh80ByoOoo3/36gF46IWY=;
 b=PsjayfhqX98AL+z2pakWaR/TzPYjXQsxjND3q7rQMD/TXTcTNuaL54nNEE8+uHvQf/ETSrsMaP6X9Z9eEAEJpYRlkwxexF4qNEHRPiM0RcjYivKnnVBwqbh/eY6cAS4uNcmGVCwQtdZNggTH32HL5mj/lsfGxog++6ErJrOo297rAbSY4BxCfBe6CfIV760kDHGz4kTP6dWmqcBaTYQwla7jp6EJ/ltLi0iC2DbG1OMcoYUvxDFkVfXFtrggQD0TmMCmtmYsg85YyIu9Ww9dLH4tv8YDOHGi0YBdTCKWJ8/OKwpCIZR/Xlo9oBkPDhfNGxdrBxxVp+hNodDPftdeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gymEY5k1LP7W8nZuRWnG2oh80ByoOoo3/36gF46IWY=;
 b=iUc1SAjESfgSEUujvwnsEUf4Res/puRXSKs5B8ltdeQ8w5fMaWb34/46uGOC0ze3+sOv+LXVI1DrdputzxCfO0ieN9jpWkTf4q9Qwi1hYuPYuX3TjiZAGAT5ZneNcR9e3R1Hq0R0qqxl9nJWK3DY3dguzJyXAsxjIHQ8PjPo9Ds=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5789.namprd10.prod.outlook.com
 (2603:10b6:303:140::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 10 Nov
 2021 07:38:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 07:38:40 +0000
Date:   Wed, 10 Nov 2021 10:38:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:fscache-rewrite-indexing-2 50/64]
 fs/cachefiles/io.c:483 __cachefiles_prepare_write() error: uninitialized
 symbol 'ret'.
Message-ID: <202111100533.Qxw3LycR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 07:38:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14c0a403-a701-41b9-f30e-08d9a41d1d82
X-MS-TrafficTypeDiagnostic: CO6PR10MB5789:
X-Microsoft-Antispam-PRVS: <CO6PR10MB57898CFC3F2199FD3D00DC288E939@CO6PR10MB5789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZHNos76nTttUD5hV+m0qHUzgDZWfQyxMNmE/DoK+AF+jgCsZclhKAtHQpaHH5ZYhgkFru3Nf7ld7FYzc1xoErEw3iFBA5ukhzPKDPRwaWc/OtSPqfrAqJqSWNJqOvvEDLSp2AgPin2lLb+7DrCzkrf/Rb/5bgGk0ej7YtadendFC/13bVUXxZAjGaQPoVjl6vgJ/bfIENMODLZXJjs4JLgiZhrPNkhVIvXoDbdGjVCJeLPhAdqhmtFXeiA+e4sm19qmHf4Yr0di+5aEq3KfxQpGVE21hk13pVr93a2UAEWlfP0dRYg7SVLErtJLpzAaWIejqH9jDiZ9V/9QRaSVDijZpNW/xI4NZkgNJkEt/reSpWQI6JnPzfj75ouDlRSnqoo+Hf2G81tkXTSqy4ZgJgZTRRa5hf81yuHqgiRAKar/bywuh0s9LK4lECZ0C8kdY0ShIEnuk0S59HovEEVclEOJtCbhpa/cLQKM4ad8i8kwQhb2Nd7hhNFu8ThrUUe0/frIGrWoV1oXcZ+7bsWpH7S9q7/QsfSOoVN4vRJnanFdddypOS5pkUm4Owj1Ah0OUzTyJjjpRx+BkHYwr7OuprYsKwPnneqe6DxKquM3/AJOM0bKlMGZpai1NjbnAzSkzxJnGOgYDaej1028FFQLbOMToXqQDNbG1ADmOMcrIOnvcLoYTwBdzBNeElqMlkxcxTMjlW7LzKBfFh/9P8WwJBlzc69CCG/wN+YQMhRmPK+gKYHyc/hXIeRr0KfKrkVe9velUiRN0PC3g4/yHdONnx/jtckJfzIB1Rt0q1B4EifusilROgI4JM1J9xPaueqlxP5Qyb7l4NPjobzbPpORaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(186003)(26005)(956004)(6666004)(66946007)(66556008)(508600001)(8676002)(1076003)(4326008)(5660300002)(966005)(52116002)(86362001)(6916009)(316002)(2906002)(4001150100001)(6486002)(38100700002)(44832011)(6496006)(9686003)(38350700002)(8936002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zEmWViPRhAqxnks5TjGMnvzpqvn5tbZ5BKJim0JM9HMhtKG0rZQ2wvT6jAnM?=
 =?us-ascii?Q?2WDBUusnL9T6fUL/lfUIcg+d50d6OW5YZ7IxYEB8111YpP3egb8v8sNrzJBb?=
 =?us-ascii?Q?bdnRQN2UjDO79dpVfmsJeZ04BKbPWzj7x+Y79gzJanWta6+4EPZ8BWBSTtZY?=
 =?us-ascii?Q?vlWMphUH4FvGE1fpjY+Wyk9L2aQi9dAlTfvsu8ec/uQj+CW7ubCBzRIpSgHq?=
 =?us-ascii?Q?/GizCjWb4gtsZlAmHX+SKvJ9CUSNshJ8/ks4nuNRU+wYSMuXt5/oilpxilt9?=
 =?us-ascii?Q?X0o+e/pIB3wQXQguRQPSzfOmoRZvGd4ZKU+UoeYCc5sdNYXx/bNs277Wx+h+?=
 =?us-ascii?Q?cz2e+htKLKE27sm2UYld/L1CCtKq3bxg2u1bZrdYz2UPgtrLIDUlpsL5jYhq?=
 =?us-ascii?Q?zzik7jxSgS4AjKaB6RFGmCIkUFyW1jaMjMpzFWYl0qhIEff99jV6bOR//WER?=
 =?us-ascii?Q?F4IselrZWeZwsvPe/X8TVXePc4blbj4CwAjyRZOtPIbvIBKR94yfZ6BTLSZK?=
 =?us-ascii?Q?bDPmH8nM1X+O3Q7llvMxAd8ZKNTvkMvyKzneZoyl1NsBTirtwmYoRBDJ4puj?=
 =?us-ascii?Q?4M864qGwNc8GzSn1oCEoR7AfwZnr/DB+4agqtCWvl7GJV3umzqU5LB0RjQCn?=
 =?us-ascii?Q?XXqrIatiYQefdTBYmQ5uZhPLtW481zZ/CoMLy+gQ/Atpeezd32UFY4s8raIO?=
 =?us-ascii?Q?8XVt0S83AQx/9B73tEBfxKYbd/4hbqXYeGiqU8pfxMw/zru1tQ0NbRWFe3Zk?=
 =?us-ascii?Q?MTcmLk88KX7YIIVH3BEaIlgOqxGKjllucc5HsSo5p70tVnsAwVGZYs4PXA6k?=
 =?us-ascii?Q?PCg8vHUUWEtzGSkzVSVxkDEQjKdBf4S5ny+n5GU8X7ZwdBMN1AbLUArwqpot?=
 =?us-ascii?Q?pNWfAOBt5Pgo5i3tgH7XxkIVoYuBH7hR2ZNsOCn+z4r4NGIuOtjOYd2HcKqk?=
 =?us-ascii?Q?eGl7NvDzVlnsQHPB3dXjSRS/Sq5YT9lBHXLYQOMh4CGEAGfpFCQd8pdDeZig?=
 =?us-ascii?Q?HSAjVXOYwSZCMuUen7b+Od9dQQW9YAb/XVItjJ0EXTPXAiLIKqCs0EJKgYOQ?=
 =?us-ascii?Q?6Al0Q9IqoFclkgxflOS+GEsqtIdY3sAG6wJ+QzNql+/pYaFDEl9ytXMj6lVI?=
 =?us-ascii?Q?xPrkndLTijNWsPLWaXhFkQSvbtsutw77Ud+waaWTBmo6dvl3C5qk6r47reIE?=
 =?us-ascii?Q?zaIInh7TtsNoXTQmwfp/DgWsEjlfmCDQ7qUj0jsagFo9Tj2zfFkD5B1W5yRP?=
 =?us-ascii?Q?y58eJ0aRMMcLPF6RBjn/ULuWC4AbK32OQB0+flYtLhmuzNtEICkkitldnDU0?=
 =?us-ascii?Q?//mFx2x83wFOIXGOkdW4qrxQH6eNJUKmjRe1K7zE1o8XDXRDJQQGnAyaBvMp?=
 =?us-ascii?Q?GkMgCe/Zf5JWaIDOx+4NFUaNcJnTndd+KW0a0sL1YjhpOrEDfScXER5KIPj2?=
 =?us-ascii?Q?vC8ceFBLk95c1PHPyOs07d35P9I3UoeiKc50T7WmB4rkC9qP4TgIpcwg4biG?=
 =?us-ascii?Q?RW9eUC+NBm4CvcZxJXSPtXPCcT3vtJj00jBZdd9mjqusG6/dEcx9OdkF5l6h?=
 =?us-ascii?Q?LYfQ1F4q1xO7sNcdZlN4mXl3/t1w4/N5hoSLvXzmJcE5d85cLkyvnwhQEVw0?=
 =?us-ascii?Q?dDbqIaPwMS6OjEVL8SuTMs2jfNBo2kw6yCYCYrG1c2Yv/5SLYZ4loXpOUq0y?=
 =?us-ascii?Q?7q8lQ9MaPiwBD289luPOsMERI5s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c0a403-a701-41b9-f30e-08d9a41d1d82
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 07:38:40.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucPei+d5ERcnQlmyxvBhvRzokjSBA1NYZ3gkbsVyUqLu8lVnBoFrdLwXKkLhHWYCgWV2XOYe66dnKeK6iRGArCLejynzeJsADtxYB66RqGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100039
X-Proofpoint-GUID: 9vHD0ChBJe6dZMOn0kJVvrwJWrh4hDhr
X-Proofpoint-ORIG-GUID: 9vHD0ChBJe6dZMOn0kJVvrwJWrh4hDhr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-rewrite-indexing-2
head:   90bb44e5d6dcd202b7443fbe2dd1f71cd408b942
commit: 0cdb319c9ee8e62be3f3c395eabfd746515a8c9b [50/64] cachefiles: Implement the I/O routines
config: powerpc-randconfig-m031-20211101 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/cachefiles/io.c:483 __cachefiles_prepare_write() error: uninitialized symbol 'ret'.

vim +/ret +483 fs/cachefiles/io.c

0cdb319c9ee8e6 David Howells 2021-10-21  424  static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
0cdb319c9ee8e6 David Howells 2021-10-21  425  				      loff_t *_start, size_t *_len, loff_t i_size,
0cdb319c9ee8e6 David Howells 2021-10-21  426  				      bool no_space_allocated_yet)
0cdb319c9ee8e6 David Howells 2021-10-21  427  {
0cdb319c9ee8e6 David Howells 2021-10-21  428  	struct cachefiles_object *object = cachefiles_cres_object(cres);
0cdb319c9ee8e6 David Howells 2021-10-21  429  	struct cachefiles_cache *cache = object->volume->cache;
0cdb319c9ee8e6 David Howells 2021-10-21  430  	struct file *file = cachefiles_cres_file(cres);
0cdb319c9ee8e6 David Howells 2021-10-21  431  	loff_t start = *_start, pos;
0cdb319c9ee8e6 David Howells 2021-10-21  432  	size_t len = *_len, down;
0cdb319c9ee8e6 David Howells 2021-10-21  433  	int ret;
                                                ^^^^^^^^

0cdb319c9ee8e6 David Howells 2021-10-21  434  
0cdb319c9ee8e6 David Howells 2021-10-21  435  	/* Round to DIO size */
0cdb319c9ee8e6 David Howells 2021-10-21  436  	down = start - round_down(start, PAGE_SIZE);
0cdb319c9ee8e6 David Howells 2021-10-21  437  	*_start = start - down;
0cdb319c9ee8e6 David Howells 2021-10-21  438  	*_len = round_up(down + len, PAGE_SIZE);
0cdb319c9ee8e6 David Howells 2021-10-21  439  
0cdb319c9ee8e6 David Howells 2021-10-21  440  	/* We need to work out whether there's sufficient disk space to perform
0cdb319c9ee8e6 David Howells 2021-10-21  441  	 * the write - but we can skip that check if we have space already
0cdb319c9ee8e6 David Howells 2021-10-21  442  	 * allocated.
0cdb319c9ee8e6 David Howells 2021-10-21  443  	 */
0cdb319c9ee8e6 David Howells 2021-10-21  444  	if (no_space_allocated_yet)
0cdb319c9ee8e6 David Howells 2021-10-21  445  		goto check_space;
0cdb319c9ee8e6 David Howells 2021-10-21  446  
0cdb319c9ee8e6 David Howells 2021-10-21  447  	pos = cachefiles_inject_read_error();
0cdb319c9ee8e6 David Howells 2021-10-21  448  	if (pos == 0)
0cdb319c9ee8e6 David Howells 2021-10-21  449  		pos = vfs_llseek(file, *_start, SEEK_DATA);
0cdb319c9ee8e6 David Howells 2021-10-21  450  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
0cdb319c9ee8e6 David Howells 2021-10-21  451  		if (pos == -ENXIO)
0cdb319c9ee8e6 David Howells 2021-10-21  452  			goto check_space; /* Unallocated tail */
0cdb319c9ee8e6 David Howells 2021-10-21  453  		trace_cachefiles_io_error(object, file_inode(file), pos,
0cdb319c9ee8e6 David Howells 2021-10-21  454  					  cachefiles_trace_seek_error);
0cdb319c9ee8e6 David Howells 2021-10-21  455  		return pos;
0cdb319c9ee8e6 David Howells 2021-10-21  456  	}
0cdb319c9ee8e6 David Howells 2021-10-21  457  	if ((u64)pos >= (u64)*_start + *_len)
0cdb319c9ee8e6 David Howells 2021-10-21  458  		goto check_space; /* Unallocated region */
0cdb319c9ee8e6 David Howells 2021-10-21  459  
0cdb319c9ee8e6 David Howells 2021-10-21  460  	/* We have a block that's at least partially filled - if we're low on
0cdb319c9ee8e6 David Howells 2021-10-21  461  	 * space, we need to see if it's fully allocated.  If it's not, we may
0cdb319c9ee8e6 David Howells 2021-10-21  462  	 * want to cull it.
0cdb319c9ee8e6 David Howells 2021-10-21  463  	 */
0cdb319c9ee8e6 David Howells 2021-10-21  464  	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE) == 0)
0cdb319c9ee8e6 David Howells 2021-10-21  465  		return 0; /* Enough space to simply overwrite the whole block */
0cdb319c9ee8e6 David Howells 2021-10-21  466  
0cdb319c9ee8e6 David Howells 2021-10-21  467  	pos = cachefiles_inject_read_error();
0cdb319c9ee8e6 David Howells 2021-10-21  468  	if (pos == 0)
0cdb319c9ee8e6 David Howells 2021-10-21  469  		pos = vfs_llseek(file, *_start, SEEK_HOLE);
0cdb319c9ee8e6 David Howells 2021-10-21  470  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
0cdb319c9ee8e6 David Howells 2021-10-21  471  		trace_cachefiles_io_error(object, file_inode(file), pos,
0cdb319c9ee8e6 David Howells 2021-10-21  472  					  cachefiles_trace_seek_error);
0cdb319c9ee8e6 David Howells 2021-10-21  473  		return pos;
0cdb319c9ee8e6 David Howells 2021-10-21  474  	}
0cdb319c9ee8e6 David Howells 2021-10-21  475  	if ((u64)pos >= (u64)*_start + *_len)
0cdb319c9ee8e6 David Howells 2021-10-21  476  		return 0; /* Fully allocated */
0cdb319c9ee8e6 David Howells 2021-10-21  477  
0cdb319c9ee8e6 David Howells 2021-10-21  478  	/* Partially allocated, but insufficient space: cull. */
0cdb319c9ee8e6 David Howells 2021-10-21  479  	pos = cachefiles_inject_remove_error();
0cdb319c9ee8e6 David Howells 2021-10-21  480  	if (pos == 0)
0cdb319c9ee8e6 David Howells 2021-10-21  481  		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
0cdb319c9ee8e6 David Howells 2021-10-21  482  				    *_start, *_len);

"ret" not set on else path.

0cdb319c9ee8e6 David Howells 2021-10-21 @483  	if (ret < 0) {
0cdb319c9ee8e6 David Howells 2021-10-21  484  		trace_cachefiles_io_error(object, file_inode(file), ret,
0cdb319c9ee8e6 David Howells 2021-10-21  485  					  cachefiles_trace_fallocate_error);
0cdb319c9ee8e6 David Howells 2021-10-21  486  		cachefiles_io_error_obj(object,
0cdb319c9ee8e6 David Howells 2021-10-21  487  					"CacheFiles: fallocate failed (%d)\n", ret);
0cdb319c9ee8e6 David Howells 2021-10-21  488  		ret = -EIO;
0cdb319c9ee8e6 David Howells 2021-10-21  489  	}
0cdb319c9ee8e6 David Howells 2021-10-21  490  
0cdb319c9ee8e6 David Howells 2021-10-21  491  	return ret;
0cdb319c9ee8e6 David Howells 2021-10-21  492  
0cdb319c9ee8e6 David Howells 2021-10-21  493  check_space:
0cdb319c9ee8e6 David Howells 2021-10-21  494  	return cachefiles_has_space(cache, 0, *_len / PAGE_SIZE);
0cdb319c9ee8e6 David Howells 2021-10-21  495  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

