Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC63FB423
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhH3Kxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:53:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57684 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236337AbhH3Kxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:53:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U6wpYt020827;
        Mon, 30 Aug 2021 10:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=sd+bb+gDxgRL0SbgG4hmkv+Pr8q0+Voi9pEY6LfdGyg=;
 b=P/uEQL6CZ90/Z1kJXHHyAoOkpvJgbzX08nGfZcJhW20wCOduZHpzWXt4juKIFyh2C30Z
 yJZan2roWcqB/U1QDf4HwolKG/E33Fef81KqasfGRQ2LgxHvpzz5BRhh5OynPvh6rAYL
 fa5FWBxccBc8ooaknNjsxpM9AgtgzZwxYK810CHNDywZOMt22IEvxZ3ppccoORRomjNs
 tDvRWv1SSVQSMPgHSH2ze7Vqs1Rh0RVUTkl52OuJNpKSPrSOxSrU2GtCqBRPviZjGlbW
 mVG7ulQB6r07bUEOMxvT4zf87vF4m20t/qZtZDb2O0jGMLUFOti4/WSP4Wf+Idw+txPB Mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=sd+bb+gDxgRL0SbgG4hmkv+Pr8q0+Voi9pEY6LfdGyg=;
 b=jV15pLjrP6lyzGl6KZxhK2CAxoBbtpGvdF4G2GVvZNp0I11RymLiuNuLxv00vg4Q8L04
 XBXAUuMXcbWn1hWj0aOkygj/easKX+hYzTzZdRtow0gRywkvHQCsxUDYvAkxCs/a1IQc
 HiajXTy7PoMszj2gvOVv2NgATL50jo3ZNZQ+z/VeMCrdjHzp+V0WxQnZyrVt9s1ZboTU
 NWKs72JuT3r/vo/turTTedPtul3QIGoliv5m2DSIkmx9Mt17LrP/whAX88xiq8LTEIOn
 jPKSbIP48Rx6AnWWW8t/bZD0LW3AZtGKLjNltIs9jUHO2A6Fn/CAQFXtwtKmKXJ0x5XF Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arc1a186m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 10:52:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UAnfdH033898;
        Mon, 30 Aug 2021 10:52:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 3aqb6br8ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 10:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5YCsHGD+9ylA17d7DeSfUIgKCalGPQU/Iyf5hMWCn83JbKcX/9yHStBl/Kr69aL71OM6ycfTyG1gIrvO685/ckE/bfWoEs+I93540kPmcy9lKHqdQXc9AJlOnxGI2gLmRfOV4AMMdVpdF/dglHcwCbQA7ww5AbEOL0fi8QHO5QXqkFDTsmjs48wTI6sIbykMkxuBzipwzpTC6QPBT1o/TEItpxtGkw8Hj0uhnTh7RGDqJJS8vgebfsu38ACWHan6Dmaneqczggopxl90aCjspsRh3qOCLTA7KYcyQ8jwrhMWP3swkDgvGGM60ALp9w7m/K2ZHWyhmAXaPYFp6RxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd+bb+gDxgRL0SbgG4hmkv+Pr8q0+Voi9pEY6LfdGyg=;
 b=MW0MlURnlXBSLdPLMHUW/dhqnBAMCOFCitdJZSdxsmYSlpZGI9jjOFtMfH2FNTuj1PbmUCsazi60eAgLmuWS8M2wLgnxOwY4FbAyEryNMcZyaT6GjU9Uk5aSzTnMClAovAed5D20nD7hu282jKCn1CvcFJntLwJ7mSBVGcD4IKzCmMIbzMiicSzhRN4ryTY214f97QkByG6m6shW7MyvZRSt/NRYg3uf7Qyr3omcJtNV8tQFjz55TIm1qV5qA8F9dt5B5yGmL9cvGFBHIQjWuG2NDihPhihpPW2iTkju9gTRLuDesMM1XKOqokwr62cmStMqe6+eLi29MVac8jpW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd+bb+gDxgRL0SbgG4hmkv+Pr8q0+Voi9pEY6LfdGyg=;
 b=XE5upz/bu3vWhe2DiLe6C5vqX7Qn4UsA/DAMy1CWn/L7mScrDOo7pl8s01hsu+XuXc+43oebb4et5DNj/OcCg6ql9dQOBtUp/kmCJCFmqiD9/V/NPk9Oa0a5vpYy02zznzd1ZtI6UJJlnx9oxhwuniD50dxalg9xXD3MCLK/m0s=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1999.namprd10.prod.outlook.com
 (2603:10b6:300:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 10:52:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 10:52:32 +0000
Date:   Mon, 30 Aug 2021 13:52:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] staging: r8188eu: fix sparse warnings
Message-ID: <20210830105217.GE12231@kadam>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1630148641.git.aakashhemadri123@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.22 via Frontend Transport; Mon, 30 Aug 2021 10:52:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e6eb207-c580-4ffe-d140-08d96ba444db
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB19993DDE71C3588DAF568D258ECB9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YogqZhRjlLbGPtvLvQKe7Dx6N8XSqT+WQOi5aW4rP/xo/00BCaisyv9Y98ib4FUi/+fwOYkicJABKx5mKPaEO28rAbV+pIrhrhuFLHhsYu8E5fcMOWZxoax6ZdT9v9I4aHOp1Qp7vbqaa8h57oby5EPC8yQgQb5V20JIHKseokM+ok1UpcBoG9Hz66SQ7457pNd7VYqs0qoxVuTniMUo65boFx6FADU952m6FE8YzFnoGEVJmUj338Zvu0ryVf2vo6obgVshAjyRL1++XPaNBrZws+wOZPTjpV0wpCUu1/MreA11CEMKJ/149feImJUUM2imOchfTRXwpxJa4wvGcy/xzUu2dCbh05F8m6bqP0zPfKrfCJrIOERh5A3QGAf124TEPt+HNuJ+K0d8kOjQ+ffGvzvZL2LAxrlBsaXK40wg+QqDvOQed5RhUDoYzMW0JHstUBai6uuc4/IChkR3z5F5By8YifKeujm/ICbX/MCt4qALVFCI92b14fmA/3ObwiWfZBpvciW71757YV9QFSb6YeuPiy5AU/I0Ch+We1C0HtwxN0JmC1R+ef707qY9N0sNp1tLjwV5GfnZSRWsDNvyhInXameeAfFD7R302OICFOMngD6+RQFH9Srm8UzFyZItjFrzWzKGt5H97gRXzUg1S9ZztH0oNbuFC/Rv6Llj63CHJAtU+1FJIPnWdSf604p9vkIWsEdxgUrfiMvvDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(2906002)(86362001)(316002)(956004)(66946007)(44832011)(1076003)(4326008)(66556008)(5660300002)(33716001)(8936002)(38350700002)(6496006)(55016002)(38100700002)(478600001)(8676002)(558084003)(52116002)(9576002)(26005)(186003)(6666004)(66476007)(54906003)(9686003)(33656002)(6916009)(4270600006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2yPxFjdKZgZvkdIBbsctU97Eovtb/qMnLIbU4i7c0xsOyAveJnoWkQlldIs?=
 =?us-ascii?Q?qmF1yTLTVxUY0pzub8ntEOngXhO7TFaaZWKIwwO6ZRkPRuCrqiaEDm2RkeUE?=
 =?us-ascii?Q?GC/ykQXGiMSB91dQS1+4kBrwU8iFYJRDmUZT4MiTFc/cZMjk05PjOYbCA0i8?=
 =?us-ascii?Q?SpdxMjTNW9DgTRmzV8fSiKWYWRNyzMRcIBmwKkLxGysfdx0+yUs5ZuDAVpB5?=
 =?us-ascii?Q?86KTLuoYpX5ypA1Fkry+5khgeD4Jl7NA7z2AmSGoV19bT+JUKJ5N3oTqX1wA?=
 =?us-ascii?Q?QCJ/FetzEz8iFjjTfqh9fjB3kn9/IwoBlOyBrRLWIm1fLJK1HLQccB1n0eNw?=
 =?us-ascii?Q?qyRX2q0A4trwiItibXYLMnPdNISAMlPaHA5BBLPmnJfepuXOcuLZyl6AFr8o?=
 =?us-ascii?Q?hyFm+IyGV0XKyNcqyO+5WvsViU6qH6cz0VtSzJXEacbUxfSxD90c6CNNcvs7?=
 =?us-ascii?Q?iS1FAnHgNY+Wpfvr2h2NE2gaHuOuBZVEaWmCG+oqlMr7AWULNCta6yhna/pC?=
 =?us-ascii?Q?HhY9bY6KRPOvgyD91u3vIYhzzHYEB88kE9WJwZH50r9AcDg6D0QIqBGn17Qe?=
 =?us-ascii?Q?hbkgOqdupzrt72ZWQ1RTu4fhB10KxbBpATfOgSO3broyrfi5Z7QGFURYOmvh?=
 =?us-ascii?Q?zNtcvWQHxVoP3m4s4mmGJQ/Ej9DfdTBlOQ8+almtWIGRm2DLT7oAzf8Je2rr?=
 =?us-ascii?Q?Dco/LdaqUXc6o9Gt8/UlE1Kf0uovZx/4Wm26UmmLTy4An2K+6czbt71A/+/Y?=
 =?us-ascii?Q?QTOSwHuccJuyiIK1qwdpF/HnLHBg4s40KOAYzDSgjRx3P+Nz2Ni0hmqzsSFV?=
 =?us-ascii?Q?X14TcDIv2b3ICyfitkJBpSaPW4LD8ETVC6UBkbW7kaujn+7sJ9ZHUSNiu0S0?=
 =?us-ascii?Q?AwcdGvpm3nbWqfrlu0UVlrUFnyL0AFBh2tDVMbfjOKRIhNnEu3Yw4uSQWcSF?=
 =?us-ascii?Q?qWY5TLP6r2z67Kn53UXdQDtH5KmoM3EiVbO7bV4tDsI7pacQ07pJaIq9qMUP?=
 =?us-ascii?Q?Do5w0o9mOZQ5xVShlf5CQV9al0Eim1OSl97H9T2y8dXE/DSOQfDuErqnb0sC?=
 =?us-ascii?Q?JFWqQoUBo9IV7tvEvVrmZNCsB3dJ22gPduPVy+MABosHCTSy6wkucZjFNMwj?=
 =?us-ascii?Q?7Kc25aT8/fITbEXR4pdlbHLUfOn7tnIetZzvNSiMn8LE3ETBFQD84st03JSE?=
 =?us-ascii?Q?GJ3H9Xaa9OPeDRGhQWFZeOmAc3tGMbg0BaB832aooCnjzqGTyGfxtTp1G3XJ?=
 =?us-ascii?Q?8GUeGr6FJSBCuWg/NXmx/HDXIOXq+ATyMaMxOETPuvfqkVfNPguRnCyj3XlP?=
 =?us-ascii?Q?kyfwJlS2aqJjP6u0ohYtTYsX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6eb207-c580-4ffe-d140-08d96ba444db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 10:52:32.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mi7kl2zcJqMUIRovxjhB+D1TQct9XI4Anf6rZnMf6lmAh0l5zyhDZ6AWbOVgyW362Mnpdf/sfKqZaFwWBLRUdYIplXdmF85ATJbCMr2z+Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300079
X-Proofpoint-GUID: eF5Ll3VBEm_PRbmWeTe0hjQOahIJVuhQ
X-Proofpoint-ORIG-GUID: eF5Ll3VBEm_PRbmWeTe0hjQOahIJVuhQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are fine.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

