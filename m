Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEFC32BCE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhCCPBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843059AbhCCKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D76C06121D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4YUdLZtUmXO9WwFQSt9D62WdcKyRjooT6jGkHiB8rClxuaIpyh64zl44zmoFOLiRfxT2qB2j6/3jyJ+zukxFK6NTMyhwnOidNk84vDG/qPcGiQhgw0XLZIll91LQCR8iHni0xpYsoyhPUpiITmMAC5RvM7Fkp1DaAKd1SoTSr9H7vNRHj/xpmXLQRG2SAuzQb0usAQjIrXyiRLrw+F0N2VFdx5wvOaMT2GKHJTEcyeQybCBiHqRUTW4B5Mii7rQO3mvHckTzyW0Ct6FhHsRsb9V6dXtHX9Ap4QlBjLegoBQ/AH/5EcuOOKm3h88oYFL5zI+RuKmh+8CH0YoERBYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h90L60eBns+8UXaMe11qcdZ4w5DYYE5GY+wsWGOZLx0=;
 b=JUfN6mjcnfBMYq//l5bBp0AJRlkMOnWa1JqTemFzLWp7w4fa1/iG9HYMzAO6XHFEx8qBVXKnKYUcy4n1jzGEHNin+XtSw3Xxf2mAYeegGAQABpP3+1WTjvKR3XvnQvAs/Sr2BUdNRbzEfcUOtLpqvEkNzBir6yq/Sjk8MSKEcy71x08SqxE0c1jbGlh5hFyD6quTQ/3Gb/SNpUe9tQJwwDY0PDe7XKAY8B2awNhDj56XqSid+8xK/EaD6rjnOVOZ4Evt+cNPB/REtB1nrrP4461fKNGob52ljvlxnnegjFtr3BwN2PU2AHgYhXKxGim//Ugt8uulQVd+3C4gdaJExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h90L60eBns+8UXaMe11qcdZ4w5DYYE5GY+wsWGOZLx0=;
 b=Y5OPB6gvsLQAv8yjC3joGklSWZV46La68gYnKNYukfo2jUJ1LumYbjeYHt2AWXQHqkoqlUCVfxmM0yvIe56JuLLQYjSXzHI60sAFPWE0KbNSULrzdAo5pyCRPZ17mQVqJVNZ3PufLLHmhD8GO1djLYZK4GSA/pvUU1ORjTPwPLg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB1680.namprd11.prod.outlook.com
 (2603:10b6:301:d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Wed, 3 Mar
 2021 08:30:35 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::ad02:3dcf:d3e5:b27d]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::ad02:3dcf:d3e5:b27d%10]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 08:30:35 +0000
Subject: Re: [PATCH 2/2] perf tools: Improve EOPNOTSUPP error reporting
From:   He Zhe <zhe.he@windriver.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org
References: <20210223082535.48730-1-zhe.he@windriver.com>
 <20210223082535.48730-2-zhe.he@windriver.com>
Message-ID: <0bf98239-8956-9d9b-64e1-dee31bf18d93@windriver.com>
Date:   Wed, 3 Mar 2021 16:30:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210223082535.48730-2-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 08:30:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8089d87c-7a69-45af-4f9c-08d8de1e9dd9
X-MS-TrafficTypeDiagnostic: MWHPR11MB1680:
X-Microsoft-Antispam-PRVS: <MWHPR11MB1680AE6CE2D2BE6E60BFBED58F989@MWHPR11MB1680.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkUvuEI+nDE2jUyVisMKKAP/ANHCSKnTXAte/QKlm6+o3mxFvIwoaR2ynBu6U62yy7x6/0jIu/oIubAzjiVLknGPjOx+CYooIuQdwOVd6I51BR8vCouFmLYvyFrUOXZaPE+tOgM9mZCu9zY4bn6BNjKcGXZEzSUZsU+ygg0ZGPaREu5e12+rMgP4lu5jqizSPg2dr/S1KUARhYVR9tGfuPFqsmeReR6j2ospMyH5Q7NgUf6lNU5/opww1j6YfClWexgfdXkY8HAbAuEAFIgix2QckbZW8O+bih7Y8M6CccGDPgIWq2BS/TEw1FFw0atKCXhG/svPzSe4a0rEU4SZLarNIQ9Wlo7TGeQ4PgaJjtHIW4IRms/o6MPDmz4FwYcJdJZqcAwMXvgDDOg/PSGG68AjISuK7BcB7XCxe5x3clg1HImPMwx81SOylB6bsz4XDsBe/K0apZ6NhsBSuLw7fEn/d+Q4VAHYX/lEU/GaXMdx6wLYc3atFd2GOTj45cQvWx8Cx4N5+y8rRfwn1+rlRPtkbH8yvBJ2+LqrxpCJWJ0olNj/TMzQ/I8aDZwOYHsLt8nCYvdT8XkzWT9Lp/xA/CzDJq/+2GRXhyF0XohOoO0f15KSKdTRJYuwu/TJJ1/YreJpftCnbxOE0giLBsy1pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39830400003)(396003)(376002)(478600001)(66556008)(83380400001)(956004)(16526019)(66476007)(66946007)(52116002)(921005)(36756003)(53546011)(8676002)(6486002)(5660300002)(31686004)(31696002)(2906002)(6706004)(86362001)(7416002)(8936002)(316002)(6666004)(186003)(26005)(2616005)(16576012)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFRScWl6Q2FjWEJQSjZOUUtJVWV1c0dFWS9WSFdkODVsMG0wWW1VV2hSYkhr?=
 =?utf-8?B?Q21iRHprS1FEc1QzSWRySkxHTW16ZWpkcEtidlVCWmxONUNmbkNXaEEydHY2?=
 =?utf-8?B?Mk1UQW9sSnFmZXFhOGx2bE52SG9kT1RybzhDSng5enc2RTZmZklzZXc4Rk15?=
 =?utf-8?B?Vy9sOEpOWVpXMStjMGczZElPV2xERmVLWHkwazR5eHNIVk5ISm52QjNsN1lS?=
 =?utf-8?B?MmFlcHVta2U4czEwY2dXYlBKZnR3dE0yNUE0R3UwS3NBWE1VZTZDM0tmanFD?=
 =?utf-8?B?L0FGQUh1amJ2OStpUXZoNTBUc05sMFd0UkhxNzk1QmFLdExUdnhXM1FTRmtt?=
 =?utf-8?B?T3lFem5WY1JPWFp2akF3dmJPOTFod2NoOGpYNHdFRTRtNXEyU0gwSVdzMWR2?=
 =?utf-8?B?TVlVWVFUN3JRcmRoc0hpcGxtQ282eGRERC9keENWRGo0ZElqN3hBc3FGOXAr?=
 =?utf-8?B?RVlmRVI0dElpeDJlNkljWnEvRVhGR0JYRGs0YXAyamJLbEQrb25kc3J1RGJq?=
 =?utf-8?B?ZDdZbEZWSml3Skh0VzRVVW1EdExGRGhxRVRsWk1WWFBVOEFpMVZsZVcwekl5?=
 =?utf-8?B?dWRMTVRjem5PVW5uWWJ4Y3ZaSjVCNHpnWEp1dzlBZGNndmZEVXp0TFlhNWd3?=
 =?utf-8?B?VEw2MHRSZUZWR0R1RWdOUjFSQmJ3VkNhNUJZZ2RXaVlUbGVjYnA2WHRBZWp1?=
 =?utf-8?B?SWdody9XSExCM1NrSkRvOTNlUHdraCsyN3FGNkwwcUJtQncvRDJ4SW9YUisr?=
 =?utf-8?B?Q3hrS3hWQnlXSlIzL1BtSkJsVlFvZnFTT1NQYm1TTC9obFlxamRUb2RKZ3Bl?=
 =?utf-8?B?bzNVQVdjdU9LVnBOMmpYa3VRUjVpWGZqek9JVURLbG9Eb2x0dkRtY3c0OFMz?=
 =?utf-8?B?NDRDV2VodmZvTVk0QVowL2ZwcEZtVkYxVENHamFJeGFnVUVuL2FDa2JFc1Ix?=
 =?utf-8?B?M1BTV1RXY2pIakI2TDhjV2dvVzc1Smw0U2JLOHVIcEFlZ29zTEZsVDBndWJa?=
 =?utf-8?B?bkdCZk1GbWhYem9oWlYxT3FudjhEVE42WFUraUZQRW5sSnNYRXREcHZpcndM?=
 =?utf-8?B?TmprYm5RZ1hwSHVqOFNNdGltZU5JSjYzZmRWK2xvT2k4QW5UTFFXL2JJZEJq?=
 =?utf-8?B?cVpvQUZmZG1sSG1QdmpmZTBTTjFBb1pMcW5LRzBtY09NT0lNSW53Y05TZ1RX?=
 =?utf-8?B?Mi9ROVVEMnNlMzhXYjl2RWc4QVJIUkVEV3dUQTdSV3JlSjNmWk83amZlSUpS?=
 =?utf-8?B?RlBBaFRSRmhEV3FJUUhBbXd2T0ZGUjJYcU1HTXdHVXRDdEZGbVk4ZjBiUVI4?=
 =?utf-8?B?Y2pKQkRidzgzTFB5SW05ZW5GUGJVQTVFZ1pGQXFMWXlmbVdrSHJWejJlVUtR?=
 =?utf-8?B?TTY0d0FSUlR1c01ONmVUT0U5dlkvNHJKcnc2ZFhHS2ZKMEFHTUxxUW5vdmlo?=
 =?utf-8?B?M1JSWW9tcFNXcVI1TExNOVM1UlVCNGU1WFRSN3BCMUQ5Y0ZJcnZMcFBvcEVR?=
 =?utf-8?B?QzVSSUdqUDE3QkVzSENSb01nOGl6UjAwdFBMM3cwUGM2NVBMS2JkQ3ZBYlBn?=
 =?utf-8?B?WWs3ZE8yOHladGlqMDNGUDNGc2lPNy96L2lKcTZzaE1hSG91dzhQbk9uRG1R?=
 =?utf-8?B?dEkvTkozQjVoVUM5Nk9aNjVTNmV6VFNLSEh0cU94THpJalBRMFZ4cjdCclVI?=
 =?utf-8?B?NzZVMWlmQklWeE1pT0ZCY1NUV0d0aU1tKzVzSW5pRnpodHJka05RWUZQdXFW?=
 =?utf-8?Q?tlokfN9r4auPniZ6QxvLAW/eWkEyRXYUAySuxsD?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8089d87c-7a69-45af-4f9c-08d8de1e9dd9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 08:30:35.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rpCczk8RPchqWWtE6iYDLWyo0H/5ZoPSz8N+wcQGeMUtZ+TRddP+XKy8ifhQ8qqK5qT7VkrnZpJYvbGIxNmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, add some supporters from get_maintainer.pl

Zhe

On 2/23/21 4:25 PM, He Zhe wrote:
> There may be multiple reasons for EOPNOTSUPP. Sometimes we cannot determine
> which one it is.
>
> For example, when we set up uprobe with 32-bit perf and arm64 kernel on
> some hardware that does not support sampling/overflow-interrupts,
> $ perf probe -x /lib/libc.so.6 malloc
> $ perf record -e probe_libc:malloc -a ls
>
> Before this patch:
> probe_libc:malloc: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>
> After this patch:
> probe_libc:malloc: PMU Hardware may not support sampling/overflow-interrupts. Try 'perf stat'.
> Some 64-bit architectures may not support 32-bit instruction probing.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/util/evsel.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1bf76864c4f2..aa56511ddf60 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2697,22 +2697,24 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  		break;
>  	case EOPNOTSUPP:
>  		if (evsel->core.attr.aux_output)
> -			return scnprintf(msg, size,
> -	"%s: PMU Hardware doesn't support 'aux_output' feature",
> +			printed += scnprintf(msg + printed, size,
> +	"%s: PMU Hardware may not support 'aux_output' feature.\n",
>  					 evsel__name(evsel));
>  		if (evsel->core.attr.sample_period != 0)
> -			return scnprintf(msg, size,
> -	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
> +			printed += scnprintf(msg + printed, size,
> +	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'.\n",
>  					 evsel__name(evsel));
>  		if (evsel->core.attr.precise_ip)
> -			return scnprintf(msg, size, "%s",
> -	"\'precise\' request may not be supported. Try removing 'p' modifier.");
> +			printed += scnprintf(msg + printed, size, "%s",
> +	"\'precise\' request may not be supported. Try removing 'p' modifier.\n");
>  #if defined(__i386__) || defined(__x86_64__)
>  		if (evsel->core.attr.type == PERF_TYPE_HARDWARE)
> -			return scnprintf(msg, size, "%s",
> +			printed += scnprintf(msg + printed, size, "%s",
>  	"No hardware sampling interrupt available.\n");
>  #endif
> -		break;
> +		scnprintf(msg + printed, size, "%s",
> +	"Some 64-bit architectures may not support 32-bit instruction uprobe.\n");
> +		return;
>  	case EBUSY:
>  		if (find_process("oprofiled"))
>  			return scnprintf(msg, size,

