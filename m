Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57893411F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhCSBKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:10:52 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36558 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhCSBKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:10:41 -0400
Received: by mail-lf1-f42.google.com with SMTP id n138so7486112lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0X4AR0FUqslo6/bd0K7Ngd+/gfgIYgdxYKc2e/VmGsw=;
        b=NFBZmb0SQiLCi4UJX4pXcrchoawSC+oOcDeOEfsM6DN/Jx3Sy2DOSXmmcKzaHuIdjg
         4iCMTIDl2g36O4GyC+kpCvLh8WMasMB1PjE0tDyxmOB1X69WeMIcisEX2Bku54Oxg+XK
         S+FBwIDCM7JH0+jXEQpqS4DPvlqTgxJG9KxSdNqGfs1rfbMiimyaOVRgghoC+JYUgzSZ
         JBfc3ts6eepIlM616H8AS+CHTkTf/8L0iPbXrhkpPKzpo4G37Z1IjgA87/7LymPhPuyz
         oyqkmLq+VAVKUNiqWsp3FzvoPWmeK8nEVOtS6NtjjRI9O+cqaKp3b66xGvU0cgWbGY0H
         SPKg==
X-Gm-Message-State: AOAM5327T9ZgeQmUMtC9QM235JbCkslhTcocQ+K9GfvVjPOpOTvqtT+m
        EUhgQokkRDTg4ZyF6zEGogM5cN/nfM/+sS3EV10=
X-Google-Smtp-Source: ABdhPJw7uYsruLtMTzqJMK3R7xGi7u9RfvpbvTkFqStre/SPtNF5lp6js5PTZV9gAf+FGU8F1B4nvh2OUiWQYhW5oAo=
X-Received: by 2002:a19:430e:: with SMTP id q14mr3954880lfa.374.1616116239896;
 Thu, 18 Mar 2021 18:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com> <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 19 Mar 2021 10:10:28 +0900
Message-ID: <CAM9d7ci9fpds3_EbgDp7heJGn-Xc_6NjR7KZ__GYBfaVLftdeg@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery tables
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Thu, Mar 18, 2021 at 3:05 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> A self-describing mechanism for the uncore PerfMon hardware has been
> introduced with the latest Intel platforms. By reading through an MMIO
> page worth of information, perf can 'discover' all the standard uncore
> PerfMon registers in a machine.
>
> The discovery mechanism relies on BIOS's support. With a proper BIOS,
> a PCI device with the unique capability ID 0x23 can be found on each
> die. Perf can retrieve the information of all available uncore PerfMons
> from the device via MMIO. The information is composed of one global
> discovery table and several unit discovery tables.
> - The global discovery table includes global uncore information of the
>   die, e.g., the address of the global control register, the offset of
>   the global status register, the number of uncore units, the offset of
>   unit discovery tables, etc.
> - The unit discovery table includes generic uncore unit information,
>   e.g., the access type, the counter width, the address of counters,
>   the address of the counter control, the unit ID, the unit type, etc.
>   The unit is also called "box" in the code.
> Perf can provide basic uncore support based on this information
> with the following patches.
>
> To locate the PCI device with the discovery tables, check the generic
> PCI ID first. If it doesn't match, go through the entire PCI device tree
> and locate the device with the unique capability ID.
>
> The uncore information is similar among dies. To save parsing time and
> space, only completely parse and store the discovery tables on the first
> die and the first box of each die. The parsed information is stored in
> an
> RB tree structure, intel_uncore_discovery_type. The size of the stored
> discovery tables varies among platforms. It's around 4KB for a Sapphire
> Rapids server.
>
> If a BIOS doesn't support the 'discovery' mechanism, the uncore driver
> will exit with -ENODEV. There is nothing changed.
>
> Add a module parameter to disable the discovery feature. If a BIOS gets
> the discovery tables wrong, users can have an option to disable the
> feature. For the current patchset, the uncore driver will exit with
> -ENODEV. In the future, it may fall back to the hardcode uncore driver
> on a known platform.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/Makefile           |   2 +-
>  arch/x86/events/intel/uncore.c           |  31 ++-
>  arch/x86/events/intel/uncore_discovery.c | 318 +++++++++++++++++++++++++++++++
>  arch/x86/events/intel/uncore_discovery.h | 105 ++++++++++
>  4 files changed, 448 insertions(+), 8 deletions(-)
>  create mode 100644 arch/x86/events/intel/uncore_discovery.c
>  create mode 100644 arch/x86/events/intel/uncore_discovery.h
>
> diff --git a/arch/x86/events/intel/Makefile b/arch/x86/events/intel/Makefile
> index e67a588..10bde6c 100644
> --- a/arch/x86/events/intel/Makefile
> +++ b/arch/x86/events/intel/Makefile
> @@ -3,6 +3,6 @@ obj-$(CONFIG_CPU_SUP_INTEL)             += core.o bts.o
>  obj-$(CONFIG_CPU_SUP_INTEL)            += ds.o knc.o
>  obj-$(CONFIG_CPU_SUP_INTEL)            += lbr.o p4.o p6.o pt.o
>  obj-$(CONFIG_PERF_EVENTS_INTEL_UNCORE) += intel-uncore.o
> -intel-uncore-objs                      := uncore.o uncore_nhmex.o uncore_snb.o uncore_snbep.o
> +intel-uncore-objs                      := uncore.o uncore_nhmex.o uncore_snb.o uncore_snbep.o uncore_discovery.o
>  obj-$(CONFIG_PERF_EVENTS_INTEL_CSTATE) += intel-cstate.o
>  intel-cstate-objs                      := cstate.o
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 33c8180..d111370 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -4,7 +4,12 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include "uncore.h"
> +#include "uncore_discovery.h"
>
> +static bool uncore_no_discover;
> +module_param(uncore_no_discover, bool, 0);

Wouldn't it be better to use a positive form like 'uncore_discover = true'?
To disable, the module param can be set to 'uncore_discover = false'.

> +MODULE_PARM_DESC(uncore_no_discover, "Don't enable the Intel uncore PerfMon discovery mechanism "
> +                                    "(default: enable the discovery mechanism).");
>  static struct intel_uncore_type *empty_uncore[] = { NULL, };
>  struct intel_uncore_type **uncore_msr_uncores = empty_uncore;
>  struct intel_uncore_type **uncore_pci_uncores = empty_uncore;

[SNIP]
> +enum uncore_access_type {
> +       UNCORE_ACCESS_MSR       = 0,
> +       UNCORE_ACCESS_MMIO,
> +       UNCORE_ACCESS_PCI,
> +
> +       UNCORE_ACCESS_MAX,
> +};
> +
> +struct uncore_global_discovery {
> +       union {
> +               u64     table1;
> +               struct {
> +                       u64     type : 8,
> +                               stride : 8,
> +                               max_units : 10,
> +                               __reserved_1 : 36,
> +                               access_type : 2;
> +               };
> +       };
> +
> +       u64     ctl;            /* Global Control Address */
> +
> +       union {
> +               u64     table3;
> +               struct {
> +                       u64     status_offset : 8,
> +                               num_status : 16,
> +                               __reserved_2 : 40;
> +               };
> +       };
> +};
> +
> +struct uncore_unit_discovery {
> +       union {
> +               u64     table1;
> +               struct {
> +                       u64     num_regs : 8,
> +                               ctl_offset : 8,
> +                               bit_width : 8,
> +                               ctr_offset : 8,
> +                               status_offset : 8,
> +                               __reserved_1 : 22,
> +                               access_type : 2;
> +                       };
> +               };
> +
> +       u64     ctl;            /* Unit Control Address */
> +
> +       union {
> +               u64     table3;
> +               struct {
> +                       u64     box_type : 16,
> +                               box_id : 16,
> +                               __reserved_2 : 32;
> +               };
> +       };
> +};
> +
> +struct intel_uncore_discovery_type {
> +       struct rb_node  node;
> +       enum uncore_access_type access_type;
> +       u64             box_ctrl;       /* Unit ctrl addr of the first box */
> +       u64             *box_ctrl_die;  /* Unit ctrl addr of the first box of each die */
> +       u16             type;           /* Type ID of the uncore block */
> +       u8              num_counters;
> +       u8              counter_width;
> +       u8              ctl_offset;     /* Counter Control 0 offset */
> +       u8              ctr_offset;     /* Counter 0 offset */

I find it confusing and easy to miss - ctl and ctr.  Some places you used
ctrl or counter.  Why not be consistent?  :)

Thanks,
Namhyung


> +       u16             num_boxes;      /* number of boxes for the uncore block */
> +       unsigned int    *ids;           /* Box IDs */
> +       unsigned int    *box_offset;    /* Box offset */
> +};
> +
> +bool intel_uncore_has_discovery_tables(void);
> +void intel_uncore_clear_discovery_tables(void);
> --
> 2.7.4
>
