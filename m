Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8EB3FD7AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhIAK2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:28:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48496 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235868AbhIAK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:28:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1819iUAa026381;
        Wed, 1 Sep 2021 10:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sTyPZbk8/cnJrRCNghBeNAeeKgn7B9DVcAzyk/Yl3TE=;
 b=HUCsK6QI5NvdMnnwGE9pKgZ05ERKQqEhgWvPqD9dpZPZ9Pyqg/omiuBuJ4NPrPuGIp8V
 ybSqIOsVWXwXmMjRNO6oKDoJwOndLpv69FpMw4lSIE2DBs4n57B3uv41Q6fKZKTgJ9Zk
 VeMEOZNx3OMCg/8rW1rKkISDGM+qwZJu3MpSRw8p59uZzkHqM8Cdrk2k/50K5Jl7mtwx
 Mw1cGjPne+zsG9OQ3NlaDFVFWV/yFdo2DRilnH0sS0RlR1ZqYyPrIs363FjKyGdaTrhJ
 68/to+2stusnTp4uJ3pGyE8/nbNKWslrHU7DXHIyeq4RWAaj/jcHRd2+ypwLZNoAuWoz lA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=sTyPZbk8/cnJrRCNghBeNAeeKgn7B9DVcAzyk/Yl3TE=;
 b=GG6D7NXsdCyRI3QRTZqn4kFlotNth8S5aHTFNaHvwpVYt3LvD70x10UIkNJuiXzoQBDd
 wTG4hvx9eySr263zeihfFzEIYafjdQojA7XmNXfVkzQHIE/QQqdnVR4cUQLCELbV1Q8A
 dUBv8bL8OXTgIuQkUWL4uKapscFyxIYVuzD0ky5jZvir8BN59dJnaOzg0TFzbDt8kg9A
 6YprJ/8QbZWETTU6+0zFS6bfvJ0+r9yHclVYSPZfJVZ5ptLUJeS4E47zSZyMTK9CXjal
 50QVG/ofprHS6zEyNcsYfYT8ppq6kDkGCrWmTztxaEbzPYujAoJiWH2qgs0BUOB+ErP1 Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf66m487-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 10:27:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181AFeIl178933;
        Wed, 1 Sep 2021 10:27:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3aqcy6dnga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 10:27:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/tntI1MC1yqBUJskMGTwbn+cJljjhDodM+DpYR02i9EUbIVaNL+l1nCwPKwEyjpM2rB4VznxmE3+oa2Z+cr3xNbkKdoH9S+D+xwcrcGWuRW3FXzoSj4u1K6S3vmD1OEjX4WQaHFLTG05pdmuFgPpcb9ZFQ1lFP8fWmA6wiGB6Gw3FZVzAauFdWEvlgGTmWUYUDY61laXN5ScMCWfaJtyUcbIiE0PNN4fLYioA5OiDGuPVz0VYMk+20x2RLpHRX5SEnjyxN/HLWyVpq8rC5t3emGaiRdQ7BHqpnNZZMDyyfCi6uzRVy9m83DE284IZRRsweKhAbwW/G/73xsopYEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTyPZbk8/cnJrRCNghBeNAeeKgn7B9DVcAzyk/Yl3TE=;
 b=YxCMhDWgK3V05JdCI7V5oITVmGCcZuByvBKoAxNHsh5t4AtE2acHTL6XV4h4OZVknVoE3CVO5Mm0MTQrxkyfFWC67XCUb6EeE0SRzPZDy9mQshc6RuNlNAhRoMNSVkJTg1xwEDuUIxCh+AUlb4N35HB4KjyzCx45oIljNKvKgJv7/Agj3aDUMDqt7gv9JUd7JJVBvIHgIjCdIEM+DDnBe1rQFiSwGMjdP1hnS6vN6FIVmHDHfs8VFDbNuEQ4nMITzGaZGMvAfV9EqWlWFW5jhH2HKH7bJGxAXjohMzOAGBNU6umB8d6oKEGWR3drT3zr/vm2JdZs1Joir2UYOTPnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTyPZbk8/cnJrRCNghBeNAeeKgn7B9DVcAzyk/Yl3TE=;
 b=Q/lwpsOaeEeHjhk4rXXy0QoCUs7Nt2dsUPZQJJGnBNk9fBqffX1we3TA1S1FUyiFH0sZp1xnIgWT+NpoJDcZ94otxdOMkRmTsjQNTO1nGpzT/mupRFCiHdotyUCSf5iKwSRkxIhrTOFY5faH724DP04dMbhcDFLtcnrNMzeHn0w=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4643.namprd10.prod.outlook.com
 (2603:10b6:303:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 10:27:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 10:27:32 +0000
Date:   Wed, 1 Sep 2021 13:27:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jiri Olsa <jolsa@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:ftrace/direct 5/8] kernel/trace/ftrace.c:5150
 register_ftrace_direct() error: uninitialized symbol 'entry'.
Message-ID: <202109010541.2HLm1TVa-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend Transport; Wed, 1 Sep 2021 10:27:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aab6722-9057-4de9-ca0f-08d96d331b38
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4643EE1365B023CB9369D12A8ECD9@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnyWOhsxOGxyMx1Ei8mROXcwM96BxiI0BLtMjdIEt42Qu7eLxZ+3MlhXQ2YzvmIBvVPVT1DtPX6yz9uznbHgXVnM1RmK4WAa1XYGXpGlpsNeAJfrb1xeoabOxPkuRkt/vrTTzGKFtUtV5iO6ple0JfmocOoack4/86AkBANom+R7KYfebJGOLME6cHUDBNTdBo7HMa+VEvHAS1ESb9erw3c/eoL5/j82AiAZyMEpYZjAJIqvpifvDlMPCzko8E+Iv+6UepvRluThcRFBq5FH75Yp4q9XTyr37JYtmYP0vp3N0QZghVVIFrV4JaU0BjPkRJRBYMdGWnzJRHYMyNcynDxWrjlLOsZ8pRYSiAly3ucdS7qLcXRxvb0kxCTykXrpMFTSeOWBHWn1+92RSGROteBLiJELtq8+LuQxmd9wnf6HjK5rUjpJjq86TSarLwe5l7gIxlajbUHHMjlDkVdoWcFk41MnnOEMiRNOMEovckDrchHWIJUw+UAC2N0AE+atKtSZOYVCJZ64mOyR67BHjrbPmk3S//IfWkJH8u8gAT1ERWU4NoDH8tTshhNxSrchv2AcODSjSMPQp+IWKqugLylJDyDmgS4QTCX+h5183rVM9iltv1RdNRy1F4oem5RZOMskiZIJuk0c5SwMrqrAkjpQKo2jJZgn6NjlYzBq8HC8kMLkymxSjrY6dD+4qCHSnEDihgK/UIVQU2VjYcONOUGcU/LnDlwGDpj6vfb+hnXFCZ73M7gCem/Mw2iFouMax5ySeBasQF9L7jr91RsXSBViopfzlMaVobIFKZ/lgkIYiMqR5gIkPHdwhf6XVGyfPRFZdBrvGiO7gNbFY2M/pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(346002)(396003)(966005)(52116002)(66556008)(38350700002)(66476007)(9686003)(66946007)(6496006)(2906002)(8936002)(186003)(83380400001)(5660300002)(26005)(6486002)(956004)(86362001)(1076003)(8676002)(36756003)(4001150100001)(6916009)(44832011)(478600001)(316002)(4326008)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kNQWOVQQ62FPmtTfbr3TPjaEI9N57hmbtCaagD1nyo9fPnBdKI1cHMPYYHuF?=
 =?us-ascii?Q?bevk+0ka8m0a56H8s0EfAmIzj5J12WogDu6NxhfGTDgCxB/IrckiZeQnDih+?=
 =?us-ascii?Q?Cxg5l3z3v2zZItoFos6+jgKq9hjYaH7Xt/9H/zsYt7dwThSahrdi3bBdGW2Z?=
 =?us-ascii?Q?Apk3ZDR1v+8L1WmYzMGk3GXUOPmadXiqKrYVJohFaHoniPBFAQuIzH/UdXxm?=
 =?us-ascii?Q?aY2IeGZXKwNYez+R0DPw1ZuIVbCUSZL9rlKBh2qS2oZ8hmupyOvMj3PaQ69p?=
 =?us-ascii?Q?lTsbiCO4hGLO8AdQO0O53ByGQ9oSOJZUWj8CoGwbLjXudpMq9W1FbE0G3ixT?=
 =?us-ascii?Q?YO3RysUZ0G5gYyA8vOhYB3Bwg+ZETMumRUqzMUC4bIprBoW7J1mAc7LYieWW?=
 =?us-ascii?Q?d/iWgo+ZjI7hRCX3WCSBwtGZQe5eDym16Q3LXcwPsfDblGqMoAUJERBrN26X?=
 =?us-ascii?Q?R/RKeMc+hL1ZP1AGfv2kiGOfm2ESiHCsZRyn5lXJ2xi4BQ/POyiE6OOo9rzg?=
 =?us-ascii?Q?dV0A5qpHqgd69MEKWltinUuv6ZWsDCY7NWlJh3Q+sAXQ/byfgRkKTQLRl0TE?=
 =?us-ascii?Q?c+ZXAY8jeTyKJcdEw46OscZ7D/T+/MZIGsByhtoEyhzusIk5Vfl0f2Jy1ylo?=
 =?us-ascii?Q?4HjEpVGMJ8daigOd5G3z3Ug3gYWXKITlMgdocluf+daYbwmkmBbsbVYgiQBp?=
 =?us-ascii?Q?h7FfoW25pShwOWZpcj9DjlU5SSaQLky1gibbFDYZDbjLflGiUB6UgYAKHZ6J?=
 =?us-ascii?Q?t3NTtNemp1lMEyZQFlEO0Pe8TAVtdn6aVNKL3rjmzbW61GXdIxszdpCRRgWU?=
 =?us-ascii?Q?qG7x9JS7FDG2ItR3aKYE8/s+P50fASbOD5rfMwt3ZypBuVJNVliiEzk+t8Vg?=
 =?us-ascii?Q?thADRxpAVJq9QvyLH8AAvnasHdjOFrBFoIb9uaBQI4H30xjSxVSl3Cc9bJ6N?=
 =?us-ascii?Q?0oVsSocKuyTToJ1PPIUtn72Ai8BNyVu9RaO4jTEmfKvNVGFXNCQpybyDOkNA?=
 =?us-ascii?Q?zg112jR05hgfPiV01OkfTvLcqaZQEkkaqL9t7DY67iuhRAz7oswlBE/+vGtK?=
 =?us-ascii?Q?bOVm/Im5x0SVa2D7ucGF4dXTPJIrbqEsrKVWcTc6bkZiLLvNnGTJIfQXcZ2n?=
 =?us-ascii?Q?LTax5Y6lZp4m6vimG9y0AhD9khR9mWt3QrePf8aTUZDLLOOrzY6vEvnG0vBA?=
 =?us-ascii?Q?qgXGmeeGP8JUGR5BCkAdZdt5tLMv7B7luWucj3VrTLghdo3u8+PfMD7KCorY?=
 =?us-ascii?Q?ysm/gGbpvpGbPctog9U9Q+Zq3RIFfZqlL1hdx/HzxIkM9o+apfLaYCq+LU9t?=
 =?us-ascii?Q?7tYcJl8yQj2bUm0r4+zGuy5Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aab6722-9057-4de9-ca0f-08d96d331b38
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 10:27:31.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6vEKDWLnHQicexBfjyIwJTzmGfJBrJ+dCG+VgbDTv/tBnLldHJ3ZLKEEtow/zbdP3zpQLWiMquuLHPQGAzFDo0uH0Ki3aSMlTJPjLilpeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010060
X-Proofpoint-GUID: xFeSNmbH_Lcpi3ZQo9_bIRSSG0WkLYsF
X-Proofpoint-ORIG-GUID: xFeSNmbH_Lcpi3ZQo9_bIRSSG0WkLYsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git ftrace/direct
head:   95a037919f1906d8bf164fb0c0066c9f298df139
commit: b45bdf4de5473d5c15090eceeb72a2d5082cde2d [5/8] ftrace: Add ftrace_add_rec_direct function
config: x86_64-randconfig-m001-20210831 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/trace/ftrace.c:5150 register_ftrace_direct() error: uninitialized symbol 'entry'.

vim +/entry +5150 kernel/trace/ftrace.c

763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5111) int register_ftrace_direct(unsigned long ip, unsigned long addr)
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5112) {
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5113) 	struct ftrace_direct_func *direct;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5114) 	struct ftrace_func_entry *entry;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5115) 	struct ftrace_hash *free_hash = NULL;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5116) 	struct dyn_ftrace *rec;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5117) 	int ret = -EBUSY;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5118) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5119) 	mutex_lock(&direct_mutex);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5120) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5121) 	/* See if there's a direct function at @ip already */
ff205766dbbee0 Alexei Starovoitov      2019-12-08  5122  	if (ftrace_find_rec_direct(ip))
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5123) 		goto out_unlock;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5124) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5125) 	ret = -ENODEV;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5126) 	rec = lookup_rec(ip, ip);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5127) 	if (!rec)
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5128) 		goto out_unlock;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5129) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5130) 	/*
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5131) 	 * Check if the rec says it has a direct call but we didn't
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5132) 	 * find one earlier?
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5133) 	 */
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5134) 	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5135) 		goto out_unlock;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5136) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5137) 	/* Make sure the ip points to the exact record */
406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5138) 	if (ip != rec->ip) {
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5139) 		ip = rec->ip;
406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5140) 		/* Need to check this ip for a direct. */
ff205766dbbee0 Alexei Starovoitov      2019-12-08  5141  		if (ftrace_find_rec_direct(ip))
406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5142) 			goto out_unlock;
406acdd32d3e7d Steven Rostedt (VMware  2019-11-15  5143) 	}
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5144) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5145) 	ret = -ENOMEM;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5146) 	direct = ftrace_find_direct_func(addr);
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5147) 	if (!direct) {
8a141dd7f7060d Alexei Starovoitov      2021-03-16  5148  		direct = ftrace_alloc_direct_func(addr);
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5149) 		if (!direct) {
013bf0da047481 Steven Rostedt (VMware  2019-11-08 @5150) 			kfree(entry);

Delete this kfree.  "entry" isn't initialized yet.

013bf0da047481 Steven Rostedt (VMware  2019-11-08  5151) 			goto out_unlock;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5152) 		}
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5153) 	}
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5154) 
b45bdf4de5473d Jiri Olsa               2021-05-18  5155  	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
                                                                ^^^^^^

b45bdf4de5473d Jiri Olsa               2021-05-18  5156  	if (!entry)
b45bdf4de5473d Jiri Olsa               2021-05-18  5157  		goto out_unlock;

This patch should probably do free direct or something.  The error
handling in this function is quite confusing so I'm not exactly sure.

763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5158) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5159) 	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5160) 	if (ret)
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5161) 		remove_hash_entry(direct_functions, entry);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5162) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5163) 	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5164) 		ret = register_ftrace_function(&direct_ops);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5165) 		if (ret)
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5166) 			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5167) 	}
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5168) 
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5169) 	if (ret) {
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5170) 		kfree(entry);
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5171) 		if (!direct->count) {
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5172) 			list_del_rcu(&direct->next);
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5173) 			synchronize_rcu_tasks();
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5174) 			kfree(direct);
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5175) 			if (free_hash)
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5176) 				free_ftrace_hash(free_hash);
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5177) 			free_hash = NULL;
a3ad1a7e396890 Steven Rostedt (VMware  2019-11-08  5178) 			ftrace_direct_func_count--;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5179) 		}
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5180) 	} else {
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5181) 		direct->count++;
013bf0da047481 Steven Rostedt (VMware  2019-11-08  5182) 	}
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5183)  out_unlock:
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5184) 	mutex_unlock(&direct_mutex);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5185) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5186) 	if (free_hash) {
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5187) 		synchronize_rcu_tasks();
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5188) 		free_ftrace_hash(free_hash);
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5189) 	}
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5190) 
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5191) 	return ret;
763e34e74bb7d5 Steven Rostedt (VMware  2019-11-08  5192) }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

