Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846A31E7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBRIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:55:07 -0500
Received: from foss.arm.com ([217.140.110.172]:47122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhBRHv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:51:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFF4D1FB;
        Wed, 17 Feb 2021 23:50:17 -0800 (PST)
Received: from [10.57.42.30] (unknown [10.57.42.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC6C3F73B;
        Wed, 17 Feb 2021 23:50:15 -0800 (PST)
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
To:     Mike Leach <mike.leach@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210212202628.GC2692426@xps15>
 <9ca3b9da-dded-1206-e048-835590b2265e@arm.com>
 <CAJ9a7ViX6UUO66WX7M8hixg7dRdx7XPZNpfr3zwTaT=GBbWJSg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3d886de7-6f97-aa77-be15-635efb9de791@arm.com>
Date:   Thu, 18 Feb 2021 07:50:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7ViX6UUO66WX7M8hixg7dRdx7XPZNpfr3zwTaT=GBbWJSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

On 2/16/21 9:00 AM, Mike Leach wrote:
> Hi Anshuman,
> 
> There have been plenty of detailed comments so I will restrict mine to
> a few general issues:-
> 
> 1) Currently there appears to be no sysfs support (I cannot see the
> MODE_SYSFS constants running alongside the MODE_PERF ones present in
> the other sink drivers). This is present on all other coresight
> devices, and must be provided for this device. It is useful for
> testing, and there are users out there who will have scripts to use
> it. It is not essential it makes it into this set, but should be a
> follow up set.

This is mentioned in the cover-letter and as you rightly said
we could add this in a later series.

> 
> 2) Using FILL mode for TRBE means that the trace will by definition be
> lossy. Fill mode will halt collection without cleanly stopping and
> flushing the source. This will result in the sink missing the last of
> the data from the source as it stops. Even if taking the exception
> moves into a prohibited region there is still the possibility the last
> trace operations will not be seen. Further it is possible that the

Correct.

> last few bytes of trace will be an incomplete packet, and indeed the
> start of the next buffer could contain incomplete packets too.

Yes, this is possible.

> 
> This operation differs from the other sinks which will only halt after
> the sources have stopped and the path has been flushed. This ensures
> that the latest trace is complete. The weakness with the older sinks
> is the lack of interrupt meaning buffers were frequently wrapped so
> that only the latest trace is available.

This is true, when there was no overflow. i.e, we follow the normal
source-stop-flush, sink-stop.

> 
> By using TRBE WRAP mode, with a watermark as described in the TRBE
> spec, using the interrupts it is possible to approach lossless trace
> in a way that is not possible with earlier ETR/ETB. This is something

It may be possible to do lossless trace, but not without double buffering
in perf mode. In perf mode, with a single buffer, we have to honor the
boundaries set by the aux_buffer head and tail, otherwise we could be
corrupting the trace being consumed by the userland.

Please remember that the "water mark" is considered as the END of the
buffer by TRBE (unlike the SoC-600 ETR). So the LIMIT pointer could be
one of :

   * Tail pointer ( of the handle space, <=  End_of_the_Buffer)
   * Wake up pointer ( when the userspace would like to be woken up ,<= End_of_the_Buffer)

So, if we use WRAP mode for perf, the TRBE would overwrite the from
the Base, after we hit the LIMIT, where we should have started
writing *after* the LIMIT (when LIMIT < End_of_the_Buffer). Moreover
restarting from the Base is going to be even more trouble some
as it is most likely the data, perf is still collecting.

> that has been requested by partners since trace became available in
> linux systems. (There is still a possibility of loss due to filling
> the buffer completely and overflowing the watermark, but that can be
> flagged).
> 
> While FILL mode trace is a good start, and suitable for some scenarios
> - WRAP mode needs implementing as well.

Using WRAP mode makes sense only in the case of double buffering. Even
with that, we are not guaranteed that we wouldn't loose trace data, with
significantly larger buffer than the AUX buffer. So this may not be the
right choice looking at the performance and the software expectations.

When it comes to sysfs mode, I believe we could use the CIRCULAR_BUFFER
mode, as the collection is asynchronous. I understand WRAP is suitable
for lossless collection, but unfortunately the Linux sof

> 3) Padding: To be clear, it is not safe for the decoder to run off the
> end of one buffer, into the padding area and continue decoding, or
> continue through the padding into the next buffer. However I believe
> the buffer start / stop points are demarked by the aux_output_start /
> aux_output_end calls?

Yes. Each session is marked by RECORD_AUX. So, as long as we fix
the decoding to use the limit, we should be fine.

Thanks for raising this point.

Suzuki

> 
> With upcoming perf decode updates this should enable the decoder to
> correctly be started and stopped on the buffer boundaries. The padding
> is there primarily to ensure that the decoder does not synchronize
> with the data stream until a genuine sync point is found.
> 
> 4) TRBE needs to be a loadable module like the rest of coresight.
> 
> Regards
> 
> Mike
> 
> On Mon, 15 Feb 2021 at 09:46, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>> On 2/13/21 1:56 AM, Mathieu Poirier wrote:
>>> On Wed, Jan 27, 2021 at 02:25:35PM +0530, Anshuman Khandual wrote:
>>>> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
>>>> accessible via the system registers. The TRBE supports different addressing
>>>> modes including CPU virtual address and buffer modes including the circular
>>>> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
>>>> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
>>>> access to the trace buffer could be prohibited by a higher exception level
>>>> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
>>>> private interrupt (PPI) on address translation errors and when the buffer
>>>> is full. Overall implementation here is inspired from the Arm SPE driver.
>>>>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> Changes in V3:
>>>>
>>>> - Added new DT bindings document TRBE.yaml
>>>> - Changed TRBLIMITR_TRIG_MODE_SHIFT from 2 to 3
>>>> - Dropped isb() from trbe_reset_local()
>>>> - Dropped gap between (void *) and buf->trbe_base
>>>> - Changed 'int' to 'unsigned int' in is_trbe_available()
>>>> - Dropped unused function set_trbe_running(), set_trbe_virtual_mode(),
>>>>    set_trbe_enabled() and set_trbe_limit_pointer()
>>>> - Changed get_trbe_flag_update(), is_trbe_programmable() and
>>>>    get_trbe_address_align() to accept TRBIDR value
>>>> - Changed is_trbe_running(), is_trbe_abort(), is_trbe_wrap(), is_trbe_trg(),
>>>>    is_trbe_irq(), get_trbe_bsc() and get_trbe_ec() to accept TRBSR value
>>>> - Dropped snapshot mode condition in arm_trbe_alloc_buffer()
>>>> - Exit arm_trbe_init() when arm64_kernel_unmapped_at_el0() is enabled
>>>> - Compute trbe_limit before trbe_write to get the updated handle
>>>> - Added trbe_stop_and_truncate_event()
>>>> - Dropped trbe_handle_fatal()
>>>>
>>>>   Documentation/trace/coresight/coresight-trbe.rst |   39 +
>>>>   arch/arm64/include/asm/sysreg.h                  |    1 +
>>>>   drivers/hwtracing/coresight/Kconfig              |   11 +
>>>>   drivers/hwtracing/coresight/Makefile             |    1 +
>>>>   drivers/hwtracing/coresight/coresight-trbe.c     | 1023 ++++++++++++++++++++++
>>>>   drivers/hwtracing/coresight/coresight-trbe.h     |  160 ++++
>>>>   6 files changed, 1235 insertions(+)
>>>>   create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>>>>   create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>>>>   create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>>>>
>>>> diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Documentation/trace/coresight/coresight-trbe.rst
>>>> new file mode 100644
>>>> index 0000000..1cbb819
>>>> --- /dev/null
>>>> +++ b/Documentation/trace/coresight/coresight-trbe.rst
>>>> @@ -0,0 +1,39 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +==============================
>>>> +Trace Buffer Extension (TRBE).
>>>> +==============================
>>>> +
>>>> +    :Author:   Anshuman Khandual <anshuman.khandual@arm.com>
>>>> +    :Date:     November 2020
>>>> +
>>>> +Hardware Description
>>>> +--------------------
>>>> +
>>>> +Trace Buffer Extension (TRBE) is a percpu hardware which captures in system
>>>> +memory, CPU traces generated from a corresponding percpu tracing unit. This
>>>> +gets plugged in as a coresight sink device because the corresponding trace
>>>> +genarators (ETE), are plugged in as source device.
>>>> +
>>>> +The TRBE is not compliant to CoreSight architecture specifications, but is
>>>> +driven via the CoreSight driver framework to support the ETE (which is
>>>> +CoreSight compliant) integration.
>>>> +
>>>> +Sysfs files and directories
>>>> +---------------------------
>>>> +
>>>> +The TRBE devices appear on the existing coresight bus alongside the other
>>>> +coresight devices::
>>>> +
>>>> +    >$ ls /sys/bus/coresight/devices
>>>> +    trbe0  trbe1  trbe2 trbe3
>>>> +
>>>> +The ``trbe<N>`` named TRBEs are associated with a CPU.::
>>>> +
>>>> +    >$ ls /sys/bus/coresight/devices/trbe0/
>>>> +        align dbm
>>>> +
>>>> +*Key file items are:-*
>>>> +   * ``align``: TRBE write pointer alignment
>>>> +   * ``dbm``: TRBE updates memory with access and dirty flags
>>>> +
>>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>>> index 85ae4db..9e2e9b7 100644
>>>> --- a/arch/arm64/include/asm/sysreg.h
>>>> +++ b/arch/arm64/include/asm/sysreg.h
>>>> @@ -97,6 +97,7 @@
>>>>   #define SET_PSTATE_UAO(x)           __emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
>>>>   #define SET_PSTATE_SSBS(x)          __emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
>>>>   #define SET_PSTATE_TCO(x)           __emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
>>>> +#define TSB_CSYNC                   __emit_inst(0xd503225f)
>>>>
>>>>   #define set_pstate_pan(x)           asm volatile(SET_PSTATE_PAN(x))
>>>>   #define set_pstate_uao(x)           asm volatile(SET_PSTATE_UAO(x))
>>>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>>>> index f154ae7..aa657ab 100644
>>>> --- a/drivers/hwtracing/coresight/Kconfig
>>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>>> @@ -164,6 +164,17 @@ config CORESIGHT_CTI
>>>>         To compile this driver as a module, choose M here: the
>>>>         module will be called coresight-cti.
>>>>
>>>> +config CORESIGHT_TRBE
>>>> +    bool "Trace Buffer Extension (TRBE) driver"
>>>> +    depends on ARM64
>>>> +    help
>>>> +      This driver provides support for percpu Trace Buffer Extension (TRBE).
>>>> +      TRBE always needs to be used along with it's corresponding percpu ETE
>>>> +      component. ETE generates trace data which is then captured with TRBE.
>>>> +      Unlike traditional sink devices, TRBE is a CPU feature accessible via
>>>> +      system registers. But it's explicit dependency with trace unit (ETE)
>>>> +      requires it to be plugged in as a coresight sink device.
>>>> +
>>>>   config CORESIGHT_CTI_INTEGRATION_REGS
>>>>       bool "Access CTI CoreSight Integration Registers"
>>>>       depends on CORESIGHT_CTI
>>>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>>>> index f20e357..d608165 100644
>>>> --- a/drivers/hwtracing/coresight/Makefile
>>>> +++ b/drivers/hwtracing/coresight/Makefile
>>>> @@ -21,5 +21,6 @@ obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>>>>   obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>>>>   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>>>>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>>> +obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>>>   coresight-cti-y := coresight-cti-core.o     coresight-cti-platform.o \
>>>>                  coresight-cti-sysfs.o
>>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>>>> new file mode 100644
>>>> index 0000000..1464d8b
>>>> --- /dev/null
>>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>>>> @@ -0,0 +1,1023 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * This driver enables Trace Buffer Extension (TRBE) as a per-cpu coresight
>>>> + * sink device could then pair with an appropriate per-cpu coresight source
>>>> + * device (ETE) thus generating required trace data. Trace can be enabled
>>>> + * via the perf framework.
>>>> + *
>>>> + * Copyright (C) 2020 ARM Ltd.
>>>> + *
>>>> + * Author: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> + */
>>>> +#define DRVNAME "arm_trbe"
>>>> +
>>>> +#define pr_fmt(fmt) DRVNAME ": " fmt
>>>> +
>>>> +#include "coresight-trbe.h"
>>>> +
>>>> +#define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
>>>> +
>>>> +/*
>>>> + * A padding packet that will help the user space tools
>>>> + * in skipping relevant sections in the captured trace
>>>> + * data which could not be decoded. TRBE doesn't support
>>>> + * formatting the trace data, unlike the legacy CoreSight
>>>> + * sinks and thus we use ETE trace packets to pad the
>>>> + * sections of the buffer.
>>>> + */
>>>> +#define ETE_IGNORE_PACKET           0x70
>>>> +
>>>> +/*
>>>> + * Minimum amount of meaningful trace will contain:
>>>> + * A-Sync, Trace Info, Trace On, Address, Atom.
>>>> + * This is about 44bytes of ETE trace. To be on
>>>> + * the safer side, we assume 64bytes is the minimum
>>>> + * space required for a meaningful session, before
>>>> + * we hit a "WRAP" event.
>>>> + */
>>>> +#define TRBE_TRACE_MIN_BUF_SIZE             64
>>>> +
>>>> +enum trbe_fault_action {
>>>> +    TRBE_FAULT_ACT_WRAP,
>>>> +    TRBE_FAULT_ACT_SPURIOUS,
>>>> +    TRBE_FAULT_ACT_FATAL,
>>>> +};
>>>> +
>>>> +struct trbe_buf {
>>>> +    unsigned long trbe_base;
>>>> +    unsigned long trbe_limit;
>>>> +    unsigned long trbe_write;
>>>> +    int nr_pages;
>>>> +    void **pages;
>>>> +    bool snapshot;
>>>> +    struct trbe_cpudata *cpudata;
>>>> +};
>>>> +
>>>> +struct trbe_cpudata {
>>>> +    bool trbe_dbm;
>>>> +    u64 trbe_align;
>>>> +    int cpu;
>>>> +    enum cs_mode mode;
>>>> +    struct trbe_buf *buf;
>>>> +    struct trbe_drvdata *drvdata;
>>>> +};
>>>> +
>>>> +struct trbe_drvdata {
>>>> +    struct trbe_cpudata __percpu *cpudata;
>>>> +    struct perf_output_handle __percpu **handle;
>>>> +    struct hlist_node hotplug_node;
>>>> +    int irq;
>>>> +    cpumask_t supported_cpus;
>>>> +    enum cpuhp_state trbe_online;
>>>> +    struct platform_device *pdev;
>>>> +};
>>>> +
>>>> +static int trbe_alloc_node(struct perf_event *event)
>>>> +{
>>>> +    if (event->cpu == -1)
>>>> +            return NUMA_NO_NODE;
>>>> +    return cpu_to_node(event->cpu);
>>>> +}
>>>> +
>>>> +static void trbe_drain_buffer(void)
>>>> +{
>>>> +    asm(TSB_CSYNC);
>>>> +    dsb(nsh);
>>>> +}
>>>> +
>>>> +static void trbe_drain_and_disable_local(void)
>>>> +{
>>>> +    trbe_drain_buffer();
>>>> +    write_sysreg_s(0, SYS_TRBLIMITR_EL1);
>>>> +    isb();
>>>> +}
>>>> +
>>>> +static void trbe_reset_local(void)
>>>> +{
>>>> +    trbe_drain_and_disable_local();
>>>> +    write_sysreg_s(0, SYS_TRBPTR_EL1);
>>>> +    write_sysreg_s(0, SYS_TRBBASER_EL1);
>>>> +    write_sysreg_s(0, SYS_TRBSR_EL1);
>>>> +}
>>>> +
>>>> +static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +
>>>> +    /*
>>>> +     * We cannot proceed with the buffer collection and we
>>>> +     * do not have any data for the current session. The
>>>> +     * etm_perf driver expects to close out the aux_buffer
>>>> +     * at event_stop(). So disable the TRBE here and leave
>>>> +     * the update_buffer() to return a 0 size.
>>>> +     */
>>>> +    trbe_drain_and_disable_local();
>>>> +    perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>>>> +    *this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
>>>> +}
>>>> +
>>>> +/*
>>>> + * TRBE Buffer Management
>>>> + *
>>>> + * The TRBE buffer spans from the base pointer till the limit pointer. When enabled,
>>>> + * it starts writing trace data from the write pointer onward till the limit pointer.
>>>> + * When the write pointer reaches the address just before the limit pointer, it gets
>>>> + * wrapped around again to the base pointer. This is called a TRBE wrap event, which
>>>> + * generates a maintenance interrupt when operated in WRAP or FILL mode. This driver
>>>> + * uses FILL mode, where the TRBE stops the trace collection at wrap event. The IRQ
>>>> + * handler updates the AUX buffer and re-enables the TRBE with updated WRITE and
>>>> + * LIMIT pointers.
>>>> + *
>>>> + *  Wrap around with an IRQ
>>>> + *  ------ < ------ < ------- < ----- < -----
>>>> + *  |                                       |
>>>> + *  ------ > ------ > ------- > ----- > -----
>>>> + *
>>>> + *  +---------------+-----------------------+
>>>> + *  |               |                       |
>>>> + *  +---------------+-----------------------+
>>>> + *  Base Pointer    Write Pointer           Limit Pointer
>>>> + *
>>>> + * The base and limit pointers always needs to be PAGE_SIZE aligned. But the write
>>>> + * pointer can be aligned to the implementation defined TRBE trace buffer alignment
>>>> + * as captured in trbe_cpudata->trbe_align.
>>>> + *
>>>> + *
>>>> + *          head            tail            wakeup
>>>> + *  +---------------------------------------+----- ~ ~ ------
>>>> + *  |$$$$$$$|################|$$$$$$$$$$$$$$|               |
>>>> + *  +---------------------------------------+----- ~ ~ ------
>>>> + *  Base Pointer    Write Pointer           Limit Pointer
>>>> + *
>>>> + * The perf_output_handle indices (head, tail, wakeup) are monotonically increasing
>>>> + * values which tracks all the driver writes and user reads from the perf auxiliary
>>>> + * buffer. Generally [head..tail] is the area where the driver can write into unless
>>>> + * the wakeup is behind the tail. Enabled TRBE buffer span needs to be adjusted and
>>>> + * configured depending on the perf_output_handle indices, so that the driver does
>>>> + * not override into areas in the perf auxiliary buffer which is being or yet to be
>>>> + * consumed from the user space. The enabled TRBE buffer area is a moving subset of
>>>> + * the allocated perf auxiliary buffer.
>>>> + */
>>>> +static void trbe_pad_buf(struct perf_output_handle *handle, int len)
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +    u64 head = PERF_IDX2OFF(handle->head, buf);
>>>> +
>>>> +    memset((void *)buf->trbe_base + head, ETE_IGNORE_PACKET, len);
>>>> +    if (!buf->snapshot)
>>>> +            perf_aux_output_skip(handle, len);
>>>> +}
>>>> +
>>>> +static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +
>>>> +    /*
>>>> +     * The ETE trace has alignment synchronization packets allowing
>>>> +     * the decoder to reset in case of an overflow or corruption.
>>>> +     * So we can use the entire buffer for the snapshot mode.
>>>> +     */
>>>> +    return buf->nr_pages * PAGE_SIZE;
>>>> +}
>>>> +
>>>> +/*
>>>> + * TRBE Limit Calculation
>>>> + *
>>>> + * The following markers are used to illustrate various TRBE buffer situations.
>>>> + *
>>>> + * $$$$ - Data area, unconsumed captured trace data, not to be overridden
>>>> + * #### - Free area, enabled, trace will be written
>>>> + * %%%% - Free area, disabled, trace will not be written
>>>> + * ==== - Free area, padded with ETE_IGNORE_PACKET, trace will be skipped
>>>> + */
>>>> +static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +    struct trbe_cpudata *cpudata = buf->cpudata;
>>>> +    const u64 bufsize = buf->nr_pages * PAGE_SIZE;
>>>> +    u64 limit = bufsize;
>>>> +    u64 head, tail, wakeup;
>>>> +
>>>> +    head = PERF_IDX2OFF(handle->head, buf);
>>>> +
>>>> +    /*
>>>> +     *              head
>>>> +     *      ------->|
>>>> +     *      |
>>>> +     *      head    TRBE align      tail
>>>> +     * +----|-------|---------------|-------+
>>>> +     * |$$$$|=======|###############|$$$$$$$|
>>>> +     * +----|-------|---------------|-------+
>>>> +     * trbe_base                            trbe_base + nr_pages
>>>> +     *
>>>> +     * Perf aux buffer output head position can be misaligned depending on
>>>> +     * various factors including user space reads. In case misaligned, head
>>>> +     * needs to be aligned before TRBE can be configured. Pad the alignment
>>>> +     * gap with ETE_IGNORE_PACKET bytes that will be ignored by user tools
>>>> +     * and skip this section thus advancing the head.
>>>> +     */
>>>> +    if (!IS_ALIGNED(head, cpudata->trbe_align)) {
>>>> +            unsigned long delta = roundup(head, cpudata->trbe_align) - head;
>>>> +
>>>> +            delta = min(delta, handle->size);
>>>> +            trbe_pad_buf(handle, delta);
>>>> +            head = PERF_IDX2OFF(handle->head, buf);
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     *      head = tail (size = 0)
>>>> +     * +----|-------------------------------+
>>>> +     * |$$$$|$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ |
>>>> +     * +----|-------------------------------+
>>>> +     * trbe_base                            trbe_base + nr_pages
>>>> +     *
>>>> +     * Perf aux buffer does not have any space for the driver to write into.
>>>> +     * Just communicate trace truncation event to the user space by marking
>>>> +     * it with PERF_AUX_FLAG_TRUNCATED.
>>>> +     */
>>>> +    if (!handle->size) {
>>>> +            perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>>>> +            return 0;
>>>> +    }
>>>> +
>>>> +    /* Compute the tail and wakeup indices now that we've aligned head */
>>>> +    tail = PERF_IDX2OFF(handle->head + handle->size, buf);
>>>> +    wakeup = PERF_IDX2OFF(handle->wakeup, buf);
>>>> +
>>>> +    /*
>>>> +     * Lets calculate the buffer area which TRBE could write into. There
>>>> +     * are three possible scenarios here. Limit needs to be aligned with
>>>> +     * PAGE_SIZE per the TRBE requirement. Always avoid clobbering the
>>>> +     * unconsumed data.
>>>> +     *
>>>> +     * 1) head < tail
>>>> +     *
>>>> +     *      head                    tail
>>>> +     * +----|-----------------------|-------+
>>>> +     * |$$$$|#######################|$$$$$$$|
>>>> +     * +----|-----------------------|-------+
>>>> +     * trbe_base                    limit   trbe_base + nr_pages
>>>> +     *
>>>> +     * TRBE could write into [head..tail] area. Unless the tail is right at
>>>> +     * the end of the buffer, neither an wrap around nor an IRQ is expected
>>>> +     * while being enabled.
>>>> +     *
>>>> +     * 2) head == tail
>>>> +     *
>>>> +     *      head = tail (size > 0)
>>>> +     * +----|-------------------------------+
>>>> +     * |%%%%|###############################|
>>>> +     * +----|-------------------------------+
>>>> +     * trbe_base                            limit = trbe_base + nr_pages
>>>> +     *
>>>> +     * TRBE should just write into [head..base + nr_pages] area even though
>>>> +     * the entire buffer is empty. Reason being, when the trace reaches the
>>>> +     * end of the buffer, it will just wrap around with an IRQ giving an
>>>> +     * opportunity to reconfigure the buffer.
>>>> +     *
>>>> +     * 3) tail < head
>>>> +     *
>>>> +     *      tail                    head
>>>> +     * +----|-----------------------|-------+
>>>> +     * |%%%%|$$$$$$$$$$$$$$$$$$$$$$$|#######|
>>>> +     * +----|-----------------------|-------+
>>>> +     * trbe_base                            limit = trbe_base + nr_pages
>>>> +     *
>>>> +     * TRBE should just write into [head..base + nr_pages] area even though
>>>> +     * the [trbe_base..tail] is also empty. Reason being, when the trace
>>>> +     * reaches the end of the buffer, it will just wrap around with an IRQ
>>>> +     * giving an opportunity to reconfigure the buffer.
>>>> +     */
>>>> +    if (head < tail)
>>>> +            limit = round_down(tail, PAGE_SIZE);
>>>> +
>>>> +    /*
>>>> +     * Wakeup may be arbitrarily far into the future. If it's not in the
>>>> +     * current generation, either we'll wrap before hitting it, or it's
>>>> +     * in the past and has been handled already.
>>>> +     *
>>>> +     * If there's a wakeup before we wrap, arrange to be woken up by the
>>>> +     * page boundary following it. Keep the tail boundary if that's lower.
>>>> +     *
>>>> +     *      head            wakeup  tail
>>>> +     * +----|---------------|-------|-------+
>>>> +     * |$$$$|###############|%%%%%%%|$$$$$$$|
>>>> +     * +----|---------------|-------|-------+
>>>> +     * trbe_base            limit           trbe_base + nr_pages
>>>> +     */
>>>> +    if (handle->wakeup < (handle->head + handle->size) && head <= wakeup)
>>>> +            limit = min(limit, round_up(wakeup, PAGE_SIZE));
>>>> +
>>>> +    /*
>>>> +     * There are two situation when this can happen i.e limit is before
>>>> +     * the head and hence TRBE cannot be configured.
>>>> +     *
>>>> +     * 1) head < tail (aligned down with PAGE_SIZE) and also they are both
>>>> +     * within the same PAGE size range.
>>>> +     *
>>>> +     *                      PAGE_SIZE
>>>> +     *              |----------------------|
>>>> +     *
>>>> +     *              limit   head    tail
>>>> +     * +------------|------|--------|-------+
>>>> +     * |$$$$$$$$$$$$$$$$$$$|========|$$$$$$$|
>>>> +     * +------------|------|--------|-------+
>>>> +     * trbe_base                            trbe_base + nr_pages
>>>> +     *
>>>> +     * 2) head < wakeup (aligned up with PAGE_SIZE) < tail and also both
>>>> +     * head and wakeup are within same PAGE size range.
>>>> +     *
>>>> +     *              PAGE_SIZE
>>>> +     *      |----------------------|
>>>> +     *
>>>> +     *      limit   head    wakeup  tail
>>>> +     * +----|------|-------|--------|-------+
>>>> +     * |$$$$$$$$$$$|=======|========|$$$$$$$|
>>>> +     * +----|------|-------|--------|-------+
>>>> +     * trbe_base                            trbe_base + nr_pages
>>>> +     */
>>>> +    if (limit > head)
>>>> +            return limit;
>>>> +
>>>> +    trbe_pad_buf(handle, handle->size);
>>>> +    perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct trbe_buf *buf = perf_get_aux(handle);
>>>> +    u64 limit = __trbe_normal_offset(handle);
>>>> +    u64 head = PERF_IDX2OFF(handle->head, buf);
>>>> +
>>>> +    /*
>>>> +     * If the head is too close to the limit and we don't
>>>> +     * have space for a meaningful run, we rather pad it
>>>> +     * and start fresh.
>>>> +     */
>>>> +    if (limit && (limit - head < TRBE_TRACE_MIN_BUF_SIZE)) {
>>>> +            trbe_pad_buf(handle, limit - head);
>>>> +            limit = __trbe_normal_offset(handle);
>>>> +    }
>>>> +    return limit;
>>>> +}
>>>> +
>>>> +static unsigned long compute_trbe_buffer_limit(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +    unsigned long offset;
>>>> +
>>>> +    if (buf->snapshot)
>>>> +            offset = trbe_snapshot_offset(handle);
>>>> +    else
>>>> +            offset = trbe_normal_offset(handle);
>>>> +    return buf->trbe_base + offset;
>>>> +}
>>>
>>> I won't review the trace buffer management functions in this revision, I will
>>> leave that for the next version.
>>
>> Okay.
>>
>>>
>>>> +
>>>> +static void clr_trbe_status(void)
>>>> +{
>>>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>>>> +
>>>> +    WARN_ON(is_trbe_enabled());
>>>> +    trbsr &= ~TRBSR_IRQ;
>>>> +    trbsr &= ~TRBSR_TRG;
>>>> +    trbsr &= ~TRBSR_WRAP;
>>>> +    trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
>>>> +    trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
>>>> +    trbsr &= ~TRBSR_STOP;
>>>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>>>> +}
>>>
>>> I haven't read the TRBE progammer's manual but looking a the documentation the above
>>> looks good.
>>>
>>>> +
>>>> +static void set_trbe_limit_pointer_enabled(unsigned long addr)
>>>> +{
>>>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>>>> +
>>>> +    WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
>>>> +    WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
>>>> +
>>>> +    trblimitr &= ~TRBLIMITR_NVM;
>>>> +    trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
>>>> +    trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
>>>> +    trblimitr &= ~(TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
>>>> +
>>>> +    /*
>>>> +     * Fill trace buffer mode is used here while configuring the
>>>> +     * TRBE for trace capture. In this particular mode, the trace
>>>> +     * collection is stopped and a maintenance interrupt is raised
>>>> +     * when the current write pointer wraps. This pause in trace
>>>> +     * collection gives the software an opportunity to capture the
>>>> +     * trace data in the interrupt handler, before reconfiguring
>>>> +     * the TRBE.
>>>> +     */
>>>> +    trblimitr |= (TRBE_FILL_MODE_FILL & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT;
>>>> +
>>>> +    /*
>>>> +     * Trigger mode is not used here while configuring the TRBE for
>>>> +     * the trace capture. Hence just keep this in the ignore mode.
>>>> +     */
>>>> +    trblimitr |= (TRBE_TRIG_MODE_IGNORE & TRBLIMITR_TRIG_MODE_MASK) << TRBLIMITR_TRIG_MODE_SHIFT;
>>>> +    trblimitr |= (addr & PAGE_MASK);
>>>> +
>>>> +    trblimitr |= TRBLIMITR_ENABLE;
>>>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>>>> +}
>>>
>>> Same here
>>>
>>>> +
>>>> +static void trbe_enable_hw(struct trbe_buf *buf)
>>>> +{
>>>> +    WARN_ON(buf->trbe_write < buf->trbe_base);
>>>> +    WARN_ON(buf->trbe_write >= buf->trbe_limit);
>>>> +    set_trbe_disabled();
>>>> +    isb();
>>>> +    clr_trbe_status();
>>>> +    set_trbe_base_pointer(buf->trbe_base);
>>>> +    set_trbe_write_pointer(buf->trbe_write);
>>>> +
>>>> +    /*
>>>> +     * Synchronize all the register updates
>>>> +     * till now before enabling the TRBE.
>>>> +     */
>>>> +    isb();
>>>> +    set_trbe_limit_pointer_enabled(buf->trbe_limit);
>>>> +
>>>> +    /* Synchronize the TRBE enable event */
>>>> +    isb();
>>>> +}
>>>
>>> Ok
>>>
>>>> +
>>>> +static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>>>> +                               struct perf_event *event, void **pages,
>>>> +                               int nr_pages, bool snapshot)
>>>> +{
>>>> +    struct trbe_buf *buf;
>>>> +    struct page **pglist;
>>>> +    int i;
>>>> +
>>>> +    /*
>>>> +     * TRBE LIMIT and TRBE WRITE pointers must be page aligned. But with
>>>> +     * just a single page, there is not much room left while writing into
>>>> +     * a partially filled TRBE buffer. Hence restrict the minimum buffer
>>>> +     * size as two pages.
>>>> +     */
>>>> +    if (nr_pages < 2)
>>>> +            return NULL;
>>>> +
>>>> +    buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
>>>> +    if (IS_ERR(buf))
>>>> +            return ERR_PTR(-ENOMEM);
>>>
>>> You know what do to.
>>
>> Right, will check for NULL instead and return ERR_PTR(-ENOMEM) as
>> the function return type is (void *).
>>
>>>
>>>> +
>>>> +    pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
>>>> +    if (IS_ERR(pglist)) {
>>>> +            kfree(buf);
>>>> +            return ERR_PTR(-ENOMEM);
>>>> +    }
>>>
>>> Here too.
>>
>> Yes, changed.
>>
>>>
>>>> +
>>>> +    for (i = 0; i < nr_pages; i++)
>>>> +            pglist[i] = virt_to_page(pages[i]);
>>>> +
>>>> +    buf->trbe_base = (unsigned long) vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>>>> +    if (IS_ERR((void *)buf->trbe_base)) {
>>>> +            kfree(pglist);
>>>> +            kfree(buf);
>>>> +            return ERR_PTR(buf->trbe_base);
>>>> +    }
>>>
>>> Here too.
>>
>> Yes, changed.
>>
>>>
>>>> +    buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
>>>> +    buf->trbe_write = buf->trbe_base;
>>>> +    buf->snapshot = snapshot;
>>>> +    buf->nr_pages = nr_pages;
>>>> +    buf->pages = pages;
>>>> +    kfree(pglist);
>>>> +    return buf;
>>>> +}
>>>> +
>>>> +void arm_trbe_free_buffer(void *config)
>>
>> Added the missing 'static' here.
>>
>>>> +{
>>>> +    struct trbe_buf *buf = config;
>>>> +
>>>> +    vunmap((void *)buf->trbe_base);
>>>> +    kfree(buf);
>>>> +}
>>>
>>> Ok
>>>
>>>> +
>>>> +static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>>>> +                                        struct perf_output_handle *handle,
>>>> +                                        void *config)
>>>> +{
>>>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>>>> +    struct trbe_buf *buf = config;
>>>> +    unsigned long size, offset;
>>>> +
>>>> +    WARN_ON(buf->cpudata != cpudata);
>>>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>>>> +    WARN_ON(cpudata->drvdata != drvdata);
>>>> +    if (cpudata->mode != CS_MODE_PERF)
>>>> +            return -EINVAL;
>>>> +
>>>> +    /*
>>>> +     * If the TRBE was disabled due to lack of space in the AUX buffer or a
>>>> +     * spurious fault, the driver leaves it disabled, truncating the buffer.
>>>> +     * Since the etm_perf driver expects to close out the AUX buffer, the
>>>> +     * driver skips it. Thus, just pass in 0 size here to indicate that the
>>>> +     * buffer was truncated.
>>>> +     */
>>>> +    if (!is_trbe_enabled())
>>>> +            return 0;
>>>> +    /*
>>>> +     * perf handle structure needs to be shared with the TRBE IRQ handler for
>>>> +     * capturing trace data and restarting the handle. There is a probability
>>>> +     * of an undefined reference based crash when etm event is being stopped
>>>> +     * while a TRBE IRQ also getting processed. This happens due the release
>>>> +     * of perf handle via perf_aux_output_end() in etm_event_stop(). Stopping
>>>> +     * the TRBE here will ensure that no IRQ could be generated when the perf
>>>> +     * handle gets freed in etm_event_stop().
>>>> +     */
>>>> +    trbe_drain_and_disable_local();
>>>> +    offset = get_trbe_write_pointer() - get_trbe_base_pointer();
>>>> +    size = offset - PERF_IDX2OFF(handle->head, buf);
>>>> +    if (buf->snapshot)
>>>> +            handle->head += size;
>>>> +    return size;
>>>> +}
>>>
>>> Ok - I really appreciate the comments.
>>>
>>>> +
>>>> +static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
>>>> +{
>>>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>>>> +    struct perf_output_handle *handle = data;
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +
>>>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>>>> +    WARN_ON(cpudata->drvdata != drvdata);
>>>> +    if (mode != CS_MODE_PERF)
>>>> +            return -EINVAL;
>>>> +
>>>> +    *this_cpu_ptr(drvdata->handle) = handle;
>>>> +    cpudata->buf = buf;
>>>> +    cpudata->mode = mode;
>>>> +    buf->cpudata = cpudata;
>>>> +    buf->trbe_limit = compute_trbe_buffer_limit(handle);
>>>> +    buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>>>> +    if (buf->trbe_limit == buf->trbe_base) {
>>>> +            trbe_stop_and_truncate_event(handle);
>>>> +            return 0;
>>>> +    }
>>>> +    trbe_enable_hw(buf);
>>>> +    return 0;
>>>> +}
>>>
>>> Ok
>>>
>>>> +
>>>> +static int arm_trbe_disable(struct coresight_device *csdev)
>>>> +{
>>>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>>>> +    struct trbe_buf *buf = cpudata->buf;
>>>> +
>>>> +    WARN_ON(buf->cpudata != cpudata);
>>>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>>>> +    WARN_ON(cpudata->drvdata != drvdata);
>>>> +    if (cpudata->mode != CS_MODE_PERF)
>>>> +            return -EINVAL;
>>>> +
>>>> +    trbe_drain_and_disable_local();
>>>> +    buf->cpudata = NULL;
>>>> +    cpudata->buf = NULL;
>>>> +    cpudata->mode = CS_MODE_DISABLED;
>>>> +    return 0;
>>>> +}
>>>
>>> Ok
>>>
>>>> +
>>>> +static void trbe_handle_spurious(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +
>>>> +    buf->trbe_limit = compute_trbe_buffer_limit(handle);
>>>> +    buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>>>> +    if (buf->trbe_limit == buf->trbe_base) {
>>>> +            trbe_drain_and_disable_local();
>>>> +            return;
>>>> +    }
>>>> +    trbe_enable_hw(buf);
>>>> +}
>>>> +
>>>> +static void trbe_handle_overflow(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct perf_event *event = handle->event;
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +    unsigned long offset, size;
>>>> +    struct etm_event_data *event_data;
>>>> +
>>>> +    offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
>>>> +    size = offset - PERF_IDX2OFF(handle->head, buf);
>>>> +    if (buf->snapshot)
>>>> +            handle->head = offset;
>>>> +    perf_aux_output_end(handle, size);
>>>> +
>>>> +    event_data = perf_aux_output_begin(handle, event);
>>>> +    if (!event_data) {
>>>> +            trbe_drain_and_disable_local();
>>>> +            *this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
>>>> +            return;
>>>> +    }
>>>> +    buf->trbe_limit = compute_trbe_buffer_limit(handle);
>>>> +    buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>>>> +    if (buf->trbe_limit == buf->trbe_base) {
>>>> +            trbe_stop_and_truncate_event(handle);
>>>> +            return;
>>>> +    }
>>>> +    *this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
>>>> +    trbe_enable_hw(buf);
>>>> +}
>>>> +
>>>> +static bool is_perf_trbe(struct perf_output_handle *handle)
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +    struct trbe_cpudata *cpudata = buf->cpudata;
>>>> +    struct trbe_drvdata *drvdata = cpudata->drvdata;
>>>> +    int cpu = smp_processor_id();
>>>> +
>>>> +    WARN_ON(buf->trbe_base != get_trbe_base_pointer());
>>>> +    WARN_ON(buf->trbe_limit != get_trbe_limit_pointer());
>>>> +
>>>> +    if (cpudata->mode != CS_MODE_PERF)
>>>> +            return false;
>>>> +
>>>> +    if (cpudata->cpu != cpu)
>>>> +            return false;
>>>> +
>>>> +    if (!cpumask_test_cpu(cpu, &drvdata->supported_cpus))
>>>> +            return false;
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle)
>>>
>>> @handle isn't used for anything.
>>
>> Okay, will drop.
>>
>>>
>>>> +{
>>>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>>>> +    int ec = get_trbe_ec(trbsr);
>>>> +    int bsc = get_trbe_bsc(trbsr);
>>>> +
>>>> +    WARN_ON(is_trbe_running(trbsr));
>>>> +    if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
>>>> +            return TRBE_FAULT_ACT_FATAL;
>>>> +
>>>> +    if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
>>>> +            return TRBE_FAULT_ACT_FATAL;
>>>> +
>>>> +    if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
>>>> +            if (get_trbe_write_pointer() == get_trbe_base_pointer())
>>>> +                    return TRBE_FAULT_ACT_WRAP;
>>>> +    }
>>>> +    return TRBE_FAULT_ACT_SPURIOUS;
>>>> +}
>>>> +
>>>> +static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>>>> +{
>>>> +    struct perf_output_handle **handle_ptr = dev;
>>>> +    struct perf_output_handle *handle = *handle_ptr;
>>>> +    enum trbe_fault_action act;
>>>> +
>>>> +    WARN_ON(!is_trbe_irq(read_sysreg_s(SYS_TRBSR_EL1)));
>>>> +    clr_trbe_irq();
>>>> +
>>>> +    /*
>>>> +     * Ensure the trace is visible to the CPUs and
>>>> +     * any external aborts have been resolved.
>>>> +     */
>>>> +    trbe_drain_buffer();
>>>> +    isb();
>>>> +
>>>> +    if (!perf_get_aux(handle))
>>>> +            return IRQ_NONE;
>>>> +
>>>> +    if (!is_perf_trbe(handle))
>>>> +            return IRQ_NONE;
>>>> +
>>>> +    irq_work_run();
>>>
>>> I trust Will that this is the right thing to do.
>>>
>>> I will stop here for this revision.  I will dive more in the mechanic of the
>>> TRBE on the next revision.
>>
>> Okay, will collate all the changes till now and respin sooner.
>>
>> - Anshuman
> 
> 
> 

