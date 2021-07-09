Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9C3C2191
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhGIJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:28:37 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:45190 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbhGIJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:28:35 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1699MJ7V009276;
        Fri, 9 Jul 2021 09:25:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-0064b401.pphosted.com with ESMTP id 39ny6c8uns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 09:25:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGXHKrEOa2P6wbdWQqsxunPlAcLkWUdeo/rMEHnMBlKJETeGRmzs1laUH1P9frLickxyvsAxm7Nk90+N96gHwqGZ5Vsd2wlZFcInU8BAsFRM2WDkT5xgZow7R3s5nzR+q5WE1k3XNxL77LPN2wsFaMqPB/nRAwSR5dH7aFE2GkKihnRW/A2fo3g0JDyYmR/5yAV1XaslZkVvbJ4STuFH/LrKar9gcLerd+CBwuf7rmdVjPiwYRoPlvoG5tcxoEE3cVMg/nYsBZsqmUY0YBmwRNZEsafamMLrDimH3yCYCar2R4WQHuW6NjwrO+/W88r/2EmazSLWphqHIwWFP2aWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuHQzzlx9h2Mj1SME16pFfHN9QkQj/Nwy+LvabU/Heg=;
 b=eLRPexgCaOXbSmZgkI6SDTli+QviJkRkummixEpa07YtDIKyELSKVS/Oe7CzUaMFp9hz6vruAtoNtL+7dFAKMMA4XO4hbp3SKxPkqN8LsxTujA4sI5OBUtyb7uyUU6DjXVJh3vzDCFSXu1AvlP8ljuxZ1dhBNA+IW80Lx7H27Hul9MZjUYYN4tuvTwwNGakoreizM7zdk6u52Aauk5on7EWZwf6UBuIq3kDYax+dym4XiK/4rKn/hyn9bMQN2R4rEX54OTJVusu2pHbd/Wo5TGAyAtbNV5ERgTopWNEmfmReDv3qflfstnvQvhGkBwJq1DPjeYb13b9TXlqJz7Ht7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuHQzzlx9h2Mj1SME16pFfHN9QkQj/Nwy+LvabU/Heg=;
 b=euZLWfeP/zkHKS5PQNyqW53pRVcgGp1QvUN2zMMC4Xy2r5eHhPFqokigySTR2DSSH13PQ9BjkVsDY/4ZXDz0E4vTHo2hEE2d6K61T57GmJh5741Ty1umAggSBNBPL6VaA9HwkCSPU1L6hsXoj2qD+8V9tICWXcyarW91V3NGiu4=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) by
 DM8PR11MB5654.namprd11.prod.outlook.com (2603:10b6:8:33::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20; Fri, 9 Jul 2021 09:25:45 +0000
Received: from DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f]) by DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f%9]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 09:25:45 +0000
Subject: Re: [PATCH v2] timers: Recalculate next timer interrupt only when
 necessary
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <20200723151641.12236-1-frederic@kernel.org>
 <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
 <20210708153620.GA6716@lothringen>
 <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
 <20210709084303.GA17239@lothringen>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
Date:   Fri, 9 Jul 2021 17:25:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210709084303.GA17239@lothringen>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To DM8PR11MB5637.namprd11.prod.outlook.com
 (2603:10b6:8:33::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR0401CA0002.apcprd04.prod.outlook.com (2603:1096:202:2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 09:25:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bee5eb1d-cba6-4a1c-43e2-08d942bb8783
X-MS-TrafficTypeDiagnostic: DM8PR11MB5654:
X-Microsoft-Antispam-PRVS: <DM8PR11MB5654BA6F127DC4A6C8259A358F189@DM8PR11MB5654.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R997WIdVHOY5EUlljaCrRARy4iMwZX2k4bbciT4T8i2gugLbcXb+qim6HMvVlV8SpMDjFo3RrbN7Wm4qg0Jwqq7ucOiM0D2n43ScZl1SpD5sLZo94JxLfif4v8oFdawOCU+CWazXw4yZsdbtb7HubsnVduTG61YZNE1nImwDnQqIrvw08gnT1TxDNKUuwnB0I01xK05+IkKrpTBHcY8TyPeCKiR9oT80qB2LAS5ja8IoplskKJMWVFHIqCJNgiEmz03i4EWMAUeNB0K1fFV1XB0sr+xyYMUJTn8BnfjHEXPSne2MIi4gm+Lug9O6x+GLwpYDaxMn6/CNhWD7Tw71hfC/Q9CHYUXtyOOET4xmKnX9t9FWShwQFuZ1pSGWZpIUjCkMaWmjqUkkOg3c9A2tfOIh+z1DCQJYtYhUotsoP22bdKnZ/GeOAjteA8ncP88w9+XiCQ7FUOKoOG3PMK/oHjuMvD1EkijgUVyAC2d47E4ivd/nhyPyOcZCHNFuomlGnui7ZvWvQrfe5yS7Ulz1KB42jltL3OC10/Chiy5+mb01RpvW84FhGHIZ35AhJjYqTrocQZvsrOrxFmP728dyZIg8NQQ5sonH9g9e3vVqT7WMMpPXm3Pl7gkWVk6+8V3pmVsWRSwcNLyFfy35x/uiIoat+eIFW+6IDRsu1WfWB+pnxKTLyzfzWiS2Xv/Tzy/lYekE8YWb/2k1IbUUxhsZY4ay7AVNDiG++eSojRDXuxqv3mYyPFSCcz/Ax1c1JzlX1peLwSTFoIdOkzVDCrn9Trf/+AMaV9PTScANRvNl6b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5637.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39840400004)(346002)(6916009)(4326008)(31696002)(16576012)(38350700002)(956004)(5660300002)(86362001)(52116002)(83380400001)(31686004)(478600001)(6706004)(2616005)(66556008)(66476007)(66946007)(186003)(36756003)(2906002)(6666004)(53546011)(8676002)(8936002)(6486002)(26005)(38100700002)(316002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2h5KzAvVmMrVTFjU0ozemtMdXdPQWZ3d09zUEJNNXRFTUc1ZFdpeTBwR0p4?=
 =?utf-8?B?N3pvQUFFRWI2MXlhQnp5QlRnNFErbEwxbWdBSE45ZFJQdXBnU1BPQ3JjZll1?=
 =?utf-8?B?RWJnWmt4TTBBNGxyYkRiWkJsZkx2S1U2S3NkZGRqMENiLzFhQWpFNW0rdmlH?=
 =?utf-8?B?TTZUR3pxQzRwT3dCNW9RYnpiT0gwSTBDR1U0YXRRUWEzcHdjN2xReURTcjlq?=
 =?utf-8?B?a2l5cFBOSk9qZ3Z1Ky83SWlKaEhwcG1LUldkTjVsZmJCN3VMWmRlTUtFK2ZJ?=
 =?utf-8?B?emdOOEVUUGl1UEpjTExzNG1UYWVRV25Zd29CNzJ2RFIrS1dCZHI1Y0dJY1d3?=
 =?utf-8?B?RTI5NkdtZjJrTkg0TjFXdEZFUjJJdkxGdEU0SlZheGU4c3k5ak1IRzk1N20z?=
 =?utf-8?B?TFFNTFBTalo1TzlNVWpJNWVLWkFzbWdWaDR4dE03WjhkMzFkR0ozRDBwbk0w?=
 =?utf-8?B?QjVHR0pCRTZ6WDVkZXRRVW1LUnNIZWZvUXg2UzQ3ekoyS0g0N2VhN3JHVHRY?=
 =?utf-8?B?R3BpbHU4QU53aGppQ212RHNQM1pldy9QUTh1NnBIZ005SURaRVN5Y1l5SC9Z?=
 =?utf-8?B?Q241dGlzVDFSNEVrdDhpZEtIS3NkRlVQekt0d3NzU0djVFd4dUhhQ0JZR2dR?=
 =?utf-8?B?UHpLcTRiVVhmdkpxam5yRituOVdaTkV4ZEMySHcvdjJVbTdkU3FLdWQyWmo5?=
 =?utf-8?B?WFBEVU42UjRZNmhxZFE5Wk52cG5hdjJtNXNKdTNlUEQyTGRQS1d1RVlDdkpz?=
 =?utf-8?B?cXV5MGVZc0ZTem9XeHN4Snl3RTcreThaTVJjd1F6MVQxOUVWQlZqTmRaSnJS?=
 =?utf-8?B?NXI2RGR2V1NXUjJGMk9wMlhLMElxeVZvUTFVSHQ0dUxyZzBNbGttYjNwUWRL?=
 =?utf-8?B?Zzc5eHl4OWRCQ1lEWWFrazRtRUllVHFGR0YwcDVvcjhRYzhRMmlrVDZ3cFBW?=
 =?utf-8?B?R2VYa1lsZWdja1dBNm1CRFVqTURaNnQzTVdadThRMGxIaVdKa1VOT2lzYzVZ?=
 =?utf-8?B?c0dhdHFTUmNUaC93UmZCRWZPdHVWQWYyTnB0c2E4V1V4MUcrVGcvRlV5WjR4?=
 =?utf-8?B?N2tqVzFyNUJXcldqcUowVy9FVFRXL3EvbTZ6ME1zMFpiYVlWZG1FQU1Pckww?=
 =?utf-8?B?aUd4N3R4SVhSVVJqOEtaMFBYcm5ZUVBOdjNnVXZXb1IxSzcweU0rUnVLMWhQ?=
 =?utf-8?B?K1FHSHNFa0xEOWdaWWROalpuSUtHMFc3ZlZMY1dGelJhRHQwZUxjbjVEayt5?=
 =?utf-8?B?eVBVZXRYZCtvc1huSzVWQUZLeStsbzZzTlF6eTNiRlI3bCtJeVM4VE5Lb09U?=
 =?utf-8?B?TWwrQUx4Mi9lS3ZWeEF5VWFjNzI0ZWFBT29Gb0xFci9ER2lELys0bUJ3cWxo?=
 =?utf-8?B?QVBiempTTkk0Z2g1aURiQjlYdnVGcC9PcnRkR3VsWnlESnJmU0dWTlV0YjIx?=
 =?utf-8?B?VTdsRjF3SHpkQWNsMU9qSnZXaHY4QVJMVlBtMjFRQmN4T1gvZDNsajRFYjNW?=
 =?utf-8?B?NXZNMHgrbFVqNkcyRVNINzA1aTZ1RUxzNjFwN2N3VjRHVjg0OXRkcUs1SkdL?=
 =?utf-8?B?RE5sV3BDaWEwNk1BOWNOZ2w3YmFhQk56UnpNY20vYUt0RWtncTJGbS82YkM3?=
 =?utf-8?B?VjlVZjNHOUlRbmo2RUMycGFMd2tTT1dvZnFxbC85M2REK0xRZnhGRGxRUGFM?=
 =?utf-8?B?OTh5ckhHTGtRSjJYRjcwejExZjMyc0tTWHMxR3ZwWksrZThLWU1UbVZaZ1Fo?=
 =?utf-8?Q?mZhRIz/13taA1MYyfGVWn9G87ChIwaYMaIWe+fp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee5eb1d-cba6-4a1c-43e2-08d942bb8783
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5637.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 09:25:45.1063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CdyxvbYyGM3lHqO9COzOeEVYiZPIQHDvm+GjHd2OIPAhYXa5TpPyguU8qWIzu/+CHDssmkXRarxbzU/naoGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5654
X-Proofpoint-ORIG-GUID: ueaY2w6fnKvDMLqlF5HcmVLs7Yokds8q
X-Proofpoint-GUID: ueaY2w6fnKvDMLqlF5HcmVLs7Yokds8q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=567 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/21 4:43 PM, Frederic Weisbecker wrote:
> On Fri, Jul 09, 2021 at 01:37:11PM +0800, He Zhe wrote:
>>
>> On 7/8/21 11:36 PM, Frederic Weisbecker wrote:
>>> On Thu, Jul 08, 2021 at 02:43:01PM +0800, He Zhe wrote:
>>>> Hi,
>>>>
>>>> Ever since this commit merged in, when nohz_full enabled, the counts of arch_timer interrupt on arm64 arches keep increasing on cores that have been isolated. This can be reproduced on several arm64 boards. After reverting the commit, the counts would stop increasing after boot. my .config is attached.
>>>>
>>>> root@qemuarm64:~# uname -a
>>>> Linux qemuarm64 5.13.0 #1 SMP PREEMPT Mon Jul 5 07:11:27 UTC 2021 aarch64 aarch64 aarch64 GNU/Linux
>>>> root@qemuarm64:~# cat /proc/cmdline
>>>> root=/dev/vda rw  mem=2048M ip=dhcp console=ttyAMA0 console=hvc0  earlyprintk isolcpus=1-5 nohz_full=1-5 rcu_nocbs=1-5
>>>> root@qemuarm64:~# cat /proc/interrupts
>>> And I'm not observing that on default aarch64 on qemu either.
>>> Are you emulating a specific machine?
>> Here is my qemu configuration.
>>
>> qemu-system-aarch64 --version
>> QEMU emulator version 6.0.0
>> Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
>>
>> qemu-system-aarch64 -device virtio-net-device,netdev=net0,mac=52:54:00:12:35:02 -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::2323-:23,tftp=/qemuarm64 -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -drive id=disk0,file=/qemuarm64/qemuarm64.rootfs.ext4,if=none,format=raw -device virtio-blk-device,drive=disk0 -device qemu-xhci -device usb-tablet -device usb-kbd  -machine virt -cpu cortex-a57 -smp 4 -m 2048  -smp 6 -m 2048 -serial mon:stdio -serial null -nographic -device VGA,edid=on -kernel /qemuarm64/Image.bin -append 'root=/dev/vda rw  mem=2048M ip=dhcp console=ttyAMA0 console=hvc0 earlyprintk isolcpus=1-5 nohz_full=1-5 rcu_nocbs=1-5'
>>
>>> Can you enable the following trace events and send me the output from
>>> one of the isolated CPU trace, say CPU 3 for example:
>> output_to_send is attached.
>> I can confirm that during the sleep the count of arch_timer increases one on
>> each isolated core.
> Oh that's the trace from CPU 0, precisely the only one I don't need :o)
>
> It's my fault, the last line of the script should have been:
>
> cat $DIR/per_cpu/cpu3/trace > ~/output_to_send
>
> Sorry...

No problem. I didn't notice that either...

Then here is the result of cpu3
root@qemuarm64:~# cat output_to_send
# tracer: nop
#
# entries-in-buffer/entries-written: 19704/19704   #P:6
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
          <idle>-0       [003] d.h1   346.216802: irq_handler_entry: irq=11 name=arch_timer
          <idle>-0       [003] d.h1   346.216862: irq_handler_exit: irq=11 ret=handled

Zhe


