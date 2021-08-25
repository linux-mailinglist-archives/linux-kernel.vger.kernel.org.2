Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604CA3F7462
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhHYLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:32:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27930 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239324AbhHYLcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:32:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P9g88a025058;
        Wed, 25 Aug 2021 11:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=eT6R+od/77Grn8HdLChkTQKY4rPQLlFlfMI4131gS1I=;
 b=Zl69+Bqtuob5W8dr9JcwIFF1pvaye3UMcSTDl6tIKKGKijFYRz9gI4v+PQlytAY7XDCo
 8b0psd7vNULv2NwPiWqmnS0PMWYxCTW4Dcl9wWu4+zPwyPExGDegw6ByY4qS47FHmOvy
 LHybJxTsYxZwUy1wQAtiluzyrrRxlT9OaC7NqE1L8+Jq3b9V4aIhK4E/ZLB46s/eFOVm
 PL0zU7Rr+4lgGMe2JQlojvKghtWZreaz4J+55f6CdrVDraUB/vnsRcFn9rmcKn7182+B
 RjFzDRfPivZtUobzw5BwUWdOkfKZWmrpQwk2ixN/Fra7aP1bfxOIpga0nmqLGyS4QAwI 3A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=eT6R+od/77Grn8HdLChkTQKY4rPQLlFlfMI4131gS1I=;
 b=lgNtBpYFNNShuz8KSx6E4YiQosIsiZboa8AvzHi7FGZOQpyAzBjKNg6xZnHdRvjN/9Oj
 o+dXdq3Vdik1pr8j/nt3LeL87q3VmsU+Z9f8asYDnrK9lMh4R5zYxIB4uVUTO7WLhdfi
 XHOQK00imcMBQZ33Bau4McPWZKJpVvB9nh1zWcT+J44uY9JbWoyqj1/Yj4EztrWkY+sO
 weyF3UTVxAJ/zKV9ZuTe7Pcz1fWaHQlhun1dxLsuz8cTsDLuZru5WmB+NT3obrHbHgjR
 twQMcJUmG4I0oje9BQHMavwgjCn8ghPsS2KTcryvWKGp+SMWnXG+OZUqidUBkAsGVHzI ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amu7vupyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 11:31:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PBVf57102071;
        Wed, 25 Aug 2021 11:31:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 3ajqhgexu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 11:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxBU/WvhR2dRRkAR6+7KaYNjAcJM1lt9JQcK6SA+yzCbNJ8rFtzlDiK2YUQdYlxpgbkG/UCeCgVVuIlX2xjKW4tO6yf8WfyGnbLxUHtDKnLxMhZGoIcaHDDaUBlHAVgVXLpi2kDzGqF3ic4laK7sehoW7M84/4pffILRVLrUqjk1C+RR6PUemlqV7CoU/saYK/jKYWiOoQX1ODyESOO1y2jWGMfgbsjmUL7m0PZrXCgPyEYMqjL1Vk1/gi4FdLrShEC6UaZH4Fy8BgzH6Hp7E05hG0/V2HVWeCR/rNpH9yYl6bZwZ5yvqP0UaPLLlyuWFT6aAxIia/0xiNIqYqrrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT6R+od/77Grn8HdLChkTQKY4rPQLlFlfMI4131gS1I=;
 b=bcGDLVPxy5dJZxrZeSYWidnmbECsnVe2Qv70oYRdZzxNl3wqPYnCo/LZfsEgqduEppZq4PYh+w15wym6qAaxj5ttxdstJi2qBj3wmw71K2I1YuijLTPt1tkdqaZ+cQAyuiC1jXWbxhMrMbu7b7rcOGEnD6R2IPD+3cvyOZC67c7aP0wHh4B2NH3svnVGSsJ6ydLIsZcHE3WWjKaj8Ja6WHIlGHaYmShCxVuqegnEpaev/F/eZJDen+TROu6ey5BHpQts5p+j+U0x2CC70gAwOwWvkSZXxG04xl+qrB3ZnNOMkdzYf6z0j5GlLncXHQ8vlSDgNO4V9rFVpjZxP954Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT6R+od/77Grn8HdLChkTQKY4rPQLlFlfMI4131gS1I=;
 b=p9kH4iYGnXtEU8vUNlgqj07uUapKjhIaxJydLVO5D/tYoEJ0aH64azPP4UvJxrrWnUcCP+q3NRTEiIDIEKQ1eWfmJTX5Cgq9CA7sozErvYYjZsxLVx/JGhK34hCxrRO7Qgt9Z+JQCBwhHdk7k7LcRIPYcH/X2KTfSmd1wCqWiV0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5410.namprd10.prod.outlook.com
 (2603:10b6:303:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 11:31:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Wed, 25 Aug 2021
 11:31:39 +0000
Date:   Wed, 25 Aug 2021 14:31:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Message-ID: <20210825113122.GT7722@kadam>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <3396277b-6d80-b621-0ef0-71de7d581602@gmail.com>
 <20210825103802.GS7722@kadam>
 <3494498.825kMHXWDN@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3494498.825kMHXWDN@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 11:31:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b2706f-1933-44ee-f683-08d967bbe753
X-MS-TrafficTypeDiagnostic: CO6PR10MB5410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB541078575BC1A112555495A58EC69@CO6PR10MB5410.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfNv8RyHuFnWVNiiJWQEuLFpe3IFVWbjZ2WYLDHXFyRbGlA636KY0Ui9mVBb/wlN37jqOe8z84dkGZ9qavXjngEz1/q+Za43Z7BxnmeM78NgoXHqVK20qTDpDusrJ3NJ4jlGXGg+n8/40iwJOwSxJ1wGrQeec/ZYYdS0pFR/IPIMcyIxSOBeaIvS3iKnE3eTx1gHMfDWKVMUpxbBqFRXW7u0oSOPG4SVhuJT4OYBir1w6Z9hyph2RRLRwZd180UxKzy0Eo3fVhnKYdW9lWUeW4cNboTHfIIzEXlF0NSPgCeinMe5bgdmvm82ldnaoBtOqUn4a8FcURO12a67LT/tOcfrOiwN9zYRZTaJJapt1zHQblEZS887R2E14kEotOExqDrW4TwMH5uX+EIluUgglrLp9p/vOwQ76AL2xuNrcZLZ0XlNUWc+mH8OI3KqZGu9z9+wQqHQbbfsqvjKUzIvuQCeH89NDzeAUGxSvYnsXklN2sU4TAjXW4hzxuA6kIQEciAk/kNhqtx7ut1BOggRIRDQYRuBeOIJHfr17ZDOAHwunEP81Vvp0KtuJyd9xmTUMokW6JEEXpRbjNQ61w2EDjqEsn+M8HS/4hCN0SoPa7DuPMUlq92W+EyA4Mls787O+87tAUMNRwwvebb7R53BXXp2eSFEY/42oIgAF/eKYDFVkNBpJ8GVgHbfc+gVgRFuacvkdFyFYqZxWRa2KR5PvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(53546011)(2906002)(8936002)(9686003)(316002)(52116002)(5660300002)(9576002)(478600001)(44832011)(33716001)(186003)(38350700002)(38100700002)(55016002)(956004)(6496006)(26005)(8676002)(86362001)(33656002)(1076003)(66476007)(66556008)(4326008)(66946007)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzcJg41vqV/hu5khZPFusApmvJIYcwi/7dZNgLjDGeKao8yfRGCkvEjzuA0q?=
 =?us-ascii?Q?jDH4G2zQbtJfINfWozcaqdHzYXWQFMKRk1CXRXbd4Z/603pS+4Qh/gaIjLJR?=
 =?us-ascii?Q?rrTpOxFV8p/rQg/WGmYNPAM8mYQ5PkKz1ErD27o7701DfcquvTQ5BSLC0uug?=
 =?us-ascii?Q?y/RJE8jqRkBgT7UbYbXkdpZFsD+5Zl7ZVs/OFZOzZdLXKug4+nfVo23O5vtE?=
 =?us-ascii?Q?Cpi5mO4AwtKEPDHnP6Bu7sAh0pd4tiAL/QYIJzY+4/3Xn2JqXygHyV/NQ72W?=
 =?us-ascii?Q?30py9DbOE/MoPRa02pHzlsLdAq0v8mc5PZ8OSD6IqFQffxWxRW3wtlUg7Yh9?=
 =?us-ascii?Q?aJ44/raU/0EC+On9H7Vu/CmcYjfI5mZv42tiY4ijvnB6a4prahlgoMsM33/R?=
 =?us-ascii?Q?sqjKqkDUWxvEDJdB/GqIDc0gxWFRJinQZnGUMzmCp+VYPDQMyuXGf8ZFDBKB?=
 =?us-ascii?Q?tm7pbD9RwARbLfyLA12k7mwrfBBozqh9LL3IrCmN3vGnnATBd/GDtOdL6AGg?=
 =?us-ascii?Q?HRzKm1x3MifgI+8BS0Qqhp7VpDRI0jQBHoMt/Zq7IOqVBmmGl2ICjiNHW/KL?=
 =?us-ascii?Q?YVOiBay6IGJEZ0pNDzQHmNyUcMZN5cpzIKsZPj0lH0hBY3ryaUri9lb0m75q?=
 =?us-ascii?Q?FwGoub2cK/GEWhpWiWNSC/YnCaXNFImxhSVVBw+T/QSWsAPIFgy1Qb6LRDrJ?=
 =?us-ascii?Q?/qywE+lYRqaNGQ5TPixoyIBsbHT4xAYTcqHpuA3gArTQq5rBSSZv+oKaSjYf?=
 =?us-ascii?Q?BaCazwyiZv7pzzi7iVECeEo+qa3SqP/TqACZJ7dCBo0I9VleIwNHJFf9sP2h?=
 =?us-ascii?Q?05AJQ6N2v5kpNnE+WjBKjFCzKUJPOTWtvBklXl6UraiCA2tMYZpxL76MV4MB?=
 =?us-ascii?Q?rhlL/mUaKITYRUQdvqQw1D3qBtmJTfmPNHm02FTfbWUEAl3Tl03WEl4wEuHa?=
 =?us-ascii?Q?syUTP9sYjdgkVCXB4zpA64DjwrQKdf1/rVjd9ZnsY4XSMkuzRSRdLtvSKJ/S?=
 =?us-ascii?Q?JaEcNjY5d9ifvdiXmb84pVgIDraz7xbsPXU4Mm0Dp++jYAIJ1i4iocSH7ATT?=
 =?us-ascii?Q?la8Y0nCW6hbOwVf4Ee8EVGam4lk2pgllut4KIEL0leQnRwNr2u9+CxDLDKT+?=
 =?us-ascii?Q?wxYbyI9VNkBSaWTgCws3ppwe6I6Bk/j4BanxUFKfm5mK4cJZzmuCMi82Ix5p?=
 =?us-ascii?Q?8h9InzVqy808gHD9f1RVSm3LfKzx8fto2jBhre54SK5xmwwumurv7QGmWimJ?=
 =?us-ascii?Q?+G0WUKZ+LpfR85GaQiFSn3RcrRoADt5LzKM8HI6MdOBpX+mOlXAZO8MigP6z?=
 =?us-ascii?Q?SJt6j1SrP0TRQsYrsK6cBtEQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b2706f-1933-44ee-f683-08d967bbe753
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 11:31:39.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq0pQfCN5t3ehi14U49IGi99JzePboXP/zBiHU+5YfrGoO6fYYr+LNg0+hyawyl0tqIqcXm+1A0HQ6DHbVeHnddAmYpF3vxT3obSQGysAfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250068
X-Proofpoint-GUID: EqI_pF-vOesr8WXeUEy4URnQL26pLzdK
X-Proofpoint-ORIG-GUID: EqI_pF-vOesr8WXeUEy4URnQL26pLzdK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:06:40PM +0200, Fabio M. De Francesco wrote:
> On Wednesday, August 25, 2021 12:38:02 PM CEST Dan Carpenter wrote:
> > On Wed, Aug 25, 2021 at 01:13:54PM +0300, Pavel Skripkin wrote:
> > > Both series are pending right now and made on top of staging-next branch.
> > > Who needs to rebase? I think, applying these series as-is can broke the
> > > driver, since error handling will be broken
> > 
> > That's a bug then.  The patch should be rejected.  You're not allowed to
> > break the code.
> 
> Sorry Dan, I disagree. It's not a bug. No one intend to break the code. 
> How could anyone know that someone else is working simultaneously on 
> some code that is not compatible with the work of the other developer?

Okay, I haven't been following the discussion closely.  If these patches
introduce a known bug, then I am going to be cross.

I'm really stressed out right now.  If you at all suspect that your
patches are going to introduce bugs then just go back and say "Sorry,
don't take this one, the way it conflicts with Pavels ends up
introducing a bug.  I'll resend after Pavel's patches are applied."

regards,
dan carpenter

