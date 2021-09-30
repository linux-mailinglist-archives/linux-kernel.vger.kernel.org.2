Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5241D64D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbhI3J1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:27:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53870 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349315AbhI3J1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:27:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U9H7Dr021996;
        Thu, 30 Sep 2021 09:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=A9Je44EtIz5kLnXT7XoWfmRxfgYtopJLiakH0Rwm1YU=;
 b=s9nhPSozDAX76XiiNT9Kxpyx1AJ1GCwAWbOniHsmnOiCR1SOMilKl5wJON8gGou10SFY
 6fz2dwtLwwNQGVMMeLadbEzdVgMPnAbJpk2tnkgGGY8qmk1cBcju+jiluv//YHIYIuez
 Ts+WUCXcoGQqf+snNGOnf/SeGyhEDzWL0OdhhvG/IXUecsig5i6ATxIIpanZnTPFXfsz
 W0E9dMoj61w0ky6MbQn5HflBCI/p4dDl614HkBi5DAptfsyj+whn+9kDsOTp02rhn33w
 5iOOnNvRhotjt9s/OhAU8/OAHUCliuQAlOpF7wYJDwQLDVM+BXZhklzkZaBeDvP0s9Jq xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3husrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 09:26:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18U9Fkjv148375;
        Thu, 30 Sep 2021 09:26:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by aserp3020.oracle.com with ESMTP id 3bceu6rnwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 09:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUXdOg0rCxm7diuOaLRzYiYkfg7C2uSMEyB5xYoeT54Hp4HCdyi8MWMP8QGpBMbryqtU6deSe9ThIe/YxOPbbLceeIKQCvtGkTB0rmod/+M0WRKlQs02wrR5M6iZFAVFgAg6SzYh13QpVfF7g53FpuXwWgHszvcgNuL7AA5ECKOzdmKLXAn4VyeXSizlvN1+DGSlbSS+7BYKifbk7NJooMjGyQY6q/wkgMgxRkHQeeY9LDJj05/xZcDAWrUO1eOushCdQTBxU0MFmdglWewMj+lCt3HLgH5hvhMbPUglDdRt/BvjVFFTLHireg1PDA9weSMDi4cCXOYmav1ggQsSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A9Je44EtIz5kLnXT7XoWfmRxfgYtopJLiakH0Rwm1YU=;
 b=H4u+5WZD7Z7oTNlepUb5Y/8Pc4IOuzuijMEqXUOhJKwVvoueSdI6y8C5FoEXbH7kDSM4MCVmpzRfNzqCEfeIp9kYTBc96VzUCRRr4/GlVTcYKY4FKZvLGtgz6cQ0PL5Rd6aWlH2AjnCMKfDjaMDrcNWHPLDVZovpj2MO7CznMaeLdrLBkFupWPqYBOgkCFjKCrJEqmZJAfyiBvvs+uliP16IN9E8kGWeuyg2iki/POrnAGu0B99M1e5naQ0mvp8Dksba82TihROBnDKQhmGuwRfTWVAhgQGRWvcEeVbjkjLAqskiU+AnTTucSjeIRQWTA94P7XSL8423LKuoWVNKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9Je44EtIz5kLnXT7XoWfmRxfgYtopJLiakH0Rwm1YU=;
 b=oz+lTBubkmnFhO6ePKvHGfFsV+mIhiQ2vcGr1lEEw1DNuJQNAvHL2mdN9JnF8DUmIFXejr2sMfA8f/Zp0fZ9D99XSYQ/4nWq8dR0ZvHTgfTcRHzbG/UwMjG/qM8lGk/oXJCBhYayesCkEKfEK39FABREqDEiTcM9D3dO4a71mcw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1248.namprd10.prod.outlook.com
 (2603:10b6:301:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 09:26:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 09:25:59 +0000
Date:   Thu, 30 Sep 2021 12:25:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dawid Esterhuizen <desterhuizen@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Statements should start on a tabstop
Message-ID: <20210930092435.GN2048@kadam>
References: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0055.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db3bcfb-d8c1-4343-32f1-08d983f45058
X-MS-TrafficTypeDiagnostic: MWHPR10MB1248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1248995C4E8E56441AF628948EAA9@MWHPR10MB1248.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrHKEqmtQjjArvlIXm86r5+DPyAUaAX+ZpZGbBpEauMAd4OSKjKswl9YgSwDRc3mKi1vA1NwqkSdnvDBVnz8ZCkPGr+1Bk1sh5i0KJC+IIzsQoFd3ZILBVObJ0u+IbnWwnrDcMMQORj3D4Joo5nYMYDrjxj6kHNqZwdnEBF93Lh6mGwmgZLAQsNLPr6E65LgmoYkFkr+MOKx5crX+Yp2oEqyjg+VzJrTLEkBYh33EmO9xjMN1i2nw3AyjrHj8T1S73/lFJ8x1Pa4VFq3ius2riV9NmQoXp0TCswNYLca/YmX8TyrKoN7gHCE/P34HLtZbaQNHkcnWiOaA8kv/FAB0JO0Cr5+hGWJJwRuQnV2gpMsgFMXsbRoVqyrYctNiRyf89Ud+tR8/GyXvRc/KJl/s60rwc210j2AqpbfPeKbwVlBcgkQkRMlTCMauYM0en321+R/e5tvCXqbIP1b+0n4JVSL5ltAY4uug+SfdIoOMaJwfxYWRDCFgNSYa6/dGNxlcF5y08MkHvJqZfc7kA5qxr8FkMIpFW6H9p/O9H+dgLrEZdjq/PEokJmqDF/dYgGIxq8AdOo2Po2Y9iOUO6gbsMVq5b9aRHbJTTgzQBnd46cWnsBxj9y0v0X+lHFVogi0X/mXIfhcjMRK7ETXk4oN1AeNkoKpzpOusz7RoVHogvkmMCagHpSW39qbl8Ihhw+MwMspNhSPCM7rkeV4fKldxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(508600001)(186003)(9686003)(55016002)(26005)(9576002)(33656002)(1076003)(5660300002)(316002)(54906003)(956004)(44832011)(2906002)(4326008)(6666004)(33716001)(6496006)(86362001)(8676002)(52116002)(66476007)(66556008)(66946007)(83380400001)(38350700002)(38100700002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTWJmzFp8tbwl70wXbLKnnOoyil3yWLSKO9bCeJcLjbKBZuCyk+suVWahO0d?=
 =?us-ascii?Q?EkvdXeWJKu9djtnh92jHKh5CdQ+yvZnWS+llraFzAEDirB0YtzZfK35zIxOo?=
 =?us-ascii?Q?3SLyXtL9/5HJZd/Q8UFPxa0E9+5dyLxZ8ZndRzpWZDCUEtKjKnVgNYx/Nhtn?=
 =?us-ascii?Q?ANCchX7Zh9O2PSkLLlpNG1xK4qo48GZKrEgrcf776ki2TvT12boMybbKjVTw?=
 =?us-ascii?Q?6dOxNoPXDS2Ntxr3PmwPBbHkQo4EhMAPspW5JiiWD8PXeibp5QgbIF/juxtH?=
 =?us-ascii?Q?QyQqmXmwE6yVaqUNHq22zNplsUplPyOoyD4XmU8Nksqk+AUorbY9Bv0mxwhL?=
 =?us-ascii?Q?Y1Nq4+TNuzqS54Omh1S57UiowHA92LTHDeu6AoqLoy0b+cKQmz0oISj0hQlk?=
 =?us-ascii?Q?XTLv85pSoPqc+cRomdn3p4pwDPXXK9f7aF3dDCIdjQjTkYsHvIWH7R8H/aYy?=
 =?us-ascii?Q?maSpkEiu1wEjLs13QzxlywapeOtlfdh+WdR0qykE70OrKh5grAnyDmmXmzp8?=
 =?us-ascii?Q?42td/lJGgwlbHir5mwxLJJMUTHOvWWkbVRgXkAzMwUcatvtdVpJiwdZZ1cHI?=
 =?us-ascii?Q?CmbjAaHP+ZWL0Av79MyCO6g8zdDQZnNXMBe6vZIKIX2OYFOxsbvR0Ey1cJSJ?=
 =?us-ascii?Q?0aRhCZ3AkofDhoz8+zkGEzXhyoKQiXgE4bf8iAKYLJL+rVkfhm/1iWxpnIat?=
 =?us-ascii?Q?eKBMeyDJ5RL2DK3f1ndmMIZa/6a/eZ4wDsZFJMXDUShDPyRyZ5Oa+TAFKxPb?=
 =?us-ascii?Q?9ueXSnOZHVGn7S8nVjWnn5xRDHZL+g9W28eBAe/QiUX2Wd5a2gVRutVjqCRT?=
 =?us-ascii?Q?zh1lyiIx6SyBonbyJFQfjnqSa50EnQYEA8HLj8StKaC70QLtLFWWb142ejQM?=
 =?us-ascii?Q?Qre9OasvipPjrAcc+6+3u9YaYKxkzDi1t9PjgdtPAYbXrCEoeGda/q34JB9M?=
 =?us-ascii?Q?UUpf8XAWoK5J3CPyBzO0r3oeKlGtuXg8KQVXgnHG0eCIsk4Zx6LhUPSo28jS?=
 =?us-ascii?Q?SR7Uy2Uw57+uIwkpYt1hJEw3AGO/Yvtbd488ZttfJ9S7hKUj+S8AjOuCp4QB?=
 =?us-ascii?Q?lTkl3jOtX31aZR4X+mdUz71EyLJaD1ivtuDZRT0opgl/0MSYUKTNqoXrDQbp?=
 =?us-ascii?Q?idhSLsEcF2WtfEigwupbH+8hDyViNvvU77hffbF0R1R0RzBe2jyXqRuUDWQD?=
 =?us-ascii?Q?KQVVoXSyfIWCeh1YO66nXRtCxCKJUx/Z1UHgaiq8yrPXPs7unS1K5yHmqXs9?=
 =?us-ascii?Q?5NcwrXETZX7QlWmXib+OLrcWutb3YfDPErGniNkK2D128tk+Nm9UJiqodYCG?=
 =?us-ascii?Q?B3JjmQQT45LEhShheHWoa9uB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db3bcfb-d8c1-4343-32f1-08d983f45058
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:25:59.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a20J3TomBLTRVmDY9B1WdsfbkTfPziZWHmsI/E+2QRe1k/2npPVdhu+9SAng5L679TKigJNYCRvnmE1rj9EwL6vOe2P6bzXXRG5nBV0dz8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1248
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300057
X-Proofpoint-GUID: ViFAe8r3OMNCExhjCH-ADKF0mRfVNs_y
X-Proofpoint-ORIG-GUID: ViFAe8r3OMNCExhjCH-ADKF0mRfVNs_y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:34:46PM +0200, Dawid Esterhuizen wrote:
> This path fixes four checkpatch.pl warnings:
> 
> Statements should start on a tabstop
> 
> Signed-off-by: Dawid Esterhuizen <desterhuizen@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_xmit.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
> index 2e6afc7bb0a1..bc1287cc853e 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.h
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.h
> @@ -182,11 +182,11 @@ struct sta_xmit_priv {
>  };
>  
>  struct	hw_txqueue {
> -	/*volatile*/ sint	head;
> -	/*volatile*/ sint	tail;
> -	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
> -	/*volatile*/ sint      free_cmdsz;
> -	/*volatile*/ sint	 txsz[8];
> +  /*volatile*/ sint head;
> +  /*volatile*/ sint tail;
> +  /*volatile*/ sint free_sz;	/*in units of 64 bytes*/
> +  /*volatile*/ sint free_cmdsz;
> +  /*volatile*/ sint txsz[8];

These "volatile" comments are wrong and pointless.  Just delete them
instead.

regards,
dan carpenter

