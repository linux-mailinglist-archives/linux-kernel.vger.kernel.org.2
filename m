Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154293DBB01
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbhG3Ork (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:47:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:47016 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhG3Orj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:47:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="213141611"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="213141611"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 07:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="667261104"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2021 07:47:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 30 Jul 2021 07:47:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 30 Jul 2021 07:47:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 30 Jul 2021 07:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CepCuYqLBU0RJRAkCsoxVkS+jjbOW/dJvsyRotEfYpYwWT8FWWl0bbTcAMHeiORprLPpVYL+rR3G9ny0tQLHtvUICmrz6MBda28k6AIUMbonBEDlgdxaUnDFS+/8Z1TuS+PUwBnHHPSoxst+Wr77HERwZ10BmQ+OXxcdwKV1DuEU6AwvWDJO9oPXp89mPzEPTc2t6nXdWa6R/SUrMJAl645LAgPl4oPJ8Em3j1tXyu8PECR2QC4SaFOBcWakw2ghSIWIb86yxVpYOKNJg/uMzx2pekkOUjzU8CtPIuTk/oOmzwGjyprdSmFrk1IG3c/b2IbACeY+qsYN8JuCfeex6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE7HSkXT7Wn+DmDshJBcCASt+IIUPZA5Zq7xvD8InsA=;
 b=VUFHR8odPkFpqv540ZL2PlB1Ccy5a3cxj2zl0nPVVcx7VdWctgKeuLjbJq4675wC8mG9fwTa3Q1i4Bd6s188VNDAjQrmsFSU+pG/JweEqJcZHlgVLBpO0AgD27HyFnIM6Pk6LLKuxfFtwEstcxjYjPt1C8zJbmL31vl/5/0HSueOv5ncSy72YDNsvEyu9N6rfrcv60rvwxEIkeR90J0nYeO2hKNfVoViE5k3pahc6G+zB+cXI/qZbAdjVi55t0+6MwoMkAEE2rr6L0S+uHWvNwDgcnHtEa1OzvRQFCxlbmhZ5Hh8EV1LQN1rZtGhM5o+3XF6yYAgOTuhRCZubC/YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mE7HSkXT7Wn+DmDshJBcCASt+IIUPZA5Zq7xvD8InsA=;
 b=pe4setclClLiTuTZbhXAkSk74XW7RGfRXKNjV9yoRrD9NILzuWXCmMRVq2ZyWvJYbq9qR00xmDpWEO/W61shm0YiTrRujGqAMPVwakm4r2q+I7w0DQGzInt0WCmNn2cRbL+koF8kciEw75cvGum/vrkecb9FwAeSr+GOAG9bcYQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2180.namprd11.prod.outlook.com (2603:10b6:405:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 14:47:31 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631%8]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:47:30 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSB4ODYvaW50ZWxfcmR0OiB1c2UgX190?=
 =?UTF-8?Q?his=5fcpu=5fread_in_pseudo=5flock=5ffn=28=29?=
To:     =?UTF-8?B?6IuP6L6JKFJvYmVydCBTdSk=?= <suhui@zeku.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210723023342.3015-1-suhui@zeku.com>
 <ddb942f0-4c34-4e10-7d46-526d411f5ebd@intel.com>
 <KL1PR02MB47882A3A37249394CB6B5D84C6EC9@KL1PR02MB4788.apcprd02.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <01aaa72f-f4c8-720d-e51b-df38f200eeaf@intel.com>
Date:   Fri, 30 Jul 2021 07:47:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <KL1PR02MB47882A3A37249394CB6B5D84C6EC9@KL1PR02MB4788.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:104:4::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.219] (71.238.111.198) by CO2PR04CA0174.namprd04.prod.outlook.com (2603:10b6:104:4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Fri, 30 Jul 2021 14:47:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6de3052-c599-4ae5-1a88-08d95368f4c0
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2180:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1101MB2180CF2BBB2E343DDC1E97A4F8EC9@BN6PR1101MB2180.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzdABwNPnR9XvxdmjsHfwmaF2O84XY5bFc0EzH+F4kZaFaPB+uheAlTjZZVXMNFASc/3yFmMvqyTwUMlgDMvUX/XaOuPfJqrHdujFAT7oCGN+yv06kLa9xB6R6z2pmyF4QfUsdbu2A77i2RsltNrTECkBVzGU198+/wZ6RWBqtTN4v0MeveX9PuHiRiaCHRL1U1NmsfdoVnmlBTA/CTanhIDMuMQ2gPhZlBSyxSOwKqvO7dbTwlQWIxJulfUtl2VlYjnz2M/tSDJ3qhgqnI7VMKHpCi3eBq7qIUTsA8qcv/0QJcoBRSPGCR9rJEYnv9XUySUeSLWgsDrg/slSw/c+Vk6LYTQQBX7mYqzdtGncYW8fMapdMOsyd6ooYU5EW8UyNgYp95iEDgTgABtZemx53p9JTfJvtpSvKLxSWZWEXWMlRNbZz8m4M6vQ8KjMxf3JR/jPid/9XgHvLLb6u4srePn/pdyljj8V6zD7tgYMTHYjnw7fhY2+keALnGwKnV9A4LwHVdJnZ0+nLtp8CCaX2wvTm0AkLWDUEzGDLlmXjPKPA/aS6isx5SDZYulTEh0A4dsUFmHxnodw4Ws5o/rdSYlMO13tk13/8sclLPliqeC+S/43Qnk1cFsiGluuQTNWVg1NF3d8Fo1i9lweX7F4Pj9ru60OqzTzznqFJVRfuMilP98uAyVpg788dHOBXDQ9DAKK0yF918UH1fajo42HjbAen9uSAgj2TwM03T/1sWoxXHT4YHVsnRm6cWkYW7M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(186003)(26005)(4744005)(5660300002)(31696002)(6666004)(36756003)(83380400001)(956004)(44832011)(2616005)(53546011)(31686004)(86362001)(316002)(16576012)(224303003)(8936002)(6486002)(66946007)(38100700002)(66476007)(110136005)(2906002)(478600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?REVhRkFDWEVFakRybEkwUFg3cTloWnFFbUZMUC85eWZSVnRZa3dFbTFYQytw?=
 =?gb2312?B?ay85NURvVG5teWRxWlFCR2FrenpuNDBnSjYxQzY0R3hOTU44T3VWNUhWdFg2?=
 =?gb2312?B?ZFJTZk5GU0ZzZkc2aWZkMjVNeHIrT3JvOW56Y2ZSeWtSdTdXaDBubjVxSGQ5?=
 =?gb2312?B?QkpnUTB6TGErYTVraGZOMkRnb25wOHdPY0VQRkhLWEk3bkoxNzByOTdKRFhK?=
 =?gb2312?B?WlE4enNoQ3U3bktkRGp1MTM3VGliMzhLVVkydnRkRHRaWEkrMHVIZXdPV09h?=
 =?gb2312?B?MkNiS0QwdTErMzFQZXNFNVBQMi9BbHZiOTlMRHNVNm5wTVByQ3pQOVh1cGEy?=
 =?gb2312?B?NEN2MzdRK2VGYVo5QnhTRUxyL3g3Mm5Uck1kT29jOGRsbUk4a1B3WnBWRGZ1?=
 =?gb2312?B?V21oMnlKYUQ3anFtWndIWGNpT05MbWovVXAxdUM3VFhwQUFLY2F1dm04U002?=
 =?gb2312?B?cGsxckJFL3h5aWdtZHF0UXJ2L1d5d0tBUkFpWkg5NmxVUmpJRXU3Z0twYjRk?=
 =?gb2312?B?aTZFZjYzcDQ2emNVeFBoSTYraVg3dWdMM2J1YmVINkVWeWQ4eUxVcytSbXl2?=
 =?gb2312?B?aFdzZ3o3VzlTUG55bUJxQ0grU2NRSDJHSk1meHZqRUZSMS96czAyM1VRaWRt?=
 =?gb2312?B?SVpqM2NjSnJHd0JzMGJZeExxT2dDK0RzbkVDdG56UDBkVEdiVmJlbU81S0hB?=
 =?gb2312?B?V3JUS01SdUJkNXBPUXFtTERHMWxmMzR3eFMxck5MdWUvbWtvaUhTaVJnNTdV?=
 =?gb2312?B?bUJKL0hlWnRsNk5QamdFMWZhOHpXZlRvbUNSVkhsTHZPOHJQZ2J2a3g2OGlP?=
 =?gb2312?B?ZnVZd0Y4NkErVDZFa2VDcVBzVmZSR3ByVDVhYUhjNUdwNGQ5UFBDYkl3cEZr?=
 =?gb2312?B?MFZKekd5ZG9lVkI2Vk5GY0pVeHhuTlFlSkZNQXZ1bGFsS3JwY3JxSkVET0xG?=
 =?gb2312?B?YjdTVEJpVy96Ui9sSmtwZ1dFaWNHa1R4Nzk1U2syLzVDbU1BL2dhQTVHN3kw?=
 =?gb2312?B?MXhvZ0xORHlvZ245N2o3eXhqMEhsOWk5am5FbldYbEFZc3hBRFpkeWFnZnl0?=
 =?gb2312?B?ZERqM1NNdFFUdEJtc3d5dUdKUHBidkV3eE9Md2llUkUvK3FYNUpaZ052dXpB?=
 =?gb2312?B?QW9uVFJHQWU0Y0o4ZU1Jd0k0SWxTOVFkaHdTWTJQN3JOU1BBTFZhR1dBSitz?=
 =?gb2312?B?cjlxTkRIZmUrajVxOVZuNHdNNHRzMHVJZjdRby95elQxem53MlZWbEd1SXZU?=
 =?gb2312?B?dVprLzZYMUZoT0pHQjl6U2lGQmI5R29JZHJuMFh3dlRRNlltL251elRMOEEw?=
 =?gb2312?B?TlVjQTZSaDZta2xmZVFWK2NmYXZ0aE1JeE5LbEl6ZUdpRkQ1d1d6bG9aeFVN?=
 =?gb2312?B?N0pSRVBadm9ZMEJvS3FrdFF3eFhZYTYza1lPRFJ2amhRa1gzOEJudEtzMk5w?=
 =?gb2312?B?V09qRlc5aWRzby94a0oxYVFHYVJTSU9XOFhPci9PRlFQUkhxMTlPR21wY21L?=
 =?gb2312?B?elZpUnhoWjgvOHFEQkhaaDBpYnhGcjdqVVhjOTJNU0Y1ZWp2ejlNd0Y5d0Yx?=
 =?gb2312?B?WVpWMXF2eHVkUmhHQW5QTUR2WXFrMGh5QTVScStLQW5aTENWZlh3MkZJUjNC?=
 =?gb2312?B?QU1zVGVSN1ZkRzhWSzZ0WndNbmNHZEt3Zy8vdCtweXk3TStYMEVkeWg1bmFG?=
 =?gb2312?B?VDlYNXVuQnAvcXVvbFk1VU1FZWNZcDkrTHV0b1JocEV5aU85dHNDa2ZtNzJH?=
 =?gb2312?Q?k2Fs3EwMnDaYM3bbNh7WbgczVu/TMTb/ZiX2B6V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6de3052-c599-4ae5-1a88-08d95368f4c0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:47:29.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g+ULS1Q0+Pd62R+Z7bHn6n4R7rH5CKB7O2AWISY/jeOxInwzo1yXqNXkrYfQ+18dDPwrqs6rkOrumeGBU7CCBUFa6CUIyeO3QqnGVwqnog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2180
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/30/2021 1:22 AM, ку╩т(Robert Su) wrote:
> Hi, Reinette:
> 
>      There is no issue here, i just think it's better to use __this_cpu_read when
> interrupt disabled.

ok, could you please elaborate why it is better? I do not see a problem 
with the change - I would just like to understand the motivation for it.

Thank you

Reinette
