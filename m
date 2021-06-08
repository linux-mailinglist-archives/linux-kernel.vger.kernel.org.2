Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A362A39F141
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFHIr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhFHIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:47:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3272C061574;
        Tue,  8 Jun 2021 01:45:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g20so31370789ejt.0;
        Tue, 08 Jun 2021 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fR3ab/zjle1Nt5uNzFnvgGqgsj2Kj0CI4fURhn3/mgg=;
        b=NDGy3qSGukY0MuCs9OFy7RAF3W3bLsQSZ25MzP+N8xFY2Jl+u1YT9C08Gdb1QlFVGr
         OE3R1gyCwf6EHTdXtEKMTS0jV5A2qQPNTJPwv3DyuA7fNpPmnAZDdVuXt0CJ1Bpx33V1
         Wj7d+us7cCYIuq/SO41nQL+1QJHY5hPxLugL/iRHMweIiRjPgVZ5JEYtxVxJZKJBVl7w
         IgD0IKvjJiNgWEAmJthlvxrjmRJlFmvvdmLNqkvE3E+traDk6sFLoZd1P8unFM3jt7pY
         IJNgqyQ7XDF9gteqszgms8WFEpEXr/iZ+rVzv56jl+/OZGVqr88zmFLhL0b9vKNVgMEm
         bOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fR3ab/zjle1Nt5uNzFnvgGqgsj2Kj0CI4fURhn3/mgg=;
        b=lb6h9gyBxvRRw8l54iJwQ54jR6k8Y+DRIk1ZvCuNC+5eCLbSqSjVRsFsM4vFS3xblj
         w66EHROX/0knMPXreQnzTkWSqk8PLBipDRbCuDhBluPkKuPlbFJjCOL5LOQ7uCdq+A2T
         /neC3VEVWX+KzqEX+qojHgA1Bi3SUPJ6eeAX0/03K/F3ay9cPxRXjiUfWAePwgW8oppc
         JGPsbgN8Pd96cMeH9kzP2UI/VO/UDE8mpM/lcx7P6t6IJw/waVSkAQqfgdjK2fr2n05n
         iOP9iAOkziUjSh+Lepd2DPoiLhCQYx+YrOaPtiMJ/liZMr+/J8Rg66+k3So2a7Z2tooK
         7yhg==
X-Gm-Message-State: AOAM530pzglNBcKMyZwHnAylulKYiE13l3SE2m3HWDsq5DcUt6PmmrIc
        qaOTh9Xzlb2lVaksN8X78AU=
X-Google-Smtp-Source: ABdhPJzcPlCByzHE+0eTX3kyRDawZVkCCk1Q5edkuoHkkm9Qe22jfhGQl7cWRkva+y8IT7FyLd7MGA==
X-Received: by 2002:a17:907:2bf9:: with SMTP id gv57mr22369726ejc.189.1623141919565;
        Tue, 08 Jun 2021 01:45:19 -0700 (PDT)
Received: from localhost.localdomain (ispc-static-34.84-47-111.telekom.sk. [84.47.111.34])
        by smtp.gmail.com with ESMTPSA id m4sm7353184eje.8.2021.06.08.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 01:45:19 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        faiyazm@codeaurora.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>
Subject: [RFC 4/4] docs: add description of debugfs files for SLUB cache
Date:   Tue,  8 Jun 2021 10:45:17 +0200
Message-Id: <20210608084517.6119-1-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
In-Reply-To: <20210521121127.24653-1-glittao@gmail.com>
References: <20210521121127.24653-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Add description of debugfs files alloc_traces, free_traces
and all_objects to SLUB cache documentation.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 Documentation/vm/slub.rst | 109 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 03f294a638bd..2280d74d395c 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -384,5 +384,114 @@ c) Execute ``slabinfo-gnuplot.sh`` in '-t' mode, passing all of the
       40,60`` range will plot only samples collected between 40th and
       60th seconds).

+
+DebugFS files for SLUB
+======================
+
+For more debug information about current state of SLUB caches
+with the user tracking debug option enabled, debugfs files
+are available. There are 3 types of these files
+with different debug information:
+
+1. alloc_traces::
+
+    Prints information about unique allocation traces of
+    the currently allocated objects together with their frequency.
+    Output sorted by frequency of use.
+
+    Information on output:
+    Number of uses, allocating function, minimal/average/maximal jiffies since alloc,
+    pid of the process, allocated by cpu and stack trace.
+
+    Example:::
+
+    1085 populate_error_injection_list+0x97/0x110 age=166678/166680/166682 pid=1 cpus=1::
+	__slab_alloc+0x6d/0x90
+	kmem_cache_alloc_trace+0x2eb/0x300
+	populate_error_injection_list+0x97/0x110
+	init_error_injection+0x1b/0x71
+	do_one_initcall+0x5f/0x2d0
+	kernel_init_freeable+0x26f/0x2d7
+	kernel_init+0xe/0x118
+	ret_from_fork+0x22/0x30
+
+
+2. free_traces::
+
+    Prints information about unique free traces of
+    the currently free objects together with their frequency.
+    Output sorted by frequency of use.
+
+    Information on output:
+    Number of uses, freeing function, minimal/average/maximal jiffies since free,
+    pid of the process, freed by cpu and stack trace.
+
+    Example:::
+
+    51 acpi_ut_update_ref_count+0x6a6/0x782 age=236886/237027/237772 pid=1 cpus=1
+	kfree+0x2db/0x420
+	acpi_ut_update_ref_count+0x6a6/0x782
+	acpi_ut_update_object_reference+0x1ad/0x234
+	acpi_ut_remove_reference+0x7d/0x84
+	acpi_rs_get_prt_method_data+0x97/0xd6
+	acpi_get_irq_routing_table+0x82/0xc4
+	acpi_pci_irq_find_prt_entry+0x8e/0x2e0
+	acpi_pci_irq_lookup+0x3a/0x1e0
+	acpi_pci_irq_enable+0x77/0x240
+	pcibios_enable_device+0x39/0x40
+	do_pci_enable_device.part.0+0x5d/0xe0
+	pci_enable_device_flags+0xfc/0x120
+	pci_enable_device+0x13/0x20
+	virtio_pci_probe+0x9e/0x170
+	local_pci_probe+0x48/0x80
+	pci_device_probe+0x105/0x1c0
+
+
+3. all_objects::
+
+    Prints information about all object (both allocated and free)
+    in given SLUB cache.
+
+    Example:::
+
+    Object: 0000000042ee8b00 free
+    Last allocated: ima_queue_key+0x2f/0x1b0 age=247112 pid=1 cpu=1
+	__slab_alloc+0x6d/0x90
+	kmem_cache_alloc_trace+0x2eb/0x300
+	ima_queue_key+0x2f/0x1b0
+	ima_post_key_create_or_update+0x46/0x80
+	key_create_or_update+0x383/0x5b0
+	load_certificate_list+0x75/0xa0
+	load_system_certificate_list+0x2f/0x31
+	do_one_initcall+0x5f/0x2d0
+	kernel_init_freeable+0x26f/0x2d7
+	kernel_init+0xe/0x118
+	ret_from_fork+0x22/0x30
+    Last free: ima_process_queued_keys.part.0+0x84/0xf0 age=170962 pid=137 cpu=1
+	kfree+0x2db/0x420
+	ima_process_queued_keys.part.0+0x84/0xf0
+    	ima_keys_handler+0x57/0x60
+	process_one_work+0x2a5/0x590
+	worker_thread+0x52/0x3f0
+    	kthread+0x140/0x160
+	ret_from_fork+0x22/0x30
+
+    Information on output:
+
+    a) Object: <address> allocated/free
+       There is address of object and information whether object is
+       allocated or free.
+
+    b) Last allocated: <address os user> age=<jiffies since alloc> pid=<pid of
+       the process> cpu=<allocated by cpu>
+
+    c) Alloc stacktrace
+
+    d) Last free: <address of user> age=<jiffies since freed> pid=<pid of
+       the process> cpu=<freed by cpu>
+
+    e) Free stacktrace
+
+
 Christoph Lameter, May 30, 2007
 Sergey Senozhatsky, October 23, 2015
--
2.31.1.272.g89b43f80a5

