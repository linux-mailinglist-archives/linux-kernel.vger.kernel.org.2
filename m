Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213D53D1FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhGVHt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:49:58 -0400
Received: from mail-eopbgr80124.outbound.protection.outlook.com ([40.107.8.124]:7043
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230048AbhGVHt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh+XooeTlDqKECt7XSM5AXOfpVWYNoPBJFW7Q/Tao1/0E18z6TXfLGafcy4am1x06nD61l9kAdoRhh3w/cs4tEsv1UlQ19N8qZBwWV5XtLG4wuweZAW/pVc/I7oZFQE8KRazKGonMJ/QHSohHZKU9MwOdwKY4fW0qJ/nua31QAYC3/cKJhWtcKte4at7rFhhukRyEspx2VlfR5Lc+axwTPH1I8QzR+8E+LoyOMX5Sv7uIuRJafQ1N+mcGcQ18Pu71y+j3LNyEM/hfhqiBXjvr3osTMu1d5kDNFLaezBoFG7PSgacnYqbh2rhHzrXR7VETojrp1YB+Eyc7OUtuEzcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix8nR1C4btqTlYDc6M7xItU1s5E9OSgIipfhogfvb5c=;
 b=Owd24RdDMhnlANGb9onVZ1eUtdI+QoJqeDuIze11sr13bn+AN5ZeWpXyRuGaulSAPryJ867dJ/dQUUGqvKF7BaVqID7eKI1offb8Z0x54DQM+8gdHnnBFfewKV7ZzETDtRP3oo5AdejxEPGDpo6QzHmLnHprmgMK6Z1B7UMYUhzjSs0PTd3lTZrQkSKyUfbUvWJilglbKUg+5Giq5ysYIXmSLcH5GguzIpwu9e+HIriD35jYBUCm6TJ7J1v+4uK10wHd07WocXlEY8tdAwtJkWubnZ6nU9EoJo8Y40nqBCoUdcI2p6cEFZWM+9yEQXlq2uFTZUD+5FaVqGTgyNCGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix8nR1C4btqTlYDc6M7xItU1s5E9OSgIipfhogfvb5c=;
 b=RwYXgcs1ZMcktlE1EGWAcSdjFG1qF8scDp3SJWGGiwRfI0biNsO4J01LOTq/vX1QC9EhrS/3JtocU5x121CoCOPhj0iv4+wF9P2qs5dGddUmUJpJ3qrDLHMeZ/jqKoS9TXb/DvWFnl4l+8nsoroJToLjTrxhpvW+2TZBkT/hSg4=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <314d75d6-ae5c-6aaf-b796-a424c195aee4@opensynergy.com>
 <20210719113657.GI49078@e120937-lin>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v6 00/17] Introduce SCMI transport based on VirtIO
Message-ID: <a2b796ef-3ce4-65a7-c9e6-4d9a97738c10@opensynergy.com>
Date:   Thu, 22 Jul 2021 10:30:27 +0200
In-Reply-To: <20210719113657.GI49078@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:206:1::24) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6d1a5c5-ac01-4f1d-c2f8-08d94ceaf738
X-MS-TrafficTypeDiagnostic: AM9PR04MB7716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB77161B7CF2CCB6A87822EED28CE49@AM9PR04MB7716.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ea4MylKtPqwF6Cj/ATAWC8iEEtOyTzDc5ctVr6fkci1OeqjXNcvf8nEcX/rVuJqKXO7MCPv5VqPzv/KbQa7SiVn06WMxK5afwWzqlj05j2AD151Wbud/CIitSc+Oj4DzYAvK0VpNXifTHJylTCP2UgCHbwgdFnO1J/Oei0tgeW9Z3W2fsPjpNLX1rX6PaDt5ppDrA/HDWz6bqmdL6E91Rmtz6FxHLY2SwzRVuGfvvE10wRDVhlViJEGpeFwd6DgRSyqH/CGXr2u9htnd+eyS5pgO3nsK27ySkY65bTT1AUr6jEChJLDS+vQIvSC+kSXWjXIgl7kWRBNU8FfLQj4HMwucrsMBTgKoMA3VuAwi3PLFHwmtlJNySH0HH2E3QqGjwwkaAKwYXrFHiB3MHjSHdUuws9y5MXsM3O3uomwClEBjFF4jbw7EaoMn5+cwAO80CLLxGvGeHQYHWqxE1IUfGmuw9Z9JiXACbNWkuu2ppUdwEcZvn8F0U81BeaEMXAXU7HxAfLqF7Dx0YHHg/KT7aWTuOn4hpNp7VGEtzU3jWKzgy4aNCjsI40mI+jpP9NVgwi3QD6FTTazez6nAfRxzgFWBLgHPNJNlDIBoQgM/4qAuB58mJ2JAO5DZfY5X6fpbK5Rsmywf7+ref7ZmHljG1DdQ/rdhjh6NX0xcmfZfjb2hcFsbHTq4+l6gIi1v2/hei3R9DAZuMSACc9mzTvassNjBxdCdZbv60ZBDz7pd1/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(396003)(366004)(136003)(44832011)(478600001)(8936002)(7416002)(83380400001)(36756003)(186003)(66476007)(8676002)(66946007)(86362001)(2616005)(38100700002)(6916009)(107886003)(66556008)(53546011)(966005)(316002)(4326008)(2906002)(31696002)(5660300002)(42186006)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9HYnhJNGp6c1Zyb0JPelFwRFYvSFl6Ui9DV01QRlVwb24zN25IZm9PQkRF?=
 =?utf-8?B?R1FOakxqNzdmbzRUdDJKNys5ZFNKdkFEOEU1dG5FajNmNWZNdHpzL2JiK09r?=
 =?utf-8?B?ZVhNVUg3dnQ4M085d1pMUVVqYVJrOGZIaHJuR1ZHMVNQTUxlVElBVzhZUk95?=
 =?utf-8?B?bWxDS1J5ckJTc1cyVVZLM2JuR0p1YWFwN1FOamJuWGNQZVlhYnA5OXNYdTJw?=
 =?utf-8?B?Yk5rVk1yMWZ2d2dLMlMxZE5aSlJPOTJCM3BBa3c3T29DczJzVnJEOEJVTVZs?=
 =?utf-8?B?Nkk3NVdEK0tLcEVaeTc3NW5lQThMQ2RqUkpuZ3Bnc1E0U0E3eEVURE5LWS9h?=
 =?utf-8?B?b1UvRFJyNUxqa0l0LzJPeVlGbU15RE5IMjkwM24vdlV5ZkVMa3B5elZrcnRX?=
 =?utf-8?B?Wi9oL2lpdE5HenhRTDJ3bXRhYmFFL1hraG5yYks0Nkh0WSswd0phZGpIRDdq?=
 =?utf-8?B?RWM3aHlLZ2duZDlIcnJvMWwvUUxTY2kyRWNVTlhXMlNXSk5BSExBQVJ3elI3?=
 =?utf-8?B?V0RoMjFjUXhVbFRvaVQ3QmJLSXc1Zy81dHU0eVA2S3ZxQ3FxZEtDYTZ3SzdW?=
 =?utf-8?B?azhERGZSZFJQTnIrRElqejdJMFNyL21CeVF6NWhxcVdmNlhQdHQ2RU8relNL?=
 =?utf-8?B?R25mMzIrdW1xVXlMQlFwc3ZMbklpVEhJWUk3WGdrZnVLL2ZwNzJTQXkzNU9W?=
 =?utf-8?B?bU9acTE5K1lEdHIzRndYbjZzNStmTnVZRExXRmFjQmJuRnFjVDJzZXlFRzA3?=
 =?utf-8?B?TDk3dGt1S3Rhb3lqUnhrVkdaUG53RVNKc1RxS3JUTEZHTW9QY2RlWlVOUEpp?=
 =?utf-8?B?SUh5OSswckZ2Lzc3QUI3QnVoenlRZ1puM2xXa1BvcyttTDBzL3JTZkpseWVs?=
 =?utf-8?B?cHBoZ1ZnOStETGdmTlJ3OTllbG0zOE01Qzg0N0JZMFI1V0ZTWG5uS3k2RUJk?=
 =?utf-8?B?QTRkaVJpeHVqOUVEOVBYQmwzdXBvdU5zTGdWSnlEYVlsY0trOHUvTmNnNkpj?=
 =?utf-8?B?K0xpQnJ2VDVRL0o1eDN1THkzMXNLTzZzUHlxd0Vob29TN2ZBVGJvdTgzZ2py?=
 =?utf-8?B?M0thYzE0YlI5QnNVMzlqT3pzZ1JsVVpFS0cxS0FoSm9Hb0hqMkorQTNUdE1D?=
 =?utf-8?B?Z0g3Nnd1Rk9HV3ptaUUvZEM1M2pIdE9KZFpzNGJyNWQ2VlZ6R2dnc0NiQ3du?=
 =?utf-8?B?M3ErOXp6cEZ6dURVaUEzT1RuQVh4anhVQi9KR1NvKzVHRGwvRjZpNjE5c3hh?=
 =?utf-8?B?QzUxOUZEOCtBZWtwVlYyMnhCbjVSaTh5dlJqR3AxQjVFMDJyWEZmYmpXeDVv?=
 =?utf-8?B?NDhwUGNpSTFvUklFZElxc0hLWkhJdlowWlh1cWpON043bHlCTysxd1VhSTNw?=
 =?utf-8?B?bHFCRVJQcFBUUHNjc0F0MEUxb09Rbm1ySXJtT2wxcHorRWxaOWlvZTNlSUFx?=
 =?utf-8?B?eXQ4bG9Mc0ovdWZLY0R5dkJsaE4yMmtEWTJSK2dJamQ4T1JTTWZvbmxjN1Nk?=
 =?utf-8?B?V05LeXVxZFd3eVltalRBQmNPMkhIWTdwenRQZHQySGhHZlJEU1J6bDYrcmUz?=
 =?utf-8?B?VmQxNndsbU0wcGY1eWtjYjZSS0pnUzFHWkFvNkY0dVowVFdKMGlIMCtFSGFU?=
 =?utf-8?B?VjQ1L3ZRcTNwQ2hkQy9ocEVlT29qclFtNXZmWWU1anF5Njc3NTVibWFHeE01?=
 =?utf-8?B?cW5qKzB0ajdXaUlDR2dhU1JxVk5FdElldFRBNDg0dzE3dXV2SVBDNUdoMjho?=
 =?utf-8?B?VXFlRGRFbUY5VE80MlU3U3c0bTZ0K29xdlBWQWVyWlJUaEJlclVhaHE4Q29D?=
 =?utf-8?B?eE5jWWplUUFFWmNIa0Nad1Q1UFBtVGg2U0FiUTNHYmlsekFKR2F4ZjJLcnUz?=
 =?utf-8?Q?Ha6aFRn1AUVo5?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d1a5c5-ac01-4f1d-c2f8-08d94ceaf738
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 08:30:30.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFXCe/FLr/B8Co2/f8CQImVdSEmdGB0vB5HR/TA5L6wb+rX7FiSuKZFxaIgGKN1h21sJm69sTY89X/hsxsoSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.21 13:36, Cristian Marussi wrote:
> On Thu, Jul 15, 2021 at 06:35:38PM +0200, Peter Hilber wrote:
>> On 12.07.21 16:18, Cristian Marussi wrote:
>>> Hi all,
>>>
>>
>> Hi Cristian,
>>
>> thanks for your update. Please find some additional comments in this reply
>> and the following.
>>
>> Best regards,
>>
>> Peter
> 
> Hi Peter,
> 
> thanks for the feedback.
> 
>>
>>> While reworking this series starting from the work done up to V3 by
>>> OpenSynergy, I am keeping the original autorship and list distribution
>>> unchanged.
>>>
>>> The main aim of this rework, as said, is to simplify where possible the
>>> SCMI VirtIO support added in V3 by adding at first some new general
>>> mechanisms in the SCMI Transport layer.
>>>
>>> Indeed, after some initial small fixes, patches 05/06/07/08 add such new
>>> additional mechanisms to the SCMI core to ease implementation of more
>>> complex transports like virtio, while also addressing a few general issues
>>> already potentially affecting existing transports.
>>>
>>> In terms of rework I dropped original V3 patches 05/06/07/08/12 as no more
>>> needed, and modified where needed the remaining original patches to take
>>> advantage of the above mentioned new SCMI transport features.
>>>
>>> DT bindings patch has been ported on top of freshly YAML converted arm,scmi
>>> bindings.
>>>
>>> Moreover, since V5 I dropped support for polling mode from the virtio-scmi
>>> transport, since it is an optional general mechanism provided by the core
>>> to allow transports lacking a completion IRQ to work and it seemed a
>>> needless addition/complication in the context of virtio transport.
>>>
>>
>> Just for correctness, in my understanding polling is not completely optional
>> ATM. Polling would be required by scmi_cpufreq_fast_switch(). But that
>> requirement might be irrelevant for now.
>>
> 
> Cpufreq core can use .fast_switch (scmi_cpufreq_fast_switch) op only if
> policy->fast_switch_enabled is true which in turn reported as true by
> the SCMI cpufreq driver iff SCMI FastChannels are supported by Perf
> implementation server side, but the SCMI Device VirtIO spec (5.17)
> explicitly does NOT support SCMI FastChannels as of now.
> 
> Anyway, even though we should support in the future SCMI FastChannels on
> VirtIO SCMI transport, fastchannels are by defintion per-protocol/per-command/
> per-domain-id specific, based on sharedMem or MMIO, unidirectional and do not
> even allow for a response from the platform (SCMIV3.0 4.1.1 5.3) so polling
> won't be a thing anyway unless I'm missing something.
> 
> BUT you made a good point in fact anyway, because the generic perf->freq_set/get
> API CAN be indeed invoked in polling mode, and, even though we do not use them
> in polling as of now (if not in the FastChannel scenario above) this could be a
> potential problem in general if when the underlying transport do not support poll
> the core just drop any poll_completion=true messages.
> 
> So, while I still think it is not sensible to enable poll mode in SCMI Virtio,
> because would be a sort of faked polling and increases complexity, I'm now
> considering the fact that maybe the right behaviour of the SCMI core in such a
> scenario would be to warn the user as it does now AND then fallback to use
> non-polling, probably better if such a behavior is made condtional on some
> transport config desc flag that allow such fallback behavior.
> 
> Any thought ?
> 

Maybe the SCMI protocols should request "atomic" instead of "polling"? 
That semantics are the actual intent in my understanding. So the 
"Introduce atomic support for SCMI transports" patch series [1] could 
potentially address this?

Best regards,

Peter


[1] https://lkml.org/lkml/2021/7/12/3089
