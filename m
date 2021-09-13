Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1B4093B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbhIMO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 10:26:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61712 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345877AbhIMOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:20:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DEFuBa020777;
        Mon, 13 Sep 2021 14:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zjgS2Us4TZ+RMKRrO9CA0Tr8xPKOvhoQaP6OesYcWEQ=;
 b=NN59X6s6w3amEQDMXcYsdwxaJaoPWz+eNicA+bSe9OtXHX1SxVUb7EpJcklRp6D/ktQT
 zMGOwp/jQCEo1g5alNDj/lK/CYzfMrBKWDPJgSVzLxeav77kK/CksmcmKqk3pX0rAHpL
 7chyGxU0torblgWxHsKwp79kUPEMkuPzvTBHI6ECO5tavftqe0ZqmkmhaoUd1FK3tdHo
 Ah0TsV0ddaai4OVPJFfmK97h5GKhHv8yQo0ZeXVLjuxamFwqBUK7aTxQCxDlRvXiLBjp
 GyexdVeQcPuV/gUym4ZCN9wJX6VEqU2RRcB5z7z9nOhxpHGSFKZR0nhMS0u77SY+Askf aA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=zjgS2Us4TZ+RMKRrO9CA0Tr8xPKOvhoQaP6OesYcWEQ=;
 b=MPkv4QIJbBn5bZw215bqIeWvFliHlk+mqOsFV0zZJrH0snZFv7/sH02dUmosDzbImOgy
 m0ZvWjY3yTX5RtSGJkjzaXBQT831JxZAcHJuf4LAuOV2hNBwGG2N6FRnEvpH/ffi61PM
 RnWwUhUr96a+Xb+RBCciuswQEn5ewEm9hCV/hfLvdGsRh3+jZ5O+jS4zrxvdzJVNapX1
 8EmWX8VQeV5cVqmou+S6vJuj0LVpDXhVD943uf2JKXkUWzTIgrJuEj++kwoDYT1AMkwU
 PRCPbkYe7Ca2XybAgvzEFgS32fDuOsGPDiR5IBmgfTtaD9OzxV72IhKhumlsaQ1ea4iK Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1jkjau1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 14:19:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18DEDOH7034885;
        Mon, 13 Sep 2021 14:19:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 3b167qgvc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 14:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng/ImMN6F7S2umAcrF0Jsi/b1LLw2Z0Rt4X5W8Q59l4+0zg89iboNN/GqMmtOjEaP5sOKVhdluVqd0qEDLu+dxqHEhNNEx29EUynzcXpiWuO0LRg/n6MYGzqlalokVyy7+15VmPQEEvPoeUB0RfP0bq9AYsMOAhIoaDN8WCyo31Zr3sehJdAaN7UWZmVMGj93G7mCCvBlEuGSqPAzdYnwLD+o/egrT3tEaLicvGPX475GNUgOguO6bNOEWYJaN6zLeSQJnxsUV5hkHFnQBSiVjln/8dPCwX+y0t35Lslsp3i1an9CfdLMupBR99T4QkwpZUhvCS+pMEDvyro557Ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zjgS2Us4TZ+RMKRrO9CA0Tr8xPKOvhoQaP6OesYcWEQ=;
 b=Wt8N5yUIQAaA587sN8wsqsfGsr5ZVHv1s2gdD0o9jN2Q5J7DOU/Lku1udaQunhIn28eGto3cOiJ7+IrWLjN7d+jeo90UOZc7sUGxSQB84alUeNId1+ugO37IvjhWL+YUDGpoCIa3i1J0zIsEqScRbtObE3P+XeQZRl8hSVa4NHjgkocb0JGSF7iOfWCDMgDdp1bbBhbGRKLSKVhGrDsZ+4HwJv9AQRCtWtlE2bGV/aITusy2eH1oFY8dnnv+Wp53g2ZcuILqj3Jp6wV3HDJRqT0pDah7DV7DLDqlThntuXWpt6FWxW77n1Zx4FLkJPqv6t/ajVRz1wlvJqwFWtAhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjgS2Us4TZ+RMKRrO9CA0Tr8xPKOvhoQaP6OesYcWEQ=;
 b=XW9sgUhfLRiFHcxJI4yzhfl41kxswNiKuV82iR1SBmxPo2e71gyN/n1WjGbr+8BrW5loPH/odBL+WLD6ruLBkiAXeb8XsgzOWp8ZX6wxI12zngRy2OG2ohAMStd2jUT1U2CDY3gENyVJA5w30ClZNx8FxsFjFkl69b4jBI369+0=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1248.namprd10.prod.outlook.com
 (2603:10b6:301:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 14:19:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 14:19:00 +0000
Date:   Mon, 13 Sep 2021 17:18:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Thomas Zimmermann <tzimmermann@suse.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/vc4/vc4_v3d.c:468 vc4_v3d_bind() warn: 'v3d->clk'
 not released on lines: 451.
Message-ID: <202109130332.svSr7mtV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 14:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 847374ae-fe1d-4a2b-a039-08d976c16e8a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1248C723041E127AA16B8ECB8ED99@MWHPR10MB1248.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:305;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vT9O9xL6uxjG6iLE7w/ttWAII6sVCo7Or2y2m6ujXWlEJvYfEgCWppZCKFYjaQHtJcp2frSEjzSLse8joKhybtYIdhJ5WOuQ6yG3iKv2ELO094KgmAeoE/8gWqgKMkwaWhScOpgexFaDcIdWT1tXPKmYOFnqxPkXdrKADzFPmTw+vCWiLAv1OmFJHs9SC+AhuLDlGA5eVy9YuO6mnnsF2fPF2Dspss03a89oW4Faq4kCzagyjM+3IvxUP2c+VfrDyX/FTzPGM3d3V8thEQ0j/xsek5z695g2J41OBmj6MiXvzuT2DS7SVnr7+cWcO9lqEuZN6wptQV2IAUNmF/1jbHSkrkyfm4+UfBerejoMmtg0ArMfhDIfQRcAZ6TOxnxVcxtyHZP8MXU68yjej6du+NoUoYmjmr+fU+ACkNLTmpgs8quccmgn4Jzc3n/fMP+hKBYaZM/2yUdRMyQ3ooDfU72tDEvSni9PGeud9vihWF+i6JcAPpnWLa1XcDYFWCYBNxeY7mN+lWVjmENBxpSaUJSWLlhQoCBpFRf4cQHKmeaLcVBhS1A/JMIuoUH5Cf8Iw9q7P3JOH/GE6pVMJiN7T4YNSSIUIL+dZDagr1dbwF6gTfHdjPo2YF5xAr9EORkZjmaGFv5P8saWDuZO/VbWSVYoY3FwIWxPQ9KgSHusNP9fmhA2YIa+YxUShzzfouTPsIVJuBzU7aA2wA9eXB0dgl1+jLfWXeYX1M/Gpq3nIpzZNP9uup+dZ8L3d6UYf4gUaynbj+qkBEhPnZhFhM3bQoPz1N+R54qme2Biw3PeEr9qeI0CgLUr7iAdZ6S7GYCXyTIPJl7HhVyxq92IbeCE5iLMrnOHYDfJfSfxaoA/GaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(38350700002)(66476007)(38100700002)(83380400001)(66556008)(8676002)(4326008)(26005)(6666004)(36756003)(6486002)(86362001)(44832011)(66946007)(9686003)(2906002)(4001150100001)(5660300002)(52116002)(1076003)(966005)(478600001)(316002)(6496006)(8936002)(956004)(186003)(6916009)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dqcmI9J/81LmzbOwPEItcDlmMx3eGPCKGdMnUefUKXyBlgmv+dlIcPusw29q?=
 =?us-ascii?Q?CCk4zPw1Q3e9yCj+GWB2MzBsulVifiGqSnvLL/qcyLHjdqB/keUORutbC8aM?=
 =?us-ascii?Q?haQzYZROo0yse8o+ETaF2+tQPRevGE8hlFhfq6Roo4cioQS7hKv+IoqUX2fv?=
 =?us-ascii?Q?tvcCgCe7oli+PJn01DSSWxktRq3OMKMyLcVxqG7k2GG/rj884CbhxtQnKHDF?=
 =?us-ascii?Q?exUnwlw8SNtz2ZTySpHoSSv90AIOT+RHDjVqIhZgf9Wr2LLo3xL2N5Q8GDGT?=
 =?us-ascii?Q?lQDEph13iZKDI5GucVLucI8dP6EIvLmhYOol0+EJK29LIFhd+Mn5JSrjFm7m?=
 =?us-ascii?Q?imMMjrGHc7EUTtEqjiJzziPYX5rn9c/d77lP3C0HjiNiOdXFAR2PBZ2xwpuO?=
 =?us-ascii?Q?wLWPum+W3WOExMfwtuHdCEYzKmS2hslnEvaAcoC6/4r6hl2Wu4uGSmpdL665?=
 =?us-ascii?Q?1o1gwqRVwiZFQcrR6HokyBXKcqi2K3zqppFcG80yVcEn3dVpniCt0Y4AVBmw?=
 =?us-ascii?Q?Oi95laJFI+mlZKLKx/VEwEYWf6jWz3dEcZQ6vc7gJ5CtzezECscd/Kl4ReC3?=
 =?us-ascii?Q?OHaFsvqOd8p0b/3meW444W2wcXJGD1H2A3J/wi2QSnHtRVRQPaMGCell7DfJ?=
 =?us-ascii?Q?opDvNy6xuAvnuc61ELNrJM9s44Nfjzs8tMms1hx+gLAYHxrTZ7HwQKwv42tJ?=
 =?us-ascii?Q?cLEBdD5ueLnofkLGMDBwYIoObq3XYtkUm57uu0ToxjGiUM9sbiTAKKGwjxMH?=
 =?us-ascii?Q?RFh953fCkgluTGOXTyVFxNwK6G8P3dHqEuWfDa8popie5bjqzvYUs7rH5Qzg?=
 =?us-ascii?Q?LkggoJLwnmNM7vVF9+bVxLjTdu8upFYt80DAlrxabonmoR0sFGUAW85kwC9d?=
 =?us-ascii?Q?QqMWBCepbUvvi46MmnvxUy+WWTCqU6dRbADO4beKZOcOq2U6jHd3hpBNND1D?=
 =?us-ascii?Q?ts5IxybAHRTB8gMwyeVG8OkFkWoqZHMA9cK+pQmR0r1pmmGvniq3cAldG74X?=
 =?us-ascii?Q?EgSjsCvqrPF3avwvPWYL3QV8QAqDhNWzKn03/GJM975Hm2faD8j5KzswJhL6?=
 =?us-ascii?Q?GkDW2ZLaiOTM7Kg6v883r9i1xnp61jzlMj2ohA/RqNZIxLgLgsqaRCgRYXOj?=
 =?us-ascii?Q?DFMXci8SKpkubfcWlew4Bgvz5AMCSwc1nkDbxmuh5U8SVYahQnK4kytLojMW?=
 =?us-ascii?Q?USPSOvQaR6siD6EBZYNlWk6XJaLPUPLFr2Qf/GkcHGyEsFqwgHCSYcosINUc?=
 =?us-ascii?Q?j+kWdA7zc5UIfeGXHcG07v0v3imE5lVZgv5YMa7oNjJG6z0vkr8JwNaGAEgk?=
 =?us-ascii?Q?dBLAvJ5PbxSfs2MIcAceYVx1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847374ae-fe1d-4a2b-a039-08d976c16e8a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 14:19:00.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stKvfcdCKyaAq1VKsNvmPGXI570EgNuHjBXbd9NrpkxZpWxqXKNthymt++I3NY9urmLpBl1jRZ/F0Jjbgg43i1UDMu2XJxL/5ik8pGfP4gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1248
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10105 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130095
X-Proofpoint-GUID: 3JKfpEMpRnOdxEyX3QAW9OOqeQyAcnOT
X-Proofpoint-ORIG-GUID: 3JKfpEMpRnOdxEyX3QAW9OOqeQyAcnOT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   78e709522d2c012cb0daad2e668506637bffb7c2
commit: 5226711e6c413ed069788f1e3f71def9d8d839d6 drm/vc4: Convert to Linux IRQ interfaces
config: openrisc-randconfig-m031-20210912 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/vc4/vc4_v3d.c:468 vc4_v3d_bind() warn: 'v3d->clk' not released on lines: 451.

vim +468 drivers/gpu/drm/vc4/vc4_v3d.c

d3f5168a081000 Eric Anholt       2015-03-02  389  static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
d3f5168a081000 Eric Anholt       2015-03-02  390  {
d3f5168a081000 Eric Anholt       2015-03-02  391  	struct platform_device *pdev = to_platform_device(dev);
d3f5168a081000 Eric Anholt       2015-03-02  392  	struct drm_device *drm = dev_get_drvdata(master);
d3f5168a081000 Eric Anholt       2015-03-02  393  	struct vc4_dev *vc4 = to_vc4_dev(drm);
d3f5168a081000 Eric Anholt       2015-03-02  394  	struct vc4_v3d *v3d = NULL;
d5b1a78a772f1e Eric Anholt       2015-11-30  395  	int ret;
d3f5168a081000 Eric Anholt       2015-03-02  396  
d3f5168a081000 Eric Anholt       2015-03-02  397  	v3d = devm_kzalloc(&pdev->dev, sizeof(*v3d), GFP_KERNEL);
d3f5168a081000 Eric Anholt       2015-03-02  398  	if (!v3d)
d3f5168a081000 Eric Anholt       2015-03-02  399  		return -ENOMEM;
d3f5168a081000 Eric Anholt       2015-03-02  400  
001bdb55d9eb72 Eric Anholt       2016-02-05  401  	dev_set_drvdata(dev, v3d);
001bdb55d9eb72 Eric Anholt       2016-02-05  402  
d3f5168a081000 Eric Anholt       2015-03-02  403  	v3d->pdev = pdev;
d3f5168a081000 Eric Anholt       2015-03-02  404  
d3f5168a081000 Eric Anholt       2015-03-02  405  	v3d->regs = vc4_ioremap_regs(pdev, 0);
d3f5168a081000 Eric Anholt       2015-03-02  406  	if (IS_ERR(v3d->regs))
d3f5168a081000 Eric Anholt       2015-03-02  407  		return PTR_ERR(v3d->regs);
3051719af11eb4 Eric Anholt       2019-02-20  408  	v3d->regset.base = v3d->regs;
3051719af11eb4 Eric Anholt       2019-02-20  409  	v3d->regset.regs = v3d_regs;
3051719af11eb4 Eric Anholt       2019-02-20  410  	v3d->regset.nregs = ARRAY_SIZE(v3d_regs);
d3f5168a081000 Eric Anholt       2015-03-02  411  
d3f5168a081000 Eric Anholt       2015-03-02  412  	vc4->v3d = v3d;
001bdb55d9eb72 Eric Anholt       2016-02-05  413  	v3d->vc4 = vc4;
d3f5168a081000 Eric Anholt       2015-03-02  414  
b72a2816e37114 Eric Anholt       2017-04-28  415  	v3d->clk = devm_clk_get(dev, NULL);
b72a2816e37114 Eric Anholt       2017-04-28  416  	if (IS_ERR(v3d->clk)) {
b72a2816e37114 Eric Anholt       2017-04-28  417  		int ret = PTR_ERR(v3d->clk);
b72a2816e37114 Eric Anholt       2017-04-28  418  
b72a2816e37114 Eric Anholt       2017-04-28  419  		if (ret == -ENOENT) {
b72a2816e37114 Eric Anholt       2017-04-28  420  			/* bcm2835 didn't have a clock reference in the DT. */
b72a2816e37114 Eric Anholt       2017-04-28  421  			ret = 0;
b72a2816e37114 Eric Anholt       2017-04-28  422  			v3d->clk = NULL;
b72a2816e37114 Eric Anholt       2017-04-28  423  		} else {
b72a2816e37114 Eric Anholt       2017-04-28  424  			if (ret != -EPROBE_DEFER)
b72a2816e37114 Eric Anholt       2017-04-28  425  				dev_err(dev, "Failed to get V3D clock: %d\n",
b72a2816e37114 Eric Anholt       2017-04-28  426  					ret);
b72a2816e37114 Eric Anholt       2017-04-28  427  			return ret;
b72a2816e37114 Eric Anholt       2017-04-28  428  		}
b72a2816e37114 Eric Anholt       2017-04-28  429  	}
b72a2816e37114 Eric Anholt       2017-04-28  430  
d3f5168a081000 Eric Anholt       2015-03-02  431  	if (V3D_READ(V3D_IDENT0) != V3D_EXPECTED_IDENT0) {
d3f5168a081000 Eric Anholt       2015-03-02  432  		DRM_ERROR("V3D_IDENT0 read 0x%08x instead of 0x%08x\n",
d3f5168a081000 Eric Anholt       2015-03-02  433  			  V3D_READ(V3D_IDENT0), V3D_EXPECTED_IDENT0);
d3f5168a081000 Eric Anholt       2015-03-02  434  		return -EINVAL;
d3f5168a081000 Eric Anholt       2015-03-02  435  	}
d3f5168a081000 Eric Anholt       2015-03-02  436  
b72a2816e37114 Eric Anholt       2017-04-28  437  	ret = clk_prepare_enable(v3d->clk);

Smatch wants a matching unprepare disable for this.


b72a2816e37114 Eric Anholt       2017-04-28  438  	if (ret != 0)
b72a2816e37114 Eric Anholt       2017-04-28  439  		return ret;
b72a2816e37114 Eric Anholt       2017-04-28  440  
d5b1a78a772f1e Eric Anholt       2015-11-30  441  	/* Reset the binner overflow address/size at setup, to be sure
d5b1a78a772f1e Eric Anholt       2015-11-30  442  	 * we don't reuse an old one.
d5b1a78a772f1e Eric Anholt       2015-11-30  443  	 */
d5b1a78a772f1e Eric Anholt       2015-11-30  444  	V3D_WRITE(V3D_BPOA, 0);
d5b1a78a772f1e Eric Anholt       2015-11-30  445  	V3D_WRITE(V3D_BPOS, 0);
d5b1a78a772f1e Eric Anholt       2015-11-30  446  
d3f5168a081000 Eric Anholt       2015-03-02  447  	vc4_v3d_init_hw(drm);
d3f5168a081000 Eric Anholt       2015-03-02  448  
5226711e6c413e Thomas Zimmermann 2021-08-03  449  	ret = platform_get_irq(pdev, 0);
5226711e6c413e Thomas Zimmermann 2021-08-03  450  	if (ret < 0)
5226711e6c413e Thomas Zimmermann 2021-08-03  451  		return ret;

Here.

5226711e6c413e Thomas Zimmermann 2021-08-03  452  	vc4->irq = ret;
5226711e6c413e Thomas Zimmermann 2021-08-03  453  
5226711e6c413e Thomas Zimmermann 2021-08-03  454  	ret = vc4_irq_install(drm, vc4->irq);
d5b1a78a772f1e Eric Anholt       2015-11-30  455  	if (ret) {
d5b1a78a772f1e Eric Anholt       2015-11-30  456  		DRM_ERROR("Failed to install IRQ handler\n");
d5b1a78a772f1e Eric Anholt       2015-11-30  457  		return ret;
d5b1a78a772f1e Eric Anholt       2015-11-30  458  	}
d5b1a78a772f1e Eric Anholt       2015-11-30  459  
7f696942a7e52d Eric Anholt       2017-05-15  460  	pm_runtime_set_active(dev);
3a62234680d86e Eric Anholt       2016-11-04  461  	pm_runtime_use_autosuspend(dev);
3a62234680d86e Eric Anholt       2016-11-04  462  	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
001bdb55d9eb72 Eric Anholt       2016-02-05  463  	pm_runtime_enable(dev);
001bdb55d9eb72 Eric Anholt       2016-02-05  464  
c9be804c8c7a2d Eric Anholt       2019-04-01  465  	vc4_debugfs_add_file(drm, "v3d_ident", vc4_v3d_debugfs_ident, NULL);
c9be804c8c7a2d Eric Anholt       2019-04-01  466  	vc4_debugfs_add_regset32(drm, "v3d_regs", &v3d->regset);
c9be804c8c7a2d Eric Anholt       2019-04-01  467  
d3f5168a081000 Eric Anholt       2015-03-02 @468  	return 0;
d3f5168a081000 Eric Anholt       2015-03-02  469  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

