Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52A44416B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhKCMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:25:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13422 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232166AbhKCMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:25:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3BOUE5017352;
        Wed, 3 Nov 2021 12:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Se8eDQLCoI9vVS0mZwUGgYaJiTCvEBVx324dqDeDQb4=;
 b=bms2Rss7TUs3+skPhp5oZVBweQ2SyMODhT3Q2PFYF+r/cof/2s9d0sLh45MVGxDKGnzh
 HrylURg0hsLlqxQm0NSjim/UupEp19bAGtmXQqlFAQcXEHziYrnUR5CjNkdKGNJP3MDq
 EK0C13zcK47Ug6AG+6Pl5wmRv0rbESRsGZb/F8LI9W/xEk3Pvf4uZToIRTHa4agBlJmQ
 CPrAll46S7vLFxOj7lCG5GMtLbWQ+2qj3s+dCdw9A58dLR8ChHoKJfDJrZMq20Fjd48E
 Nltreedd2S6QcPwAQfAhHplujEsYyPXsyWnXY9ZUkE7YkYhyRmYBUJWZ/4B56810hK5F 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n9xhg91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 12:22:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3CFd50038172;
        Wed, 3 Nov 2021 12:22:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3c3pfxhwbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 12:22:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXSzPoSxPtroTb4R1bxpEdYLADZsSxneFqrZNSZ26YOXCRyoT+ci0WQOvkm0CIf29oYKNGFkn7BAXIl2ZPEVXOz52ps2nxWH+GIixFASLm2G5DJNVx8zmPnetEQtykubRo1n6GcjqJr+o/5hRCr9d8aEGwdVZXQUjXAevgt4O086SGsez/msfgcxLxHCX/jlRL2CU4A+WtVV++JIG4Zd49fouceOH+PeYROXN68s1VzAzJo1D7tu4FfcdJM3uRhgHW1eedviuUxIcYmbjaed2p26KEOZtBnJpMmvJ3+7gWLg8AJ2MgGmOW4pNpK68eV2q7p6w9aIIb8Z46i8tGjlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se8eDQLCoI9vVS0mZwUGgYaJiTCvEBVx324dqDeDQb4=;
 b=Oc2e1VaXBDcM6l6qvrQM+ff2jA9OXVdCPYUjcrUARG0B6j6MNV2u7t9ScJYRxhmXM9DOkyoZ2/Qlck+Bk0kf4o3PaPX2OECcD4OyMQN05FVHEY/q6zxhrwYOd5hZMvvP/5BsdUs1ZbnQpWx8AMkKHRIYhQmGpOfua9PIrQeDJxRu5lJUXtncUfIJn7Txy11uWQ6DhqtESOO71tSQkVXYqJhdDundQfzhIggZCStjGYRwXgD4rNR39dqfSQLbYmsbLNtJtDl8MIqzJrVZfIu3LLKRj9yKetl37jxCrBc/KdMHyA0k22a99mOrxUGbv25r50OIkfuzdgexi9XRmkTs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se8eDQLCoI9vVS0mZwUGgYaJiTCvEBVx324dqDeDQb4=;
 b=tJ6QFBbZCi2bmG+GBbtmB4OwI2c7vhrW4zo3sI6Ladeu426f27L2ZMsU9abz6gixxd433wNwMzA+EojL53nNkzN5xl8/NyJuoESqrR+Hr3NRBOYeXgWbI4MrBFKSD3AJOA50v+H7yAZKAB7F4CCz3HrP0BcLSvnqTfnaG0lIHtw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR1001MB2200.namprd10.prod.outlook.com
 (2603:10b6:910:3f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 3 Nov
 2021 12:22:23 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 12:22:23 +0000
Date:   Wed, 3 Nov 2021 15:21:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     gregkh@linuxfoundation.org, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: Re: [PATCH v4 1/4] staging: rtl8723bs: core: Remove true and false
 comparison
Message-ID: <20211103122159.GT2794@kadam>
References: <cover.1634967010.git.kushalkothari285@gmail.com>
 <47dd38847c4e36742f88f4493773fef602ca079b.1634967010.git.kushalkothari285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47dd38847c4e36742f88f4493773fef602ca079b.1634967010.git.kushalkothari285@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::23)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JN2P275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19 via Frontend Transport; Wed, 3 Nov 2021 12:22:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb2e974c-c050-4f1b-f5f3-08d99ec496a9
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2200:
X-Microsoft-Antispam-PRVS: <CY4PR1001MB22004B0A4BBD6410DEA2CF718E8C9@CY4PR1001MB2200.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5fi399kutyN1wJ0nvRV60LkHiLLWjKAFq3rqjhX9DHx6+Q2ZLlsUAyaIXXiOGwdXmy6N38qqWgSMpjqxyPnDn/AcoS6YTF1wLTLNRuA7jsWRSBVqQVm4R0ro15DLditSijolsUa7tYE8J75jMqPQNUg/GLlGE5MYruNlCagslZrcCp6zpiioW/6kkUsEyp9TaaOF5YjSUPrqaspxghmtJjl0aJH6gQ8iuZvXE2vCDryCbyBKYymKrauLH5ZDlggq79tfUmOk6m/BXCrtA6n1NurA6Nmz3d6uaJ2ARWlh+qJAMubPcT+O0G/o0Fh4q+yqFfjL/QL9aTWkeUrA4ujKncM51Rm9vkOamEjYzAAuSkuf+gIExfv9FuFWgueWXA3WZdToAo7tU5u2dIUzJnKovPrC2fGPFM4Ry6T/d7GeresB72gJHMn4XeBGUecRUwScKzpRJrmL9rlM35Q7x1Krf4K5CK0Xh7w40J5mcq1bI3wDUgiTBBbePBFdTgj1UDUdeHEtto7d16lZD7bJw5htlZfGgIy0Y0jMgN1Ha+K5po30I0BWISwjkYOFE1Ly3Lv7ZhnU4hh9KQetIo7uKd6MFOAKxkBF4geZyABmkTLCyvXrTClu1FWkT1hr5YQ/w1pDiUd6qrWztwJ6xeNzkr+ZB9W//9zjvMsay8xVTX5J4Q3EEUxoEdNc5i59BJNdIuNRtGOL5Ezh8XEXagQ5O2nGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(508600001)(66946007)(9686003)(2906002)(55016002)(86362001)(5660300002)(186003)(26005)(6496006)(44832011)(66556008)(66476007)(956004)(52116002)(33716001)(83380400001)(316002)(6666004)(8936002)(6916009)(4326008)(1076003)(7416002)(9576002)(33656002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcCqAotKJ2A2X5vw+mBA+7BUmdRef2gdIgMSucJIvLTAI+lxfd6COolLMpQw?=
 =?us-ascii?Q?WsWD3v6mRd3bfWQes9dFJdzhOo/GxKAy0zvyZ+whGcaMqPs3cY8PrVW8k0Bt?=
 =?us-ascii?Q?ohIVvjFJvU7zm4X1Mzzf1h+YdoNR7xHUwtKZbLgTkLCJUDLWiVj4C4lqlez3?=
 =?us-ascii?Q?Pr8qZnYgTfofVgR44fKdbBzf1qeLjlcj32Ynqh1/EO8kvuaOmLkH9Z2EsfOC?=
 =?us-ascii?Q?4D2QmSTpCaMR9bEt9IgPBn1wSrXFShT5yR/HXdYkyFYOGxpd5YMdjVKz08jr?=
 =?us-ascii?Q?JdikOxkdf1UJfQjf2unWNB4IG7N1BtTd8r+jplvQJAXe7To1dIKho2OQc4H1?=
 =?us-ascii?Q?AbSiV20bAFuC99FqE3Yr9oEBJMlUtW4a0ydPdzq+MeVxyIzm+T9gTH8CPcAs?=
 =?us-ascii?Q?xDqhNppqUTgdrdi6vf80VDhh9Yc85NX62jenXCUQVUz0lEjdklQj7yUR24zJ?=
 =?us-ascii?Q?V359YomBrCxxUOU6Ih8ieV2lXjQhgJ9B830Zi0nTW4cuPvPv1XCqLQ8EWJUY?=
 =?us-ascii?Q?smZJIt1tSGbqaNDRKlrBHn375Bor/8TU6nE0+uSxMGohiL6JdTTTVNUepAil?=
 =?us-ascii?Q?lsLsjIZLZHpHVzVXQ/olomes/MZNbYmMuVptgIMWbpvrSVFISbxDLBo55hDg?=
 =?us-ascii?Q?tS8smKh7hjWJVnrhNcEKDAex4fVtfvYUaCh5H9or1MDcLhTqDvgd1sGiu0+y?=
 =?us-ascii?Q?5RYQv1f4r57V6bsyKOhcR478gcCZT61erQcUdgFg8bmdE8IyEUwknr5NyP86?=
 =?us-ascii?Q?oINwl8XKRc+0B6DjdIFzPNoaRgk+QoF0d6rKcez8E4NToAjgJxJqVR2neu3p?=
 =?us-ascii?Q?ZxCs94vcOjZ1xwtZdrdBP5S6qeKuOGvoM+YXrwuyzefBJQBmPvRI9M4fWpj4?=
 =?us-ascii?Q?luy4H/0f3pSy7OHnUvCXwwlHTnHseZZd5iaNy5TQl742/l8QE+Q7n4FaZe3L?=
 =?us-ascii?Q?IzWZ8e7WJc1Ykcp4ixCALZQTf6hEybyeYBwQpZffv9kzr1W7D7T/g/1qYvTw?=
 =?us-ascii?Q?fcTGaa8jsQG6p8Ty5mpmn61cJwd1bj7h+Ztc/wICDagCcECWLSB6KHYlS3Aw?=
 =?us-ascii?Q?ZATKlLwN636rMdSajiBHHlBDSukzVjK8X07iJon4sHITkFXf/2t0V3IXGycc?=
 =?us-ascii?Q?XoTvIdDGUlgF5/gtH78bT/zYXtCothe3xKfztRIJ1spwNG5XkQiAx0NCbHXv?=
 =?us-ascii?Q?W/fY1I5IgoedyUlM0GQjcguOyX1xsbclxCuGmaYL5FjhdCgm5Q+LbaYV700O?=
 =?us-ascii?Q?vrsg7h3cU3EmteZzhUYSZ33AnU8dnJFbB9GRutJ8foiVKkIt5rmO2zhpZPbO?=
 =?us-ascii?Q?G075Zh9xwkbUxshq+N5fnNEO6jCNDbLiDPJaUtdQmuZe4Kl9QibZ/PiYTwfb?=
 =?us-ascii?Q?IbYjBgj9IFEhVz3CHc1KHZOUVTOJziWfHr421rD85veC5GOXk9c2sJVZGUhi?=
 =?us-ascii?Q?MiWwQsLQbpqQ9sKrNlqOFvueoH+B3SPxOTa30gxYt8amvHDFzqCEv+J6i2M/?=
 =?us-ascii?Q?Puu41lfAOddVFnN6tJZjW9JbYpmIyu6rVEr80GSJgBYLYNU/R0gN9aL3/EHD?=
 =?us-ascii?Q?24VoRgdD1jUGPbNuwTFZ9zckl3021wNvalheyYiwfGuJI5qtnv3OosgDLDcK?=
 =?us-ascii?Q?y98pPUhEsQzw6+7madb2l1EW4bsLNwUTsegAciP2NFApUYaPu6hp+AxZWa9B?=
 =?us-ascii?Q?tV5UHA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2e974c-c050-4f1b-f5f3-08d99ec496a9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 12:22:23.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiyBoBlm33/y3nJ+KRkJzfhPjEcKUbIm7lyd+J1hehCVX8drzf1E27zPua6CfXakeY+pdVOLqig3c1NYOssmi4H96LCJAusGpLUFpwpxZgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030071
X-Proofpoint-ORIG-GUID: yYIy_Y5s1wbUMDnARvE39VDL2C4li0B5
X-Proofpoint-GUID: yYIy_Y5s1wbUMDnARvE39VDL2C4li0B5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 01:05:47PM +0530, Kushal Kothari wrote:
>  	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
>  	u8 mstatus;
>  
> -	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
> -		|| (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
> +	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
> +		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))) {
>  		return;
>  	}
>  

This is a "let it slide" moment.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Normally would keep my mouth shut but we had already discussed it a bit
and it's really important to know the rules.  In your original patch
you did this correctly, and then a reviewer made a comment about a
different set of parentheses and you modified this one as well so now
it's wrong.  The extra parens get removed in [PATCH 2/2] so, whatever,
it's fine.

The rule is that if you change a line of code you are allowed to make
small changes to fix the style to make checkpatch happy about *THAT
LINE*.  It's not required.  Try to avoid making too many unrelated
changes if it's going to make reviewing difficult.

But I don't want to see three patches fixing the style for a single line
of code.  You can take it too far in either direction.  We had a guy
who was re-writing all the error handling for a function but he would do
it in 5 to 8 patches.  It was crazy hard to review.  He introduced a lot
of bugs as well.  It would have been easier to review as one patch.

But if you change a line and your change introduces a checkpatch warning
then you *must* change the line.  So here, removing the == true, means
you *must* remove the extra parentheses.

But it's fine.  Now you know the rules and can do correctly going
forward.

regards,
dan carpenter
