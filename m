Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B875131C269
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBOTXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:23:21 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58475 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230163AbhBOTXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:23:20 -0500
Received: from [192.168.0.6] (ip5f5aea9d.dynamic.kabel-deutschland.de [95.90.234.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 569EB20647913;
        Mon, 15 Feb 2021 20:22:35 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: smpboot: CPU numbers printed as warning
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, it+linux-x86@molgen.mpg.de,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Message-ID: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
Date:   Mon, 15 Feb 2021 20:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Using Linux 5.10.13 (and before), looking at the Linux kernel warnings, 
the CPU numbers show up. For example with 12 cpus/threads:

```
$ sudo dmesg --level=warn
[    0.216103]   #2
[    0.220105]   #3
[    0.224103]   #4
[    0.228104]   #5
[    0.232110]   #6
[    0.236101]   #7
[    0.240102]   #8
[    0.244102]   #9
[    0.248100]  #10
[    0.252098]  #11
```

If I am not mistaken, this is from `announce_cpu()` in 
`arch/x86/kernel/smpboot.c`, and the `pr_cont()` in their “forgets” the 
log level it belongs to, maybe because of SMP and other messages are 
printed in between.

```
         if (system_state < SYSTEM_RUNNING) {
                 if (node != current_node) {
                         if (current_node > (-1))
                                 pr_cont("\n");
                         current_node = node;

                         printk(KERN_INFO ".... node %*s#%d, CPUs:  ",
                                node_width - num_digits(node), " ", node);
                 }

                 /* Add padding for the BSP */
                 if (cpu == 1)
                         pr_cont("%*s", width + 1, " ");

                 pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);

         } else
                 pr_info("Booting Node %d Processor %d APIC 0x%x\n",
                         node, cpu, apicid);
```

Would using `pr_info()` instead be an acceptable fix?


Kind regards,

Paul
