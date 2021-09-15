Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0426540D01E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhIOXYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:24:44 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:15083
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229769AbhIOXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:24:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFR5c/sRqZgcYfaA1hG3UyNwDFUZanCkCwAli6GFCbzGIaCNFU8QWKP3LuTEw+eqflnRvcv7ED2z5ZK117DjxdD8mkqDmfOY3bqXHJodWekgDdV1GDD2ICnmF7whaPK6zFvoL0etZECTDMQMCFgi4uJUFtX0avTCi/qPBNc93clIdZ2LG1l/rM4/LYCHi9Bz0ml4cQWEC7/9uE4Rp3TBgWGeLgDxi1YGjmpMQ0QTgOPCmKEds6JroP40mrdoYOf/0gUKRMwV0ZX7cRHsdreM953jKdpWSRYGUHRFiwF98K1zPkiom+XxonBqE5UyZ7iXS6js5JrZBZ4Y6TPqTv/Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9clrjxKcMZqiCs6V1MdQ3Bej0mtz9GfVq5BGIU6lsgU=;
 b=OvpYqhmBqqE9Ygz1ZJ71gDtaBEskW4gU7hqU6yzCNHrXqSKmUEElLhCNBnDUikojM2Xn2295rS46IFWgIDZ/V18MJV2HAHIwR2TRAnCyf5rQyCqw2kjAbkStQeqU0fvDFkRWOxNY1fRjP21H0BKqwVmKvKwA6jSJsEUfhU63gVdK4QoFivJzr6/1qIjgl0XPVvnHew6czUIcnCn8OI7trjeKxOuDtfY5UQaSY3r9d/ggYRmBh/rk29/29VbodJjhcTZnAM0f7woLYkSu7LN0u8Oizwj+8qWFAdckvgnN7+uBlYOY4SaNmh8creoNN++w/lMtX0lXNHmTfXSzbo9XFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9clrjxKcMZqiCs6V1MdQ3Bej0mtz9GfVq5BGIU6lsgU=;
 b=cQPMUXhtN6IqaM6uRgyt/9EuPzYOrF0yV+pp9nekEzrOFOKaesruXVkgCTpEbzacw0zJFVcIohKZUfQoyQTY0TcWfIWt10HOQDXX30qShLoERq8DU2nIqHhd/HeAsqIaiTr5Ak1syWkEmfPvAHQ+1PkXaBuxoqSu/RcO0Bjku38=
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Wed, 15 Sep
 2021 23:23:22 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::3d10:92c3:3a52:77d9%5]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 23:23:22 +0000
Subject: Re: [2/4] drm/amd/display: Pass all structs in display_rq_dlg_helpers
 by pointer
To:     Harry Wentland <harry.wentland@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@kernel.org, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, nathan@kernel.org, linux@roeck-us.net,
        llvm@lists.linux.dev
References: <20210909010023.29110-3-harry.wentland@amd.com>
From:   Anson Jacob <Anson.Jacob@amd.com>
Message-ID: <1102cfe4-bbc1-913c-ad74-4a4f1ed39dc9@amd.com>
Date:   Wed, 15 Sep 2021 19:23:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210909010023.29110-3-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To DM4PR12MB5072.namprd12.prod.outlook.com
 (2603:10b6:5:38b::22)
MIME-Version: 1.0
Received: from [192.168.2.12] (142.118.127.251) by YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 23:23:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 342651f6-39f4-4a8c-9912-08d9789fcf57
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5391FC77CCE7E06D6108A252EBDB9@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xf9BaBY1UcAx8B0f1L/OeWcj9R6jS6WGPBuzIa67l5Z9waWoaXd5e6pDmo0hoYmtPHf3V0kJfg6kRWFRNLHi/2p8cU+usRb8EuXCZJztHg/w1GeB3YYy3tMLiN9EV2BMvziuhkwZ5ypsoS2LjA/BmPBtcxkbMfs1h4Om6gHNr7sNcIfx1ltbpWPvbINJig/a918z5eIZwAuzzZWWegGeZbXfKyhvtgjcvfIN8goXASn5fLGm4l8KPYSo7MzUG5RoAa5EWGS4e8ccnQ/QtSCs4UP+K+KzJlmKzXUByxCiQ0eOM2F9J5CCN7LiOLg67q+NVn1JYrbjB+vU0kK2qISMsz9fmQCnAiAafOnoV8CnXulLparCpcmi9HGRk+AfQR1nnnF9CN1iKbu+OopDdQW3mc6DLzIFFd2cNEmcBzlZph4m3VDC9S4BRcZLhV/U3KE4mh2XRt/aM4/9o/guU4BgB5FZpJkDhXUt9oJUcHxfeAqJIWAON5PL1CzD9YudO8YtaY7UqX6i9moBWulxzv+dvgtnqbHTGNcUJJ9XtY7J+eCTX8ButO+V0EQRXugZFmNlXiXyFEhv3lGP/++XnWenuwVUAnpWsqULQNBFedpecmTw6R2hVOhaLnpX/yY8eYmYy8cuQRO/r0JmIuMFn1xI56cMwa7qM4OtXIficSghQ/StKx6Is6ln84rhaRElfz6ALWBHUOzRLLSIrjYk4qULfYgYJL5k7MAFVWC8+P+TqWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5072.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66476007)(86362001)(478600001)(66946007)(26005)(316002)(31696002)(558084003)(31686004)(38100700002)(956004)(4326008)(8936002)(2906002)(8676002)(2616005)(5660300002)(186003)(36756003)(6486002)(16576012)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0xlSFpIQ050VHR1S1ZPdmlwdjUybFFxNHZsL0EveUVyTWt2ZU1QQkZFa3c0?=
 =?utf-8?B?TDU0bG1GeERaSDNZTUZVQ3I0U0RJTkppTyt0eHVjdDdZeEVtd2xGSHc1MzlF?=
 =?utf-8?B?UFFteVVKRHFkTFZSL1BvTkxkMFE5dGZmRE1veWVybkZWejJjTTNEck51OTBB?=
 =?utf-8?B?WHdjMlE1Mmh0cWRrcVdWRXovUGtlY2VTT0kvcjIwVTJCT3l0RSt6VHl0d21J?=
 =?utf-8?B?bnFCL0pOcVpMd1NDdUVqRk1RTk12RlY5clBtVGJEZjg5SkVuMWw4VEFNNEtx?=
 =?utf-8?B?Y05NYTBvWGJjTkZ4S1BlZ1RCdmhpSWdDYnB3MXk3d2hNenBETVBIbmxHWnBm?=
 =?utf-8?B?RENzc1E5Zi9pVTZSa2czSVB6bXRTWHJyOHRlS3F3RFFUMXZHL3lXN2V6bVgr?=
 =?utf-8?B?a1hrRDk5NHdWZVRyanZQZEl5NEhPQzF3V09Ub0lHS3c4b25ZL0UwK2JUMGl6?=
 =?utf-8?B?cjVSR281TVQ3Tk9CeVQvanBmYVcvM2s3OXVUSTZLNUF6cVZTZE00dllXcFE2?=
 =?utf-8?B?eTVtZVlQb3JkZWQxQ0dYekQvbkJMK3hsdURVZDJTbjJ4cnh0V2JyOHdUd21a?=
 =?utf-8?B?VGFKb1VMWHB4NUExc29EVWVmWVpBK08wV0lUcDU0bHBlWW42OURTanFpcVFH?=
 =?utf-8?B?QjFKamI4R0pFV0FFNCtVV2cvYVJyZmFsWXRpWmJCTFRNMXYwRC94UzgxOUxF?=
 =?utf-8?B?a1F3VjJERTBMbk9OMkNyZUFFTUg4Q0xyc1BhWHlJQ2JDMytsQnRKNGwxTnV5?=
 =?utf-8?B?K1NrWndqQkZDQmVqMmFpQ09pWit5OXhWV3ZROHRWa1QwN2tSaDV0Z2NXR1pk?=
 =?utf-8?B?NktOckRUT01zajZ1UE45Z1FPOHBaWHZkUnFUR2FnbkhTN3lDYzNFbVZaM21F?=
 =?utf-8?B?TXpWZ0M3aXZjbG5aZnZlL0d3Q0U0eFoxRHVWbTVqRUpQdGMzSmFZOEl1alNS?=
 =?utf-8?B?LzR4eGZKMnhEM2tyYXRkSEJ0WXdOaG9sVnBUSENYS0JnYnpKNDFKZThpbCs5?=
 =?utf-8?B?b05nZWs3VlB0SlVwU0t4SWorYlY3T1RITERObkkxcDVhSHJiMnd6S3dyaWYr?=
 =?utf-8?B?WmhtTnFsakR3dUh5WEZVR2RRTEhjZGxtM1cwWlpyZjQvNmhkQUtUdVhjMHZ3?=
 =?utf-8?B?YU11YnduR3c5K3VHSm9RbDJIQm04VUlWYUUrMXNwaFQ3S3NTTmo5VGhpOTZZ?=
 =?utf-8?B?SHo5NmtnV0p6NDR0NU5mS2lNaHRpa2dTMzNhSitjR3hIbmRGd1JaTEwrdm9s?=
 =?utf-8?B?KzAxaklWeHIzWFBheUh3eHZZL2JJV1JDV3VxVzJhem1HUG1sT05KVGtRbDRp?=
 =?utf-8?B?TTN0RWZDQ0FscjRsdCtmUTlEYUlzQ0cyR0ZaamMwOXgvWGRPMU9takM5L2JN?=
 =?utf-8?B?anc3bXFJRXJKMzJkbGFTTzdQVHRpSEMvQmk2MlYyOHY1ZFE0Z3pMY1lzWGho?=
 =?utf-8?B?c1RQWmJLQ2tmaE55RkJoWVVaQ00vdVg4a1hZTUdWREREa1MveWVqakpZRWFy?=
 =?utf-8?B?c3BQMklyWjZLd1FFUFUvdHRRcGdmN0s4RWh0cTZ5OE5abHZQVHlMMTE4N3h3?=
 =?utf-8?B?NENNcGxUY3BDMXI5eEZXS0c0MXdodmVDMmJZNDJNdmo4NGhJZ3hSclpWTXZN?=
 =?utf-8?B?RWFHSHZhSkdpQUJ4TFJoVkJSRjBpbElFOUV3NUtHYk5GMWpEN2dzTkUxVXhl?=
 =?utf-8?B?KzNJeHMvS1FGdnltMm94RkE3a0xtMXZKaHFrMSs5ZGZsTTV6VDh3OWs3NDZ3?=
 =?utf-8?Q?yeJzrOgcFC/BOeIlL3Bs3CjwLMz2tiD/H64UdOa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342651f6-39f4-4a8c-9912-08d9789fcf57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 23:23:22.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G+EFVGRP9WVQTXHY/M5nWTyLqUdDgq0pRoutbpm5G9GEgVPmvnWd96ejwrQMvAGXNrQoWonqaNbSgxRYvKfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry,

This patch fixes the following CID's. Thanks.

Addresses-Coverity-ID: 1423868: ("Big parameter passed by value")
Addresses-Coverity-ID: 1423870: ("Big parameter passed by value")

-- Anson
