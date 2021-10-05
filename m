Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81D4233F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhJEXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:02:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42608 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233540AbhJEXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:02:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Mhipj022650;
        Tue, 5 Oct 2021 22:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mCNfL0/LrshLkfqSd1sL0vMKitpVIau6BSDnuUyPI2s=;
 b=Oqrs8UQIl1zzUkw8+BZi7Fg91jNW33XjJ/RrkU54jfrSQxDTYFMnMe0njIpfN/ysJ2tt
 G7ixqGBUWHRK68ionRsy8PADibXfgbZyPGKl3PdBkEnKD1WB5snSWfdVuMoXLkxhzFp/
 U12yv0pibmrBdSAGG+Bwkk6Hh/0BjD2EKcZvaJtuFF75zcPfUxjn5Exvt3b1jLiqZ4j/
 VBP1mdNWqBGz7Ava9388nVaAa7B52UiCBRo/EgK1IpM7wJfpHm/Sf0CvUAuR50jY/kVJ
 xyrmqF1Y8o3oeu1xoDXZDVb52+3+HG6sZA55lKouQP6FgveunnKZ8fed0DnHiRaymnP9 NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454krb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 22:59:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195MshJW174089;
        Tue, 5 Oct 2021 22:59:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16twbh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 22:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnY7qK1KSdg4C0/q1siVJnMqCevtln5KNoxxHZNDzvs7IERqQqVA7nPBLnzjFfbQrQxaqhdcKsF+s4e9YIj3dCK1ub45PCvDuALHeETReU4kHgWG6moeobovU3z1ktOYBHczAuob4wCCXpn+daRSSVMfAACPf+YDtBWweEIh6yR3lzwDcgpunUEwzac6DDmHlniq4Wp+9m1ftwrNMSk45kfK4V5s1h3uvDePoTRwwdErMS7xdY5qIpwivN66+9nn9S0dp0ru/IldXfZKSwJNx0/XgIfcTJirqEA5TMEm+nvO5KgsjKJ1NWzhXkfcEdFfRVTEuUbSWlvdEJA0uXti7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCNfL0/LrshLkfqSd1sL0vMKitpVIau6BSDnuUyPI2s=;
 b=PXU92B7u6m0AUGdHqKJD78VpjHtlY+2WhmHHpE2KMTlEVN7r74qp7vw4IhRqA0nFn8OmUGex3XpMiU4T/PMsHmCryD5qoN5zjPdIyjZWGJBYrbKLVge6r8T1ym2/EnhB8/kpvBbk+11fOAeeZVzALN38HI/E7sKzgCYLxqAAHuFa+f2kgtvSKTzYDig6Mg/HUb3xsZcVndD4ToKuuJIOOP2WpBLv1NVkO/j3zBmNQ92Qmv4A6vaUfzoNVVeAkBKhIsYkaC7G/PnzCMyUd+DIUzkPNOagflnG6I1VWHTBiRfNADJTaSDC2S6J0eifDoyBh0AjGbGUQMBJV1LWjw7FZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCNfL0/LrshLkfqSd1sL0vMKitpVIau6BSDnuUyPI2s=;
 b=wGVsaGVQ7dAi6MX32RwTjKUHBXSoQgEGwa7qQ/xYxonqahdRQD2yFOH2DDsqIK0qfv2qkzIsA5Xh1A9uK6HVA9czazBTpnRky4dxcnXmcwdHaMBiD2qSBsaWMEd2EwliU/YwK/mXCSG1u1xbnJTWIZ0X4U8s0qGuHxj9JjbVDC4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 22:59:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 22:59:52 +0000
Subject: Re: [PATCH v8] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     Zhenguo Yao <yaozhenguo1@gmail.com>, akpm@linux-foundation.org
Cc:     dan.carpenter@oracle.com, nathan@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, corbet@lwn.net,
        rppt@kernel.org, yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
References: <20211005054729.86457-1-yaozhenguo1@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <55d28037-4e0e-70b3-717d-a44b90f6f9ef@oracle.com>
Date:   Tue, 5 Oct 2021 15:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211005054729.86457-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:300:94::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR19CA0068.namprd19.prod.outlook.com (2603:10b6:300:94::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend Transport; Tue, 5 Oct 2021 22:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 412ac727-d722-4652-2769-08d98853d6eb
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB397090EFCDC7C7041D63079FE2AF9@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u13aBd4eK+hGpTGPjTmc6gYRlu+qv9z0Yq0luYR+YTAM0c4aLqWMnx3n5FYy3AxtCIPpS/nJpE8TULyXSTvQBIwvQQ8e/Qa4KKhsadLgsG5YvWDbW98yy5NtvnFym18xwtneHmAUkyAg5gNetOSQcwP4kRgGmqvVmDOtAtrdCjx9B5fJZTodS7sBZYDn+XOE1y9MvTjBKto5caOJqBFttBQKIJZs1firsNhBK6KCh8mIILAC1BXErOEUqChU1DNufogBstJtnbPcDrlXhz7rrNyESYtZX4Vctptb9S40bvYOgH6neDVKuo6Ymc755Q/HdrfeRjTJ4fMSOc8+md9nz7lAe6JMLuNGCx45UiVsZPothUJvDolRPfLk5lJKU8EWh48Jka/7g4paQNrkolo7ImPBkXMqb1ljta1Tlt8gY+RfBO0ZejIuw77KJ1q+LtmTUBLrXbKMi6JTxNYfccF41LhGiQ7QSl9M6NaeDuMIP64bKH6q8dyIGhpbzzwT4bLPFisQfdSYwXICwR4ED9MuHWFpDOKOjnzWsyK557p9rlWmk6Kk7h8GWSL6Zq3g7VCMU9HZOq7sz2l3iZHu9uqIa4IVeBYV+ZgkHLdpoR/EUlA8eGvvs8U24zPV65fORBMYbcGf1zhL+FUU549FEo8r7uL+4/Sq019ev7fM93B14O+O0JS8sxaljSvNDQFbTyyxGufEypUGcmhH1eW0wRIjTorSpoJNCEFmT1sy8KheVJ+/UYZwZrbOzTCLa5PBuyOjbVmApdm5IavYBokDI2sVCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(5660300002)(316002)(16576012)(508600001)(7416002)(6486002)(66556008)(52116002)(66476007)(38100700002)(4744005)(38350700002)(31686004)(66946007)(4326008)(53546011)(36756003)(8676002)(26005)(31696002)(186003)(44832011)(2616005)(956004)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmw2SVhId3ZwK1B0Vm5Ha3lBa1VtZjM3Rkc0QzIwYlNqQ1JjRWNFZWM3eFN0?=
 =?utf-8?B?U0c5Z0puaExnbXRacE5xeTFsb1REbG93YzVUQ3ZNbVpuTitHYWdqVTZoMFNt?=
 =?utf-8?B?anJYeXlGc2dDUHR2NERPdkUxWjRDYkhkQlh1TTdtMjFYRS9ac0hiQzdVb2NK?=
 =?utf-8?B?RFBXTjVXL0xmYXl5dzFUb3FEN240VEQ1cmZBaGI4ZVJHbmVrbVJ4T0lmZ0tI?=
 =?utf-8?B?d1lZb05XQXVSZmlaeGlOMHdvR2FMb1FzbXpsbGpsSElTb1J1a2RBU2s1M3N0?=
 =?utf-8?B?TWcxN093QmpqZnFoL3E0THNJeDg5THZmN1lNV2ZYbHpudzZyeGYrd2ZOVjdD?=
 =?utf-8?B?cTUvSXAyN0xyQ1dHNE5zb3lFNWNadnFqamRRUVNCdm9lcHRuYUlNaXZkUU9z?=
 =?utf-8?B?SEowRWgzeWpFZ1dvOUNLQVJOTmhuYjBMUUc0UkJCc3YrOG1sNEFDYmxFNmFR?=
 =?utf-8?B?U3NqMHZhWHR4RW1JSmR6YkkwTFdGc3J4cFdpTjZ3S0Z0VmpDb2xEZkVqWGlN?=
 =?utf-8?B?aFNTNWFIUEx1OHdaTzJINkY3Vng0cmlydWlHSFR4dzNEMnB2UG5WNnoyMTdm?=
 =?utf-8?B?ejcrcjBqamh2bThjTWE0ZGpaSlY5eFZyVGppdjBBVE1TemtTWDY3YmptSTBF?=
 =?utf-8?B?U3RjTHhvemN4amFPc3ZmT1J5a3JKVjdxZ2hqdUJzTXdsTVcwaDJYQ21samM4?=
 =?utf-8?B?Rjh5WUpGV2xPcmFLR2dsemU4SkFNUW43K1RtYm5pOVUybW9rZlppUEJrR3o3?=
 =?utf-8?B?L2NIejBxMldDeGJXckt3cm83SkZ2OUdsYmRMQnZhU1VXdC84RzdraFM4a2VX?=
 =?utf-8?B?bGppS2pFL1g5UE9Tc1Vnb2VpQy94Vndnc2Z5b1BFSituNVY3Y0xsSVc3bEJI?=
 =?utf-8?B?L3ZnaERaZG8xK3Y2SGsyYUZoa3VMZ3V1QUQweFY3VUV1dkNpZlFCZVV6ekpt?=
 =?utf-8?B?d0NxNzU3Y29rUVYrRUVVdVFEUFJGNGVFSTNiY2JUS28wVC8rSS8reHl4SjAw?=
 =?utf-8?B?dUQzMGxJN3pGU2FTc0d2Z0NCemdicDJpQkVnNmhiUkpvL2FoYnN1ckdqak9U?=
 =?utf-8?B?NHA5YUNSbmJZRklTcXhraWZTNEpkZU0yY1RWZFJCeGdnYXM1d2JnekwzYTdl?=
 =?utf-8?B?d2RaQ0Q0aWNEMXE3bVpyOUoxSDVjWFZqeVpITjU0WGtXTEpQK0RuNnFhMCtC?=
 =?utf-8?B?QkFVMHpML2ZaNFo1MHYzMUZ4UTdscWJDUHNNRFJxU0JEVFdsV3FIVCtyWjIv?=
 =?utf-8?B?eG8wRE1jcVlXWmtReEZlaXo5SFNDOHpRUkh2Yjk1d1NjS2ZiQTlCc0RUdWpy?=
 =?utf-8?B?RkNubHQrNDRycDRFOFdndlcxTW43ZHRTUFJaRVczQ3ZKaXNFUEtUdlFZUjIw?=
 =?utf-8?B?eTE1QWxDYXpkRExnQmlVZHpsempkdkR1NWtKdlBPa1VmZVN2bWFSTllvaDRF?=
 =?utf-8?B?bUMrdHVyZTFtWHBnWFZETjBtZG5sZEZVZ1hiYjdWR0tjOERhdFlHeXFtQmdC?=
 =?utf-8?B?WStkRzRtWjg5Q09FNU9VWmgvbEMzVUpZdnM0bDZzUVhaZDdmUllzSGR6OFJi?=
 =?utf-8?B?MFZKTWQwNFIvWUtQVUtvblRoVlFocHh0QkdwM1d5ekNLQ2hmTXdpNkliVmdM?=
 =?utf-8?B?SHVLWXFBRWtReDRuSkdneGlkT1hlenFlZlJDSkZRVzlwbERuQUJVOUNtblJY?=
 =?utf-8?B?NHRYaE1QelhWbmkxaGdBRGNNOWh4TENRcU1aVmZqTEpSQXRReEdmQTdsbW5r?=
 =?utf-8?Q?Xm80SVp8bE8NOCS+Hjh+KEEhgwz9POx3MyBpBWn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412ac727-d722-4652-2769-08d98853d6eb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 22:59:52.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7QWw6imrhs5SuwFQL5ebqlZXJQDk4k5xqXTyGdOQiWsQrhjW5nNyLNCQW3Jh1ugW52S2luy+JGohSb5xP0Ddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050135
X-Proofpoint-GUID: O0u_37e_oFKxc7NYOE0uD1tAUU0zhhT2
X-Proofpoint-ORIG-GUID: O0u_37e_oFKxc7NYOE0uD1tAUU0zhhT2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 10:47 PM, Zhenguo Yao wrote:
> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepages in one node. For example: DPDK needs hugepages
> which are in the same node as NIC.
> 
> If DPDK needs four hugepages of 1G size in node1 and system has 16 numa
> nodes we must reserve 64 hugepages on the kernel cmdline.  But only four
> hugepages are used.  The others should be free after boot.  If the system
> memory is low(for example: 64G), it will be an impossible task.
> 
> So extend the hugepages parameter to support specifying hugepages on a
> specific node.  For example add following parameter:
> 
> hugepagesz=1G hugepages=0:1,1:3
> 
> It will allocate 1 hugepage in node0 and 3 hugepages in node1.
> 
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Looks good.  Thank you!
-- 
Mike Kravetz
