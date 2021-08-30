Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA43FB3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhH3KYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:24:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65050 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233248AbhH3KYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:24:13 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U6wwwD031011;
        Mon, 30 Aug 2021 10:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=E09+f0QJmdic8Bg52RK0czKXyPPOSdlauzGvWEtSsv0=;
 b=t4LWkitxwdYaNjECUFnyVQ1tp1uCnsP6RC31kdc58gjgCdyDCgisZ8Bl79dt9DAMBSmH
 dyosdGB+CrEXRnarp7MsUowgIXfhbVBJ8mPQPcT9QoGybka8mGpYt81DWI8mSSKAc/dn
 /MS9Vfymy+d8ZvynyZqjNULsveRAIwUcxB8LBqJCai8VkV+Do7EsgZ3Lp10cpQSAw3rC
 LrXOESuNXal0/M2XGzmd2371xD9KeCjTkQsPgEvAOHceoDdMsTZUxcQJtDVMqsFrqxtx
 eER4BT6DymJq+hCt6Q7hkyu7uVX5QzKiZSiat9XDM9nLn5sssI/LgEFuh36dHFsBSq6d Vw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=E09+f0QJmdic8Bg52RK0czKXyPPOSdlauzGvWEtSsv0=;
 b=eAilkd2PVEl8lhWtio7/Ei9MagSDUnDxSB9MkxZQF1xP+eRIC5Fd6fQXG8BskX+bVnEi
 B7eUpk0v36cUwBLfwzV5ZNxb6e0RykDXrvfOE1d7ZYyrxHFVFlfLRfle5aK7tR7I+Lgd
 UI7bKywlc67UYXiVeaBQ7HScvdJmDjYmuXpHXKahVkuXreH+UPR5B4IXc3puc+455Tk8
 fVNpxtu1ksSNT7x4B+LdAFVYj5VfoSBSHX7ALpVxlvqdpmX+gRI7vw1kIUOUs9hOOt27
 IMlJ/RU1C0XvqiNI12gab2gtPX0S1h9kaCfdW+FQ1mRV4mICr6F2Ijn56Fkg5ZiwbMbx XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxxh6jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 10:23:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UABmif002643;
        Mon, 30 Aug 2021 10:23:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 3aqxwr5xkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 10:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeR+WDF9GrpUJJtBuAcCXB8xStxygOLUSnqGP131iWZYdsMKs2fNhq/iewg18YLF3QXU07ZrLZGwX4SRk1D7OOAku25My5miXezuwBN0p/R5mPephouIVkNLtxszgJ+IKGgRwjMqpDLLiZ4h62X4rHNxqqs4iA7h2mU3ET7f/j68fgplVIkTpqPddtwRosmWlHwg1HITydpjBM6HM3zIo/HkHMsiBeKiYIBc8D/HIlvXIBbKu/++NrgM/cXdMRBo46bWpERe/x+Vfj4To1ZcbrV64RnWbtQ9YSBKIaRrVoRXZgzMZoPC6MgQX9g/l+nlRmVBNvvAnt65sul7zkNaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E09+f0QJmdic8Bg52RK0czKXyPPOSdlauzGvWEtSsv0=;
 b=cAeOtpTdlcGsv8Mq+VAe9tav5adcFRRdXEu5y+mZOGeRfmLJWq2KiXdIAFIesnOL19WoB3oqvkaWF/Hd/d3Hqq2lANsUEIp77fRnQadSvT4Ui+Zm8KOcEbnRztcKMesDo+Dvv340bbj92hwbgORVEFMSeV6jtM9DXuwMtAy1Dq6UZV0wrMjzW0wRIEPlC2ubd9WseuaU9eeL9YqD1J27+f09TX0M6dHTFJdNvzOMiWJowHCQFT2tiOoDTSxWrZr2OkDUnQ8msgC+LUDa3yaMTaylvib1r20ISJTQ27Q78CtGVVO+0KpjgyPrQHbGdzNGCFI6gSYbZm5gfjRVr5gudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E09+f0QJmdic8Bg52RK0czKXyPPOSdlauzGvWEtSsv0=;
 b=lunrlJqA9NDkft9/2fQj6CFqoNofR4NFDxv6ijOeBF7GB+wZQduUONVk9CQ0TqziKLGdzIGVJAesmnOifuKFUFfMA09IWHM4loPE0E2yneejJcAwOkoO59bXSjRF6jmf2+U1Qkd/7HzmsHOCxe6kMjPbWSjLHRSDpEPAvIUDEI8=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1662.namprd10.prod.outlook.com
 (2603:10b6:301:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 10:23:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 10:23:12 +0000
Date:   Mon, 30 Aug 2021 13:22:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luca Coelho <luciano.coelho@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/intel/iwlwifi/fw/pnvm.c:332 iwl_pnvm_load()
 error: uninitialized symbol 'len'.
Message-ID: <202108281440.81ULgYYD-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.22 via Frontend Transport; Mon, 30 Aug 2021 10:23:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c1f5fc0-b7a5-46ee-0e40-08d96ba02bfa
X-MS-TrafficTypeDiagnostic: MWHPR10MB1662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1662089EE802A1FE381149F08ECB9@MWHPR10MB1662.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jC/JtWYCAKUPDtzR5cZpxbepHCb4dRrO1JTrfGSgvHOCfjDWndvkBLV9lihopGSxI7WxvHVEo9tBNPSPfup6DGqDa7B1fgTvBiKglOqE7e5jgT/vs6qTOBl0PXFTELEsnk3L6tnNgffokrHfcBzaIAcaKJ5ocjN7lf4h533C6r2nu8Exy7mExrRq9vzuqgcvfTcitUkLRd/AF8zKJhbjDz0yRGL4S9R6GjcMvR6ltjZ+uGpmW/EyOIKcLIP/EgOv/KUKJXTKLcdrVvH0UP0BmXAh3fFxtglgFmmAbD9MEK3RN+rgr5orflrh2uHqRRuTgclayGyLbbgIrLEkuFuILvhpkbGFAojJkc6nOqr65OY2dJuFu8/1EQtEylIKLOZm4wa7fDjELL4GjXhCHbDMAuWPkuLEwW9XJQAZu8cbgtu4vbYgadZxdAFn0M7Ka3OQDEZ8rZ3KvkiCyS2//fCBM4YXXx3gpxcQeXcj6hFjN7y6M8kKpSnmfrHd8eACfF9Nb6dGsb1wups1rRWbgq/2pMxZ2Aq7rElpbMYFWFyMSlneFtbkZr//R8ebv5kMbJLhI9SS7OlJ0VW4oNZyoDtdoq3mTv3ioBWSSQARW1T/0D5/75VJ3Jmm1KfAeO/dNnSLiy0l3GOnpXI483snMoHp3gvC7swW/wqiCLb1A8XSiDW4Yvbj6zRPddjXgbBujsKNd1+6YrK7tMLrnFi0En+4z8yUzzwDr8WTyh6XBv0gzJt3Hhgka4VYDekcmwQvl2zDEWtlWv9nBfurcRAamXXg6Xzz+eSKMbNghyzQND10IGGJYQrK0ppKYCg72QIFKGk9MMNcQl/TlTtz8vwUYf0jNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(66946007)(66476007)(2906002)(86362001)(966005)(8676002)(66556008)(6496006)(9686003)(6666004)(6916009)(44832011)(37006003)(6486002)(186003)(508600001)(8936002)(36756003)(83380400001)(52116002)(38350700002)(316002)(4326008)(1076003)(26005)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jE0TdysecUmH2u/e7OEFzz9PZDeFIQnJAcUnBVFVTNGuEGWy6tGtt94LXYyB?=
 =?us-ascii?Q?44K/l/A09qwc5YcijjEElSGUbQscjs1ftgItXXQLcshJMGRaZJvgFThnsbbD?=
 =?us-ascii?Q?dDsUU9uGqLj4hB7DQP/0qNfPDO+JBk/Ug1+WKFRZkXJGH2NFR+1Zo61Yn4bS?=
 =?us-ascii?Q?efP3YSIqsXV68G2ODS0iTEQEiLO/zogCgCirqIn29TuWKX7Y84BlgY7GMKSm?=
 =?us-ascii?Q?mmbdYjpQ9aE0HuvOels/lcjAjK/yJYjAovlCc0itCYGwWadY47N4vC7tXR3G?=
 =?us-ascii?Q?T3rpED26nXT3J9s2p1Ch7J9O3edKAN8VR78ZSmyQAWTgPM6GE3Klr4h0bVZ3?=
 =?us-ascii?Q?uGIQ+dRvNH+pJuRKUaEIgLVoD1oogd1LApJ3v/IrysRmR/Ol8FHi9xtZItTH?=
 =?us-ascii?Q?UzO02bqI7w8pbZsfEB56lsdgREvDCUxWNlIPTG5qUF5g8+RIc8QIMNWYuzrH?=
 =?us-ascii?Q?7fOwPyk0WGtMYj2BIbr+H8lazPNGql3ucuSXDedMMOZYQySt/DwaAlEm34XM?=
 =?us-ascii?Q?/iB7TTCJ/OMcYhNZuKFhFJo3iW6PxxW4mYhVq0R/3WuQkAbhZhAk2qLuXNhV?=
 =?us-ascii?Q?oIvsUGCoQQAmW5HpZIcpGcxxzF4BAAIQa1mY5ugHbcYIzYF70QLdPtauKucJ?=
 =?us-ascii?Q?4Qbskcc8FS/iLSkATPYszP42PePgyCkTDMsKiQvjak51fCV/jWejTMhcbRmq?=
 =?us-ascii?Q?47IrYF3h93BQiN+Gzz8UDR47LN5Auk6fJIUmKY7ru1n5fCoNzLHp9aakIjFw?=
 =?us-ascii?Q?EtQH7X5/EB+yRiRHRb99G1uLj3H0n7AzKodTbXNv4tOP5S8ZjyDLxm+c9Xh9?=
 =?us-ascii?Q?vWg0zb85I0cz6P5hsthVTZyq6kKZVWS6EmpyrFUyUEmP8B6tThMlChMHyB6K?=
 =?us-ascii?Q?VFlTxye0lm/9A9NL3AI8K/vu3RTsJwReG2shh5xPZh8q1Uahv1V3J5XoAhlf?=
 =?us-ascii?Q?vsjEjsmc4GapvjneWflOsuuoxx9zfLuXoVYgUzOqcmEvhKB2kfu2pkcSNS7P?=
 =?us-ascii?Q?m50yztOG5iiZMJ7tZardcx+s/vC4vjcFIaS34gk8kXMo6JdnI2/rFptjBZpb?=
 =?us-ascii?Q?+ku4egNqU/oN3Wu2iyNpconmMZzkr4KEziS3eOUNnVfx3dEx68Tlxct0OBiC?=
 =?us-ascii?Q?rNkEsSAA8GprpObsX2Z7/kMQVXxr0ORsUDdkEjbG9FYj4OXTlsqvHF3h5bBC?=
 =?us-ascii?Q?/xGkSr5jlcMz6xhWJqxf2EColHEO9fgGisvwS2kbWpX11W96Y4dvcM615vRB?=
 =?us-ascii?Q?4OdS5C/X6UJoW8RoC9fbrgdEmBlevvXWXsmbDNKG2pBs2V1q3Tk50AyssOB0?=
 =?us-ascii?Q?n/Ra/Mx8YPgZ3imgOmgCDuHX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1f5fc0-b7a5-46ee-0e40-08d96ba02bfa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 10:23:12.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd19y+bxkcF1YhuHHlJFpxBJ6E3cn0vW/qr+Sw6u5YCNtNg596Ds2ZKWwr0nrj++0N3y2btnV7K1jGlPYkgAQpz0wUdOsctovj5oVctiX2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1662
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300075
X-Proofpoint-ORIG-GUID: HMo8A8DWsHupZsJ8BlnbdrywOG20lohA
X-Proofpoint-GUID: HMo8A8DWsHupZsJ8BlnbdrywOG20lohA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   64b4fc45bea6f4faa843d2f97ff51665280efee1
commit: 9dad325f9d57508b154f0bebbc341a8528e5729c iwlwifi: support loading the reduced power table from UEFI
date:   10 weeks ago
config: arc-randconfig-m031-20210827 (attached as .config)
compiler: arceb-elf-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/wireless/intel/iwlwifi/fw/pnvm.c:332 iwl_pnvm_load() error: uninitialized symbol 'len'.

vim +/len +332 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c

cdda18fbbefafc Luca Coelho   2021-02-10  256  int iwl_pnvm_load(struct iwl_trans *trans,
cdda18fbbefafc Luca Coelho   2021-02-10  257  		  struct iwl_notif_wait_data *notif_wait)
cdda18fbbefafc Luca Coelho   2021-02-10  258  {
cdda18fbbefafc Luca Coelho   2021-02-10  259  	u8 *data;
cdda18fbbefafc Luca Coelho   2021-02-10  260  	size_t len;
84c3c9952afbf7 Luca Coelho   2021-06-21  261  	struct pnvm_sku_package *package;
cdda18fbbefafc Luca Coelho   2021-02-10  262  	struct iwl_notification_wait pnvm_wait;
cdda18fbbefafc Luca Coelho   2021-02-10  263  	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
cdda18fbbefafc Luca Coelho   2021-02-10  264  						PNVM_INIT_COMPLETE_NTFY) };
cdda18fbbefafc Luca Coelho   2021-02-10  265  	int ret;
cdda18fbbefafc Luca Coelho   2021-02-10  266  
cdda18fbbefafc Luca Coelho   2021-02-10  267  	/* if the SKU_ID is empty, there's nothing to do */
cdda18fbbefafc Luca Coelho   2021-02-10  268  	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
cdda18fbbefafc Luca Coelho   2021-02-10  269  		return 0;
cdda18fbbefafc Luca Coelho   2021-02-10  270  
cdda18fbbefafc Luca Coelho   2021-02-10  271  	/*
cdda18fbbefafc Luca Coelho   2021-02-10  272  	 * If we already loaded (or tried to load) it before, we just
cdda18fbbefafc Luca Coelho   2021-02-10  273  	 * need to set it again.
cdda18fbbefafc Luca Coelho   2021-02-10  274  	 */
cdda18fbbefafc Luca Coelho   2021-02-10  275  	if (trans->pnvm_loaded) {
cdda18fbbefafc Luca Coelho   2021-02-10  276  		ret = iwl_trans_set_pnvm(trans, NULL, 0);
cdda18fbbefafc Luca Coelho   2021-02-10  277  		if (ret)
cdda18fbbefafc Luca Coelho   2021-02-10  278  			return ret;
cdda18fbbefafc Luca Coelho   2021-02-10  279  		goto skip_parse;
                                                        ^^^^^^^^^^^^^^^^
"len" not initialized here.

cdda18fbbefafc Luca Coelho   2021-02-10  280  	}
cdda18fbbefafc Luca Coelho   2021-02-10  281  
a1a6a4cf49eceb Luca Coelho   2021-02-11  282  	/* First attempt to get the PNVM from BIOS */
84c3c9952afbf7 Luca Coelho   2021-06-21  283  	package = iwl_uefi_get_pnvm(trans, &len);
84c3c9952afbf7 Luca Coelho   2021-06-21  284  	if (!IS_ERR_OR_NULL(package)) {
84c3c9952afbf7 Luca Coelho   2021-06-21  285  		data = kmemdup(package->data, len, GFP_KERNEL);
84c3c9952afbf7 Luca Coelho   2021-06-21  286  
84c3c9952afbf7 Luca Coelho   2021-06-21  287  		/* free package regardless of whether kmemdup succeeded */
84c3c9952afbf7 Luca Coelho   2021-06-21  288  		kfree(package);
84c3c9952afbf7 Luca Coelho   2021-06-21  289  
84c3c9952afbf7 Luca Coelho   2021-06-21  290  		if (data) {
84c3c9952afbf7 Luca Coelho   2021-06-21  291  			/* we need only the data size */
84c3c9952afbf7 Luca Coelho   2021-06-21  292  			len -= sizeof(*package);
a1a6a4cf49eceb Luca Coelho   2021-02-11  293  			goto parse;
84c3c9952afbf7 Luca Coelho   2021-06-21  294  		}
84c3c9952afbf7 Luca Coelho   2021-06-21  295  	}
a1a6a4cf49eceb Luca Coelho   2021-02-11  296  
a1a6a4cf49eceb Luca Coelho   2021-02-11  297  	/* If it's not available, try from the filesystem */
cdda18fbbefafc Luca Coelho   2021-02-10  298  	ret = iwl_pnvm_get_from_fs(trans, &data, &len);
cdda18fbbefafc Luca Coelho   2021-02-10  299  	if (ret) {
82a08d0cd7b503 Johannes Berg 2021-01-15  300  		/*
82a08d0cd7b503 Johannes Berg 2021-01-15  301  		 * Pretend we've loaded it - at least we've tried and
82a08d0cd7b503 Johannes Berg 2021-01-15  302  		 * couldn't load it at all, so there's no point in
82a08d0cd7b503 Johannes Berg 2021-01-15  303  		 * trying again over and over.
82a08d0cd7b503 Johannes Berg 2021-01-15  304  		 */
82a08d0cd7b503 Johannes Berg 2021-01-15  305  		trans->pnvm_loaded = true;
6972592850c00e Luca Coelho   2020-10-08  306  
cdda18fbbefafc Luca Coelho   2021-02-10  307  		goto skip_parse;
1c58bed4b7f755 Johannes Berg 2021-01-15  308  	}
b3e4c0f34c1752 Luca Coelho   2020-10-08  309  
a1a6a4cf49eceb Luca Coelho   2021-02-11  310  parse:
cdda18fbbefafc Luca Coelho   2021-02-10  311  	iwl_pnvm_parse(trans, data, len);
cdda18fbbefafc Luca Coelho   2021-02-10  312  
cdda18fbbefafc Luca Coelho   2021-02-10  313  	kfree(data);
cdda18fbbefafc Luca Coelho   2021-02-10  314  
cdda18fbbefafc Luca Coelho   2021-02-10  315  skip_parse:
9dad325f9d5750 Luca Coelho   2021-06-21  316  	data = NULL;
9dad325f9d5750 Luca Coelho   2021-06-21  317  	/* now try to get the reduce power table, if not loaded yet */
9dad325f9d5750 Luca Coelho   2021-06-21  318  	if (!trans->reduce_power_loaded) {
9dad325f9d5750 Luca Coelho   2021-06-21  319  		data = iwl_uefi_get_reduced_power(trans, &len);

Possibly initialized here?  I looked at this and wasn't certain.

9dad325f9d5750 Luca Coelho   2021-06-21  320  		if (IS_ERR_OR_NULL(data)) {
9dad325f9d5750 Luca Coelho   2021-06-21  321  			/*
9dad325f9d5750 Luca Coelho   2021-06-21  322  			 * Pretend we've loaded it - at least we've tried and
9dad325f9d5750 Luca Coelho   2021-06-21  323  			 * couldn't load it at all, so there's no point in
9dad325f9d5750 Luca Coelho   2021-06-21  324  			 * trying again over and over.
9dad325f9d5750 Luca Coelho   2021-06-21  325  			 */
9dad325f9d5750 Luca Coelho   2021-06-21  326  			trans->reduce_power_loaded = true;
9dad325f9d5750 Luca Coelho   2021-06-21  327  
9dad325f9d5750 Luca Coelho   2021-06-21  328  			goto skip_reduce_power;
9dad325f9d5750 Luca Coelho   2021-06-21  329  		}
9dad325f9d5750 Luca Coelho   2021-06-21  330  	}
9dad325f9d5750 Luca Coelho   2021-06-21  331  
9dad325f9d5750 Luca Coelho   2021-06-21 @332  	ret = iwl_trans_set_reduce_power(trans, data, len);
                                                                                              ^^^

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

