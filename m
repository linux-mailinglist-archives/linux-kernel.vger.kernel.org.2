Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6584443117
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhKBPCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:02:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36772 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234410AbhKBPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:02:30 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2EiJu6005678;
        Tue, 2 Nov 2021 14:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=C0/nFgoUQj91x1wH0rO6VQexN4v+bkYfThu8BI28v1s=;
 b=pv29tpW4qTJ/wCagltB+TMghJZvUDR8AJTVX62rlxIxAwiDbdfhIsHVwpz5i2X/2BKbl
 IRrtGXZSv8c5ivkOqVhb3/cRRBXMonu6fcY5WPkDsnuRjRr4cV9Pf71DIdecwt2amrY/
 gSgOHYIGkSZRv8G35QpRPzoferAZkkalaXAtVpUMx8v9bThoMy/oVG3Ze4nxpRiIV/zR
 aDeBmlupVBQ0tUQ2yneR9lZ/HampiWuGyIwJRhNoazUOajCSGuGGTWEfnk0+yzuSpIoL
 NZ3VdTWBlfxCq/ZOmShwdPnlgO0Q10xwugErckuytDsvuNru/oc4EAWj/2U7wgv/dhEF eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c28gn7v1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 14:59:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2EtcnR100421;
        Tue, 2 Nov 2021 14:59:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3c0v3dt4hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 14:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqfjlaCOCQPq0d+WkxBeumXo1h2PJmR/mj9Y5joRMBtyXaQyFHaVezd8u9tvI06CSVuSwjJwL41KeTKwsgbng/gFT7VNpxX0gPHIBTULTqyPyk2NozuLb62kqGEQbL/4LvtSGJqxQiRU732COyynBVfboIhxeMQ6H3MvuDNlKWOjfjhK8TDb0VFGG9/NzwadhsHLX2FXCodKjp2Ki1jloygw4UOpZVr0Oe/CKXOOAWJUZSRF1bK6xI6IEzNztRNJ8+GSqDSIUTTDNYh7iLiyim22d8gFxLlIMAeY7oo2/xdHMDVYmLySQbjmQ9+32NoJwnr0M5Ghf96F+kxikf8qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0/nFgoUQj91x1wH0rO6VQexN4v+bkYfThu8BI28v1s=;
 b=C9VMnv31BUqzYo9/kUYNmWj6Fq+6rlCQk9J0wHUBFeC6scvKjHxNYrvWqYtZCSL1ZMxMz43BkJg0OiU+UJFWVnsvmLqe0wgjDUOG47oNWmhtNSkdBxLmMs54H3FtdxNM0X8Rr/eXwv3qXtoWgq5HlcCcfBqjBLgpk4UGYRwivKcvm0FgSBb+fqYfXjTqA69ET8ztigGCMC9RBY3m5msrT+97NfcPAlOvRM6cqYwdsQhLuJVAGMVyBmkpByxJ5joD6I6OWnlBGIHN0QFgqfFYTxnYFWuuk9zoKesHOeb696MOyw2VZ/JAypvLpQAsr7hhLtNLqFPNWePGFRUqAQQudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0/nFgoUQj91x1wH0rO6VQexN4v+bkYfThu8BI28v1s=;
 b=TetTM0H+DpUHu1BNgCBFmvudqFLCTtph7GjzCOZMEWxHD/633uDTyuvhzyuSJZJeYuoGBVt7z+I2TC07U7MdGpiXlp87vQYkZoUP7ZOKY6v5VP4uH1BCSVFEzfH+k8qFZeDaVrHKLVpwdA8k6HHsIAFJ4xgH+XqaqFB8KLVCsfU=
Authentication-Results: kaiser.cx; dkim=none (message not signed)
 header.d=none;kaiser.cx; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4483.namprd10.prod.outlook.com
 (2603:10b6:303:98::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 14:59:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 14:59:22 +0000
Date:   Tue, 2 Nov 2021 17:59:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: r8188eu: use helper to check for broadcast
 address
Message-ID: <20211102145901.GH2914@kadam>
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-3-martin@kaiser.cx>
 <YXCFFO//n9N6MZXv@equinox>
 <f5657f12-e20e-5cd9-e872-32e294741e88@gmail.com>
 <20211022092110.d2mcmf2qe2jtkld4@viti.kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022092110.d2mcmf2qe2jtkld4@viti.kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 14:59:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 010db6a0-5750-437f-d140-08d99e115a66
X-MS-TrafficTypeDiagnostic: CO1PR10MB4483:
X-Microsoft-Antispam-PRVS: <CO1PR10MB448381687FF8F1E5D75A3B088E8B9@CO1PR10MB4483.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjHmFTdgnN601nbCI8yLOFZtaOWTwb3nClNEg4WsexteEqpBrYn+90wK5AJ/l5FDYK+MFH7Pns5+63/tmn8IaiFb5ARUbrzI4QfmAjxQSoadUQUEzxsIz52tC9EgMviP4BEHXIlNKmMePbMGAV7cO/hwS86fwaMJMWo6dXNzwGeN4Ymnxn+fpXm3xCe7PHQL5VF2+2+eb9kzzL6O4GS8rB5JXQEwnb/zeThuWvPIza6EoeItxfmrcJ+Jfk0/Q9JqhuxzDMw7tK46L6c0oNYYGozo4Gaowc13dVDxMb6EQMYFqp3CDB4l78ataUpgZYrjmjajZdUuXy05CIQKbHl8iOYfXHqs21kw9NIBFPOSaxyJDB7K0UiR0Zwfc+uZ+ErThHL7LvaXEUM+Hg29QT+iZfZ15WZHubrj2ebcHgUFxro1Zfv5LYgcegYouKPKDZ5NdhPtlXGSAysUjYWLFsJAq08tzixRVx4sqF5YM1qXjo4CfCHmI8Te68XOk/s3DkGCfUiatJjAwvJP9CAyfVR84ySNNuNV5RUEBJv/74Iy5/O4wk/4EnHovPSdUH8h60Sd7q36ULg9D+laQzgygklkmXtRO7chboOXlndUadzDLdKK+l7xcii0ZBX4jAccP9gWrKvQmZ2Wn1MYVgqDhZx66bPn/CE/rbDkHR/y16Sy0vlbPHRnensTVlK2FXJoccixYm9ocjv2MT+wqWT1ikwWNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(508600001)(26005)(5660300002)(54906003)(38350700002)(86362001)(8676002)(186003)(6666004)(316002)(9686003)(1076003)(55016002)(52116002)(6496006)(38100700002)(33656002)(33716001)(6916009)(4326008)(2906002)(8936002)(44832011)(66476007)(83380400001)(66946007)(9576002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4kTaCoPn7BoMa1/Hrb9qYZIT/Fs7EpAjWjHFs3mnGhH9PmAoy/FeDuYpaYUX?=
 =?us-ascii?Q?rA5FXEAoqud+EkKpdWoZdmH8FsjNFVPqHiO1JySz9aXQm7hHbwDECjmJEQwX?=
 =?us-ascii?Q?ekOgKQCQwvYjftgn1NCLx8B8jJJVkgHDI1SHqG6frWjoU85cIqdft4xiABPb?=
 =?us-ascii?Q?zXH3n6zs6C9nYF59v7gRH0ynjNZQUASciw94sUwa1/vDz6loTg6nF3XLoteK?=
 =?us-ascii?Q?C/JO/DDHUlAXXt3gxVtKcjC3eSmrfP6JsRTBe4Uc7BZMpOjMLgWNsEEalKky?=
 =?us-ascii?Q?y9+8PwFY8UNkmTf1nGA5eEMN1JZn2dGXBSNQ++vdB3lMkC3JhT4gKEkDyn4e?=
 =?us-ascii?Q?IijfH9OGaSIec3zEbtZfFsqdBd1tfHzhAKxnr8CO2HklD3TydhJ7eD7jY+FZ?=
 =?us-ascii?Q?U2dXaXs+0dVbRizVp0oZ1LAuwH9pWOe2LCH6WSHcwRMCREu6YRriBL4biuwa?=
 =?us-ascii?Q?6TaF2HkGdxx46gS5h84vWT6kB7JMRMbhdmdvXwrF4V/FhfS84ogwmX5iKeUi?=
 =?us-ascii?Q?TzkqeG1AMYWeH59zNqpcdMbeEXLghM6kFSORksLT2i+0frZyziGnRLRimNqs?=
 =?us-ascii?Q?HiMG2asoYGfsARBRvlMhfuFkNzqqWuD+qeFk24s3EKAYdFOnC2mY9YLpJOOm?=
 =?us-ascii?Q?Fm/Wb6Bu/zoCRT5EhEnjIm6d2pbsLyLaO01OXY5I1ayqKv0SXKNO8Fm0lzWL?=
 =?us-ascii?Q?vkUIbiznAZlf0qeULetEORztaFsciNBrN14FRNIlxUBzXTWFbkwk3U8Dhqvf?=
 =?us-ascii?Q?+zqKlSgTvaS2tSy/Yri5fD0MUh4ilE2/N5uC9BoLqq3m6I2V7g54MHWH/yVe?=
 =?us-ascii?Q?956SM4dtrbE2txhDMVpnVvtpbMsE2y/H8VRB195v1kG/3Eb70H734dFM90HP?=
 =?us-ascii?Q?neduKLMK7q43mFuMjalOixJnqvM/Z513/dc5Zt/W1FM3HU3ngKw9rIRHRHfK?=
 =?us-ascii?Q?C0XR9/C7bH1ukJSU3bZjeH9gG4gf9jVczzWxN9sMKIu/wX+q0JBZvw4TJUsi?=
 =?us-ascii?Q?i0BSWVWIe2dd9kkOMDl9IvFZJufZJxpqy/Lnup9LIVpO58ckNiqXOn2jLJjz?=
 =?us-ascii?Q?8IvHLsmGAiEKY5AIzsYLONGsmmlQ+L1PvKKGxiK5ln8MCa6u+9C6hJv9Ro1i?=
 =?us-ascii?Q?OO9HlUlGM7k02DS0cDqXJwMk+HPvBGlZl8ndjQ8aPlinb3Dwf/Rahi1DvT2E?=
 =?us-ascii?Q?GAYl7BHpvePG7lxIYJrr8i7C/dz7CxWo3FPsIzZ3K99PMpQ+o0WIHcOVxB7j?=
 =?us-ascii?Q?dVOFVnFCSjo7iwa0ETjkxkaeGluKMwB1nfClWJhtKC0BzBXNKG0mTHRBPbKO?=
 =?us-ascii?Q?zWFvbFBdBB8IdV+SKS7WBhBlad/RyEAhTI9JyBobmNAwBDpDKg3oZOfbsgwD?=
 =?us-ascii?Q?hhyrns0p8Z3KTK13QFoa40xKzJSEt/Lh6kVroUmeBNvpwi+FJccxzGHD/SzC?=
 =?us-ascii?Q?IeoGE6ncOrnxx2/MDbbAeQMNWlTd8+qSrYfD8CcLjPQwtxeOpHe3Gr6JHBLs?=
 =?us-ascii?Q?7jeLjz51hRCU+czvW0kioq6r1KUARaZhl+WdweSbqli+84Gd7c2a13tXs46Z?=
 =?us-ascii?Q?s+7mxrEi1kWxsDCMwJAOWvXEKYGC273ZtcRkdUUrsH8uzVo6Q342fHa4uw46?=
 =?us-ascii?Q?sNcyRha5bxJOm8pqct/efrbpxZBVbNDpzx6e0jTwkkZN/vvOc6QBxLUKx7Ei?=
 =?us-ascii?Q?5M8kiQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010db6a0-5750-437f-d140-08d99e115a66
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 14:59:22.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD120QfWmdQNNdj1mOEudYMG8rzAaGpCRrVXGLquDjZkt3ftypGdGI7UEQEAk55vew7jJm0hXp4pzhQeIWxgqwQRa5I4eDa94Mb57isknlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020088
X-Proofpoint-ORIG-GUID: KFMUMja_AWYnq4e6g8LJ7adsKaW3qgwW
X-Proofpoint-GUID: KFMUMja_AWYnq4e6g8LJ7adsKaW3qgwW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:21:10AM +0200, Martin Kaiser wrote:
> Thus wrote Michael Straube (straube.linux@gmail.com):
> 
> > > > +		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
> 
> > Hi Martin,
> 
> > I'm not an expert regarding alignment. Is GetAddr1Ptr(pframe) always
> > __aligned(2) as required by is_broadcast_ether_addr?
> 
> Hi Michael,
> 
> thanks for spotting this. To be honest, I didn't look at this in much
> detail when I wrote the patch.
> 
> I suppose the pframe comes from recvbuf2recvframe().
> precvframe = rtw_alloc_recvframe(pfree_recv_queue);
> with
> struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue; 
> 
> This should be initialised in _rtw_init_recv_priv().
> rtw_init_queue(&precvpriv->free_recv_queue);
> ...
> precvpriv->precv_frame_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);
> precvframe = (struct recv_frame *)precvpriv->precv_frame_buf;
> and the frames are added to the free_recv_queue.
> RXFRAME_ALIGN_SZ is 1<<8.
> 
> So pframe should be 256-byte aligned.
> GetAddr1Ptr adds 4 to the start of pframe.
> 
> I guess we're safe here.

Greg already applied this patch.

I'm not sure why you're looking at precvpriv->precv_frame_buf instead of
"precv_frame->rx_data"?  Am I missing something?  This is actually a bit
tricky for me to analyze because it gets set in two places:

drivers/staging/r8188eu/core/rtw_recv.c | recvframe_pull | (struct recv_frame)->rx_data | 0-u64max
drivers/staging/r8188eu/hal/usb_ops_linux.c | recvbuf2recvframe | (struct recv_frame)->rx_data | 0-u64max

But the fact that we're using GetAddr1Ptr() on it at all suggests that
it must be aligned and hopefully we've verified that the ->rx_data has
enough data etc...  ?  This code is much trickier than I like it to be.
Anyway, this patch doesn't introduce bugs that weren't present in the
original.

> 
> > > > @@ -841,7 +840,7 @@ void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
> > > >   		psta = pDM_Odm->pODM_StaInfo[i];
> > > >   		if (IS_STA_VALID(psta) &&
> > > >   		    (psta->state & WIFI_ASOC_STATE) &&
> > > > -		    memcmp(psta->hwaddr, bcast_addr, ETH_ALEN) &&
> > > > +		    !is_broadcast_ether_addr(psta->hwaddr) &&
> 
> > Perhaps we should add __aligned(2) to the hwaddr variable in struct
> > sta_info to be safe?
> 
> > u8	hwaddr[ETH_ALEN] __aligned(2);
> 
> Hmm, some of those arrays in other parts of the kernel have
> __aligned(2), others don't...
> 
> Can anyone else give some guidance?

This array comes after a u32 and it's not packed so it's going to
__aligned(4) already.

regards,
dan carpenter
