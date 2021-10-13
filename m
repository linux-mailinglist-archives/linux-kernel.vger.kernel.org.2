Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72FE42B8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbhJMHUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:20:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49478 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238375AbhJMHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:19:47 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D70UEq013092;
        Wed, 13 Oct 2021 07:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 in-reply-to : mime-version; s=corp-2021-07-09;
 bh=tsTjiCCREkmEoosMRzDdSa+aJlfAVUqN7lHkOaE+cTQ=;
 b=UGZFjB69Fsy4EeFTGaU8eyL4AqgMj9VZEh1Fj9Lusyvfxn/1kEqIojtEtplrtsju0ac/
 nEHwFmVhWbF35ICvvsQy10h1tKx6q5pt9YVloqiULfeIF1v+8BT9Nf/jS8n6ijcE3DGj
 fJg5+OFLP3IbOg0myl3tlazLjFEwMGsGrwulF29xTUAXtIDIxo5Nav3fua53QCRjEatH
 jVakuj1wbWLqvvytPmagetma/2J55vZcVTte41z1Q781P/z9BCv/N/NoylShRKkJNK5f
 sL6WJsSXV48mw1bvA5oTIgLCHDefPZmlLrP1IgYHDFLYgN0MkvwdpeSWsPH6Kx4KeQ0z FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbmsx5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:17:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D7ASbo004158;
        Wed, 13 Oct 2021 07:17:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3030.oracle.com with ESMTP id 3bkyxt0ach-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:17:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yex3CxdpoNeFXO4TxYh92W5LxnFtX1GwRAUMCAEQSKrjRMXVgjD8oOTSePD1hRXEjFc0D/5HUYIpUMTTeOp4PJDffoiUK+Oi5PoA7q6DWqtTX+NeA0kSSgLRYkEiMrxgHxdudnTCmIyXXrxAnL1Ha4poRl22xRppmRpTRygEPVv/V8/Zk4klZfzBIC8aWHYHWCDlQD++1WzoLQDpk52KT1YK30/CwTAFOpCe7zz4D8Tin6U2oqkhdqA49FPj8eB6m0zJJgg4y8fxhA7pTqhrNgLIBESaKEgJk2CbMXkqjwzXz3100XsItb5nJ+WiHbjPYEPAlyyRQ1v5vslOgqTXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsTjiCCREkmEoosMRzDdSa+aJlfAVUqN7lHkOaE+cTQ=;
 b=N69nw9Eixl5bHxB9Ctu9HTjqYIm8Z8JpHyV5Jwe6GMWLyK28JWI0QPjD/jrWFqpSwhC3tHR3EV1GCJ7MXJwFFt9/ikl7JpjJwv1ZRPGFVWnvIMgHzrF2BIcUXvtpKebxLZ2OKADe3zxqlnAANRnvfHi7PEjkYj+wv5QDZOs8zbOthmEQbdvLqUEG6qNNOS+7OrSFJacKwQZdv/uzgirNvxlcF2Yxm9zSvTITjrK7KDimud41guKO0PwdUEzfJpyhOI+/Dj7tyIqk9YMtPJUS22v2upsj4VcbXwMH+gUD2+amfwqI9q0kJOnCFJE9rWzqDhnop3MsPWare5oDUdfDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsTjiCCREkmEoosMRzDdSa+aJlfAVUqN7lHkOaE+cTQ=;
 b=REdsuVsCMgHFjMJT7fmaTrhZMQa4ICpta+4VkWWT1GHNZZ8IKOOkTwqz72JO8BEEBreKK7lXa0aKIboCCaacfxdLL0wjAhLPQXHeabraRnpSPsQfrmSD57JqTcQ2EBnQjtZjsx6us502WAQBfQYPW2feijvRASP6Oyl+cq2km6s=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2256.namprd10.prod.outlook.com
 (2603:10b6:301:31::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 07:16:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.027; Wed, 13 Oct 2021
 07:16:58 +0000
Date:   Wed, 13 Oct 2021 10:16:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Richard Guy Briggs <rgb@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>, paul@paul-moore.com,
        eparis@redhat.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next] audit: return early if the rule has a lower
 priority
Message-ID: <202110130344.odiZFWOO-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012013240.63072-1-cuigaosheng1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 07:16:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a32a4e-9d08-4634-cb98-08d98e19719e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22568A27D7631B57BA8B5ED98EB79@MWHPR1001MB2256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buPhduQJDxoKQAz+4IN66FHx+/CF/2x8cvt/lr47amcAdXP2Fur95emfcpGhcXopMZb8TX6VurQgfDZV8EC5MFiH9jaRc9AD4KxGjV//hmnXlg2w6+d2ZjBgOUQ28Peu0rqCyVaBUMTSGo8Qe4Yq7lmBPveonsWynbywzYlqztfNESmUhRsUxRKp4UvfSt1yk1IXAdK+m2z4KY/Actwm/18BbmoXsnVAtM2kSUoC0DuuTox+C/XmWu20V9JaYU/VUo+HXPqjZelbv8UvTYAt67GCkks8TALZgU6UzEzeATBkvXGITnxCvG7AmhmEqoet+7uC2fU5erSsSTEeMYXrSKalVmBLrChNa5iSS3T403gD2yTBM9ohbZr9Jm2MFGuLxXhusHj4VOUjH4/COwCL6Ppzdf4tvRMG/8Qq0r56wEgcesWNtbTDNHXIJJ5lmomDilHSYKN+cehC0ie/rWXjMApzVKDMlGVrM2DyeL028DCERhqMildAQTEE7Y4JqVjME2MUTrKD+bSM/EAxXzGxq1dhw9W1mRLNb3F7jfLFt7IAl+03GRVwI4kBnMvpAR3UpCkXsUdvhM1/1lAbFQb5UJLnHEHC/EBfIvfCJ8/0NUihndd631LhQfLDredwX5OMZ6hgSHJwSA+b/VHoFbeLhpl9pjXnizsMHEz7DYo623mgJMPtcKM2knzIfBPCHlA2mBQh6xeK3PQ/Y/iCblA3uJmvUD57aJYfLWBmaC7LsanrpNfJ4aATTXbhivPgKzSlO5Q2a9l/HCcNttkmFL3Iin4VFYrQQcFyHsHSwuVN5/PhnfUk+Wew9nClgQl6SYdanFm6Kp9UyWvNcmZdACX61w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(508600001)(66946007)(956004)(66556008)(83380400001)(2906002)(4001150100001)(52116002)(9686003)(30864003)(6486002)(6496006)(7416002)(36756003)(966005)(1076003)(5660300002)(186003)(86362001)(8676002)(38350700002)(44832011)(38100700002)(4326008)(316002)(6666004)(26005)(110136005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzFBN1kzK1dKTW5oeGtOMVF2N1BXZXdhaUR3WWltbHJtWUxWRkxDc3JiRU1H?=
 =?utf-8?B?amxuZUlSMGpWcWxIR0dobDUweVBHV0ZtZGVTYkJZeHRoSWY3bUZkQ3E0aVFX?=
 =?utf-8?B?VUZFVmY3SWVmd01tTDZPOXhSYnplb2d1d2JFTUlYN0pnSWQvZVA1WDk2SHNq?=
 =?utf-8?B?dTJwaXpHcHFPVnVHS0tVTmkrNTZlK3pVU0N1UExkbkxhQ0hpZ2liM1QxczE1?=
 =?utf-8?B?S0RpR1pCVWIyTjk0Rnd0ZWZyWHFnOVdONVBpT1B1ZWdPcnBKbmNmZHZqV21W?=
 =?utf-8?B?SDBvNndZeDRBV0FtZFRXTVZrY1luSXNPK01DeE8zVzVwNFI3ZmRlVzA2bUVv?=
 =?utf-8?B?d0NKSmVFcmFaWnIrcVYxMWdhWEtvM1VHZkZ5SUdYaFpydnVHeHdKNXNtTU4v?=
 =?utf-8?B?QmJCZGtnK0RrNnBJdjdJWCs4M3RiT1JwNkdRQ1J6LzJWNG9wT3p3RUZHcFp3?=
 =?utf-8?B?WUQwTWo1QnAyMnloc1B0WnpqUzlGUFllYzM2Qnc5SkNzYkdqdUx5VnhBVDZx?=
 =?utf-8?B?am5lejcza0R4RTZ4SnoyVHY3R0QxWGROcGRlSnVHaUUyR1k5TDlUZjVva1E3?=
 =?utf-8?B?Z2NyM0pQN2JvMFlmQUZDU0hlRnVOaDJhVUtxYWJZdTFBck0rM0Z1UUREQm1o?=
 =?utf-8?B?cDluRXJyR1RGdCtUN0taU0FoNFQ1akVjRkZXeFV5SnQrZGNwdXNERFUvNDRH?=
 =?utf-8?B?cVNsYXpBS2hyZXRvcG9wb2JjQzNvQmJCUTRWYXZrYzVxK2hOUUx1YlBNSkhj?=
 =?utf-8?B?N3E2YnZCL3AvRktuajZQbllZejUwTTVyNGl0M3QvOHlzWXlqYnhGQ0l1R2th?=
 =?utf-8?B?MG1OR0F5a2lQUlgyMGgvcEpBV1VPUW12TnZQR1V2L0FOUDhMTHNVWDNETTdh?=
 =?utf-8?B?VjdHVWxNdXdENGxzUjljWTNFT1dLZTJIZ2NiU1dQcExZTW02RUxrMkk5aTNY?=
 =?utf-8?B?YkZxUWx1cFp5WFAxdm1wUXc1YzlMOEpZcjdiOTJnOEVFMG5qRE9HK3Z0MktC?=
 =?utf-8?B?YUF4OFpZbmFackY4dHk4UThSVFZoUXRmSmp5KzMvNW9lOEtBaFkvWGd2bmp6?=
 =?utf-8?B?UGN1N0txV1JkdDNSYjJSMHVuR2UvTUJmdU1aN1V1SE5yRUgvZVB6Q01PVVFr?=
 =?utf-8?B?dTIyOTBpbTN0WXN2YnJ2aE0vRjJiOW92NFgwMXRiQnpzSzU0WDRHUUtCd2Fi?=
 =?utf-8?B?VTJla2hjSkUzM1pWbjloTU4xT2czTFhmU3FWc3NiVUN0bHdmczl5bmhidmk3?=
 =?utf-8?B?N0QwYUxIcU5CTE9SN1NzQmVFd1hUWjdQbWl6dTgxcjdENnRuRjh4WFNDbEpm?=
 =?utf-8?B?TG1DdWZ4ME1LM0trcGlRVUxVRXVXaFh1Y3VnVlBabUQrZ1VvcFQrcitMTXY1?=
 =?utf-8?B?V3JSWHJmZEY5YnRRck1mdWJOczdVMWp2TFNIWVJXS0VaWktvckFJdThpZkxa?=
 =?utf-8?B?ajhsZnhhU1RNTnVoMld2bnowVTh1TU9Ba3dzVFN1MDFHSTFnK2lKb29naDFi?=
 =?utf-8?B?MEFXMzRzR2xkVDh5Z0w0b2pxTHIrOGx4L0JRcmlhbmc2eEdmRlVoMjhhTUFq?=
 =?utf-8?B?cmJnQ0hhendJMURWcWlvKytTdUdPY3B4bDJ1cGN5TGZWazU5L0xOdXo2SzNt?=
 =?utf-8?B?UDFyQ2hSLy9POHRoTFI5SEFkaXA5ZSt5VWZRc3R2cTlaelpyNzJkYTVWUGdh?=
 =?utf-8?B?bGJHSzluMENlK1hBNVpLR1lBWjZYSE83ZkRQV0hKV3RGWG93eFNzTld6SGZr?=
 =?utf-8?Q?hA9PFhUMgv7Xr+leDElQso5IOgC14lQmVY7eayo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a32a4e-9d08-4634-cb98-08d98e19719e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:16:58.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJxloD1Atww5yE5UCgdax+ShswJIosYdOlE0f/49GxkIoB24VVDAKr4YcO76avje1mSuDd9ByQrPc3gM7a1CtzrnPKp8BTWOUeIu/1VaI8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2256
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130048
X-Proofpoint-ORIG-GUID: w1t0q2A6UARTpYc1veWY_bmrFKbrEpk5
X-Proofpoint-GUID: w1t0q2A6UARTpYc1veWY_bmrFKbrEpk5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ It's Gaosheng's patch which triggers the warning but I think it's
  actually the dereference which should be changed.  I've added Richard
  to the CC list. -dan ]

Hi Gaosheng,

url:    https://github.com/0day-ci/linux/commits/Gaosheng-Cui/audit-return-early-if-the-rule-has-a-lower-priority/20211012-093102
base:    d3134eb5de8546a214c028fb7195e764b89da7d4
config: x86_64-randconfig-m001-20211012 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/auditsc.c:653 audit_filter_rules() error: we previously assumed 'ctx' could be null (see line 473)

vim +/ctx +653 kernel/auditsc.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  461  static int audit_filter_rules(struct task_struct *tsk,
93315ed6dd12da Amy Griffis        2006-02-07  462  			      struct audit_krule *rule,
^1da177e4c3f41 Linus Torvalds     2005-04-16  463  			      struct audit_context *ctx,
f368c07d7214a7 Amy Griffis        2006-04-07  464  			      struct audit_names *name,
f562988350361b Tony Jones         2011-04-27  465  			      enum audit_state *state,
f562988350361b Tony Jones         2011-04-27  466  			      bool task_creation)
^1da177e4c3f41 Linus Torvalds     2005-04-16  467  {
f562988350361b Tony Jones         2011-04-27  468  	const struct cred *cred;
5195d8e217a786 Eric Paris         2012-01-03  469  	int i, need_sid = 1;
3dc7e3153eddfc Darrel Goeddel     2006-03-10  470  	u32 sid;
8fae47705685fc Richard Guy Briggs 2016-11-20  471  	unsigned int sessionid;
3dc7e3153eddfc Darrel Goeddel     2006-03-10  472  
046a8e46eefb9d Gaosheng Cui       2021-10-12 @473  	if (ctx && rule->prio <= ctx->prio)
                                                            ^^^
Checked here.

046a8e46eefb9d Gaosheng Cui       2021-10-12  474  		return 0;
046a8e46eefb9d Gaosheng Cui       2021-10-12  475  
f562988350361b Tony Jones         2011-04-27  476  	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
f562988350361b Tony Jones         2011-04-27  477  
^1da177e4c3f41 Linus Torvalds     2005-04-16  478  	for (i = 0; i < rule->field_count; i++) {
93315ed6dd12da Amy Griffis        2006-02-07  479  		struct audit_field *f = &rule->fields[i];
5195d8e217a786 Eric Paris         2012-01-03  480  		struct audit_names *n;
^1da177e4c3f41 Linus Torvalds     2005-04-16  481  		int result = 0;
f1dc4867ff41b7 Richard Guy Briggs 2013-12-11  482  		pid_t pid;
^1da177e4c3f41 Linus Torvalds     2005-04-16  483  
93315ed6dd12da Amy Griffis        2006-02-07  484  		switch (f->type) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  485  		case AUDIT_PID:
fa2bea2f5cca5b Paul Moore         2016-08-30  486  			pid = task_tgid_nr(tsk);
f1dc4867ff41b7 Richard Guy Briggs 2013-12-11  487  			result = audit_comparator(pid, f->op, f->val);
^1da177e4c3f41 Linus Torvalds     2005-04-16  488  			break;
3c66251e573219 Al Viro            2006-05-06  489  		case AUDIT_PPID:
419c58f11fb732 Alexander Viro     2006-09-29  490  			if (ctx) {
419c58f11fb732 Alexander Viro     2006-09-29  491  				if (!ctx->ppid)
c92cdeb45eea38 Richard Guy Briggs 2013-12-10  492  					ctx->ppid = task_ppid_nr(tsk);
3c66251e573219 Al Viro            2006-05-06  493  				result = audit_comparator(ctx->ppid, f->op, f->val);
419c58f11fb732 Alexander Viro     2006-09-29  494  			}
3c66251e573219 Al Viro            2006-05-06  495  			break;
34d99af52ad40b Richard Guy Briggs 2015-08-05  496  		case AUDIT_EXE:
34d99af52ad40b Richard Guy Briggs 2015-08-05  497  			result = audit_exe_compare(tsk, rule->exe);
23bcc480dac204 Ondrej Mosnáček    2018-04-09  498  			if (f->op == Audit_not_equal)
23bcc480dac204 Ondrej Mosnáček    2018-04-09  499  				result = !result;
34d99af52ad40b Richard Guy Briggs 2015-08-05  500  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  501  		case AUDIT_UID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  502  			result = audit_uid_comparator(cred->uid, f->op, f->uid);
^1da177e4c3f41 Linus Torvalds     2005-04-16  503  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  504  		case AUDIT_EUID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  505  			result = audit_uid_comparator(cred->euid, f->op, f->uid);
^1da177e4c3f41 Linus Torvalds     2005-04-16  506  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  507  		case AUDIT_SUID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  508  			result = audit_uid_comparator(cred->suid, f->op, f->uid);
^1da177e4c3f41 Linus Torvalds     2005-04-16  509  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  510  		case AUDIT_FSUID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  511  			result = audit_uid_comparator(cred->fsuid, f->op, f->uid);
^1da177e4c3f41 Linus Torvalds     2005-04-16  512  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  513  		case AUDIT_GID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  514  			result = audit_gid_comparator(cred->gid, f->op, f->gid);
37eebe39c9731a Matvejchikov Ilya  2011-12-13  515  			if (f->op == Audit_equal) {
37eebe39c9731a Matvejchikov Ilya  2011-12-13  516  				if (!result)
af85d1772e31fe Ondrej Mosnáček    2018-06-05  517  					result = groups_search(cred->group_info, f->gid);
37eebe39c9731a Matvejchikov Ilya  2011-12-13  518  			} else if (f->op == Audit_not_equal) {
37eebe39c9731a Matvejchikov Ilya  2011-12-13  519  				if (result)
af85d1772e31fe Ondrej Mosnáček    2018-06-05  520  					result = !groups_search(cred->group_info, f->gid);
37eebe39c9731a Matvejchikov Ilya  2011-12-13  521  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  522  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  523  		case AUDIT_EGID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  524  			result = audit_gid_comparator(cred->egid, f->op, f->gid);
37eebe39c9731a Matvejchikov Ilya  2011-12-13  525  			if (f->op == Audit_equal) {
37eebe39c9731a Matvejchikov Ilya  2011-12-13  526  				if (!result)
af85d1772e31fe Ondrej Mosnáček    2018-06-05  527  					result = groups_search(cred->group_info, f->gid);
37eebe39c9731a Matvejchikov Ilya  2011-12-13  528  			} else if (f->op == Audit_not_equal) {
37eebe39c9731a Matvejchikov Ilya  2011-12-13  529  				if (result)
af85d1772e31fe Ondrej Mosnáček    2018-06-05  530  					result = !groups_search(cred->group_info, f->gid);
37eebe39c9731a Matvejchikov Ilya  2011-12-13  531  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  532  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  533  		case AUDIT_SGID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  534  			result = audit_gid_comparator(cred->sgid, f->op, f->gid);
^1da177e4c3f41 Linus Torvalds     2005-04-16  535  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  536  		case AUDIT_FSGID:
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  537  			result = audit_gid_comparator(cred->fsgid, f->op, f->gid);
^1da177e4c3f41 Linus Torvalds     2005-04-16  538  			break;
8fae47705685fc Richard Guy Briggs 2016-11-20  539  		case AUDIT_SESSIONID:
5b71388663c092 Ondrej Mosnáček    2018-05-17  540  			sessionid = audit_get_sessionid(tsk);
8fae47705685fc Richard Guy Briggs 2016-11-20  541  			result = audit_comparator(sessionid, f->op, f->val);
8fae47705685fc Richard Guy Briggs 2016-11-20  542  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  543  		case AUDIT_PERS:
93315ed6dd12da Amy Griffis        2006-02-07  544  			result = audit_comparator(tsk->personality, f->op, f->val);
^1da177e4c3f41 Linus Torvalds     2005-04-16  545  			break;
2fd6f58ba6efc8 David Woodhouse    2005-04-29  546  		case AUDIT_ARCH:
2fd6f58ba6efc8 David Woodhouse    2005-04-29  547  			if (ctx)
93315ed6dd12da Amy Griffis        2006-02-07  548  				result = audit_comparator(ctx->arch, f->op, f->val);
2fd6f58ba6efc8 David Woodhouse    2005-04-29  549  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  550  
^1da177e4c3f41 Linus Torvalds     2005-04-16  551  		case AUDIT_EXIT:
ba59eae7238572 Alex Shi           2020-11-06  552  			if (ctx && ctx->return_valid != AUDITSC_INVALID)
93315ed6dd12da Amy Griffis        2006-02-07  553  				result = audit_comparator(ctx->return_code, f->op, f->val);
^1da177e4c3f41 Linus Torvalds     2005-04-16  554  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  555  		case AUDIT_SUCCESS:
ba59eae7238572 Alex Shi           2020-11-06  556  			if (ctx && ctx->return_valid != AUDITSC_INVALID) {
93315ed6dd12da Amy Griffis        2006-02-07  557  				if (f->val)
93315ed6dd12da Amy Griffis        2006-02-07  558  					result = audit_comparator(ctx->return_valid, f->op, AUDITSC_SUCCESS);
b01f2cc1c37ac3 David Woodhouse    2005-08-27  559  				else
93315ed6dd12da Amy Griffis        2006-02-07  560  					result = audit_comparator(ctx->return_valid, f->op, AUDITSC_FAILURE);
b01f2cc1c37ac3 David Woodhouse    2005-08-27  561  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  562  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  563  		case AUDIT_DEVMAJOR:
16c174bd95cb07 Eric Paris         2012-01-03  564  			if (name) {
16c174bd95cb07 Eric Paris         2012-01-03  565  				if (audit_comparator(MAJOR(name->dev), f->op, f->val) ||
16c174bd95cb07 Eric Paris         2012-01-03  566  				    audit_comparator(MAJOR(name->rdev), f->op, f->val))
16c174bd95cb07 Eric Paris         2012-01-03  567  					++result;
16c174bd95cb07 Eric Paris         2012-01-03  568  			} else if (ctx) {
5195d8e217a786 Eric Paris         2012-01-03  569  				list_for_each_entry(n, &ctx->names_list, list) {
16c174bd95cb07 Eric Paris         2012-01-03  570  					if (audit_comparator(MAJOR(n->dev), f->op, f->val) ||
16c174bd95cb07 Eric Paris         2012-01-03  571  					    audit_comparator(MAJOR(n->rdev), f->op, f->val)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  572  						++result;
^1da177e4c3f41 Linus Torvalds     2005-04-16  573  						break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  574  					}
^1da177e4c3f41 Linus Torvalds     2005-04-16  575  				}
^1da177e4c3f41 Linus Torvalds     2005-04-16  576  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  577  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  578  		case AUDIT_DEVMINOR:
16c174bd95cb07 Eric Paris         2012-01-03  579  			if (name) {
16c174bd95cb07 Eric Paris         2012-01-03  580  				if (audit_comparator(MINOR(name->dev), f->op, f->val) ||
16c174bd95cb07 Eric Paris         2012-01-03  581  				    audit_comparator(MINOR(name->rdev), f->op, f->val))
16c174bd95cb07 Eric Paris         2012-01-03  582  					++result;
16c174bd95cb07 Eric Paris         2012-01-03  583  			} else if (ctx) {
5195d8e217a786 Eric Paris         2012-01-03  584  				list_for_each_entry(n, &ctx->names_list, list) {
16c174bd95cb07 Eric Paris         2012-01-03  585  					if (audit_comparator(MINOR(n->dev), f->op, f->val) ||
16c174bd95cb07 Eric Paris         2012-01-03  586  					    audit_comparator(MINOR(n->rdev), f->op, f->val)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  587  						++result;
^1da177e4c3f41 Linus Torvalds     2005-04-16  588  						break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  589  					}
^1da177e4c3f41 Linus Torvalds     2005-04-16  590  				}
^1da177e4c3f41 Linus Torvalds     2005-04-16  591  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  592  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  593  		case AUDIT_INODE:
f368c07d7214a7 Amy Griffis        2006-04-07  594  			if (name)
db510fc5cd9b9d Richard Guy Briggs 2013-07-04  595  				result = audit_comparator(name->ino, f->op, f->val);
f368c07d7214a7 Amy Griffis        2006-04-07  596  			else if (ctx) {
5195d8e217a786 Eric Paris         2012-01-03  597  				list_for_each_entry(n, &ctx->names_list, list) {
5195d8e217a786 Eric Paris         2012-01-03  598  					if (audit_comparator(n->ino, f->op, f->val)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  599  						++result;
^1da177e4c3f41 Linus Torvalds     2005-04-16  600  						break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  601  					}
^1da177e4c3f41 Linus Torvalds     2005-04-16  602  				}
^1da177e4c3f41 Linus Torvalds     2005-04-16  603  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  604  			break;
efaffd6e441786 Eric Paris         2012-01-03  605  		case AUDIT_OBJ_UID:
efaffd6e441786 Eric Paris         2012-01-03  606  			if (name) {
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  607  				result = audit_uid_comparator(name->uid, f->op, f->uid);
efaffd6e441786 Eric Paris         2012-01-03  608  			} else if (ctx) {
efaffd6e441786 Eric Paris         2012-01-03  609  				list_for_each_entry(n, &ctx->names_list, list) {
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  610  					if (audit_uid_comparator(n->uid, f->op, f->uid)) {
efaffd6e441786 Eric Paris         2012-01-03  611  						++result;
efaffd6e441786 Eric Paris         2012-01-03  612  						break;
efaffd6e441786 Eric Paris         2012-01-03  613  					}
efaffd6e441786 Eric Paris         2012-01-03  614  				}
efaffd6e441786 Eric Paris         2012-01-03  615  			}
efaffd6e441786 Eric Paris         2012-01-03  616  			break;
54d3218b31aee5 Eric Paris         2012-01-03  617  		case AUDIT_OBJ_GID:
54d3218b31aee5 Eric Paris         2012-01-03  618  			if (name) {
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  619  				result = audit_gid_comparator(name->gid, f->op, f->gid);
54d3218b31aee5 Eric Paris         2012-01-03  620  			} else if (ctx) {
54d3218b31aee5 Eric Paris         2012-01-03  621  				list_for_each_entry(n, &ctx->names_list, list) {
ca57ec0f00c3f1 Eric W. Biederman  2012-09-11  622  					if (audit_gid_comparator(n->gid, f->op, f->gid)) {
54d3218b31aee5 Eric Paris         2012-01-03  623  						++result;
54d3218b31aee5 Eric Paris         2012-01-03  624  						break;
54d3218b31aee5 Eric Paris         2012-01-03  625  					}
54d3218b31aee5 Eric Paris         2012-01-03  626  				}
54d3218b31aee5 Eric Paris         2012-01-03  627  			}
54d3218b31aee5 Eric Paris         2012-01-03  628  			break;
f368c07d7214a7 Amy Griffis        2006-04-07  629  		case AUDIT_WATCH:
0223fad3c98a95 Richard Guy Briggs 2019-05-22  630  			if (name) {
0223fad3c98a95 Richard Guy Briggs 2019-05-22  631  				result = audit_watch_compare(rule->watch,
0223fad3c98a95 Richard Guy Briggs 2019-05-22  632  							     name->ino,
0223fad3c98a95 Richard Guy Briggs 2019-05-22  633  							     name->dev);
0223fad3c98a95 Richard Guy Briggs 2019-05-22  634  				if (f->op == Audit_not_equal)
0223fad3c98a95 Richard Guy Briggs 2019-05-22  635  					result = !result;
0223fad3c98a95 Richard Guy Briggs 2019-05-22  636  			}
f368c07d7214a7 Amy Griffis        2006-04-07  637  			break;
74c3cbe33bc077 Al Viro            2007-07-22  638  		case AUDIT_DIR:
0223fad3c98a95 Richard Guy Briggs 2019-05-22  639  			if (ctx) {
74c3cbe33bc077 Al Viro            2007-07-22  640  				result = match_tree_refs(ctx, rule->tree);
0223fad3c98a95 Richard Guy Briggs 2019-05-22  641  				if (f->op == Audit_not_equal)
0223fad3c98a95 Richard Guy Briggs 2019-05-22  642  					result = !result;
0223fad3c98a95 Richard Guy Briggs 2019-05-22  643  			}
74c3cbe33bc077 Al Viro            2007-07-22  644  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  645  		case AUDIT_LOGINUID:
38f80590486e38 Richard Guy Briggs 2018-05-16  646  			result = audit_uid_comparator(audit_get_loginuid(tsk),
38f80590486e38 Richard Guy Briggs 2018-05-16  647  						      f->op, f->uid);
^1da177e4c3f41 Linus Torvalds     2005-04-16  648  			break;
780a7654cee8d6 Eric W. Biederman  2013-04-09  649  		case AUDIT_LOGINUID_SET:
780a7654cee8d6 Eric W. Biederman  2013-04-09  650  			result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
780a7654cee8d6 Eric W. Biederman  2013-04-09  651  			break;
bf361231c295d9 Richard Guy Briggs 2019-05-09  652  		case AUDIT_SADDR_FAM:
bf361231c295d9 Richard Guy Briggs 2019-05-09 @653  			if (ctx->sockaddr)
                                                                            ^^^^^^^^^^^^^
Everywhere else checks if "ctx" is NULL before dereferencing it.

bf361231c295d9 Richard Guy Briggs 2019-05-09  654  				result = audit_comparator(ctx->sockaddr->ss_family,
bf361231c295d9 Richard Guy Briggs 2019-05-09  655  							  f->op, f->val);
bf361231c295d9 Richard Guy Briggs 2019-05-09  656  			break;
3a6b9f85c641a3 Darrel Goeddel     2006-06-29  657  		case AUDIT_SUBJ_USER:
3a6b9f85c641a3 Darrel Goeddel     2006-06-29  658  		case AUDIT_SUBJ_ROLE:
3a6b9f85c641a3 Darrel Goeddel     2006-06-29  659  		case AUDIT_SUBJ_TYPE:
3a6b9f85c641a3 Darrel Goeddel     2006-06-29  660  		case AUDIT_SUBJ_SEN:
3a6b9f85c641a3 Darrel Goeddel     2006-06-29  661  		case AUDIT_SUBJ_CLR:
3dc7e3153eddfc Darrel Goeddel     2006-03-10  662  			/* NOTE: this may return negative values indicating
3dc7e3153eddfc Darrel Goeddel     2006-03-10  663  			   a temporary error.  We simply treat this as a
3dc7e3153eddfc Darrel Goeddel     2006-03-10  664  			   match for now to avoid losing information that
3dc7e3153eddfc Darrel Goeddel     2006-03-10  665  			   may be wanted.   An error message will also be
3dc7e3153eddfc Darrel Goeddel     2006-03-10  666  			   logged upon error */
04305e4aff8b05 Ahmed S. Darwish   2008-04-19  667  			if (f->lsm_rule) {
2ad312d2093ae5 Steve Grubb        2006-04-11  668  				if (need_sid) {
4ebd7651bfc899 Paul Moore         2021-02-19  669  					security_task_getsecid_subj(tsk, &sid);
2ad312d2093ae5 Steve Grubb        2006-04-11  670  					need_sid = 0;
2ad312d2093ae5 Steve Grubb        2006-04-11  671  				}
d7a96f3a1ae279 Ahmed S. Darwish   2008-03-01  672  				result = security_audit_rule_match(sid, f->type,
3dc7e3153eddfc Darrel Goeddel     2006-03-10  673  								   f->op,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  674  								   f->lsm_rule);
2ad312d2093ae5 Steve Grubb        2006-04-11  675  			}
3dc7e3153eddfc Darrel Goeddel     2006-03-10  676  			break;
6e5a2d1d325968 Darrel Goeddel     2006-06-29  677  		case AUDIT_OBJ_USER:
6e5a2d1d325968 Darrel Goeddel     2006-06-29  678  		case AUDIT_OBJ_ROLE:
6e5a2d1d325968 Darrel Goeddel     2006-06-29  679  		case AUDIT_OBJ_TYPE:
6e5a2d1d325968 Darrel Goeddel     2006-06-29  680  		case AUDIT_OBJ_LEV_LOW:
6e5a2d1d325968 Darrel Goeddel     2006-06-29  681  		case AUDIT_OBJ_LEV_HIGH:
6e5a2d1d325968 Darrel Goeddel     2006-06-29  682  			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
6e5a2d1d325968 Darrel Goeddel     2006-06-29  683  			   also applies here */
04305e4aff8b05 Ahmed S. Darwish   2008-04-19  684  			if (f->lsm_rule) {
6e5a2d1d325968 Darrel Goeddel     2006-06-29  685  				/* Find files that match */
6e5a2d1d325968 Darrel Goeddel     2006-06-29  686  				if (name) {
d7a96f3a1ae279 Ahmed S. Darwish   2008-03-01  687  					result = security_audit_rule_match(
90462a5bd30c6e Richard Guy Briggs 2019-01-31  688  								name->osid,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  689  								f->type,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  690  								f->op,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  691  								f->lsm_rule);
6e5a2d1d325968 Darrel Goeddel     2006-06-29  692  				} else if (ctx) {
5195d8e217a786 Eric Paris         2012-01-03  693  					list_for_each_entry(n, &ctx->names_list, list) {
90462a5bd30c6e Richard Guy Briggs 2019-01-31  694  						if (security_audit_rule_match(
90462a5bd30c6e Richard Guy Briggs 2019-01-31  695  								n->osid,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  696  								f->type,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  697  								f->op,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  698  								f->lsm_rule)) {
6e5a2d1d325968 Darrel Goeddel     2006-06-29  699  							++result;
6e5a2d1d325968 Darrel Goeddel     2006-06-29  700  							break;
6e5a2d1d325968 Darrel Goeddel     2006-06-29  701  						}
6e5a2d1d325968 Darrel Goeddel     2006-06-29  702  					}
6e5a2d1d325968 Darrel Goeddel     2006-06-29  703  				}
6e5a2d1d325968 Darrel Goeddel     2006-06-29  704  				/* Find ipc objects that match */
a33e6751003c5a Al Viro            2008-12-10  705  				if (!ctx || ctx->type != AUDIT_IPC)
6e5a2d1d325968 Darrel Goeddel     2006-06-29  706  					break;
a33e6751003c5a Al Viro            2008-12-10  707  				if (security_audit_rule_match(ctx->ipc.osid,
a33e6751003c5a Al Viro            2008-12-10  708  							      f->type, f->op,
90462a5bd30c6e Richard Guy Briggs 2019-01-31  709  							      f->lsm_rule))
a33e6751003c5a Al Viro            2008-12-10  710  					++result;
6e5a2d1d325968 Darrel Goeddel     2006-06-29  711  			}
6e5a2d1d325968 Darrel Goeddel     2006-06-29  712  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  713  		case AUDIT_ARG0:
^1da177e4c3f41 Linus Torvalds     2005-04-16  714  		case AUDIT_ARG1:
^1da177e4c3f41 Linus Torvalds     2005-04-16  715  		case AUDIT_ARG2:
^1da177e4c3f41 Linus Torvalds     2005-04-16  716  		case AUDIT_ARG3:
^1da177e4c3f41 Linus Torvalds     2005-04-16  717  			if (ctx)
93315ed6dd12da Amy Griffis        2006-02-07  718  				result = audit_comparator(ctx->argv[f->type-AUDIT_ARG0], f->op, f->val);
^1da177e4c3f41 Linus Torvalds     2005-04-16  719  			break;
5adc8a6adc91c4 Amy Griffis        2006-06-14  720  		case AUDIT_FILTERKEY:
5adc8a6adc91c4 Amy Griffis        2006-06-14  721  			/* ignore this field for filtering */
5adc8a6adc91c4 Amy Griffis        2006-06-14  722  			result = 1;
5adc8a6adc91c4 Amy Griffis        2006-06-14  723  			break;
55669bfa141b48 Al Viro            2006-08-31  724  		case AUDIT_PERM:
55669bfa141b48 Al Viro            2006-08-31  725  			result = audit_match_perm(ctx, f->val);
0223fad3c98a95 Richard Guy Briggs 2019-05-22  726  			if (f->op == Audit_not_equal)
0223fad3c98a95 Richard Guy Briggs 2019-05-22  727  				result = !result;
55669bfa141b48 Al Viro            2006-08-31  728  			break;
8b67dca9420474 Al Viro            2008-04-28  729  		case AUDIT_FILETYPE:
8b67dca9420474 Al Viro            2008-04-28  730  			result = audit_match_filetype(ctx, f->val);
0223fad3c98a95 Richard Guy Briggs 2019-05-22  731  			if (f->op == Audit_not_equal)
0223fad3c98a95 Richard Guy Briggs 2019-05-22  732  				result = !result;
8b67dca9420474 Al Viro            2008-04-28  733  			break;
02d86a568c6d2d Eric Paris         2012-01-03  734  		case AUDIT_FIELD_COMPARE:
02d86a568c6d2d Eric Paris         2012-01-03  735  			result = audit_field_compare(tsk, cred, f, ctx, name);
02d86a568c6d2d Eric Paris         2012-01-03  736  			break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  737  		}
f562988350361b Tony Jones         2011-04-27  738  		if (!result)
^1da177e4c3f41 Linus Torvalds     2005-04-16  739  			return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  740  	}
0590b9335a1c72 Al Viro            2008-12-14  741  
0590b9335a1c72 Al Viro            2008-12-14  742  	if (ctx) {
0590b9335a1c72 Al Viro            2008-12-14  743  		if (rule->filterkey) {
0590b9335a1c72 Al Viro            2008-12-14  744  			kfree(ctx->filterkey);
5adc8a6adc91c4 Amy Griffis        2006-06-14  745  			ctx->filterkey = kstrdup(rule->filterkey, GFP_ATOMIC);
0590b9335a1c72 Al Viro            2008-12-14  746  		}
0590b9335a1c72 Al Viro            2008-12-14  747  		ctx->prio = rule->prio;
0590b9335a1c72 Al Viro            2008-12-14  748  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  749  	switch (rule->action) {
66b12abc846d31 Paul Moore         2016-06-16  750  	case AUDIT_NEVER:
619ed58ac4e2fb Sergey Nazarov     2021-06-08  751  		*state = AUDIT_STATE_DISABLED;
66b12abc846d31 Paul Moore         2016-06-16  752  		break;
66b12abc846d31 Paul Moore         2016-06-16  753  	case AUDIT_ALWAYS:
619ed58ac4e2fb Sergey Nazarov     2021-06-08  754  		*state = AUDIT_STATE_RECORD;
66b12abc846d31 Paul Moore         2016-06-16  755  		break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  756  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  757  	return 1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  758  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

