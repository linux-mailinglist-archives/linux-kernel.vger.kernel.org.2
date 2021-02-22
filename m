Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC3321EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhBVSBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:01:17 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:25505
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231955AbhBVSAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:00:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGa7FGojeHbmFYFsSpx7IUY2UHBSxI+4CDMDKaby+ccue9T56HYZmLDDCX/Sk56S9OETMHhUUek1gBiXAVLtdQ1cI4jUxgQNwemUsJbm9hkzMdYlPAezWps0jDDT/Fs4zVsmd8vprX1GKyyahcgFzMFi7dhiXqKu29dr1cadL1BTXiByGs8ph6DMmFPcWPuC/E3mWIv3DPdHACaNFI6+xPFmGf3TogrgIEkwqSZX17kx1uj9BVAzoRs9XdFPTXReyLF4DbNyHI8FFmZuCFNK8AaTJ1fsWqYnDBpBckZrzuYHaiwwyV1C8OLF7Mv2CQUfx1/S8j3fpYshIfNN2fxi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/rPX1oc6zOhNtifGe8ZR8LE0ZdRrGRB5XchlZWIq7U=;
 b=V3AJf0CYWXCAo6dR2h6vcCQxfnEwq/Kqz5JpROqYNrcqJ9WpesyFBl8b1Bp1c+3kCbfXPEF2kbPZgmILRp1q2/Jr+DsmQj37+AM8TdAPQ0FJeKhGx+Rcskq45nXtJTEDRR7mf7Wo53HXKD4BjAyVUYcmDnN2VJCGkftD9VyJuoqr6I5nDs4pquQTmRFF7ebAIpT2b2xQK9cuwERllkrUSpZFqfo0ZKFQoARVQ8MjdCgmg7h/1jE6wMXNRBW3SaI/FIn39/sd82Sf1XPbkCO1k5WQ8PI33s2xVsr1alGNDqt4YVcjh/IB15k9BgNBINMKkb3arw7j1wvYTYgtWiP3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/rPX1oc6zOhNtifGe8ZR8LE0ZdRrGRB5XchlZWIq7U=;
 b=Sbe4QlQR1kxVvlGiNkHfD+c5jnbhO0RMhDqCSqLQ+hHhC5rvYr81JYr2dvI4sZkAAr+48gHxMYCgeJwMvDz8RzMeaqSyrqflWihCu0NeU950tY/UIhSx3d6app1OUn/CAid2Z5YJxxT3Pp73hccWnpsLilIfC9kXULxWIOqQRJ8=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2824.namprd12.prod.outlook.com (2603:10b6:a03:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 17:59:52 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 17:59:52 +0000
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Alexander Monakov <amonakov@ispras.ru>,
        Joerg Roedel <joro@8bytes.org>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
 <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
 <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com>
 <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
 <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
 <alpine.LNX.2.20.13.2009172052480.29869@monopod.intra.ispras.ru>
 <23d42e73-91ac-8f47-af64-40edff8bc027@molgen.mpg.de>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <290635dc-723e-a55e-8447-95cef703b090@amd.com>
Date:   Tue, 23 Feb 2021 00:59:41 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <23d42e73-91ac-8f47-af64-40edff8bc027@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [124.121.4.202]
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (124.121.4.202) by SG2PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:54::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 17:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61d55878-cb25-4501-6037-08d8d75ba735
X-MS-TrafficTypeDiagnostic: BYAPR12MB2824:
X-Microsoft-Antispam-PRVS: <BYAPR12MB282467083ABCDD5C4104AC70F3819@BYAPR12MB2824.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZdbB9BoO/jbwx1sBmE1dHjtU++xBcH7REhY+KqZGK0UuK56+I1zlSTHNIN7vjS6cqPSki9gUw2nf+hd7Qidrz595uuNeXh9f+UG8wekAMwf3GAJDRfYrsFSoqjs7gLA6mR44uqVadwn5a2oAM3eTEKMQHQ/HW3Anm5fFSfRuXFlHoGLRP/93T7BKnYcGSYI2n1XzAH+GYEHa3V210HwKTiS3EwjEoQlaMI7rIwxiy9kc9cikkVBfq4mJOuJwsYvVXgpTF451XRRUJ0yZaAq0U5nOPojgMqrf6t+mSsck879qdaPDP4mP6gbtWqgK822KbVQw5hxLYZjBT+WiJXMg5GS44vQQ9ZZ7ApwD5KPhkzpJP1we+CNWLWdr2sEVNI53YK54V5urNarq39uX0lLp8Cbs5v5UTeJMabM9VyKLhDBNQvY8ckFSOqZMaB852QtS15ZfXOPGrU9/h2TTgDV5SOFwW16hnbEbYiHfQ8ab+K/ofB6hh77IBldQhoGmy7c3tXed6HJ2b/O+OWjc+Wc6FSkfmiKAHp24SpI8UtHBRqTa8qlSqZ406f5tkYccmWY9MaGwHo2Jdjo/nHk6OQa3/WRVpH1z1qIIoyMELOT2DwJ3PhxQXOtmkmDlQTCidllRWEYKzj/UJdhPtHJ9ehZBsqKY9xjGqpXX2sjluTnH2+MD0Xn7BcOoUOf0clAIqh6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(6666004)(6512007)(6486002)(86362001)(52116002)(2906002)(316002)(31696002)(31686004)(36756003)(6916009)(4326008)(8676002)(8936002)(16526019)(478600001)(966005)(5660300002)(66946007)(53546011)(44832011)(26005)(66476007)(83380400001)(54906003)(66556008)(186003)(956004)(6506007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWZZanBmWUJ0ZDZXb0doeTB2T014UThOTDh1UWRqSWdLaDhCWkRnYWRYbUZz?=
 =?utf-8?B?Y1ZlNlVnUWlqeGc5dUZRS0hldXZEcVZMcTkyYlk2dThKOFZldXAwVTJYVGd3?=
 =?utf-8?B?ZU50SWptbGVXZEQvU1d0NGVlUFV4d1d2aitpNlRVdVp2OVFFa28vdSt3T0lz?=
 =?utf-8?B?Tkd0dzhJTjJYM01LWVI4L28yMTFIOWNDenN0bXlHaGZXMkRjOVNrdnNwc2h3?=
 =?utf-8?B?T2FDN1pkenRnT1p3Yi80a0NmVllTOXpMZjRUZVdLb3NpMEt6ZTZKQWZNczZH?=
 =?utf-8?B?MVJPVUl6ODRrM01NdXdlaWJ1Z1IzaHpHWnVFTlRtZTNqRmVBeExqelZ4b1pR?=
 =?utf-8?B?VDBySVlGTDJiREJEU3RBdURlZUN2ZFV6MU9JVklxNXR4clBGemhJcDNuNWtP?=
 =?utf-8?B?UlZ6SUZTYWZlazlTZTlUdHdoUW5IVmtuL2xVTWluM21XajlHS2NiRnFDb04y?=
 =?utf-8?B?eEJtT2M4NWpvWmNvazNSbHk1V1AyeUVaYk5IbzUydTRVODlMeTljSVB3OWx3?=
 =?utf-8?B?UzJONmJKTm04MmhtOUJCSGNmN2toZndpWXVwV0JPN1J0YjQyYytlNTZsRE02?=
 =?utf-8?B?eS8xUTZKMHQzS1J1dVpBLys5eDI5QUNrTEtmTG1UZTJmckVKTy9saVhPWkpR?=
 =?utf-8?B?c2lpQlVwMWxVNlhCSEZYWXB2WXNWL1dvWUVBdW5MdjVpTElSR3A4aklsVEdx?=
 =?utf-8?B?UU1FSEZsTU1XN1N2ejZNQ0R4RjFQMTdaQmRJVEV5VDdvSkMrc25CNlplUVM5?=
 =?utf-8?B?QUhXMzVFNjAzdmJMRG15V1JYMC9XMlVSLzVxcW0zL0dUT3V6b082eXFheUJX?=
 =?utf-8?B?b1BTMmtVK0xlUGlSWkpkb0YzRXZHckRXV0JNVDZHSW1oSkFyZmZTdlE5SjhW?=
 =?utf-8?B?RVc0MDZ0NkxKU0NrM0FySitCSitVYUN2N2FPemVGYnZ1MFRTenM4OXU2Mlhq?=
 =?utf-8?B?Ym84WWF0VnBYNllUVUhzNGhGY2p3RkJPV1o1S0RoQTAzb3JHbkZ5ZlltL2hD?=
 =?utf-8?B?SzA1R0JPTDFsczYweDRRUGU3L0JXQVRBZjhKTFFJZVdVckQ1aldsTU9aYkpL?=
 =?utf-8?B?UURuUVNMU1VnWXBqYmtGMnU0Y3VsQm5GYnd6YUE3d3FjUmY5TndOd2lKTEYr?=
 =?utf-8?B?SW9KeFFxNjhKdEdZNHJkaGdwR2ZGUkVUU2dISlZjVmswbjZzK2ZDekczWVVQ?=
 =?utf-8?B?WlNlMTZYeGMwb0E1NHlYeE5xTVJESTAxVEx2YlJNZFh4WnFNZjArcW1DVTc3?=
 =?utf-8?B?T0cyNVRSQWhQVUNyWjZyaU53Uy9nVWIraGVQVEgzb2pjckNONkJNS0txU1ND?=
 =?utf-8?B?bWc5MU1TVXdOdDRSZVJWMk9VcDNpUm1xUnovcjVBTWlYVDA3eU9SbldwRjRt?=
 =?utf-8?B?clJyeTgvQ3lzNWRhQTQvZTJqZEliRWZ5c2NaVGRmU1hwMUNCSG9yNGw2Z3ND?=
 =?utf-8?B?YWdSemRjL3N6bXJ4WDRwYVM5a3kyQXNSaklaQklSdEVsS01oMC9YcFZ3MFEy?=
 =?utf-8?B?Wmg3czB4MmlsbmMvSUtDYWtLUkZKdkF0NHJQV3RFWVBib2N6ZFZIbUhzUXRq?=
 =?utf-8?B?OGlQMU5NSWFrM1NSQWRqRVhVQW5ZbFdaU3ZnRC9waytsODBIaXB0NVVTSDRF?=
 =?utf-8?B?RlRySmxrWnNla3hidVNraGl4dU9SWmJwNk1Fa0ovN214eW1waXJPTW95VTJF?=
 =?utf-8?B?Tk5pbkh5V3FBYnpTOWZkNi9IZVNDVHFlelR1cTZVQ1YzSXUwa3JlVUNySkpC?=
 =?utf-8?Q?Ko2YE7MpoyFfbUceKPrPOhMdQvbzdHe9fOEmYrt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d55878-cb25-4501-6037-08d8d75ba735
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 17:59:52.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxTwlgvmZScItvrx5x6vCufP8BgGSRcddj48ZDre3yfnPDk+NkyvBrPKk+MMm6f4Nlfr8aJ+ccrqpsUh6+ixsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2824
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix has been accepted in the upstream recently.

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=x86/amd

Could you please give this a try?

Thanks,
Suravee

On 2/21/21 8:49 PM, Paul Menzel wrote:
> Dear Suravee,
> 
> 
> Am 17.09.20 um 19:55 schrieb Alexander Monakov:
>> On Tue, 16 Jun 2020, Suravee Suthikulpanit wrote:
>>
>>>>> Instead of blindly moving the code around to a spot that would just work,
>>>>> I am trying to understand what might be required here. In this case,
>>>>> the init_device_table_dma()should not be needed. I suspect it's the IOMMU
>>>>> invalidate all command that's also needed here.
>>>>>
>>>>> I'm also checking with the HW and BIOS team. Meanwhile, could you please
>>>>> give
>>>>> the following change a try:
>>>> Hello. Can you give any update please?
> 
> […]
> 
>>> Sorry for late reply. I have a reproducer and working with the HW team to
>>> understand the issue.
>>> I should be able to provide update with solution by the end of this week.
>>
>> Hello, hope you are doing well. Has this investigation found anything?
> 
> I am wondering the same. It’d be great to have this fixed in the upstream Linux kernel.
> 
> 
> Kind regards,
> 
> Paul
