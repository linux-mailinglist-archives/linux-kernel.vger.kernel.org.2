Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF7412E40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhIUFho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:37:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3334 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhIUFhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:37:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L3TRRe019335;
        Tue, 21 Sep 2021 05:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Xpwr4WCdeHdBNvpZ2KFLRrnQ4l52NoVwFqqBKFGLH+U=;
 b=fgthEDp0BDOP2BPgmG0PvkBYG5HpL5zMJoMkWVQALM8EwhIx7thX5Ndmo8tq6dL8P7Im
 /qY3/mw2asjSVq4CNWI7CM9EEsFfET780TIqpgCQccQNZ2AGGqfgTYVlrJkLSKtewEvj
 CKxQRBwoy3QAP30ZhboWUQ3kC8eUZQ6p1rKqXC4pxReBQLS7YkGZC5n+pPmzR5CMSFS+
 m9aPwah5lGZvqdaKD77zTc41yrvAGGGjEE2oOP6U19jrRI24520L6KMFCOnqNPMH459r
 j0rpouJLqbFKR1kFEnxZXCmrojjnmEYLIWx6Nn0B3WJ08xrwl699FwA/wdzkkV9qBd4S /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b757vrmwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 05:36:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L5ZwJq005299;
        Tue, 21 Sep 2021 05:35:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3020.oracle.com with ESMTP id 3b5svrpk3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 05:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avg7frv1J+XW9Z4oL+Tk8RKRSSc+iyKL/Dzjk7aQb6FMi4jrI2YoCKJigSwLvEAfTT4zByqhvKMT5qaV/4vKLLXndxUPD7C4s/uoBMCYMxlO0iL3WygxPR/xdUCCeOhi+m5Rd4WPJtyav/SAtJnhgyMXScH6EgrehGNufkMiUfXmPtBA6VhyzcO9maffhgS6Cq3dmMpoV53GmHSFD3wpMgZLi9Bug2M2OP6jJzfQikqvas9zXiEFX/9C64TV6QUWxAYCZHzdQ5KIlrXcQ1Oq0HgxYlIfp4r8QYlm+bJpmRyogEBFx3w+jasuLnSHfYEZ/Mp12L7lbbOEjSzxARhixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Xpwr4WCdeHdBNvpZ2KFLRrnQ4l52NoVwFqqBKFGLH+U=;
 b=NhaEpCJK+RDi92xZ5auupjs0XWazge0G1CBoyREz8FOuLmPJcYHkT4wn/WrsPXlQRs9Aos2QOpX0OtZzvOrWnGTtICSHKOgGkvRcM6dR5tuFYCzgG6nFILjZfA+0/hIPfTHTKY59V1sz24WIxLZr8QMeJtDxV2W167OZOjaxxM0oSbMo2Q99mxwBqB8SAIy9ek1WzskndaDClfipiLnMXkccL0okJSLI5ZpHVnLg62a5fZzIBkgrmHwhxUssuURYMGJ9YdmcG4LAE7fuJSkmnwBzdxyw+GSKcUMy7v/tbq60YmHatv07PjkQpDLRezdOJ5tEvaut1LkjntdMwcjthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xpwr4WCdeHdBNvpZ2KFLRrnQ4l52NoVwFqqBKFGLH+U=;
 b=Pn11xgYEsQ7ElMj8IXXiLmoM3dYeN9zomYdaqEe3ABzWsbngqd7d/wk0+S7rSepmbTmqaMl84bWcstmyYmfEdltUimjzXp47Tkn/tcUXmbm23FieA6P1YYwt7Kf3+TwNv8+uujLWoTvkUo40OziGWFUTbP2foFlB85rpzBqhRAE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 05:35:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 05:35:48 +0000
Date:   Tue, 21 Sep 2021 08:35:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable
 in rtw_read16()
Message-ID: <20210921053530.GS2088@kadam>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <3187315.KoBY3qX4Pt@localhost.localdomain>
 <20210920190133.GS2116@kadam>
 <2079638.AGfTBEE1WJ@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2079638.AGfTBEE1WJ@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 05:35:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9060e120-5024-4eda-eea0-08d97cc1aa44
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4500D84AC7933476FACC1ED78EA19@CO1PR10MB4500.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RttSRquujfOZNK94W057EhpTzgXYVRaouarczrU+93EBEr3irH8M3EpmpRH+b1SSh/CzWxlVTsWdztPqZyIDd5ZpQPUehOZyWqWWW9uvUn+QvBdO13Ala4HxCYY178yeWeUCRiRf5J+LRdxhKO0GcLGRuXqrz5BkHYJ/azbn5e38KYLsqjnbHHlUUqExLsHc0y3zYzHtuM//Rw1c83tBkMXLpjQKfOVSzS5lOgozmPZqcq5prvsTZBKdD9X2rNB22gvwlaSt6Ne17orCA3c13yCLA1LxTB8DiVTSV9Y0rShS7VDsydEoF6hFF8xmYwAnUa3EQNtEJ4gBGYsCDfRI/2fGLdHJR7LOBCAAo5LDct/+0DKCwZj7lDuT2y/pTXM292ZlztwtYZa6sEhGKICSGBUpNZMRqlBdh483UO5FvgnfglAb3vhw3aHp60xFDYQ7uc+QkOM1DBRFz1Dq8pURch+WGkKahCensr8qkaneQc9vofgUsHUdFgQ9XuJGS4qwmr2TEJonC3VD7WV1lP+HIFv1f8on1QZHqI9Icuh6SXrIYMSDJV23VOShPYShOHCAGP/zJbVk5hwKzNzB7z5I5nZcep0xqCATr9R6+K2oO9batUVRhZ0FMsRGdVvuTREjRii+L9yaxNeavftZqn2MQyvQiK/rFLLgToAV/T+JEt61t5BOkP3DvCMeSdBhYj+YcbKQEsd4MThDU9SYDzoA1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(53546011)(6496006)(83380400001)(5660300002)(26005)(38100700002)(4326008)(33656002)(186003)(9686003)(55016002)(8676002)(33716001)(66946007)(6916009)(66476007)(66556008)(508600001)(6666004)(1076003)(316002)(9576002)(956004)(54906003)(44832011)(38350700002)(2906002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tX+x7e07v8blMcUdp5Y7QbvrGU2h1lHK4YjJnegYKRBbZSMkmCW79cU9b1EP?=
 =?us-ascii?Q?fqo99a5haQi9TEYopV+4bCgD+fJ1hVtaChf4Boc8k72VDjaloVSq7f/0gEBf?=
 =?us-ascii?Q?OQMrJwS4JlDgdUAbdrpBKPP3gViYz2WsJP83qQqBYG6LMSxnwE3fug9pig4i?=
 =?us-ascii?Q?UKX7i3VIHwAkMFfPf6NSIPBecqTi4kUBIol6KMFCJZZKareJt+q9JmdmVAWT?=
 =?us-ascii?Q?/B2fhpinKk91HDNOWYtgGgJ3iBzOOajw4ZBm4V0kLhSpPni3hLeqrBTPhxYZ?=
 =?us-ascii?Q?wtyAz4Y6dGfrMld3pWk+FzAsRxFhRROr5ioWGVt4FO7335otMAo/YFrbAv97?=
 =?us-ascii?Q?N2X0be/wnY5asGA296qHAdUJR4BfieW15R0b1PUMiTqrHe5kgYv4ZUpWE17l?=
 =?us-ascii?Q?bxjjP+BKi5/Ye+50JjLacBSEm34NGEmCEnJ8euVnZxch41/P07A7Q76vw+cw?=
 =?us-ascii?Q?+XG4jjL7U+Lq4wsvTxVfDMzjjih00/OO/pjwY7IN3k6MAbPKKHmC3yVRixB5?=
 =?us-ascii?Q?mWVzpm+f2EMDURDTCP+sXn2lJKB7Mw2JeYB7qBUMSVQhoHtpsVGA1iXsPgbt?=
 =?us-ascii?Q?hFN/MUoOE6jHoJzp2EFhsj/bnXB46EFE+fDCCrOmo0jwxAinpLscqyDU7ED6?=
 =?us-ascii?Q?TKHkuCMwfPWM++83tVEsRxJW1rpqA7ovrteE8xBde7TW8ob2XZLaUmQyG400?=
 =?us-ascii?Q?2ua/uNvW93WDS7spQ2f/CDxL0HRIy+klrt0sNjylPf5uGrDOtO13wREl0FF9?=
 =?us-ascii?Q?o9Vvs7/qElSlCCCgGeMHzbFFK6g5jNbQWCMHEqLqcpVFIkMuobBTpKdDq0DM?=
 =?us-ascii?Q?lxhYechwpUj2DaQ6HV2OMUPnsM4VTvpoPbqQpITwxSB7oAJwhmJt3k9RifnV?=
 =?us-ascii?Q?JyBWXqC0MC4wqJ6rvlHtEFS/iAEEDng82D4rtVFfZtVgKfw8Dh8Rt/YIkO0e?=
 =?us-ascii?Q?uLb378VJRZ4MekvknpH0yhdlOGKjjyHqYECDc83VnrdHsuZJkN29SjKLGv6f?=
 =?us-ascii?Q?dgI+93qxj9gDFfU+9423B4M1cEtittiY5K8+udV0GE7YwR8W/OgrJ9hOLyAB?=
 =?us-ascii?Q?XWJRXb7jxKsTEIDdd90vqni3S+ZDMXmWoem8UfaEMrHCC6hfxBfcCHgjELlM?=
 =?us-ascii?Q?U38rXCOr2M8itBaUyzr0SBE/AEPqMiORCPRi5UHNAEwNUGJW4r/C7inTp1RE?=
 =?us-ascii?Q?EbHZ0ZM/gXAQD9lULk++FwjBbqiojX+YcOvXw2/XlE4QIFNLYlV1AkCUbcJZ?=
 =?us-ascii?Q?GU3w87gPAX7WfDORn9dXLHT7v8TOplYOJbZhF/Aj8xciGzvxNOcqCIcV4Hgk?=
 =?us-ascii?Q?FKhRvBJ3K1hg+IuRwl+e3viu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9060e120-5024-4eda-eea0-08d97cc1aa44
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 05:35:47.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62UQPL8oevvrRNr7HlKirZ0EJu2+kCAx7/rh/6VZszdLFuqmJMVmF6iYdIruD9rUcGOjNPlkYuSYLNqly4XQNkMtko/0zqwVACsFV62UEs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210035
X-Proofpoint-GUID: PGkK_EBsy7UtKniWqIwg7uhlKIyjYE7j
X-Proofpoint-ORIG-GUID: PGkK_EBsy7UtKniWqIwg7uhlKIyjYE7j
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 09:54:41PM +0200, Fabio M. De Francesco wrote:
> On Monday, September 20, 2021 9:01:33 PM CEST Dan Carpenter wrote:
> > On Mon, Sep 20, 2021 at 06:17:36PM +0200, Fabio M. De Francesco wrote:
> > > On Monday, September 20, 2021 3:10:36 PM CEST Dan Carpenter wrote:
> 
> > > Back to the code... uninitialised data is not a problem in the old code, 
> it's 
> > > just bad design. The new code cannot affect runtime, it's just better 
> design. 
> > 
> > It would be a problem for KMSan and the kbuild-bot will email you about
> > it.  From your commit message "Change the type of "data" from __le32 to
> > __le16." it's not clear you understand why the kbuild-bot will email you
> > and why it's correct to do so.
> 
> I guess that for sure you are right in saying that it is not entirely clear 
> why the kbuild-bot will email me. However, since the change is correct, but 
> the commit message is not, I confirm that we'll use your note with only a 
> slight change (only if you agree): replace KASan with KMSan in your text.
> 

Perfect.  Thanks.

regards,
dan carpenter

