Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB74341A10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCSKbF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Mar 2021 06:31:05 -0400
Received: from foss.arm.com ([217.140.110.172]:44456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhCSKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:30:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81974ED1;
        Fri, 19 Mar 2021 03:30:40 -0700 (PDT)
Received: from [10.57.52.33] (unknown [10.57.52.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AAFA3F70D;
        Fri, 19 Mar 2021 03:30:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v4 18/19] coresight: sink: Add TRBE driver
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VhHP3_mRWQujVPxcguF4W17tNhogGqAFj6MF2nJ+Y==Fw@mail.gmail.com>
Date:   Fri, 19 Mar 2021 10:30:37 +0000
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <5685C840-7F03-4A53-9183-D5771308F5B8@arm.com>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-19-suzuki.poulose@arm.com>
 <CAJ9a7VhHP3_mRWQujVPxcguF4W17tNhogGqAFj6MF2nJ+Y==Fw@mail.gmail.com>
To:     Mike Leach <mike.leach@linaro.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

> On 8 Mar 2021, at 17:26, Mike Leach <mike.leach@linaro.org> wrote:
> 
> Hi Suzuki,
> 
> On Thu, 25 Feb 2021 at 19:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> 
>> From: Anshuman Khandual <anshuman.khandual@arm.com>
>> 
>> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
>> accessible via the system registers. The TRBE supports different addressing
>> modes including CPU virtual address and buffer modes including the circular
>> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
>> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
>> access to the trace buffer could be prohibited by a higher exception level
>> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
>> private interrupt (PPI) on address translation errors and when the buffer
>> is full. Overall implementation here is inspired from the Arm SPE driver.
>> 
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> 
>> +
>> +static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>> +                                           struct perf_output_handle *handle,
>> +                                           void *config)
>> +{
>> +       struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +       struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>> +       struct trbe_buf *buf = config;
>> +       enum trbe_fault_action act;
>> +       unsigned long size, offset;
>> +       unsigned long write, base, status;
>> +       unsigned long flags;
>> +
>> +       WARN_ON(buf->cpudata != cpudata);
>> +       WARN_ON(cpudata->cpu != smp_processor_id());
>> +       WARN_ON(cpudata->drvdata != drvdata);
>> +       if (cpudata->mode != CS_MODE_PERF)
>> +               return 0;
>> +
>> +       perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>> +
>> +       /*
>> +        * We are about to disable the TRBE. And this could in turn
>> +        * fill up the buffer triggering, an IRQ. This could be consumed
>> +        * by the PE asynchronously, causing a race here against
>> +        * the IRQ handler in closing out the handle. So, let us
>> +        * make sure the IRQ can't trigger while we are collecting
>> +        * the buffer. We also make sure that a WRAP event is handled
>> +        * accordingly.
>> +        */
>> +       local_irq_save(flags);
>> +
>> +       /*
>> +        * If the TRBE was disabled due to lack of space in the AUX buffer or a
>> +        * spurious fault, the driver leaves it disabled, truncating the buffer.
>> +        * Since the etm_perf driver expects to close out the AUX buffer, the
>> +        * driver skips it. Thus, just pass in 0 size here to indicate that the
>> +        * buffer was truncated.
>> +        */
>> +       if (!is_trbe_enabled()) {
>> +               size = 0;
>> +               goto done;
>> +       }
>> +       /*
>> +        * perf handle structure needs to be shared with the TRBE IRQ handler for
>> +        * capturing trace data and restarting the handle. There is a probability
>> +        * of an undefined reference based crash when etm event is being stopped
>> +        * while a TRBE IRQ also getting processed. This happens due the release
>> +        * of perf handle via perf_aux_output_end() in etm_event_stop(). Stopping
>> +        * the TRBE here will ensure that no IRQ could be generated when the perf
>> +        * handle gets freed in etm_event_stop().
>> +        */
>> +       trbe_drain_and_disable_local();
>> +       write = get_trbe_write_pointer();
>> +       base = get_trbe_base_pointer();
>> +
>> +       /* Check if there is a pending interrupt and handle it here */
>> +       status = read_sysreg_s(SYS_TRBSR_EL1);
>> +       if (is_trbe_irq(status)) {
>> +
>> +               /*
>> +                * Now that we are handling the IRQ here, clear the IRQ
>> +                * from the status, to let the irq handler know that it
>> +                * is taken care of.
>> +                */
>> +               clr_trbe_irq();
>> +               isb();
>> +
>> +               act = trbe_get_fault_act(status);
>> +               /*
>> +                * If this was not due to a WRAP event, we have some
>> +                * errors and as such buffer is empty.
>> +                */
>> +               if (act != TRBE_FAULT_ACT_WRAP) {
>> +                       size = 0;
>> +                       goto done;
>> +               }
> 
> We are using TRBE FILL mode - which halts capture on a full buffer and
> triggers the IRQ, without disabling the source first.
> This means that the mode is inherently lossy (unless by some unlikely
> co-incidence the last byte that caused the wrap was also the last byte
> to be sent from an ETE that was in the process of being disabled.)
> Therefore we must have a perf_aux_output_flag(handle,
> PERF_AUX_FLAG_TRUNCATED) call in here to signal that some trace was
> lost, for consistence of operation with ETR etc, and intelpt.
> 

I agree that the there is a bit of loss here due to the FILL mode. But it is not  comparable to that of the ETR. In this case, the WRAP event is triggered when we flush the ETE. i.e, this could be mostly due to the fact that the tracing was enabled for the kernel mode and the last few bytes of trace which caused the FILL belong to the code responsible for stopping the components in the CoreSight trace. I personally do not think this data is of any interest to the user.
Otherwise, if the data didn’t belong to the perf event side, it should have triggered the IRQ.

This is true in case of the buffer overflow interrupt too, with a bit more data lost. i.e, since the interrupt is PPI, the overflow is triggered when the buffer is full (which includes the data that is cached in the TRBE). But there could be a bit of data that is still cached in the ETE, before it is captured in the trace. And the moment we get a FILL event, we stop executing anything that is relevant for the Trace session (as we are in the driver handling the interrupt).
And then we reconfigure the buffer to continue the execution. Now, the interrupt delivery is not necessarily synchronous and there could be data lost in the interval between WRAP event and the IRQ is triggered.

I am OK with suggesting that there was some loss of trace data during the session, if we hit WRAP event. But this could cause worry to the consumers that they lost too much of trace data of their interest, while that is not the case.

>> +static inline unsigned long get_trbe_limit_pointer(void)
>> +{
>> +       u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +       unsigned long limit = (trblimitr >> TRBLIMITR_LIMIT_SHIFT) & TRBLIMITR_LIMIT_MASK;
>> +       unsigned long addr = limit << TRBLIMITR_LIMIT_SHIFT;
> 
> Could this not be:
> unsigned long addr = trblimitr & (TRBLIMITR_LIMIT_MASK <<
> TRBLIMITR_LIMIT_SHIFT);
> like the base ponter below?
> 

Sure, it can be consistent.


>> +
>> +       WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
>> +       return addr;
>> +}
>> +
>> +static inline unsigned long get_trbe_base_pointer(void)
>> +{
>> +       u64 trbbaser = read_sysreg_s(SYS_TRBBASER_EL1);
>> +       unsigned long addr = trbbaser & (TRBBASER_BASE_MASK << TRBBASER_BASE_SHIFT);
>> +
>> +       WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
>> +       return addr;
>> +}
>> +

Thank you for the review

Kind regards
Suzuki

