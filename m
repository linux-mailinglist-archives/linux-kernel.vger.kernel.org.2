Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6AF332C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCIQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:30:55 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:54209
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231424AbhCIQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:30:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRx1VOQgAN/VHzjofDDI1hLHL04k2Pi3HbH0WDooQSIfmwhIDOpsrjovfrgVe92Kx5x69Qemm0XOyuba7MzeeuxcJCGs98btG8PoJwLw9bdeMVLiE5Omz5GIH5SCg1uRd4qFLD/j4LfFwF5sPndyfvie3SiA0AvlJcQdrhU15v7z6buL8OzhsS4qP26gim9hs54wfLwkrdoQaCdJ/5CeBJg+SmvwCgAgvQWof2PdzC6AtFUfWnHBaEbZ5ASo783RD/PWZRSrr0xRygY2NzUqWGMXW/cRam4vUrWQdfzDuoDxilJNuqHh4qzXGsLV4rChqcis2nQ+/AnqOuPe8CM+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJLCzuXadJD5Cb2xjauTr+bDtMGEJWLUdpxGeol8nBo=;
 b=leV3yWfwMNkiOAw40FQ2FYhxGQFbcXyCHuynV80IcEyV/9zNuaF9M68WRGeFqumdFE8TIyN89c0WIpH4Etc/amLhG1hPcuCNCFw43ej2/WmS5Bk1dLl34MjkNVFwhDWYOrvMnkSE4VcO8us8wkLYeDc9wfSuYIBdA9EXUYr1XaiaS8PsYxElYa96Epu9/wTA4WO0mxJ290lbfSlQK4Ht9tWEVhDGYcFdGp8wrteH7lZEB7JLw0cNyzNTNZ3kzptzemLXS2TjZNe/DwaKHCuuTrkgjzL3W4gMY0NyY8HmaHhsxB6vv1f2qG1gL5OOAZ/XfV0jyD+ItFMhI2eI3Fn5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJLCzuXadJD5Cb2xjauTr+bDtMGEJWLUdpxGeol8nBo=;
 b=1lBokpzAe38FOk/NtOMrqcJDsDl2PgBmIlIIMCe1Q2q1E+eBbXLXs4acUE8OWFtdPhPeBMZH+k3uAvFVmK/UFPWsbN6gfp7157Yd34QJJKsCWSj93rPQaNhLhE5nyOzLATVH41mOs2WiAjLx+5mXLxoMdvno6rf8tYSarmf7XWI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4781.namprd12.prod.outlook.com (2603:10b6:208:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 16:30:21 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Tue, 9 Mar 2021
 16:30:21 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To:     Arnd Bergmann <arnd@kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309032356.20800-1-Felix.Kuehling@amd.com>
 <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com>
Date:   Tue, 9 Mar 2021 11:30:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::27) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 16:30:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e361e921-b05b-4fc9-5320-08d8e318a234
X-MS-TrafficTypeDiagnostic: MN2PR12MB4781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47817FAD261B705F7F0C0BED92929@MN2PR12MB4781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hC7vQedGpXtxRy2apAoI/6kDRrjImiudEWGWeNFL5qhQci9VY1kNN5Tb7j/ay7JSoeYdxr25+4vJXG4ozMPw2jwYAPnF+iBDfazw35x2eihtXmjCrebLvHjuHpbAWDtRHVwoe3Ixj8TkFE27SYl8902RQwBaNPc5iRal4pDgDmi40cV1aFKWPvbE6RG/eewE8eWFlEoyd87MnRzSg74BEUeJqK6Za3hcNY1HQkOb2nM9G4R2GQcZZReeWvZB7GDKqQRWVGhsbHi2kD0j353QdXP8Zq1AA37qNDI7kyO+47GYIfec0im6GNdZ5a5wqww4UuhAfxgxegQ4O+pxJBETu0kb1O5ldoinjn2Qfijo9FsdcB8be7SMNpAhrTASwBUt4COoojt7V6FEQCQTwUJHQOtQsL9sVBShetPYdxZlq1G79jZorIzMIeY5UoqT/DKAwsSXPhIDbyuByvYoZBgiuKhKYolr6ZEnnKZGU8av43fhZ4WKN4bqUpbFJbrmgzkS21M8vgLxCkFF8f225mR2wqm/2lC+dy7kxU1fMNLx86NVeASui3Es08YGUSRBrgfRzBWClOeBLPp267sIWDGZqL/atNehNNtSnmZ4akMVg/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(6636002)(2906002)(86362001)(4326008)(31696002)(6486002)(8676002)(36756003)(44832011)(66556008)(53546011)(956004)(5660300002)(31686004)(66946007)(26005)(316002)(52116002)(16526019)(2616005)(8936002)(186003)(110136005)(83380400001)(54906003)(16576012)(66476007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Zkd0bGZmZGlBZTdLZDgzVGNpdllnYVJKSW9qaFJ6ZTh2ODI1eGRTZHdmbnVJ?=
 =?utf-8?B?OVNqYkROTm9kZWc3Uy9vYkVHUHpnOHNRYnNCTERzQnVRZTN1VVN6L2hJZnp2?=
 =?utf-8?B?azNoY2doTEowU0lqaDI4eEg0RW5kODJiQWRDMjVvdnZTcytpSkZnSGRsRUt0?=
 =?utf-8?B?Q0dsb3JBWjRtZ3ZFYnlYa1psQ0VhejZ4SU50Yzh6SGhuMW1hK0Z4Uk84UW42?=
 =?utf-8?B?eUtFL1B2ODNkVDdHTnNnT1N6YVJoVlVBYkpJa3p5R0lQMVdiaWs0V1U0akZm?=
 =?utf-8?B?VXFQSng4Z3F6OXFDUzFRbDFtR1N4bmQ0WjZzT09tU1oxRm1kd1h1WEVkTkEw?=
 =?utf-8?B?OFp5R3JFUDZKTTl6SDBBZFlZN1hxRVV5aTd0a3dSdlRTR2Q4ai9sUWprV1Qr?=
 =?utf-8?B?VGVJRVpwZDZ6VTlKQzN4UXlVWGdDUTJFTzZIUzFoTWlQaStRL1Z4c2tUWkxW?=
 =?utf-8?B?WWZ5VTRWMTdNSXBCU2tKclVHQ09JMHc5dW5iTDJ2R205SS9FQ0pLNVdCV2FE?=
 =?utf-8?B?dTNSNTVQdFF2Qnl2SVhzVWcxZEhqOFZHUkYxUGw5Qy9FdkZ5Y1VlS0dvZWk1?=
 =?utf-8?B?aWpBQ1FGYndjcDI0V3RXRElnaERLU28zT3VoUjhaQ3ZXSm55Y3BPUWp1K0t0?=
 =?utf-8?B?dWxTUkhlWG94QXZWb3lmaVg5ekJUbnJZMjRzaERZYWFLWVgwRTc3dTFkanR2?=
 =?utf-8?B?S2lmUVd6REVBSWY0eXVBV2RoZGNqTXpNN2c3Sy84OVV0cHgrVEd4cnN0VldV?=
 =?utf-8?B?dVJWL1h3MkE1QXVvWGRRaDVsY1grbzA2dy9YVjhHV1VGUXlNZVNEd056bnB1?=
 =?utf-8?B?TXlTdHNZeDVrSGpOcUJPVEpsZWhFVG0rZ2hqVENuZzBVTTRGWjF4V1Y5dFR3?=
 =?utf-8?B?Zy90WC9BUldIbU04MyszSWp6b1FsejlraTBlRGxqZVRJL0k0K0NpR2k4eE05?=
 =?utf-8?B?blhIemFvVFFsNWw4RUs0RzdTeFo0d0xhVEJzNmNTcGFQaXl6QkFxSnRyUUVU?=
 =?utf-8?B?UVV2V1J6ejRVZWFld016RzhqUmtkM2VJdmowM1EzelowNDQ3TlEwTUJmdTcw?=
 =?utf-8?B?aG9TelNSQlI1dDhoRWYra1pxdnVhSnpQUU9FRXN4QzRCcUtnQmNqMHAwbWFJ?=
 =?utf-8?B?UnRUN2txbVNwUGE2Y2xwaENmT2lZYVdOT3RKVnBtMFhwYjZ1S3gwc3FPVEhN?=
 =?utf-8?B?T3FOallsZk1CbEJmNGY1Zml2aDVzMW9TRGQrWklqRWxoa3pvL3labXRqSkM3?=
 =?utf-8?B?YXFFY0dqTWFvSTc2eHhGZTNHZnoxVm1MOHMvT0NQbFFQWmxBQTgzUS9XM2dv?=
 =?utf-8?B?dkRaVy9nQnVlcHVocGNUVnh6QkdEb29OUzlyQ21neitIYmluZUZyYnZoeU1z?=
 =?utf-8?B?VkxvNGhhT2VjVkFkUFJnS1pKODU4cnI2ekJpM3hrNnpPai9HVzhxLzRmZUV6?=
 =?utf-8?B?NlJHQVplSEdCUjhIOGNnREVic1ZUUkdSUjBwTUh2TFJEUmtDT2lsSkRNdzJE?=
 =?utf-8?B?R3ZqVlFMUnlJak0zcjE0MHdtUWlvSWFuV0xjS0owUTVmeEVqMEJYY09YTE0y?=
 =?utf-8?B?aW1mL1lKTHZabGZJcGplRnpVYVhCR1BZQ0xtTFUwc2Y4bHdyUGthWGRFcXo5?=
 =?utf-8?B?STdlZmRtQXhuWUt5eTczTjJRcUJmK3pIbzBwazNXNE5GT08yN1dHbXRnQWIr?=
 =?utf-8?B?Ym50eDJybXE0MWdZWjE4RVp5SWpqZ2tvQ0JTS3ljN0FQNkVmVU1kN0hzbkRj?=
 =?utf-8?B?L2VxLzQ5SEw3K3AvRy8yc3lETlczVXZndjRURno2Zm42NThxNCsza2RyeVNJ?=
 =?utf-8?B?NkZweTUwaVVhVmluaXRxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e361e921-b05b-4fc9-5320-08d8e318a234
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 16:30:21.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtVaESFokEJmqoA3qqAgppYAj91zi9F8SzJiN6XVgiuV5PfcZbwXpa2w54FlPPDCPwZMDfItX8z+7QslFowfEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-09 um 3:58 a.m. schrieb Arnd Bergmann:
> On Tue, Mar 9, 2021 at 4:23 AM Felix Kuehling <Felix.Kuehling@amd.com> wrote:
>> Using 'imply AMD_IOMMU_V2' does not guarantee that the driver can link
>> against the exported functions. If the GPU driver is built-in but the
>> IOMMU driver is a loadable module, the kfd_iommu.c file is indeed
>> built but does not work:
>>
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_bind_process_to_device':
>> kfd_iommu.c:(.text+0x516): undefined reference to `amd_iommu_bind_pasid'
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_unbind_process':
>> kfd_iommu.c:(.text+0x691): undefined reference to `amd_iommu_unbind_pasid'
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_suspend':
>> kfd_iommu.c:(.text+0x966): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0x97f): undefined reference to `amd_iommu_set_invalid_ppr_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0x9a4): undefined reference to `amd_iommu_free_device'
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_resume':
>> kfd_iommu.c:(.text+0xa9a): undefined reference to `amd_iommu_init_device'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xadc): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xaff): undefined reference to `amd_iommu_set_invalid_ppr_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xc72): undefined reference to `amd_iommu_bind_pasid'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xe08): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xe26): undefined reference to `amd_iommu_set_invalid_ppr_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xe42): undefined reference to `amd_iommu_free_device'
>>
>> Use IS_REACHABLE to only build IOMMU-V2 support if the amd_iommu symbols
>> are reachable by the amdkfd driver. Output a warning if they are not,
>> because that may not be what the user was expecting.
> This would fix the compile-time failure, but it still fails my CI
> because you introduce
> a compile-time warning. Can you change it into a runtime warning instead?

Sure.


>
> Neither type of warning is likely to actually reach the person trying
> to debug the
> problem, so you still end up with machines that don't do what they should,
> but I can live with the runtime warning as long as the build doesn't break.

OK.


>
> I think the proper fix would be to not rely on custom hooks into a particular
> IOMMU driver, but to instead ensure that the amdgpu driver can do everything
> it needs through the regular linux/iommu.h interfaces. I realize this
> is more work,
> but I wonder if you've tried that, and why it didn't work out.

As far as I know this hasn't been tried. I see that intel-iommu has its
own SVM thing, which seems to be similar to what our IOMMUv2 does. I
guess we'd have to abstract that into a common API.

Regards,
  Felix


>
>        Arnd
