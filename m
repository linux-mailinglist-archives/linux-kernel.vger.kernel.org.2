Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0738F380DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhENQQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:16:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:2787 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhENQQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:16:37 -0400
IronPort-SDR: IJk3ZruCV0V0uc1vYLWUYk5gJEEafW7d3hvftSfRS27kV0iCaVTUizcrzQvk1kUjkDdvFh1nFd
 e2PHhAL/6Y8w==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="200252019"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="200252019"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 09:15:21 -0700
IronPort-SDR: blY05JkgxFSpOK1YA3Jre2JoSqapjRVMGxhBT9GCrZB4eYzkGHVjIfyPdgjdBGrVXlCUy6tm2Y
 iS1bWJa/TFMg==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="438074788"
Received: from rvarsha1-mobl1.gar.corp.intel.com ([10.215.180.45])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 09:15:18 -0700
Message-ID: <76e9c2ae095184930669856e9f1a886d92b83f36.camel@linux.intel.com>
Subject: Re: [RFC] cpufreq: Excessive CPUFreq driver loading
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Meyer, Kyle" <kyle.meyer@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "lenb@kernel.org" <lenb@kernel.org>
Date:   Fri, 14 May 2021 09:15:14 -0700
In-Reply-To: <TU4PR8401MB05927B583A481A3F1823CD549B509@TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM>
References: <DF4PR8401MB103590DB5A8656D6748B428E9B589@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
         <TU4PR8401MB05927B583A481A3F1823CD549B509@TU4PR8401MB0592.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-05-14 at 14:06 +0000, Meyer, Kyle wrote:
> Adding maintainers to the CC list.
> 
> Thank you,
> Kyle Meyer
> 
> ________________________________________
> From: Meyer, Kyle <kyle.meyer@hpe.com>
> Sent: Thursday, May 6, 2021 9:25 AM
> To: LKML
> Subject: [RFC] cpufreq: Excessive CPUFreq driver loading
> 
> Hello,
> 
> acpi-cpufreq is mutually exclusive with intel_pstate, however, acpi-
> cpufreq is
> loaded multiple times during startup while intel_pstate is enabled.
> 
> This issue was reported to the systemd maintainers and they indicated
> that it
> should be fixed in the kernel: 
> https://github.com/systemd/systemd/issues/19439
> 
> During startup, the kernel triggers one uevent for each device as a
> result of
> systemd-udev-trigger.service executing "udevadm trigger --
> type=subsystems
> --action=add" and "udevadm trigger --type=devices --action=add". The
> service
> exists to retrigger all devices as uevents sent by the kernel, before
> systemd-udevd is running, would have been missed. When systemd-udevd
> receives a
> uevent it matches its configured rules against the device. If a
> uevent's
> ACTION=="add", systemd-udevd will run "kmod load $env{MODALIAS}" from
> 80-drivers.rules. udev's builtin kmod will then attempt to load
> modules
> matching the device's MODALIAS.
> 
> When systemd-udevd recieves an "add" uevent from
> /devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:XXX it runs "kmod load
> cpu:type:x86,
> ...,00E8,..." as "cpu:type:x86,...,00E8,..." is that devices
> MODALIAS.
> 
> When systemd-udevd recieves an "add" uevent from
> /devices/system/cpu/cpuXXX it
> runs "kmod load acpi:ACPI0007:" as "acpi:ACPI0007:" is that devices
> MODALIAS.
> 
> acpi-cpufreq is loaded as it matches both devices MODALIASes.
> # modinfo acpi-cpufreq | grep alias
> alias:          acpi
> alias:          cpu:type:x86,ven*fam*mod*:feature:*00E8*
> alias:          cpu:type:x86,ven*fam*mod*:feature:*0016*
> alias:          acpi*:ACPI0007:*
> alias:          acpi*:LNXCPU:*
> 
> On a system with 1536 logical CPUs, systemd-udevd attempts to load
> acpi-cpufreq
> 3072 times.
> 
> 1536 * /devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0007:XXX
> 1536 * /devices/system/cpu/cpuXXX
> 
> The delay, caused by systemd-udevd attempting to load the driver, has
> a
> significant impact on the startup time. It causes some devices to be
> unavailable after reaching the root login prompt as it postpones the
> loading of
> other drivers.
> 
> Each time that the driver is loaded it returns -EEXIST from
> acpi_cpufreq_init.
> static int __init acpi_cpufreq_init(void)
> {
>         int ret;
> 
>         if (acpi_disabled)
>                 return -ENODEV;
> 
>         /* don't keep reloading if cpufreq_driver exists */
>         if (cpufreq_get_current_driver())
>                 return -EEXIST;
> ...
> 
> Changing the return value from -EEXIST to 0 when another driver
> exists prevents
> the driver from being loaded multiple times as kmod won't load a
> "live" module.
> Alternatively, blacklisting the driver (or disabling intel_pstate)
> prevents the
> issue as well. Below are the before and after startup times.
> 
> # systemd-analyze
> Startup finished in 37.939s (kernel) + 10.909s (initrd) + 3min
> 55.004s (userspace) = 4min 43.852s
> 
> # systemd-analyze
> Startup finished in 38.307s (kernel) + 10.205s (initrd) + 38.312s
> (userspace) = 1min 26.826s

That is a big difference. i think when you return 0, lsmod will show
the module loaded. But that shouldn't be a problem in my opinion.

Thanks,
Srinivas




> 
> Thank you,
> Kyle Meyer


