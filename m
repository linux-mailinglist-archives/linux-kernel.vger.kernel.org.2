Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1EA3DB991
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbhG3NqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:46:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55848 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238890AbhG3NqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:46:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UDjir9030265;
        Fri, 30 Jul 2021 13:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=0VWLwFNUDDkt4YI40FB0KwNayP90VmhYm/TEipoF4RU=;
 b=jM8Hc9biQ6vQ+XNutYc3BZbBVvBLXzUaR6Hxzoruz6Gho8QirjrkNsMGPh96WsAB27hr
 rU+2kigXfip0QThAOnhjKAPlAS93UvXE4sbrLhRjfxBDyF7Lv/TYcZ7A2mBs99Q6wReS
 /Jo7T4slRTDY8wKch41MVvVVjkO4dQ0KYwiuekcJ2POUUi7vy+UwJ9XEq/0H2XRkIOm/
 OOW50BBzgN1a/8uwFMmB/LMPxC5l8vxqAAEYFhJOixf5jTa1zBp8uVbUHNcImwq7OigG
 CnYd7jGZUzpMJ51ZshgFR/r6QjpklBbI99QeW3bkpmCn8daHEAS8iHNkgj4EAOmoszu0 cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=0VWLwFNUDDkt4YI40FB0KwNayP90VmhYm/TEipoF4RU=;
 b=du/vlclg781/cNcULdYlXoaFbVKSLGIQCeHZOrF64IPsCKoseq7RSnaenv/u+UmeDFcg
 4t3hkHzRbCrWv58IMonUuGglZFeBFbKa/6KDtMXVQBdoDcjAMMCykZqTdmvWK15+mVSm
 6wydtP6X9z1Xzy0vkLh9fM2FNngq9ul7yE9Hv0gwXFLsdtUkBZ4/Bj+nD6Zu5gUz4Nic
 lcvmk1hL+uksF4q/VgJzE4C941BOCG8kpjN42F3YM8BCbXw/h1x0MAAo1f+q/khyURou
 RFolrLVe6PbBA9gGTC3I2FT4lKPGWD50Pw4N98IPBaxAVT/mnoJnIgYAJIjGtJZIkY7K mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a3uujavww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 13:46:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16UDjgRO095042;
        Fri, 30 Jul 2021 13:46:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3a2359jyex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 13:46:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEoqmxXjH+Aqw5wjaZVOW1S08//FAWGfWxnSGwebNx2vg1G4yDlL7a6X+ZIJ0uShNbLT8bQtP+v/MuEjofcaxa6iWN5WOw+6AIELJdCr+s3c5cSesnvIkIRFEFfcYPedUaZ48zpjKqCCjYqzib4bzlzUWvzQvwSn2SHFJgI9/DP8SqR7+sX3blgS1CN8dn7Dkr/Dmh5u0VLmDjd816mlk4zJ/U3MeVQkGHrGbR6eCs8B7SZcbYIKTaIbTKNz93dZhiY1Ndijgzeku5YOLQg3aIGPCiRSIuPaBhL/mHDtGgYnQZxhvv3ZqnfVlIFk0zlDWBAJQ3gn5rDrNx65dJvsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VWLwFNUDDkt4YI40FB0KwNayP90VmhYm/TEipoF4RU=;
 b=hqOcaVoe7Iytt7+zbiM/bnNdV9ZLMNp14Z9/F80ezqT/RBw/iojiA8tz2VMH9nGQUyhWGPU9R7sCrPyEYfzc6A9fgZrkHGwFNZJqbVfEsGoluDVE/YtiTXK7PfHZjUasAM/xbdHxC8y9M546yk4wY3jgnkZlFBpBtAFAolUtlnhqvXl+TJS1oK923tV2gsa4oLWmuob3CM3feUc31iMyvFlbswNcgsG3/1epw0Ea44WnGXNDUZnIvNACenTBuUZhgHRX+GVhUAqaPcLrbZeb2L+lCQc4wL/GnHXVWHzHaufZxmhSqbM544/yQCY2vr4aEDEg5OUjZ0i9tamWKh3dHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VWLwFNUDDkt4YI40FB0KwNayP90VmhYm/TEipoF4RU=;
 b=P37aZJJF5ykcAPYm9azTpzxv6zxntIA8CK32SQvXRnSLT/JrgYtT1Dxh/mCuaZAe8QlHPl76w6DmNLdPlXnDlwrAT+ORwQb0+xQMWQZSIp4d7i1JJiRFPRrg90YomlRSNfSD9if+DtUS2jF8EuDg4Cr67NiWwL3p4z9LnU+ayZ8=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1319.namprd10.prod.outlook.com
 (2603:10b6:903:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Fri, 30 Jul
 2021 13:46:05 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::856c:c91e:aaf8:11d]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::856c:c91e:aaf8:11d%3]) with mapi id 15.20.4373.022; Fri, 30 Jul 2021
 13:46:05 +0000
Date:   Fri, 30 Jul 2021 16:45:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Damien Le Moal <damien.lemoal@wdc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sean Anderson <seanga2@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [kbuild] drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe() warn:
 'pdata->clk' not released on lines: 962,968.
Message-ID: <202107302010.QfgLffbI-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: PP65JQ7SX5ZWTH4M6WEZFYTKE6VRKO2K
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::16)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Fri, 30 Jul 2021 13:45:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1896079c-7606-4dee-447f-08d95360609a
X-MS-TrafficTypeDiagnostic: CY4PR10MB1319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1319B563269A1326F25B2F458EEC9@CY4PR10MB1319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:204;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMHlOhMZJ11diQZ2YYWieXMInohqXG7y191ChThUVCz6HVQlHyNVZsuN2SKZLh89ntuLLGHxGH9utA6JheJEObSzn/0B4/tMqQblW1XWoqvFl4xor3DUluJnMJYlkEOdPc16xdvuaRmNOajsP6/pxagbK7pe2WdmxSwpVNzrx0R+8HD8gLBZ+Ecdqvgf/b5l+KDSwQh9EryocmzNWo8qCMVirR5OdRbYtpmrKrP1Dso08IVxMjtaDHjivpVU+MqL96vs73keHCPzka65kZcpMOC+cZzuhnXO4LzlNBg2LSRW9gkBMUA3IBnG8nABnuFTc/zbsPwzrxuFh0OEA8tXjnGlwC4ylePzjkbyhI11GNMsezYUIPOtVRdzWuDs2EyFPjEM3+lwgN3VhTcjQp0K2yPP43DN6ysN7gvLlD8boe0R31xXa4SEoMBlAKCT7YHsKAutq/p/joJS2PIgG8JY+BAoV/qG9DH3j65VSEM/qUW04rKZe7aWMWYWH3Lm8zXjcH/2XK17Df8C1a/RLLlcwXKqRxzUHWAvg/jFrRatH2AjQPr+WXvyr5dOeMS0li7trOCnfwUgnN8u7mDfxexz3iZJBQhfdq5+3EqekJz6ePNRM7qPHsAOnoU87CQ5Ed5PCx3XFo6bXpwA6J0faVfFArO8Vn0vVBKr0J7o+pSX694PeuDJrxRhiKGtDrzJo5VbaLDvDHs5tF5xTr7ULh0zh3xX5FgM/f+/jXLMIm1bjAXh4jBRKhW17rth6BjxZ4m0o8B49nyxRB7+Czvwepr9ff/q7zVWQNOonBKFxNvJUxLfWoFdL9ajBBe8gj1GVwLGdKKTwcHCDwmDSDy8nLobmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(6666004)(66946007)(9686003)(26005)(478600001)(966005)(1076003)(66476007)(316002)(186003)(66556008)(8676002)(6486002)(38350700002)(956004)(44832011)(52116002)(38100700002)(8936002)(2906002)(54906003)(36756003)(6916009)(86362001)(6496006)(4326008)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DjQN1TQ2dDAtZYrwVTa8FPunYSwIYKPc0EOvtZKRLncn3MWE+zypQVUYlysi?=
 =?us-ascii?Q?8jpABCDudg/IVCZa3vHbyxdp9OEsBQU7YXRfVr6/aWgxD315wrI/iB1rM2FX?=
 =?us-ascii?Q?d1w/bretZ9gjvDMAk7788szX0m97/58qQOmcuyyJTSIEQM0phrrq7Gcp+72M?=
 =?us-ascii?Q?JLUaKxPK5fEcsVZprjCLDoJ9NETIbQfPZdLyTe3d3CgZDM01PIMQhR0O+wPT?=
 =?us-ascii?Q?bJlhG1q36tdR7nvbzSGtwZer/mNhcbIUV7hirpCqPMJ6xtELvD4y7d5vh2FP?=
 =?us-ascii?Q?RoOVuoD5dEw9auG83e4VPySw4MlKVrxXAXNnFxLpjcZw2AK9UWh4JUSuGwJW?=
 =?us-ascii?Q?opsNH4jmMeGTSr0KDZ83UkL+UsAuMHzFkAHk5vUrUd9gtdBlAtBTFceSUgS7?=
 =?us-ascii?Q?UMj/RJS8n6nFPwG1KrKsslOJTEgkjv8vU2+QlB3Hd23wMwyKDctqAiVmOJzn?=
 =?us-ascii?Q?OENZiqcAGh/8Y48k9YM+r2qFShJO2of8tW6QuO5Gvf8lcidZBCPZJ4bDTzOA?=
 =?us-ascii?Q?iKz5JDLl/94wIaNJwRHra/9IDoDAlbcaBT4Q7EWEfrZCJqx+Rit06cBeS4sZ?=
 =?us-ascii?Q?8LUxlKXTXqAPxIVu5Mn25u+gP8Zgddr6KX1BGqNAlTSGem0RmUGnwNvFzLvV?=
 =?us-ascii?Q?YVRB1LoQIPIg7rbGXnK6b3JUEdIG0UsXVXnhNuIbqhrt9H0+GbeY17S54+fK?=
 =?us-ascii?Q?sVIc/3dVnEhGyy0ExijmgKy7/WTvLh/21lnyEgTm+3C4a1NS7nzuawRMNO0K?=
 =?us-ascii?Q?zw2J5qQOQxiJAlkRrRmYA2eaJAOmA4xpEgOxUh7QeFWNrVkF9Ej9t4sueGC6?=
 =?us-ascii?Q?1A4jd6J0KwEscwGA98YnDP/+g+0RyoT0VoOZ1rvpT5LTCN4HfWBEZEP2VfYL?=
 =?us-ascii?Q?P4ax6uSZJ4szjFhFL9LPMvLZoXBYclwqsJ5R7T53v5+mS/mDZY58c9DEFuh/?=
 =?us-ascii?Q?KQwImrV68LhwRwUa4lqU/58uPtr9GSHoNPo2resE/7Z2y2eO1+rJWbBngPYl?=
 =?us-ascii?Q?ZP3Alsm1kqh4PB0CgaiErx0iNE7y1BFUW8mMIECNWiaqOcSofloCnV7B0M60?=
 =?us-ascii?Q?wQ24obgRR1acwsxEhiZRbo5nbHk3do4QXi4esYAxKH+9urH1F9j8CDj/D6Bo?=
 =?us-ascii?Q?3PmZaMLzywmuPjlpsSMs7EMUEmExld7WH23+oFWM0JdXNO6DEoCD4JZDWFPz?=
 =?us-ascii?Q?Z52SGu7s9Juny7mpmpsbMcCKIKaLmpxjRvzGgBIT6v8cls6FvVANdwwH26kT?=
 =?us-ascii?Q?YtkY2qICEsFy2CWJ6u+V6UV/ShmXEUQTXaOzRY1eWuju6e09VakBueFMEKs8?=
 =?us-ascii?Q?S6pABCXUofqIFJQdqw1PwKE1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1896079c-7606-4dee-447f-08d95360609a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 13:46:05.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq0S5dbGFI3ZSRtbTWWM+a3pv38+0nbrm2Z19ubl9i9Dq6SV5fj4/A/VRJhEUODp1HdkSLLTYgx5ji+DbISFcFcV7hFdQz8iRJC91QA2EtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1319
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10060 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300089
X-Proofpoint-ORIG-GUID: oXemb9bdxwbHMzFJ10lMtMsgzCiCNxQ-
X-Proofpoint-GUID: oXemb9bdxwbHMzFJ10lMtMsgzCiCNxQ-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
commit: d4c34d09ab03e1e631fe195ddf35365a1273be9c pinctrl: Add RISC-V Canaan Kendryte K210 FPIOA driver
config: riscv-randconfig-m031-20210730 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe() warn: 'pdata->clk' not released on lines: 962,968.

vim +970 drivers/pinctrl/pinctrl-k210.c

d4c34d09ab03e1 Damien Le Moal 2021-01-12  925  static int k210_fpioa_probe(struct platform_device *pdev)
d4c34d09ab03e1 Damien Le Moal 2021-01-12  926  {
d4c34d09ab03e1 Damien Le Moal 2021-01-12  927  	struct device *dev = &pdev->dev;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  928  	struct device_node *np = dev->of_node;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  929  	struct k210_fpioa_data *pdata;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  930  	int ret;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  931  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  932  	dev_info(dev, "K210 FPIOA pin controller\n");
d4c34d09ab03e1 Damien Le Moal 2021-01-12  933  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  934  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  935  	if (!pdata)
d4c34d09ab03e1 Damien Le Moal 2021-01-12  936  		return -ENOMEM;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  937  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  938  	pdata->dev = dev;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  939  	platform_set_drvdata(pdev, pdata);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  940  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  941  	pdata->fpioa = devm_platform_ioremap_resource(pdev, 0);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  942  	if (IS_ERR(pdata->fpioa))
d4c34d09ab03e1 Damien Le Moal 2021-01-12  943  		return PTR_ERR(pdata->fpioa);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  944  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  945  	pdata->clk = devm_clk_get(dev, "ref");
d4c34d09ab03e1 Damien Le Moal 2021-01-12  946  	if (IS_ERR(pdata->clk))
d4c34d09ab03e1 Damien Le Moal 2021-01-12  947  		return PTR_ERR(pdata->clk);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  948  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  949  	ret = clk_prepare_enable(pdata->clk);
                                                      ^^^^^^^^^^^^^^^^^^


d4c34d09ab03e1 Damien Le Moal 2021-01-12  950  	if (ret)
d4c34d09ab03e1 Damien Le Moal 2021-01-12  951  		return ret;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  952  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  953  	pdata->pclk = devm_clk_get_optional(dev, "pclk");
d4c34d09ab03e1 Damien Le Moal 2021-01-12  954  	if (!IS_ERR(pdata->pclk))
d4c34d09ab03e1 Damien Le Moal 2021-01-12  955  		clk_prepare_enable(pdata->pclk);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
No error handling

d4c34d09ab03e1 Damien Le Moal 2021-01-12  956  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  957  	pdata->sysctl_map =
d4c34d09ab03e1 Damien Le Moal 2021-01-12  958  		syscon_regmap_lookup_by_phandle_args(np,
d4c34d09ab03e1 Damien Le Moal 2021-01-12  959  						"canaan,k210-sysctl-power",
d4c34d09ab03e1 Damien Le Moal 2021-01-12  960  						1, &pdata->power_offset);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  961  	if (IS_ERR(pdata->sysctl_map))
d4c34d09ab03e1 Damien Le Moal 2021-01-12  962  		return PTR_ERR(pdata->sysctl_map);

Do we need to clk_unprepare_disable() before returning?


d4c34d09ab03e1 Damien Le Moal 2021-01-12  963  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  964  	k210_fpioa_init_ties(pdata);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  965  
d4c34d09ab03e1 Damien Le Moal 2021-01-12  966  	pdata->pctl = pinctrl_register(&k210_pinctrl_desc, dev, (void *)pdata);
d4c34d09ab03e1 Damien Le Moal 2021-01-12  967  	if (IS_ERR(pdata->pctl))
d4c34d09ab03e1 Damien Le Moal 2021-01-12  968  		return PTR_ERR(pdata->pctl);

Here too.

d4c34d09ab03e1 Damien Le Moal 2021-01-12  969  
d4c34d09ab03e1 Damien Le Moal 2021-01-12 @970  	return 0;
d4c34d09ab03e1 Damien Le Moal 2021-01-12  971  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

