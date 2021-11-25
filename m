Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5245D502
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347895AbhKYHBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:01:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58782 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345544AbhKYG7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:59:13 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6E4AS016279;
        Thu, 25 Nov 2021 06:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=c4gx2NzKpSpuOcMHgkhyJVgSus2XtIVS9xEZq2s8gxE=;
 b=rKZXUNrYrbEvCM8h11QRmW1tlkGZXz72PFAPLWG7BhWHQViDTuYpdDxAdY2rwXmYWIj8
 +v27PlGwpPVrTkhFDUi0r/xVUY0AVUzQp5Gvfj3u/khwcLdGJ6vcnKd74SPXf7bsZz0e
 p3pwT1zBtsUeuge7fwdRAk1sH+0uQ6RQh+/5sjxpulTJYruNk6+nfgdJ1c4v9vlyjJAP
 A1alRJh1Kq2S67HNOx6MaNxg4l28tBPB38OwTmv76F7B8sAVnzolL8tSxVhYU7eBKXjl
 OWdfrvs9vqBTf6knXHByFLQQgVeROUlpSdx2ZFP40nXt+scEY04uHjxUaqyzBpvBR8CJ Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chk005g26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 06:55:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6p4wP040401;
        Thu, 25 Nov 2021 06:55:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3cep5321jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 06:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8/wmpQFg90dh5kci6wW/xEoIdwhg+jJJWwGPWy6pTlClUkfSe5A30WvEHvjiYpQwyu0xvxoNjfpA+Fi4KsURuPfhOAHAYf2Iq+XPyxnRfs56EStqvn8NAnysZIUEOLqjOb7ULe6SZmhxxOJouVDuJXIDP7llq/+pooHjg8pGpNuYPbIKWm/gcVstb/JoLjGwPTX/bPlqlwqEMdPnj0H2PUTrb6fVxzO+BElO3Aetmi2thnU0hLmREiktLDT/Hs8e9NdwCmMKPIjATW+CTmTbIejNKl1NEOedMEAO+wz2pA4rjjKEUK2gGb9G1JNjdbqFmZrSk5rPR1CZtQAMcKjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4gx2NzKpSpuOcMHgkhyJVgSus2XtIVS9xEZq2s8gxE=;
 b=CAHfgO7IOF3GhK4YmQWP4WuU5WppJNdrzHXrUIf6DRgXBp6VTheCUFY4U2Z/nIXIJ9D785gx28YlmR10qswA6ixFmjlJeOARO2Cpt8/kzfS6BpQw6hJybGmgO2Klkafs43ueBeW/9eXAyfKQwenzKofRtoXLQtiAxzT8nfTiiF94h47K3ktarG+fKXIECQaIXGYxje3TF87OLju3Uwb8P76Ba/WnnEzIvkh4S4jvgnGKWnvdgmBufhve3pgJlcvKuDvuDcswY7NXpyhSb5bN4G6JNNiv4YJuWtq/xRUHh85z/12MFYiJvPGyBpMWVwJ3+Ezp35EbKT1YOJs+OLBizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4gx2NzKpSpuOcMHgkhyJVgSus2XtIVS9xEZq2s8gxE=;
 b=RraNHVf11iNU5tilSfFnjveIDFSI1ZkTzsz0Adr21WcwTLDMnn31jQDtnO31K5nwT00TOfkhwC6NlBjvMcRJsV7hlFSSon3Er6wUOp+mBMZ7+DiWrwzidO5qmsW/qYH28uUSwjl4vMSnopx1P81ZMLCdkmuWwukq2SmhfCaEPCc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5789.namprd10.prod.outlook.com
 (2603:10b6:303:140::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 06:55:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 06:55:54 +0000
Date:   Thu, 25 Nov 2021 09:55:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ambarus:spi-nor/next-clean-v4bis-sent 19/24]
 drivers/mtd/spi-nor/core.c:2720 spi_nor_init_params_deprecated() warn:
 should this be a bitwise op?
Message-ID: <202111250118.loeFlVbe-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Thu, 25 Nov 2021 06:55:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d257034-297f-42da-7f4b-08d9afe0a034
X-MS-TrafficTypeDiagnostic: CO6PR10MB5789:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5789BAC7F27D554787813BC78E629@CO6PR10MB5789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpSZ7w0eSYcXheM7cv0AeisCny9NuWgw9PJdcqAk6NwpqTjsceJmS53vuGtfC2wXPNFcjvf67RNaofet45ZOjplFY9EUUqV1zNro9aCOItsVuvqphEDTbulPTLykWtlnEUSq9ywwPX5nZxPsh+9mk2WC3n+glS5C6WxMasTcCH3GuNRs7iNjA6p+vlvUn0t/b/hZ2pkTgPcslC8IAsatJr/vAN/BKAHldIfEI+XcNYmJXTU4kCCNQkg6iTG/MJNvOCYe/afcf6gAWPHIWl3gXezLF5tn5C/oQ1Qe0cgqsTpMikGTUDjGwHt/2nUEEAIuy6Kv+WLak66V740VCPe+LcV1FRscdbHTPlYScpth2/RY4O5eHXrykC8tD7d1Okq+npk/QZdTPP7oQDP/0JiND5dj38FlJXIl0cs+2yfOF9K40+pmMhLoX7AqcNSbRPn/W9Pf/yy1WJae5X9g+1Sc/KUjMokf/RGIo8IQ+r9bx7bM4UuX1z1CSa0FllFEsxxeQSpSIL3aLY89GQvl9fhTEJvXHAVoOogbJscOF+8BWwjQyfwb2UZdg1pq7Ru4ol0BswkZc6BXiauanOzc+bkiuj7DcG8V6LCnJj41RBeAVf7Y/5N5H93dncgPKDmzF32aHmJH1BJR+1vmR9Ct27VzLAfAt0LRQZyYf+Adf5pHlY2MG1Qq1u1kZNXIU8BQqf0qu0c1k4b2sum22W9VJa95Sgq0MiNYWc9H0QBXDB+c5tloBV8eOuapGQ7ilKMBXC4q/G+tQc61jI0mPBTx0zcfNUMs1Qe22N9ny6gACDG7I45oICG178tVODx7ONP+aMdf97Crs4cK9cKFkru8RurhTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(4001150100001)(86362001)(1076003)(6916009)(66556008)(66476007)(38350700002)(6496006)(966005)(956004)(66946007)(26005)(83380400001)(186003)(36756003)(6666004)(2906002)(38100700002)(8936002)(4326008)(52116002)(8676002)(5660300002)(316002)(508600001)(6486002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ADZMTiR2NUWTVfHhRyOuaJvZBtCBMBGYihycBRimuB5trTGaYWYZwQytqVAV?=
 =?us-ascii?Q?0v3x16Lj/PVXTtL4g2uLYa1MYSv9Zcf8mELK5eo53kX4Whj8ETIsU/7Ftq9k?=
 =?us-ascii?Q?NxnnRMmIuy/6ASJVCcjtrMKQPKfMBw24KiHlp+pzPTqqlA0fdG+vrnUd1LqG?=
 =?us-ascii?Q?L3LdfkLZSF3IxfhR2r6mg6DH/So5i1yL8vBRI5R+fXUmKKnw8OAQjPBi/oHW?=
 =?us-ascii?Q?1hY8FuDIyM2mUNwFt9RjI9x0REAJOOZiS/X7tk5CFtusR8n4BkafVW0aJBuE?=
 =?us-ascii?Q?G7gYBQ6VHDOKMGL99rd9MOds6MtP7WYUQgYbmgBDmTx9VOhFb0kLK0qh/i4R?=
 =?us-ascii?Q?ZH+ZUeiNKclSVpVMg234k/H8hBRlVTyL1w2PU2IxQpZx7kby0stgohLGkSSO?=
 =?us-ascii?Q?oFRY2x11ThJYDViG5cmO2KaxV9l/XKTrgKTKUrbFwrgrfeAUdUfOABTtvOaS?=
 =?us-ascii?Q?a5lhyatgM0QvKWy7LrGY3whvH+rQPvpU1o1d94NYsyWEu4WIwYK/E5yHWbho?=
 =?us-ascii?Q?YYwtkmqR2pFaWxMlkq+xxNZemK4PqueSweCSkP2f44sd6BUyYXfjtEXsRGlj?=
 =?us-ascii?Q?dyH9KceHtfVr3ofUuqhzFiY8R/XFiOq0r7sI87ZCM7DMrDBAkuSSPpfTDFnW?=
 =?us-ascii?Q?LVk/39ARryGx4lf/4U3qrwvZI+ad6StDxeiS3YS/clH4FrPLS7NOEsIfH81Y?=
 =?us-ascii?Q?tvxsX/0+rLFvkc1EiDWXdQirIQKdMO/7xOccYAgNc9XQc36Za1APhSggqUBE?=
 =?us-ascii?Q?FVEgEHVFrSOLDupLnFtA53YF9cnl9vW+AGH2RGdMQksAqoi37eWwazzih175?=
 =?us-ascii?Q?Ez7f+eM+IhIuu5d0hhTigOln+Vbu+cUjbCxwNRcpCLHgE4iEwYK94C3apaTN?=
 =?us-ascii?Q?mBIaGsZ1OJ1GX9QgMg0CK2Ehr/IkN6dMPqxJ4NDOvxIMeeSEx102JsRu7aOL?=
 =?us-ascii?Q?tV45IKCATITvVaUZRJYBEgunQzrhK9pzxE3QQPZYWZjMxTQNCIZ1XgclLDdr?=
 =?us-ascii?Q?ppZTDGFXO8Mt5K1MUwaClu93kcccCY9S5c2AgFD0g7ZcweSv1Ewc1Ol23en4?=
 =?us-ascii?Q?yuwLSm8qYFFttaTdWeUsedbckDjNArKKXnL/4ztlbP1mZepLL3724+/BTBKA?=
 =?us-ascii?Q?6b1CUNWZbKqu4rB0bT5VKKbAA2qN0YO26HJKWD8V9SfsdkVzxg0awhAvRtDc?=
 =?us-ascii?Q?o1D3LkVZWKAs8EQZqe6lmRqnu6nEGabRuYQ8iqBXt9YQFowRbaLLjTgcpA03?=
 =?us-ascii?Q?NGgnT+KEvLJBGnpATbJMpw/pWsDH6xy0FDxRjm275mpDtrFeVNQzo5QbHcI8?=
 =?us-ascii?Q?DOjj4w8ZW8cxliMZvNVEEqyPmBa9VSAwhFtBXSjaE7Mlb466KszpEU5lYR/s?=
 =?us-ascii?Q?i74IXvEeWIhdqbLXpJ0KWJdFA6lUYKNjkkYhzEUf8yOYGZYrhbOhH5TYYkEp?=
 =?us-ascii?Q?amSnF9agGPHxzorcmZE6mGUULNu/h9kfFGJXuBAmFn8Ga3yjp7XaG9s2MgQW?=
 =?us-ascii?Q?ONnpsuP4QUPvolBK1wOiQ2AwVLjt1w7mHf9SrKOh9fonyqAgCWgYtCNSiQyz?=
 =?us-ascii?Q?LCNvC4dVzwra/GfZvyOFirmw9uCtmIUNzJ27X/Vo9LM3jy/d7EStevX8bQqd?=
 =?us-ascii?Q?b3GjSo54cmVurmMziu3TaOupEDnPT6jPQ7UiBIYkLlZGioegWiDGrQjKKCLd?=
 =?us-ascii?Q?DqoxQFV20KtIovAinzAHM1RFKrc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d257034-297f-42da-7f4b-08d9afe0a034
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:55:54.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmLWqZTdn4AWXg2yMnO6fFggXsIRKn9Ei2FAnvhfuv83CCcsSxNGci9RfFwK7VXcO7pZFJ9WXEghZ0R6eh0RUmfHq401ufj7yFsxb+RAthI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250038
X-Proofpoint-ORIG-GUID: 45WpD2Xc6OyO1z6omfww_A1Hw_ckXLTy
X-Proofpoint-GUID: 45WpD2Xc6OyO1z6omfww_A1Hw_ckXLTy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ambarus/linux-0day spi-nor/next-clean-v4bis-sent
head:   088cf85cc4ef6d55a30cfab8ec33db3f1b15b777
commit: 40e3789d75cb97ab687d84fe7190dab363a758a0 [19/24] mtd: spi-nor: core: Init all flash parameters based on SFDP where possible
config: nios2-randconfig-m031-20211123 (https://download.01.org/0day-ci/archive/20211125/202111250118.loeFlVbe-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/mtd/spi-nor/core.c:2720 spi_nor_init_params_deprecated() warn: should this be a bitwise op?

vim +2720 drivers/mtd/spi-nor/core.c

40e3789d75cb97 Tudor Ambarus 2021-10-29  2714  static void spi_nor_init_params_deprecated(struct spi_nor *nor)
40e3789d75cb97 Tudor Ambarus 2021-10-29  2715  {
40e3789d75cb97 Tudor Ambarus 2021-10-29  2716  	spi_nor_no_sfdp_init_params(nor);
40e3789d75cb97 Tudor Ambarus 2021-10-29  2717  
40e3789d75cb97 Tudor Ambarus 2021-10-29  2718  	spi_nor_manufacturer_init_params(nor);
40e3789d75cb97 Tudor Ambarus 2021-10-29  2719  
40e3789d75cb97 Tudor Ambarus 2021-10-29 @2720  	if ((SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_OCTAL_READ |
40e3789d75cb97 Tudor Ambarus 2021-10-29  2721  	     SPI_NOR_OCTAL_DTR_READ) &&
40e3789d75cb97 Tudor Ambarus 2021-10-29  2722  	    !(nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP))

It's really unclear what's going on with this condition.  Is there a
variable missing from the first part?

40e3789d75cb97 Tudor Ambarus 2021-10-29  2723  		spi_nor_sfdp_init_params_deprecated(nor);
40e3789d75cb97 Tudor Ambarus 2021-10-29  2724  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

