Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA53BBDA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGENsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:48:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60118 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbhGENst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:48:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165Dfe6r018914;
        Mon, 5 Jul 2021 13:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=OgBR+w5wqEYeiJkrN9NqA3RpM5j0ilkWysKEav4gMfw=;
 b=ykMESTwUf+5JzeWHM9kHr798ReDfuw55KQ+LPpYABeofIko1vovN+2MK/hfJJZEjmivK
 qhGjFuReRo+HjulOavjlgjFCCgG9Nv0B0Dh2msG+fUvzYM+hr76fv0CvqIEAPBK6QuXV
 dFgq+PJsrvRtF6cBOgPSqLrbhiMbY3wFj9uXvn1gpMca4nWyjwIbq9hMUtTaSGljIU+Y
 bZ+mCByOdHBpulOIeezBBQw0EnT3tU3Z2gV2+GZND6cD8U9hzJ3JQD52AImP+xxThaoX
 8AEa4uaXdDaOdqcPB/yL8qVqXVtkAvebrCEcUHq+BPsDaRUe6Y7pLA+EUiEGXuNyK/8b RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kw5k0skr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 13:46:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165DeDlu183501;
        Mon, 5 Jul 2021 13:46:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 39jfq6vs3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 13:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkDL52OEQ+lmGe2isFoSy2RPBJaZ+E4DwJb6hLFCuLDWJEiZ9mTg/nHJJ3/RgD9VpING4sQpGL1Goj+55JjIf2pzU9TKtApYBLOWqmrdRoxLCFKsTOO9ktveXg1QnfnPW3kdCT0SiGXJD1VmjZISNl85IufWftemCrilYXb0mhzEcmLQ74MjOQwf0LAavFgMYr52b71BRT8WnPg3ldNpaaDJhv4zLrw10c+hRGNlkRetE7Q7iWIftt3WAxxPj0szTT0SN4XOg+8psIlTCsYpNLS1Hf5h7EXSKdPV1GcPSA4K2IOBwIERCYUYdX4LNe4/+sy9Cg3FI+0QT/L86G3k6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgBR+w5wqEYeiJkrN9NqA3RpM5j0ilkWysKEav4gMfw=;
 b=PJXi1UNODZrXpS4khVAWWEx9ABubqjYflYn1Pks90Mzq7laFEHbYjIjvDTcLHVLN25NxtYjTs94n4g7ohNaaluNWK9XwcBR6JALcju4/i8TydK0FRtGOj/dSKfiVxhd3FxGeinMi57+dXiDnAD28Uwxix14j3XD2TYqgcYduEbI6GdkCHTV2hz2PpDuL1bmj8WlmmVYR5OSCrvJAbxLs9gMCCuA01KhwVKltGief3eCE9XJYv6rcu3nkEFzEWLUqh2GLcpmZCRvhbQTVpfzHcG0GJDSW116/1MkIG2PJte1Uwh75xnl4RQ72iFCV88clBPihAJnjFJY6egL0szQB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgBR+w5wqEYeiJkrN9NqA3RpM5j0ilkWysKEav4gMfw=;
 b=nsuTlZnxZ5k0FBLp7RgleC3VqF2bib7vL0wsU+57G0tm2Qs/uOVwi48SrATAF4AnF2NgdIeymcLcPBbR+nGqkaqRBX7YLS3Q0iASLxq1FU18iNnf8HX+Hs/PQYx1SNgfMVF06oRAH9nTFYpqmG6OZGuCi7Q1bQkqjIzodQkbeFA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1773.namprd10.prod.outlook.com
 (2603:10b6:301:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 13:46:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 13:46:05 +0000
Date:   Mon, 5 Jul 2021 16:45:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8188eu: Remove an unused variable and
 some lines of code
Message-ID: <20210705134544.GC26651@kadam>
References: <20210705134151.15143-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705134151.15143-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JN2P275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 13:46:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31716fe4-02ed-4581-86ce-08d93fbb3c23
X-MS-TrafficTypeDiagnostic: MWHPR10MB1773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB177334CCC72A74B19263FC3F8E1C9@MWHPR10MB1773.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTnPr9bYK/IwpG955rKFxXuPFg6vDZN9LJkPw5yiDDx6jWiKnjIODCVef7YBOHDW5Drw6V5qKANaQ0/hLp4BVxQJeS5sCciDcr6UILKQ8IIK6i/UAVZTsbuMAorbfFJfLb2RNzYZtpmU6cSxdyoikusDt9JBJDGfUUV1fEogQqiq7vVnn/cWg2q8JKhSUQPplwPtiG04TZw97y22KxHdFkehXbJSGIHmHmQ9/bEaUhN48rkCrdMV7wE8n+rV+imm8q1FB0zbdXjxoiMf0s4P2mr2LbYNrAWtkv4HV1xwBVFI0+OPt4vSwtSamZPm8d0ZTlRy4yn1+1e+iVH6UxI+yQBqtp6hidv8ncJ+UvC4+15KW0At93zIptk3wyEjdFlG/JpXMuto9pwxYiu9FIFA/ClHxuqvUTNdkf3rwmW6gTAuso2A6J3BFkV/obxFwBPHtaMFikw+17b2zlLTprEX+mGyg+mtlBIStgLs7JGwsgsDbObFfpB/zySw7NbIwJYY0jmP/gsmBYVIbPXLna4S5SaadJ4kkKd48eZqBFaW2UUQG/BKjCIV3L/xegHE/rPMSD5sbbS044o7HA1ScDcc8w8EE88ReK55lcDptkk7ccEFLPlts26Ll66AFCN1EiAfOb8MYFOPLTVpDpFT3yV9Uh31CeRPCQqH/eBGE3N40Y3JIvboG3JT5DKYTjjaJ2xef6XGc2vGtLh07XA9T96esA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(478600001)(2906002)(9576002)(316002)(86362001)(38100700002)(38350700002)(16526019)(4744005)(5660300002)(66946007)(6496006)(8676002)(66476007)(26005)(33656002)(4326008)(9686003)(55016002)(66556008)(8936002)(956004)(6916009)(33716001)(1076003)(52116002)(186003)(6666004)(54906003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6fzkdxn0P3ua72dgJsFMWROOCTkhK5fmVp56ypDrV7kCPRCPo7LrrImPnoFm?=
 =?us-ascii?Q?G1zUinC8xgdac3Gogzhe+LHOZfQ5lM/5Y9lbBZLc1zpStIDR9V+AT5dwjCZC?=
 =?us-ascii?Q?oCMp/dni1m19RhL807aln0ljDr8O3+D/dZdCsitjKC13XAUP2XQ07rEBqjnX?=
 =?us-ascii?Q?BS/RhzpP0n7fOnopK3lZsgtMEItNe2fSTVafAU+LXs6AQuLoRPP4haXkrJ6M?=
 =?us-ascii?Q?tY7mfta4Og7vmFrxQ1xo+S103wZYBC//vNNJn8G2F4hXGDoAPmfTrjag41cA?=
 =?us-ascii?Q?pCAZ/Q1uCJ3l2hUJDn1cpJ5igeHwavILv3DDqK2QboYMfxLBksylezlKHOAg?=
 =?us-ascii?Q?UNMhb/YkZauqllXghJ3HTu/efJGPlAFcqtHckq+h1BFMogM2vbAcLJq7yiaO?=
 =?us-ascii?Q?B/0Tnd3bR9MOa3cJoyupuB/nOYElX+dl5C/U68HHscf0LCMThkTODoqq9+bw?=
 =?us-ascii?Q?/zFHYzU1FNmLFec1MBzk0EtRDACyERm9DQfbIk1S6MLKjwqdGXVGumjHU4ar?=
 =?us-ascii?Q?SqEa+IEyQtBdBkjsRBHq0pxvoCDCUuaa+XeplF0O2aMbIPShgEG+tU/dOlP6?=
 =?us-ascii?Q?X1P+tXN8K/IYBSvo8U/45Dck+xF2jw4UMXmnjAy+1DgSmtDiux+8SoS0quVC?=
 =?us-ascii?Q?oIvTjYjb8yD7k3XsZjJMO9y5103tJM7AbSFZfaVRzBonVIsNHLKEFfPqZ1h0?=
 =?us-ascii?Q?kocArcpntHcCP2J5r5F7QlRAgymUqt+zcowW/akL+WBbkK/BLW0ctJSfr2sT?=
 =?us-ascii?Q?8dnWRCjV8RymlG5WKqzieUqStPykqulhfnXOelmtgruTvMpuWXJFRvPNgc1X?=
 =?us-ascii?Q?Gr/z74okjtMUAXAxFNWesFUPsIJebMXkhGKX3o6AAR/CfiPauJiVxtKSMePw?=
 =?us-ascii?Q?oPnUlNak8VJcAUSZ5houIUcYEMmZERZdSUxw/t+nQ0j3FNgiEz5cfub7wGWy?=
 =?us-ascii?Q?apGT3L7RDZapragUVTB4P384QvH4Z6kyZn/zFcqxMNx5ntcXT7KiV3F3buUP?=
 =?us-ascii?Q?8MiD1ukYFhMfjrkumOOzIsX7Xp1UQvgUI1tCcRrEUsHAI30F9ilDe7L9bHa6?=
 =?us-ascii?Q?9vXyNw0zftVTvw0eriap5aSEcosh0F4GtaiqqH5XQdSTdHOuCeNZeBiVKEzl?=
 =?us-ascii?Q?DcmHKf0wvv9g90m5gsOh/M3diakNWkXA45gHDthHEtPvV+oQzdAWIezto7Xy?=
 =?us-ascii?Q?Aw+6kQhH/gQ/Dsn2dBBldJb4vWkhJKZM2pi45tE39deWRAgy/eFf1THRnSS+?=
 =?us-ascii?Q?UwSZHkxt2J2E0hPefU+W5I7kNhC2GIkUaLD8KKQm2izTCsjsv6Dz/EGwV0kl?=
 =?us-ascii?Q?dNHxyinRnx80bgI0Pqdnt3SM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31716fe4-02ed-4581-86ce-08d93fbb3c23
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 13:46:05.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGreWrzisjgINWCoiLNGqGopeIrmPgUUYwQ/nnShwOFj2M/Ape4tTRV3KGHPB/79Xlb13+nQMhviPTVGNfZKWqSbigV+wAlbyw/uCufjiWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1773
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050073
X-Proofpoint-GUID: DDwLxEXWP9-23pVdlxdgZmEXOhlW51Eo
X-Proofpoint-ORIG-GUID: DDwLxEXWP9-23pVdlxdgZmEXOhlW51Eo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 03:41:51PM +0200, Fabio M. De Francesco wrote:
> Remove set but unused iw_operation_mode[]. This driver doesn't support
> SIOCSIWRATE.  It just returns zero and does nothing.  Change it to
> return -ENOTSUPP instead.  (This is an API change but we don't expect it
> to break anything).
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

