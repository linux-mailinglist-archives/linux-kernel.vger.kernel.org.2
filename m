Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441093BE3E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGGHtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:49:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47286 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhGGHtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:49:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1677ku6U032373;
        Wed, 7 Jul 2021 07:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=+8nxdeoWfHjCDq7M5BT6t+YYkMNwX4Cl7X7UB0Vf/UM=;
 b=OkBDCW6P6TJ+UOEA42R1a9TJuG+RO4rZZ0kcjfqBkGC/+B7joDskFlsAxw6iiP04kksY
 6sq5cV/8jEt7I4MjzGmGugImhVkjEff0/VXTp5tNCULyg0qvbMMD2cWCXwCJjkLV24kw
 HCEbZCHttfWZglQHqpdTpydaxICjXNyDiAZw/R05tB4eBBLqtiJLbpZpM/6GMpGACqZH
 Bud2Dwcit0keKkLqK19Ve4LU5+/mXE3PkhfnvJmkPj4KOu3urMr62y0jizrZBBSj7or9
 U2cYwaA2GXbZQZjv9rDk0WfIu0xao3qF/OAyIq1n2JtkNSmPm+35zpRayKVqAmU0IT4Z cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m2smkhan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 07:47:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1677kXdK191520;
        Wed, 7 Jul 2021 07:47:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 39jdxjp6au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 07:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX8n5sOdHQcXoVSgY5vPljdVfY9/egBqCPE9a0smphTokh4oC3mMbt7X5WWg+T3jbogmQqHbaAaeMNzePWBCltGT/KI5osKxjnyiBQTu6+fJRt62qDFHJ6VyKQimZP34vFKGflN5WLhymiSVk9wKUV6Lwo4N6Bxz5Qm34MFSqiWN3pkxu3DXT9OmDybnEn0IzBatUzkwb/hzE8BvpA/yBpcz17/VXfywdbXwfuvN6zqD7vzmOSXjBAyGBUF+JAYZ9hW/Rxr1VWy1MPO7nL+TsdEeSOqsykoFOa/0VP/mTTHZzoDXN45Ux/qXb7CH0/ka8u22bytGKlVM7FWhfSwrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8nxdeoWfHjCDq7M5BT6t+YYkMNwX4Cl7X7UB0Vf/UM=;
 b=RLBhcn/A68LpqS0JjCzFL0bFnRCmGgZ0WIOn8jQRuWcCezm9WiBBb3rpUZFXqB1u6isw6Ax4HNMcK8ikcRNbMmWM/h5T1NOA5u1bYIPFUP2NNHlOYZ4PrnaMfvITeSd4ElQsJqImG37AqD+myzBuKQ+x29jlYhz10V/53bl9+mOKG19mbvRBCBd8LxR86goLAnoE5kQT2TckvrczZg12IOpH3TFm8tQFEnpRjgp/UesuRBAuUdq8YuR4Qm1X15bxlmkn6rccTCMImVwcADtb5La3cf39545DuXNk1ZILoG4eH669EvXSXJ0RtXclemGS3gZTDTib7/7VtrC4yk32bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8nxdeoWfHjCDq7M5BT6t+YYkMNwX4Cl7X7UB0Vf/UM=;
 b=rWr8ukLyUTfJR2HA7fRZszHnPPStrU5k2WhuAD2cxPRqslfi5K6od/QTWXZwG6IWbb6g5W422yh/aoERnLprUDmFBMMp6ApcaLVwUoqpISfPChH8D1Yzgwo7KK7pus1vH3w2SMDpuFVlyZfuG2D3EDu2zNify5i1ZMtEpyHcx64=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 07:46:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 07:46:57 +0000
Date:   Wed, 7 Jul 2021 10:46:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luca Coelho <luciano.coelho@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/intel/iwlwifi/fw/pnvm.c:332 iwl_pnvm_load()
 error: uninitialized symbol 'len'.
Message-ID: <202107070630.2Eb1dSqF-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 07:46:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ae5f87-627d-43ff-0d35-08d9411b65ac
X-MS-TrafficTypeDiagnostic: MWHPR10MB1774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1774934365A1D940CB4575DF8E1A9@MWHPR10MB1774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek4mDuWaRT5Orplhw2BUjutoGL6ZknRjokcCvVNTnE5kZ0OhMH1HlhxopCgOw7n1Ab1fFvm5gP7m+oiP2EaZsKOZxK4XmZ0Z5MgejbrM+4NqphkFNtv9HJlE6kWubQ++cKBkfWxCAFYYPs3Q6tWI1tFl/WwS4o+fCe7+D9Xizqn2KhlV5Hg7ongYy/IFXEWOO9GrjlR/khSQ2NPIhBEkA04NpEj9g/fbPZVL8dyIhrqF1jvVbk98x7xZNqAo3cQrPNDJSZ2onAkkAIf+n41iokx6lQ0TpqLplCUmQUXcpOWB+TIJGcgxKh2QwWQCIa2u2/EVPzhwucZxyc7qT4Ie6PcGEsaMDCCD9u1eckSN7a6azbRes0UR0mWAsm0SSbphixHHwFBaUv4PJoszd/s3hbvQdB8Cr8Hc/Nxa49mgdXqRyB3H07ULO2GlpEwyP29zAUsF/nw7M6Wg7jdAxFO8Ugd6hbF9T0dPBwN7/z2ffJZjXsvEbLDnbmt/ZQai1sFCGsaIFFciBS7ucGls9WftQ2V4UY9G0tO1K7yQJ2mO99PA11TwqLNfbgs2M7C5mePjb0OuMbTeX+dCbQV7x+onxy/r23RJjj/NUw5gN+Fb2G54KzgfxlGrQt+JdmNJeq10gZhdEhaDaWsONF93tPFIZEKJJLr0hfP2r4sN4kzdRWLJbJDBTNPQSbV9c1Yvr/qk5A6RPgatEoFuNqGXJvvfT4iukvVCCC4CIJCDec6qnqe3f4k1gA0nexsluQO/gb5CTW8zQi2HBX4TlmsP7JcQOK5iSpnsz0fihu11a3sl6cwyh0lgraXpNw+MM/PxlxIV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(366004)(136003)(8676002)(5660300002)(186003)(36756003)(44832011)(9686003)(37006003)(6496006)(1076003)(86362001)(2906002)(6666004)(6916009)(52116002)(478600001)(6486002)(316002)(38350700002)(38100700002)(83380400001)(66556008)(66476007)(26005)(966005)(956004)(8936002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NdXjwZucSiLP+WZIg7XoMwSwgvv6pAhkzLnw8WuON2gffy67Y/OA4MqrACOa?=
 =?us-ascii?Q?vn+3juA4c8Ei4fOZNzWqH06MzKCYo7YDk+dzdiKwM170knIWO+daM+M2ZD51?=
 =?us-ascii?Q?veL0rTSJvdNv1mIuf71TOmUEW986XNU0XQ78JG+m1F8Pc8GHvSA+w/LRUC9r?=
 =?us-ascii?Q?cx8elyHF7D13fJKOorzNvbDsmcJMJATMYu88weazbIzfzUYjZ+Hdoy0P5Z8k?=
 =?us-ascii?Q?WaR779uzWVSnZm+Kh37VVsBMt0aDqMtJ5gS0zh303L3gRBF+oGU915zbw6qT?=
 =?us-ascii?Q?y5Oz4BpxVCQIFmFY4yjDj1fH5kQhqit4j6VwOxg9qWjoV2N6lX+WKCz4L7Ku?=
 =?us-ascii?Q?7s4UF7R6Jf8tpU30WRR/8+ChcHj96ol47GQRNIiIN8Usk3s3jtOst7Voj8u6?=
 =?us-ascii?Q?A4bxGdo9bfGUMED/wk0MxxsuJUE90Asqx61ePhbjDHCbgwT3bO9vkgk8pp/U?=
 =?us-ascii?Q?JdlsBn6hSn4TtlGBqk7LKAU2a8EtnfYI0RcjRlZgXVLG3cHnaHYDEI0Z2bE2?=
 =?us-ascii?Q?M9thZ+41XrcHEsqRvaTCpRNNBreh0JuAmBRjFtp6ObPFkIZY19KbFruYQThS?=
 =?us-ascii?Q?NZQNt3VLk3kBn66K1Y3mlPV6KmV0S722AtLpsXz5RscnKfS5DvAaWdOKX87P?=
 =?us-ascii?Q?Gjt7Z/MYpFx9GF7rp9u6V2TkTKC4ILnGXs44/PkANI6iRTwELs+TWsbsTzub?=
 =?us-ascii?Q?s+wyPOYhm3AaxBcBT9/sXXqVWVst1KgAKHu2b2kl646FLFxKmpEIBbMCUmda?=
 =?us-ascii?Q?zbwlkYSLQCvUIbTCHMHpUZj6PIUtrsZtJ19EZzOzollUeX+MmJgf9nuXOCBQ?=
 =?us-ascii?Q?i7euJ+BkKzYjIFFbSUvPwpHq0K5oxL6mfXm2nEee7C+lQCUCUs3RhLe+N/fK?=
 =?us-ascii?Q?cnq8pi1v3VRLUNZRSBGSuDWfrh+uSc1Kyh8cHelw2/NSgIuRozsQFRnJ6/9w?=
 =?us-ascii?Q?mQ7wbE/UW2XBQKZTD7Bd6WwtBc7NKzOrfvBIumrHn50wuRzgK8KspktUhpVR?=
 =?us-ascii?Q?wsUTJbylz8Pr6r7me2A6e/DAv48TWlxn1M4wvDXDkX1kVhekq+xzw2UZJ3Ys?=
 =?us-ascii?Q?6LYVZMpWMGeuc11ZYVfnZ/EBXYjYMGXpMC0Bhdj3FBJPlp6eonczGqbAKkC+?=
 =?us-ascii?Q?YCQg63Rup7pVyQHTFGI6e5Sea0/VJOsxZZdOCODwr+oTb1tWKRq706vu2OPR?=
 =?us-ascii?Q?tEMPPb/6t0BnzwjE4cuESXnhZVYB4JXNwOqbXpFwnLsPabL/kp1dBzZPp/S6?=
 =?us-ascii?Q?Q6a2kDNMFKhFTuO1UHa24mPVUJTvol5WEMFiuB6YmUnkxqlhT9ks0kD3nBEL?=
 =?us-ascii?Q?n0ViPfTDZBpxkEiLxPQ7+8+6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ae5f87-627d-43ff-0d35-08d9411b65ac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 07:46:57.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vm96QSbL8rNpHsnmzya+BG3sUzW1u49iI6NQMno966ay5MRbL2m+GwOi1olTLpGb3td9/vU8hOXGeOE3JhXyF+4tVfLzSZZ93tvTtfepQVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1774
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070045
X-Proofpoint-GUID: FzHAM45cK4ngyzQliUXot6KiS0hJB8E6
X-Proofpoint-ORIG-GUID: FzHAM45cK4ngyzQliUXot6KiS0hJB8E6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77d34a4683b053108ecd466cc7c4193b45805528
commit: 9dad325f9d57508b154f0bebbc341a8528e5729c iwlwifi: support loading the reduced power table from UEFI
config: x86_64-randconfig-m001-20210706 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/wireless/intel/iwlwifi/fw/pnvm.c:332 iwl_pnvm_load() error: uninitialized symbol 'len'.

vim +/len +332 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c

cdda18fbbefafc6 Luca Coelho   2021-02-10  256  int iwl_pnvm_load(struct iwl_trans *trans,
cdda18fbbefafc6 Luca Coelho   2021-02-10  257  		  struct iwl_notif_wait_data *notif_wait)
cdda18fbbefafc6 Luca Coelho   2021-02-10  258  {
cdda18fbbefafc6 Luca Coelho   2021-02-10  259  	u8 *data;
cdda18fbbefafc6 Luca Coelho   2021-02-10  260  	size_t len;
84c3c9952afbf7d Luca Coelho   2021-06-21  261  	struct pnvm_sku_package *package;
cdda18fbbefafc6 Luca Coelho   2021-02-10  262  	struct iwl_notification_wait pnvm_wait;
cdda18fbbefafc6 Luca Coelho   2021-02-10  263  	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
cdda18fbbefafc6 Luca Coelho   2021-02-10  264  						PNVM_INIT_COMPLETE_NTFY) };
cdda18fbbefafc6 Luca Coelho   2021-02-10  265  	int ret;
cdda18fbbefafc6 Luca Coelho   2021-02-10  266  
cdda18fbbefafc6 Luca Coelho   2021-02-10  267  	/* if the SKU_ID is empty, there's nothing to do */
cdda18fbbefafc6 Luca Coelho   2021-02-10  268  	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
cdda18fbbefafc6 Luca Coelho   2021-02-10  269  		return 0;
cdda18fbbefafc6 Luca Coelho   2021-02-10  270  
cdda18fbbefafc6 Luca Coelho   2021-02-10  271  	/*
cdda18fbbefafc6 Luca Coelho   2021-02-10  272  	 * If we already loaded (or tried to load) it before, we just
cdda18fbbefafc6 Luca Coelho   2021-02-10  273  	 * need to set it again.
cdda18fbbefafc6 Luca Coelho   2021-02-10  274  	 */
cdda18fbbefafc6 Luca Coelho   2021-02-10  275  	if (trans->pnvm_loaded) {
cdda18fbbefafc6 Luca Coelho   2021-02-10  276  		ret = iwl_trans_set_pnvm(trans, NULL, 0);
cdda18fbbefafc6 Luca Coelho   2021-02-10  277  		if (ret)
cdda18fbbefafc6 Luca Coelho   2021-02-10  278  			return ret;
cdda18fbbefafc6 Luca Coelho   2021-02-10  279  		goto skip_parse;
cdda18fbbefafc6 Luca Coelho   2021-02-10  280  	}
cdda18fbbefafc6 Luca Coelho   2021-02-10  281  
a1a6a4cf49eceb3 Luca Coelho   2021-02-11  282  	/* First attempt to get the PNVM from BIOS */
84c3c9952afbf7d Luca Coelho   2021-06-21  283  	package = iwl_uefi_get_pnvm(trans, &len);

Let's say this fails

84c3c9952afbf7d Luca Coelho   2021-06-21  284  	if (!IS_ERR_OR_NULL(package)) {
84c3c9952afbf7d Luca Coelho   2021-06-21  285  		data = kmemdup(package->data, len, GFP_KERNEL);
84c3c9952afbf7d Luca Coelho   2021-06-21  286  
84c3c9952afbf7d Luca Coelho   2021-06-21  287  		/* free package regardless of whether kmemdup succeeded */
84c3c9952afbf7d Luca Coelho   2021-06-21  288  		kfree(package);
84c3c9952afbf7d Luca Coelho   2021-06-21  289  
84c3c9952afbf7d Luca Coelho   2021-06-21  290  		if (data) {
84c3c9952afbf7d Luca Coelho   2021-06-21  291  			/* we need only the data size */
84c3c9952afbf7d Luca Coelho   2021-06-21  292  			len -= sizeof(*package);
a1a6a4cf49eceb3 Luca Coelho   2021-02-11  293  			goto parse;
84c3c9952afbf7d Luca Coelho   2021-06-21  294  		}
84c3c9952afbf7d Luca Coelho   2021-06-21  295  	}
a1a6a4cf49eceb3 Luca Coelho   2021-02-11  296  
a1a6a4cf49eceb3 Luca Coelho   2021-02-11  297  	/* If it's not available, try from the filesystem */
cdda18fbbefafc6 Luca Coelho   2021-02-10  298  	ret = iwl_pnvm_get_from_fs(trans, &data, &len);

Lets say this fails as well

cdda18fbbefafc6 Luca Coelho   2021-02-10  299  	if (ret) {
82a08d0cd7b503b Johannes Berg 2021-01-15  300  		/*
82a08d0cd7b503b Johannes Berg 2021-01-15  301  		 * Pretend we've loaded it - at least we've tried and
82a08d0cd7b503b Johannes Berg 2021-01-15  302  		 * couldn't load it at all, so there's no point in
82a08d0cd7b503b Johannes Berg 2021-01-15  303  		 * trying again over and over.
82a08d0cd7b503b Johannes Berg 2021-01-15  304  		 */
82a08d0cd7b503b Johannes Berg 2021-01-15  305  		trans->pnvm_loaded = true;
6972592850c00e5 Luca Coelho   2020-10-08  306  
cdda18fbbefafc6 Luca Coelho   2021-02-10  307  		goto skip_parse;
                                                        ^^^^^^^^^^^^^^^^

1c58bed4b7f7551 Johannes Berg 2021-01-15  308  	}
b3e4c0f34c1752c Luca Coelho   2020-10-08  309  
a1a6a4cf49eceb3 Luca Coelho   2021-02-11  310  parse:
cdda18fbbefafc6 Luca Coelho   2021-02-10  311  	iwl_pnvm_parse(trans, data, len);
cdda18fbbefafc6 Luca Coelho   2021-02-10  312  
cdda18fbbefafc6 Luca Coelho   2021-02-10  313  	kfree(data);
cdda18fbbefafc6 Luca Coelho   2021-02-10  314  
cdda18fbbefafc6 Luca Coelho   2021-02-10  315  skip_parse:
9dad325f9d57508 Luca Coelho   2021-06-21  316  	data = NULL;
9dad325f9d57508 Luca Coelho   2021-06-21  317  	/* now try to get the reduce power table, if not loaded yet */
9dad325f9d57508 Luca Coelho   2021-06-21  318  	if (!trans->reduce_power_loaded) {
                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
This might make a difference but I Smatch wouldn't be able to figure it
out.

9dad325f9d57508 Luca Coelho   2021-06-21  319  		data = iwl_uefi_get_reduced_power(trans, &len);
9dad325f9d57508 Luca Coelho   2021-06-21  320  		if (IS_ERR_OR_NULL(data)) {
9dad325f9d57508 Luca Coelho   2021-06-21  321  			/*
9dad325f9d57508 Luca Coelho   2021-06-21  322  			 * Pretend we've loaded it - at least we've tried and
9dad325f9d57508 Luca Coelho   2021-06-21  323  			 * couldn't load it at all, so there's no point in
9dad325f9d57508 Luca Coelho   2021-06-21  324  			 * trying again over and over.
9dad325f9d57508 Luca Coelho   2021-06-21  325  			 */
9dad325f9d57508 Luca Coelho   2021-06-21  326  			trans->reduce_power_loaded = true;
9dad325f9d57508 Luca Coelho   2021-06-21  327  
9dad325f9d57508 Luca Coelho   2021-06-21  328  			goto skip_reduce_power;
9dad325f9d57508 Luca Coelho   2021-06-21  329  		}
9dad325f9d57508 Luca Coelho   2021-06-21  330  	}
9dad325f9d57508 Luca Coelho   2021-06-21  331  
9dad325f9d57508 Luca Coelho   2021-06-21 @332  	ret = iwl_trans_set_reduce_power(trans, data, len);
                                                                                              ^^^
---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

