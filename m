Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6310132BCB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbhCCOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842989AbhCCKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:26 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03on061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe09::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D1C08ECAC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V232EsKkFBTVpnt0R31nSNuSWOEyQtkjaMq/GSfNHjw=;
 b=13KR/VmR/G9sa9qveAKyS7rXbxdU5rHjS3NPgGkalY2Dxdnoc9//Jq8jxzghlMUgWomz+o6EHzEiFr6hayGR3+wbicksqA6ffmbNXbktFAGopRHnfRRe/eMJDO5v9rWl6KpWxru8wnIx3qjMnaLBVynl492rFvWckQVxaMdgpRM=
Received: from AM6PR0502CA0051.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::28) by DBAPR08MB5655.eurprd08.prod.outlook.com
 (2603:10a6:10:1ab::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 09:55:24 +0000
Received: from VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::99) by AM6PR0502CA0051.outlook.office365.com
 (2603:10a6:20b:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 09:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT005.mail.protection.outlook.com (10.152.18.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Wed, 3 Mar 2021 09:55:24 +0000
Received: ("Tessian outbound 9eff4099a602:v71"); Wed, 03 Mar 2021 09:55:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6a95f1a8aec8f799
X-CR-MTA-TID: 64aa7808
Received: from 7b13f9fd79ea.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B117D26A-A390-475B-971B-BFDD1C8485DD.1;
        Wed, 03 Mar 2021 09:55:17 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7b13f9fd79ea.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 03 Mar 2021 09:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W08h6SHLe9ixoo2IBkg/eTx3MV7CCHEphfQMymJtdVEuZJOkxfLUqUtj31XlNv6nhLOTIV1OziXw8tx3nnTQqcq680wIcf99BPGLfwoxl5XQq6FqV9DPOhxNBwd6ZPBDpph7NFR7ZK/BF6hHPufJESZqRwofccDaxpy+abQABE32La0aI3pVmyMVCTS1bGnlbt5ntwxUfNZEFackJqVe2uBzbpmXEItiNtayzuwpsJNHAlzeZGT48HkrIapUw+AmMxF/u4zoNbzCUDdw2LJvBhTfUm/s6vMKWl/Rtp6zJGtaf4S9wqyUGqr3EN8h63BIWVf92ImJQo6hAPjq5OYXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V232EsKkFBTVpnt0R31nSNuSWOEyQtkjaMq/GSfNHjw=;
 b=YVOHu9SCkvrpJCPReOovgcMl+ZuCmQAw4NSx//qyFNZ4GHkaMiz/l64idO4IdOvIn5CqXpiKjQxurxP5nEasULWL8aAXoL0xSKmaE8v+l869EV5sYPNa6JlorVGIPutwa/WrV1ZTOLyAsKri4XygjM5S8jEGSCOggEexRdcNtuqSQF5uMyDBVZtfznGS72R7e3TRBphRKFCrG/+WJUxdaCtQx6UgRlzofwmzdhJvcCLuwy5fEF/h6g8V7+Rk7lxiY6OXYYf34faC81pj49bTd0j6IsQ6F8MN4Fi/uVIbYIp29kM+jqnGCU7oV5M5UolqRy5iOA+1+4SzURBnZxQEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V232EsKkFBTVpnt0R31nSNuSWOEyQtkjaMq/GSfNHjw=;
 b=13KR/VmR/G9sa9qveAKyS7rXbxdU5rHjS3NPgGkalY2Dxdnoc9//Jq8jxzghlMUgWomz+o6EHzEiFr6hayGR3+wbicksqA6ffmbNXbktFAGopRHnfRRe/eMJDO5v9rWl6KpWxru8wnIx3qjMnaLBVynl492rFvWckQVxaMdgpRM=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM8PR08MB5633.eurprd08.prod.outlook.com (2603:10a6:20b:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 09:55:15 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 09:55:14 +0000
Subject: Re: [PATCH 1/2] iommu: Report domain nesting info for arm-smmu-v3
To:     Auger Eric <eric.auger@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
References: <20210212105859.8445-1-vivek.gautam@arm.com>
 <20210212105859.8445-2-vivek.gautam@arm.com>
 <28c0204d-2a5e-4eb9-d869-9dbd6edab55a@redhat.com>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <203f0aa1-e7d7-f27f-fec8-6583c0425ebd@arm.com>
Date:   Wed, 3 Mar 2021 15:25:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <28c0204d-2a5e-4eb9-d869-9dbd6edab55a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: BMXPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::24) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by BMXPR01CA0060.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a8a1625-1d54-40ef-2a34-08d8de2a7742
X-MS-TrafficTypeDiagnostic: AM8PR08MB5633:|DBAPR08MB5655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR08MB5655F6DA60BDED364F5EE4A989989@DBAPR08MB5655.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: n4EigMvLDXJ66nb704v7mpKUc7HUI/iiVvPuZm3UKc7MN/JX8TuRLIBLV/kT6V+jitn7/4uqQ+4HJCMKmMJaPn0eO+PAs5JxDMJZrAVvKvTsq3Oj/2BjZyw2YiTZV33zhu6yQRqDN+5i3T/GpfLbwmPPxczLIED8Is0ZXiKiXHINRgZNYFvxSxoDc+803n9LTnfxZrJjLT0iPn6GGAKVvNIIRmd8jLnJx98c/EAbLsUUBmPTZMYQdUkbhseAAQ8eneXHvdmy02bqg+zr7SlfO+rME+kCpe7L0fhr7aWV8ySka+rgDITZ1vZLCsMwbIXRQeXL3HNeVFNkWeMMFgeYq3KCiZHJKtwnCSmsOamKVq2xLB91zY1n8CBkk9cSSNk2iKljVmQLfLkWfCKCB9lQTFQ0xdIE4MbXfEt/EA6+ULHHfxN4p8iBo/mVirGvbp+LriouyLYER7VUwbGVaLoVDRj3y2Y7p1j0BLL//kdLJtnSbM0WjHqjEin3ArOm6nEWGwL8nVWfPpm7/X02fw72sJc7eJhimdFeXjZg1cQ9xGLWZ8ZB/g2fCJZ6LCCig5Db0aCh/AljGYTJLElH856C8nXtMURSxBwiH1l5vNDQAbrg+z+DOV32HKR0GlgO9WVzHf8DxGl2KataR9aL1D6GGYbpACkevgiS8L/Ks/OKM8PNzWcbbP8jz3+5HCcY9rFq
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3268.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(5660300002)(66476007)(66556008)(966005)(4326008)(8676002)(83380400001)(16576012)(66946007)(31686004)(316002)(956004)(31696002)(7416002)(478600001)(53546011)(2616005)(6666004)(52116002)(26005)(2906002)(186003)(36756003)(6486002)(16526019)(8936002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmJDbGpRUlRlQURKYjJwQ2N4TUpUOVRtR3A2blBNQjJSSk9aTXFweGJDV3k5?=
 =?utf-8?B?aDJWamZzUmZLTzQ3Yi9JWHlLQkFrSE5hYnR1M0ZoUTU1dWlKVUJPN2p6VFMz?=
 =?utf-8?B?YkZnc2NreVFxWDQvUzQxWU1hT2FJaTFSVDE4M1Npa2ltOGdvN0ROUHlCQVZq?=
 =?utf-8?B?WW1JZTkvbnA4c2orRXZRTkxBSzhvTDBRbnh3c041VVBKS25WU3RZVUJ4V0pm?=
 =?utf-8?B?c3JSOGV5aW82TFFpLzdkYzdkajZwVDJYN04xVXlabVdqZWZ2djh6TTBUb0l3?=
 =?utf-8?B?UUNFdjJpSHNJSllZMWJtYlRNUXNmeWZXT2ZqWmdDLzdmZzVHMlFxaDNBajdC?=
 =?utf-8?B?UUkwcHEvUDhnTHk0YVg5TGR4N254OXExUk5jYkJ5cmQ3aENmZHBucXJaYW11?=
 =?utf-8?B?aGl3djJtMWlnaUorWjN5RXUrSFJxQ2xPZi9GaHM5UTlCbUhKS25EbTFLSE90?=
 =?utf-8?B?NmZ0T1hxVWtSY2ZmZ2Z1WXdoNWZhV2lNdnZoeW1PL1FvZHp4YVY5cks0SHVN?=
 =?utf-8?B?eXoxcXI3aU9SekxEZmpROUdtQ1ZGUlNaWUpadWlwbFpCSkU0MXNadlpYY3kw?=
 =?utf-8?B?dVdKQWx3RWwralZya0tHODF3bGQrUkN6OTZod3l1QmUzbmtWVjhnaHFJK2N5?=
 =?utf-8?B?TXgxN0l5YVJZY3BRM0xpemFRUnFkSGZlN0YvSHFZbWxtcVhRWXZPYUdjdDlK?=
 =?utf-8?B?cVROaWZYRnd1dUsxUURtOTNtT0ZoT0gwZGc3NThaNlMzNTdYTU9ZUjc2WjJy?=
 =?utf-8?B?YmZjSHpBRFhFTVA0WGdWS0NVdkg4dHRxbW5lU1JWbGhRdytaZ01aTHZraGdG?=
 =?utf-8?B?U0djK3NtbkNKc0pCZWR3d3dabi9qWUtCb3RqaFd1NGFmRjZWamExcnNsTHlZ?=
 =?utf-8?B?VXVQNXN5NWFmcjVqYUhqRkhUUGw5SnkxK0ZCY3RBam4xU1lLcUxvclU5aXBz?=
 =?utf-8?B?d1FTYmZHcG5IdnhVUHFJV1VNbjlQMFFCQnZCZmpNR0Niekk4YU44dmh2czFw?=
 =?utf-8?B?dzVrdWxDeWgyUkNkeWVRS1Y1T3VycVo1K3dMYXVMTk1vVGhOUkpvSzFQaWYz?=
 =?utf-8?B?d0lUbnlTeWlNSisyNG1rYjRGS0FtbnduMStGSjVZcndhVnVuRVppUSt0VGRp?=
 =?utf-8?B?NlMzREtLdXJJR0tqdWdFVUwyVTNvVU5oSTZRNDRLRFNFZzdQMjZVY1EwdXE5?=
 =?utf-8?B?TmRUZzY0eXQ5di91WlY1cHpTbXlsUmN4cHdVZkVDUDRlblZiWDZVV3JPaVBQ?=
 =?utf-8?B?Z2ovUndLUnM4Qk9PWHBYaVRMTXJtT3ZrRERFSGljYUFaaUlQRXlvQ2x4RHhx?=
 =?utf-8?B?Qk0vRks2OGd4R2dLbXFOeVFnaUFRVnQ1NkxYRnBwUlBDaXZ1T1d0S3FkZVhJ?=
 =?utf-8?B?RS80L0hSUVF0L0dnSVB3NFUzaVc5Z2dQbCtoOFBmQkgwZ2RtWXhPZUlmSG9q?=
 =?utf-8?B?SnkwY25FbGFZa05Qc3lWSXUvaHdmZ3lJU2grQjgwUTZtR0ZnUFh2dDFhbG5k?=
 =?utf-8?B?UGd0b0NzSEU1WUxkc1MvcDltUXVZREMySnVQL0RORGpJbkM3QXJmS0dqb053?=
 =?utf-8?B?b3FXcEMreldwQUpkNzgrOTZNdWdaTmVTL1FwVUtENGFJbkp2eUczOExpbHJ4?=
 =?utf-8?B?WWJzekdxT2ZnRWZUbzJsaG9vVktQWGFCRG0ySm9VSk1acFNKUmJzMjlISWhF?=
 =?utf-8?B?cU1wSjdrOTFBREVWRlFoSkRPbjRFZTlveS9WL3QxZ2VwZEEzM3I5ckVyRTJ5?=
 =?utf-8?Q?oFcNUvjTeBikT4FjnihzmQvPi3oq+Kg+B3v0BPe?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5633
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 889256c1-e286-431c-f764-08d8de2a70f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8hEwnyb7ogs260ZNm12gjYVohBez3q3Bsmc1imqIbTzmsyj6bZVy08SjiRU+oqWzs4TGXgpSlZVn6zSrySm6SIzT/DFwG7U2rCWc/kqZY4ArnRLVor08Vzr44gQVMFi9wmSXMcATRyXpNbTVkWLh8bHdZZJqL6d/Mjl5A3/2QGNpSSicPWrkWN4oSZyztKiXMSawcH+td5pIFgWTpRXLJG2mcaT7Ws2UCDzSxJBs3HKOzu0mqCBViYQUZfV6jmHcAOrGQGAyFzwotkaCC8e7xTXLeVA7hwAE2xWsdkD7taQlkxeto3ewEWTiXnTtmSbmw+zvMwClhrJhpNT1wMns28HnU+9ppKX6NK/l+JB4GsQrto3hygeqc3O6Ku8vmUn9cDnkxWZhb74uUkk8qI9ZmerXaAuouI3ofxxTiiLLEd5WebA26M/26Z2mVRdNh6tRxzIGqFQV1p74Kz/qDPOZVZySg5nyPEhofZwZyEt4IxvcNdQCwPPlgASSrbXyhEw8LFk1hJGUfOu4ouoYR6oH1Ru2oBB7YroDNHgf/IRZwjV4wS0gwS9kX++ku5c4ioCTds55bTkUllWK3noUZ+0PV/tdcvTEPyhy+V3J+QmN5nlplZVARseC8Q7zsEQ4pgWzoHu+o40Qv6oQ9LknycKpp9VFSPkpylbjTinqbqXVr9Ans261c6E8p5CxtQ6PpwspP5PkTEENME50WQeCZglmAMhwRDdugjBNzZ98r68XypfYpSCWfxh038pUjnIryboNJwBYd7Bl/L/3/Osq5XXmw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(2616005)(16526019)(82740400003)(82310400003)(5660300002)(316002)(6666004)(956004)(31686004)(81166007)(2906002)(8936002)(47076005)(356005)(186003)(26005)(36860700001)(6486002)(8676002)(16576012)(70206006)(478600001)(966005)(86362001)(53546011)(31696002)(107886003)(36756003)(4326008)(70586007)(83380400001)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:55:24.2483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8a1625-1d54-40ef-2a34-08d8de2a7742
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,


On 2/12/21 11:43 PM, Auger Eric wrote:
> Hi Vivek,
> On 2/12/21 11:58 AM, Vivek Gautam wrote:
>> Add a vendor specific structure for domain nesting info for
>> arm smmu-v3, and necessary info fields required to populate
>> stage1 page tables.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> ---
>>   include/uapi/linux/iommu.h | 31 +++++++++++++++++++++++++------
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 4d3d988fa353..5f059bcf7720 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -323,7 +323,8 @@ struct iommu_gpasid_bind_data {
>>   #define IOMMU_GPASID_BIND_VERSION_1	1
>>   	__u32 version;
>>   #define IOMMU_PASID_FORMAT_INTEL_VTD	1
>> -#define IOMMU_PASID_FORMAT_LAST		2
>> +#define IOMMU_PASID_FORMAT_ARM_SMMU_V3	2
>> +#define IOMMU_PASID_FORMAT_LAST		3
>>   	__u32 format;
>>   	__u32 addr_width;
>>   #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
>> @@ -409,6 +410,21 @@ struct iommu_nesting_info_vtd {
>>   	__u64	ecap_reg;
>>   };
>>   
>> +/*
>> + * struct iommu_nesting_info_arm_smmuv3 - Arm SMMU-v3 nesting info.
>> + */
>> +struct iommu_nesting_info_arm_smmuv3 {
>> +	__u32	flags;
>> +	__u16	asid_bits;
>> +
>> +	/* Arm LPAE page table format as per kernel */
>> +#define ARM_PGTBL_32_LPAE_S1		(0x0)
>> +#define ARM_PGTBL_64_LPAE_S1		(0x2)

Thanks for reviewing and I am terribly sorry for coming to it with delay.

> Shouldn't it be a bitfield instead as both can be supported (the actual
> driver only supports 64b table format though). Does it match matches
> IDR0.TTF?

Yes, it should be a bitfield rather, and it doesn't match with IDR0.TTF. 
This is
  to hint the stage1 table allocations from viommu.
  Please see viommu_setup_pgtable() in the patch at [1].

>> +	__u8	pgtbl_fmt;
> So I understand this API is supposed to allow VFIO to expose those info
> early enough to the userspace to help configuring the viommu and avoid
> errors later on. I wonder how far we want to go on this path. What about
> those other caps that impact the STE/CD validity. There may be others...
> 
> SMMU_IDR0.CD2L (support of 2 stage CD)
> SMMU_IDR0.TTENDIAN (endianness)
> SMMU_IDR0.HTTU (if 0 forbids HA/HD setting in the CD)
> SMMU_IDR3.STT (impacts T0SZ)

Right. The idea was to start with a minimal set of configuration.

But as you rightly pointed out we need a scalable solution to this problem

for arm-smmu-v3. I am now thinking if we could even use the nesting_info

for arm. We don't want to end up adding flags for all the feature bits.

Let me know if you have any suggestions.

Best regards
Vivek

[1] 
https://lore.kernel.org/linux-arm-kernel/20210115121342.15093-14-vivek.gautam@arm.com/

[snip]
