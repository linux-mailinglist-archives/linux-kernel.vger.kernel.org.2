Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A43A24FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJHGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJHG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:06:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB40C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:04:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 27so21843476pgy.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wowS9S0+74HOyg59G1HxzyUoJNUg4XMSp6qmBnId03g=;
        b=DSRkJ+QLRWdBNl0PvX9aNt9Ue9lalAf4M+pRXemlmISeSiIiYJpA4LRmG6tF5lS2Pb
         cG/J2XwcTr0GPlImXxWAISm472NQ7mVXBz4NpZ+NH2twea+AMU8eDuDCasSNepIbTd5i
         pa86lEGmY4c6rs8/vySPv4osHlhBAd8RdslrbUBBujwBjjJXxaKE9yYgbzxYFtP7Emlw
         6Af0WhPzEtEseI1xm/BNOj8VWg3PlLJCkpod2c9vKtI9IiB0Bz6Z+kJPfn6NQSwy//UD
         u3RQDvyq2j0uIjPlMdo16dJ8sCyubqDTcinRgvvfKVYiw8/pUde74gWMENkiKaT+CAU9
         doRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wowS9S0+74HOyg59G1HxzyUoJNUg4XMSp6qmBnId03g=;
        b=NJTEE6FKVC4nrEFYNOewioO0Y6Rfj2rN+3oIyIwnFns6OnDLof2f0xiSppTpyu6wSt
         u7yP9YEfk/OtoiDl12d4t9xXfLw09qksDpO9/YQM1wqnPC6YBaiMVdm6+rHOu6sTdl1e
         lNvbw8V7QZZne1s/BuXuE+GSAibTxAre760nA2N4xjppvZJ0CVBHEqI5DVAyUtraBvmH
         uVQ7b/uADQnzJWpzep7hRaInX8illi4IrV+WgpXo5r0lBu7DHSPNplyuJ+k0k/Wi8YTF
         z3hJFRcvLGFHsVlySoZ4uWnVbDjnn93qTH8aAiu2rtuvwlSdFusDGhBSed0RCJL5OfJ/
         n19Q==
X-Gm-Message-State: AOAM533XyR9MUYSN8hc9PP7WThw/ZimvRobuuB4J33FisOFQ3gKFKCcl
        Ptf28uLGO14yYeYYfo+yn/8=
X-Google-Smtp-Source: ABdhPJxxnmtXOYMln3q/b9V4lWAlkfdb2J9ymAvyaaQItl5bNAm6Co1M21fvTm8/RfVCXCCtUMiXtw==
X-Received: by 2002:a05:6a00:26d8:b029:2ea:1101:8acf with SMTP id p24-20020a056a0026d8b02902ea11018acfmr1576201pfw.67.1623308673410;
        Thu, 10 Jun 2021 00:04:33 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id ge13sm6859249pjb.2.2021.06.10.00.04.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:04:33 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     jolsa@kernel.org, rostedt@goodmis.org, Viktor.Rosendahl@bmw.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tools: tools/Makefile supports the compilation of getdelay
Date:   Thu, 10 Jun 2021 15:04:30 +0800
Message-Id: <1623308670-17648-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

tools/Makefile supports the compilation of getdelay, which
can simplify our compilation.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 tools/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 7e9d34d..62546ff 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -10,6 +10,7 @@ help:
 	@echo 'Possible targets:'
 	@echo ''
 	@echo '  acpi                   - ACPI tools'
+	@echo '  accounting             - delay accounting tools'
 	@echo '  bpf                    - misc BPF tools'
 	@echo '  cgroup                 - cgroup tools'
 	@echo '  cpupower               - a tool for all things x86 CPU power'
@@ -65,7 +66,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+accounting cgroup firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -100,7 +101,7 @@ freefall: FORCE
 kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
-all: acpi cgroup cpupower gpio hv firewire liblockdep \
+all: acpi accounting cgroup cpupower gpio hv firewire liblockdep \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
@@ -112,7 +113,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+accounting_install cgroup_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
@@ -133,7 +134,7 @@ freefall_install:
 kvm_stat_install:
 	$(call descend,kvm/$(@:_install=),install)
 
-install: acpi_install cgroup_install cpupower_install gpio_install \
+install: acpi_install accounting_install cgroup_install cpupower_install gpio_install \
 		hv_install firewire_install iio_install liblockdep_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
@@ -147,7 +148,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
+accounting_clean cgroup_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -181,7 +182,7 @@ freefall_clean:
 build_clean:
 	$(call descend,build,clean)
 
-clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
+clean: acpi_clean accounting_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
-- 
1.8.3.1

