Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA3445FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhKEGgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:36:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:6812 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhKEGgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:36:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="295297335"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="295297335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 23:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="501838291"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2021 23:33:57 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 4 Nov 2021 23:33:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 4 Nov 2021 23:33:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 4 Nov 2021 23:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdUkZFK1kY3ElEU5zjdgJzfDf0nXDVNmrp/KwRZja1f131/LACf8et+foeYb306+4O6KGnBiwno9+sb3bBjxV9WmkeVrzBUG85VX2L0N6S77Kkt8UHMjOzhe5mft1VSIQVbOK/SXysrKvN3AkzvLMWuyYdSLlNRcv/fvScHa+aHblz9ILnSp07PC+UROWd5ZbsCEN2AjBpdN7ghqQFM6yt4q0mLU5bt6DPxgsVuMNgKiUZqwLUMz5QhTWrYh2PRLqwm07qOj6eAIt4x+etW62XzgQNWVKxWJvEh+Qo3e+ncEk4eqv10K4XnhfbeSOur9Au9PUC79mBlldUFiquy9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnzRWpJY3NWie1wbcc2Zq13pvVKQcUixrLedh94Yviw=;
 b=BWxKjvlKR/REl6ZNmrD/twLYFVtPe9Y4btt+LWeD1FFXLKCNLka+4g/DkhdloA58+pmjzE6XeGGsi9Fdd2eLo1GixwmspFF66NC2RCSaMMlgsUIbrLFL/JjiU85jaHKlMv+W7/iDrk4931FR92AKklTSfGIgbxo3ns2IPV8GFSdL/MjMNfShmusWLbKyq9HBKuNawAKED1fCr2PIjGdGJq18p1MGPHzUghnryVBVqxRgHshKmhft5UAs8O22OxQRpyByYHj884x2ryx4W8F9yPypPx2vLmakTUICxpxkyDlkoVgVqOTfcZ3B7M1JDUHzhNBLh4Kqjz6iCo+z5xASyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnzRWpJY3NWie1wbcc2Zq13pvVKQcUixrLedh94Yviw=;
 b=HE/AgyFT42phf9+4Rcb8oT/OEK0V7N+AJ/0jqlQSH5sUXyM0M1PiqTln0JGWi4uVuNjninafzspynhSTmA8F8fOkvbya5TKmwa31o7Ox6bmKZO8GSZlu1D/mtXKBKE87SqiwFyxPeO1kj32l+phIa9FUEkcFO/6FupyR25MYPC8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5646.namprd11.prod.outlook.com (2603:10b6:a03:303::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 06:33:53 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::3455:d126:2541:7723%2]) with mapi id 15.20.4649.019; Fri, 5 Nov 2021
 06:33:52 +0000
Message-ID: <f90e6d91-e75d-8627-03a7-46525f8dda2e@intel.com>
Date:   Fri, 5 Nov 2021 14:33:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [dhowells-fs:fscache-rewrite-indexing-3 43/55]
 fs/cachefiles/io.c:490:6: warning: Uninitialized variable: ret [uninitvar]
References: <202111050401.6Yknm07v-lkp@intel.com>
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202111050401.6Yknm07v-lkp@intel.com>
X-Forwarded-Message-Id: <202111050401.6Yknm07v-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
Received: from [10.238.2.77] (192.198.143.18) by HK2PR02CA0140.apcprd02.prod.outlook.com (2603:1096:202:16::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 06:33:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da8bb1ce-72db-4d3f-e50c-08d9a0263c04
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5646:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB56464B3FF4B6354E01C11E29FB8E9@SJ0PR11MB5646.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6Vu64m5GIMdEAfGsXEmmFzYeG0SJWgOnhxpIFsaeMFsodukf6SBJ9ONgiMOJQ0ZaY16uYdStuPOs32OcHRPS0eqBdymh4Q5MpDmNf1bpVeOTC/9YecybQltiNAbc6iejDlsLCmcnR6EHgtLXzdzcC/cSfgfJGlqV/p32Y6GKnRSbjzMk+dCfRt75sxwZD+prdyF2y65acimg7Zzkj+eZ5KoJueT1jeASobzofzQg4mohL0KEtAWdV4QurzgIZgNFDMJFlCBxy01simGddK/6qyJHz2BSn1DwYCOgXQk+5syU05WI2dpB1cG8XSx0kjp++oRKblqpWwQG36DhHav0fzl4/8dxwo9nHU/Uj2lvMGOjKTQU8brPUpmjEV+PzQAMdmww42HTBgSj2Nzf5mkS4MaN8BRpyQnD6Oqvm2j1gTODVo9iy9xa6ffXhVmabyE5dz4qxoH8hITjmY479EuQSZhV2URxcylOF3odf1h94689V9AqaPayivwHGDSbKbJQinupTU/G/Td2sJJjrHONDbRS++5907i5xWOwKt+Zj2gKMr3lwaXFCxPVJOheEqN5JTN2gp11xLmQUINv+WwpqudcOLIgZO5ih6GdFpR3yuzSBtU+QiHRl0GJS7I1ulqTG1JW8JF4CrhZzUB1yuHDLvSjzAmiWMCpw1OyjHrt7D76QTrxYtkKoAbkwFE/T+DWXroI92uEiT77s32/RexGRd7goq2Y2dzQXLVHw43c2DEGRR0zwI5ny002Bjr0yABetp+E8XzfMVxrOYW7Ih1R0miIrrwaCrb/kzbJaGGZgOgF92o4VVcx9TCkEAElLtbSXjQmkntbg5bJ4qqqC2Ag5DFslthYMBaYggdGC6CB2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(316002)(86362001)(66946007)(8676002)(6486002)(2906002)(38100700002)(5660300002)(16576012)(2616005)(82960400001)(508600001)(4326008)(186003)(83380400001)(956004)(31686004)(66476007)(66556008)(966005)(4001150100001)(26005)(31696002)(6916009)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJBSks5MnkzdmdqUWxMTWx4R3dPVnZKYVZVOWl5VlYyVnNUVlNEWW5NbVR2?=
 =?utf-8?B?VjM2bUgyL0JqV3FLZkZyQ3NCdnpteFJZWDN5dTVnUHVHYU1DcDdwTGppVDNi?=
 =?utf-8?B?ZHRuNXRPWllxT211YW5oeEY0ZFlnS2FDTWNpV0NLTTBvY3BZY2FtbUhWRTVk?=
 =?utf-8?B?Z2t2OFR1RnNaODlkYkRCbTRQOTdrRXVqRURLVUJFRmluc2xvdXBnUTdMb3Bo?=
 =?utf-8?B?ZmFDdVNDQXFCbzVkTzh2UGZlSDhCZjh4TExiWURoMkZ3eDJNUWd6RzZlNzd3?=
 =?utf-8?B?MUVTYlVSVkRaOGpVdk1VZWVCN09tcVFRNmNuNUtnRjYyR3J2MjY2VGFHeXhi?=
 =?utf-8?B?YTNUR2lMS3RqQS9VTGJFdkJmQjc3MjJnL2VCcU96dnlSaXpPakNYdDJtZjVr?=
 =?utf-8?B?WklZMlBBQW1Ka2xJMlNDZTFyOHcweTdRY2xQb2ZBdkUzSUU0U1ZxdFhTL05B?=
 =?utf-8?B?d2xmSnZoZGs0OWtLbmZDV0I3WmRTaXVCSGVKVExWRmZucnVBMnltY2RSdUFi?=
 =?utf-8?B?SjNXSmYvRFpuVzh0RGJmVjFiLzFxWnUwcTlvVHcrNC9iYk1ackIwRCtOYy9l?=
 =?utf-8?B?WHV6dExjajJUL2FrZy9OTGhLdHYxVUJGcDM2UkxyNVloNkx1bGRTSnBLY3J1?=
 =?utf-8?B?czFKdzN2b0pVSnVFdzQ3cDFsK0N5MURWaXorN0dnMFVWS0NJSitINVBMbWxL?=
 =?utf-8?B?WEZMMTdvekl5YUlMWDg4ejZmSmFrOHNiRWpTb21Rc2lYaFlSUlNTejd1dy93?=
 =?utf-8?B?dzRCajJrNUFXcGJHSEFvYUs3MFdXcm1pNnViY1k0R2V5aXhqSDNEOXR0UDhT?=
 =?utf-8?B?NnV0b1dERll1UGF2Ti9ueEgvVENlM1llSHcxQVQzQkxwbndzTS9sN3JoM2Q4?=
 =?utf-8?B?MzJMeHhKTklsQkhaLzZRb2Z2UWhrRU9hazZtUkg2TXdjcmJDbTZIL1FuaUVt?=
 =?utf-8?B?bzNVdU5RNkZMMGJURnZ3SSs1VGIrQk1iNHA0OTZVNVlSRlpuSU9Sd2U0NEtk?=
 =?utf-8?B?NTVqTTIyRHFjMjJBQVJ0Z2liOTZEQWxLVkNFS3B4bTR5Q0NMU2RTTGRlYWZt?=
 =?utf-8?B?eEpvWEZ4cVdUZjEvSk9NSTc1bHhCV0ZoeVVKeFpmYVplTnRzTWx0TnBLWWxO?=
 =?utf-8?B?UEZ4b1BxWkJVb1hnUkNvMzRPeVh6MGtBN2k5UmlmeUJRdEZyd2FYWUZ6QkVk?=
 =?utf-8?B?ZG1YWUtkeXAwODNHRG1RUVQ1ZTJqc3BtbGlRcWFwRkZBVGNwazVybkdzZDl1?=
 =?utf-8?B?cVY3ZDBSdmZZNFBIQ2RGTy9xOStSMmhKdVoyaUg5ODFKWmRGS2RSMDIxSVk5?=
 =?utf-8?B?aGkzcllKdHZ2U2JkUGR1WlV3VDZ5c1BDdzNwT0YybjFaK01aN2RCbEphRG11?=
 =?utf-8?B?dEgvUWRrTmlNT1lhLyt6QisxSXU5UWRNUGdvZ2E2dklMVFhWbWJWeFNiVUJQ?=
 =?utf-8?B?ekFGK21QSmZsRE5SUHRldzBqTmtqUGFGeVk3NUFGVFBjcUsxd1FwWFZrK2Jx?=
 =?utf-8?B?b0Z3NnFQRWtjWHEwaEc5N0lxeE9vbSt6WFFaQ29NYUozQ2NWcDdJNmxxOXli?=
 =?utf-8?B?RFJOT0FBZFlXUjE5STlPclVwUVJydEdFdXBMMmpCQ3dYdThhcFpLdHNVQ3Vq?=
 =?utf-8?B?NUVqazhjeTd3aXlTVVJZZG9sSTJYVWV6T21SV3IybDl1TEJLZEJvVHRLczY1?=
 =?utf-8?B?c013RW9jRlRZamk0anoveXVHbE9JMGE2T2w1K2pnWkNmajdIVHV0QUM1bXMy?=
 =?utf-8?B?L3dBVFYxZTBjVllhODRqYWlNL0pnK1NXV1hCUXEvMGNmOVl3aUlUcC81dmV0?=
 =?utf-8?B?RlE3RC9rVjA0VitjUTlwL21Mc2VpanZqSWFuYlRINGU2YmlGTDFZMXErNEVk?=
 =?utf-8?B?SVE0VHBSMFhiQ0JWalVrTjdFM1d4QWFyQjhFMTVnSWJTc1cxQ3dSS0x6U2F6?=
 =?utf-8?B?dTA5cHhoN1phS1N1cTYrb3phMjZqT2hmZ0xMNFozWGxFUXBCaFVISVRIUmNX?=
 =?utf-8?B?TWtMbXg5QlROZXR2dVRoclBLbXlXOHFJWFpoQWpEVDc0Q0lRUVNmSmhGRVh3?=
 =?utf-8?B?VHpDT3JhaUw3YVpRVk55YTA1eVFYclZ1K3JoaWpXVm9kOW1DQlJZWmNwMDRK?=
 =?utf-8?B?cHF1SHlmaEYvaTh6TVZTa1Y5QnJwQjFSNGJUMndnQ3JQRS9OcE9QbHRkM2h0?=
 =?utf-8?Q?G8VCPiFlllWtTmlq3wySsN8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da8bb1ce-72db-4d3f-e50c-08d9a0263c04
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 06:33:52.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Kn5YkgLI7PXGJvIbf/EGohR12TTV9OrgdXxDTZtuJ6QcB3LXZMPxc2i1p0L+U2F6M94yv+sT76OdM9E3rC2yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5646
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git fscache-rewrite-indexing-3
head:   d2eff33286af9373ec469be3146d6e122c07264f
commit: 54975963cf72ae83b33bc4dd298e234976a7e4cd [43/55] cachefiles: Implement the I/O routines
compiler: hppa64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

 >> fs/cachefiles/io.c:490:6: warning: Uninitialized variable: ret [uninitvar]
     if (ret < 0) {
         ^

vim +490 fs/cachefiles/io.c

54975963cf72ae David Howells 2021-10-21  427
54975963cf72ae David Howells 2021-10-21  428  /*
54975963cf72ae David Howells 2021-10-21  429   * Prepare for a write to occur.
54975963cf72ae David Howells 2021-10-21  430   */
54975963cf72ae David Howells 2021-10-21  431  static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
54975963cf72ae David Howells 2021-10-21  432  				      loff_t *_start, size_t *_len, loff_t i_size,
54975963cf72ae David Howells 2021-10-21  433  				      bool no_space_allocated_yet)
54975963cf72ae David Howells 2021-10-21  434  {
54975963cf72ae David Howells 2021-10-21  435  	struct cachefiles_object *object = cachefiles_cres_object(cres);
54975963cf72ae David Howells 2021-10-21  436  	struct cachefiles_cache *cache = object->volume->cache;
54975963cf72ae David Howells 2021-10-21  437  	struct file *file = cachefiles_cres_file(cres);
54975963cf72ae David Howells 2021-10-21  438  	loff_t start = *_start, pos;
54975963cf72ae David Howells 2021-10-21  439  	size_t len = *_len, down;
54975963cf72ae David Howells 2021-10-21  440  	int ret;
54975963cf72ae David Howells 2021-10-21  441
54975963cf72ae David Howells 2021-10-21  442  	/* Round to DIO size */
54975963cf72ae David Howells 2021-10-21  443  	down = start - round_down(start, PAGE_SIZE);
54975963cf72ae David Howells 2021-10-21  444  	*_start = start - down;
54975963cf72ae David Howells 2021-10-21  445  	*_len = round_up(down + len, PAGE_SIZE);
54975963cf72ae David Howells 2021-10-21  446
54975963cf72ae David Howells 2021-10-21  447  	/* We need to work out whether there's sufficient disk space to perform
54975963cf72ae David Howells 2021-10-21  448  	 * the write - but we can skip that check if we have space already
54975963cf72ae David Howells 2021-10-21  449  	 * allocated.
54975963cf72ae David Howells 2021-10-21  450  	 */
54975963cf72ae David Howells 2021-10-21  451  	if (no_space_allocated_yet)
54975963cf72ae David Howells 2021-10-21  452  		goto check_space;
54975963cf72ae David Howells 2021-10-21  453
54975963cf72ae David Howells 2021-10-21  454  	pos = cachefiles_inject_read_error();
54975963cf72ae David Howells 2021-10-21  455  	if (pos == 0)
54975963cf72ae David Howells 2021-10-21  456  		pos = vfs_llseek(file, *_start, SEEK_DATA);
54975963cf72ae David Howells 2021-10-21  457  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
54975963cf72ae David Howells 2021-10-21  458  		if (pos == -ENXIO)
54975963cf72ae David Howells 2021-10-21  459  			goto check_space; /* Unallocated tail */
54975963cf72ae David Howells 2021-10-21  460  		trace_cachefiles_io_error(object, file_inode(file), pos,
54975963cf72ae David Howells 2021-10-21  461  					  cachefiles_trace_seek_error);
54975963cf72ae David Howells 2021-10-21  462  		return pos;
54975963cf72ae David Howells 2021-10-21  463  	}
54975963cf72ae David Howells 2021-10-21  464  	if ((u64)pos >= (u64)*_start + *_len)
54975963cf72ae David Howells 2021-10-21  465  		goto check_space; /* Unallocated region */
54975963cf72ae David Howells 2021-10-21  466
54975963cf72ae David Howells 2021-10-21  467  	/* We have a block that's at least partially filled - if we're low on
54975963cf72ae David Howells 2021-10-21  468  	 * space, we need to see if it's fully allocated.  If it's not, we may
54975963cf72ae David Howells 2021-10-21  469  	 * want to cull it.
54975963cf72ae David Howells 2021-10-21  470  	 */
54975963cf72ae David Howells 2021-10-21  471  	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE) == 0)
54975963cf72ae David Howells 2021-10-21  472  		return 0; /* Enough space to simply overwrite the whole block */
54975963cf72ae David Howells 2021-10-21  473
54975963cf72ae David Howells 2021-10-21  474  	pos = cachefiles_inject_read_error();
54975963cf72ae David Howells 2021-10-21  475  	if (pos == 0)
54975963cf72ae David Howells 2021-10-21  476  		pos = vfs_llseek(file, *_start, SEEK_HOLE);
54975963cf72ae David Howells 2021-10-21  477  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
54975963cf72ae David Howells 2021-10-21  478  		trace_cachefiles_io_error(object, file_inode(file), pos,
54975963cf72ae David Howells 2021-10-21  479  					  cachefiles_trace_seek_error);
54975963cf72ae David Howells 2021-10-21  480  		return pos;
54975963cf72ae David Howells 2021-10-21  481  	}
54975963cf72ae David Howells 2021-10-21  482  	if ((u64)pos >= (u64)*_start + *_len)
54975963cf72ae David Howells 2021-10-21  483  		return 0; /* Fully allocated */
54975963cf72ae David Howells 2021-10-21  484
54975963cf72ae David Howells 2021-10-21  485  	/* Partially allocated, but insufficient space: cull. */
54975963cf72ae David Howells 2021-10-21  486  	pos = cachefiles_inject_remove_error();
54975963cf72ae David Howells 2021-10-21  487  	if (pos == 0)
54975963cf72ae David Howells 2021-10-21  488  		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
54975963cf72ae David Howells 2021-10-21  489  				    *_start, *_len);
54975963cf72ae David Howells 2021-10-21 @490  	if (ret < 0) {
54975963cf72ae David Howells 2021-10-21  491  		trace_cachefiles_io_error(object, file_inode(file), ret,
54975963cf72ae David Howells 2021-10-21  492  					  cachefiles_trace_fallocate_error);
54975963cf72ae David Howells 2021-10-21  493  		cachefiles_io_error_obj(object,
54975963cf72ae David Howells 2021-10-21  494  					"CacheFiles: fallocate failed (%d)\n", ret);
54975963cf72ae David Howells 2021-10-21  495  		ret = -EIO;
54975963cf72ae David Howells 2021-10-21  496  	}
54975963cf72ae David Howells 2021-10-21  497
54975963cf72ae David Howells 2021-10-21  498  	return ret;
54975963cf72ae David Howells 2021-10-21  499
54975963cf72ae David Howells 2021-10-21  500  check_space:
54975963cf72ae David Howells 2021-10-21  501  	return cachefiles_has_space(cache, 0, *_len / PAGE_SIZE);
54975963cf72ae David Howells 2021-10-21  502  }
54975963cf72ae David Howells 2021-10-21  503

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
