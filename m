Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B924458D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKDRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:43:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43972 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhKDRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:43:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4HGNH5027061;
        Thu, 4 Nov 2021 17:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rS60vCD2G9BE/DL1JdcLsWhYZqfoMCX7HYjb/Yj4RoE=;
 b=uYEaSopYhE0g9KTW9M5AYabaCbPEJuclDrWCP02Grzr2+voJKHBfa51Vupy9uJVwpFle
 rxB0zCpGEWnPi84D5s8cEnMFlfOvYCs10KrN6MFPv6kI6VmsEVE7a4/tvlBNXjoJfuos
 twJKZlbgN5As6Yfl64yR3ZBOCk2okShMwxmHHsymRIZIH/mHBpnvb5PMSFDBjydtXRnX
 ygCQlU6Kc5w3i+KCvRE3+NKVTDvngTTb78at5q3Q2YI1uGfXQmmBLo8txURII9OCmCxl
 swyVAvLRX9hIUPMuapsLa3ZIdmYcNT/jEx0boBGL3UaTfpYKkMT+Vg61uaz5uifb0eFJ rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3mxh9ytg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 17:40:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4HaOKc108428;
        Thu, 4 Nov 2021 17:40:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3020.oracle.com with ESMTP id 3c1khxj4ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 17:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np6cb5J4wXWx23EqMbZk31K+hpSHVJUAml+ZPcqlM4geQsIw5RddJAhhJVl3COJ8gbFJOxviufE0fuSr6q6n5YZ/Kb1HY1nsun/r8grw1ffWsaSu/ctsBaghHpG2t9kv99qr17/bDnLrTZZriMT73n6UmIZfUCIiftvqY0Ta3yFcgbCfszNXP6jvkWG073Yz4MxLa9frmVMScpbKuprqej6nQX3ary2SpYg/G/HHyTdz28XREs1aKpLt/h5G4jMEPc4+gF8gc6ODwJ2w3Qqj6QhUxioM8iK/iLVpngOF4mKq2NGBJlj2715FYezPb1jdoxY8Eut7s3zWUlcLqLGhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS60vCD2G9BE/DL1JdcLsWhYZqfoMCX7HYjb/Yj4RoE=;
 b=EMjnEBCzkdOJ2FpCqI/Rh21Rf8EkuNfS89Ry5XuWnzOZPwkoTiL6sWRuAbd8ZSY7aAr22lykQHndE4Fye0gxwNU2QXdc1GqCe+4y6Aei09vpujLVStS76Hl9hi3vCmN3uu42AUsH8DWe1a70cJJVrDARTijGSx0sAz9qQ9CtAeyoOfOfhRQiT18jV+7h3HgUcseGANCmXNRftIF/8gM8PcN87Sc16sOtXdl9C1AZbxEqKTCeTONt3NtkGkArSBs/NWUNKeKGok6AJcGimWrgVZqd7iY46enqS4y8l0I208FTgfcpQ/MuopLdXRvUA9WF/QvoTpdg7BbfK/VFSRxSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS60vCD2G9BE/DL1JdcLsWhYZqfoMCX7HYjb/Yj4RoE=;
 b=d12iYiD5FvVBJbAkTZEyQqtAXNABX8h29a4veJ3skIFqhEXs3UNbD51slyGK0HhuGSm7eWxLd+fUl0LGoA0XeSo30Kgpr+wrVSicUOZXmYtupIxEfjbnFdmYlKJV/n0bo96vw137e8fVGQt281rEPrsme298JbIwbk1tN84COgg=
Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1375.namprd10.prod.outlook.com
 (2603:10b6:300:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 17:40:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 17:40:39 +0000
Date:   Thu, 4 Nov 2021 20:40:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] staging: vt6655: Use incrementation in `idx`
Message-ID: <20211104174018.GD2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
 <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635773680.git.karolinadrobnik@gmail.com>
 <20211104130002.GB2794@kadam>
 <2fd61a94d8cacd2626364bd25eace6b141ad1766.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd61a94d8cacd2626364bd25eace6b141ad1766.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 17:40:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 224fb287-e629-41fa-16ac-08d99fba3797
X-MS-TrafficTypeDiagnostic: MWHPR10MB1375:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1375868406775EB5F08CB55C8E8D9@MWHPR10MB1375.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaPOu/46I+DIwE8dvupYG2LQRwOfC/wwvCtp+NssBN3PKD5c9J4OmKecXzKLCSX9Yee+n41ZTabHxBsN9ICpnicGqTuIbiUeu4V1mOZ8eeSH6jeltoim+lOcpsls7s3Ed2d/KmOlyDh7Bgz+XtQxGNnoGvePRhMDbRUUr19hOoKpJa44pI5Ok7V8o39+EeAbjw1kxQktS90BiCjXeHuj70QfEj1lEcpeD18PqJftG/HslMMBuy1ahIR8+fzTn+9advwJvqa5g/SS434aOdE/2Ym7dRcSQnsGmiZrQx50iN5ohKyIxQcHO/R0IN8rZgsU3QgXvujV0trkqPZlr+nbIqWBknFiZAWWqT0QidifyMF9Li+POZpJAOJiVSIOS/OaejnepvucQMxJOIoVs1RJAwSqW2w4XO+3FSAZIl4on9TVCnq+K9ceTY/rLEzthoeSwkQwFqu4fTqfZVuVXqLAauS2xI8ptIwLAjN8+Ffl9Hrq+qI9n1EQFdobsNTGeIUc9hrMjR0GVGQvX2cOOlzfk3sr7zgwPsAocFU32DAhMdmjPgvsbOPmU4K1oqfwHqMg6JyTwQ7C7Z1gvpbk+WT9b9a1yg9eNjHM2tzSw8jzrQZAehWrWK/DbsVdqMAJhVkEfR3N2AF8V7w60DDw4ul1+XhKiOtjqFIg+DtJ5IHeGRxyP0yNyDFBOtK3qgqYZKE73TaR5bwY/4QUTws17gy+OTMJBGyzQDgiV3MgjZwegDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6916009)(66556008)(83380400001)(66946007)(33716001)(33656002)(9576002)(2906002)(44832011)(66476007)(8936002)(6496006)(38100700002)(1076003)(55016002)(5660300002)(8676002)(38350700002)(86362001)(508600001)(26005)(6666004)(956004)(52116002)(186003)(316002)(9686003)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aor/5/j37JK8NTqs7iwlFYvdWGRK3aSEcc9Hn7nc89pkQvJYRvj4zkVzDRCH?=
 =?us-ascii?Q?Q0iTzoGmvDJArevTY5VkCPE/cNvnQlpdF33a13GM2Q6k9iwsJcD0tHr70mSN?=
 =?us-ascii?Q?Qlmp3BG4qDe1ya8V1UtGKqCb8lly4CnIjQ1WIDItPlg+uihW5YFmjoxnH/fo?=
 =?us-ascii?Q?kfsEPCY6uN6OsIeBfCHblem7sOUs7Pg4N/6sRDjuD2ASeIVSHctlposXw4ny?=
 =?us-ascii?Q?XGn1tSQDFnoLWVFu238N+860eptqSIb0r26bhe/UiImqtZh9t1djvFUk/mYP?=
 =?us-ascii?Q?Q6HnR+frS5sDNzbnkgjlYp7SxreOYoq7toUJB1m33OWA0+ONn7/QhpVYHLFc?=
 =?us-ascii?Q?EF9x+ggsJcYyIq5deceeEPf1MWtDdV168DrUtiGf+89G3HwR5y3NUCADiHal?=
 =?us-ascii?Q?+pIgluvm4NqWhE5G7SqszeVIE0eYPTkNifCNGNYK7wRxSUZp18T7dQe5dNDE?=
 =?us-ascii?Q?dgFHH5EtpxFh/a2LRFi5O6f3jSpDJBCfmTZynHi/nuxdXCKRacAlHmI40060?=
 =?us-ascii?Q?enf6s+tttINNGiBtqy1SPSRsh5y6qgt5fpKTZq+Sy1RiSNxeKjNrDYYMp2Ju?=
 =?us-ascii?Q?4ulEiRMlWnQ3uIITf27zIRUATOpdB28SNwl9lQMMedPlrRXE2Tf0TF7Lz2eX?=
 =?us-ascii?Q?nHP+WARdpPOF5k73kxTcVtQ1OcV+KdHSbdd/mpIyDCS+WH/NhB3tJatYNw8E?=
 =?us-ascii?Q?UJH6Sjne9cCvHGu5fFtRUPBqhzZNyxF7QvXEKcoyPQiNcSlqYOAu9uvOa3fS?=
 =?us-ascii?Q?SMXrS2PYNPx7ML52Qgu+r5vGI0DCvjY883rgE0UZNEoxA2sfEk5bxunwSsqf?=
 =?us-ascii?Q?fFQLuN+haY4+lXP2TxNgNU1s6Gg6dDtB/aQRad1CDyVHYSd9skueZWtIaDg4?=
 =?us-ascii?Q?ScSuIME/aWE4kmXIvyHBmVFjyDPv27z2bbtvaJTALnvEWy3cfociwO5QAaCC?=
 =?us-ascii?Q?NUdfsC2D9f+y6hkI4yo68s7QaC28VNgx+mASf9HsZMXEKgSilC8mHLSYztqf?=
 =?us-ascii?Q?yi3dUq/NTt3/Tu0/zv7wsMK1SYP3rr7ZXRMWIXs0SXEA1FuAF/qoFehue4vS?=
 =?us-ascii?Q?JB9pgOMtYnJ7fX1NA0P3VkOyzgA+62xM4NXgFSnYuuGqIH+AiWgJgggJr80U?=
 =?us-ascii?Q?aeugTwq2CNito8sIg7ONZAYSc7y+65WA4QETrpEpXlVGfirrt9cZ3338+hw/?=
 =?us-ascii?Q?tqnlLVUnB2D7LmKa5Jim/GrxNSVG29gwd11C/bs4gAAgSCD1KrBVB2EEak6T?=
 =?us-ascii?Q?CGniXSx28/5cGuQzp0UZb5+NdMn+gAwsxRXuN6dzvPFx3PHX85s9I4LhclGb?=
 =?us-ascii?Q?5jXrs6vR3fBt6rB5bg4Zr5p9TK6W+rF/wkLBo5lVkUMFGKpBOe+RZGX/Tks4?=
 =?us-ascii?Q?VOkIKpAM9sjhwWHjPHrUPjP3KNmrdJSK4P+okh5ZpYmITnOEmowstLxiDu8N?=
 =?us-ascii?Q?zN9CwMgrzYuZJRLEOyn+9USCbGH2oRj5tKA0vXhLxioNfeoCVzoerFkm6fuK?=
 =?us-ascii?Q?h4mhCTjn4hQSNf3CZWbw6qo91AJYTxrgkYXUSdMMtszViqwk7LC43+YBbBNn?=
 =?us-ascii?Q?3dPPXJ3kNjNxdZjWhp1v3D95q36XNYMznMxKf2dGlQwZgHyWLUsjqXnLQb8X?=
 =?us-ascii?Q?J4RiGhVgU4s8BhMN3WUYnWKT2fpxX4PSGQ0IuIuXnQLoaKXvoAonykp0vbct?=
 =?us-ascii?Q?WivM9pYqgFjVw8jwGLkQcIf6zQs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224fb287-e629-41fa-16ac-08d99fba3797
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 17:40:39.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdM9k8qjR509CkN5iI0801Rvebr/5182DlyHLgq0fequRsOfM1ZSSydUww7m4ULFjl/No2NFliSF9PO4w4POHfSoGdkqG8gzk7HEsqllRDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1375
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040067
X-Proofpoint-ORIG-GUID: GW49e5N6bCSBBIFD1nVi2sJ0a_GSbCM1
X-Proofpoint-GUID: GW49e5N6bCSBBIFD1nVi2sJ0a_GSbCM1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 07:44:22AM -0700, Joe Perches wrote:
> On Thu, 2021-11-04 at 16:00 +0300, Dan Carpenter wrote:
> > On Mon, Nov 01, 2021 at 02:32:00PM +0000, Karolina Drobnik wrote:
> > > Increment `idx` in a loop instead of adding the loop counter
> > > `i` to do so. Thanks to this change, the cast to unsigned short
> > > can be removed.
> > > 
> > > Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> > > ---
> > >  drivers/staging/vt6655/rf.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> []
> > > @@ -700,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
> > >  			return false;
> > >  
> > >  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> > > -			MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_init_table[i]);
> > > +			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
> > 
> > Of course, idx is no longer a constant so declaring it as a variable
> > makes sense here.  But maybe just do it in the same patch because the
> > patch 1/1 doesn't make sense as a stand alone patch.
> > 
> > Also don't declare idx as an unsigned short.  It's better to declare it
> > as a int so it just works like a normal number and you don't have to
> > think about signedness bugs and wrapping and edge cases.
> 
> No, IMO it really should be a u16.
> Look at the iowrite16() within the call to MACvSetMISCFifo.

Obviously we all agree it has no effect on runtime at all.

I just think that people get into trouble getting too creative with
their types.  There was some discussion earlier about where the casting
was required (it's not required at all).  It seems like there was some
confusion about how types work.  Declaring it as "unsigned short" has
some documentation value, I guess, but you avoid signedness bugs when
you declare things as int.

I don't care too much, but I also try to tell people not to be fancy.

regards,
dan carpenter
