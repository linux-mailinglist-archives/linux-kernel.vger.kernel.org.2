Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6C3BBC15
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhGELXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:23:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41068 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230174AbhGELXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:23:06 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165BBtvM022554;
        Mon, 5 Jul 2021 11:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=83cXuBJ5FZ85K70uoQuZ+ZhgliAVo/wS19CMvFwq330=;
 b=AN5REEEnk3jplrREplCDQEmsdKJwHekW3VT22TylshWAfem9rbpCeEbqNtPysVqz+P6W
 E+A4KH0xIwLps5oVvIeRDYox/W/APT26JB2ZJ2XWmigQ39qZO6D7Axig6MeBdHMYP9Z1
 W61BE63CkpHuVL75mc/SCmRBJqAlSUbWBj+liVWppMAoTRnETkdN2plmRgbSj34VL4lp
 ghQgEvlnk6Zv0c4wBQM7ascCK/f+PSwt5GBgiJQrF/OFK8drjnbnpwNHN0RBHCfHLvkE
 iam7i6jZtIk3gyNjjM8xCcxjbzUZuArpz70hnmnpbdLd60/srnWjC6dIWGYqvmRmQrQh nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jgesabkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 11:20:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165BARZv136483;
        Mon, 5 Jul 2021 11:20:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 39jdxf7r01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 11:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw8NGjE7oud//v1GJXEnSnxkxXEbwOR6gKEkPAofEr3n/IcEMFyGDisO8Qi1UjUaIarxpaWVqq1x+9mGhUqxz6acFAPfbkClVqjaUERQnLHxuA3s+Ba7/+29LkOaXtlY7pQ745kCWq6dkbtydkwb0Nbekmu1LJd8WW0mKLiwInAsB4vTVngZfyg2JyXti5r6eHY4hSOfAByhipkjtHBE/mZY7lyARkJo+oUifD75TFTaNQTpXR+oHQmmrKocfeizKtWcgRsDaH1pHk2rrSSTTIoNAZmeT70d/i7ZOGi/rN0GuXlLQut9pLa2DyRYEpi3Fy0UqOQfFnPo5vNbyprOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83cXuBJ5FZ85K70uoQuZ+ZhgliAVo/wS19CMvFwq330=;
 b=EH4AuwEoEQ+3/vaMCLGZ4QsK7JDCYWigPABANW72Oq0vU2K+YLMXBkALbXufRHXA9OZ12iIjRaWgu4FYbNaNgV9Uij9YtMxre9G4tgKePiSFRNU8KgsqeeOwP/nsXG9rGUpGTP+YJRtmM83mZnY+Z1XhAhsRJNYF1New5ki7/aQgelqZ+vUdFwf1xjL3Ce5KTz3nwUTZpaQNa928Eo58D8hWnLSSkaij7ZMcFejEFijBGrKNLTe5wlWB/z8jrVQq7kcGrnE3SNlmQW5t6SE+s9TVILmMxGbs9+jJJVSokQiO/Bi5ebTklLVnpaxRB5B1QGUhjOcm9p9WIxycsFVh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83cXuBJ5FZ85K70uoQuZ+ZhgliAVo/wS19CMvFwq330=;
 b=Hjrb/GeJ2FGhmYi9WS5xB+gwa+jEgE/cXXxty0sHiFHj93Cj6Q1xRLdsiRhBilY/vzY9veh2iGEblr+LOWrCwFwLENjTNNyAN7C0vrrnYJ96xuqK+63uhl9Xs5yAzcmJk4wB8EtzvrxiAlt0WBLyOq6Vw/j3qjir85d0JofHTfI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Mon, 5 Jul
 2021 11:20:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 11:20:07 +0000
Date:   Mon, 5 Jul 2021 14:19:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     kbuild@lists.01.org, nsaenz@kernel.org, lkp@intel.com,
        kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] staging: vchiq: Move vchiq char driver to its own
 file
Message-ID: <20210705111944.GH26672@kadam>
References: <3b7178086322f774772d95141764ed99d0698139.1625401927.git.ojaswin98@gmail.com>
 <202107051622.6i1l1vdL-lkp@intel.com>
 <20210705105804.GA41070@ojas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705105804.GA41070@ojas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNAP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Mon, 5 Jul 2021 11:19:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bba5257-18f0-4b4d-fbcc-08d93fa6d7f6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1774D38B1A7022A36957EB6B8E1C9@MWHPR10MB1774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dx+4ExhZkirN0W+mJtt+L/8KR5404SWnSgVyuRT37kTAzalQDqvKhXbgJHOn1xyy2pq2/YAIQyiiIPj5sumerFa8XmxnyGWhOa/MXmdGilg7E+SxOKbrrryw9Wswwl+IAbLrUhUcI3gBcOMcxb8irZrgSAHf+uUQkUyhKWO1GnsPFptJycUD1Dpe6AB16iZi3ZVyNRuK1q0xQkAxWfeEHij+xwNe8Rbdjag+PkASaTVHbtgLr2R+1LHeWnIsSBWZSCj6rOcrJzNJ8IcDfeg9bYw84iCNI5elxoXZUZYkMB7KNX7+5UVHzVETN1QAb/TfpSoMRxB9HUw/Ks/ktGA1kHVt3Pf3vEmFnYRciwbQg7Pv3mR3CoMAW67aDCfiPGgfJ0HLPi42MhU1Pwc5DYSsS/MeiXaCpjJqNoxoBGvBOHVOAT9Av4/kH3bLDmRsgswlHZudpri/Mqc29DJRQel6jEuBFL4YpUkUYkhu5DDL/TmuGhe3LdQEL8y8ULwrruQOO2oC6LxTQA7N/IDbUkTJ3GHtcOeOra1NANK5Wt+MCHd5YtmJLTcR7KzsOu9GWRRVneqrSX81AklwdF/dbMN0ojmuSbYzDzTXIHFl+YRUfhAJ1b6xjndBBh/dCKMVDuI8JYdMmCguljXX60X1qniTtFCr1fuxqlsdijnpYugqezOuJ0D93hXa88BVmrnlzOAmy1v74dRj8mS3JlFjQYPnap3KQy1lS6f935BhnVPHZkvUdGqGj0WnAuwJBgaWQtMkn9RS3QJbRpV96w4b5E3G0AgqauEKDcuPbkvHKU4ACteZG+iDOCJWxl7CPzRB4F8o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(5660300002)(186003)(8676002)(6496006)(16526019)(2906002)(33656002)(86362001)(52116002)(1076003)(6916009)(6666004)(55016002)(7416002)(9686003)(966005)(33716001)(44832011)(478600001)(316002)(83380400001)(38350700002)(38100700002)(9576002)(66946007)(956004)(26005)(8936002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lha7Pxx/N1VySgBFbOxgm2xChNZDmWuWruNTlc0F1u34XDZLcBSr4FFMR9is?=
 =?us-ascii?Q?SPE49rvvm1KpQpNVFs9eqzMezM4EQLASdIGKalUa1dbkR5BPbbE+TwQEjJxc?=
 =?us-ascii?Q?JDkak979ApNup6g4wgdLjBrreOkTkvRzSa70I7M4xCbHpF805a5BVNUpPEiZ?=
 =?us-ascii?Q?a/rcCcrIlwAIdRtoUteNQ4dMmpBqJqtnHqO29YLN6KdyPv7L+18IUnYpnQ1R?=
 =?us-ascii?Q?uLpfSDm+TQDu97WcwBt/O6h32Owiap3fhVrmoUWM57SEtsKJyGu21vSGdPDO?=
 =?us-ascii?Q?gnA1xekfNi7vtqQxIwcBvrg+PB0B3aUmGRoLdQGqweBh5LYWNIg6v1NO4MZp?=
 =?us-ascii?Q?AFYk81W1kd4Rov8AscwYsHn2qOQouNa+DrlF7hC/wu9y50KRNekRTD5gB6WJ?=
 =?us-ascii?Q?fM18RbzXOB6KryLQDWp3amae9+utrc9L2a3KhL+NuswRPc6vmiQRP2+yp9yN?=
 =?us-ascii?Q?VzmuzzUGVLf66dYM8MU3YVlogNAznUrH/k+R7fQRZwhy7z3U0cc8cap+tZga?=
 =?us-ascii?Q?nsxj/T5EzvOYK7WZClfVkHtl70ER/5PIeQYTCVl7wg7q8d06h5o3KOvFTdfr?=
 =?us-ascii?Q?xYe/ijNSZo9dkoBfFbYcFKT5oI6UYc5Y7BTyxXgtkTkF3/IJx7+Eg6Nk3ENA?=
 =?us-ascii?Q?oaDzEnS3C4POOk+F9iRLbiyVRSfKVFiObe7Ezr8bjAKfj9CIK/40eaAESAo5?=
 =?us-ascii?Q?sq8GCa7aqh2EToRQ5hWIs/odoVJEKU5BUn/M7v6AVp4ZnmVtIhE/xPQXeWpL?=
 =?us-ascii?Q?Spg5G/lcptjR47oJVJmkjyrhFKvnCOe/RNRzP0565Li9xdBx/wIEMWXUB7Ze?=
 =?us-ascii?Q?u9N+dDcrZY27pdzFk3RuTY4H71zcMjnpbfCC0h4x1COyUrQyPuc08IFCqgbt?=
 =?us-ascii?Q?Hklp85m7nt1wkTptzKEjdRpOmtcR6YAZhOMvBOgDOgB21v29XkHA5we4OSdV?=
 =?us-ascii?Q?bhyQAD/vV33JRkrv88lkxta6gD8qRMvJmXkNkMYvC7ATa6I0XbsBydy35Atx?=
 =?us-ascii?Q?GD9BQ/3qjJtb1qe1PuYtpMm6DZgWed8+fMEY2Fb54Y+dkVSCoTCbsORwcYdi?=
 =?us-ascii?Q?PqRwdue5hoajdykVgnk5+7dJiBdWuiGr27OTHl+70u19lV5KFtqAJAIqgiFz?=
 =?us-ascii?Q?UNCYy4m1F3fboq/FVMlJGY9Gr8s/mYUj7cr4875YAlKnxckBDm1Fkl7/wwZC?=
 =?us-ascii?Q?v28HX3+qlEvLj4iKbnp1Q2KXGciscDDBmqPjXlQlvaEb3kdLnQXnrZnP++cW?=
 =?us-ascii?Q?y2bRbVD37yS+JEbs1RhvKF4Z40/IAdJB8lg1uLDpoCMVZpR2rn7TB1zI8Xgp?=
 =?us-ascii?Q?W4UR7BDIaVoEBDi/+wbyDqH+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bba5257-18f0-4b4d-fbcc-08d93fa6d7f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 11:20:07.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XXHg/c3S2iYq53z+SDSZhJEiPFdwZVW7wabsgSs2sZz6w0UCsz8umRFOjzoFay3F9FsfIKeoi2aTAnV/bI1+N5iXWMZVltwvCFLRgCrD1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1774
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050060
X-Proofpoint-ORIG-GUID: y5R1J4OFIEtn4XhKZjkhOVri2JFOZMZo
X-Proofpoint-GUID: y5R1J4OFIEtn4XhKZjkhOVri2JFOZMZo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 04:28:04PM +0530, Ojaswin Mujoo wrote:
> Hello Dan,
> 
> On Mon, Jul 05, 2021 at 12:56:09PM +0300, Dan Carpenter wrote:
> > Hi Ojaswin,
> > 
> > url:    https://github.com/0day-ci/linux/commits/Ojaswin-Mujoo/vchiq-Patch-to-separate-platform-and-cdev-code/20210705-000124 
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git  77ad1f0e99bd00af024e650b862cfda3137af660
> > config: i386-randconfig-m021-20210705 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c:1235 vchiq_release() warn: argument 3 to %lx specifier is cast from pointer
> > 
> > vim +1235 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> > 
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1227  static int vchiq_release(struct inode *inode, struct file *file)
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1228  {
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1229  	struct vchiq_instance *instance = file->private_data;
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1230  	struct vchiq_state *state = vchiq_get_state();
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1231  	struct vchiq_service *service;
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1232  	int ret = 0;
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1233  	int i;
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1234  
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04 @1235  	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
> > 62b5eb4fdf3f5f Ojaswin Mujoo 2021-07-04  1236  		       (unsigned long)instance);
> > 
> > This should eventually be converted to %p so it doesn't defeat KASLR.
> > (Not that we really care on raspberry pi, I think?)
> Yes, that does seem right, however, this patchset only moves the code from
> vchiq_arm.c to vchiq_dev.c and I've not really touched any of the
> existing code itself (Except moving it to a new file which is why it shows up
> in the patch). 
> 
> Hence, I'm not sure if this fix is in scope of this patchset. (I also
> have a similar warning by kernel test robot here [1] which and I'm not
> sure if I need to act upon). Maybe we can look at this in a separate
> patch?

Yes.  Correct.  Don't mix this into the patch, do it "eventually".  Or
you don't have to do it at all since it wasn't something you introduced.
Someone will check the driver for Smatch warnings before it can be moved
out of staging.

(I just forwarded the kbuild bot messages for informational purposes
only).

regards,
dan carpenter

