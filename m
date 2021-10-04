Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E3421986
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 23:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhJDV7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 17:59:41 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:53729
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234095AbhJDV7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 17:59:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkEc00pmhcwn+7tDXREezMuuR3RmZ68OBUKK70sxHJO7TjkNF/LW5mycW80JW6n3n/Z7w5u/EQjqKOGjgFuNWFcYALGYngUv7OE6soNEO5Xw55dlGdcHBdUQxrUX8ytfaiJPo233wuvXYqFpNSlvCqyQBLYVwbbO+CxrhTLWjVlVaEOf1U9Juki0hHVtGCdZN0VKaxTbtvuhfqjCOoL0HWpL4jjIdU8oxYEijPyg55eCfvkCLow8So5I1eM+J8lJB9ebczCSJFZxCUyAS87RMRawEOFuEHkuGpivIZ5zDk+zhG2haX1ZU1yNxJMuRNpfpNO4q6sCDqs0ztqfFl30bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSckIldQlJyWJ9QXT6DQUwsGqdNUoWdPmWzuhS2FXj4=;
 b=ToZbOktKSjX2PhLvGllQO9b+cgFflJBPqyuZypvZ/cGYc3K6OnVot3EPdsQS94HIAgD/gt33snYLosxncimO/NVNXs2THLtj0GHKlOWydvpugnriIGrEhpQDZVmeIUET9qxnYLlbSIyKp+FcXdXbH/r9rF5lnWRB2PVymoEmcN1gxJRsiQFtKDg7J8EMab2S2grqed9NCrDRm3FXFg+Dc+Tewb4Yz6JcA9rtOb+QLPXlSiTWzy6P4TrFaYK3E/oqus1ykm6CtLhvirYRNRDrQDLakk1e1BbJCOLFxGlELsOc2BRGYtZfe3MkBtny4IsElRCCzH6DSm5+TpKj8JdGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSckIldQlJyWJ9QXT6DQUwsGqdNUoWdPmWzuhS2FXj4=;
 b=RAvkk7rGIvh4OTS/F2aFdvd7UBhHNf9EJ33nepwfhVe34V5OKma/QObmrqwtG74Ngw0ePG8YtBeWe2lRByV4oV1IRgXNUiW1w3K7IjfCu/hDvSEEpwrVq1aHsg2jvqDidwIb47ZF9RVezFUKRx1VcjRJHXbBJBVvyKux0SIHpfA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN7PR12MB2771.namprd12.prod.outlook.com (2603:10b6:408:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 21:57:40 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 21:57:40 +0000
Subject: Re: [PATCH v1 12/13] perf tools: improve error handling of AMD Branch
 Sampling
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-13-eranian@google.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <3fa173c8-2f36-adf5-c55b-ff356c49715f@amd.com>
Date:   Mon, 4 Oct 2021 16:57:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210909075700.4025355-13-eranian@google.com>
Content-Type: multipart/mixed;
 boundary="------------C84876E079D50284D4833363"
Content-Language: en-US
X-ClientProxiedBy: SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::16) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Mon, 4 Oct 2021 21:57:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5226189f-714c-4aa2-096f-08d98781fc44
X-MS-TrafficTypeDiagnostic: BN7PR12MB2771:
X-Microsoft-Antispam-PRVS: <BN7PR12MB27712942F3D3E05E804132FE87AE9@BN7PR12MB2771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: br8xUYLisnyICD/iRmcu8lNTP3v5KG/ZcAAzOJ6gCBWrhtW2Ocztpi0goCzZkNoJs8cmjuYLnWXTtabZqRKcunLajIphSRM52hEih3KSWj2jRDNGqP1oGWieW2BpHC+8osy9njsMH0+fXuyp711R0NUnZTT9Q8ov0DZECYXG34TeeOs0uQ9f+75QB7FiqFDg6K/7yB8acxHKHySbip5TY6oaNblG5mr+iiXWATE3r4J567XtgW5l2FDGEO9ByruIxa+vnxVYbEVkye9JhUae1ixKsJzEXsVHJc9ADG+cGOkZFiNZ2OEBhMzQH96RrOS0VlfiqX650Gm6ZdspJ2gyi9RgIztHQs8TMqU1g+X0B8D5kUe5fRZ/7XTtSNtRFYZo7FTtolWa4lcbl2XDQ8YAFR3n2/Z5qcxFuxHn+y9XPbbu+htx07yEsLRFKz0OBnMmEj1FaWoFD1r2EntI8tcVw+sNkKDIPaob/XR06hCmaM+cRN294mEAY+LCzLTPJFkFG7FMVIrpMC9wb6sjGg1PPhsBgyQgaoapen2Ctru4yZyfFag3RF4jzdh2bVPJWruRUbL/nXgPV143UO22XljFGgTL+Eusw7vY9VbLrGAr80FAszyvQEfgXmGmOzQTu6BJyiRcyjQrKn42psnvQ/NT828t2HFtra5K6d2KbLaTE7U8BWjc6sg8j0oJ5Rcdgy0ImkMf/Fia4HNJoZ4xGyVASPwGIIqTt8SaO3NNc1PPTnDUD9YSSUQSPN9I5wS8uFIJVDMLGmU8i0t8T5kOP6KA4RNtZ69rldYKjwuCkrqsHVFiIRnQ3bdujrRvZFaDIP/3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(235185007)(508600001)(31696002)(38100700002)(5660300002)(4326008)(8676002)(44832011)(186003)(66476007)(31686004)(66946007)(66556008)(53546011)(966005)(316002)(83380400001)(6486002)(26005)(16576012)(33964004)(956004)(2906002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9ZWlFvaDJWSGNmVUdVWFNkT2dNOHA0c05xQmE1TWRSemdzT2xTQ05DUVg2?=
 =?utf-8?B?Y3NtR2NhaXdWS2o5d3dIemhQUm9BYXRKQ0NWcWM4MEljbTZVNHBvbHpHMVpW?=
 =?utf-8?B?ME9STzZwUGFEck5mc3R4OXNwMmtZUmhGU2U3V05uVWNjUGJrWkFvTndETTVT?=
 =?utf-8?B?VG02OG1lbE1IbnE0dmxuaWZzNEEvM2QyZzNCTVZSM2lBN2NEcXBQSDlKdDY3?=
 =?utf-8?B?c3lEaFFYSUNlL2dLcFJEKzVJZi9MaTFxN3dvNU5DUDRDcnFoVEpsUTYwV0d4?=
 =?utf-8?B?UHB1RnRjWHZydk95Y3Z0VXJBTlg4WE1jVWJUcjFXYm83T1hOQTJCb3VDdUkr?=
 =?utf-8?B?aCtqeWQxZlZLcnB2TFJBRTkwQ1JLWDhCbkNEcGZsRy90NmVpbkYrMTZwc1kr?=
 =?utf-8?B?NndHU3Uzd1NxdUxtdFRFMjdGM0lxelZ4WEEzMW1tUEY0SlJnbTZzREZ3QzlP?=
 =?utf-8?B?RFAyTXhqTm1NeEhib2ljK3dSVXZ2SWhKckY2R2RRQi9pQlk5ajlXTjVkRG9B?=
 =?utf-8?B?WnpMUzlXemdDdHJENjdFMTZNMThpa1JwT2tFeGJCU2p5cGlvZ3AxdUlSN28y?=
 =?utf-8?B?RnBnSUR6TTZVakZiQkc1b1Iyb0o2eEpBN2grMk00aFVZclFDZ1FnWTZKYnBW?=
 =?utf-8?B?aWlDUkpWMDRsTFBoYzhNMkVOa1lIU0RUWHJ3R05pdkZiS3oyVDAzalVlbWRE?=
 =?utf-8?B?S1htVVVLc3o4VzEraXlzQ1F5VHR6ejRqTDFSL1dkUjJVMkJlOXVjdlczM0tV?=
 =?utf-8?B?NHA1WkVSRkk5Sm1HSTVRSklxVVlQejFKeUNnb2lsV0YxSGZvNnErUTlNMWRy?=
 =?utf-8?B?cVFjWlFoNTI3aTFuWndjTHJlZE5yZDFBVmRPVmRhUW1EY3NZVjd2MUNLQXoy?=
 =?utf-8?B?QStjV1AyYUJJeG1ZZytFN0FSSFFwMjNRZWQyK0tibW05Y3JEbUp6ZFpUU3FS?=
 =?utf-8?B?NWUzblFoYzhseTVtV0x4SjcybkwrUkpYaFc4V2RHNWx0cTFheG9odUU0K2x2?=
 =?utf-8?B?TGxpQ0JRemp0SzJ4YmVkSnM4dzVweVQ3MUFrdldqR1BJTXEyME4xU2c0MnU3?=
 =?utf-8?B?UVZPSGxUUTRUZGxjdTQ4c3JRR2NIVC9yRTV3SU9DSThTdkQwVVRybEVKQ0xK?=
 =?utf-8?B?MS9lTXRKWXVoY0I3bVNQRVdmWEJtakpkSVQyTkNzeVRsUEhiWnBsQml6VVJm?=
 =?utf-8?B?MXUweGxaTTd6Wm42UElPU21maHhLUllST2QxMkx2cU1YT2tVUnMvVFpuSGpL?=
 =?utf-8?B?eituODYwRWlrdnFjbWpHd05IaUFkdVZDN2Z0aDFqZkx6UGwvL3g1ZVh1cHdL?=
 =?utf-8?B?b1hrTXJYOW5jalN0cXVXYlNiaXFteGpPWCs5cVFEbnA5My9tUWpQVzBEQThP?=
 =?utf-8?B?djhzVmJCRVUvMHJKMUZZRGZSZjVxdko1VitiNWF6RUJRclo2M3NuVzR1bXNJ?=
 =?utf-8?B?eGttRXMxTHFaKy9RK0dsU1R0MHV0eEhTM05GOG14MUhFNlppbEhsVTZORFRS?=
 =?utf-8?B?K1Q1WjF1Y3lqSTRudEp5ZWVGaVJON3ZvSStOREgwZ2FPeVlZS3lFbFcrWE04?=
 =?utf-8?B?ZGRLSTVuem5LSHlzckZhVTNQVDUrWlI4eXl3aVRMcG1iT3BtYnZMV3p5bDk1?=
 =?utf-8?B?NjZRSHpsOGNtWXh4WGZlRlFPZ2tINktTbXdMa0ZaSlFwLzkxQUFhY3RsRXhI?=
 =?utf-8?B?amY2SnZUaXRTUHZTelpzTTM1VGtxNHBvTEpJT3V5WnVDUzZ0TC9CdXlMN2w2?=
 =?utf-8?Q?Vvj0zRJ17e/uV+ZP/KOyxlMJ9SeTJaasp9qa1rW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5226189f-714c-4aa2-096f-08d98781fc44
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 21:57:40.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmEKXHWIQJJdwnMpt3j42zwyZW10RyhFZQldTd4cX7G8JfwkhLqKeMLvUi3O+cxwa2a/sVodtAZApTOcVvAoEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2771
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------C84876E079D50284D4833363
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/21 2:56 AM, Stephane Eranian wrote:
> This patch improves the error message printed by perf when perf_event_open()
> fails on AMD Zen3 when using the branch sampling feature. In the case of
> EINVAL, there are two main reasons: frequency mode or period is smaller than
> the depth of the branch sampling buffer (16). The patch checks the parameters
> of the call and tries to print a relevant message to explain the error:
> 
> $ perf record -b -e cpu/branch-brs/ -c 10 ls
> Error:
> AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.
> 
> $ perf record -b -e cpu/branch-brs/ ls
> Error:
> AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---

Hi Stephane,

I've rewritten this patch based on Arnaldo's comments to the previous 
(11/13) patch.  The new version attached depends on this 2-patch series:

https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#mc4c9c582e3816ab31af6d0187e6803de1a98ac84

Thanks,

Kim

--------------C84876E079D50284D4833363
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-perf-tools-Improve-error-handling-of-AMD-Branch-Samp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-perf-tools-Improve-error-handling-of-AMD-Branch-Samp.pa";
 filename*1="tch"

From a4cbab762719b30bddec2e278cf8b8eb82e83865 Mon Sep 17 00:00:00 2001
From: Stephane Eranian <eranian@google.com>
Date: Thu, 9 Sep 2021 00:56:59 -0700
Subject: [PATCH] perf tools: Improve error handling of AMD Branch Sampling

This patch improves the error message printed by perf when
perf_event_open() fails on AMD Zen3 when using the branch sampling
feature. In the case of EINVAL, there are two main reasons: frequency
mode or period is smaller than the depth of the branch sampling
buffer (16). The patch checks the parameters of the call and tries
to print a relevant message to explain the error:

$ perf record -b -e cpu/branch-brs/ -c 10 ls
Error:
AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.

$ perf record -b -e cpu/branch-brs/ ls
Error:
AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.

Signed-off-by: Stephane Eranian <eranian@google.com>
[Rebased on commit 9fe8895a27a84 ("perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings")]
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 tools/perf/util/evsel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f8a9cbd99314..e1f5eff07355 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2753,6 +2753,12 @@ static bool is_amd_ibs(struct evsel *evsel)
 	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
 }
 
+static bool is_amd_brs(struct evsel *evsel)
+{
+	return ((evsel->core.attr.config & 0xff) == 0xc4) &&
+	       (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK);
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
@@ -2863,6 +2869,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 					return scnprintf(msg, size,
 	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
 			}
+			if (is_amd_brs(evsel)) {
+				if (evsel->core.attr.freq)
+					return scnprintf(msg, size,
+	"AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.");
+				/* another reason is that the period is too small */
+				return scnprintf(msg, size,
+	"AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.");
+			}
 		}
 
 		break;
-- 
2.31.1


--------------C84876E079D50284D4833363--
