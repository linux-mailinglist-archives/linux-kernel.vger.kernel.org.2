Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53815415A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbhIWIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:33:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12006 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239676AbhIWIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:33:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N8FfEF003039;
        Thu, 23 Sep 2021 08:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=enMnLruuqYV8gVeYWG746lI52/sFLuzoTt2Bwjo7phg=;
 b=oGbrzDSNrrNqKWWV0+kOZQaQ4Wp/SdMMXOZEoGE3OSFhTI1nL+osD9pBgqPTZIX2uc/9
 hNdMX8pR1NnjFW1FWoYwPkQ+7fjzVww6stB7p4bYcQn7IiqucQgZBfcl4vzqthSLNOqM
 ZqQ++LeAl1RV7audcTR9WNLXKAWms4f9i2v1PVjZGCkoi1FEhP7dGv7uv2B4rcXZ4WED
 7LpVsvDqrKaPoie/5hKbMGydRyj1yD+WhMjOKLIieo22VgfDmZqckToNRf/vSfPeK1bh
 lcy+zxEAPZ65i2n/c5868qw/f6Rp4hs9HhgCqY1nSNmmtgOLczHC6P+W0WqxrpMrtiJR Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8mdbghr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 08:32:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N8OqxY107255;
        Thu, 23 Sep 2021 08:32:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 3b7q5bvb8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 08:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyxJ1hFBu5LmgHeTW3zgRn7NqG+lOEkKmlNBFA6d3Gr6NSejOpHzne9Gs5JSerDgENlczVp7cwVB7gBJJtMkxRKJsYiW4cgjV1PMpi1mNkaPtcVsJ4Y6/YYhAYq5Ev44j7YAH2vsDP11WfirvEmAltgj3/S1VW2iU1AW3LwhF/+85xwos0x/NVPJv7cl3la71L/XPT4qZdvZvEZMP16Hpb1291odFrg0yKFqyFE2hN3iM4J07e1tsZ0wxoKcapgzDVrGwaQvjr/eRKXuC+K00/vNkjC6vtNzznNeVjIqmGUVpWKoFtjpARPs3c4wMIJUcCGFoSK2ZvIXF7W7GZDq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=enMnLruuqYV8gVeYWG746lI52/sFLuzoTt2Bwjo7phg=;
 b=lDeEynhShNtrda2hCsmkGm1MampnUqEq4R2qbP38FXJ6bI6kTrSb1fyXJSVyyfwG7vemD6iyFnaGF1biWoj0XLD0if1+cYY3qpwhglHKgES6htcHi4fp/p2ILMb+EAx4hX/evi6aAc3AFxPzldm4I5qTsPanA59FSalneQNPObfOPhy3HhGVyjEAg+yEJc50catjYgY0HNjtGzc1F3aSS7EcPtQyfMY7vM9q0uFmZMUnTSDs2eHG5NFABNxppsDxPtEvd94sJfnO6GPfdg2Z+PkjEzSL5BarPW/XUT7kTy1my1s+sb5VA+mIVWpyhOCKYPGockpnUTWreeRidjwrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enMnLruuqYV8gVeYWG746lI52/sFLuzoTt2Bwjo7phg=;
 b=kmo/c5/jHxXg/kLLlb8JR9Eqv3v9I51nkYM2BM1gsWN/dzIvRE3oU6gs0938vGcQK/RDxWozUe6Mg0EjonJtwv03Za1TSUOFXbPgLV5ju+5MuR6QemYd1HdF35f8VCwcq+ZvOTBeXYJEwJoeSGbHq9cWNt3t7MyMZih3MMunGlU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1568.namprd10.prod.outlook.com
 (2603:10b6:300:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 08:32:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 08:32:06 +0000
Date:   Thu, 23 Sep 2021 11:31:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] staging: r8188eu: remove dead code from
 rtl8188e_rf6052.c
Message-ID: <20210923083147.GA2083@kadam>
References: <20210921194658.10654-1-straube.linux@gmail.com>
 <20210921194658.10654-7-straube.linux@gmail.com>
 <20210923072929.GA2048@kadam>
 <2d2b1e72-9c74-a2c3-2fb7-dc0ec41bbe03@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2b1e72-9c74-a2c3-2fb7-dc0ec41bbe03@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 08:32:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da30c19a-419d-4a21-4b09-08d97e6ca09a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1568FC444595849950D361F18EA39@MWHPR10MB1568.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCqhB5cRogPEPWzLIu34/H3SD4M6f4WFt8H3PLjGUQAYSKMZsT5GgCQ+2BMG/aE/7or5Pimr1rUhG7c2H44pJTELssonYP5wM6QELdQjcskPkDJ5yt4USQfYcaLXHf3J3lx9djGoz+JHSPEmwkZBDkPIxOn+0P9mL0liOvRRcp7eJw2riI2gT2+Y2AW4X/kt3YgPIp+Zv42cFxsjJlmrbPxXxAxJDhmHDam1+PdRW3W7/H6wWL2SNn2eyhuspJxpzuMgPn5IlKWIxEAOr0dyF8cqcWY3dcW6/NcBMNcL6XzLiriZwumjqSj8kTf9XETMz2xx/QmL97yuMLQ9fGNx7zYgU7UNil/AIFXeRnm0uSFQ2OorpiwRxa3dMYrgLicrD+PxqVlADksZLy3IiBc8NOUizoS4ppbgyWMyAp3igzYhMcIYunb0Vmt76aaMT2QG/YRp+EbQ0/fhcr6JlsmQTCscOY25/R9t0fNCbkghuJULYgi2bpVyPAs8iBQNEJWcG7Zsn5U3+fP/BgRJUoLrmL/DIckhUmzhClcrJWAq2N3AunDD92ZeiUDSdVT8fwsxJs18XrJPv368K7dIqR7ZbXgZSYvoFTe4Lnlbs75lwp+zq1sD6P4zxDyf8RHYbsB3vWE3utTCupwjrL6Lh72M4PoU9HtcQRcW8SlRs33AigPwtVn4QD2vHRj18v/QBnQ1271kEjJumBHoSpUVqrwnqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(956004)(52116002)(2906002)(6916009)(66556008)(38350700002)(33656002)(508600001)(83380400001)(186003)(38100700002)(5660300002)(8936002)(66946007)(86362001)(44832011)(33716001)(4326008)(9686003)(9576002)(6496006)(55016002)(53546011)(1076003)(8676002)(26005)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3nZrdcPe5JeEZhmJ2B9fVylnk5KzmwfHW0ID3Zjqr02Qu84diETZFVVoyBYM?=
 =?us-ascii?Q?6o8dpH+iX5M3XmyNV+QoQCdcbW4Hdu3W4VBljQia7OMqLZbexvuufPJ/IKts?=
 =?us-ascii?Q?uXZnDOi8tEHkKj13B7DflTlx2mPiGU1IQV4h6uU4w07BR8ykRlPeILDlTCy8?=
 =?us-ascii?Q?W2WoZOAkDJ1UehiRUr4FuOHsnxCIEq/K57aAjQ4kaFA/4rFKP/vwbFCMJMij?=
 =?us-ascii?Q?hTXpHJX1NDeqZcExqIHlDMeTV64aP+HQry5ZQ5KX4NbRB9XHgRvHRapf1QR9?=
 =?us-ascii?Q?Hkg/XJN+2b+wB2fdjCx6H4xVTAe8wyTsEco5KyEUF510uEwmbaS51ASpSCVO?=
 =?us-ascii?Q?ZDxG4bWWyn/UJp1FmThpSf7fWM2bm+emDzTmKMoScxjCLCKtQFShvJt7ljMe?=
 =?us-ascii?Q?3ndhjN/vBs31EhkevzMXRgvtg8HVWeRNiQiitHRxB5TM6nao43JzRIfdd2Lc?=
 =?us-ascii?Q?dxspBKX1pQLRVJdStPEBlWnZ309yV6vgQZQySAEUVPyx7oc81D6/XawAjwB3?=
 =?us-ascii?Q?NxQCIBSxSlzdnIK6cuTv2kYwqxA02m7jo972SGtWpdLUia5LIALjrILErIQO?=
 =?us-ascii?Q?J0c2dvPf0aypx1Czpn/Do4qYrHaaRL2Gfg3D4+rrTqp/7RtV86OlKYJJiMRB?=
 =?us-ascii?Q?L+SJMcNgT3YCLB6Zw8Oalh2KJ7yJC927l+h/jGJ6ND9WxguezhmSkFt1f+9E?=
 =?us-ascii?Q?06Epd/R102WIH9m47tW8IvWsRh7tuumqUi2PV94VFtioLo+mUNWQ91eR3G4/?=
 =?us-ascii?Q?+pbrJVV8K4WV7LUMshBsmPaA3iGln6UQfSzNq8237JhtK97I5/TTMc7+spwt?=
 =?us-ascii?Q?B7KW+3ikkazDj84dESl7NgjSE7gQHEzLB+QAtKAbO28goWZu752gUfYLAa5u?=
 =?us-ascii?Q?T88ldDn40bBfzNoU+7sfHGpyjQwUFdTy0aSzuP1PtmZ87SqHi+3tW1HmK9xy?=
 =?us-ascii?Q?kdc74ct/7WQS5QWAPJefX9zBVm/WYMysGU7qIUPHCar7dVN0veR1ihv942+w?=
 =?us-ascii?Q?LlHIglRsgl4Bb/yeyDhpKKRhWcs0lGHKZsQB20AgazmU7ztKInyKZ6k7BiYR?=
 =?us-ascii?Q?fG3EUUlhm6BVjbINDlOY3XsLRhf0/vjvR1R6A5/kfQRzx0xhZ7NGrIomwy1r?=
 =?us-ascii?Q?pTZK+0IFonbicO46yeGYy/YwF63dw3pfgA4r29GHk+JGGWf0fLEazaskP2Yk?=
 =?us-ascii?Q?Q/ZVSnFzcx/DWLoGAkdCMN08nE+eb7sfIzEW9my2Wv57VCchBaWjXSTRZSYJ?=
 =?us-ascii?Q?SlcHoAAVyuM7XfJxgWZru4zVAazJQOZ+5aqCu/XtdYs3yzvjmXF/GJmn4Uq/?=
 =?us-ascii?Q?24T5uGh7w/TGlO+xE2oMG8RU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da30c19a-419d-4a21-4b09-08d97e6ca09a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 08:32:06.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CN77sHLodrc+JKRKTb1z04ohJE3RcbkIQaXmYh+uxxPpdorJF8jDLtnhc9l+MINkQVCw4awRaaOzPLOT6SNQJ386DQCfr3g5WafaMYrM7Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230051
X-Proofpoint-ORIG-GUID: _-nlpNSB4xrwTVz1k9_x_GPUSXFSZBQ6
X-Proofpoint-GUID: _-nlpNSB4xrwTVz1k9_x_GPUSXFSZBQ6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:21:34AM +0200, Michael Straube wrote:
> On 9/23/21 09:29, Dan Carpenter wrote:
> > On Tue, Sep 21, 2021 at 09:46:56PM +0200, Michael Straube wrote:
> > > In this driver DynamicTxHighPowerLvl is set to TxHighPwrLevel_Normal
> > > and never changed. In the file rtl8188e_rf6052.c there are some if
> > > statements that check DynamicTxHighPowerLvl for other values than
> > > TxHighPwrLevel_Normal. The code in the if blocks is never executed.
> > > Remove the dead code.
> > > 
> > > Signed-off-by: Michael Straube <straube.linux@gmail.com>
> > > ---
> > >   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 57 +++++--------------
> > >   1 file changed, 14 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> > > index edaa9a6dfdb1..946a1b97d96f 100644
> > > --- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> > > +++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
> > > @@ -85,7 +85,6 @@ rtl8188e_PHY_RF6052SetCckTxPower(
> > >   		u8 *pPowerlevel)
> > >   {
> > >   	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
> > > -	struct dm_priv *pdmpriv = &pHalData->dmpriv;
> > >   	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
> > >   	u32 TxAGC[2] = {0, 0}, tmpval = 0, pwrtrac_value;
> > >   	bool TurboScanOff = false;
> > > @@ -112,34 +111,19 @@ rtl8188e_PHY_RF6052SetCckTxPower(
> > >   			}
> > >   		}
> > >   	} else {
> > > -		/* Driver dynamic Tx power shall not affect Tx power.
> > > -		 * It shall be determined by power training mechanism.
> > > -i		 *  Currently, we cannot fully disable driver dynamic
> >     ^
> > 
> > You're a vimster.  :)
> > 
> 
> Not really, actually this was part of the original code. ;)

Huh...  Alright then.  Someone else was a vimster.  Good that you're
deleting their mistakes!

regards,
dan carpenter

