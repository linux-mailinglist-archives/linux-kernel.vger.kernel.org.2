Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC82420DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhJDNTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:19:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62044 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236375AbhJDNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:18:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194CuEBc026334;
        Mon, 4 Oct 2021 13:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=x1BgUMG5lyfouJlC53kjtQp3EyZcmXSoxoE0KxVufqM=;
 b=Y/7u/Fc2BfSlC30AI8pdcppZSbxpMX2GMp0CaqWW4XAUIBd+M3eI0uZzoJpRCFCVoLR3
 Yc3Es3WtvDfks2vfBEYnbF50xFJoc4F0bSzzXqXjcECMuBflMjLBA+WsFV+qSTyKAvMu
 f3fDa5yrbgJmUuuLHoS5MwobmuMHbspXeCvLlz+EylVzBTBP+s23Ortw5E8azILu7Q5e
 hTqk2u58PLD+ZOfViozqK5ek0Br2gZ7JGqXsFBY3u+zPtpvKIgxUq738wUvb7Z7qv+wx
 P7YPDKcXyiGTBei9UTJDX7KD66Jy/ITy+E9ct5oydVx3oyFV6fP8qhyx2GG2w2xgD5u/ ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bfbb13x1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 13:16:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194DFt4d062230;
        Mon, 4 Oct 2021 13:15:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3bev7rn8g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 13:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsg6GhvZz2siIddnv7Yq7gBH8BQtiUvq0Su1m4pNeMa1DNau9VVzSByapEUGaSJLtpml+G+H93mLtrHc/MKbMAadcjuN/Xx1nIofZQis1bkOY18xOarxyNrZUPSI08vVc6A+OQ0bgpzM5bKYWEnQRax1XTFZfgNbP1r0UREs46rtsIEfN6qDTxc9viAmnTjNBvyn2t3uIA6jnatTEFTd0Nb8a/TshXwwwWMuQGQw81OHRGlyD5kV7hATZG/C2xTts7eEHY6mdIbjE1NAJuH1N5FChPZ5YamCw1xbb6RG74u+mczeGKw3Gmphu1lA23XWYIsPxMKvPQpG0WW/wVqJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1BgUMG5lyfouJlC53kjtQp3EyZcmXSoxoE0KxVufqM=;
 b=YcQUwtDyeQBalL306DmqWsoV0mdDFYdjRNiPDwpno7fhg1lBDAvn9riLX8Nc5zucj9mdhivrSr3tM3tM9FzdyPj87lPQ2FsR1kldf9RMQyjJ8TyLxzzAkrNdBSqWE/qj1ePLVKDNX4eEpyXFbF1VXG3XoGV0nOo1zYd9PUQHqTapvEujVYvENINp/fScdzEzCTE8mFt/mVIr+l4sqyyt1mYTDQ5A0iQHr1E2SZHtuJOq+lMf5uN2sbjudoGYy3eDsMgGPQRfvURfF+Lacj3TjYnzb0mT5VvbIbQU7Y8quPSOB/MAvSqzSuKkFawReQal1jkoLi6iRCXwFB0mtQjVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1BgUMG5lyfouJlC53kjtQp3EyZcmXSoxoE0KxVufqM=;
 b=PfhEBfZDrlJC1LXwWiQFvOFsktISku+V+7Sit56uooD6ve0spEcyJ4oPTQow37BOSVHQR8gpmNtEmKpzz9FvyTeEOIWUhNhcZ9VzexHe8Ub7REJ//TPc4ZAaTXnUWV4pxeesXD7JVkiTGi7L6YfWoybjLzieLhWtSlaOe4JncGM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4434.namprd10.prod.outlook.com
 (2603:10b6:303:9a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 13:15:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 13:15:44 +0000
Date:   Mon, 4 Oct 2021 16:15:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20211004131525.GU2048@kadam>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
 <YVHilhCk3cgGhXrZ@kroah.com>
 <20210927213515.GA6953@tom-desktop>
 <YVKdVCaVwmPG7DVx@kroah.com>
 <20210930214929.GB45822@tom-desktop>
 <20211004102632.GT2048@kadam>
 <20211004125806.GA140797@tom-ThinkBook-14-G2-ARE>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004125806.GA140797@tom-ThinkBook-14-G2-ARE>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 13:15:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006b023c-6537-45fd-f7c0-08d98739125a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44342846888724DA2951625D8EAE9@CO1PR10MB4434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKTfAE+4U9LK+ooE1YE0ocaJ2Yl+8VkmICszNIuTyeYSqOdlp9GQ3ExU1cjXEY6PR/40CZ0+6CUWOYKQVYVLeoVEHJdBVS/cvPYcR0aaLA8a6w2OCNuVhiugMGSDcfAKDRumKVT627HUQNu4/mHh4KSPpMvP1f9UxWUzwCJNVzWvBtQnafqJJmd8a8YsdE8E6GiHwcbWttNceV9D9LVwKsXCRKeX9g9WordiaXG5nkvN9HbskdPK3kdFxQ/zMv3XDmhhy4ROf5cNlz3R6shOepa+Tv2NQe65A1EX3/kuItt5xAL/6eNK4xwTtRSvR9c6/O5I6iA3vAOIXf9EJDcSu3zpP0n+QaP0ldFXlqbrPwAe4LBYr4l84IRQ7kcprrrjEJ6AhJWAHdFDlMX9vC26wLRidBkChNrXeeVtObXnZO7lmz4XdsQZirsWl2YScsq937viH7NwllkvKgCWtjSpwJ/gujKLcBDOr48yBWFxGSUNwkLg5r+ifoS01HAhv22QVfBGA/SCYlsP4ZgdUTlMzvKVRcJRXTueUk7szOw6V8XG5MnASSq3BnS/pFXkzgvRWIE9qvk8hpBJou0fmorKubmt9jrA+dQGlJ+rDcInyph4Vxp2m9AowVmX2m95jGzxmvGTHHUF60VBFOTgS7KtpTJW6KseQVFfqgGt1y3p4rI2CwfKzxANRvTpw9X1yDPjWfw6Ku5tSHcFL15prNpC4xllw1MeqnpESopxuH5+uEyiTqIo5QAbi2gCJ8w65AJbNjP2owHP2i31jWITt8zO2ZLb/ZVHbUDuaYysy65sX4Chxr2+TrALbCdIQ+YGlLietaPZ8wX0qJYNyziD2vGL1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(55016002)(83380400001)(2906002)(508600001)(33716001)(52116002)(6666004)(6496006)(9686003)(38350700002)(38100700002)(8936002)(4326008)(54906003)(966005)(9576002)(6916009)(186003)(86362001)(7416002)(26005)(44832011)(956004)(8676002)(66556008)(66476007)(33656002)(66946007)(316002)(1076003)(145543001)(145603002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXXVY0Rnc+AupoRDdW4PYfGXqpCAJFGGjAwp8wRf6YLBipf8nw3ad9O/9pTT?=
 =?us-ascii?Q?myAeVvAfhWYRjHqWgwjjEcdhdud/UbCUPrbxWKKlsMq7xg4dQKdjLEfEGFhW?=
 =?us-ascii?Q?30NYEjjDiWAiBQGDqLr0/SfhBDRL726RyTpjoxaw+NLvkMiZivP71LVLS1WD?=
 =?us-ascii?Q?UyTRjMY+ev6LSj0ZrPT91kmCX91ItMzRBCHur80BPbji6/rgDcbsRqs5nCcL?=
 =?us-ascii?Q?CchLJUU+DgQ3XXQIEVmrEbCA89NsUIwSPLCB2mGHoNFGJOk/a7GsSbssAL9C?=
 =?us-ascii?Q?Egj/sJ7nUGnbNUpxv9W2vbdh+oinP3iqzyfmttL4xe5CFhm3070iNndmYx9R?=
 =?us-ascii?Q?s1ktDuhBE/PqlobfF4FXDCVst/XJQ0dI1triWGc6DDbXF7JzacBCIRITpXBL?=
 =?us-ascii?Q?WgslPlHkWLTMx+ACrwvXiYjg/9JZ/m3awA1jdDDxWjx435AaFa1+MaEbUYgs?=
 =?us-ascii?Q?Yon+Cz/qZz7NnRZZxfTltWYGt4s2XaljrinESq4AnpfFF+sqcagPIMhu9OC1?=
 =?us-ascii?Q?k/bGYRdKT5IWCBP6EjQsrVoU2mM3P6UZeVdL0SWBPqMJxQ/5OgUKLhgeX8f1?=
 =?us-ascii?Q?q8Ol8iMuQkjPxsEizekQy2onGkyy5z8EBvt2oq1a4MX/L1IEnFOxmdPwix6U?=
 =?us-ascii?Q?4+SmuX5RSLuD2FTDwSLP71oc75fnQR2PYuppMH3hZ1hT7hiJdzln+rwkTC/w?=
 =?us-ascii?Q?/xsRhfU9CqkeKzPs2oIhpJ9WiUo5h+HnRfWtvGF+JSMWa0ip+BYnzJf2IOti?=
 =?us-ascii?Q?ktXQn+y3ozAmOtZ5Bcfy1nRz0kbZ6U+ymb3/NVtRRR61uoutPqmSOk7NY3dk?=
 =?us-ascii?Q?1OCe5RcknWP+mWb+sBJo/8fUEMuZwrHc3TTJWe7VCsro2LWmNwr4y2ex4G/R?=
 =?us-ascii?Q?TOx8qPiXAbJ1bd6qwP75eC9fX1ldwnY7/FeQVe+xyWELECLOAeuM7J0ShIjp?=
 =?us-ascii?Q?5yJsI3L2gGkYMYiExzkDKNscArfV7BbEEiGUTjMiIKr/gRM0Ylcob7ZU/53M?=
 =?us-ascii?Q?HvK81QuAfY7bMteqx2sgj6uJDKdAtGO9LkUAxP7gyqtJDRMJm3gZjCRLUMTL?=
 =?us-ascii?Q?XBLjPP9FQgP0OdrM/Ia9KvFczdg6JAHXjyvNtob2FUGYNbUTEVwHIVrymYWJ?=
 =?us-ascii?Q?lp5utoscpEnwzKG5Juhr6Sf2WCTpWPP6/rMJkXFeO8voTkpPU8Dph/uiZFpA?=
 =?us-ascii?Q?PCgohERw1uhutcO+6vYlPQ9SAnT2AW8SZFuPWcGzvniWngOQvPEi/N0Cnmxi?=
 =?us-ascii?Q?W/F/URa487YQ2W/EIQTpUzjD7rXrgQiuvslGU4jnxUWjZTsfsLlkpSHe2uTr?=
 =?us-ascii?Q?xpdFNaRGps7qU8NWc/iWd1iz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006b023c-6537-45fd-f7c0-08d98739125a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 13:15:44.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Csh40ZR/HD23pwYugCN5csDIvxfHortKGlRzWBvcwBK4vzD3sKXkTpUbB7jC2CrxbzArW6oXpE03sNd4raCD8HZjuFaGQke+FHzQ0c8VYOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040092
X-Proofpoint-GUID: VzR-db7EBNsrAtlUf52D2wbPEnkoxFdr
X-Proofpoint-ORIG-GUID: VzR-db7EBNsrAtlUf52D2wbPEnkoxFdr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:58:06PM +0200, Tommaso Merciai wrote:
> On Mon, Oct 04, 2021 at 01:26:32PM +0300, Dan Carpenter wrote:
> > On Thu, Sep 30, 2021 at 11:49:29PM +0200, Tommaso Merciai wrote:
> > > On Tue, Sep 28, 2021 at 06:43:00AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Sep 27, 2021 at 11:35:15PM +0200, Tommaso Merciai wrote:
> > > > > On Mon, Sep 27, 2021 at 05:26:14PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> > > > > > > Replace camel case variable bShortSlotTime with snake case
> > > > > > > variable b_short_slot_time.
> > > > > > 
> > > > > > That is a very odd variable name.  Why did you pick that one?
> > > > > > 
> > > > > > What deos it mean?
> > > > > > 
> > > > > > You do understand where the original naming format came from here, and
> > > > > > what it was trying to represent, right?  If not, please go read up on
> > > > > > it:
> > > > > > 	https://en.wikipedia.org/wiki/Hungarian_notation
> > > > > > 
> > > > > > That style is not used in Linux, and so, when converting from it, do not
> > > > > > attempt to keep the same style present here, that is kind of pointless,
> > > > > > don't you agree?
> > > > > 
> > > > >   You are definitely right. What do you think about "short_slot_time"?
> > > > 
> > > > "time" implies that this will hold a value of time, right?
> > > > 
> > > > What exactly does this variable do?  That might help in naming it
> > > > better.
> > > 
> > >   Is a boolean variable, if true short slot time mode is enabled, false 
> > >   not right?
> > >   A good solution could be: "short_slot_mode"? What do you think about?
> > 
> > No.  That's a confusing name.  What is a short slot mode anyway?
> > 
> > regards,
> > dan carpenter
> 
>   Hi Dan,
>   My bad sorry, "short_slot_time_en".

Ah, never mind.  It means something for the protocol.  I thought it was
driver specific.  Just use short_slot_mode like you original suggested.
The "_en" doesn't add anything.

In the commit message you out include the information from here so that
reviewers who don't know the wifi spec will understand the meaning.

regards,
dan carpenter

