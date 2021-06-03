Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58985399C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFCH6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCH6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C36A0613D6;
        Thu,  3 Jun 2021 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622706999;
        bh=f8WW4Yew158OC1flZpQYNvtQO2fcKQ8f7keo/GpY5co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fQSxYoZo+ylWwgnY2X18ptshUdx7icVYG8M67ro6KGeNLHyU8ehnulvZ7hY9o0Awf
         n77kPgqJU8qogYLlHI853mPXlMqQ4tch33lLoZA9ZvELezkB18vECLURAFISa3l2J3
         glBUIFj+Pj2J72eZxUi+udUmQoh9ie7Llz12nyCuYunDHAINxtE5ifiJl4tGlh9Bcp
         ewe9ql8pAza7hrrYGI50luJegmjIYEs1nUJ2nA2KYVVGw6T5UdmrCyjOG/yGPrPSfd
         wMuY/fwRADpZOaZT9+oAeaOe378NfcPoZQWMy8wwYjaT9qIP5F5s1ZYdT5j5J13dsl
         b2pnsKzaRpQnA==
Date:   Thu, 3 Jun 2021 09:56:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org, federico.vaga@vaga.pv.it
Subject: Re: [PATCH 07/12] docs: accounting: update delay-accounting.rst
 reference
Message-ID: <20210603095632.35ab9fee@coco.lan>
In-Reply-To: <20210602221940.7e0a6135@coco.lan>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
        <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
        <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
        <20210602200121.64a828a1@coco.lan>
        <871r9k6rmy.fsf@meer.lwn.net>
        <20210602221940.7e0a6135@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 2 Jun 2021 22:19:40 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Wed, 2 Jun 2021 20:29:23 +0200
> Peter Zijlstra <peterz@infradead.org> escreveu:
> 
> > > Peter Zijlstra <peterz@infradead.org> escreveu:
> > >     
> > > > On Wed, Jun 02, 2021 at 05:43:13PM +0200, Mauro Carvalho Chehab wrote:    
> >   
> > > > >  Enables/disables task delay accounting (see
> > > > > -:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
> > > > > +:doc:`/accounting/delay-accounting`). Enabling this feature incurs      
> > > > 
> > > > This breaks any chance of using 'goto file' like features in text
> > > > editors :/     
> > > 
> > > This is a feature of your favorite text editor. Not all have it.    
> > 
> > Afaict both vim (gf) and emacs (M-x ffap) can do this. That covers about
> > 99% of all sane editors no? :-)  
> 
> Heh, not quite ;-) Here, I use nano(/pico), from the old times where 
> (al)pine was my emailer. I can live with vim, but I prefer an editor
> that starts in editing mode.
> 
> I tried to use emacs a few times, but my fingers are too much into
> pico/nano control keys, so it was ending by making me typing a lot
> slower. Besides that, nano works well on 99% of my daily needs. 
> 
> When I need more fancy, like regex substitutions, changing/moving
> big code blocks, editing multiple files at the same time, etc, 
> then I just use a GUI editor (currently kate, but seeking for
> a good replacement, as some changes during F33 times - still 
> present on F34 - caused some regressions).
> 
> Em Wed, 02 Jun 2021 12:36:05 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > > That's said, automarkup.py has a rule to convert Documentation/<foo>.rst
> > > into :doc:`<foo>`. So, an alternative approach would be to convert
> > > treewide all :doc:`<foo>` into Documentation/<foo>.rst and add something 
> > > at checkpatch.pl to recommend to avoid :doc: notation.    
> > 
> > That seems like the right approach to me.  We have the automarkup
> > capability, we might as well make use of it...  
> 
> Ok, I'll prepare a separate patch series addressing it. 
> 
> -
> 
> Jon,
> 
> With regards to the :doc: -> Documentation/ conversion, I guess I'll
> do it on an independent patch series against your docs-next tree.

A pure replace of two patterns:

	:doc:\`(/[^\`]+)\`
	:doc:\`([^\`\<]+)\`

Produced this result:

 Documentation/PCI/endpoint/pci-endpoint-cfs.rst                             |  2 +-
 Documentation/PCI/pci.rst                                                   |  6 +++---
 Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst |  2 +-
 Documentation/admin-guide/media/bt8xx.rst                                   |  8 ++++----
 Documentation/admin-guide/media/bttv.rst                                    | 14 +++++++-------
 Documentation/admin-guide/media/index.rst                                   |  4 ++--
 Documentation/admin-guide/media/saa7134.rst                                 |  2 +-
 Documentation/admin-guide/pm/intel_idle.rst                                 | 10 +++++-----
 Documentation/admin-guide/pm/intel_pstate.rst                               |  4 ++--
 Documentation/admin-guide/sysctl/abi.rst                                    |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst                                 | 32 ++++++++++++++++----------------
 Documentation/block/biodoc.rst                                              |  2 +-
 Documentation/bpf/bpf_lsm.rst                                               |  4 ++--
 Documentation/core-api/bus-virt-phys-mapping.rst                            |  2 +-
 Documentation/core-api/dma-api.rst                                          |  4 ++--
 Documentation/core-api/dma-isa-lpc.rst                                      |  2 +-
 Documentation/core-api/index.rst                                            |  4 ++--
 Documentation/dev-tools/kunit/api/index.rst                                 |  2 +-
 Documentation/dev-tools/kunit/faq.rst                                       |  2 +-
 Documentation/dev-tools/kunit/index.rst                                     | 14 +++++++-------
 Documentation/dev-tools/kunit/start.rst                                     |  6 +++---
 Documentation/dev-tools/kunit/tips.rst                                      |  4 ++--
 Documentation/dev-tools/kunit/usage.rst                                     |  6 +++---
 Documentation/dev-tools/testing-overview.rst                                |  4 ++--
 Documentation/devicetree/bindings/submitting-patches.rst                    |  2 +-
 Documentation/doc-guide/contributing.rst                                    |  8 ++++----
 Documentation/driver-api/gpio/using-gpio.rst                                |  4 ++--
 Documentation/driver-api/ioctl.rst                                          |  2 +-
 Documentation/driver-api/media/drivers/bttv-devel.rst                       |  2 +-
 Documentation/driver-api/media/index.rst                                    |  4 ++--
 Documentation/driver-api/pm/devices.rst                                     |  2 +-
 Documentation/driver-api/surface_aggregator/clients/index.rst               |  2 +-
 Documentation/driver-api/surface_aggregator/internal.rst                    |  6 +++---
 Documentation/driver-api/surface_aggregator/overview.rst                    |  4 ++--
 Documentation/driver-api/usb/dma.rst                                        |  6 +++---
 Documentation/firmware-guide/acpi/dsd/data-node-references.rst              |  2 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst                             |  2 +-
 Documentation/firmware-guide/acpi/enumeration.rst                           |  2 +-
 Documentation/hwmon/adm1177.rst                                             |  2 +-
 Documentation/i2c/instantiating-devices.rst                                 |  2 +-
 Documentation/i2c/old-module-parameters.rst                                 |  2 +-
 Documentation/i2c/smbus-protocol.rst                                        |  2 +-
 Documentation/kernel-hacking/hacking.rst                                    |  4 ++--
 Documentation/networking/devlink/devlink-region.rst                         |  2 +-
 Documentation/networking/devlink/devlink-trap.rst                           |  4 ++--
 Documentation/process/submitting-patches.rst                                | 12 ++++++------
 Documentation/security/landlock.rst                                         |  2 +-
 Documentation/trace/coresight/coresight.rst                                 |  6 +++---
 Documentation/trace/ftrace.rst                                              |  2 +-
 Documentation/translations/it_IT/core-api/symbol-namespaces.rst             |  2 +-
 Documentation/translations/it_IT/kernel-hacking/hacking.rst                 |  4 ++--
 Documentation/translations/it_IT/process/email-clients.rst                  |  2 +-
 Documentation/translations/it_IT/process/management-style.rst               |  2 +-
 Documentation/translations/it_IT/process/submitting-patches.rst             | 14 +++++++-------
 Documentation/translations/it_IT/riscv/patch-acceptance.rst                 |  2 +-
 Documentation/translations/zh_CN/admin-guide/bug-bisect.rst                 |  2 +-
 Documentation/translations/zh_CN/admin-guide/bug-hunting.rst                |  2 +-
 Documentation/translations/zh_CN/admin-guide/index.rst                      |  2 +-
 Documentation/translations/zh_CN/admin-guide/init.rst                       |  2 +-
 Documentation/translations/zh_CN/admin-guide/security-bugs.rst              |  2 +-
 Documentation/translations/zh_CN/admin-guide/tainted-kernels.rst            |  2 +-
 Documentation/translations/zh_CN/core-api/index.rst                         |  6 +++---
 Documentation/translations/zh_CN/core-api/irq/concepts.rst                  |  2 +-
 Documentation/translations/zh_CN/core-api/irq/index.rst                     |  2 +-
 Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst              |  2 +-
 Documentation/translations/zh_CN/core-api/irq/irq-domain.rst                |  2 +-
 Documentation/translations/zh_CN/core-api/irq/irqflags-tracing.rst          |  2 +-
 Documentation/translations/zh_CN/cpu-freq/core.rst                          |  2 +-
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst                   |  2 +-
 Documentation/translations/zh_CN/cpu-freq/cpufreq-stats.rst                 |  2 +-
 Documentation/translations/zh_CN/cpu-freq/index.rst                         |  2 +-
 Documentation/translations/zh_CN/filesystems/debugfs.rst                    |  2 +-
 Documentation/translations/zh_CN/iio/ep93xx_adc.rst                         |  2 +-
 Documentation/translations/zh_CN/iio/iio_configfs.rst                       |  2 +-
 Documentation/translations/zh_CN/iio/index.rst                              |  2 +-
 Documentation/translations/zh_CN/mips/booting.rst                           |  2 +-
 Documentation/translations/zh_CN/mips/features.rst                          |  2 +-
 Documentation/translations/zh_CN/mips/index.rst                             |  2 +-
 Documentation/translations/zh_CN/mips/ingenic-tcu.rst                       |  2 +-
 Documentation/translations/zh_CN/openrisc/index.rst                         |  2 +-
 Documentation/translations/zh_CN/openrisc/openrisc_port.rst                 |  2 +-
 Documentation/translations/zh_CN/openrisc/todo.rst                          |  2 +-
 Documentation/translations/zh_CN/riscv/boot-image-header.rst                |  2 +-
 Documentation/translations/zh_CN/riscv/index.rst                            |  2 +-
 Documentation/translations/zh_CN/riscv/patch-acceptance.rst                 |  2 +-
 Documentation/translations/zh_CN/riscv/pmu.rst                              |  2 +-
 Documentation/translations/zh_CN/sound/hd-audio/index.rst                   |  2 +-
 Documentation/translations/zh_CN/sound/index.rst                            |  2 +-
 Documentation/userspace-api/landlock.rst                                    |  8 ++++----
 Documentation/userspace-api/media/glossary.rst                              |  2 +-
 Documentation/userspace-api/media/index.rst                                 |  4 ++--
 Documentation/virt/kvm/s390-pv-boot.rst                                     |  2 +-
 Documentation/x86/boot.rst                                                  |  4 ++--
 Documentation/x86/mtrr.rst                                                  |  2 +-
 94 files changed, 174 insertions(+), 174 deletions(-)

Some manual work is needed, as a couple of replacements occurred inside
tables. I also need to check if automarkup.py got everything, including
the ones inside tables.

I'm in doubt with regards to translations. There, the tag is used
to point to the original translation, like on
Documentation/translations/it_IT/core-api/symbol-namespaces.rst:

	:Original: :doc:`../../../core-api/symbol-namespaces`
	:Translator: Federico Vaga <federico.vaga@vaga.pv.it>

My personal preference would be to keep using it for translations.

There are, however, two special cases:

1. Named cross-references with a documentation path:

	:doc:`Non-Transparent Bridge <../../driver-api/ntb>`

   As the end result (in html) would be something like:

	<a href="../../driver-api/ntb.html>Non-Transparent Bridge</a>

   We might just ignore the name and convert it into:

	Documentation/driver-api/ntb.rst

   but this sounds a bad idea on my eyes, as some context can be missed.

   So, I would keep using :doc: on such cases.

2. Named cross-references without a path:

	:doc: AMDGPU RAS Reboot Behavior for Unrecoverable Errors

   This actually guides to a kernel-doc markup inside a C file:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: * DOC: AMDGPU RAS Reboot Behavior for Unrecoverable Errors

   So, those can't be converted.

The net result is that a warning at checkpatch.pl about the usage of 
:doc: would need to exclude those special cases.

Thanks,
Mauro
