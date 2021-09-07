Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3A402828
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245128AbhIGMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:04:44 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:51485 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233864AbhIGMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631016215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E2UE+ZRwTyLPZzFoXjrcRBIUg7Nc5I95rFYE+wbcJnA=;
        b=JMC2l+Lusc8oyAAImD41kO878TdsUUcp2RWjW9hmpJyOaZQEiOT2JORsPKsjl8hwoDXFSj
        lp422QirQ/wyyJUgQz9oFKiw13ABzy5hN81tlXoOT8CBTdHCgw7SSG0AmEIb1TyoIW4Hx9
        1hcEJh4nOhGE/pXtpMb0Se5IRqC/KV8=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-Y331f32DNwm2pXv9fgcBiQ-1;
 Tue, 07 Sep 2021 14:03:34 +0200
X-MC-Unique: Y331f32DNwm2pXv9fgcBiQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l28+79zKnHNhBBq9ANnTM17vSuBq/3+UeHInBi1Zso4NXl4KTFTzUVP/MELeiwnhjbI3DWfI9j/mVeFJXFwXfndaaC1XpQBydzAZCyAZpEqX79SB7cAXAZ1/05FoqnXmkG0rxiVvMLgQnaWNBUK0ae91Q436dgJI0ijkqoxjwjfzS4WX9a1HMmF5wDtw1W26qcmQKn9Zt8iTC27muSB2JiR4luMt6je/MciLK4zj7zHZDcExK4OTe4KL4NQ6m85RmmbXqXRvevxgV1UUk7feXHdbMfsy5PrK5n4Z10ceO4eZOEQfFuXgix7KyjYAMhLV9HKfpH1jBHNhrTOT3IAk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E2UE+ZRwTyLPZzFoXjrcRBIUg7Nc5I95rFYE+wbcJnA=;
 b=napd71XSbTlC44/bcrwYDtCTtjZQyUpwbh3kPX79Z7q+jcazdc0LR7YCkS/k/th5BBcayvri6ATOgL9ynHMA9XWLpfJ5rF0vyvaagoffUbwy6YNON/zB54+m+M1mFwf6SHao2Aix/avLapBlCLTZSwxIk7tMqK0exsfCSDwDBT+lTK0lqmY0VooDD2C1CgsgWmd/yhnFNs3Ht/AdOt1UzPTqg75rOmi+aGnGPTJdW2iq/JKfFdjzB11f0L2Y1f+0CIxwqCBqMg+3xwdRFH67LCVnPat2pGwMfarkbbtdtWJ+0U/o6R+c1AVXCsq5RamIAMfvKO/Jp6jqtXisxbsiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.xenproject.org; dkim=none (message not signed)
 header.d=none;lists.xenproject.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB3120.eurprd04.prod.outlook.com (2603:10a6:802:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 12:03:32 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 12:03:32 +0000
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 00/12] swiotlb-xen: fixes and adjustments
Message-ID: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
Date:   Tue, 7 Sep 2021 14:03:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:208:be::47) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by AM0PR04CA0106.eurprd04.prod.outlook.com (2603:10a6:208:be::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 12:03:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4008ec7-e485-462c-2aa4-08d971f78366
X-MS-TrafficTypeDiagnostic: VI1PR04MB3120:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB312015890505818BA83EA4E4B3D39@VI1PR04MB3120.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXQ3lr0rQ/68oGTucfAwyap3gcxsTliw48mbk0/jbbax99JVMC0WlrbOTSBuEP8IwMrjMisLsrc8YbQ0ygnKPbDlZdThuAtpP1a5KmIiBJi8AXdX7TCeWd4pwfVIKbZgg3AfbdXHeWPXQ2U8xNF4y07Yz6TvAUvA/W5+IyEc9P0oSZmYUqWVLGSmbZMffTD6/0XA+qR4DLqCM6UztCZgCMAWUN4cLIVu0OmYJQ12Ic0t7vRN41WThHHhpaflHlQo99c//7DTCn9oxBdSSxNKd3wchE/FSZ8F0D0uysl7mQ4cvsB2clV4t41unGXtbDjRKmOoPyvu99dRmBJk6d6/AeAnBFh/J9dd2eXlfmhtEp8gQyHRQ6kquFm/aa2ESqLa20DFdKsR6SBkZMmbS0oXztPtFH+vAiTVnhf/DX+FuHt3C7QPj/TQXNidP9RnDSHk3oCMo7TlcbfhTYaSTofirEJf6n9qXdufjazMMbHU03ZU2Sxs1AjyBMYHMjClA0WN+D7ZqR7hFX1BVQ25KQmtNX0Vfv0mRylByI8KjPBKP+C8WyQHHOlXVWDVindEic83q6K7gOCgcHt6v0n4AAwBzI/6LDZOhW5RaTWKw+UBWhf2MQF62ImieNc+wxvLaBr7LgPAs3fqZMAJW3T2WDHbXcoh7Kwc2uTLZAkc27hzCuThiUsaAuCgjlalpR1U8t/UNADRUXX2UNvmhBAwL/i3ycvfYXhTinza3m0Rox4RQ07Y2ZLgEs0M4LYTYN0MI3iI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(956004)(38100700002)(2616005)(86362001)(316002)(16576012)(83380400001)(26005)(186003)(36756003)(4326008)(2906002)(66946007)(66476007)(478600001)(66556008)(5660300002)(8676002)(31686004)(110136005)(54906003)(8936002)(4744005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtNeFdieU0xZUtVSitVTjBPMWRzcy9STTZDMjEyTVoraS95RUtzZEVnRVlm?=
 =?utf-8?B?UmkxY0ZMeE15NG90cnFISXBSOTUxMWhheVdTMjRraHRlM0ZRUkNCTytNeDFD?=
 =?utf-8?B?OHJVdmZRRDdtcFpVRS9xam16dTFQR3VxR29JNHlueG1rQjd1TGJhaVlKUTY3?=
 =?utf-8?B?eFNzbmhDZEwrNlUydFlBN1RnQng4L3dlNzN0UlVORncxZEJtSFp6Z1ZpRWVC?=
 =?utf-8?B?Um9WREZnUUZXRTJCWldDWjBkcFJYb3dnaTl1ZHVhYXQzbW8yNkVsZUxwbEpy?=
 =?utf-8?B?VjlVWUhGdHFIY3FGYXlsRFUvcy91MS90Z0VUeVNjd251VHpGVUJQdEk5NzBY?=
 =?utf-8?B?aWllSG5rZEVzcGNtM2hsTEtKWm9tZm1OZ3V3TkZlWHhDWE90b1VTUVkwZHYz?=
 =?utf-8?B?MWNuWGJMUVNUbWQwc2NTVnRtamRER1hrV1RYYXpuZ2JBdzJhTkVhMm9kblRx?=
 =?utf-8?B?VnJGWXJWWXlLdkZJMGJ2WDdGUWpsU2lMUE1VZittRTRhZWM4Y1BISUhkT1dT?=
 =?utf-8?B?YXkwRlA4Q2JJS0NGUXJ5R1Y3aUtnZW9Zcm12R3phakNFeEREcVRTNHNNNitJ?=
 =?utf-8?B?eExBdVV6dG1wbFBVRkMyL1VMQmdvd0Z3c2xSNGJnMWcxbHJXNXljQWRZdTFu?=
 =?utf-8?B?eDN0QXdYb1g2WFFKTXJncXlBc3Qrd3Z2OHNQRlE5RUo3WlJhUHU0bnUwNEJX?=
 =?utf-8?B?cWUwTnFxM3g0RWFDOTBYTmgySzhmNTc0MTgxeGY3SGFnZkd2U3BVSVJMTzhn?=
 =?utf-8?B?ZEZ5Q2hTM09EdjVCQ21tUmxXazN2VlBOV2ZJYmdIZUhZYlpoTmF3eGpSSVov?=
 =?utf-8?B?NHZGbkpJNzFsUi9iemlhZW1ZUXlwdFlBWGtkZWYxU3FEZnRnc2ppUjN4TXky?=
 =?utf-8?B?d243V0ZIVHY3cTM3QVJDcG9aRnJiRmpIRmRnR2J2NEd4SVBVbVB0U1QybmVP?=
 =?utf-8?B?alg3eTArUkFpenZsYmhSN1pwKzN4NDhMejRvRWhWYzQ4bTYyUlZQNUM4NnpV?=
 =?utf-8?B?T29icytlSEpVUW9Zc3h0TmtxZ0ZUS2V3ZkJ0SDVYd1RMdEpoZzQ1cWpzUjkx?=
 =?utf-8?B?dWZtdGRSUm5jMkU0aWxEdGtRQVNZa3o4RVhaOWhXMlU3WHhlU01oWUcxSzJl?=
 =?utf-8?B?Y05acGhQTFBaVFZaNXRJTEN4NkxrQkNNaUtXeGgrZERZWmg2ZUw4Mi9BZFQv?=
 =?utf-8?B?aTcrUHNZeUxuQWNMQ0c0dmZNTDlyRjVvWVRtOFZqQlRRQlprMCs3MXB3Q3ZL?=
 =?utf-8?B?UDdFZk11ZGJmZ3orSEE2NXppSVRvS3JjOEF6eWFYYjFSYTd5aEUwOUFVQWlu?=
 =?utf-8?B?MGdnOUR5aGRSOGFzYkZocDhSRFZ5VFhiN0tHSUxiMldaSXkwQlRibTBhS21u?=
 =?utf-8?B?Q2dyL3I1Q3U0WVVRK0ZYbGRDMms2OTJGazhSVzExdkV6bEFUOXpSZzNvejVD?=
 =?utf-8?B?UUFJc2hPVmRYVnVRNU4xKzZXNTk0dVI3WVJ2cmFUMWdmRWpFajBzanczcVEy?=
 =?utf-8?B?OFl5bmRRZlREUHJyMmVsL1hCNldLNVlGckxYYzV5ejhQSFg1a0YxcGZISVhO?=
 =?utf-8?B?SloweCtGMFdKdVlselEzWENEaDEvaU93UVVHRTJGUEtFVExZRzhCWHpuSFRO?=
 =?utf-8?B?KytDQXZ6WEtmV2dQMmhiR3doUGp1NTNGTFNQclhTUCt6QUJuWklkT3lBaG82?=
 =?utf-8?B?djJSTjBMbFdZZm8rS0I1MVNMS29EeDdPVGwyVVNpUEtwdHIwaXNmaE5YMGox?=
 =?utf-8?Q?X9VF6pViJXIf4J4I5WlrUnSUwWbFxSKHCPQvDvZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4008ec7-e485-462c-2aa4-08d971f78366
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 12:03:32.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIovpZJGSULoeQGlwuD0njofzK9Yujr6F8vg8ppn8ZVmS5mQpzu+vXvTl6+0/lsjr+ysyD5eEtwKSWjQaqHK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary intention really was the last patch, there you go ...

01: swiotlb-xen: avoid double free
02: swiotlb-xen: fix late init retry
03: swiotlb-xen: maintain slab count properly
04: swiotlb-xen: ensure to issue well-formed XENMEM_exchange requests
05: swiotlb-xen: suppress certain init retries
06: swiotlb-xen: limit init retries
07: swiotlb-xen: drop leftover __ref
08: swiotlb-xen: arrange to have buffer info logged
09: swiotlb-xen: drop DEFAULT_NSLABS
10: xen-pcifront: this module is PV-only
11: xen/pci-swiotlb: reduce visibility of symbols
12: swiotlb-xen: this is PV-only on x86

Jan

