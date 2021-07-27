Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263763D725F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhG0Jwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:52:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35162 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235950AbhG0JwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:52:19 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16R9qCQF009826;
        Tue, 27 Jul 2021 09:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=VYHmvBGMe8nq6Mi7BqXuwklb6AfQ7wD2oOvAFKzJoPk=;
 b=Ci/qeOhUYDW9XZxTvBF+8ls5J9tLGn4cTAtOZL2nNbE/ssyOOh2f1uNz2JAto4DOX1Lt
 D16DH5631Q5KDoLb1JGdOjKjfCw42CREOCZXHUDrYff6qBQ0jKs7fONRCQE/ucnCKJ69
 LOjsNbY9+yGo0yOD6QSktD3JJjAfP8tKMvAjMlz0BI0SbdzhtXbba7syZCF8kymobTfg
 Q6iJv37+n6l/DDMbDE+lHy598V91wTImt6NqmXLXj0HaHyQ6cq+VCB1Awg2wQLf33eaX
 aTcywAN+0/JiTqHfdYlq1Kxefcb89yptlfgW4pTuOpJ8xNftGoYYuHhIa48VVvCbWXGR Dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=VYHmvBGMe8nq6Mi7BqXuwklb6AfQ7wD2oOvAFKzJoPk=;
 b=iuLrO87U0+Q54jt/2oLU+2AscDqIWqCI00VExaRDZUEJdHbwITohymdymYCY55tflxk/
 i14xYcXoI5mJPxx2yU7Kx5vAT5KVQQ9l0PVhd58YwBvFwr1iBDiWPPR65T7pQfuM5mJk
 ZB01Wf8W1PG6zVvIj+1iaih75QYIl86LTOkF6gdEJPqeGYoUnzr8htIHIbMVh7d2ysLc
 xL//U0MOWlxwqAfCLLwCqwjkWiISi3IFX8pfPhAUUoLS1RehG/rZR/EtKUvWbFDvMdTF
 256telzahfeNtfoQkJBO8/Ep8juOOmexvJNnax5qAJf+dmLRdTd0v62cGTGnzkS+a6d3 RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a235dsbaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 09:52:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16R9pfTb025630;
        Tue, 27 Jul 2021 09:52:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 3a234a454u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 09:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5dbukt0j2GxVRUSsskouQX4EMFi61vCQAuMt8N4ZS2jH9J9TbrSO3z/iUqyYd+ITvail/fanVMeXrBU1waobizqHZQVHEnhHqB+RN+ZC4rYujNYAE/tQZnk3eezHZPd9I8IFzQH8KTypNW8Drj2xMXOF+uoT4lQgtmH5u2CLF9EEGpYElTK++S7jWrwB9zq9CJTrnQh/lvckFm2mB7Ye9WeZlgu01ESCAl4o7lKzHYC745PxRC6EbxvJg0MpjtMDAwiS8Cqjtre6nQSPypBxFPyktHsMoH/YSnRQYp/utsNu8cbbbmW+KrodRSEbnCezMXlcdpzOZ83UqNQf2zcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYHmvBGMe8nq6Mi7BqXuwklb6AfQ7wD2oOvAFKzJoPk=;
 b=KWJ9/Xdj5b04DfDuzHRCjz8eGug9maCIPN2kBkjoX0bbeh9G12Gp0Pq4+nPxvEHm2eCYAKpVYVqX/zBTE0qYuf8whfs4p5td/O51aHTION/8/xyJnvwBmIN8h5piXam5Xso3WTO7Qxn1hlog55VBNPSxIlR2b2Hl5gWLEICTimGE5s0AFqHbjaeGiJD6k6lwCRplvkVcoz6T0C+g3RzCEh0mSEdM6uMa4hLclxSXlABlYUA2X6Fro//bR3BiIIHV1IUvT34586Om3NtOlqs9j7ZXr4KK6njXGQumMdrKFn7OJOr791qJLFupIIKn49bDWHJItlg46Sdw92rFl1DL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYHmvBGMe8nq6Mi7BqXuwklb6AfQ7wD2oOvAFKzJoPk=;
 b=Zys6irqrzrJECyWBXEJUPyVw8QB0GgH42EjmKaRmliEa61QYYQ9VmayP7HsHk2GV45miMK8Pal38SE7RgdZYif4MkZGVb6x9FHXWvHSGnLPtbBlxJoZa2rRhkSOfZe4kP/H9fUzUm8acz/+YUet0eqQLWMRt+y5w2gypsXrffZg=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2093.namprd10.prod.outlook.com
 (2603:10b6:301:36::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 09:52:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 09:52:06 +0000
Date:   Tue, 27 Jul 2021 12:51:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Andreas Gruenbacher <agruenba@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [gfs2:for-next.mmap-fault 6/9] fs/iomap/direct-io.c:134
 iomap_dio_complete() error: dereferencing freed memory 'dio'
Message-ID: <202107270528.U5UdYp9I-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Tue, 27 Jul 2021 09:52:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c45f78bc-cec9-4714-d87a-08d950e4316c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20934FB435AAB59F5E7532CF8EE99@MWHPR1001MB2093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFHhIJZqNqvZaA89atXiaQbRhAFXwgeFPlm3teUZlusKQsbKg3xsi3zLhW7+VnE+Sg+Nco+9pfdbtO2sEqLyuFeedXdRU4R4eIRpzfHxZUYWCKr75vnUUu70k6pEF1T7ernemVzgaORIX3lMeDSD8/bCLMpWLcuLJEwpkmMNMkGrZzN1VJbORTFTfd9tVchSX8yLLV4AgcOftnXxaKjmpEEwWAJoyE3j/M5W9jzI/c9vfVRJdzivLKqX4gQF2TyUvF1/K97L7+GeO0P5Pbd7KgJO8fibdx8ImEud+noyGVQZS0FmvHtSUQXi2wPtGCtWLKHQytBpqUJhoIU+XJ/ncKlZLbapMRxxgkeIj+V3s5PwdYeLfuioWl5cvZB8yft912Bf4RZo6n0cQR8BdaaE/Htt6F9yx9He2yr1LMLiA6tpKObX8zKfN03Opmj2DugwA4cr8QCaABZMdWaaPk8m5D6GSQoQlfwd6/u+6IZ2aAjeCK2jHEuXXgUJYg9bidp5QJcrqGifZU1tX6YgLCxPlHIdPCm+kAKRa6lHfGfnTwT2H6A+xlQ17yWknCyshkJuNCbbxx6P8mDBtKFhRtLteSgGFHKKihWF3oJp6nPWJl3S1CTK5yTQ7JDXjNionfBVjy0onEne3JLHRnYLINZC/1y0tTtv7bRPFWduj5XedpSo2Va2LTNbX9RzzsCsE8zuDmpkB/EBW+saKGyELUuXQplZn6iJ1z/6Ax5bUTP5F1y4i8yy4cJ0vBrsAdei6OWbANMTtZgMWVyfYF7WMTw1L26/T5kiV/l7ICMDfqu1N+7xH7dUUb/D0PgoVABXS5IiFqJTFPoLtBj0p6aVjtbFJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(39860400002)(376002)(83380400001)(36756003)(44832011)(5660300002)(2906002)(52116002)(6666004)(6496006)(6916009)(38350700002)(186003)(38100700002)(1076003)(26005)(966005)(8676002)(4326008)(9686003)(8936002)(66946007)(6486002)(66476007)(316002)(66556008)(956004)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A2+/EvFhBUskdMAUz9b2h9jBbPqnb8EAolOxvRomqzVBC1fFcvBCzurGfjrZ?=
 =?us-ascii?Q?fP4y6Vlb4XC1dkh//RuAkDe7Pku+DhXuMjAbb/L15puzYN8f3zPBHPb/74TT?=
 =?us-ascii?Q?MTf+J5CbY1pGhbTPFtgV4s3FiI/KWcdmSki6F+sjwD5aD2Ctn5PK4q5LUxC/?=
 =?us-ascii?Q?G86yPzITLnPbk3JWKWxdTTeNjbTYqpQBcvVm4P3YYiHeCP6E0lbkhEcEM/Rd?=
 =?us-ascii?Q?QmzMvpBp2ioKX5Unt8sXkqaVSx2Imit/da1LeAJeAOIzKFCi9Wdcp7UMsQks?=
 =?us-ascii?Q?jbpV0ti6GUxylAcvNz3p+fOmkQgJgpjdN+i0sxlY0o4T6mB36F2CrygnRZnG?=
 =?us-ascii?Q?e2jmu6lPPBmWz7cGLBUBhXKkLJ5w9Z54BOAygKD1gj6vjSYYFWd75NIOeIxY?=
 =?us-ascii?Q?AdC0Z+0D1f1qqRTO/rFDWTQM0181tWNP871VkIrt2bND7yQVCwdxo7NDvm5o?=
 =?us-ascii?Q?8iXpsCA/ACq+dOGrrHocE8unVMce+LNOqtjUk/CoMdY1akSi1Yh2JaUcQ8+U?=
 =?us-ascii?Q?AUuRfUGCMdAve3THZsIss4asl7iMxclKA5vR3OcLW4jsPjWWxi9f3Fb3EBUF?=
 =?us-ascii?Q?h83HpZjJSrlOO1zT9SLhVKD4oQroSuPHZwnHLt2hK3I3QbGW4K2mRCvW2Pmc?=
 =?us-ascii?Q?O8lPG+tZ2Tm3+L9vWm3NLAlMGVO/D5ZYADZwwIUWVPuapXmAE5lhpfc+xGh0?=
 =?us-ascii?Q?wXCsRvx3lnXoCMfNdwOcq6CizCQrYICWskOxNSif118PBBQR8RdTYHzNfcEF?=
 =?us-ascii?Q?oWLMVmdASlacvithGJngNWzK4Vddl3XHPBqeWDdlTm91C9qwIj8WqKRyaSnE?=
 =?us-ascii?Q?yG0YVFatyeC/YwRE6kAscd18iYr00dwM/1O+X67Vsd6PBsqo6vJjxPqxcRu7?=
 =?us-ascii?Q?KMyzWAos0BP73H8pbbPtSloSj56IYD9RlXhT2khBgQvtsIipcVodE6MyG5IT?=
 =?us-ascii?Q?Mu7OMxZ6AjHMMHTfEemRIu9Wk6ai3FH/YKobxFOtmD32YAURAuXEPvSrAZ2e?=
 =?us-ascii?Q?mOvLL9tWKGkpFsIR0O/PPjWpRxhc+5CTjVX58OQ4nBzfppERQW7jCXL1tEI9?=
 =?us-ascii?Q?GoFnsabYDkVWXQMCEFDYA0ljlAZvTLxtaOfyu8fzO0fo86BlsQA/sW6p6llv?=
 =?us-ascii?Q?wQbZBg8dOWgC4XEQ1H1CR/gNdebJzl86vZBgmeGmccpShp/5hzqUaiA1QqRZ?=
 =?us-ascii?Q?7L4us5fqBH8z6aSV3xi55RNvHgNSs3fdZdt3XaQljI/D08EFtxNuwJd6C9vB?=
 =?us-ascii?Q?9XRSwgw9UvUUhdSn89z/5NQz1YXad0Y/VJQ3UZhKKz7vQ9A5FGueIWt+nKYT?=
 =?us-ascii?Q?Je38VMVUgLpGTmwosHU2oIN4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45f78bc-cec9-4714-d87a-08d950e4316c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 09:52:06.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30iI+u9qKyoApYGxwDbWthbs5Q/4egGbOdk1tT26CbmQw8Dzr7b1/1ecobqVZwhP6DKPOFQw9nRQd7ZDzq0Z9JqXdTR8SRaVqKIrs3i7Vs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270057
X-Proofpoint-GUID: nRpoq9RdipnqerhX_XQRJEo8WAMLGSPS
X-Proofpoint-ORIG-GUID: nRpoq9RdipnqerhX_XQRJEo8WAMLGSPS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next.mmap-fault
head:   1e32783802dce0f79d3b25e800ac86bd24512e10
commit: cbbd26b20cafc8f40d495be172ba807dc260845c [6/9] iomap: Add done_before argument to iomap_dio_rw
config: x86_64-randconfig-m001-20210726 (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/iomap/direct-io.c:134 iomap_dio_complete() error: dereferencing freed memory 'dio'

vim +/dio +134 fs/iomap/direct-io.c

c3d4ed1abecfcf Christoph Hellwig   2020-09-28   80  ssize_t iomap_dio_complete(struct iomap_dio *dio)
db074436f42196 Darrick J. Wong     2019-07-15   81  {
838c4f3d7515ef Christoph Hellwig   2019-09-19   82  	const struct iomap_dio_ops *dops = dio->dops;
db074436f42196 Darrick J. Wong     2019-07-15   83  	struct kiocb *iocb = dio->iocb;
db074436f42196 Darrick J. Wong     2019-07-15   84  	struct inode *inode = file_inode(iocb->ki_filp);
db074436f42196 Darrick J. Wong     2019-07-15   85  	loff_t offset = iocb->ki_pos;
838c4f3d7515ef Christoph Hellwig   2019-09-19   86  	ssize_t ret = dio->error;
db074436f42196 Darrick J. Wong     2019-07-15   87  
838c4f3d7515ef Christoph Hellwig   2019-09-19   88  	if (dops && dops->end_io)
838c4f3d7515ef Christoph Hellwig   2019-09-19   89  		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
db074436f42196 Darrick J. Wong     2019-07-15   90  
db074436f42196 Darrick J. Wong     2019-07-15   91  	if (likely(!ret)) {
db074436f42196 Darrick J. Wong     2019-07-15   92  		ret = dio->size;
db074436f42196 Darrick J. Wong     2019-07-15   93  		/* check for short read */
db074436f42196 Darrick J. Wong     2019-07-15   94  		if (offset + ret > dio->i_size &&
db074436f42196 Darrick J. Wong     2019-07-15   95  		    !(dio->flags & IOMAP_DIO_WRITE))
db074436f42196 Darrick J. Wong     2019-07-15   96  			ret = dio->i_size - offset;
db074436f42196 Darrick J. Wong     2019-07-15   97  		iocb->ki_pos += ret;
db074436f42196 Darrick J. Wong     2019-07-15   98  	}
db074436f42196 Darrick J. Wong     2019-07-15   99  
db074436f42196 Darrick J. Wong     2019-07-15  100  	/*
db074436f42196 Darrick J. Wong     2019-07-15  101  	 * Try again to invalidate clean pages which might have been cached by
db074436f42196 Darrick J. Wong     2019-07-15  102  	 * non-direct readahead, or faulted in by get_user_pages() if the source
db074436f42196 Darrick J. Wong     2019-07-15  103  	 * of the write was an mmap'ed region of the file we're writing.  Either
db074436f42196 Darrick J. Wong     2019-07-15  104  	 * one is a pretty crazy thing to do, so we don't support it 100%.  If
db074436f42196 Darrick J. Wong     2019-07-15  105  	 * this invalidation fails, tough, the write still worked...
db074436f42196 Darrick J. Wong     2019-07-15  106  	 *
838c4f3d7515ef Christoph Hellwig   2019-09-19  107  	 * And this page cache invalidation has to be after ->end_io(), as some
838c4f3d7515ef Christoph Hellwig   2019-09-19  108  	 * filesystems convert unwritten extents to real allocations in
838c4f3d7515ef Christoph Hellwig   2019-09-19  109  	 * ->end_io() when necessary, otherwise a racing buffer read would cache
db074436f42196 Darrick J. Wong     2019-07-15  110  	 * zeros from unwritten extents.
db074436f42196 Darrick J. Wong     2019-07-15  111  	 */
c114bbc6c423a4 Andreas Gruenbacher 2020-09-10  112  	if (!dio->error && dio->size &&
db074436f42196 Darrick J. Wong     2019-07-15  113  	    (dio->flags & IOMAP_DIO_WRITE) && inode->i_mapping->nrpages) {
db074436f42196 Darrick J. Wong     2019-07-15  114  		int err;
db074436f42196 Darrick J. Wong     2019-07-15  115  		err = invalidate_inode_pages2_range(inode->i_mapping,
db074436f42196 Darrick J. Wong     2019-07-15  116  				offset >> PAGE_SHIFT,
db074436f42196 Darrick J. Wong     2019-07-15  117  				(offset + dio->size - 1) >> PAGE_SHIFT);
db074436f42196 Darrick J. Wong     2019-07-15  118  		if (err)
db074436f42196 Darrick J. Wong     2019-07-15  119  			dio_warn_stale_pagecache(iocb->ki_filp);
db074436f42196 Darrick J. Wong     2019-07-15  120  	}
db074436f42196 Darrick J. Wong     2019-07-15  121  
1a31182edd0083 Goldwyn Rodrigues   2020-09-28  122  	inode_dio_end(file_inode(iocb->ki_filp));
db074436f42196 Darrick J. Wong     2019-07-15  123  	/*
db074436f42196 Darrick J. Wong     2019-07-15  124  	 * If this is a DSYNC write, make sure we push it to stable storage now
db074436f42196 Darrick J. Wong     2019-07-15  125  	 * that we've written data.
db074436f42196 Darrick J. Wong     2019-07-15  126  	 */
db074436f42196 Darrick J. Wong     2019-07-15  127  	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
db074436f42196 Darrick J. Wong     2019-07-15  128  		ret = generic_write_sync(iocb, ret);
db074436f42196 Darrick J. Wong     2019-07-15  129  
db074436f42196 Darrick J. Wong     2019-07-15  130  	kfree(dio);
                                                        ^^^^^^^^^^
free

db074436f42196 Darrick J. Wong     2019-07-15  131  
cbbd26b20cafc8 Andreas Gruenbacher 2021-07-24  132  	if (ret < 0)
db074436f42196 Darrick J. Wong     2019-07-15  133  		return ret;
cbbd26b20cafc8 Andreas Gruenbacher 2021-07-24 @134  	return dio->done_before + ret;
                                                               ^^^^^^^^^^^^^^^^
use after free

db074436f42196 Darrick J. Wong     2019-07-15  135  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

