Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B590F42C7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhJMRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:45:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28882 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229714AbhJMRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:45:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DHO5wB008142;
        Wed, 13 Oct 2021 17:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MmybetnEgFdnwbK/lFDOAtHG8zO+BihozgR1kbg0Jf4=;
 b=QMS577bRD5fl/cioMMSw7eBaOPUZu8BPKBlRcbieZAAsAxOCDDRksIseudnW0DTm+1bL
 a2XAVNaoWpJIOkWsnyUwfSYFtSvLCxB6AAUdlpEq0js9HeiqMqSfK8onnxg3ArBW9jdG
 aoLItXzQ2lwI1zaajoLKcEZpxDsA/dGmV09Kd+pnjLfBit5kImSqX/BY3inyiaXetTCF
 ryumX+xLDL9aiMP+Lc8m+wg8RGNcGCz5cHOkjBWuQLxU35lvK6q9a0tK7TI2Vv+zle/x
 SDM0PIxOUYaPOU5ycX6ACh7DkN6p1GmszrGZSgi1pzSqJybVbTz/7oxbnlVxhJ2JGT8T aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbj65b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 17:38:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DHKmRV034621;
        Wed, 13 Oct 2021 17:38:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3bmae17f8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 17:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWn2LYaYiqKLKcg+A1pNHqi2uIRTXkLFryIIlUiDbqi4Giv1rvo1mY1/higEOaHFKQGJmpHg7ragoPIzmmehZVAdTdP3Yxdwzhy1RlwD7+eSVX5mXn+NUnsf+8D6CPCLPrp08clJRPEdzLCrSRXzI57reoTgEUBWniWVHFxmWtR/VuPPTZE4AmCrgcHkm4jspJ/55BMainP7LYrn8Nstij6WJSRCT3LIlB7ymXd+YRCrqRx7wVA/Cr9DBCYrp4gUMh5SBF68h7iOzU5v/8ON5KCgO6wqcuYfTY5ZMWxqZJ9/mRitb/t//RhDeWksZkbx2XcWF80tlWX6AUpenXFOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmybetnEgFdnwbK/lFDOAtHG8zO+BihozgR1kbg0Jf4=;
 b=QOcizQPC18BqccZ8BATwtiqJEmQeZr+rwrmEbmYt9IxeFFXUvAfnOcNctUp13xtPiulL0kFQgBOwtduDsU8YJTPaH9SpglRlbLG2BGeplsV6CjVDl282etClViUdLcHCD3Nx/Q4yF4OzkQDsoTRMH8AJwIzOlyEJzsh4aYLmZ/+fhomBGf0DP+iP1Dxwd31lxzwRYSRd2311c80YXWhvzPnv5vsXLyj4xsgvYloFL/yjJ+7rLV3glNSkxldFdk6mapjMxosWhT3T+yNw9ECjtMljgJZ9iWpASc2LL37o00FdPpPFrPy+WU9ZR+cabRzzlHzdhVS9ucG6yCKM7WaeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmybetnEgFdnwbK/lFDOAtHG8zO+BihozgR1kbg0Jf4=;
 b=MHBrvht/wlNDIuUKzvyTO1OIi8GDZGIZ3CLEEWPrLpObdhwqnf4+qW7XZwyBT2d6El6Ugnkv2n4fueuRTk/HwYq9b5kE/OtpvEQMuWdcvioZcPAnda04ZJCZOz4YIUx03/5T1CTt6NG52pPNKybyHRJCv4TjYhIyvjiF5pJKeXo=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3381.namprd10.prod.outlook.com (2603:10b6:a03:15b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Wed, 13 Oct
 2021 17:38:38 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::938:e546:a29a:7f03]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::938:e546:a29a:7f03%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 17:38:38 +0000
Date:   Wed, 13 Oct 2021 13:38:34 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, ultrachin@163.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
Message-ID: <20211013173834.lrff6wloae4c6uol@oracle.com>
References: <20211008063933.331989-1-ultrachin@163.com>
 <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
 <YWQDqtnA5FXk7xan@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWQDqtnA5FXk7xan@dhcp22.suse.cz>
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
Received: from oracle.com (98.229.125.203) by BL1PR13CA0398.namprd13.prod.outlook.com (2603:10b6:208:2c2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Wed, 13 Oct 2021 17:38:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad6ccf34-30e3-4fdb-b511-08d98e704a47
X-MS-TrafficTypeDiagnostic: BYAPR10MB3381:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3381436A782D39DACB4D5CB3D9B79@BYAPR10MB3381.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e32p+r7FSLzGd+RsXkk8ygPeFkmsm88iI/OKZbYSYXR1+Rrtt7/E1xR55zMlyKVBZj0khnxzYm0oOLWtQwVBlrgSs52sMxM5hUxfvVB61KgodEPXyOl/YH0/fBmRJFUU+Xj/0vLj87+N55nvU8Ogto9ghqkKjbhweFP8CG9aUs27qfIj/iYuK/oG44zG4kodzMQLYzAzG+i1c91I+UdahZ8PLNavCySoEUm6XrhOuItD6aou+oe36/zjux4TqejWAJvu30Ejkl9ka+auuZtSOOAazFKcvBxkFJfT1AC1WzKmx+PjNKcq+CH+YRE8L37oHEcIiZdflEgbUnQOkcRpteLLoVMOnpO3iJZ2knroUtmFVVUkr1DevPYRgll344HMSHzo+F7KjiieZ2K635OWDWMSh3Uneeoqz7spsRxqxcZJPSDj4OdcmtIzfBGpzkdt1mqGe9oRq83+TjZbM++KOdISXaRe5j0WQGHXRSxy2gafX/7kOuq8AZ6nOXONpsKRtvNx7vmOiI7fliN118KIKKBuP0tyS6ZRWcbdlc1Y4CZeUDnkQZAOdgvIaVL2bgtD6pfWKre/10jxVVg+TRnrV5oKFJVUOPSxNCtBCJMPJ8qG+02llN7NhH8UKgHxNwUFCSU9VWkCQBMXj/AF9kvBohLJdPvs2mQqpahHwl4I8cg7tRe7/cQboUZONS0JG0bsLkugxKvD7D4aObMSEoZTYiPbXOD3YXA0rAT4qJULYH9gUb5ENs/Es7CyDCq+hdTTO0zcvqN8rp9yZ0ZKb0OttYhdIvjfkLzv0Hge6ZXKF/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8886007)(8676002)(66946007)(4326008)(7416002)(38100700002)(38350700002)(6916009)(2616005)(8936002)(86362001)(55016002)(83380400001)(508600001)(66476007)(66556008)(54906003)(2906002)(956004)(5660300002)(966005)(316002)(36756003)(52116002)(6666004)(53546011)(186003)(1076003)(7696005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+tyGrWZKFlwzeU+pgUzWGaAVUsReYe7Ww3ElfDEqRm+si0fxmaPSMhb20eq?=
 =?us-ascii?Q?rQqIFoB/qJTOVesMMsFZdsMQ+Cd0392/U3/gkU2B3Lzo+4JFLAJg3HrX5Xp3?=
 =?us-ascii?Q?pYlS84QDSvxmy5D1q9Tf1rMg2sB/oCyCyVscf+cc2A1MRdu0m58fU3bANluv?=
 =?us-ascii?Q?n104CO1uZkEfNuIYxjQp06jeR+jCBmZjxRJA5r8zJVPNoE1WIdwNWmpX0jiJ?=
 =?us-ascii?Q?dg0arN+z+7VG5eIQ0/u3rr8Kslha/LWMMbA8Tch53v1C/dcQVJp8JneDuBJc?=
 =?us-ascii?Q?sVWlX/TTRkd9/mrdKuesBV61TkFWzRCMltuNBs+bptaOry4T+4I9EKcLY5Nm?=
 =?us-ascii?Q?x+Z6kWq4Y4EEtcivAjcRcHU7xRc2QGaa6oK2QLUvT/F1LfYOFq6dvSi3iyKd?=
 =?us-ascii?Q?SAdFk+pKCUKZ0Qu/VslCFelCEjy1vt73RcBSTub2rYVsxFvyu/G9qk7tvK+A?=
 =?us-ascii?Q?2rhBGZ8UkhBzQ4FhZTzUIdzJNlDMXukErZj2sCi000eScMvqU2GKQX8YvdZ/?=
 =?us-ascii?Q?Ke2PQpi4npbZXN4191lgq++9uaKEL722ZB+3BUS1vhUlsEphMwtxemt/W3Yv?=
 =?us-ascii?Q?/K6+AYQOM7Uv8XZqIB9x5p2Gd6+tQGY9ZEZu7eYN3wzd940EZzi2tCA54X9J?=
 =?us-ascii?Q?yDsDqVNdvDiRt/WAS3sSbG4+6ah0vci3P+Rbas8AI3FwgjM6u/oUgHqGqNW+?=
 =?us-ascii?Q?gV+7gwT6fS5phRrpIv2ziarcOM64TmQterl0CIH0+YCIS0sDE42+FnxpNG9Q?=
 =?us-ascii?Q?mi/YU4xyYlrIWii7oorOW0Xf8JIKmZc9Ui9kWzrTq+y5osdIOTe161rR/Eyo?=
 =?us-ascii?Q?b8rnpoLH8SMGvX+ZteYt+UZoL+rgsMMxyw0PTZaG34IoKa5okKIDE9s1/BXE?=
 =?us-ascii?Q?Nr7QoLslD2I31wkvq01RexSTW+xkGoHIXuTyAajojzJPmMUoUv5btlR4PG7c?=
 =?us-ascii?Q?2EUzE1Xoqlx4CilVfeZTxBFyg5gRkQtS2o1wFl0UPlOwOJryvtanAo4rTmtl?=
 =?us-ascii?Q?QnO62mh0n59bzhEnCAQQyg19CQDU+gYRADY4KZFsAIyT4dVI8DdZpYFi3Mqb?=
 =?us-ascii?Q?A7odVYN4d21DFtD7Bwz2HW5VLMODXW97BSMTztOXF3tZnNuAL9mVkJTId9Ar?=
 =?us-ascii?Q?7P4i52ttRulyGsow5GtULmSYKF+/LYOLzuZiO+zxa3janP988r7TUC9Fxssz?=
 =?us-ascii?Q?ef/n2LDSKRPRPOo/jslXNtCbC7sfl+RBpPk6Rd1G1ShsMFQJC8lAMGs2RqKj?=
 =?us-ascii?Q?667oS2bw61k7C+KatjgL2Wn/Qc4ruCUv4tPTEvN9RV7i0EaU7zJS1WAnslzz?=
 =?us-ascii?Q?q7W1TF1B8SXgC7BJ/drypIIH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6ccf34-30e3-4fdb-b511-08d98e704a47
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 17:38:38.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcyC+pwWShLm5KL1p8/z/lHCgftj8Fk/4YQFPZW+mgIMX49tUQ+a5ilyTsIkiSKZlT6VCKeyuQHP4G9ajFQy6l+FdPZml9r9ELtnrHWj4Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3381
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=773 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130106
X-Proofpoint-ORIG-GUID: TEOUkecb3AjxHZx3SlXLvfyVgpPbv5KM
X-Proofpoint-GUID: TEOUkecb3AjxHZx3SlXLvfyVgpPbv5KM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm just back from vacation)

On Mon, Oct 11, 2021 at 11:28:10AM +0200, Michal Hocko wrote:
> On Fri 08-10-21 10:17:50, David Hildenbrand wrote:
> > On 08.10.21 08:39, ultrachin@163.com wrote:
> > > From: chen xiaoguang <xiaoggchen@tencent.com>
> > > 
> > > The exit time is long when program allocated big memory and
> > > the most time consuming part is free memory which takes 99.9%
> > > of the total exit time. By using async free we can save 25% of
> > > exit time.
> > > 
> > > Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> > > Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> > > Signed-off-by: lu yihui <yihuilu@tencent.com>
> > 
> > I recently discussed with Claudio if it would be possible to tear down the
> > process MM deferred, because for some use cases (secure/encrypted
> > virtualization, very large mmaps) tearing down the page tables is already
> > the much more expensive operation.
> > 
> > There is mmdrop_async(), and I wondered if one could reuse that concept when
> > tearing down a process -- I didn't look into feasibility, however, so it's
> > just some very rough idea.
> 
> This is not a new problem. Large process tear down can take ages. The
> primary road block has been accounting. This lot of work has to be
> accounted to the proper domain (e.g. cpu cgroup). A deferred and
> properly accounted context implementation is still lacking AFAIK.

Right, still doesn't exist.  It's coming though, and there was a session
on it at LPC this year[1].

> I have a vague recollection we have padata framework but I am not sure
> anybody has explored this to be used for the address space shutdown.
> IIRC Daniel Jordan was active in that area.

Yeah, address space teardown is one of the things we want to use padata
for.  It's on the list.

[1] https://linuxplumbersconf.org/event/11/contributions/1041/
