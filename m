Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B833BE3B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhGGHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:39:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12696 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230427AbhGGHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:39:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1677VuCR024373;
        Wed, 7 Jul 2021 07:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=aLsC26W/5i34c7x/0UQkrR6nd69Lg+K3xbaS0MzguWo=;
 b=pBBfwulWYZHqmMp5IxHYGleR/6sjuBc3JcJvmV04qmv3rEw6DR8cWINniJpPHlpOMV5c
 6k4yGoJY29JZaQ6z71nuL8DFCykysrOqooTLfhJs6h56+XQWKcVX33lANjYwQ1cW4t4R
 1iQVUN3ye1kpagmMxSv46IDZCW6fCHgd81mx3aoOxT3TrRP55xwVhJrvH/IYwUrGXkiH
 DmdbYw7uC6AXbsOY5gPQBC4ofSAgADLsLTzAhqzatFIncC/l/56kxiCEdChKAk2MbfZN
 3R5Ofy2fZdpH/Sw9BXPi2YJjzFFw8RQ8xhev4pAirTI5V9X2xgyqvcQs0TNjMY1cHZK3 Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n7wrr0fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 07:37:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1677UWOB023773;
        Wed, 7 Jul 2021 07:37:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3020.oracle.com with ESMTP id 39k1nwksj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 07:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbDZJCM1olt2F1Yd2tx+PyN/vhmhHxm8gqel4/Cqb7Bw/DmuX+iH7UbXj7ccdW30zpNemTBiJAVS/pRvTlGzzGfg2FAAfRFPcTSsb5hm8hcJX8m3w+IgGxOSKrZuOccv4RIEmVLvOAu9ts0IVsrUlsVU0s7PqnugT0s1Q7VusvpHMggdHXb6APnDDR/ozK+9gQd3f9z4qnh9+aadEcSqrchuXNxMmSMJUbKXB+dffK65izpuR7I8QcW23ZriqCI66dMUjOzrUp30Pt3QzTPjjEXvkYCS/BID/QVENlHic1xhkcKaL8qowWz2NypnCgKvKCzXXdFAQEq837DfcjO61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQaGW542T+cTUbJldgw7kkiUCvHqOMuVQpz1EiZw6aA=;
 b=eE7qBuZIvVnQUY3rcZ55Efd40sZavxAsMDxw6sfnENzJLVA5++oiHEThMTHZAONnl0UfrSGQjzP63F1huwWfWtZKOdgI06qaErVfvzztKUQ54o8NhvxPqWgcLaurKhdKBTDKOSliom5P0QaDEkzhAVdIl+EwCaApaC0COybvseP5yPNXpseY+h8Im2RpHmWilypqow9/6oc3N4K/Xtk9uHHJUybKxRGdIB3tAw3AdA1y8HQUAP97J6m/V2o/o8uxnjgYj0MgRCxwqAUF/pUidTdgekMnZU+EtqC26eGs3QJZWvWgujNkFVmcJ1nDdeL1pyHyd5ZzQADfoEFCSuvIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQaGW542T+cTUbJldgw7kkiUCvHqOMuVQpz1EiZw6aA=;
 b=GlhZHXj44BMwP4gypsNXcqFaRnjenmfhr2MAW08cSrjzdPOcopuKVQY2ex0XeRymtwltsBr7sYfSPKI46PRVWJnPVb2c6brkvTQpw+K05M3QOSp84g7vLcQeI1NlNiHr7u/Yyg1ggCT29Fk0gEDZSBqTPtZ0bxOkueojI9BQBPg=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1774.namprd10.prod.outlook.com
 (2603:10b6:301:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 07:37:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 07:37:06 +0000
Date:   Wed, 7 Jul 2021 10:36:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        =?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/chelsio/cxgb4/sge.c:2571
 cxgb4_ethofld_send_flowc() warn: missing error code 'ret'
Message-ID: <202107070458.FO35EqwU-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 07:37:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0da4cd8-427b-4018-399a-08d9411a04f6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB177439E142D668586981279C8E1A9@MWHPR10MB1774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78XVIaoYQkMIj86tONhtCiNQJzLl5JC2ePlC9uIeTtn9m0/w2hzEd3CtPZz3e+ZYdh1LuEt24gNbYvKEBbNg8ejxAql9KbM96QVUY4qtW9d+Qsd489mB297eaZ0ZIqJF6K2BBeZILYWsh+lq7d9wjRewAK3IcFkap9A4Oxm5oU0qjuAwyyuT99FV4TiYclne3vjibQCRolAH836yP1RCvcniUVRn9osmpZB0InG9gNwkCnqTdXEcS0Ipno9X7aeLXdmtDE7W7Z8HyjFF4cBwT4VRiRoM7DGNp1VGW8XiMeSCD9a4P0AIVY9zgGjieYcU93e0/ULFdAVBVM/HllV+ortGZUrBa9oo7/BtA+Z5HIvoEJQTkP4/+ioi3EBhy1SRyg6Goj9azldP5I/49rCWfTblPX678qnMBbVcmMeC6ybKRWpsbhwNWOMCDfSjLn74NTvOsDdLCLSlzdbEC215C+dr/KSsyINd6i3YBQ30rc6L6KN9kVutlqW+bKPRyusQQQHRFgVlJnVt7GUixga0Q25s767DtlZMqiFNCDyzsBCqeCJTZHAVGsref0k/Mw6W/eCc1H+xk0+mXY3Getv9tSdn83Yqr6j9kOFaYMackf99PZtOiOOr8eW+UCgmC+hdhVQzpeCzTD9ozDRMmHQtaFnYpkxrtsq5JBEkFSM1/c22++wxWlV5Ly0FAbafcUO7c+ngmPELxPE01RQSwzR4rBrRO+7iBWy/gUVWefOGZ3zb2jh4qjzcFjTFX5Zp5lKiTsCUzdv+wPZY6oV/SnA3qAlpmXyydDKKFU6k5RZBBNqtmLaSwmcSOinrbEdOm5SP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39860400002)(316002)(38350700002)(478600001)(6486002)(956004)(66946007)(8936002)(4326008)(66556008)(66476007)(38100700002)(83380400001)(966005)(26005)(44832011)(9686003)(6496006)(8676002)(186003)(5660300002)(36756003)(52116002)(6916009)(2906002)(1076003)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Lb59x89wXuCTR5RLgtTqTl8zC2YnkmHur9JwJb31F1FWtRpgEevdqG8QI0?=
 =?iso-8859-1?Q?OlzjzuidlitmLh2I2cqtXUFt6kdesEMspWv1+/2Dy3ab/tOhkHhxLBBQW6?=
 =?iso-8859-1?Q?U3VMU4QpCHV2lqOraNGPcpEGvmE38he62CbSwbmMCBxoFHTmBRIzKlsABI?=
 =?iso-8859-1?Q?GO6BS55QP0CtmOq5JZdFyGA7p6sg2tsTD+hhgLQk8FI9nDRAAPyhVuCVs7?=
 =?iso-8859-1?Q?yUR+3DvjSAcW6GO0iIArnU3zFwx1Ph4TX+YOmdr3H/nIqcu3626lFecnkw?=
 =?iso-8859-1?Q?7rYwxIj7v0BREsfcoOjs/vy+zlm+HH6kbEnK7cCqzzweWb0661/jzkLBb/?=
 =?iso-8859-1?Q?qwp49/a+R14YNnLdkJwhpg3RYzkoDy/JXsooYMaoSbi1AsaVvz4rrms+53?=
 =?iso-8859-1?Q?M3UdZosh3pOISj4E1pOmobtFG2d68/+M00zbvsPeuk50pITcKkuRERosVk?=
 =?iso-8859-1?Q?cyd02fxNP3jwMXv8yTlNxkLoDdpwrv4pZP+dr/Wy9GLomRC3CT1FDFFM5r?=
 =?iso-8859-1?Q?ALVHlrmbcEx9pl1hmAkdzUmtq4v5zmVnBMLblj4FHUIu4Dn0D/v1Eg0YIf?=
 =?iso-8859-1?Q?xxn/4tFEXPUNSvF7P20dsmiYR4920Cg7Dw9o444/BLJvVjbhNQ9Xf0B1Mv?=
 =?iso-8859-1?Q?7wsYfRLScLhCl5KskyXBr9g+krrm+IoYI00VUf2TzU+3gB19cERs0MXOsi?=
 =?iso-8859-1?Q?x9CRSMKnr5SHSRmpmVrqx02+546Xop+TbYRaX7m9R6PXssS3UlxLfyxjOV?=
 =?iso-8859-1?Q?6Ufdt2R8X1wOuEzLyQUftxa3cegaRpAJzJF5c8hPZIZc3EvJmKCKmVsUNm?=
 =?iso-8859-1?Q?g32A40OEs6yGEIbYWekZ+FSaopTMpjx/xJkJ6Y99mKMRxXgFWU4SB2pccE?=
 =?iso-8859-1?Q?afYxd3fBKD1MpKcX4eIXgfVKGyucNFXLF0z+9+Ke3QjgP/DojclkE62CYn?=
 =?iso-8859-1?Q?waN61HXzHFGLdECilEwbuI+TBE39LzY9q3sCR/2Ursi1+M+x0ToRjDSxDw?=
 =?iso-8859-1?Q?H+a9jylTizAXpbxcpmOkhMGtxiRlMPqXkKwYkS8CV6Iw8Bl3QIEcd5beML?=
 =?iso-8859-1?Q?Q5Yyt1bLakuIEIvqI+iFUqp4pAeXtclH2bhFP5qjfUQHgN6vYrD9kFcun0?=
 =?iso-8859-1?Q?8ayiS68h9vDBOUnlEXymmBTK2XCx+VS9E0zxZwtGJfnrVJu/Wygp8iSAc5?=
 =?iso-8859-1?Q?HB3IcofE3cho/VAhCbI5i695BCVXfSTi5H3jG7hJoSO9Q8Z6xVQueoZ16s?=
 =?iso-8859-1?Q?tErtxquLRstixsOkd+UG9a5Z0lhp/fBABCS50kc/VDqK8Ly/JbJKCX0xlo?=
 =?iso-8859-1?Q?vI3zP4R9ned72F1APQbleoes2QfqESrv3mMu64FU5xaVDU6jFoMOVzXptF?=
 =?iso-8859-1?Q?E4vH5+7bOV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0da4cd8-427b-4018-399a-08d9411a04f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 07:37:06.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEjWZlLTIWVVdk94L6uSLkGklDH55Ryx6BvbjrAaRGv8DYB/Q2IyAIbA5c/puTNFA/kNiSdlk/gkFqXUd/GaFiMdGlVAIziPmXcY64eihDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1774
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070043
X-Proofpoint-ORIG-GUID: hIlzOp8WZZUvquxvRLlhcoF-0jcqoXdi
X-Proofpoint-GUID: hIlzOp8WZZUvquxvRLlhcoF-0jcqoXdi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79160a603bdb51916226caf4a6616cc4e1c58a58
commit: 52bfcdd87e83d9e69d22da5f26b1512ffc81deed net:CXGB4: fix leak if sk_buff is not used
config: x86_64-randconfig-m001-20210706 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/chelsio/cxgb4/sge.c:2571 cxgb4_ethofld_send_flowc() warn: missing error code 'ret'

vim +/ret +2571 drivers/net/ethernet/chelsio/cxgb4/sge.c

0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2535  int cxgb4_ethofld_send_flowc(struct net_device *dev, u32 eotid, u32 tc)
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2536  {
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2537  	struct port_info *pi = netdev2pinfo(dev);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2538  	struct adapter *adap = netdev2adap(dev);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2539  	enum sge_eosw_state next_state;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2540  	struct sge_eosw_txq *eosw_txq;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2541  	u32 len, len16, nparams = 6;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2542  	struct fw_flowc_wr *flowc;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2543  	struct eotid_entry *entry;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2544  	struct sge_ofld_rxq *rxq;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2545  	struct sk_buff *skb;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2546  	int ret = 0;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2547  
a422d5ff6defb1 Gustavo A. R. Silva 2020-06-19  2548  	len = struct_size(flowc, mnemval, nparams);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2549  	len16 = DIV_ROUND_UP(len, 16);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2550  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2551  	entry = cxgb4_lookup_eotid(&adap->tids, eotid);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2552  	if (!entry)
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2553  		return -ENOMEM;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2554  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2555  	eosw_txq = (struct sge_eosw_txq *)entry->data;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2556  	if (!eosw_txq)
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2557  		return -ENOMEM;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2558  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2559  	skb = alloc_skb(len, GFP_KERNEL);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2560  	if (!skb)
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2561  		return -ENOMEM;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2562  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2563  	spin_lock_bh(&eosw_txq->lock);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2564  	if (tc != FW_SCHED_CLS_NONE) {
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2565  		if (eosw_txq->state != CXGB4_EO_STATE_CLOSED)
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2566  			goto out_free_skb;
                                                                        ^^^^^^^^^^^^^^^^^

Are these error paths?

0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2567  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2568  		next_state = CXGB4_EO_STATE_FLOWC_OPEN_SEND;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2569  	} else {
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2570  		if (eosw_txq->state != CXGB4_EO_STATE_ACTIVE)
52bfcdd87e83d9 Íñigo Huguet        2021-05-05 @2571  			goto out_free_skb;

Here too

0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2572  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2573  		next_state = CXGB4_EO_STATE_FLOWC_CLOSE_SEND;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2574  	}
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2575  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2576  	flowc = __skb_put(skb, len);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2577  	memset(flowc, 0, len);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2578  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2579  	rxq = &adap->sge.eohw_rxq[eosw_txq->hwqid];
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2580  	flowc->flowid_len16 = cpu_to_be32(FW_WR_LEN16_V(len16) |
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2581  					  FW_WR_FLOWID_V(eosw_txq->hwtid));
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2582  	flowc->op_to_nparams = cpu_to_be32(FW_WR_OP_V(FW_FLOWC_WR) |
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2583  					   FW_FLOWC_WR_NPARAMS_V(nparams) |
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2584  					   FW_WR_COMPL_V(1));
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2585  	flowc->mnemval[0].mnemonic = FW_FLOWC_MNEM_PFNVFN;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2586  	flowc->mnemval[0].val = cpu_to_be32(FW_PFVF_CMD_PFN_V(adap->pf));
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2587  	flowc->mnemval[1].mnemonic = FW_FLOWC_MNEM_CH;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2588  	flowc->mnemval[1].val = cpu_to_be32(pi->tx_chan);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2589  	flowc->mnemval[2].mnemonic = FW_FLOWC_MNEM_PORT;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2590  	flowc->mnemval[2].val = cpu_to_be32(pi->tx_chan);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2591  	flowc->mnemval[3].mnemonic = FW_FLOWC_MNEM_IQID;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2592  	flowc->mnemval[3].val = cpu_to_be32(rxq->rspq.abs_id);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2593  	flowc->mnemval[4].mnemonic = FW_FLOWC_MNEM_SCHEDCLASS;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2594  	flowc->mnemval[4].val = cpu_to_be32(tc);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2595  	flowc->mnemval[5].mnemonic = FW_FLOWC_MNEM_EOSTATE;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2596  	flowc->mnemval[5].val = cpu_to_be32(tc == FW_SCHED_CLS_NONE ?
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2597  					    FW_FLOWC_MNEM_EOSTATE_CLOSING :
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2598  					    FW_FLOWC_MNEM_EOSTATE_ESTABLISHED);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2599  
69422a7e5d578a Rahul Lakkireddy    2020-04-30  2600  	/* Free up any pending skbs to ensure there's room for
69422a7e5d578a Rahul Lakkireddy    2020-04-30  2601  	 * termination FLOWC.
69422a7e5d578a Rahul Lakkireddy    2020-04-30  2602  	 */
69422a7e5d578a Rahul Lakkireddy    2020-04-30  2603  	if (tc == FW_SCHED_CLS_NONE)
69422a7e5d578a Rahul Lakkireddy    2020-04-30  2604  		eosw_txq_flush_pending_skbs(eosw_txq);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2605  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2606  	ret = eosw_txq_enqueue(eosw_txq, skb);
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2607  	if (ret)
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2608  		goto out_free_skb;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2609  
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2610  	eosw_txq->state = next_state;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2611  	eosw_txq->flowc_idx = eosw_txq->pidx;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2612  	eosw_txq_advance(eosw_txq, 1);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2613  	ethofld_xmit(dev, eosw_txq);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2614  
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2615  	spin_unlock_bh(&eosw_txq->lock);
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2616  	return 0;
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2617  
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2618  out_free_skb:
52bfcdd87e83d9 Íñigo Huguet        2021-05-05  2619  	dev_consume_skb_any(skb);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2620  	spin_unlock_bh(&eosw_txq->lock);
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2621  	return ret;
0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2622  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

