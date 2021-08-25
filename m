Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807953F72A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhHYKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:08:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20666 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234846AbhHYKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:08:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P8haTX015024;
        Wed, 25 Aug 2021 10:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=P6yMJ1wOoWRQ/jIvSaYTUTEZpWqBjWrWuJb2tmNzI0I=;
 b=Q4l1px0LEemBRUpR2ccIr0WbRUZzqei5ImU/cpSkpYts4qGH37mJeN2lG7Vk/BbrF/SN
 sgNZUD1q1n+D8nDxUxNZYFS5wXY79nya29KDCh/E/mYjCVUGO76BUKwYqMdET/cdl5gA
 laqA19DtBCP5X0znD35dWdJA05SWUTyEnqmURstiDvVPApz1mWHio7LsvTp8liwH1xSb
 QZ7kPj+YKIz27HYRX4AZMUnVEFHD7IhtxjLExEVh3qbdVc+iQ/hmJAQ+e7wNdm5QBPIY
 bnfya577lgrgCs8mB1mpQUHBw9wy6qnNVijznWXwhrL0omoIjxA/U9V58L9hp2/ZnZ9j Bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=P6yMJ1wOoWRQ/jIvSaYTUTEZpWqBjWrWuJb2tmNzI0I=;
 b=bbYV5qCkTFt9aBORSNjtmWxIwj7SYFYEwznuCx1y6v+35BzfZHn7gUqedJNN7srBuyfc
 WQbiFYIWNtreLunUPaD5KZT5x9+XhdDClpEVos2pQVTa5/tenNtugSuMRWz9dzVEsGYZ
 pxRNMV1MhyCJBgYNbDEQjeEkUx+3TQSwLcxS3xJXXmGu0bj9Kt0HkY7OEfuF7qPDSc1m
 0YI0rqKPFaV/9bGpu8TXSYiTvccq2iUPL3x2J7hnlTrcLCqZIo+TSpnnWiL5yDTVqeFi
 o90NKnY7S18spRzdyLgw+wl57D5dY222EzomqPOsJR933vBFhuuRifKfQB1H3/8+guKO JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6k116-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:07:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PA1dHx192752;
        Wed, 25 Aug 2021 10:07:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 3ajpm042dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ1qrrMueWh7Pv5pjuvgdj8MAkAZoMZ0DFgfVev4B9JZL+ZHws8Qher5odGxosmcOambHhRnAOX4ALiOQqeeWHdBO6hHHomzMDgo0f4HwkAjwqtQES/x8GeQn4BIaVQRTROWWLHg7rHIytFrlXLRuWa6oWXNpP7Hn5uS08krv+/mqfd4yfiM0b/fmyMd8RXihO8Fydsr2mcanExqTibeUfBzp8LtHuLjP5V9SlUwokd4CQhR3JKt1VzaYdu+sQ1FlclS91asDUqMVKWRozIbwlMBoHxMQGCEppX/K/Z38SP7ZahjapCalhrIFStblvhq25C6AAv4NrJ4fsj3d6JY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6yMJ1wOoWRQ/jIvSaYTUTEZpWqBjWrWuJb2tmNzI0I=;
 b=FkdXFdSVdCNs4l4iPAjLd7kx1gLlfmecq9dpuNfnkaAcegQI7ZW/XxlecKjvHJb6Xvg/uBi/y6fKHvezvAbvuOGhS6fEiDZwpMXVvTXPAGBJRn20ToNlmaC3v8pYE4R9TaADjht0I2r3EBJRK5ZPUSvKqBN7qOZ4yOupI1ArilsnAa0l5A0mHBP/HYWEB3D+5UBWNADmy/hnfb9kYBL1ZibZo93Nk/mj1Hcijiarabi4VaIpXodjc0Uby3S5zJTe/L8hjaEmq65RVRPPbVckIv28F7g1SAQVgH3cl/E1tAZwF3RJf4PALpGk2jd5ozPa+wYDIj1TBdjOnXlUomxnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6yMJ1wOoWRQ/jIvSaYTUTEZpWqBjWrWuJb2tmNzI0I=;
 b=IUv0fjxWnfpMswiK/qDNW1RS6UOO0QrS59+pEAOQ+yZN1hAiQPf1DVgmrxOdgTeuWLmnFj7jA1YIxk02pHVF2VcLbuQLsqvo/jc7PY8PIG97XqczPDCd1siLtvfz8Jes3kLB3wvsHQJqZYCvC2B+M1Zh17FCUsCEFl7nl24DwyM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1421.namprd10.prod.outlook.com
 (2603:10b6:300:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 10:07:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 10:07:04 +0000
Date:   Wed, 25 Aug 2021 13:06:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Message-ID: <20210825100647.GS1931@kadam>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <1665728.ljvk3MsED4@localhost.localdomain>
 <ab20fcd7-69a8-0530-7770-0e309178b0f0@gmail.com>
 <2227654.mbYB7oqmoa@localhost.localdomain>
 <794dfd94-fe88-43ac-c4ec-9ff7df9db6de@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794dfd94-fe88-43ac-c4ec-9ff7df9db6de@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 10:07:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f38ee0-1f84-4bc7-1657-08d967b016ee
X-MS-TrafficTypeDiagnostic: MWHPR10MB1421:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1421074EDC38E6DD0E76A6428EC69@MWHPR10MB1421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ctnfw9iU6OkHxl7krSKP/EJNPLfGo2+BAMDxf4UoYuDAYWe9VgYRepk4hLWCFuNm3+2UEs4TQrMCexKq1XGOdyMpzest5Bs3Lk/45RDGpP7GlsTNULCnxpowYXgp2P5pXTPk02Htaf06mux5fV5XgTbaqOiM2qqTQsnlY7k3LHLcIvkdWrh22mUHsE730zkO5I430H/cyZq1fL/Yn3Wof3RuAFC4rG3sDFwr/iU0SAQ3gtTvpOZiT8IdCBJbzIX2rQdTu+E8BWB9kS3NgrIomA7TUVmX6Hk1p1GSGLhNUaJIhq1h085Xi724l7ISoq4milMVnKcaOujBEfy+zESRZYaONjlExrwUzRDJVPZRpiUF4dieS1NwVBPQTt23x7DmasPgzcIG0lAb1fucflONZH98wy69JNtizFIx9938xLDU9fgBu3CdA2rbqNIoQpOUM2Ou+0+M3pGWfFXrLsMLAlOx1yk3ppEvj4XW8A6eX7gSfFxCipwZ3VAqiImy2LTkcxpriyUIyonnyYA3k+DqEDcrVWx/UGoJoenLepX6qT8Xl2WlWwlIjja5uNAsFzGlBWrY5dfrIrNzozqF8G1uUI0KjT7yEYuR8ehyk5cMo0scwl5n26KbN5gung1Z/RzXlYCB+XCuQRMXYHTRkb/T12cRLtzKn37Fn2EVsM9QHZ7Cns/xQ0c2BIJ1AjQ0OfvZvNmy94EORkKp5+DkvV8Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(39860400002)(346002)(8936002)(33656002)(956004)(8676002)(1076003)(478600001)(26005)(9576002)(186003)(558084003)(38100700002)(38350700002)(6916009)(86362001)(55016002)(5660300002)(6666004)(83380400001)(66946007)(66476007)(6496006)(2906002)(4326008)(9686003)(44832011)(33716001)(66556008)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xmZ76NAZ6SA+mNEFi34rPJVBgOrW1Zcezw/nDjDuhUcDH9l2S1JaYOZsTg3K?=
 =?us-ascii?Q?1KNOf5uTLnvetP+BzwsiaKKunxLLcDOqna8i6KIFB3JL24TLfFnMQCob/4rR?=
 =?us-ascii?Q?FsmbtCxqOxxYbPFJjmGdH5NFaj358GsD1PrPiuuJRFIOTNTyLr1mAwIsWnav?=
 =?us-ascii?Q?66UQdZkoInH5ySyP0jy+H5H3UscOoj1wh17aeoJ64iCHQ51LmJGOXJ0p1nsD?=
 =?us-ascii?Q?ES3KTIH9GwsITRfmvoAgm3KpTfDMN8eDqSo5SViYD4dtJ5+2n88cUEuSIFG8?=
 =?us-ascii?Q?Q/N8hF7CfN1JZxJ7o+HHWyYsIo1TRhBTNA/vlUqH+pLB907ySx9xRySw2FNG?=
 =?us-ascii?Q?beD7TPHF/kVrVnEvq0D/1xfITL/2gz6hMNt/jGAh4Ov5Q/C0Dcj4ZuHGse/7?=
 =?us-ascii?Q?81hwtpjtgswDQZtstf3fGrAdM/vHV2AfiHkkpoDiEsb4kfyhOt4uQF+RcTGL?=
 =?us-ascii?Q?09b4v22e2Ropt6j6Jg5URY+9PnixisJ8dEDKcQIULVt16DfjgnD+750ZAEh4?=
 =?us-ascii?Q?N608BJTxzsx3lfXiCDSQPYonEZaLsXpXdkYssQ6KewItnjSw/4u8a1tjQ9ra?=
 =?us-ascii?Q?pCh3j+mLXtySvDftuhsGGJ1E1oXpN4fzWHVBgle/Doi5AlmA3q2A07KUfmdg?=
 =?us-ascii?Q?24FjsFtFs7NU9aCGvNxmMfXQ3OKas54L10YhMb4JQezJtbjjPvt691kjzZiu?=
 =?us-ascii?Q?EVAMmX8zUOO4M647DG4yns6lMluxAK0/VemixDIsqFlRbhm9TGaf4YaujGtw?=
 =?us-ascii?Q?G5Ro9GTnMt9NqvTcqDoC85rDm78pbBCzLaX6XbvrIDec1rcy2WJQm5qGGDoj?=
 =?us-ascii?Q?7Xv6AAXkuf0qPOoTHufoKM4YLdxNwUuMt9TrBph26XdqaNVuOeZNupM+85yA?=
 =?us-ascii?Q?b+GB4+Z721aZ/lfI3qbQLtgUerKaQe2hFQRBuCVYOUAzo++qfUu7ArOMa6xf?=
 =?us-ascii?Q?cxSzhsAjKQjtAeM+iHoil/c+v/f9f+UqtDSLN627dQZdT1EkRwQxSd5/ktAr?=
 =?us-ascii?Q?g8wrawvVbedBm2xNezROjRZ6vAowOu4Y0BxdNFsPoFg1HfZoZrvPUiBpb/Rb?=
 =?us-ascii?Q?zoOlOOmXIynJUB4kbBC8SVdVWkA018YhPBwYjqDbL/ZRboMGN/uty//zpYrF?=
 =?us-ascii?Q?3bEYLgO4EaTdjeFBfjL0IzNYp/4wQg3yMGTircyEZLDKpOok+Ij0vMu4XTu8?=
 =?us-ascii?Q?MhLSVGO2LqFdeMh4BR14W+rqlWVRmne+ZAeZhpugZWfH9PAdBHlRtLjUdlCw?=
 =?us-ascii?Q?4qxS4Yb9K8aElB8FSFZZku3x5C0TtjuhCiHGwkHW47hK6/a/svAIr+CfujXO?=
 =?us-ascii?Q?Q5dEFhEp1m1jtjvqXdLM4Hro?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f38ee0-1f84-4bc7-1657-08d967b016ee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 10:07:04.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gkbKaEWk0n2T1H4EYOh5Mec+NdKWKo5zmGPJZeeqQ8Aj1xVcFvpr+sR/Ye0m0ZsPN7g7in26qeOhe8fe+NQ0FhkRoZxqO+q3NitYnrY2YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250059
X-Proofpoint-ORIG-GUID: mirrOUB-XntE5ZXKbpEbCp3EqHyxxIRD
X-Proofpoint-GUID: mirrOUB-XntE5ZXKbpEbCp3EqHyxxIRD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:55:37PM +0300, Pavel Skripkin wrote:
> The main problem, that no one knows who is the "old". Greg can take patches
> in any order he wants

Patches are always taken in first come first serve.

regards,
dan carpenter

