Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F7428EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhJKNwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:52:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33402 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237326AbhJKNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:51:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BDStlW023196;
        Mon, 11 Oct 2021 13:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=pqSgaVjpuEQ4qshdU27k+6pFpxyYI10hDjm0N+L+xr8=;
 b=uMxS1DnYKELsYyJTiNQAJopsxRIg3zTGnKhkySOYsMSAfrrue4AvdRp20nQVKdIvsyLU
 bLELSYLHBoO9BRcRdDvUkW32FXZ+LOeuxOqLWfFqxghfgqprMJI2a09KY4BA3GQtPLfS
 f0UsVyC7TvdcmWUQSadDTsY5jfBXeL0jdNUlzpBNL16OM62oll5HDkAfxQjyQLvOFABC
 Xeb9QhjJKE527xIUqMOtTV8QdRVHNi9ttT8ZAYs3BYwj2mxfu72j9sY3xvxAS6jKHcbq
 d9dxxDPVppVt8D61GF4Oaa9rm5S/yFeaPzV2UWl6isvB3Jr6AFX123zIvCsfxTQRgkOn vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkwyumcmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 13:49:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BDif2s083714;
        Mon, 11 Oct 2021 13:49:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3bmadw99h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 13:49:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC/gWDVNJ/yboSCyWI/4MBi9wm0hQ6nGbYKglRgQpb9WN6FjAwhMNDAncNWr6c8HddAksyc/FhM8ZYesc1Gh/mb13QpbH74BAQVaPOK1WLQ0oLqw4cpFLT3T7b4OCQVI1xMrZeKJYdQWBMGMcAZdLjq3xKhTixrtWI5mYbm/MBrI4AR7u3P9AxYR7TM93f5hO50gR5afZb/FijCSpM5OS1CPtTMwCByqYPRc3VWK/w1BclqQn7Ljy47vosTf4ocfdYObPhxh+Y/M6uuXHiLXtP7/K4ITVYNbWL5n1cqx5rIjO1M1EAKiZta+ZyknTBosl/b1OgxcP7Is6hAH8EIuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqSgaVjpuEQ4qshdU27k+6pFpxyYI10hDjm0N+L+xr8=;
 b=OBNm+G4yuw+dwCNRxkMjZx0IBtfubdRqWg+M97uKdR+EfNWQTqY6toy9av7k91MuHNNC/cyx++IEUYFQ+p/UJrSCPzMlnJILeyHDCmosl8lo7zxluVJWpmkrTft6ky6EcXoPwG+3TPHTYRg86nnv/M5XvuUYluz6znYgvfV2m5jJ8UFZA1ApaW8ANtHXQY5C9Cupk3ivt5tyGWV9wZOszMZ1DQvRt30qo7qfceSAjzDPmOn9uaiilCzXO2fj/MAqBxtbi5IK4CmRK5EP/dBkxMpTFzOmhjjt6+B9xq3esfK6BDvsaZHTFQ4pPiIxDQl6X7KZhpdCdwZyy3cOuPh2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqSgaVjpuEQ4qshdU27k+6pFpxyYI10hDjm0N+L+xr8=;
 b=e0dCrk1cjG1mTMvqDNAJavr4qXUxAFtajk+DTQGyPigoB3sEeYp5lvtU7MNPi1ocEV2+8aT15F+5xl8SKPTzSoZTDEAUQbD0vKP69Yzcz7B8F0+bPkpgFR1sxMwEVgQP/5xYAaeBPCCoTvmB3Wq7rYJa1qA3LAYzwkyvA6DKIQY=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1293.namprd10.prod.outlook.com
 (2603:10b6:300:21::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 13:49:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 13:49:25 +0000
Date:   Mon, 11 Oct 2021 16:49:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [ti:ti-rt-linux-5.10.y 4405/9998]
 drivers/pci/endpoint/pci-epf-core.c:169 pci_epf_add_vepf() warn:
 inconsistent returns '&epf_pf->lock'.
Message-ID: <202110112106.CuCZQB5D-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 13:49:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d47708-a1dd-47f3-b92a-08d98cbdefa8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1293068ACAE5D568832817E68EB59@MWHPR10MB1293.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7R6Dt2uyTNuo6odRX8AtXymT7bQi/Porn5o7YVhE04bbgVwJZfjLZdAPR1Y1d1vB0V/mFyTf9z9dDLeQHgmVcw6BZKVquFBNgZeLC4fjhKaWI07utiUjQenUJlPWGm7gcmi4Yy51AidjpUbIcos4njkm8VvBzoz9EFeKBHKPGd2bjAn35POdpVVzmzNWXwdA9uV9CvCoo05wH6vvFJckntj855USaKy5xFWiwPvBkKNKU1YgYygZ+jZcRzbhlOJmDj7Ii3UBGk2/ckNsX4iK+GY0S8C78XnYdtTbRqrdFh4CowUusl5nmyqYGTljgG6DDnu3lV+VePBSd67cspdCG5rDywcwCTUJqHvRo/lR4MbBqGEjnDfXH51ImDaQfvib6HSlkkuyD1CN+cTSgfuSqdR93MswNtvbX2gBX3UNhxZL9o83YLeEdBMbrPfleh9ulHlBOEycQvxqfcWba5cgxcIv9Yy6JnoPI7AA7kKUDtxcm/JajJu7zV/ZwmfczTd33nDLm/050dg/t0ktJ891BiW8M0XmUL0aQGVg1PBOt69KHghlfh+OIB5DtVaDzqqWSIVLRIchV/SWGbys6MVSTToVGbNeVPyD58S+zXet7AYgmzUPYwrQToPxb7/dYA37PSEtIRHR09rd8+pqUViNAikPCZdc94pdkF0PkX2g8Of2iswr46y4rYG/pF9IXHwXC2BakTYcFAE265bO+38PO2/Htt4So5tHoaUH37YO8VicnSwguwGVlBoRXOLMtNDB1VAwnsBkjvOtMTqk4DfVnejNUWX05NTR1KcRhaQZno=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(6486002)(36756003)(8676002)(26005)(86362001)(186003)(8936002)(52116002)(966005)(6496006)(508600001)(66946007)(4326008)(66476007)(66556008)(316002)(9686003)(6666004)(6916009)(44832011)(956004)(2906002)(38350700002)(38100700002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qmQoowxni8CJSjdvzozYArAnsWKgFNFtlg44a9L8ZG2s9kzgeyzuQmXCNJ0k?=
 =?us-ascii?Q?mpQsgMHIJbt0wNFWrpRM507D1PxX+YlV/wKslmIHC5ZneHtKvzSa3Sjz3Pl4?=
 =?us-ascii?Q?8f5411hrx1FLBKC7VyyPfY9c0ORh/ixtzOvQvUKMkZgfVnmQO9bt4rcoytlQ?=
 =?us-ascii?Q?AJNYSZx8N5WWKyd/Jus+uIigoZ0FUhfSPE6PxqpzO9WMB7DCm3wWKE/TVnNm?=
 =?us-ascii?Q?n6zfY6K79EvAo3/AckhpaTgYw0EoNjc4+GNtlKhBwdav3TjCnPVMGdPUacJN?=
 =?us-ascii?Q?ftB4lzbB5JlFefHMP4rU82g7RTd9AKprUriF4VvEmPeXX8v4luB/hnObt1TB?=
 =?us-ascii?Q?HX7HVJ/gr4yiFzTi+R17Gqd9CT7rb0HTs82AR0vr4bhJGt3a0Woj4qhY0xou?=
 =?us-ascii?Q?2yH8si15QYISbavAhQcGFRs2Z8WqK7UdMLyetgW6vPnHxv9pCpNm/0UIJsep?=
 =?us-ascii?Q?X8W9gZlqEQMviKjRSofdrl8ZgIrjB1yEcUi45uTiauIlJ6SeCYRUKnAbWofv?=
 =?us-ascii?Q?X3eDc+xDuTIWbhh00MpmMxGJ19h0c3yjbU12hP+8LNcNYZ09m6HI5pN5jWzu?=
 =?us-ascii?Q?QFdWBN60YgBSjnyk9wLFXflZo+mDPssQaPkkQA1qXG/BpNW/PebHTNCtuZQR?=
 =?us-ascii?Q?+LX8+P0Fx65WkAXTwN76GwxmygMp11QtuWGLTrYI8e4/Zlvrk1jXvelPFH6E?=
 =?us-ascii?Q?FqsjreBeJBYs610yXk3Xq8UVi+O0vTxgimU3WCgfzB3II12XS8cSga15EVjp?=
 =?us-ascii?Q?o8qVqfFyrsW+2HnSBxMCnjTx0fBlBYi4XKjl57ky37NfU5gXNm30m7171I81?=
 =?us-ascii?Q?5mkeUszU779vn1tBWG96UDNAJzqDIMlQJOiedfntulKoAhWHn1UVJcV+8A8z?=
 =?us-ascii?Q?Xv8QykZ8FKF8qVZybe2DsHyjIsTaACfm1eG/d8pDP56/wxUOrUsVMdhUhYMS?=
 =?us-ascii?Q?wn0DxfTQnKGq5jreKmoPa7AA1sstcfVg1GBYGJ+A+HX2lCyoJBEQw3eu9OaQ?=
 =?us-ascii?Q?n4xiFDpuuSs+oW/yUomfZB92pFS40MvR1PUJxfAU4Zg6XloU9/4qnuHRHlRU?=
 =?us-ascii?Q?X2zvrSthFIgXnGSkFwhv+GBuuqsqJpGLrRjd62yKAyd6t15wPnVEANpmCoZs?=
 =?us-ascii?Q?Ughh4AqvNr2UiovPVV8yTdlFgThNnbfk9VrL6QvlWkN5PWYlpepR2YLysJI/?=
 =?us-ascii?Q?Ip28y4I9RFAczvdlBPfZxFNgL75HbIMKb23ewWNd8w3DnDeo7l/nvHplSqWl?=
 =?us-ascii?Q?Pnxaas5LFiVAabIyiLi/zjTtC3oTwYlMBqIiQ/jjF+8AGewoMDydNQjd7V6Y?=
 =?us-ascii?Q?W/NZ2ujSjhWX+T3nkViJUwUx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d47708-a1dd-47f3-b92a-08d98cbdefa8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 13:49:24.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3bv29ejrZe2EwggSJuuJZkG1QkRQprxzXr6i7HL1wZs5/nLlsQGV9yxEAY06qmTMpV9zHuZxFcTZlWWRNLjvLKsYpreDw2FlxlI/zJ7JOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1293
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110080
X-Proofpoint-ORIG-GUID: F6lIlnPh9scFFUuTqbJgFC33jjn4NY1k
X-Proofpoint-GUID: F6lIlnPh9scFFUuTqbJgFC33jjn4NY1k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git ti-rt-linux-5.10.y
head:   7ff055c5f01acc96255948cdd632c72fd78a1f72
commit: 0cf43e35b1743dc43574089fcf3ff71d8cd2ae39 [4405/9998] PCI: endpoint: Add support to add virtual function in endpoint core
config: x86_64-randconfig-m001-20211011 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pci/endpoint/pci-epf-core.c:169 pci_epf_add_vepf() warn: inconsistent returns '&epf_pf->lock'.

vim +169 drivers/pci/endpoint/pci-epf-core.c

0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  141  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  142  {
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  143  	u32 vfunc_no;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  144  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  145  	if (IS_ERR_OR_NULL(epf_pf) || IS_ERR_OR_NULL(epf_vf))
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  146  		return -EINVAL;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  147  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  148  	if (epf_pf->epc || epf_vf->epc || epf_vf->epf_pf)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  149  		return -EBUSY;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  150  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  151  	if (epf_pf->sec_epc || epf_vf->sec_epc)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  152  		return -EBUSY;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  153  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  154  	mutex_lock(&epf_pf->lock);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  155  	vfunc_no = find_first_zero_bit(&epf_pf->vfunction_num_map,
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  156  				       BITS_PER_LONG);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  157  	if (vfunc_no >= BITS_PER_LONG)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  158  		return -EINVAL;

Unlock before returning.

0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  159  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  160  	set_bit(vfunc_no, &epf_pf->vfunction_num_map);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  161  	epf_vf->vfunc_no = vfunc_no;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  162  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  163  	epf_vf->epf_pf = epf_pf;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  164  	epf_vf->is_vf = true;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  165  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  166  	list_add_tail(&epf_vf->list, &epf_pf->pci_vepf);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  167  	mutex_unlock(&epf_pf->lock);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  168  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30 @169  	return 0;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  170  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

