Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23A3E5E34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhHJOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:44:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50566 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240677AbhHJOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:44:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AEfvr9019223;
        Tue, 10 Aug 2021 14:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=P3oGjT1ZqleB231DNZd4mkxLbZUt4jTRWbHHpXLiaRI=;
 b=rM19Kelf1+nJNyO0OLVVNmn2+cQGKNvpVAYyM5MXYoljCxkcj7C8J1K/g3/D7MIHOCUI
 x7AoThe05u3yj7kcL9wJ+uibxqzvQ6SA/WA8/Z2ZrKHvoY7nQuSO5COxtEOODIPybLNE
 bSNunhgSZmHn2trLClan4l8R16+MZ81cX8nP3BQatBR/gsF740BRe2k4+te1y4Q/5Xj4
 lKxjDiOn6Ir6T1rrhFBmeEZogMdkqimGVQkEjhzeIgdTbCQgCZQZ1M+ANcexS1DboTkQ
 tfUj9RfJUk+5DByQDYX9FXotG8rE8Cl5kL5LtReNlg8964UGSgq3Y9SZkC8hKSpP+ocX JQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=P3oGjT1ZqleB231DNZd4mkxLbZUt4jTRWbHHpXLiaRI=;
 b=D20kAER01fVhcXlleFWjOKErUOap0mpg9N8E8pH3R6OeXnbPFF5/gKCvpJgxqfreQeqU
 q708LJw/7tE698mHuxeOJDBrsPhVi3RWTbRP/12bNfIgFH3T1G8DkYXdrQVk2gwrx5Ri
 nWqRWJ9iZPmP8JYdgmt4VpRNHn5IkzHfQc1YO3TJfCDdmskRs4CZZJ8lMGlAyYp91UxF
 eNPyYkdZ+taAyyzRNr8oJQ86hkQaDPKKAMdsqr16GdmV9Xm59cdz1Z0Q9AKJEB1wOFhT
 Aj2JgtG19ckvxHW8/I1Eje1aw50fZDCEfVZwXunCWibH5zTPCUaLU5gIg5BftC/Orh3+ ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aav18ma60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 14:43:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AEa6TT092239;
        Tue, 10 Aug 2021 14:43:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by userp3030.oracle.com with ESMTP id 3abjw4hgm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 14:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM9a0rHi3a82KI3EDNdIDs1Lnh/Ff+zrHBuvI8XHO1Ipem+u7gG880nQnSgGDYF9aPIp2Qyp8OdIsiiH51gcaGbsmQe3/6T++iAQZZ756cphZzLmH9gK64pxi6U/gXbbVyHcYp+7iJX0FsfmuqFZP+OAP31g6WGXLDgJNGIm3lFlVkglOt4fibTWLh7U3TZ0HQj1fIII2WP87e8x+YV7kimrEQ7ztpa3Mm/6PgtvIO3LJrKoRZ+HyDWAws7hCp7j5yywDil/TcCi5Ngi4af5vRsJlkYi9oyDC6hdaNqO/voM4xP8NTwTJ835tICW3FsobxYY+19C+y1zt7ilU8qzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3oGjT1ZqleB231DNZd4mkxLbZUt4jTRWbHHpXLiaRI=;
 b=Qr/h96UxLxbINCWaWGdkeh6HfJRjqfKLcytEVfAR06PbqFLcmhCC0VIDx9mDoGFqwNExiZBOGeNrMKVHOgxeB9L37MsoPRtdXtE1d2HNXbgwV4dWGg5qiG/X3TM2S2GGSuYNF293JK7MrvdRaiLv0TZN3PidPHuD42JfQin0x4EgjpiAtaFEiLGWZMm1DoOs/FOgB+qC7I0JBR2+s+l0nxi+Ez6hAGzUsqBKVT2v4D/h45aE5DtyMNMKfUJoHZc4DzcogtOn/edXPr7XKHu51LWLT+RrLjk4t1NVzOK2hOec1Rg+be3UbtDDXexBOm2/JWGwQjId0g7AvxIKL8qXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3oGjT1ZqleB231DNZd4mkxLbZUt4jTRWbHHpXLiaRI=;
 b=Wtg2zfb2c8pEOfDk0AMHjP2XlMQqsFcanB/KKk/GCMa2W/xbnt0k1jct0jRLdTQXZ961HZ9Fz5k66u4mAug7Fm5Jscvbr3rZ3TYBgv//vfeY80alEo+6GO7m1usQRpKiMgXz7df6kzhdzP7S1MQg0C7+WUYXx7N2/QgX4N9xQT4=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4402.namprd10.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 10 Aug
 2021 14:43:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 14:43:38 +0000
Date:   Tue, 10 Aug 2021 17:43:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH -next] staging: r8188eu: Use GFP_ATOMIC under spin lock
Message-ID: <20210810144316.GW1931@kadam>
References: <20210810125314.2182112-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810125314.2182112-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Tue, 10 Aug 2021 14:43:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006c9882-b090-4859-7702-08d95c0d3d66
X-MS-TrafficTypeDiagnostic: CO1PR10MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44026AB46F6A3708571FF21B8EF79@CO1PR10MB4402.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxwz6UoLCcAYHPJUGyGBo+z5za+bCCBSYBNtXWttlSgptfpNFDOy0/sF477l4HuZ5v4REYtbPbudKU4sp+0UVRMUHKBn2/5+jUHc+gZVeElYriASwUgrHzLZjczFIVtg9v5Wle3d0a0h6ir0UOW2xsHsA/NjOAWdhIUf/v+3wyMmHRHRK8+MDx1MSuwERbzKUYolLp8USivpOuJslSVRIeC6vNnCZ5bSvET3y0Wxd+57t+VDgONrYxf7G/rLARea+uBt0Bypy1PkfP5oF6MUqiB2sHUf74Qhpb8Zb8j6/rzoC7chKjOKIERaqKHBFhr/6phiOOwwgFpQA/3/y3ISmbE2TG06MyK6S/39shW1XtxQJHzr3YyuL2oo/TcdpW6odlvTPk3z16nMcYQJv8qTfP9I993ZWKF0YrtOXNVATVWoFdBAeQGlbElO4Jtn14Arlslt51Wz1C/AFmc9Fg2RztdhJqOX8GLd7gTkeNIj0nSpuxf95uQUCZ5yJM38PFbP++0HmAZ0MY8qU0b/E0Rpd+DmAIh8i8ebt58vjLPitNPCD2h03FpAtGQJ6XNS+wo51y90mQwAqEPOJfe2/FQpUbJAj/dhZupkITsz8oHkX98IRGKNUzPKbIx48x8nIstyQIFOdoDlhk2Gic/ipK431m/R8sbQS9rkVrKg+c2meFn+O1MX/fGuvvpD7txd9Aq8BUQJufYshuXuwRRqWuB1Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(26005)(478600001)(86362001)(316002)(9576002)(6666004)(186003)(6916009)(1076003)(4326008)(5660300002)(956004)(2906002)(4744005)(33716001)(6496006)(66946007)(66476007)(8676002)(55016002)(8936002)(9686003)(52116002)(44832011)(38100700002)(38350700002)(83380400001)(33656002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZy7wUAG3STPVDwvHSLortXt9x0Jrd1qJ2+a7I/iFm5fsDr/lPQz3ENS4xM1?=
 =?us-ascii?Q?IDq0L5aeAOb0cb9qD9stcCYL8LQB+X64kjb2Qm/X+FQZU5k5B9DJBDvfQAW2?=
 =?us-ascii?Q?t99Gbqc5oya7LWfXTenky2fnAloRHd7+5dN6xC0K1IOvr4l1FesE1TMVXY6x?=
 =?us-ascii?Q?Hj/wV0X5b0x8yO2JNic7thnrPSC6wKQEN9jlSzgUYNdWr8DKwFAmRu3qTwvI?=
 =?us-ascii?Q?VFNlDwoPpfejcHzYyW73wFHsJlh1QchoXsVxdsdn+Hb7jCq3TsTfz6kpUB66?=
 =?us-ascii?Q?QAEdOOD++U4QhzsoMl0YzZoH8gGlWObL2eoPcOqqIDfUItqQ8O3j4Q0SjpN6?=
 =?us-ascii?Q?IYOLqX3OQGRAYGqgBu2BHfFr9Z//rYjL8gL8KZNce2p1SG0EiKOBI9fdYmne?=
 =?us-ascii?Q?7q6mnTBrz6mWLpnIca2Vjy8pVF2z9ALzu5ctX21NfvbX8mZP9sI3hTeVtBaY?=
 =?us-ascii?Q?d/R44kiXOKt7fPMoPhN8VT85y5emNjfDwqFwiAK3uK7WcCKYE0zfsZCftS8d?=
 =?us-ascii?Q?TYVKCYlgU8RbtHVod/Pv+C5htxPFI9UE4HFtj6T+F4iP51pXjXvfQ3afECZk?=
 =?us-ascii?Q?G9XsXOvh8pY3jqDLLSevrKxbSeyqBy0i7VdEK6n13NvlO/gNjg5gIXQb3P50?=
 =?us-ascii?Q?EWTYKZ6gAO5eRBIqaYMRzfdkoyImLtB8Axd+ca0fhJMD+aUddR6s/AtsHsM3?=
 =?us-ascii?Q?kzm37CH1Z8GNCX1RKhrLzetTmonZ7ZdEgmkV17wBTGp3r2ukI0vDOIG97EWN?=
 =?us-ascii?Q?rkeAzYkQVipaysy4F6TPTy1jERMK/q1C/GdrD17G8t/KJk06qun0jYmR9D0V?=
 =?us-ascii?Q?EX/2rYAuSBYqa/mP/uYgHp7RTh94Q9iK+1TlSwoYoA2as8uHtgcIS8Tugkq9?=
 =?us-ascii?Q?9BgUVe70ZJDn2mNc/4Q+XIcRpAcDqOLTX/0EyNs8anxuS6FEQr+w+7p78gef?=
 =?us-ascii?Q?T4WIFOMZvDwstfWNV0cwQxofmO9I2VkL1rrguUOONUuPsYv/NnCRXJKlbDZC?=
 =?us-ascii?Q?CuSmh5bHW1hHQlmf8pVXl5jjkYetUAcLD71zqhzrJXNv9fZM4eyzHlYDQmrd?=
 =?us-ascii?Q?OTk+qDZT3c1DO2s5uKGiuDFPeYON2RTq18ZrNj1CFq6by2Y8jfbSH+ryoiqU?=
 =?us-ascii?Q?osaVbKuk+flYFZpBLxR8g5l9BkSC0k4bzLNkD2uzpHDbz4gzg8NE47rKN/8J?=
 =?us-ascii?Q?4EtUzAb7SyPv/wSOTGlRvi+H135NxTir2YaCaJUPE8xfvxskF+iiRdKvN/fs?=
 =?us-ascii?Q?sB/kCbRZ3jfz38pvT5nPpwpTQhWzIKviqUTHciIHozxID2LL/PiTlpyqSy6N?=
 =?us-ascii?Q?TBiIZMPzcv0PV6bsQiK+2Wfp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006c9882-b090-4859-7702-08d95c0d3d66
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 14:43:38.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVdnexLkyJH5savarcO2b/jCzcunvkkQwAvQbM2/ecyf6YSbcIof2eRw0Cf7AS6zvNI9GA23m6MmUfgL3mgTgkxUglGHh/QlCt+OVsapEPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100093
X-Proofpoint-ORIG-GUID: v4V-DwszaXsvw44MgQvzNe5xh3qXAV_0
X-Proofpoint-GUID: v4V-DwszaXsvw44MgQvzNe5xh3qXAV_0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 08:53:14PM +0800, Yang Yingliang wrote:
> A spin lock is taken in __nat25_db_network_insert() and
> update_BCNTIM() is called under spin lock so we should
> use GFP_ATOMIC in both place.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Good spot.  This goes back to the original add a driver commit.  It used
to call rtw_malloc() but that was buggy.

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

