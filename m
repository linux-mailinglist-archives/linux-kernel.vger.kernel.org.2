Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8B3E1881
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbhHEPpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:45:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32104 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242386AbhHEPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:38 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175FWbAA009528;
        Thu, 5 Aug 2021 15:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/jMgebvyLrZWFbWjamVoLcfrfuhqdnh1kwBkZItFzT4=;
 b=IAPc6hd7VQvnoIx8TiXWABr/VAyCmXJDZVqIlhmC6ISiYvZ7ciHQbkkvKA2id+lj1AOC
 wYfvpDEEf4xRftfAt6yIjuBFrblkIbSl5hYIiEIMBnS+U7V5XlLpFAozI3IGcx9oBpR9
 U5V60W/0A/Bt0syuhNe0Zepol60Ioxtb/SFpCcomLZqw0Rh/M4NVLLGnBE33d87aG4VN
 FQMcVbnVn7ng92jAkA3bDR0/o885kHg53/tI3J0+RaGbNHpCNzufQmq86DEPp40zBN7j
 ILV3HnvYB3eq0rtY0ut7g472/RUAFcAtoyFKOMQbxZJ0jhzcJeOulVkteCA1w6WrlTjP vA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=/jMgebvyLrZWFbWjamVoLcfrfuhqdnh1kwBkZItFzT4=;
 b=0Wes8v8gsx5pcKjHGTiiwxMEL+zbbWx2CmnoY0PDnu0l2b/7qG0E0RCU1JoFxKQEYnuz
 BNzjmUx6aEeQUsaZqQ6RauHcFki0Rvgy88PL1ngYD7HknXG63PDeuqTBPC3S3YwqwXO+
 36ZQX+FHoJxMXc5KQzdR6PvGxx2peXDR+7guUXwvDduwUw+fPkSFhJriaO3MqwjPc/nh
 FR/uW6tWJ1UrrPaexatEwlrXOYLICxte2suAPswJxL6r7gJ7VBtfYqevpPgGdtONOAOa
 aWLfXpf99+592Wfd4TSbMzBrSeHvMdqpgLrOtyg3MG+1MhRbvpCTwCzpj7cT7KbeRpiA GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7wqv2pec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 15:42:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175FffnT012582;
        Thu, 5 Aug 2021 15:42:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3a4un40445-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 15:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh+CygA/2XMB+hL+tCYNQ9FVfVc7QP+8S5FTcvMLjX37I5qAgvb3hK/1DIjFjHPdMhY6CDt/UEDUGhl+Sa9eCXACZQwbRZMfzoutqDVqtQxHvxQn92LOHtM+UXpgoo8kQPRayMnBHVwGuHypnm42EKmxqVDFPffc0nDLVbjnZYWisq26f+XI/l6olrgx6WzhpGNVLdvzA5nP6VzfkYQVn8gSlWNESfNVZvaddg0+ngqVLSheG6dkW4yChbebB8ISnYxTjMJA6VsLiKeg9YN7YzuyxD0k9b484+ciqFgAMnIlWuxLFsKWhx8eaCyw7K9b1RPbpAtSG+KvPgHk045ZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jMgebvyLrZWFbWjamVoLcfrfuhqdnh1kwBkZItFzT4=;
 b=arOdRRajDz6IbmLpwocy3GpnjNlVT2lDUERm0mvIJg+fRbQ97Y0gdDoQ69DTpK80i1agvj5PrYZjfsykRiPg0VfFH8XJ2BcoZL1EB8Kz/yjLv7J57CvGSKvf2L+CA7wRJ22DWViWNDTl8iRUny3+lvOSxXx9PcWeSfQ1uzXb/ucaLZcRD71qUG5tA5WAKihnKYvvNnQHnvCPFp4JCkpmqwy8u9FxJVt3reHRAYvLMxP/f146f8rIg+/ob1EfKlkxqnAqzFvtleiPk+hEdw3opaI4r+zsGRsYUbMTQJYEW5FX8YLXWO+wg5ApwIRk3UEq6HYw66xB5A8GKCYn1W9zgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jMgebvyLrZWFbWjamVoLcfrfuhqdnh1kwBkZItFzT4=;
 b=sDQXQHe5MFB70x8iR0adhNWOydwfM86VTDgNt7L0cfdFKg+GGM/tNCLUrAdw0dWWuHw5H4tAHcYlEBUei0Pa976rIZzlzAEp5IwUhdZP/EcnrUnQy+5FZt27rjJy2RBfYxoHfRmnh1ec/uusGeEhi+wUEu+RRpoh1a6rjYcf30k=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4577.namprd10.prod.outlook.com
 (2603:10b6:303:97::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 15:42:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 15:42:13 +0000
Date:   Thu, 5 Aug 2021 18:41:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix incorrect types in arguments
Message-ID: <20210805154153.GK22532@kadam>
References: <20210805131108.19775-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805131108.19775-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 15:42:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a37368c7-2a81-4448-24c4-08d95827983b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4577CD5F673E9C078138D6CE8EF29@CO1PR10MB4577.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcNHQWGCXeTOND6M5sGJN4Lt4Gs8FogIJVJfv5rLsXtL1Qd7QEZ8H5OFKsWvd19ZuukCxpqIqIC5f4qbDMWjN1tN1DtCPy+K7wF7GG56EvwrnL7F/dA6VOiuAnO/yCfqNzhMqh4XieA/nJKkg5kKWWdfiTHYM/fIzQYN7ghoS247HF7ilWOXfrSbV36HVZzM+kNFT7nOedCvnHhSPZj7EfdjGvs6/ZmXDqhc3scPNO+OoxGgKVFi40qGU/Yp9XCtd1AMukYBrWcf6t9EfMJLhsMbnjL2Wg2nxyn5KN5vD+USX5xqZLnhCPWkWlcM5sIC/VS2aR9tfScmFl0tFheSZSrCGqBf/0TLmAQF37ndM1Yh4+Qb7v6hBxUoX/rwm5zhcHheK3hj+kA1c8n+dn6sKnXh+8+siiaq8hTLpDAhsiFQ2NYaTE3bFZzE1N3tI5FdQtA0LvJM9pIVrLgWcHRv/S8bmsBC7ARWPGEKrbzq3felopDWdgTO/CzNum4YgXbBff97CRWEu7fAkki/YBnkqNUHJuKSXbg+V9PJj/7HP7ekot9Fm5ZETqBQgAL+Z8bC6wylTpQZ/ZcR0DNfm+gV4JMEypjfna9LRYBXU22lGUe5uCUxk0uYV9lFXFUcBSTRXufizL0pZ7fENFvwa/NTSRplBYEVbE6BfgZsDEyetfDFMoxrkyDSOHHYPyi/tUxyQMBvCit5n3YHcFZ0KQ6fiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(33716001)(6666004)(33656002)(54906003)(55016002)(5660300002)(9686003)(2906002)(478600001)(4326008)(44832011)(38100700002)(38350700002)(316002)(6916009)(956004)(4744005)(6496006)(9576002)(66476007)(66556008)(52116002)(66946007)(26005)(83380400001)(1076003)(8936002)(186003)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udNzozK6G39m95m6v/aF9I2SRIz9nji/VgfeLmbxLM89bn/1YGyR+cfR/L7s?=
 =?us-ascii?Q?8lW+SVmXSh/fQ7BdfF61F+jOxwyzADa4oJ9UE7JQ7UsWkmluWHpRG8oy8cAC?=
 =?us-ascii?Q?n/HU+uqDkZiSwMd64isANiF8DRcK+MGmybAPO05Bg6clGiIEaNZZ1iigpKjq?=
 =?us-ascii?Q?Lsz41Ypm3OWajx2JJXGGABe7syz38ytxZbyD4g3uFpttIbNPg2Wm9nIExrXo?=
 =?us-ascii?Q?2FNC0HT9PinKsZHklyywLNmf9LpvzhGDIvlVDBI9c18wnSqa2YVbjpuTTPh6?=
 =?us-ascii?Q?RB39rWNf0QPCdyh20caj3bF0qneDu5rgh1B10E2ezIZrSrCkNUSyAquGRiW5?=
 =?us-ascii?Q?mkZIwINXKqE6SaAUPEludFZ5vn+dxJpvv5LmDa9JJkBc177bousXBjN6gZ0N?=
 =?us-ascii?Q?bueEe+3koqW83bgSvAiIieXzaFjkfJlV1jotQz3Ju0mMxUSAEBzH3qZQfJir?=
 =?us-ascii?Q?XQNz6bQBQM4ma2g5oR7g/OfHQyTdkPqHLhMZqB55PimjPVxYXEmYwEeXnJKi?=
 =?us-ascii?Q?b9zn1MF9YuIcCv9NwRHWLV60nngy0J9HCieg4tujeqspt5VAwbhAWsu4avBM?=
 =?us-ascii?Q?Ugl85HRZcZMcpdUq60CM4rhG2n0wOiY5UxKrTaGGQhG6UTkxODf2oLOFoZDD?=
 =?us-ascii?Q?X5/8phBm/H0fIjOOVn9DwQv2yQdreYgsN5fzGy41KZjeqDxWjRFcUIhnJ4pZ?=
 =?us-ascii?Q?YO12sKUJexjRCMocWxoQ0LYw4C14bi+X0UWw2n7rQWxGOw4rroFbUUHe2mOW?=
 =?us-ascii?Q?HS7y6zR1El53k3yBZh+GIMNmZfoRUbXm+YejkxRyysgralGvDbAskgjGYLaE?=
 =?us-ascii?Q?G/hiH5q8gwjzBRC9NS8z0AH4BL30/EWA4Mt5XEfj1yAKyd79+mWPxSNoZ5FH?=
 =?us-ascii?Q?+f7w7zPDt+umsM385FMiq+7Zcet4M/G4SCj+mZBPQ26VakLOJySC61XCOix4?=
 =?us-ascii?Q?tn5ljHk7jE4cjCWcqzdHVBmW5PdOln2SOAqL2HhZeXEt0AiPVXdxDLERer8r?=
 =?us-ascii?Q?ddYb/Pd8qxFYmP/pbUpIzGzcyJkzJjUcostwDyI27fC9hW7JVrHjfXf6quYv?=
 =?us-ascii?Q?9VV9S4JNMXzWD5lx+MxCrhycj9OatqvF0/ZiyQtDrZiBWrJHxePVO/cwthOJ?=
 =?us-ascii?Q?WWGa/ECvdVUSnHQ/KvpyWWNMlllo1YRlvcsiKoixO2V/r5FhrjoJOk1eNvsR?=
 =?us-ascii?Q?EOpLWa8IVz1AWHBC3jRhkaUKtKladpwHxizvep7Fs/cjF8LiAgrZRYTEgLUm?=
 =?us-ascii?Q?bNfVcaE68HDcHWADWi1IXn31BoyDGesuIKbHya7ORDfBU6OSJz9ka/fDL413?=
 =?us-ascii?Q?te/jVf8Ox+s49IksT1L6z4fX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37368c7-2a81-4448-24c4-08d95827983b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 15:42:13.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNvOtb/vFlBRH3R5Mxbx+Yd6gQKoxQUJ58XmVah26UnadzY9i1u7W5cjWwcTAq9MqKwvr6w1DW/2Jn1Poia9uw6x4ShlROCMndAtEl9cdCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050095
X-Proofpoint-GUID: i3yImPFE64I6EBvEG9kc-nVuEtuRrF7F
X-Proofpoint-ORIG-GUID: i3yImPFE64I6EBvEG9kc-nVuEtuRrF7F
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 03:11:08PM +0200, Fabio M. De Francesco wrote:
> GCC + Sparse emit warnings of passing incorrect type in arguments of 
> some functions because of different base types. Fix them by changing 
> the types of the parameters of the above-mentioned functions.
> In the meantime, remove the unnecessary casts of those arguments
> which are then passed to memcpy() within those same functions.
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

