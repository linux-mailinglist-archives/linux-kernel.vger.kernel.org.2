Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5740AEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhINNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:32:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18772 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233202AbhINNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:32:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ECrN3D014569;
        Tue, 14 Sep 2021 13:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=m09qwi92noxN9JY4StGrJydJ13OsAmfAUW69u4wphfk=;
 b=nsWFEpxiuaa2ZQfMrIU5bZIytEO3Racpd3wjmZ1SAnVy6K5bB00siwC8puH/6B1ekNJ+
 Zrs5kJw5++bibbr3UbZRyyF5qCrnwxXe4IJjpTtfpuJ4/4K7MtoaZpmfRU1LvuKPkjx1
 UZ2Ga/6bYu4sMmckrZ/+tLtwlc0g2aVgo4qgRnWRSoJ9BAY6mFABCyCwxkp3D33T/bpS
 9l4bq0jtqdZjbT+r+r15awHJqOUI40FyuuWtc/XgVNY8UbhQZCkis1G8BhORs95WrQNP
 qEV6nRzlx2J1Qfvlt80FN47ULctUCgdCDrKwEYJBW+W3zBFryk+OCRDXiHOTswBt9bQw sA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=m09qwi92noxN9JY4StGrJydJ13OsAmfAUW69u4wphfk=;
 b=sVi5YQv6Cp+GaW06uLpW7o+m8r8vXa6ASW5bWEF6pXH+5PFQAdIIHVI4Z9Pt4BAD2rJ8
 0acB755dG4VJaUnabvSOjE7PMb0kt5/hM2oWWTQJT+iWDVbgHoARJMUyIZuQL6DqXCBB
 Cy/cl0Z8rBjgKwVgbaEu8iLvx9MEG0eAVUlHdivie+/1mVcBGC0S7/nYnkl0j5ZVTk3q
 EWfHWR10qtV97dMKKiJNQSb7DDPFYtprWdAhtSl15F7NPR9Dzvfufj7zrvtKK4HtpOea
 8fARFrJk+C8GF37+Pn9mVHV+RuBQPYVeFQA1ykRvjV6AJUbbCfTLBJl/32zDn+2j+1mV tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8t9f9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 13:30:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EDUYv0187518;
        Tue, 14 Sep 2021 13:30:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 3b0jgd4e00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 13:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FARnRKY5eoqitaeFdguj1vXDfGhpHCvqEu6ELv4ampcssgTlRb2u46z8T0NpLinn5IaxkdNVi/9XZeXRUXx7aCoTPdTGPL72JXnqk4SNx1KMlnRpASFmOy9cIm6Rk/QYSvvyPFzfzqwKSHQ9UQ5SAd0397WBo7VAZXa96sO+gciidSHzI9sQ0xoh/9q2MnpSp4dWff8nxEGeteKCjQSi1Gl86Ta0J2BZ6/ztcw8NKc+ce0YgsgxUNABKhXQe3emSjbVbs41mhr4o20rSJjFDgOFCw3Ty8oNt+JKbmgKYQ5WI0t3QHf2LmIfnxtAIKcdCE6kkNizU+dCWYDdSuByTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m09qwi92noxN9JY4StGrJydJ13OsAmfAUW69u4wphfk=;
 b=ZvvGrXfFq47ujITg3bPc32NF9V37OTZieiyrowXcYSiNalX4g9xIzSGO7ZcnzTcPB5JObt+i/4YAA+25km8Mdf6Cb7XJqjHkuoX8HCnTldJlCxUIHXUiS0u74dYu0NoMEEEtGBUdFOicb7A/opDzbxkNvtnlM2IbB3wijQgPISY24Bz2DQ9r9mq/FbdSiERxxM5ABdK1TRMtMVrSSLEZyXxCBCxvXzOjH0P/Owv5W0Z4G9w1YX0nSWS71qVMU6LRpgSdgs5gsCK+2gX2sZIMHROl+cu0yp2YhgFaxh553k8oMC/zmiHWfFYKXkW35AWhSj4gt/X9ukKAjxwdsAag1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m09qwi92noxN9JY4StGrJydJ13OsAmfAUW69u4wphfk=;
 b=lRUTyu5H1zDGTSTFm4vbboWcPmzlhdTvY059h2sIS60zftD5+xEScXdFXpFylH106NpctN2qD3oRPe+lt/afHKtiECkDU1tTXxAZFzvZ78tCOU398J/I+KJykqNVP4i8bqc6OGU77EjI6/SNxb5fQ88x4cDVEFRo9AAMaTz6TKQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5570.namprd10.prod.outlook.com
 (2603:10b6:303:145::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 13:30:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:30:29 +0000
Date:   Tue, 14 Sep 2021 16:30:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 15/18] staging: r8188eu: hal: Clean up
 usbctrl_vendorreq()
Message-ID: <20210914133007.GE2116@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
 <20210913181002.16651-16-fmdefrancesco@gmail.com>
 <20210914092405.GB2088@kadam>
 <1670478.viNvIS23Oo@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670478.viNvIS23Oo@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 13:30:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68ded2bc-0468-4cd4-4ed5-08d97783d1db
X-MS-TrafficTypeDiagnostic: CO6PR10MB5570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB55709696ECF8E635C9D9CE868EDA9@CO6PR10MB5570.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qj0WTHIEzGdSUkbLfiovoKKLYKBb3DmcvykI0IwI/xC75XMR41UMdWZP+CZ2syRIkYqEARS+JeINpI5a8fNsa55Hjzhh00oO7/YW2M+yt6AUV8pc1o0wIk8Fj2f4xsFf3v6T11GcPRJcIsPmi7w1Z+4K6NMpcyylI9gbrYRPvY8axZahlTT2zc90AU+Ze2XlgTYDUo+ZP1g/Dk2c7pG867TCs+EZXZJPraaNi1VNczCcFMYouGfk8z9TLQUONHxF/6I6pSmRvJyUiPAvq6gythXnc4A2mbg/rIc4VjEqVRbb253rGe7d3dI0ZwNZQ2PIxyztaOyGAoLWJqxoYf5teKTdDgALEEbzaM85G10wB/IE/XtWh4C/FDS4g1GOoViexAb6CcjBht5HIcjSMsln83kdOWZjcjFd02nwzV1OwJW1WNXk4SUJr1NKbr9zR47L5Nq3pFlOfg9i/nMDra/czgnqCEzH3hOpe8i36ZucV7FNmWxj30UVbGTStgbUsXzpGfYHKtWU4fG0c7E3nbHcfHC724u/dUMeWxvIdbQsVExqP2v7zVqsYoEqGUJb9aZiE7J7XuXhuOdE6kN2+y5suzoEb4AEmBpme4z3NC5r4sx2Hqy5tkccr1T19z174bLUT0xRvzLFs5Ppw7Hg/ActoeDL3O7X7SIIXaJxGR7pqf4aciYNqh5e4pReqvLMhAWzf4WCYU2l6DnCr1KqNdnKNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(376002)(366004)(136003)(52116002)(6666004)(8676002)(956004)(44832011)(86362001)(33716001)(5660300002)(1076003)(38100700002)(38350700002)(478600001)(33656002)(66476007)(66556008)(66946007)(9576002)(6916009)(316002)(54906003)(26005)(8936002)(53546011)(55016002)(186003)(9686003)(4326008)(6496006)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FggpBBzGlOT1FDqkZgBxZSTWxbGD//SL1xO4vKo6w47+Jh7/ip8lyeVEHqSc?=
 =?us-ascii?Q?qIwygko7wRrSoMc338Wq5gMW0x/lIgxC1sthCX4X6chg8aSnVwm74R7JlmA6?=
 =?us-ascii?Q?G/LG+XxdBUgDxjOy3peJorXlevRr7kNIeyUSYQ78zcKuj/i34sZXOHj03aeg?=
 =?us-ascii?Q?4+TaHsek+JlYDsultELSgTmWzRAEZZMIs+gNAAjIm61T3q7VK0wbial17o/e?=
 =?us-ascii?Q?21fiz4uCt0XJWXI97vz06lwhcj1lVIXLcb5xVDZ2s0gvRB8I7UvCna9WDQ2Y?=
 =?us-ascii?Q?BSiTFrsSBuTnIHA8FULCy7H5nuMflRlCH4Np0fZPSGP974WwQmSa/+04B8dn?=
 =?us-ascii?Q?w1AnloFdXB2eLSU1SNL4ac1yoWs/Ol/RHZ4DycJvPR9EwtZ6BpxYAJZgknQ3?=
 =?us-ascii?Q?ED2esENVeoZYmpTD1xSZh50w4yych9Ye5uT6Qn7bx2chgKO1l8IL3yiW1fiw?=
 =?us-ascii?Q?oBPy71OD9LqSDJuVewLB/u4po/rVF7ceM8nNfUb9TVvFj2qxn4n4zn44T4U3?=
 =?us-ascii?Q?fZE4SqwqPkeEpv6kgY+rphvfPvh1uEs1/2OLTebOaMbCQvewvjwpg07APMST?=
 =?us-ascii?Q?J2Y1eiCZLC4cRyxU5ur90mFQu0DqJt08dsT5frwQ/ACFnDMp09KnxHcDA8hZ?=
 =?us-ascii?Q?X3k19RB6USNCRQ0I/eHVQpr7gIgpWOi2PjvyRG81nEIEEUePhz5r9c+YvLlz?=
 =?us-ascii?Q?aywV/hOaJq2sUmeRQHyD731JJ0huQ+kPU6a/UcLEKvka1sG4lq+x945mvZUX?=
 =?us-ascii?Q?mdLgesP47Eo3LT/Yj88E2NVso2nAyTTHHbbjZW26LG0pDjRrGzOPLxUvd5dh?=
 =?us-ascii?Q?MjJ1e5yRJdT0Q1mpBRwHvAUXZddBTISzEO0k4csvy7UuJXR0Rlt9XWphXf7D?=
 =?us-ascii?Q?vjKBm8/ykYahsGTpVUQBGtiqUee0b/sXEUPbBf0g+KTjoVF31l3GVTP3ShUA?=
 =?us-ascii?Q?CRH21slAqqr62h03zL0LhXkfp6JkNh6nL3aYx2iVDEoh3fyc8PyhD51w+LvL?=
 =?us-ascii?Q?3gIrEG6/TUfbjcJiySb1efkWiEiwhoBA50CKSmrSzDjsnoPIHFioim94Ynp4?=
 =?us-ascii?Q?M1x0+FVb9Np5TP0UUAPDi2/j2/72/UVop7LROq+W7Muhkzk5egzCC67sWxST?=
 =?us-ascii?Q?KyZaLCvd38cU8P3/eII5ElJShltPmkcM0Ab+0L/mGv85lE47veqiV8Rw/Ssx?=
 =?us-ascii?Q?K+WjszHOcDgpWh1Lzri7AIiDUQCIqh47Tzum4rxARRvwZIXqGH18rNbQ6Ljo?=
 =?us-ascii?Q?toXZapNAfvX8P72MrIgYWpCzq62Xn4gYdyo3b5GXTBb/OwMKYWD63m8Aa9ZE?=
 =?us-ascii?Q?I9ZbP3uhFv6kVvz8aSQtN3Dq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ded2bc-0468-4cd4-4ed5-08d97783d1db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 13:30:29.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATHTbYxnJgC12/mPaYgmUgwaaryoEihAzb84thL/D45HwPbWAY6M6v8ZE2BlBF4SCkM9EhTZJmAElv3KkCdzKaYXpNXp2xXNj+vMaEfQqu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140084
X-Proofpoint-GUID: _0VRDPlTBhGzmDVZbk9XoKezD7FZBxUs
X-Proofpoint-ORIG-GUID: _0VRDPlTBhGzmDVZbk9XoKezD7FZBxUs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 03:24:06PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, September 14, 2021 11:24:05 AM CEST Dan Carpenter wrote:
> > I don't understand why you moved these from the top to the bottom.
> > But the original was better.  In networking code declarations are
> > normally written in Reverse Christmas Tree format, longest to shortest,
> > like this:
> > 
> > 	long long long_name;
> > 	medium name;
> > 	u8 short;
> 
> Dear Dan,
> 
> I'm sorry that I forgot to thank you for the reviews in the other messages I 
> sent in reply. :(
> 
> I also forgot to answer to the above question...
> 
> I changed the order of the declarations because David Laight wrote "I think 
> you'll need 'reverse xmas tree' ordering as well." (copy-paste from his 
> message).
> 
> As far as I know you are both experienced kernel developers, so I took his 
> words for truth. Is it a matter of personal taste or Reverse/Non Reverse Xmas 
> Trees are strictly required by the Linux kernel coding style guidelines?

David and I are saying the same thing.  "Reverse Christmas Tree" vs
"reverse xmas tree".  It's like an upside down pine tree.

	asfklajsdfljasldf
	asdflkjasldfjal
	asdflkjalsdfj
	asldfkjalsdf
	asldfkjl98
	lwkejrlw
	ljklkjl
	lkjkll
	kjld
	asdf
	x

regards,
dan carpenter

