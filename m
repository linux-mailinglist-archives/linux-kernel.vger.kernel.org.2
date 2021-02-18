Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E68631E524
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 05:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBREX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 23:23:58 -0500
Received: from foss.arm.com ([217.140.110.172]:44490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhBREXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 23:23:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 652501FB;
        Wed, 17 Feb 2021 20:23:04 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D223F694;
        Wed, 17 Feb 2021 20:23:01 -0800 (PST)
Subject: Re: [PATCH V3 00/14] arm64: coresight: Enable ETE and TRBE
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <20210201184436.GA1475392@xps15>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e1af8031-5ba6-b04a-6e55-8d8d0f0c07c1@arm.com>
Date:   Thu, 18 Feb 2021 09:53:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201184436.GA1475392@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 12:14 AM, Mathieu Poirier wrote:
> On Wed, Jan 27, 2021 at 02:25:24PM +0530, Anshuman Khandual wrote:
>> This series enables future IP trace features Embedded Trace Extension (ETE)
>> and Trace Buffer Extension (TRBE). This series depends on the ETM system
>> register instruction support series [0] which is available here [1]. This
>> series which applies on [1] is avaialble here [2] for quick access.
>>
>> ETE is the PE (CPU) trace unit for CPUs, implementing future architecture
>> extensions. ETE overlaps with the ETMv4 architecture, with additions to
>> support the newer architecture features and some restrictions on the
>> supported features w.r.t ETMv4. The ETE support is added by extending the
>> ETMv4 driver to recognise the ETE and handle the features as exposed by the
>> TRCIDRx registers. ETE only supports system instructions access from the
>> host CPU. The ETE could be integrated with a TRBE (see below), or with the
>> legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same firmware
>> description as the ETMs and requires a node per instance. 
>>
>> Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which is
>> accessible via the system registers and can be combined with the ETE to
>> provide a 1x1 configuration of source & sink. TRBE is being represented
>> here as a CoreSight sink. Primary reason is that the ETE source could work
>> with other traditional CoreSight sink devices. As TRBE captures the trace
>> data which is produced by ETE, it cannot work alone.
>>
>> TRBE representation here have some distinct deviations from a traditional
>> CoreSight sink device. Coresight path between ETE and TRBE are not built
>> during boot looking at respective DT or ACPI entries.
>>
>> Unlike traditional sinks, TRBE can generate interrupts to signal including
>> many other things, buffer got filled. The interrupt is a PPI and should be
>> communicated from the platform. DT or ACPI entry representing TRBE should
>> have the PPI number for a given platform. During perf session, the TRBE IRQ
>> handler should capture trace for perf auxiliary buffer before restarting it
>> back. System registers being used here to configure ETE and TRBE could be
>> referred in the link below.
>>
>> https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers.
> This set is giving me several checkpatch.pl warnings...  Those about complex
> macros and DT bindings are fine but everything else should have been addressed
> by now.  Since this is your first patchset I will carry on but I expect future
> submissions to be clean. 
> 

Hello Mathieu,

All the potential patches for upcoming V4 series applies cleanly but these are
some checkpatch.pl errors or warnings which could not be resolved.

- Anshuman

1. 0004-coresight-ete-Add-support-for-ETE-sysreg-access.patch
=============================================================

ERROR: Macros with complex values should be enclosed in parentheses
#88: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:165:
+#define ETE_ONLY_SYSREG_LIST(op, val)		\
+	CASE_##op((val), TRCRSR)		\
+	CASE_##op((val), TRCEXTINSELRn(1))	\
+	CASE_##op((val), TRCEXTINSELRn(2))	\
+	CASE_##op((val), TRCEXTINSELRn(3))

ERROR: Macros with complex values should be enclosed in parentheses
#97: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:172:
+#define ETM4x_ONLY_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPROCSELR)		\
+	CASE_##op((val), TRCVDCTLR)		\
+	CASE_##op((val), TRCVDSACCTLR)		\
+	CASE_##op((val), TRCVDARCCTLR)		\
+	CASE_##op((val), TRCOSLAR)

ERROR: Macros with complex values should be enclosed in parentheses
#104: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:179:
+#define ETM_COMMON_SYSREG_LIST(op, val)		\
+	CASE_##op((val), TRCPRGCTLR)		\
 	CASE_##op((val), TRCSTATR)		\
 	CASE_##op((val), TRCCONFIGR)		\
 	CASE_##op((val), TRCAUXCTLR)		\

ERROR: Macros with complex values should be enclosed in parentheses
#133: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:382:
+#define ETM4x_READ_SYSREG_CASES(res)		\
+	ETM_COMMON_SYSREG_LIST(READ, (res))	\
+	ETM4x_ONLY_SYSREG_LIST(READ, (res))

ERROR: Macros with complex values should be enclosed in parentheses
#137: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:386:
+#define ETM4x_WRITE_SYSREG_CASES(val)		\
+	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
+	ETM4x_ONLY_SYSREG_LIST(WRITE, (val))

ERROR: Macros with complex values should be enclosed in parentheses
#147: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:396:
+#define ETM4x_SYSREG_LIST_CASES			\
+	ETM_COMMON_SYSREG_LIST_CASES		\
+	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)

ERROR: Macros with complex values should be enclosed in parentheses
#155: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:403:
+#define ETE_READ_CASES(res)			\
+	ETM_COMMON_SYSREG_LIST(READ, (res))	\
+	ETE_ONLY_SYSREG_LIST(READ, (res))

ERROR: Macros with complex values should be enclosed in parentheses
#159: FILE: drivers/hwtracing/coresight/coresight-etm4x.h:407:
+#define ETE_WRITE_CASES(val)			\
+	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
+	ETE_ONLY_SYSREG_LIST(WRITE, (val))

total: 8 errors, 0 warnings, 133 lines checked

2. 0006-dts-bindings-Document-device-tree-bindings-for-ETE.patch
================================================================

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#23: 
new file mode 100644

total: 0 errors, 1 warnings, 74 lines checked


3. 0010-arm64-nvhe-Allow-TRBE-access-at-EL1.patch
=================================================

ERROR: spaces required around that ':' (ctx:VxE)
#49: FILE: arch/arm64/include/asm/el2_setup.h:93:
+1:
  ^

total: 1 errors, 0 warnings, 33 lines checked

4. 0011-coresight-sink-Add-TRBE-driver.patch
============================================

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#36: 
new file mode 100644

total: 0 errors, 1 warnings, 1322 lines checked


5. 0012-dts-bindings-Document-device-tree-bindings-for-Arm-T.patch
==================================================================

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#22: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

6. 0014-coresight-etm-perf-Add-support-for-trace-buffer-form.patch
================================================================== 

WARNING: line length of 103 exceeds 100 columns
#82: FILE: include/uapi/linux/perf_event.h:1115:
+#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT	0x0000 /* Default for backward compatibility */

total: 0 errors, 1 warnings, 24 lines checked
