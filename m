Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1039B5BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFDJVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:21:03 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:1088 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:21:02 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id C4D23A178A;
        Fri,  4 Jun 2021 11:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=MFCk2MHH3ylO
        6oaFg64coN1f5+LH4owK5o5/OdJljl8=; b=GyTsZZztkq8QAeh2sc+osM6Joq+s
        81zhjFFxhml8Y1PAZgrxEkaVYdJ3dHL1cOPSpA6SM1bcooUz15VR4dm+IMBKPe3G
        pY+Zw+Jte/6bR+Pn7w0UQm2BDDH8fn7vcNIb0cwXvk8oWBzO7o0Us6OY0CK98/xW
        jL/EliDQ8i03bvR1gjL74uqpf3/9dYlixq8gtPjWRt3CF2YI/p5F4WRXrHyIeqNe
        2FmM9JdjcmDtf7Sh/2hFeuaQm8OrcCrjwRjptzTjm5netxu059NUu3G1vPTKFBpE
        DUfFxVWlky4+0OvoO7ToRa/Gsg5a5cXl1YranENSgA1mITQ1bl/qpADUdw==
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwG76wa41/FnPZWqHu8BiLdV6Zo6oyl+vQZwUwzwHz/Wm7f65nhO8w+FJBRwEEZVaEQrcZG+LXapcBFC2kMSwE5o8MR/sL5h/m0Sg7sOBu7fZG9y4bkn5bpS+cO6esLH6Bzi5CgZQDhcjIAUR90dMst0YiX0MOdwiJ6FhIp1WmOzIzTbuowhhthUDpSgGX0k6QIqWZ1SlQEGdSzILg45xGFTFWvjF7iB5GAWEGDjq6xkf2s0g/9vx40vwOuLsW8itWXD94NeHUkfhVAj5ib8tMjh5tkyZsav4suY86DbkwzxaeZ3wdSgTKFyVVNrlkIDXJjOviVe6lwBu4KDZHjkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFCk2MHH3ylO6oaFg64coN1f5+LH4owK5o5/OdJljl8=;
 b=i6a1gdmGzUhRF9y10zFoSIrFfWTzFdpHWfp/Z7Yd+AbApfCQ+ItnIvL/brLGVyxfUElHvisioVy7FYIh8SwTNvok1jLeZz4j2ZKiFuv4OHUzqgQQnliBPyj7mLXpttMFajS9E0XgdG8j9fpQz6A6h+3OAwUZk5WW6L4iIauQSJ1udQUQLEnDyjpmisWTdBsdkukbMpU8dug0InE52Lwp37ggSEs3vIdRCtIItbGz9R/3KIw4SWPi4iaJ3aqmzs0c89yrNVn/p6+0iQExZ0TdUUq6goxHipnfreDkAHdQhgZLkrkyLfKpJEFiUIYIXGrulcSwTYXh1zKtPE9VLALJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opensynergy.onmicrosoft.com; s=selector1-opensynergy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFCk2MHH3ylO6oaFg64coN1f5+LH4owK5o5/OdJljl8=;
 b=jovQnpjnLsKFw9spoBLGb8DK6JL+Qv/FbZjfPlRYM46jj1EYEF8D61wj/iSrZgMXv3p71zTpUps8zhzlXZOIvTFDeWoRYeZiec/4lmQqFJApqPspFGz+HbUZgUhFXmL+EI9+ejo6RlpbJizfFreDOoL22ehIkpfxTKoe8hZRBe4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=opensynergy.com;
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
 <20210511002040.802226-12-peter.hilber@opensynergy.com>
 <20210526144035.GN28060@e120937-lin>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 11/12] firmware: arm_scmi: Add virtio transport
Message-ID: <af23ce35-4c58-678b-eb20-c4072c358db3@opensynergy.com>
Date:   Fri, 4 Jun 2021 11:19:02 +0200
In-Reply-To: <20210526144035.GN28060@e120937-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0602CA0022.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::32) To VI1PR0401MB2477.eurprd04.prod.outlook.com
 (2603:10a6:800:55::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44dc3dd4-37a3-4648-5d59-08d92739cd4b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6462DF6FA89447BBB284E7FA8C3B9@VE1PR04MB6462.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPOfkWhp5fEnz+oBeBR739dCvQPztb0gUJNJU8SvhGW2cTTvRqIJJj8g12fliXni/BAzKeETrr+or02V/KBHlZmViNQ3PeVE+WW8P8oKs5ZniT2HMq2YdWeaKSnz6MjM7jxxKrWxsZaVIKqCLptCWXbTWgH5rhM6+61siwa3wLd4TQ7yNqjjcKcCd2S33MFSJ1FoJH1fNUs1OWpH+Y/ylgcgDc7xlEfwJj4K+UFw4Mrvv1T/syM/nMaT0bW3HD9VWqwOmrxjD76/jszueZyKRUNocDmy/biYAhGmmRR0ZDYAN17O3MQ3lVevbqNb9rfnJL8cVfezXRsaoEafygNvH7q19SoOw/kHE3CwTqbdEXu8lMadBwNANCI+08xMsEfsvxEbYPRGVzsXlaHI/cF0TAYeE9wHi1FGHcsqTuXerSgtFlmZMDaaLsouCN0LCD/E4Gv7Y7Gkmn8V242acOYyq5kK3x1rFueoW/O/xZj3Kifd6iPQ959pSlZoth7TdRRRdXVDsuqWDz8E/r6xqaoz06A5L3qbmddY21J/yoz0rBatqkcRoS8C3ykfoVdd8ZRZlSmOgvXqgB8k+KAaaOQBpJnTZCnXhoNOgfpFLMJ7mmeimozYYtjcgLVa4lWTgDpAc1BOWEkNPKW/SRu6MUnF3dVlH3q2o+6m1EzsyUPPYgDQOtY/JQOoybkQdnjkmlj6wmnARmJa2KMzbyOhSTZNRgMBbe2o1xnhy1ERWQuncabVEpY+qwKYinVGNj9oAvEmVmJpZfzAyVyIwZ3CK+2Q2H4+SFZgUOf6U+3b88Wof5q7u0To+lUyugzglgpZD53drPUADI8bU3GgeXZx170Oyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(30864003)(186003)(16526019)(86362001)(36756003)(2616005)(6916009)(6486002)(5660300002)(508600001)(53546011)(7416002)(966005)(44832011)(4326008)(54906003)(38100700002)(2906002)(31696002)(8676002)(83380400001)(66556008)(66946007)(66476007)(8936002)(16799955002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VmJ5SzJkRENzejkvWUNKNWhwOXZYL09EdUpZcDRzTU9rWmZrUXdtWTdsUmg4?=
 =?utf-8?B?TFg4VU9haUsxVitxMjhhUXpKU2dIVFJCWEM1LzZ1MXYvckRnT2JQdkRrWEk5?=
 =?utf-8?B?NlNlWU5oRUhmWFBqeEw5KzA2RUtxcFpkZ1laVGdRbDJLd3FURDJaNUJnRG1i?=
 =?utf-8?B?YkhhOVE4TmduTUFZUTNsM0JyNDJ1K3RUNEVCWFpqNk0wVlVyUVpmS2dBN2Yy?=
 =?utf-8?B?UDkwckRzUzgramVCb0xtN2FWRHFqMlNReXZYbXd4djBFQ1NwVWRTcnRQM0Zl?=
 =?utf-8?B?RS9hNDE1OVpmUnp1VkdOTGpSQmw4bTRPd2REU2NEbFJ1V3dkRFhodVNGZlJQ?=
 =?utf-8?B?RkY2QWhBRHQ2WjlkNGRUNC81NlZsMmdkVWorSWt5MkRZNk94WUxkejdCbERy?=
 =?utf-8?B?REpNOVVOdEROYS8xajJPaU96ZHFZaUQ1TVlkcGZndktVbHJLMk9iSWtXTC9W?=
 =?utf-8?B?ejI4U3U2L0dZQmtONStWUHZJb0l4TWFnS1d3anJraTVvYXo2elZJMkhWWjAz?=
 =?utf-8?B?Zld5eGVGdityc2ppMkN4ZE1VdWwxbTdQVmFsTmp5QldjT2YxMWh3SUdJYmRT?=
 =?utf-8?B?Q0h6VWZyQVF6TFkvaG51Rjdic0dlSDFJNDVscElHaGQ3RGxpaGVnR3dPcVdn?=
 =?utf-8?B?MWE3cEpCb1pLd0hzL3ZvbTcyMUUwK1FKYzRqMjYvbit5dlVRMzJ2b29xTnVo?=
 =?utf-8?B?dTA1THdrVGxmanNTNmJJQjVDVGl5M0Y3UDd5Z3g3WnZQUXMrSm42SXRXNXVT?=
 =?utf-8?B?ZzU4amV3VmpKOThXTFQyUG1FR3VVcDl1T1I2aHEzTDgxWFFoam1sdjcwazYz?=
 =?utf-8?B?dVFrRVViVVlaTGsxQ0o4cDlma1QvZkE5bUlKWnVYVjlLRmtDTThsaVM1TzRh?=
 =?utf-8?B?dVpacDVUSVZJdGhmVHdJeUdVUXdXb2NnQS9SZ2lGejF2dlBsNU0xeHpsYWgx?=
 =?utf-8?B?YmFoL2VDYXBnZGtKUEJydVNISklpb0hidm85NjliRDlQczluTlVUMnRSd3Nm?=
 =?utf-8?B?UWloWCtIRy9ZdU1OaFdGenJhSDEreTlTNThyVDZUUkpSb3RKOGdxMnhnQWRJ?=
 =?utf-8?B?Sy9RTlhtdHAvVlNRakRZUk9Ib2RoRjAxMFBaYjI5aXhaOWtKbU54M0o2Zm1B?=
 =?utf-8?B?bDF0ZnhwOXFsQzB5MkFHc0o0NTFDeHFHYmFvdTZvNms4L09iQkYyUnJzaytV?=
 =?utf-8?B?YzBNMzRqNWVrMnNOSk0zckpkQitpMDBnaXFQSGpiM1dDdDBDYnlXeG5iL3Bs?=
 =?utf-8?B?blNPeURTdWpiODdsVUZhcEVRZE5jRHdRdG1rWGpVaFNlOWRRbElKeWlZcm5q?=
 =?utf-8?B?TlNtOXBSVzBaVnFsQ3l4ZENTVnVwRzVHRXBiTG1DMnB6ZnA1L2dzcDNIM1h3?=
 =?utf-8?B?Ym1sVkxGYlZ1S3BWV0x2YmZHS1d6cVh2aTE0dDBSUnlndkVLYkd0aUZPTlFV?=
 =?utf-8?B?b3gxNURCc0FoTmo5cUpoS2lxdnFDMCsrcndySkgwaURBbDBLckdpZXJJbEEw?=
 =?utf-8?B?cEJlVmVkK3Zzd08vWlBVSUNDeWt1SlRBT3lCMFFFWUxaL0RkaXlkK05rN3F1?=
 =?utf-8?B?ZSt4RUNySFltRjhWMS9VQW5OcUNBdm1yMEViOVdMdDY4T2FvT213dU1aam5p?=
 =?utf-8?B?R1NrcUlVVDA2SkY5S3V1ZzJvWmVLbFlrWjl6UzVjK2lzV1dVR210QlZPTFhh?=
 =?utf-8?B?VzRxU3RvV0xuQ21RRDdCTTFLSUN2anBsT244TUs5TTZMYUhTTWJrdTdRZlZk?=
 =?utf-8?B?czZWdzJ0Q3QvMGRBL1ZYYmFGTzlHczVPaFF4T3V2dEJJaFAzZVJpODN0bktW?=
 =?utf-8?B?bG0zWFZqbXV5dmxIV3ZtbnJPU05yNUpzU01IS0R3M3NhRURhSWxhWUVSTUto?=
 =?utf-8?Q?Pqihdw5vfkb9m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dc3dd4-37a3-4648-5d59-08d92739cd4b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 09:19:06.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjOMXGpzNdpqxTN7O1DhAFifwsdckbfXLtrAyyiJvZ3cdcSf8Pd4aD5Vl4YGR/DiT1Dbaih0K9YCLGZIArPtMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6462
X-OriginatorOrg: opensynergy.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.21 16:40, Cristian Marussi wrote:
> Hi Peter,
> 
> as anticipated I'm adding some new SCMI core mechanisms that should help
> simplyfying virtio-scmi series.
> 
> Such core work is still in progress (and to be properly reviewed) and it
> is at:
> 
> https://lore.kernel.org/linux-arm-kernel/20210524231503.34924-1-cristian.marussi@arm.com/
> 
> but in the meantime I have an initial but working (for me at least :D)
> rework of your V3 virtio-scmi series; rework is still in progress and to be
> cleaned up (nor I have addressed probing sequence or polling mode), and I am
> anyway holding it for now since Rob asked about DT txt-to-yaml conversion
> too, BUT if you can or want to have a look in the meantime, you can find the
> whole V4 transitional series rebased on top of my core changes with some
> changes on top at:
> 
> https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_virtio_trans_V4_rework/
> 
> where:
> 
>  - I dropped V3 patches 7,8,12
>  - the virtio changes I applied to make use of my core changes are all
>    embedded in the last patch (just for now):
>    
>  	[RFC] firmware: arm_scmi: make virtio-scmi use delegated xfers
> 
> Definitely not the final version, so you may want to just wait for a
> real V4, but just to give an idea of the direction I'm trying to follow
> if you want.
> 
> Thanks,
> Cristian
> 

Hi Cristian,

I had a look at the concepts in the linked branch. The following race
condition seems to not be addressed ATM:

- concurrent not delayed and delayed response (or inverted order)

The virtio device will send the not delayed and delayed response through
different virtqueues. Sending in a particular order will in my
understanding not entail that the receiver is able to restore this
order. I think the virtio transport cannot handle this race condition in
general without interpreting message headers (which it shouldn't).

Also, it might be documented that after a response timeout, do_xfer
should not be called on the xfer any more (since a belated response to
the timed out message might corrupt the new message).

Best regards,

Peter

> On Tue, May 11, 2021 at 02:20:39AM +0200, Peter Hilber wrote:
>> From: Igor Skalkin <igor.skalkin@opensynergy.com>
>>
>> This transport enables accessing an SCMI platform as a virtio device.
>>
>> Implement an SCMI virtio driver according to the virtio SCMI device spec
>> [1]. Virtio device id 32 has been reserved for the SCMI device [2].
>>
>> The virtio transport has one Tx channel (virtio cmdq, A2P channel) and
>> at most one Rx channel (virtio eventq, P2A channel).
>>
>> The following feature bit defined in [1] is not implemented:
>> VIRTIO_SCMI_F_SHARED_MEMORY.
>>
>> After the preparatory patches, this implements the virtio transport as
>> paraphrased:
>>
>> Only support a single arm-scmi device (which is consistent with the SCMI
>> spec). scmi-virtio init is called from arm-scmi module init. During the
>> arm-scmi probing, link to the first probed scmi-virtio device. Defer
>> arm-scmi probing if no scmi-virtio device is bound yet.
>>
>> For simplicity, restrict the number of messages which can be pending
>> simultaneously according to the virtqueue capacity. (The virtqueue sizes
>> are negotiated with the virtio device.)
>>
>> As soon as Rx channel message buffers are allocated or have been read
>> out by the arm-scmi driver, feed them to the virtio device.
>>
>> Since some virtio devices may not have the short response time exhibited
>> by SCMI platforms using other transports, set a generous response
>> timeout.
>>
>> Limitations:
>>
>> - Polling is not supported.
>>
>> - The timeout for delayed responses has not been adjusted.
>>
>> [1] https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-scmi.tex
>> [2] https://www.oasis-open.org/committees/ballot.php?id=3496
>>
>> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
>> [ Peter: Adapted patch for submission to upstream. ]
>> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>> ---
>>  MAINTAINERS                        |   1 +
>>  drivers/firmware/Kconfig           |  12 +
>>  drivers/firmware/arm_scmi/Makefile |   1 +
>>  drivers/firmware/arm_scmi/common.h |   3 +
>>  drivers/firmware/arm_scmi/driver.c |   3 +
>>  drivers/firmware/arm_scmi/virtio.c | 523 +++++++++++++++++++++++++++++
>>  include/uapi/linux/virtio_ids.h    |   1 +
>>  include/uapi/linux/virtio_scmi.h   |  25 ++
>>  8 files changed, 569 insertions(+)
>>  create mode 100644 drivers/firmware/arm_scmi/virtio.c
>>  create mode 100644 include/uapi/linux/virtio_scmi.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bd7aff0c120f..449c336872f3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17705,6 +17705,7 @@ F:	drivers/regulator/scmi-regulator.c
>>  F:	drivers/reset/reset-scmi.c
>>  F:	include/linux/sc[mp]i_protocol.h
>>  F:	include/trace/events/scmi.h
>> +F:	include/uapi/linux/virtio_scmi.h
>>  
>>  SYSTEM RESET/SHUTDOWN DRIVERS
>>  M:	Sebastian Reichel <sre@kernel.org>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index e8377b12e4d0..7e9eafdd9b63 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -39,6 +39,18 @@ config ARM_SCMI_HAVE_MSG
>>  	  This declares whether a message passing based transport for SCMI is
>>  	  available.
>>  
>> +# This config option includes the dependencies of ARM_SCMI_PROTOCOL so that
>> +# this config doesn't show up when SCMI wouldn't be available.
>> +config VIRTIO_SCMI
>> +	bool "Virtio transport for SCMI"
>> +	select ARM_SCMI_HAVE_MSG
>> +	depends on VIRTIO && (ARM || ARM64 || COMPILE_TEST)
>> +	help
>> +	  This enables the virtio based transport for SCMI.
>> +
>> +	  If you want to use the ARM SCMI protocol between the virtio guest and
>> +	  a host providing a virtio SCMI device, answer Y.
>> +
>>  config ARM_SCMI_POWER_DOMAIN
>>  	tristate "SCMI power domain driver"
>>  	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
>> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
>> index f6b4acb8abdb..db1787606fb2 100644
>> --- a/drivers/firmware/arm_scmi/Makefile
>> +++ b/drivers/firmware/arm_scmi/Makefile
>> @@ -5,6 +5,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>>  scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
>>  scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
>>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>> +scmi-transport-$(CONFIG_VIRTIO_SCMI) += virtio.o
>>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
>>  scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
>>  		    $(scmi-transport-y)
>> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
>> index 4cb6571c7aaf..bada06cfd33d 100644
>> --- a/drivers/firmware/arm_scmi/common.h
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -349,6 +349,9 @@ extern const struct scmi_desc scmi_mailbox_desc;
>>  #ifdef CONFIG_HAVE_ARM_SMCCC
>>  extern const struct scmi_desc scmi_smc_desc;
>>  #endif
>> +#ifdef CONFIG_VIRTIO_SCMI
>> +extern const struct scmi_desc scmi_virtio_desc;
>> +#endif
>>  
>>  int scmi_set_transport_info(struct device *dev, void *transport_info);
>>  void *scmi_get_transport_info(struct device *dev);
>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>> index e04e7c8e6928..a31187385470 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -1637,6 +1637,9 @@ static const struct of_device_id scmi_of_match[] = {
>>  #endif
>>  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>>  	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>> +#endif
>> +#ifdef CONFIG_VIRTIO_SCMI
>> +	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>>  #endif
>>  	{ /* Sentinel */ },
>>  };
>> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
>> new file mode 100644
>> index 000000000000..20972adf6dc7
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/virtio.c
>> @@ -0,0 +1,523 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Virtio Transport driver for Arm System Control and Management Interface
>> + * (SCMI).
>> + *
>> + * Copyright (C) 2020 OpenSynergy.
>> + */
>> +
>> +/**
>> + * DOC: Theory of Operation
>> + *
>> + * The scmi-virtio transport implements a driver for the virtio SCMI device.
>> + *
>> + * There is one Tx channel (virtio cmdq, A2P channel) and at most one Rx
>> + * channel (virtio eventq, P2A channel). Each channel is implemented through a
>> + * virtqueue. Access to each virtqueue is protected by spinlocks.
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/virtio.h>
>> +#include <linux/virtio_config.h>
>> +#include <uapi/linux/virtio_ids.h>
>> +#include <uapi/linux/virtio_scmi.h>
>> +
>> +#include "common.h"
>> +
>> +#define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
>> +#define VIRTIO_SCMI_MAX_PDU_SIZE \
>> +	(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
>> +#define DESCRIPTORS_PER_TX_MSG 2
>> +
>> +/**
>> + * struct scmi_vio_channel - Transport channel information
>> + *
>> + * @lock: Protects access to all members except ready.
>> + * @ready_lock: Protects access to ready. If required, it must be taken before
>> + *              lock.
>> + * @vqueue: Associated virtqueue
>> + * @cinfo: SCMI Tx or Rx channel
>> + * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
>> + * @is_rx: Whether channel is an Rx channel
>> + * @ready: Whether transport user is ready to hear about channel
>> + */
>> +struct scmi_vio_channel {
>> +	spinlock_t lock;
>> +	spinlock_t ready_lock;
>> +	struct virtqueue *vqueue;
>> +	struct scmi_chan_info *cinfo;
>> +	struct list_head free_list;
>> +	u8 is_rx;
>> +	u8 ready;
>> +};
>> +
>> +/**
>> + * struct scmi_vio_msg - Transport PDU information
>> + *
>> + * @request: SDU used for commands
>> + * @input: SDU used for (delayed) responses and notifications
>> + * @list: List which scmi_vio_msg may be part of
>> + * @rx_len: Input SDU size in bytes, once input has been received
>> + */
>> +struct scmi_vio_msg {
>> +	struct scmi_msg_payld *request;
>> +	struct scmi_msg_payld *input;
>> +	struct list_head list;
>> +	unsigned int rx_len;
>> +};
>> +
>> +static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
>> +{
>> +	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
>> +}
>> +
>> +static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
>> +			       struct scmi_vio_msg *msg)
>> +{
>> +	struct scatterlist sg_in;
>> +	int rc;
>> +	unsigned long flags;
>> +
>> +	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
>> +
>> +	spin_lock_irqsave(&vioch->lock, flags);
>> +
>> +	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
>> +	if (rc)
>> +		dev_err_once(vioch->cinfo->dev,
>> +			     "%s() failed to add to virtqueue (%d)\n", __func__,
>> +			     rc);
>> +	else
>> +		virtqueue_kick(vioch->vqueue);
>> +
>> +	spin_unlock_irqrestore(&vioch->lock, flags);
>> +
>> +	return rc;
>> +}
>> +
>> +static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>> +{
>> +	unsigned long ready_flags;
>> +	unsigned long flags;
>> +	unsigned int length;
>> +	struct scmi_vio_channel *vioch;
>> +	struct scmi_vio_msg *msg;
>> +	bool cb_enabled = true;
>> +
>> +	if (WARN_ON_ONCE(!vqueue->vdev->priv))
>> +		return;
>> +	vioch = &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->index];
>> +
>> +	for (;;) {
>> +		spin_lock_irqsave(&vioch->ready_lock, ready_flags);
>> +
>> +		if (!vioch->ready) {
>> +			if (!cb_enabled)
>> +				(void)virtqueue_enable_cb(vqueue);
>> +			goto unlock_ready_out;
>> +		}
>> +
>> +		spin_lock_irqsave(&vioch->lock, flags);
>> +		if (cb_enabled) {
>> +			virtqueue_disable_cb(vqueue);
>> +			cb_enabled = false;
>> +		}
>> +		msg = virtqueue_get_buf(vqueue, &length);
>> +		if (!msg) {
>> +			if (virtqueue_enable_cb(vqueue))
>> +				goto unlock_out;
>> +			else
>> +				cb_enabled = true;
>> +		}
>> +		spin_unlock_irqrestore(&vioch->lock, flags);
>> +
>> +		if (msg) {
>> +			msg->rx_len = length;
>> +
>> +			/*
>> +			 * Hold the ready_lock during the callback to avoid
>> +			 * races when the arm-scmi driver is unbinding while
>> +			 * the virtio device is not quiesced yet.
>> +			 */
>> +			scmi_rx_callback(vioch->cinfo,
>> +					 msg_read_header(msg->input), msg);
>> +		}
>> +		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
>> +	}
>> +
>> +unlock_out:
>> +	spin_unlock_irqrestore(&vioch->lock, flags);
>> +unlock_ready_out:
>> +	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
>> +}
>> +
>> +static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
>> +
>> +static vq_callback_t *scmi_vio_complete_callbacks[] = {
>> +	scmi_vio_complete_cb,
>> +	scmi_vio_complete_cb
>> +};
>> +
>> +static unsigned int virtio_get_max_msg(bool tx,
>> +				       struct scmi_chan_info *base_cinfo)
>> +{
>> +	struct scmi_vio_channel *vioch = base_cinfo->transport_info;
>> +	unsigned int ret;
>> +
>> +	ret = virtqueue_get_vring_size(vioch->vqueue);
>> +
>> +	/* Tx messages need multiple descriptors. */
>> +	if (tx)
>> +		ret /= DESCRIPTORS_PER_TX_MSG;
>> +
>> +	if (ret > MSG_TOKEN_MAX) {
>> +		dev_info_once(
>> +			base_cinfo->dev,
>> +			"Only %ld messages can be pending simultaneously, while the %s virtqueue could hold %d\n",
>> +			MSG_TOKEN_MAX, tx ? "tx" : "rx", ret);
>> +		ret = MSG_TOKEN_MAX;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_vio_match_any_dev(struct device *dev, const void *data)
>> +{
>> +	return 1;
>> +}
>> +
>> +static struct virtio_driver virtio_scmi_driver; /* Forward declaration */
>> +
>> +static int virtio_link_supplier(struct device *dev)
>> +{
>> +	struct device *vdev = driver_find_device(
>> +		&virtio_scmi_driver.driver, NULL, NULL, scmi_vio_match_any_dev);
>> +
>> +	if (!vdev) {
>> +		dev_notice_once(
>> +			dev,
>> +			"Deferring probe after not finding a bound scmi-virtio device\n");
>> +		return -EPROBE_DEFER;
>> +	}
>> +
>> +	/* Add device link for remove order and sysfs link. */
>> +	if (!device_link_add(dev, vdev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
>> +		put_device(vdev);
>> +		dev_err(dev, "Adding link to supplier virtio device failed\n");
>> +		return -ECANCELED;
>> +	}
>> +
>> +	put_device(vdev);
>> +	return scmi_set_transport_info(dev, dev_to_virtio(vdev));
>> +}
>> +
>> +static bool virtio_chan_available(struct device *dev, int idx)
>> +{
>> +	struct virtio_device *vdev;
>> +
>> +	/* scmi-virtio doesn't support per-protocol channels */
>> +	if (is_scmi_protocol_device(dev))
>> +		return false;
>> +
>> +	vdev = scmi_get_transport_info(dev);
>> +	if (!vdev)
>> +		return false;
>> +
>> +	switch (idx) {
>> +	case VIRTIO_SCMI_VQ_TX:
>> +		return true;
>> +	case VIRTIO_SCMI_VQ_RX:
>> +		return scmi_vio_have_vq_rx(vdev);
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>> +			     bool tx)
>> +{
>> +	unsigned long flags;
>> +	struct virtio_device *vdev;
>> +	struct scmi_vio_channel *vioch;
>> +	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
>> +	int max_msg;
>> +	int i;
>> +
>> +	if (!virtio_chan_available(dev, index))
>> +		return -ENODEV;
>> +
>> +	vdev = scmi_get_transport_info(dev);
>> +	vioch = &((struct scmi_vio_channel *)vdev->priv)[index];
>> +
>> +	spin_lock_irqsave(&vioch->lock, flags);
>> +	cinfo->transport_info = vioch;
>> +	vioch->cinfo = cinfo;
>> +	spin_unlock_irqrestore(&vioch->lock, flags);
>> +
>> +	max_msg = virtio_get_max_msg(tx, cinfo);
>> +
>> +	for (i = 0; i < max_msg; i++) {
>> +		struct scmi_vio_msg *msg;
>> +
>> +		msg = devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
>> +		if (!msg)
>> +			return -ENOMEM;
>> +
>> +		if (tx) {
>> +			msg->request = devm_kzalloc(cinfo->dev,
>> +						    VIRTIO_SCMI_MAX_PDU_SIZE,
>> +						    GFP_KERNEL);
>> +			if (!msg->request)
>> +				return -ENOMEM;
>> +		}
>> +
>> +		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
>> +					  GFP_KERNEL);
>> +		if (!msg->input)
>> +			return -ENOMEM;
>> +
>> +		if (tx) {
>> +			spin_lock_irqsave(&vioch->lock, flags);
>> +			list_add_tail(&msg->list, &vioch->free_list);
>> +			spin_unlock_irqrestore(&vioch->lock, flags);
>> +		} else {
>> +			scmi_vio_feed_vq_rx(vioch, msg);
>> +		}
>> +	}
>> +
>> +	spin_lock_irqsave(&vioch->ready_lock, flags);
>> +	vioch->ready = true;
>> +	spin_unlock_irqrestore(&vioch->ready_lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtio_chan_free(int id, void *p, void *data)
>> +{
>> +	unsigned long flags;
>> +	struct scmi_chan_info *cinfo = p;
>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +
>> +	spin_lock_irqsave(&vioch->ready_lock, flags);
>> +	vioch->ready = false;
>> +	spin_unlock_irqrestore(&vioch->ready_lock, flags);
>> +
>> +	scmi_free_channel(cinfo, data, id);
>> +	return 0;
>> +}
>> +
>> +static int virtio_send_message(struct scmi_chan_info *cinfo,
>> +			       struct scmi_xfer *xfer)
>> +{
>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +	struct scatterlist sg_out;
>> +	struct scatterlist sg_in;
>> +	struct scatterlist *sgs[DESCRIPTORS_PER_TX_MSG] = { &sg_out, &sg_in };
>> +	unsigned long flags;
>> +	int rc;
>> +	struct scmi_vio_msg *msg;
>> +
>> +	/*
>> +	 * TODO: For now, we don't support polling. But it should not be
>> +	 * difficult to add support.
>> +	 */
>> +	if (xfer->hdr.poll_completion)
>> +		return -EINVAL;
>> +
>> +	spin_lock_irqsave(&vioch->lock, flags);
>> +
>> +	if (list_empty(&vioch->free_list)) {
>> +		spin_unlock_irqrestore(&vioch->lock, flags);
>> +		return -EBUSY;
>> +	}
>> +
>> +	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
>> +	list_del(&msg->list);
>> +
>> +	msg_tx_prepare(msg->request, xfer);
>> +
>> +	sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
>> +	sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
>> +
>> +	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
>> +	if (rc) {
>> +		list_add(&msg->list, &vioch->free_list);
>> +		dev_err_once(vioch->cinfo->dev,
>> +			     "%s() failed to add to virtqueue (%d)\n", __func__,
>> +			     rc);
>> +	} else {
>> +		virtqueue_kick(vioch->vqueue);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&vioch->lock, flags);
>> +
>> +	return rc;
>> +}
>> +
>> +static void virtio_fetch_response(struct scmi_chan_info *cinfo,
>> +				  struct scmi_xfer *xfer, void *msg_handle)
>> +{
>> +	struct scmi_vio_msg *msg = msg_handle;
>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +
>> +	if (!msg) {
>> +		dev_dbg_once(&vioch->vqueue->vdev->dev,
>> +			     "Ignoring %s() call with NULL msg_handle\n",
>> +			     __func__);
>> +		return;
>> +	}
>> +
>> +	msg_fetch_response(msg->input, msg->rx_len, xfer);
>> +}
>> +
>> +static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
>> +				      size_t max_len, struct scmi_xfer *xfer,
>> +				      void *msg_handle)
>> +{
>> +	struct scmi_vio_msg *msg = msg_handle;
>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +
>> +	if (!msg) {
>> +		dev_dbg_once(&vioch->vqueue->vdev->dev,
>> +			     "Ignoring %s() call with NULL msg_handle\n",
>> +			     __func__);
>> +		return;
>> +	}
>> +
>> +	msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
>> +}
>> +
>> +static void dummy_clear_channel(struct scmi_chan_info *cinfo)
>> +{
>> +}
>> +
>> +static bool dummy_poll_done(struct scmi_chan_info *cinfo,
>> +			    struct scmi_xfer *xfer)
>> +{
>> +	return false;
>> +}
>> +
>> +static void virtio_drop_message(struct scmi_chan_info *cinfo, void *msg_handle)
>> +{
>> +	unsigned long flags;
>> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
>> +	struct scmi_vio_msg *msg = msg_handle;
>> +
>> +	if (!msg) {
>> +		dev_dbg_once(&vioch->vqueue->vdev->dev,
>> +			     "Ignoring %s() call with NULL msg_handle\n",
>> +			     __func__);
>> +		return;
>> +	}
>> +
>> +	if (vioch->is_rx) {
>> +		scmi_vio_feed_vq_rx(vioch, msg);
>> +	} else {
>> +		spin_lock_irqsave(&vioch->lock, flags);
>> +		list_add(&msg->list, &vioch->free_list);
>> +		spin_unlock_irqrestore(&vioch->lock, flags);
>> +	}
>> +}
>> +
>> +static const struct scmi_transport_ops scmi_virtio_ops = {
>> +	.link_supplier = virtio_link_supplier,
>> +	.chan_available = virtio_chan_available,
>> +	.chan_setup = virtio_chan_setup,
>> +	.chan_free = virtio_chan_free,
>> +	.get_max_msg = virtio_get_max_msg,
>> +	.send_message = virtio_send_message,
>> +	.fetch_response = virtio_fetch_response,
>> +	.fetch_notification = virtio_fetch_notification,
>> +	.clear_channel = dummy_clear_channel,
>> +	.poll_done = dummy_poll_done,
>> +	.drop_message = virtio_drop_message,
>> +};
>> +
>> +static int scmi_vio_probe(struct virtio_device *vdev)
>> +{
>> +	struct device *dev = &vdev->dev;
>> +	struct scmi_vio_channel *channels;
>> +	bool have_vq_rx;
>> +	int vq_cnt;
>> +	int i;
>> +	int ret;
>> +	struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
>> +
>> +	have_vq_rx = scmi_vio_have_vq_rx(vdev);
>> +	vq_cnt = have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
>> +
>> +	channels = devm_kcalloc(dev, vq_cnt, sizeof(*channels), GFP_KERNEL);
>> +	if (!channels)
>> +		return -ENOMEM;
>> +
>> +	if (have_vq_rx)
>> +		channels[VIRTIO_SCMI_VQ_RX].is_rx = true;
>> +
>> +	ret = virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
>> +			      scmi_vio_vqueue_names, NULL);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
>> +		return ret;
>> +	}
>> +	dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
>> +
>> +	for (i = 0; i < vq_cnt; i++) {
>> +		spin_lock_init(&channels[i].lock);
>> +		spin_lock_init(&channels[i].ready_lock);
>> +		INIT_LIST_HEAD(&channels[i].free_list);
>> +		channels[i].vqueue = vqs[i];
>> +	}
>> +
>> +	vdev->priv = channels;
>> +
>> +	return 0;
>> +}
>> +
>> +static void scmi_vio_remove(struct virtio_device *vdev)
>> +{
>> +	vdev->config->reset(vdev);
>> +	vdev->config->del_vqs(vdev);
>> +}
>> +
>> +static unsigned int features[] = {
>> +	VIRTIO_SCMI_F_P2A_CHANNELS,
>> +};
>> +
>> +static const struct virtio_device_id id_table[] = {
>> +	{ VIRTIO_ID_SCMI, VIRTIO_DEV_ANY_ID },
>> +	{ 0 }
>> +};
>> +
>> +static struct virtio_driver virtio_scmi_driver = {
>> +	.driver.name = "scmi-virtio",
>> +	.driver.owner = THIS_MODULE,
>> +	.feature_table = features,
>> +	.feature_table_size = ARRAY_SIZE(features),
>> +	.id_table = id_table,
>> +	.probe = scmi_vio_probe,
>> +	.remove = scmi_vio_remove,
>> +};
>> +
>> +static int __init virtio_scmi_init(void)
>> +{
>> +	return register_virtio_driver(&virtio_scmi_driver);
>> +}
>> +
>> +static void __exit virtio_scmi_exit(void)
>> +{
>> +	unregister_virtio_driver(&virtio_scmi_driver);
>> +}
>> +
>> +const struct scmi_desc scmi_virtio_desc = {
>> +	.init = virtio_scmi_init,
>> +	.exit = virtio_scmi_exit,
>> +	.ops = &scmi_virtio_ops,
>> +	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
>> +	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>> +	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
>> +};
>> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
>> index f0c35ce8628c..c146fe30e589 100644
>> --- a/include/uapi/linux/virtio_ids.h
>> +++ b/include/uapi/linux/virtio_ids.h
>> @@ -56,5 +56,6 @@
>>  #define VIRTIO_ID_PMEM			27 /* virtio pmem */
>>  #define VIRTIO_ID_BT			28 /* virtio bluetooth */
>>  #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
>> +#define VIRTIO_ID_SCMI			32 /* virtio SCMI */
>>  
>>  #endif /* _LINUX_VIRTIO_IDS_H */
>> diff --git a/include/uapi/linux/virtio_scmi.h b/include/uapi/linux/virtio_scmi.h
>> new file mode 100644
>> index 000000000000..732b01504c35
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_scmi.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>> +/*
>> + * Copyright (C) 2020 OpenSynergy GmbH
>> + */
>> +
>> +#ifndef _UAPI_LINUX_VIRTIO_SCMI_H
>> +#define _UAPI_LINUX_VIRTIO_SCMI_H
>> +
>> +#include <linux/virtio_types.h>
>> +
>> +/* Feature bits */
>> +
>> +/* Device implements some SCMI notifications, or delayed responses. */
>> +#define VIRTIO_SCMI_F_P2A_CHANNELS 0
>> +
>> +/* Device implements any SCMI statistics shared memory region */
>> +#define VIRTIO_SCMI_F_SHARED_MEMORY 1
>> +
>> +/* Virtqueues */
>> +
>> +#define VIRTIO_SCMI_VQ_TX 0 /* cmdq */
>> +#define VIRTIO_SCMI_VQ_RX 1 /* eventq */
>> +#define VIRTIO_SCMI_VQ_MAX_CNT 2
>> +
>> +#endif /* _UAPI_LINUX_VIRTIO_SCMI_H */
>> -- 
>> 2.25.1
>>
>>
> 


