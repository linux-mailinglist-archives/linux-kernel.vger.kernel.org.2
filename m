Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE43B2F48
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhFXMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:46:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5072 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:46:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G9fnY5fxxzXkj8;
        Thu, 24 Jun 2021 20:38:41 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 20:43:53 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 20:43:53 +0800
Subject: Re: [RFC PATCH 1/4] Documentation: tracing: Documentation for
 ultrasoc framework and drivers
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <alexander.shishkin@linux.intel.com>, <suzuki.poulose@arm.com>,
        <jonathan.zhouwen@huawei.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
 <1623749684-65432-2-git-send-email-liuqi115@huawei.com>
 <20210623225111.GA1057775@p14s>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <0aac4467-3abc-026c-4989-22b87bc80dc7@huawei.com>
Date:   Thu, 24 Jun 2021 20:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210623225111.GA1057775@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for reviewing this patch.

On 2021/6/24 6:51, Mathieu Poirier wrote:
> Hi,
> 
> On Tue, Jun 15, 2021 at 05:34:41PM +0800, Qi Liu wrote:
>> Ultrasoc trace module is a system level solution for both core tracing
>> and SoC tracing. This patch brings in a documentation for ultrasoc
>> framework and drivers. It simply introduces function of ultrasoc, a
>> typical Ultrasoc system, and a driver framework for ultrasoc.
>>
>> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   Documentation/trace/ultrasoc-trace.rst | 209 +++++++++++++++++++++++++++++++++
>>   1 file changed, 209 insertions(+)
>>   create mode 100644 Documentation/trace/ultrasoc-trace.rst
>>
>> diff --git a/Documentation/trace/ultrasoc-trace.rst b/Documentation/trace/ultrasoc-trace.rst
>> new file mode 100644
>> index 0000000..36d2df2
>> --- /dev/null
>> +++ b/Documentation/trace/ultrasoc-trace.rst
>> @@ -0,0 +1,209 @@
>> +=======================================================
>> +Siemens Embedded Analytics - HW Assisted Tracing on SoC
>> +=======================================================
>> +   :Author:   Jonathan Zhou <Jonathan.zhouwen@huawei.com>
>> +              Qi Liu <liuqi115@huawei.com>
>> +   :Date:     January 16th, 2021
>> +
>> +Introduction
>> +------------
>> +
>> +The Siemens Embedded Analytics Framework is system level solution for tracing
>> +of multiple type SoC, this document is concerned with trace module. This module
>> +has two main components: AXI Bus Communicator and System Memory Buffer.
>> +
>> +The AXI Communicator has upstream and downstream channels, the upstream channel
>> +is used to transmit user configuration, and downstream channel to carry response
>> +and trace data to the users.
>> +
>> +The System Memory Buffer provides a way to buffer and store messages in system
>> +memory. It provides a capability to store messages received on its input message
>> +interface to an area of system memory.
>> +
>> +A typical Siemens trace system would look like the following diagram:
>> +                           @@@@@@@@@@@@@
>> +                           @    CPU    @
>> +                           @@@@@@@@@@@@@
>> +                           #############
>> +                           # Coresight #
>> +                             #  ETM  #
>> +                              #######
>> +                                ###
>> +                                 #
>> +                                 |
>> +                                 *
>> +                    *******************************
>> +                 *** AMBA Advanced Trace Bus (ATB) ***
>> +                    ***************^***************
>> +                          ===============    |
>> +                           === FUNNEL ==<--- |
>> +                              =======
>> +                                 |
>> +                                 *
>> +                              @@@@@@@
>> +                              @ TRC @
>> +                               @@@@@
>> +                                @@@
>> +                                 @
>> +                                 |
>> +                                 *
>> +    ************************************** *******************
>> + ************************ Message BUS ***************************
>> +    ******************^************************^****************
>> +             |                               |
>> +     @@@@@@@@@@@@@@@@@@                      |   @@@@@@@@@@@@
>> +     @ Message Engine @                      |   @ JTAG COM @
>> +     @@@@@@@@@@@@@@@@@@                      |    @@@@@@@@@@
>> +       |            *                        |---> @@@@@@@@
>> +       |            |                               @@@@@@
>> +    @@@@@@@         |   @@@@@@@@@@@                    |
>> +    @ SMB @         |   @ AXI COM @                  JTAG
>> +     @@@@@          |--> @@@@@@@@@
>> +      @@@--|              @@@@@@@
>> +       @   |               @@@@@
>> +           |                 |
>> +           |                 |
>> +           *                 *
>> +  ***************************************************************
>> + **************************** AMBA AXI  ****************************
>> +  *****************************************************************
>> +
>> +Acronyms
>> +---------------------------
>> +
>> +Acronyms:
>> +
>> +AXI-COM:     AXI Communicator
>> +SMB:         System Memory Buffer
>> +TRC:         Trace receiver
>> +
>> +Framework and implementation
>> +------------------------------
>> +
>> +Siemens Embedded Analytics Framework is implemented as a platform device. The
>> +platform device provides a global point to configure the Embedded Analytics
>> +subsystem, and also provides a ``struct ultrasoc_com`` to manage AXI-COM and
>> +SMB.
>> +
>> +AXI-COM and SMB are implemented as platform devices, each SCCL has one AXI-COM
>> +device and one SMB device. AXI-COM and SMB can use the following API to register
>> +into Embedded Analytics framework:
>> +.. c:function:: struct ultrasoc_com *ultrasoc_register_com(struct device *root_dev, struct ultrasoc_com_descp *com_descp)
>> +.. c:function:: void ultrasoc_unregister_com(struct ultrasoc_com *com);
>> +
>> +As TRC receives data from coresight ETM device, SMB can use the following API
>> +to register into coresight framework as a sink device:
>> +.. c:function:: struct coresight_device *coresight_register(struct coresight_desc *desc);
>> +.. c:function:: void coresight_unregister(struct coresight_device *csdev);
>> +
>> +Then users can get trace data by this path: ETM->funnel->SMB->System Memory.
>> +More information about coresight framework can be found in
>> +Documention/trace/coresight/coresight.rst.
>> +
>> +If everything goes well, the relationship of Embedded Analytics devices will be
>> +described under the sysfs::
>> +
>> +    $# ls /sys/bus/platform/devices/
>> +    <HID.Embedded Analytics>:00   <HID.axi-com>:00   <HID.smb>:00
>> +    $# ls /sys/bus/platform/devices/<HID.Embedded Analytics>:00
>> +    com_mux             firmware_node     power      <HID.axi-com>:00
>> +    driver              message           subsystem  <HID.smb>:00
>> +    driver_override     modalias          uevent
>> +    $# ls /sys/bus/coresight/devices/
>> +    etm0     etm14    etm2     etm25    etm30    etm8       funnel4
>> +    etm1     etm15    etm20    etm26    etm31    etm9       funnel5
>> +    etm10    etm16    etm21    etm27    etm4     funnel0    funnel6
>> +    etm11    etm17    etm22    etm28    etm5     funnel1    funnel7
>> +    etm12    etm18    etm23    etm29    etm6     funnel2    sink_smb0
>> +    etm13    etm19    etm24    etm3     etm7     funnel3
>> +    $# ls -l /sys/bus/coresight/devices/funnel0/connections/
>> +    <file details> in:0 -> ../../../../system/cpu/cpu0/ARMHC500:00/etm0
>> +    <file details> in:1 -> ../../../../system/cpu/cpu1/ARMHC500:01/etm1
>> +    <file details> in:2 -> ../../../../system/cpu/cpu2/ARMHC500:02/etm2
>> +    <file details> in:3 -> ../../../../system/cpu/cpu3/ARMHC500:03/etm3
>> +    <file details> nr_links
>> +    <file details> out:0 -> ../../../HISI0391:00/HISI03A1:00/sink_smb0
>> +    $# ls -l /sys/bus/coresight/devices/sink_smb0/connections/
>> +    <file details>  in:101 -> ../../../../ARMHC9FE:05/funnel5
>> +    <file details>  in:114 -> ../../../../ARMHC9FE:07/funnel7
>> +    <file details>  in:121 -> ../../../../ARMHC9FE:03/funnel3
>> +    <file details>  in:39 -> ../../../../ARMHC9FE:00/funnel0
>> +    <file details>  in:51 -> ../../../../ARMHC9FE:04/funnel4
>> +    <file details>  in:61 -> ../../../../ARMHC9FE:06/funnel6
>> +    <file details>  in:68 -> ../../../../ARMHC9FE:02/funnel2
>> +    <file details>  in:89 -> ../../../../ARMHC9FE:01/funnel1
>> +    <file details>  nr_links
>> +
>> +How to use the Embedded Analytics trace module
>> +-----------------------------------------------
>> +
>> +There are two ways to use the Embedded Analytics trace module:
>> +
>> +1. interacting directly with the devices using the sysFS interface.
>> +2. using the perf cmd line tools.
>> +
>> +1) Using the sysFS interface:
>> +
>> +Before trace collection can start, a coresight sink needs to be identified.
>> +There is no limit on the amount of sinks (nor sources) that can be enabled at
>> +any given moment.  As a generic operation, all device pertaining to the sink
>> +class will have an "active" entry in sysfs::
> 
> I haven't looked at the rest of the patchset but unless you have changed that,
> only one sink will be selected by the framework when operating from sysfs.
> Regardless of the number of sinks that were enabled, the framework will pick the
> first one it finds.
> 
Yes, framework only choose the first sink device if there are several 
sinks. I'll change the description in document in next version, thanks.

>> +
>> +    $# ls /sys/bus/coresight/devices/
>> +    etm0     etm14    etm2     etm25    etm30    etm8       funnel4
>> +    etm1     etm15    etm20    etm26    etm31    etm9       funnel5
>> +    etm10    etm16    etm21    etm27    etm4     funnel0    funnel6
>> +    etm11    etm17    etm22    etm28    etm5     funnel1    funnel7
>> +    etm12    etm18    etm23    etm29    etm6     funnel2    sink_smb0
>> +    etm13    etm19    etm24    etm3     etm7     funnel3
>> +    $# ls /sys/bus/coresight/devices/sink_smb0
>> +    connections  enable_sink  firmware_node  power  subsystem  uevent
>> +    $# echo 1 > /sys/bus/coresight/devices/sink_smb0/enable_sink
>> +    $# cat /sys/bus/coresight/devices/sink_smb0/enable_sink
>> +    1
>> +
>> +When start trace collection, etm devices corresponding to the enabled sink
>> +should be selected::
>> +
>> +    $# echo 1 > /sys/bus/coresight/devices/etm0/enable_source
>> +    $# cat /sys/bus/coresight/devices/etm0/enable_source
>> +    1
>> +    $# cat /sys/bus/platform/devices/<HID.smb>:00/com_status
>> +    com-type            : DOWN-ONLY
>> +    service status      : stopped
>> +    interrupt status    : 0x00000003
>> +    write point         : 0x5437f400   <----- The write pointer is moving
>> +
>> +Trace collection is stopped the same way::
>> +
>> +    $# echo 0 > /sys/bus/coresight/devices/etm0/enable_source
>> +    $# echo 0 > /sys/bus/coresight/devices/sink_smb0/enable_sink
>> +
>> +The content of the SMB buffer can be harvested directly from /dev::
>> +
>> +    $# dd if=/dev/sink_smb0 of=~/cstrace.bin
>> +    5233+0 records in
>> +    5233+0 records out
>> +    2679296 bytes (2.7 MB) copied, 0.0131708 s, 203 MB/s
>> +
>> +    root:/sys/bus/coresight/devices#
>> +
>> +The file cstrace.bin can be decompressed using "ptm2human".
>> +
>> +2) Using perf framework:
>> +
>> +As SMB device has been registered with coresight framework, perf tool can be
>> +used to control Embedded Analytics trace collection, and the method is similar
>> +to using perf to do coresight trace collection.
>> +
>> +The only thing to note is, list of cpus should be correspond to the specified
>> +sink device.
>> +
>> +Example usage of perf::
>> +
>> +	 $# ./perf list pmu
>> +	 cs_etm//                                    [Kernel PMU event]
>> +    $# ./perf record -e cs_etm/@sink_smb0/ -C 0 --per-thread sleep 2s
>> +    [ perf record: Woken up 2 times to write data ]
>> +    [ perf record: Captured and wrote 0.288 MB perf.data ]
>> +    $# ./perf report
> 
> After reading all this and without looking at the rest of the patchset it seems
> to me this work should go under drivers/hwtracing/coresight/.
> 

So how about drivers/hwtracing/coresight/ultrasoc?

> There is a lot of code to review and as such it will take me a fair amount of
> time to go through it all.  Comments will be scattered over several days (weeks)
> - I will set you know when I am done.
> 
> Thanks,
> Mathieu

Ok, thanks for revewing this patchset

Qi
> 
>> -- 
>> 2.7.4
>>
> .
> 

