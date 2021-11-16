Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA3452B34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKPG6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:58:15 -0500
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:42815
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229593AbhKPG6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:58:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auZuEfr/BiIgxNvPzpZXqTQfN2J9Djvxn7uzCGuNOsdPTYYOVAuPeUZWpIdaOfwA5KBjCBtlULR7ztcTXv9EzsCwrrpz14+qXzEQu6ipN/G29APxo5IFDQATrjmqH5oGRme7Iv+2LCcjP2n1gHEfepcx3R51x7vP2ZCIypWYYSm+4Ma14CTh7B/TGIqnz2PCI+saUtdccCJCuGEKgDkSctv5vQwPx9/EhiZIFSxCU8Q78cTPgitREBr23G3VpshDPvVZFeAX2Rye/5KiEkEwmH9cNIVdRR4weQB42VBt0V776ekAHVl6GJ0dq9GIM+JzTPylMwxMy+tZDWVZAyHEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTprxJq2QZ22iAHcjUr8YgpssbWE68aWqQ9mxtWWHNA=;
 b=EFgf/BwkXPCJPGCCXgtgEmTETUPO1AkdhURqJmpiK7mvP5T/jcbVLxUcWWHOvgo1PL3GFGJP2untt12Jsdv5fv/93dQEWzhH6udhqCuNBfP+Go0pQOWVkAaCzw/ORpPunguysg3GgrMc6lNfsA0S5Evs9Gyqys+JIEm0Hp9x24VvvZP8URDM1T+KqkHc3RkvHyxxx233L0y+fmpEaQf2st5FBPnIzhp0tHmCmcJgfMCvGb2SbSCc/fK2swQT4JvUlvTlenhUwLAT2dh9Z5TZPRMBapiaJ57Odj6D96QThHd0A9OlSjTe4moJUWNdDAsj/XQADp+l0Qt9FSjNPoOL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTprxJq2QZ22iAHcjUr8YgpssbWE68aWqQ9mxtWWHNA=;
 b=kjBtPbKKOUGP8eXWLMiqvhpLKT6ohkeV5bx8/+ekf+rZJvGu7F4eLaqUPQU336tqX4oAESFfhVa64fD8eOeqmVhr8pFjzBFqdJ0xxF+Rzqs0s8t6Q55DsD32beZmjFU3QYZ4l9LeZqxYvVjw9CdLp3jeQ/yWLyfInc/L+9oL7Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 06:55:16 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e953:c93a:f2b0:aa56]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e953:c93a:f2b0:aa56%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 06:55:16 +0000
Subject: Re: sound/soc/amd/yc/pci-acp6x.c:251 snd_acp6x_probe() error:
 uninitialized symbol 'index'.
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202111131437.WN6zRp5F-lkp@intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <322a3a29-c561-6e21-dfd6-f68ae53a3d8c@amd.com>
Date:   Tue, 16 Nov 2021 12:24:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <202111131437.WN6zRp5F-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::13) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
Received: from [10.129.9.123] (165.204.159.251) by PN1PR01CA0073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 06:55:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c086242-2fa6-4a1c-a39f-08d9a8ce0b70
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4105F06046CA4A93FB71AA4D97999@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuYBcvCr2cxwDH4XUrSU771JYFZxVI4RJ+JUqQXadP3autff5Nx7/m/fqevFN9X2bSvipRhK7JiWUsC5mCg8uffKmGTM4AC7HVoujNfjnh7wm4CZdP1U1Dc7LPHntUYijg4UOpvh7xTTXUkhVIvNw1itPgFKShshGP8WtMz6cX1r2oR/0bERnietBy0lRxTPdAuv7tVG4qBsmZWicWrg6nGtli/aWL7nBUUFudE20wHtTdU5sP8POO/uVB4Vank0T6KSjAPg6H58/+xYDjrirjIW/6uEsGj9ev9TBIc8pN2wxlhIGmPp36pY/oq963g+gr+qy0ulwgBM9S/LoLYEq/J5i5w1eqmHbAJZum80NWzlbMfzNW73+hnPTOsOUzauboyE4P5qeAyTL9/LTEdX3EhAf86JZkKA849wXaj7Q1TzcXJInOuMafwD9c6fF7tGbz3X0qjBnBEdmXTWPPszGRAAGmQbO4E2Wh3xvHFDBUfkEP8OR8/snzu3XoQwKdf/v8Tgv3l2Bts2lpZM+5vFrAc9GPhPXyz/MyKB7BaWaMamQqtrSeDDn8Na5zguwDwhB0isEf+i466EZ69YGgOghjdAlcHg1ir0Q4mM1hyEY7zxTs7g96puYBwdEkwbhAjqGSPC8DC12h5R57TvMzXBEDMaN8kLJI0jBYZBbUcBJKSP+N7JR1z1CYPEk6Msz6wdkAqhoiArsGNgzPHny8Djh7u68TC7xVSSufoanwDEonFlz1bn29IdhPAdWHPSUAmoVMbfroydP11MtNyr8hpynB5YbGvw2pLNeAoiVOyUSIOCdBhzUQV17G3YjAFGTabj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(36756003)(8676002)(2906002)(2616005)(26005)(30864003)(186003)(5660300002)(53546011)(966005)(4001150100001)(31686004)(66556008)(956004)(4326008)(66946007)(66476007)(45080400002)(6486002)(508600001)(8936002)(86362001)(316002)(83380400001)(16576012)(6666004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzF6cU9CKytqbE9FdEYrakRlQ29CMTFGVk5VY05lZFVJVnRBZWRLUUtKVDJK?=
 =?utf-8?B?aTlpYkEzeXpzRHJLaDFPTEFmZjhGbjdSM2VsclczcmgvYkxuR3ZkZlI2UTg5?=
 =?utf-8?B?Tm5hUFFtYldVdlE4NzExTzQ5d1lvYytJcWVjTlp2SUc0cWMrcXZKS3lXY0tw?=
 =?utf-8?B?OERPM0srVFJIKzEvWEdOMS8rRVYyOWJ4NHN5TkVkSHlTdnN0SDR5ejQyREli?=
 =?utf-8?B?bFdMVEtndkxrbWNWb0tGR0xZMGdtd2N5eWNzbWRlRlNjWEZBU3ZueGlrdDMw?=
 =?utf-8?B?cHR5eEZIcDVHeGlrUmVuYjQ0QW84cDFnVnVJSTFPRXJYZVJ2dk1zWVF1MDlT?=
 =?utf-8?B?TGZ2RFB3TVR4RmZxRmJ1MWRWeWtPbDArRzNKNWEzZUplNGJUVEZyRmpRUlQv?=
 =?utf-8?B?WVhybHVMcjZjUEROdkFxdUgrcXBrQitaanZzNmczT3JjcTVyS0U4eVlmRUxT?=
 =?utf-8?B?Q3ZvVlJBaklUMytsQUM3dEFjSG5yRXZ4YUM2OUIyRFlFdEM1c2pFRmRDVVIx?=
 =?utf-8?B?VlBmYjROZDR6YThwWG5Ba1pmVGhmVkZBeGg4Zk1qRUZWaEYzREt0cjUxVDNi?=
 =?utf-8?B?YUo5SEdxOWEzYjBXeGNvRzdaZWlha3dkcnBZOHdYM3V5QVJUTE8wWFNYdGly?=
 =?utf-8?B?VnRlZEFoT2JSZ2V4eVlmTTRsT3BjTlBub2g5ejJLT1c1a0V5UHRxcnZ2a2Va?=
 =?utf-8?B?a3RnendqWHFLamdRSXBnOE1ORjQ2Q1hoNjhjTUtxVy8zTWN2RHJ3SFUyeVdF?=
 =?utf-8?B?K0JPS3laNlZBM25DR2VpTGVrZVZQcVNVU1htSVlQN0xxUXJqbU01bXEvclVo?=
 =?utf-8?B?NGplYkFEdGhLQ2x2MlZKODkrV0d5azFSc2FTVnVnTDdVZGhDUlh2TlFLdklX?=
 =?utf-8?B?YXNXc3VyMlk2cjFlSitDcGRNQVFkQnlHZUxWdDM4V1J2ZERna282Wm5pMWtw?=
 =?utf-8?B?WE80RG5BcVNLc0llNHlnZWYvdkFUK1p5N0tkbkdhUG1WWWZoazRCYk16K1cr?=
 =?utf-8?B?L3VIYzB3bXR2QnJtOFcyQ0Y0NmJYRzd0S0tRTEF4U1RlSjlYaEVtVVVEcWF3?=
 =?utf-8?B?by9sRXByVUVnb0tGb291Mm4zN1lwR3laVGpIUEV2V1RxWExMUHBzMnhkQllN?=
 =?utf-8?B?bTRNRjdybmgrbTVCcFlvamxMQ0ZENWorT2dnMlRIR1lQUElSdlJHNSthZzZR?=
 =?utf-8?B?U2J2RjlFcml3NjRHb0JKZWR5a3doSlZnZlRLeXUrMVhvRitlSnd5THhWRmJW?=
 =?utf-8?B?bHJOZW42SUx2ZFFtbmlDZTgzclUvQTlpcnZlMDhtNDVIWHVHcHY2Tk4wdUho?=
 =?utf-8?B?TW1kWHNTZHFmaXNBM1Rjcmk1YUFrUjIwSHZ3S3BNRnh3QnQ2c0JqOVhGL091?=
 =?utf-8?B?dEc4bmEvRE9qTUxWakpMVU1jYitleng0OWVrYTduMkpGS2dLa1Y3OVFGZnl4?=
 =?utf-8?B?OHpxWVZrQjZQVHlSUFNWZit1a2hMTU9IUXhST1oxOXRtaDkvNlBqU3g4MkRr?=
 =?utf-8?B?RWtzT0FiVC8wT05nVmNUM0pPbmtmYUUzeGh3YUkzNnZncVBXald0OVFZMzVi?=
 =?utf-8?B?MDZja0t1TzBncTlCQ2lzQ1FaUzltQ2Nka2dQZ3U2eVlwMGVaenB5NUFWUHFn?=
 =?utf-8?B?RmxUN21mRzU4RXk4NVFvN2pVekhvdGk2NkdiWWViakQ1V1BSZXVVNUMxR0pn?=
 =?utf-8?B?Z2IyaHJIUnRpMHhVZU53VHpmd25NVU9hWmRmMW9LdXl0RG9QQmJ2dUZlcXNF?=
 =?utf-8?B?UGJTOERSaytuNi9PMlVEZXR1ZDhlQnkxWVBabW9iKytLdlR6cGtQaXFjTXhR?=
 =?utf-8?B?ZjYzQkFJNDNGQkMwQTd3NW5lU3c2allMYUFQWlkvUDZKb0JDQmtBTjdONEtt?=
 =?utf-8?B?dzV5M0hVY2pTVzM4TVMzNm1IQnhXM2VLa3RJNHJQQ3YrSE4yV2l0MHU1V3JD?=
 =?utf-8?B?NFZiajYzczlPcnlOYnNvQWJqOTZucjUxUm9VNnNJYXZTTlRKR2VEa3NGK3RX?=
 =?utf-8?B?R1ZtWEw4bm84bjBHMkFyRlZZK0hIVHIvME5DNFZHaUgwK1hIK2dhZmxwa0JZ?=
 =?utf-8?B?ZDhHR2VQcUZlR2ppWjltRkh2RjdjdStSeUNpa1krWWRhZGQrbUladCtLK1hX?=
 =?utf-8?B?WGZVaDRwcHY2RDRCLys1TmJtMHpwUmVWZmx3MzBDNURFdkhUNkFWaHNyUmJH?=
 =?utf-8?Q?WtSPoBvdWMJihv6Mwz1NFbs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c086242-2fa6-4a1c-a39f-08d9a8ce0b70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 06:55:16.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnPVlozsGinR2UhL7oygq2YbcCe4s1E9ZY8P6xZCgKBtUOCHPpuDeWituVpGhA8Vxrw+lvfHDLCn0Vq6KpDfIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 4:28 PM, Dan Carpenter wrote:
> Hi Vijendar,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C7888a2ea4fa44a3fd1b408d9a826e7c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725707327235801%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=dk4pUdo741olPkRbPf4DtZHsO1U6ppgI%2FVo%2FTb5yKVU%3D&amp;reserved=0 master
> head:   66f4beaa6c1d28161f534471484b2daa2de1dce0
> commit: 89728d97db3f078aceb967ebe5ed2d0797b6a117 ASoC: amd: enable Yellow carp acp6x drivers build
> config: x86_64-randconfig-m001-20211028 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> sound/soc/amd/yc/pci-acp6x.c:251 snd_acp6x_probe() error: uninitialized symbol 'index'.
> 
> vim +/index +251 sound/soc/amd/yc/pci-acp6x.c
> 
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  144  static int snd_acp6x_probe(struct pci_dev *pci,
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  145  			   const struct pci_device_id *pci_id)
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  146  {
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  147  	struct acp6x_dev_data *adata;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  148  	struct platform_device_info pdevinfo[ACP6x_DEVS];
> fc329c1de49825 Vijendar Mukunda 2021-10-18  149  	int ret, index;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  150  	int val = 0x00;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  151  	u32 addr;
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  152  	unsigned int irqflags;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  153  
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  154  	irqflags = IRQF_SHARED;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  155  	/* Yellow Carp device check */
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  156  	if (pci->revision != 0x60)
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  157  		return -ENODEV;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  158  
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  159  	if (pci_enable_device(pci)) {
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  160  		dev_err(&pci->dev, "pci_enable_device failed\n");
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  161  		return -ENODEV;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  162  	}
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  163  
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  164  	ret = pci_request_regions(pci, "AMD ACP3x audio");
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  165  	if (ret < 0) {
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  166  		dev_err(&pci->dev, "pci_request_regions failed\n");
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  167  		goto disable_pci;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  168  	}
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  169  
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  170  	adata = devm_kzalloc(&pci->dev, sizeof(struct acp6x_dev_data),
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  171  			     GFP_KERNEL);
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  172  	if (!adata) {
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  173  		ret = -ENOMEM;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  174  		goto release_regions;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  175  	}
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  176  
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  177  	addr = pci_resource_start(pci, 0);
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  178  	adata->acp6x_base = devm_ioremap(&pci->dev, addr,
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  179  					 pci_resource_len(pci, 0));
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  180  	if (!adata->acp6x_base) {
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  181  		ret = -ENOMEM;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  182  		goto release_regions;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  183  	}
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  184  	pci_set_master(pci);
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  185  	pci_set_drvdata(pci, adata);
> 8c7161f2c97b2d Vijendar Mukunda 2021-10-18  186  	ret = acp6x_init(adata->acp6x_base);
> 8c7161f2c97b2d Vijendar Mukunda 2021-10-18  187  	if (ret)
> 8c7161f2c97b2d Vijendar Mukunda 2021-10-18  188  		goto release_regions;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  189  	val = acp6x_readl(adata->acp6x_base + ACP_PIN_CONFIG);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  190  	switch (val) {
> fc329c1de49825 Vijendar Mukunda 2021-10-18  191  	case ACP_CONFIG_0:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  192  	case ACP_CONFIG_1:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  193  	case ACP_CONFIG_2:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  194  	case ACP_CONFIG_3:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  195  	case ACP_CONFIG_9:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  196  	case ACP_CONFIG_15:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  197  		dev_info(&pci->dev, "Audio Mode %d\n", val);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  198  		break;
> 
> "index" is not set for these cases.
> 
> fc329c1de49825 Vijendar Mukunda 2021-10-18  199  	default:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  200  		adata->res = devm_kzalloc(&pci->dev,
> fc329c1de49825 Vijendar Mukunda 2021-10-18  201  					  sizeof(struct resource),
> fc329c1de49825 Vijendar Mukunda 2021-10-18  202  					  GFP_KERNEL);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  203  		if (!adata->res) {
> fc329c1de49825 Vijendar Mukunda 2021-10-18  204  			ret = -ENOMEM;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  205  			goto de_init;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  206  		}
> fc329c1de49825 Vijendar Mukunda 2021-10-18  207  
> fc329c1de49825 Vijendar Mukunda 2021-10-18  208  		adata->res->name = "acp_iomem";
> fc329c1de49825 Vijendar Mukunda 2021-10-18  209  		adata->res->flags = IORESOURCE_MEM;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  210  		adata->res->start = addr;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  211  		adata->res->end = addr + (ACP6x_REG_END - ACP6x_REG_START);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  212  
> fc329c1de49825 Vijendar Mukunda 2021-10-18  213  		adata->acp6x_audio_mode = ACP6x_PDM_MODE;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  214  
> fc329c1de49825 Vijendar Mukunda 2021-10-18  215  		memset(&pdevinfo, 0, sizeof(pdevinfo));
> fc329c1de49825 Vijendar Mukunda 2021-10-18  216  		pdevinfo[0].name = "acp_yc_pdm_dma";
> fc329c1de49825 Vijendar Mukunda 2021-10-18  217  		pdevinfo[0].id = 0;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  218  		pdevinfo[0].parent = &pci->dev;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  219  		pdevinfo[0].num_res = 1;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  220  		pdevinfo[0].res = adata->res;
> 8c7161f2c97b2d Vijendar Mukunda 2021-10-18  221  
> fc329c1de49825 Vijendar Mukunda 2021-10-18  222  		pdevinfo[1].name = "dmic-codec";
> fc329c1de49825 Vijendar Mukunda 2021-10-18  223  		pdevinfo[1].id = 0;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  224  		pdevinfo[1].parent = &pci->dev;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  225  
> fc329c1de49825 Vijendar Mukunda 2021-10-18  226  		for (index = 0; index < ACP6x_DEVS; index++) {
> fc329c1de49825 Vijendar Mukunda 2021-10-18  227  			adata->pdev[index] =
> fc329c1de49825 Vijendar Mukunda 2021-10-18  228  				platform_device_register_full(&pdevinfo[index]);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  229  			if (IS_ERR(adata->pdev[index])) {
> fc329c1de49825 Vijendar Mukunda 2021-10-18  230  				dev_err(&pci->dev, "cannot register %s device\n",
> fc329c1de49825 Vijendar Mukunda 2021-10-18  231  					pdevinfo[index].name);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  232  				ret = PTR_ERR(adata->pdev[index]);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  233  				goto unregister_devs;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  234  			}
> fc329c1de49825 Vijendar Mukunda 2021-10-18  235  		}
> fc329c1de49825 Vijendar Mukunda 2021-10-18  236  		break;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  237  	}
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  238  	ret = devm_request_irq(&pci->dev, pci->irq, acp6x_irq_handler,
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  239  			       irqflags, "ACP_PCI_IRQ", adata);
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  240  	if (ret) {
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  241  		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  242  		goto unregister_devs;
> cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  243  	}
> c8212df7bc0f2e Vijendar Mukunda 2021-10-18  244  	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
> c8212df7bc0f2e Vijendar Mukunda 2021-10-18  245  	pm_runtime_use_autosuspend(&pci->dev);
> c8212df7bc0f2e Vijendar Mukunda 2021-10-18  246  	pm_runtime_put_noidle(&pci->dev);
> c8212df7bc0f2e Vijendar Mukunda 2021-10-18  247  	pm_runtime_allow(&pci->dev);
> c8212df7bc0f2e Vijendar Mukunda 2021-10-18  248  
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  249  	return 0;
> fc329c1de49825 Vijendar Mukunda 2021-10-18  250  unregister_devs:
> fc329c1de49825 Vijendar Mukunda 2021-10-18 @251  	for (--index; index >= 0; index--)
> 
> Uninitialized variable "index".
>
Will fix it and post the patch.

-
Vijendar

> fc329c1de49825 Vijendar Mukunda 2021-10-18  252  		platform_device_unregister(adata->pdev[index]);
> fc329c1de49825 Vijendar Mukunda 2021-10-18  253  de_init:
> fc329c1de49825 Vijendar Mukunda 2021-10-18  254  	if (acp6x_deinit(adata->acp6x_base))
> fc329c1de49825 Vijendar Mukunda 2021-10-18  255  		dev_err(&pci->dev, "ACP de-init failed\n");
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  256  release_regions:
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  257  	pci_release_regions(pci);
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  258  disable_pci:
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  259  	pci_disable_device(pci);
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  260  
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  261  	return ret;
> c62442bd5d9f86 Vijendar Mukunda 2021-10-18  262  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01.org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C7888a2ea4fa44a3fd1b408d9a826e7c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725707327235801%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=gGdJTfvecE%2F8KukmrIY4sAlQdiOQvnF2tk35P0iixh0%3D&amp;reserved=0
> 

