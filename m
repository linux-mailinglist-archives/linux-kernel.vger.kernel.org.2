Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84146458C77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhKVKnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:43:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65422 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239354AbhKVKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:43:14 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM9aTZm019952;
        Mon, 22 Nov 2021 10:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mlRFY8PDWuMMKPc3nvG7Zeucx/PeK7ETjG6xXeNyQ+M=;
 b=0joAJzl70+AoGRZ1yUuMRT8uA/rU0jAFd0Kd2kPZ6cXuPtETz2IkV0B1Nl0DiFBHtin0
 SF2oo0ojPozoS7iGKbJogyZIWIVdfgeU5y0tRRkrSR6XMW5rlPVvIB63Md+z7+iPRr0q
 aRi0pLyp2WgbX9NDIfvloiFmPfEbH93/UuAXu9tQlrXCpEl+9IBZsjrH3cuKqvstBo7h
 GkmEQrocCRIGAjASf66a254HA5SswWMRo2/XSCnxBxFnh+sxs4WwF4r9o8FBc3ChRDtq
 dX1o+TofBZKc5TTR1uory4b1KRO8llbDnQa0Xtwmoe7t51iYFlBBIv2U6GS6meKDQQoy Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55fs86f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:39:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMAUxhc096500;
        Mon, 22 Nov 2021 10:39:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3ceq2cd57c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8uz1xcuT6bEk/cDsBmyhTKAvHhNDZNi/mKOdE3tuaNwo3f7LtUyDA/eSR26C/73DSHbI8+bvwlJgpvhMEoDoVrnYHDjeRFa+CrcvYC1nFY6lLGPxYnFPaJhqbkoYhE0mRQ8AL5j28oTPkdZZ1xzwxZ+IO1n4vDvAwN4JoNUg3uP8EKUnjAwak3hW034esiBQ7vCFQXC5xzv1PJIgcOkTaK+AySRuATnU8rI7vzXKiFgF4sD1MOP8BV8/qzArXGnI7oQm/i7MSOBuRtsKSftdmOADecY9MnYjRIPXfpoD6RntPCs3wtmjba3fbRC7pWDHHo412ei8/7pwT60mmZOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlRFY8PDWuMMKPc3nvG7Zeucx/PeK7ETjG6xXeNyQ+M=;
 b=F2lwU704Boy3hwh3K6bH76B6v7nTH+Fv2X1ExhP4zz+l4B7w5ZXtshU+7UOnnpiAzAewxeP4EojE7doJh1v4q5LlDR5vY5pgnQ//MQ1qAJdLFP1J/VdqZVfeudLx06VdLPoqgzr7Vk4F4SHyLaHGyJTwWBVmX6OifRj4F9bPzTTSy8erAR94MzEChU/6KtFmyEun2JalXZI9pnN128DI3rXH94p4qqTgawhEmlO/bzgxhY0JUGU4CXu2cp3VEheGSb5wZEYh+G2z+AV8QaJoSRB1JzYQJSt4x3m4qnf9PVv/kD5+ZqaFQ3cWapxyxN9Z3eSi8RDzYPWsa5MpFSYpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlRFY8PDWuMMKPc3nvG7Zeucx/PeK7ETjG6xXeNyQ+M=;
 b=lFLhCgLUYj2QJuikdGPIx7F2n+agzvT+vpxMgZeyV4W6pGcEtfr4SQoHGdzFiMZOtlMxYexaGIWQzWQ9OCZcz7n/3zSPxRmQ6aV7bGuwZmQ5MWwcaLJICwnxe7kIQLyFdKjFxO5MJzWlPp+G2twz2/+pD7DWEsr5h5pV34E3TEk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5792.namprd10.prod.outlook.com
 (2603:10b6:303:14d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 10:39:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 10:39:51 +0000
Date:   Mon, 22 Nov 2021 13:39:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zoeb Mithaiwala <zoebm@google.com>
Cc:     greg@kroah.com, trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] Staging: rtl8712: rtl871x_security: fixed a camel
 case variable name coding style issue
Message-ID: <20211122103931.GA6514@kadam>
References: <YZixPDg8kKHZrGJB@kroah.com>
 <20211120111151.1086970-1-zoebm@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120111151.1086970-1-zoebm@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 10:39:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d12d3f14-bfc6-45e3-9c34-08d9ada469a1
X-MS-TrafficTypeDiagnostic: CO6PR10MB5792:
X-Microsoft-Antispam-PRVS: <CO6PR10MB579271CB8C150775F4610A8B8E9F9@CO6PR10MB5792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzYsR1Lue3I4/lERQOUru5frozv5adgt0KvY1KjG3zAz43IisJN2KMShc2O0wjhssEOkEKqm/qnpUH+i6qzt4G8D3gwEZMtDFBA8hpufLK22A/Os5G1sY/6L+ACxDkFdvE1rKdbaRb+fXnot6YirfbKwJ8MdZ5NYMU99y98rNAoeup68sU4rzH+C3Ier7LfLgrGWtCDSN/37lH+5Cd8u1EtuSusrYQl59ZHqCRUiBn5QpSFmUUyXf9A3SgLE33+/QnvOvQrKNZ/C7hkeYxJXg1/bSdbWGOfz4aOtjOLCTrb+9G/kKe0A9cx1iiSzARYLg1gbey58AjGpGIAjrQW3m0Z2eit9y8U4gpcnFrJ8qCAtMG19RB9olmIgKQwqM50fo6McWXd4J/pGQjIFNY4pPAbLje3rtchiyqOqIY3vQZ7aCIQZZV5jPqetWXKfV0X2GWzJXtx4kYg2s51hNmgCU2bsBAJR+/oNKV4WW3pntLqdo74zoi3QW70+2mbqHJs3h9zri6Zil8RNnhY0onmI5PODRI7B2ZPaFChSXJLC7byLsCXwY98X2qgIAUGa95AIy4bCW32dy3DE45tAHFg20AIMrqTEzYtBtGYXCtTuhzf/LMank6HmXSxZ5CoOuBxpWa38tyJnAQWTOQO7JM9eYWmis/nEJdktrElh8/wBjqbijP9qQO8h4bOysSpzPBtcUaYVLkjZ1rp0M0EF8Hd4UpkKgL7rHgOWfyoxsQ5iyj/+dZn4Z7cDjBZ6lFGUvhhnVncXB2BOdefIxrcJzBU35hHic0UIHkCkimQSDedrm/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8936002)(1076003)(9686003)(4744005)(33716001)(33656002)(6916009)(9576002)(5660300002)(44832011)(316002)(956004)(26005)(52116002)(4326008)(55016002)(6496006)(86362001)(6666004)(508600001)(966005)(186003)(66556008)(66476007)(38100700002)(38350700002)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eybRQh3HHm20H02gTEvzjCaNlUzL1Psbepj4cnUDQynV2mEIc+v2LSCydyEF?=
 =?us-ascii?Q?P8Xzer1LtdiP8jZMiwFhcuWOLITbCJ5qbcRYJKiSmldAzjubHDjWZ20EK5eC?=
 =?us-ascii?Q?WV9btoqqEKE4159m+4jTPWVOZ/FZCJxx4KzAKhwGzbTYkUI/h2K2MZdshFVJ?=
 =?us-ascii?Q?oguaPBS+xc29vTbhEIpN5GakPifAJoJ/OIAc+TbL7nHNK/YavCBG9/c2cN6h?=
 =?us-ascii?Q?Jj74olJGss7G1sfqb0B3JLy3fewHZw8/WpY0T254iAiH47pRlpNAb7qq/L+w?=
 =?us-ascii?Q?09IhCAtu6hR0ir5wS+E3ry/iBYJBaWBUgxOILjWCaEGUFVYFdatcu9MVZUa8?=
 =?us-ascii?Q?8DM/R3QWZCr6c1X2mABHwg5WCFv9l1nrwP5ElzFyQzJ4qYts+jj/Gg+1UVvx?=
 =?us-ascii?Q?pUdqz9lKKPZZDxHVZZ/IZlzrEoD4ySY098nka8hF/0r0jx3CNjGwHo1ZmHwZ?=
 =?us-ascii?Q?2/m93pSQziVTjFa6V2J+1TT5+NO8P5b4Y64sTFwvOw9RqKF0AtvgZO8Ohc9y?=
 =?us-ascii?Q?NTVwmMw3Lbh8yVz3wWAjnsQYQWO8kyDNr/sWFh/ckVNimC5ovmthFE68uM2o?=
 =?us-ascii?Q?0noiGFKxzr6MgnrcZ+gEjc4H0s1GP3HWzaPO3yyezWoqiEu7k2p6SXIc3AZ0?=
 =?us-ascii?Q?7I4ytaISZYGA70Zf9n/PuHaCbJjck/Jxs8flBHCASmZaqPB4JmGf75WmkGGQ?=
 =?us-ascii?Q?QULVFpBJk+piVfjM5hc4E85Dk/bsaX2TxmFFNocAGYy7e2RBiDF+4ZYRrhFa?=
 =?us-ascii?Q?wSErrUT+2cehe5BrSPBB9aHAYrA+mrd5gSej704VEDD/vwOgTj1nc/xyN11u?=
 =?us-ascii?Q?P2R0DscBuJexnv3knCQla9liyseNManBbGkFDFk8WemzJsInjmzH7XeJFf0A?=
 =?us-ascii?Q?bxXilZbxjo888ylE1XTDUv33EtWG/RPgtRAZHRqbxIG/D7S0oCTMC1/ffSc8?=
 =?us-ascii?Q?HtPgUB0Q2TSAyk7GUNMLEDGa7zpU4/UwYbXXKvepDLg8wnUJdBgbtKQD81Pb?=
 =?us-ascii?Q?+l9iLTi5dElgc4kBuhsKEaXnrjeyngH9nccUFnqZIAbLXlGPtp6wLr8kQWWt?=
 =?us-ascii?Q?rONoA92CZgBWVMq35BqjeyJPfDSda1eb9LisUA2se2i7pZlerkoZ53VESi+u?=
 =?us-ascii?Q?eNoFceQitNqaUVudvgzPUz1imitwumlu95GlgVoYJHYl2KsvLKgHKhljMi1E?=
 =?us-ascii?Q?d/gTT36NbPhlNl2lKTdA9vuQ+hE79aUFNfffgICSxM7MZPQLzh1AwAGODA43?=
 =?us-ascii?Q?dNRuZzc/8AhbjM1P+KAEfkTS2OEHIVKhcu56QieQq6egzIUE6KOpLvOAXbSy?=
 =?us-ascii?Q?2BV/mxXkARRs+NBlA2kgSu8Qz+FvV4fgLXSTj4vzdMF/0z6VcSy+CvhusbTM?=
 =?us-ascii?Q?IYNZJWnM+/oId5cak/zIFNJJ1PWIHiKP5pU5yhezwemXB/p5veFGZkhKqYKm?=
 =?us-ascii?Q?yYm9fvLy92rC318lc4RpM72tA0spLik5V+KBtPAvRMfA8dlTf9Ufoy5uLeq7?=
 =?us-ascii?Q?M93chTOYVF33gx+XqGlnHZxY5XVGAK2j7v8J94lHRuCrIB2R8/ya/vV86RM2?=
 =?us-ascii?Q?msSoX8+62QKJDM7NxbLULTX9an62smJkMN49hRqVkK9ZBY1BMViPLtnJfUtd?=
 =?us-ascii?Q?rkHZL3aXtVv+GIcUYig9xe4T7VuOdQIm3HBt9DEuWHXaSg2pEXa+FvEyoMlo?=
 =?us-ascii?Q?tdSSPQByMabtjfXWnB2HUdVI11M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12d3f14-bfc6-45e3-9c34-08d9ada469a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 10:39:51.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onhSggmwNlJq7het2QXDn7t1Hiee1wpRLGeBKnTEd7dKhXqTLNiAjNyarA7Mgoarv8Z1XjZAslDEpC7J1EgEIxvTCa2yQcJVpzW5zqU4JGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220055
X-Proofpoint-ORIG-GUID: CZZOoH18rTXHmjc_10Ztd64DtshUDJO2
X-Proofpoint-GUID: CZZOoH18rTXHmjc_10Ztd64DtshUDJO2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 11:11:51AM +0000, Zoeb Mithaiwala wrote:
> Changed additional 'n' from variable name. Corrected comment indentation.
> 

This is not how you're supposed to send a v2 patch.
https://kernelnewbies.org/FirstKernelPatch  See the section on "Revising
your patches".

> @@ -200,11 +200,11 @@ void seccalctkipmic(
>  	u8  *header,
>  	u8  *data,
>  	u32  data_len,
> -	u8  *miccode,
> +	u8  *Miccode,
>  	u8   priority);
>  

Take a look at the naming in the .c file where the function is
implemented and use the same name in the .h file where it's declared.

regards,
dan carpenter

