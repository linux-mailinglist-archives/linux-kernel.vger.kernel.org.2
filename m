Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685EA4452AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhKDMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:09:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55620 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231660AbhKDMI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:08:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A49uwWv019885;
        Thu, 4 Nov 2021 12:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cYVIqdBQU4Jc+p+xRheb2F8YqLfaVtq3D9VOzCseRL4=;
 b=mNygIWpbRDeNfGQ80qtbRkFEj32Csr0PVe1uX2sNdPK2SduzqtM0EfA+PffdtismWYLI
 +m+X49fELQy+hCbFQNl1E9ZuqMmXFe0ZTxOSllzVKkpOD3GsLjm6CGYauzvPkeCWfAYh
 6PkTPfUb5Jempt9rXJ5BJ5HfUkQWN8BzzZGtk5AiJr4e/WJjkhXg4abrMJP2+hwohYGb
 4qMreijWsYMDT2LSUw8h1Xa4ldrprfGnukAy+OKjw5IXJrqHXYMUCo121kJWjlBzGm/Q
 zeH3Xls52wDLkdtBatepAvymiR7k3IN/vXKwsL33b+1qH8YrodEikUqRbf1aKF4l/bkk 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3mt5g1n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 12:06:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4C1jip119188;
        Thu, 4 Nov 2021 12:06:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3030.oracle.com with ESMTP id 3c3pg03e4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 12:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5YWUplWg+riKsG6/36ZDgI7myeFSUqGopmdNKEW7jj5QcM3zZflgyEdpvHEODSXhEt0AeuqK/Rl7ujwZ0pmLV3Wg0tJa8JbP85+pA6o495LRzzF2agvwwrSNObVIMYFwzCjTp4B0Ckw+AnkPBnV+d7MM8fclLRYkn9k6tmYbDLPVdLzxwueaPEzueanv2ZmfaK2CkHXMfX5Sv/B7f+jMSYZWTIrgaDHtET0+ra+wlFNcCWR9Fc5CpYlUSGw6FGBAVrtvsQk2JML67jOWimqRqWLDiWm17KEoGWg3iY/6iK7fwss657C0pyhK0RHbxHYegrwKhYBehui/4puX7AyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYVIqdBQU4Jc+p+xRheb2F8YqLfaVtq3D9VOzCseRL4=;
 b=PSINkNOn3UTLavnS44R7gT998kVLjKYbhaokOSGPdck3BIE6M/3+O/Gziygaw/I8mM6MD2NRDQR5FOUz1vOF0ZaHnThxWNQ2Z/TJrXETEpKjG56GY95g9i9Rre5s4uTftYHkxg7bOoz4InanL0dozyYw81o/6MDduMthz+PtsOuWvwAsTjy/AYfLjWbdHdv+IAiW4JWyXZ8ciHR0jPgHTQrzO9cggn13g0XKx2GEMQUy+oF+qSM0EjT4IZy8Ek7FBhsoZQ6M3vRryHkZUVVliqPTOGHmqfY+5qrm7vogNMrSlMCk/vMPXda6SWafzHnakbIPLOsa8gd9BgBSl6taSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYVIqdBQU4Jc+p+xRheb2F8YqLfaVtq3D9VOzCseRL4=;
 b=rqTDatN637xra/KVnT1pWmWhkuUjJ60oRPjFPHpQOg1lLPbV+FQ/AxFeMAtVixqWp5AukqdimQLVtTh+Bd/zG93S3ihvbNtPvs8vfykTTWPNf6oVmIqZFJThmInEoHERogp5jipF/0niCPf1cSXHL7xSEC2R2nmN5r4l1HIRGUw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4433.namprd10.prod.outlook.com
 (2603:10b6:303:6e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 12:06:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 12:06:10 +0000
Date:   Thu, 4 Nov 2021 15:05:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] staging: vt6655: Introduce `idx` temporary variable
Message-ID: <20211104120552.GY2794@kadam>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
 <34bd0e8f42597edf006a950d420345befc4e0bc2.1635415820.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bd0e8f42597edf006a950d420345befc4e0bc2.1635415820.git.karolinadrobnik@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 12:06:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77df47de-e216-4136-2669-08d99f8b7d9e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4433:
X-Microsoft-Antispam-PRVS: <CO1PR10MB443318D92EF1A76D9C7B1C2F8E8D9@CO1PR10MB4433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFKEJxvORPxo4TzVFSRLPL87PX95hcyNU389UFtCV09lLHUpFUCQJvjge7s2BFOhkYArO72/JQNAoanzkq1yBYfJAUMgEg+qaXhItRVqKmcml8KimpAFUIymyT3tnzHatJrGAJPQU9BzQmHfX89OZ4v6W+dpQF5/7PmIBAI29qYlT/d35T+X52/eCcQ0Raf+GnwwelXcOBZqCeucfBSRN3JVGWs30o5qP/C5LAl+Z5/AlsUS0/UU0yiA4kH18nKyPSUSHLo3iAWydSB4W5I/x6rXF/e+bI09eWsU3V4xCpGM5s2L7dTpS8YF+X5L5BRHmqiRpyTri+rqclosCcLZBtyIdGX6ZpTkg0gitgeIvDCh7NMUtgv12TJCoQ1g4cD+tb3gHImr2TkszsBBfJYIz/qj51GTWKVJrxa8GRsxGBvmHcY8MfCPQ9JzJJ0G6+a+CRbjLQIlN7/Bpo6QueMXwzD5fcfbEJvWOBt7tOOv1j04NmYtIRVrQi/nqF/kPTw1D5NwAaJL6x8xBGq190hNjn5wyQDtkHFfHLZ57GBOdihlm9xtNhpd8OGMDJfAZiWH3c33Qwat8oIt8t5evZ9fdJ0lODjf4ABp08Yvr8Pj1RB7TxHt4SiAdAv7yub0a0WLV3nPkBLNIR8bYIK8UwsMlYB82sDuU/lD4VJJ1gAYqxafz31nCXSqO2xG30TV0uhcgSFFk+dz5YkUYJZCs49TSbXJruYtxE+V691p3y3WP+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(1076003)(6666004)(8676002)(8936002)(9686003)(33716001)(9576002)(66476007)(66556008)(66946007)(52116002)(2906002)(6916009)(33656002)(6496006)(316002)(26005)(86362001)(38350700002)(38100700002)(4744005)(44832011)(956004)(508600001)(4326008)(5660300002)(186003)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pr5q1ejNnNzcMMIMtxo1o30xhwJChirqotX4Sv6rfYq5hQOvwlINlcznuXCn?=
 =?us-ascii?Q?Ch9z9bTEQmeqyl8OhPpvuM12fjE6yWt3a5SdKOkx6dc2yc2YobAC+z/h1VAB?=
 =?us-ascii?Q?FI+EvwMdq3bkPLgOSIcc91U2/TCPANqhm38suRon5o2PEwroOQQHM+dg3hPu?=
 =?us-ascii?Q?qr5glaxn6BG3dvtGzsmw1zP69/iwTqmQic0Yg89qXxB2VdoQbxtHw72YVOde?=
 =?us-ascii?Q?459QwHVB5LB6YTWLTLxCWeEWg3nf6DqsB8AN+fV7jPdK1/p4rSlhqjS7rOQb?=
 =?us-ascii?Q?CTJ9mrwCbWftBGOMNmGuQqU8XYFf8nHh1vwAwGjkifgPHTnFV1NdPAQWIbO/?=
 =?us-ascii?Q?bXvlPxGFR8Ih0HlJdr+A2JpqilE55BUVGCkB0Ln7Kww5B4kft9SZ1e173uie?=
 =?us-ascii?Q?+LnIQMyC1Msq1x92pSBqWwL5aeCz6aBlwYm1dnZ32l4r5Fc8yPAdPAhXlbhj?=
 =?us-ascii?Q?EmD/K+smJnS0My7eCCarR15gUE2NCMp3OVIFG9iIoN7VTNl3Gpa3QXxCQKiZ?=
 =?us-ascii?Q?rb+i1KzhspNo85mYp6BNh1XszpH99wvOKCrlI2SYZKkIFLYbxxxKLkwl1nEs?=
 =?us-ascii?Q?bKcd/zISvAOUTHCT+R0s+77qMyPzK1rx+MwCKHzuZnw2MuCfvVQf+qnhnDT5?=
 =?us-ascii?Q?ARctIl3blqD/3RlHllVMjBL08tToRDleiUjtOK+R/sBL76yvjCO6tGGexhPk?=
 =?us-ascii?Q?OSJJ2M5Q0x+gXDjAdFs0gKMkhgrA+H316IbPtdls5y0aglWGecPTeh7hhmbl?=
 =?us-ascii?Q?85adhcanrOP7Jyqavhnc+SWibGE1qWGpHorLBLVvviS9/K6RsTPQGoy3ci5C?=
 =?us-ascii?Q?hKg4jFpY/ynuenlqdKeHXmHS3ImRM2I1bpAoJNTHcjEdnfa0cLamli6JX3QF?=
 =?us-ascii?Q?9TIlTPVWK1EcVBk30gkn9f3dhLXblWwLWawRk887NGZgwV10dPmXxrvB18Pw?=
 =?us-ascii?Q?Du54EE/06BVdAh8tNWaTxPP0keI8/KlaJ8PYihbwYneSpddnuY4I68g6NSLg?=
 =?us-ascii?Q?joahs5MxV6mE8KjB02MEqQ0OJd59JKEbZ7ImrozpxnXBDFDVvd09ftLrPFTu?=
 =?us-ascii?Q?an8B2ydfpREmGfzFnF5wm9dj1+G90XbB4mfA/T4JV7NrQusDiEYDRWVbVmIQ?=
 =?us-ascii?Q?XfuFU4MItzAz7FUlDIfJUg0/N0Ti1Io4F1yW3DL+kgqniP64ajjfPGDbXYor?=
 =?us-ascii?Q?anpQoNiAP7SWTOmXT30QsYbFlGrJTh3V4yZrOb8KLdXe/HMULsTrARLdz6vC?=
 =?us-ascii?Q?NGPhvyh6AmaShYQ5rXxeu/y5cYrJ255ziqEVklLjh5APYXRzt1E8LRkBXHVI?=
 =?us-ascii?Q?av9sdyZNlV3Bdqw4gOoYUfFpLjulaj1Sh7/CgiWeufIblqSs445a2vg4DyYs?=
 =?us-ascii?Q?AqD/0OvNY880v8od5sVzsETfidCsJtFr3H1ULmFKn7SgVHQvQDUPwyapmjgf?=
 =?us-ascii?Q?n5PIHsuMZUzPRbzNSsHYNXCIV3qJnOivBPJYGZLG1vGnEqQqum5CJWHCcQx2?=
 =?us-ascii?Q?k5WaCmor39gVeo2fVD84yKyyBPfJV3cnlFvYwqSgaXJTY/68wx/hDATuXuSJ?=
 =?us-ascii?Q?w8Bt+JuWi5+YIGnHoUIdgEO6ckT8pZ3XcZBtUC3ZfB7f2bRnE4Tx+SsvhOb3?=
 =?us-ascii?Q?S6BCIQSMDnR5jFPUWNaSDlcCXGg1uT00v+4fZxWJYQTkVj7WYSFPH8BTf/e3?=
 =?us-ascii?Q?oxvuU2UPKep5sMv3z0OjDq/vIKg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77df47de-e216-4136-2669-08d99f8b7d9e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 12:06:10.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN9pQcX5WwqhuCSGRB40dmLTKVKSB0ZLYXyCHlwJxj6e+TvzQi4Wm3nsqu9xC4XuupCg00N6ugUn0VAcXDLwej+rnh2CKn7IcD1/GBDLirY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=967
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040051
X-Proofpoint-ORIG-GUID: 2qOtLB6HoNSAwwkR2Pskqkzl7rWDh8Xh
X-Proofpoint-GUID: 2qOtLB6HoNSAwwkR2Pskqkzl7rWDh8Xh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 11:35:31AM +0100, Karolina Drobnik wrote:
> Add a local variable to store `MISCFIFO_SYNDATA_IDX` offset.
> This change helps in shortening the lines in `rf.c` that
> are deemed too long by checkpatch.pl.
> 

No, this just makes the code harder to read.  Don't introduce a local
variable which only holds a global constant.  Variables should be
variable and constants should be constants.  No one wants to have to
look up things for no reason.

regards,
dan carpenter

