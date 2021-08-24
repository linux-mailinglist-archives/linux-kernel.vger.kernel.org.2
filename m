Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC13F6540
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbhHXRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:10:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38566 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239047AbhHXRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:08:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OFDYrC015014;
        Tue, 24 Aug 2021 17:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CxA6NxgJgDIHh2yqatTAP+Xqkcn0X+wgnlAWzGmj414=;
 b=tZktPbJRvmnXr5aUzviQM/gFqHTyfF0TiGnqAov46Ob8ro0iZkdp88kXFDhkvNKXHLLy
 GbpYGJL1Oth9eiT55oZyvDmlWOM4XWo7ctY2MiP5Q2GnRjxmuZA1YEVxSZUcLlWblxyo
 PNNbdJYR1pOSBhZZ5PN7PXHIEm1R0CRfUDwzHQeOCyzNG4Tbv5V05W6SRDFzXJ/8qVW4
 9+y1DS+3VOJrKvB5ibmeh6bu8rag9MUfeMU8aptw9qSzhWdjHuTuIztjrazyt0kLaZP8
 FqqaUsviuj8xuuqt2rQ+iwnhkwiUSGJfnsHecCQ1enw3kzAT6/1J2FIDo7qwdce+wPwG gQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=CxA6NxgJgDIHh2yqatTAP+Xqkcn0X+wgnlAWzGmj414=;
 b=UjX2MrsUywF4Zq0Qp+sOGSVcFM/QAHC55pXmssYVFGWl7bxuux7R3QSqytkaT8wct55p
 /ieIxH9IOemf0haJ9UQ2XSVjj/69PohREwNbr/o39MnXDskUI5px4XpMDw+nXianevGl
 8EVuWECmrmbifZ5H2/oK/m58DE1SGX9lmhOpGP6UFyEjlJ3CqI9qNJztccOYZYyxVhQ8
 rbOFXjNCcSInaEFHuEDd8xFYkc+qSZvCh8HEP8N1mwLTIV363CxwTyRzTlxG9wdT6AK3
 u2v2g++/2t6u4EbR4KyXn//80RXwv16aDEiZkx4H7npjFC0Ri5clK7eIXGX7l9gXxd9D QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6h82w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 17:07:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OH5UWa011519;
        Tue, 24 Aug 2021 17:07:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 3ajqheya45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 17:07:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXFldN5B2Fc6utmlMbMsDKrUCCuISHMxU4KM3L/Mei1C7WrNnn3eE94TOAAcOYpB0M5Kt6A10DEfu3XLtgwRYH8/Mj2UTQcbqBEzqYY6ZY27WIp2L7MjkIoHW5o4uH0FZiMMwabeVLFn/wBaMw0lOF2JdKy1bevcLipytKlfq8uX26I7qiZqRerKK0FuP/ag48aefejYfHrUBGv8Vgr4HwsBUjwcfytDUz7pWggChXoQBXzyszIxiYMPPnB3EX+jyC5BhYhTKu8AlAXwgnzr32la3a75yBxy1r4iBX6tcgea6mkI5Bl/XRN5x2SJAxrfFIo6mLVGcexpVgnusPkr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxA6NxgJgDIHh2yqatTAP+Xqkcn0X+wgnlAWzGmj414=;
 b=g3uATw0zRDO9L/x5M7hpHU9alRgt2onPkzHGXe/EKGtbA/Dopg8bErlzZWhhFEniS/8rMO1uYaum1MpkrCjRyPV2dVfgn+nf5zb+D/T/MRkMolATL2adVF6or93NsoSlr/zrZUFtdvapP+eNbHqtavzWkJXp6PRnVjqIPmP7XpLUvAQkMJ5mUdm6iPrITCwBpnx22JuiuWuvf5W7z+Ksd9NXSHBFpI/C69DQebDOKSMhGktGeyt8o7lK4DxMiTmOW2duxD1/fEMVfxSQY9k8CjHg9mq1Z6csOY6CVpwL96h72NUwPRwQaWNgzbPkdpD3GlEpvkhdQXosJUbboAakfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxA6NxgJgDIHh2yqatTAP+Xqkcn0X+wgnlAWzGmj414=;
 b=H00p8/BkAL4qk4Lj1yrMImzFVFOFp+JlIedMgHjNEtkl0tM/MIAJ9KY/tfI2rqmXA4nzO7HOaEBqAINshA9Jo7PdYPJ1Wx6XglF/9vpRo1TGzXEJK83UVlYpZGyz6l1igNCC3yM/+TmUj+mIfdwz5v4oohiyLNl7QURAWkDibiY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1637.namprd10.prod.outlook.com
 (2603:10b6:910:8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 17:07:34 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a%2]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 17:07:34 +0000
Date:   Tue, 24 Aug 2021 20:07:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: fix an error code in ntfs_get_acl_ex()
Message-ID: <20210824170720.GO7722@kadam>
References: <20210824114858.GH31143@kili>
 <20210824163851.hfbjqqpztgk4ngd5@kari-VirtualBox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824163851.hfbjqqpztgk4ngd5@kari-VirtualBox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:07:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26573e35-2641-4355-0fa9-08d96721aa9d
X-MS-TrafficTypeDiagnostic: CY4PR10MB1637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB163781A2324E58F7AF98A5C18EC59@CY4PR10MB1637.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDyrTHI+xJCDZ68AsBbGXUmdWPDBmIja+CSC6hZbylx0omNFMlgUE5DktV8kTm8/5ep95vC6WjMXTrzKwBYqQmVROrdan/5CAiRkMyTI0ezxte1/3RDMgzMbG3wqp8am9uq3JK+gkvvtuN1YYSmt1TLt/mzhXaQgpLATXeDVQXBudZA+1CFnl7+ji0O3DWx2EsLA70jnSLynT/iZKIZR/yNGP4MU2CGU6n/a+w6/XQ9biNXwv+Xixgb0YCOWtZrnmMvdhrDxijRhquTqF7YqSzhWr2SKE3oI+s2w+p2cAg1Vpnrk30QjK2+kTFv3w7lPCimCZa9OODLG0+2uIFtBgmIoo69KYBD+q5GIt7JE4243PIRmIOiwTrYMxRSnnu3/ug9HWxrIPLuP8WWL1kO4hQk3QocpvAUY0mky2J6/1S8pnzrmjbtJO2cmJ5kLRUJU5GO2XAsrXxDkMg4kN3asLEKThViZlFyWKOzByxhTA/V8VzCyVFn6JL7PtFck3hlGfBPr2PmUPkPGKPpKQb+Exar8l0O8kJurUsRt1altLUvqR6f3J+L28rSHkovCeNuUWjq7xkPkGXRo4vZkgMUjVhGUrbR6gj0q1Iu23Mjuelsy89fSu965J9EHCYziQRbfiMVF7dVxsnWKTJ9rFVZpSuk0lSIxCrCW7pbbgbunxjJzt/lz82OuPv48oaH3fjI9uF/8NhDNrYYYe28xtT87lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(396003)(376002)(26005)(1076003)(38350700002)(5660300002)(38100700002)(33716001)(86362001)(9576002)(186003)(55016002)(2906002)(8676002)(956004)(66946007)(9686003)(4326008)(6916009)(6496006)(8936002)(316002)(66556008)(66476007)(478600001)(33656002)(52116002)(83380400001)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pj9UGV4v3NYFDoAEJtTfnuAtkRIvaGVnS/tTYzoNSNeM0By1r5NWFBaiOQvv?=
 =?us-ascii?Q?mkOtkX4LrnwIGctApTfTPekhgnmJWUuRIcUSo4+siW1CySPwLzSh+2fFkema?=
 =?us-ascii?Q?1nqAjIpNKTO7YqD+5d0p0ar6cf8xFe+37q814I8QCmvgllMMSYYWD9/+PxR/?=
 =?us-ascii?Q?cXOz0mFw1IngEGlFSLsShkRGitHSz05f9e3sXv7PWtCC+CKcqnUkPnsUMiTR?=
 =?us-ascii?Q?pW+Mu+icdp6+SD2XJdZzyxeXcQNVDZNaA+sdIHrew2PkskZQ5/WB7fg+IZb8?=
 =?us-ascii?Q?xQIt6MSl9JrPYDh9AiKTLnsQnK1nveRW+cJ8VMyabeExVVmIIfEZLNSaGj9f?=
 =?us-ascii?Q?IPeKD3fvzOzZtxzn3b5Y+rpNd/namr8f5nzEW2VVy5iZ74sY41nGTmJc535s?=
 =?us-ascii?Q?l+znEzZ8RsdG7PNOg/11RLuRaEtoR5ICxcVs5gA/mS+OZbmbTVqARzes+frF?=
 =?us-ascii?Q?YxQYUCJnwij8WGAAflk6wXJk4Sv4JAh9BVqTlGdkuKCxTXGmzfsScrlN7LTG?=
 =?us-ascii?Q?DCJLhnBnyNa5EECXp+enzamvxylprROBz3Y+3X45TrKiMIP7erxqsLMVRmGy?=
 =?us-ascii?Q?4vGPD8BtLEzCdkC4IYMl7MLI+LiALTrVl3lpXZpfokBjtQq5I0+61Nf8akFQ?=
 =?us-ascii?Q?qfg6umgRbFiqd76t1n/tRJyjvQerPahTDoIKFCmZ3IvTC+GIdh6FPV46WLeB?=
 =?us-ascii?Q?BHyJTZloxF0WrkKxU5nfO6txH9S0kO5vB8kom/l9evDuVLc/6r537B3bY5ED?=
 =?us-ascii?Q?9ZO4Oy7BuspeyWAddtQFJCaZ9iyzbwM57J4lsT5jZpkbg7lfMBcRywO6InCv?=
 =?us-ascii?Q?Wd4fQu+wrQk0jfZqhf+qc3NvDXKxjk7+VMG4uP8o56glqn0aMxEYetmPojeg?=
 =?us-ascii?Q?GCxVEGP/MAULmlUQhwhC5CifIvLqGRSLJ5fZ0xdjxdJvZTTEJVioGYcIfoL+?=
 =?us-ascii?Q?0fdljqehOSAahE+3eijxYnf79rjEnmPgApk6mb36BPXQt5/q2XYFWolB9B6Y?=
 =?us-ascii?Q?lSj8IsLgcDb6D3Lco99yNhCUygh6y95mwmKFK80qD0clrf5kfn24VP9qbA1+?=
 =?us-ascii?Q?0XZuVOh9aAlIFDJNfZkKf4pKsIomVfOeOhYKukFsEwsIA3ol4DuQKAC5l995?=
 =?us-ascii?Q?4D65vmexKHU0eXdVWpNtHoy4qf5yVbn7hITpumY9jE/YlwiITbS7INzxxkK0?=
 =?us-ascii?Q?TbPh5QDIbXHyvuo5ZzysSp5E0fxzuGmuLWdJpYZdmj1dqufcTKyaP8OxhITH?=
 =?us-ascii?Q?XkNHp0+ceAN9gRIINDhUh8HpD69/jxVmmmwRIyMrhGlZv3Dj1UGHp2Ex8MxE?=
 =?us-ascii?Q?DAePNT1EUoQzW1PSEEy6029S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26573e35-2641-4355-0fa9-08d96721aa9d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:07:34.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0YHES+5f4NVVT6axK8k5bvaoFRaluMpKDSl9SzON8Z53ydV1V2j/QXKbPwIdrCtgoJfZyKG7BYIq1wDShvmfs+xtvkKk3/QkVL+sgm2vR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1637
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240113
X-Proofpoint-ORIG-GUID: 3raqVmNtmgUJwyrIbjkfFIKdY-hF3qNA
X-Proofpoint-GUID: 3raqVmNtmgUJwyrIbjkfFIKdY-hF3qNA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 07:38:51PM +0300, Kari Argillander wrote:
> On Tue, Aug 24, 2021 at 02:48:58PM +0300, Dan Carpenter wrote:
> > diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> > index 9239c388050e..e8ed38d0c4c9 100644
> > --- a/fs/ntfs3/xattr.c
> > +++ b/fs/ntfs3/xattr.c
> > @@ -521,7 +521,7 @@ static struct posix_acl *ntfs_get_acl_ex(struct user_namespace *mnt_userns,
> >  		ni_unlock(ni);
> >  
> >  	/* Translate extended attribute to acl */
> > -	if (err > 0) {
> > +	if (err >= 0) {
> 
> So now if err (size) is 0 it will try to get acl. Didn't you just say
> that you want to return PTR_ERR(-EINVAL)?
> 

If you pass an invalid too short size to posix_acl_from_xattr() then it
returns PTR_ERR(-EINVAL).  It was hard to phrase this in the change log
but I feel like length of 1 and 0 should be treated the same.


> So overall good finding but maybe more work is needed with this one.
> 
> >  		acl = posix_acl_from_xattr(mnt_userns, buf, err);
> >  		if (!IS_ERR(acl))
> >  			set_cached_acl(inode, type, acl);

regards,
dan carpenter


