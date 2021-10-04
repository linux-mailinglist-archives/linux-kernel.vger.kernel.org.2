Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC2421984
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 23:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhJDV7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 17:59:06 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:26033
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234225AbhJDV7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 17:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI1g5atrqBewqh3WoJidHUxUQIu8UGia81Gl3x4vwsCXLLWTArbT3p98fXA6iAjo5JGoWq1PmNr+7xkrppuvH+awUhi5yryP05JiDtMJ0Q51+RbOOO7+42RFf2xpz9hEMLmvJMvKWXvcSjmij1ayDct98eHvxLY98zEfjLD0IJw5GLfw4bTorRlK2ZlV2Qw/4fqcwTg4ZtnxRnsG8m6jlSpVR4JCzA8tLfmCF+mijRLy6+F+EakgamA1QnZ7P4gmUvQ6GkXegCDg4LLnc3uRw8l6ZPPaFKIWQ62SbIMBapMc6YBayMx2ZUzfytBEGes6AlX4vYDL51ZCs6J/C8ockg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0ja4l46bovHUamJixyXL9ZMbe/ccnbK6cC/ZyNFSKw=;
 b=Lmy6KdZnoqPor2rjffAcrgRMTksc2UotXzm1L76seZpx2xu9jGqKsH2gLFq1fOh51nBgc/SOCozvUFG3833kDCGD9WVb8PSJciQc2vYhExyjIfEUZlLHpO4/XHQUqvmeL23FsaDMIamAToeYa2aOWYKuXoIyzVpxbMXyU2TvRk7wN3FtdCdlr4ZZhncJObzu09pwe6OTE5/Z3f9Lnovz+Jk8cIjqfw22eYu7uTlNDRAVBiNZAoRlyhDLM0KQOlHuqAEcYtnMVie6VBDIxGMHDITyZTw1vkOMKjGepGkRMWVEA6RdatZMM0CfUqQv+mjJi73xxW9P0n6fqqbWhEYwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0ja4l46bovHUamJixyXL9ZMbe/ccnbK6cC/ZyNFSKw=;
 b=qDsdssODmFbjVJ8nzduNDQJsPLTnDKiUUkYNQUuKv12MVRTTvd5fFqeA5oYyMiqlWihZ0xnT60zuL0l5izrF3cuNeJq++vSAxp2U0ozrBI/ROTgjozzsC+qlGx9cmMRS6kphbANYeJRRMbyvz47Klq5nFi48N7hh+sATdj1JRvc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR12MB1762.namprd12.prod.outlook.com (2603:10b6:404:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Mon, 4 Oct
 2021 21:57:13 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 21:57:13 +0000
Subject: Re: [PATCH v1 11/13] perf tools: improve IBS error handling
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, namhyung@kernel.org,
        irogers@google.com
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-12-eranian@google.com> <YT+nwP3jrzgxEdmu@kernel.org>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <aa40b532-0e95-76c0-6c9c-a91d45bf3468@amd.com>
Date:   Mon, 4 Oct 2021 16:57:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YT+nwP3jrzgxEdmu@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::21) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 21:57:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc398adf-e871-476b-92e3-08d98781ebca
X-MS-TrafficTypeDiagnostic: BN6PR12MB1762:
X-Microsoft-Antispam-PRVS: <BN6PR12MB17626CC89CA718AD06E00AF487AE9@BN6PR12MB1762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iepx+cAkpHKDSphA0yVyG5P0SzfncpdWLSO50bH4iYLV55pEDGuNkhR95xIcQAvDxHxHG7UUd+P3WGwBGUvsjbuwz3J0TZ2yvRD4KkA67RjeElSOUqz3a0dQ/Y1CJaKyLiryAayk1mgxPiHkBT6AwntbDZk5mMsvwCMiW7JeCdYTUyEJkXg7CLyMjKKIx/pKOhRrzZO6df8mBEkkc5+QFCWC3aK1DrnIwTxs3ywPMNVPgoGuEd50HbYmJwc01hdHsc3/eor1fq1cmnSCqzDZSRGYZImAWDGBWhJzqALTxTJL72OM4OvEGWqMxkgGD7p4gW1Wn4RUrMDfGt5qJyyqvQ/znXMCKMGXAFLulCTEA6yS8j8lqZWusvagJGWKA2pIlM+jz8hGP0+mXBqajgMT+5GYjo5BNmvu1L5zr5fezM8l/HQgZibpH9JTXD1nGmomcilx/sgCkQMZOSKdc+hAPsa1MDKxoirlDYFh+HQbVk4E5lswP9zhZzAI1T/CRWfsZCRaY0tD3YrlhZR+y2fe/Oaus2alHJ9AWegmQl/CHHzOT+sLEvuENMnQY8jVEVI3Nphjcjuj8Qf4NKuYufRw6e/4K8RIT5Gk91/gXfo7Xck9jZwimQXF/+OPXsSOL1VzplCiDUgUbdJFo9q2JT4f5M1VFOIyZWCd8VJEiqEX9m5bUwCY+GEbmAEmSAYwItZCXjTzL3ioZk38dwEd0XHtxkIJYqUkhkyzCWNpq99yjQagFGC3S8xpWPPHj9R8dNOJF/8HUK8/BMPomX3SeNMM5b2EaPAdcG+MxyuoTHBv1WeiH2kJd2W693pIpRqHZs3Vpjk6sqm6K+Mg8RUNRo4C8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(508600001)(966005)(53546011)(86362001)(38100700002)(8676002)(4326008)(6486002)(26005)(16576012)(316002)(110136005)(5660300002)(186003)(66946007)(31696002)(2616005)(31686004)(956004)(66556008)(2906002)(66476007)(83380400001)(44832011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjI4SWQ3U0xBQmZwVllVQkhFMmtNQmd0L0hvNlZpY0N2bmNOUU51MXFpRVpC?=
 =?utf-8?B?Vmk5L1ZGL3pvVk9RVWl3SVQ5YXM0RUtQa05uTFR2bkpzdWtremprRWlLNnNh?=
 =?utf-8?B?SjNtNlQxRGFuWnJ5SmVvRXpmZzdvcGdSbUNqc2dmMmkyaEk3aFVQTXZiaktk?=
 =?utf-8?B?aC9pQ2FEejJ3WU0xbTlKZll5TUUyTjMyUjhMdldOKzdYRnEwTHZEY3doZ05u?=
 =?utf-8?B?b2cvSm9RYXFPL3phdXEycFZ3SVU0WTJzeTZMTTc1L1pnNEJEKzZNb1JzUWR5?=
 =?utf-8?B?N3NEQXMyMm1BVnNUNkpyTFZUY3M1RWVwV2g5ZGpLOXliUlQzRGNjajdNQTR0?=
 =?utf-8?B?OWs3VWZBWG9uUmdhbThPVzIxejUwRDNLY0VSOXBENkl3eThXYnBVQ1VnYlR2?=
 =?utf-8?B?MC91dEg3ZFBoS2lYZG9JWHBMUGNsUExpblFlOGkvN3crZ0o4NjQ4NzRseDJj?=
 =?utf-8?B?M2FUUmVjamVZaVpBbzJ2cmFBMFZrRGh4YWFVaWI2citaSWp2TjN6bzBrYkNT?=
 =?utf-8?B?Y2I0SHVOYWFZd3lIY2R3K0F4Y2ZrdDRMYTNrc256eC96bjRHZ21sdERWRmV2?=
 =?utf-8?B?ZEtTK1o2Rzc4Y09iR3Y1RTJTUyt6SEFrd0xSNk80NVk0NXFNTFI1WmF3T1RE?=
 =?utf-8?B?ZjEyQUVESGpoaHFKVWo3OXMxUW1kb3JIY3NwQnN5SzJJMUUycVpIVmlTdjlB?=
 =?utf-8?B?aHRibmVGQUM1eGlHSHg2S2JPZkx0K21zYnIvbjBUcGZ2TGFHZlowcjg4Y0py?=
 =?utf-8?B?ZG9GdWVXczlwWDlZekRva2l6RVFxRXQvMWZtZThPVlczK0todGJRYlhqdnF2?=
 =?utf-8?B?MTl6YmNra3cyemhjVHZmZ0lpSGE4U1Ruc3ZsR2JUTGNSZ0p0Z1FudEFkT3Fr?=
 =?utf-8?B?QWtOaUdBVDU2NGZ6YVgxNW1xSEZ2amJYMlcvb1Z3MlVmSUk1N1VnRXI4SGp6?=
 =?utf-8?B?VXVzZ1ZIZ0JqYktaQXJQaFBpSDRMaWxYcEJ0OTR4bDVOL3J0bVlUMUR0ZC9C?=
 =?utf-8?B?RVRsdHJleFNLZkdNR05xeUxnN01jcjNNNHJwMXZVMGlmQS9FeGpzcityZS8r?=
 =?utf-8?B?Mkc2bDBTdllsT3FtSFZYekx2T2RWd3pWWUpHdnNMUThEaWx3MW82N3V4VzdM?=
 =?utf-8?B?QnZZQUovRjJ4L3UwenZoc0pMT0JqalBQM0kySDFncldocnY4RjdkMC92Z3Iz?=
 =?utf-8?B?WEVxT01sVEZQWmhHdzJQcklWK0VwVE1vK0hCVXEvQmxkL05tSWtUR20zWnJk?=
 =?utf-8?B?Ni9aUU1MYjhGdXZxSWZnaWdyKytFZUpFbGNZN1BYYWVLcktGaDNmclRzN2Ni?=
 =?utf-8?B?bWUybklRZ3BwSFhjdGV2M3ZmYTNuWXczL1lyZ3FLSkpwWTFKYTV1VTdUTDVX?=
 =?utf-8?B?aEg5UmxoaXVkUjZiTXlkQkFCN2lQZG9MeGxUMEYzV0tIeWZkOUFwTUhwRUl5?=
 =?utf-8?B?elJVbWRhZS93cjVpVENjM0xvcHBaUVk2NW95R2hSM2pkTWtqU2Q3UDlqNnlN?=
 =?utf-8?B?R3hsc0hGeUl3UEx2QjdpQytLYjN3VjZGQWN4M1Rqb0oyNlV0Qy82K0R2R1Y2?=
 =?utf-8?B?aDEySVQ5WEhGUmRWNWNkUHdZUkFZZ1Jyc2hwOXlOcGMwY3B0N1FSVVZyRTBz?=
 =?utf-8?B?WG1oV3llUGpoTjZxbEV3dDQzWFNRRmhHWlBzNUc3S1NYNzVhbHhXbk1ZME9H?=
 =?utf-8?B?S3lGQkxETjJIZjl5MFpSNEU1enZaaFkvSHBVVlE4aTR6MVRFRGZjRFZJNjBW?=
 =?utf-8?Q?0t45hcb65zlOxS7mrX5Mxg0zWXVXf1sBxDRdrDB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc398adf-e871-476b-92e3-08d98781ebca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 21:57:12.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgcaS3COWSvuhTF1hQnbX0jnoHn7TCU25t49YUK00kb9g+bmi2Bqfyxd+pStnO9jS1mQdgzcti6zkNiPpjIWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 2:34 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 09, 2021 at 12:56:58AM -0700, Stephane Eranian escreveu:
>> From: Kim Phillips <kim.phillips@amd.com>
>> +static void detect_amd(void)
>> +{
>> +	FILE *inf = fopen("/proc/cpuinfo", "r");
>> +	char *res;
>> +
>> +	if (!inf)
>> +		return;
>> +
>> +	res = fgrep(inf, "vendor_id");
>> +
>> +	if (res) {
>> +		char *s = strchr(res, ':');
>> +
>> +		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
>> +		free(res);
>> +	}
>> +	fclose(inf);
>> +}
>> +
> 
> We have perf_env for such details, for instance in
> tools/perf/util/sample-raw.c we have:o
> 
>          const char *arch_pf = perf_env__arch(evlist->env);
>          const char *cpuid = perf_env__cpuid(evlist->env);
> 
> 	        else if (arch_pf && !strcmp("x86", arch_pf) &&
>                   cpuid && strstarts(cpuid, "AuthenticAMD") &&
>                   evlist__has_amd_ibs(evlist)) {

OK, I've rebased this 11/13 patch onto the new perf_env__{arch,cpuid} 
code, and posted it here:

https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#mc4c9c582e3816ab31af6d0187e6803de1a98ac84

The following 12/13 patch in this series changes, too, but since it 
depends on prior patches in the series, I'll reply-all to 12/13 with its 
new version.

Arnaldo, would it be ok to apply the two new patches that replace this 
11/13?  They don't depend on any others in this series, and it would 
save Stephane from having to carry them.

Thanks,

Kim
