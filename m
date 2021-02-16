Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969E231CF12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhBPRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhBPR2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:28:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 332A064DFF;
        Tue, 16 Feb 2021 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613496487;
        bh=5YQAn+QKwubyb4oA1PMBGtIpuvfy4qAGuzioBsKkxek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3pgL3FOy1BiR0jL9UGENPszZ/XIACRMKxCTqu/17NS6r6QPfVQ8WPLRnb8fJv59i
         lu7PRfhtWD8nYye1qDg7L7TqbHs0MZ9eXAnXJK6MXwlpUn+JeyQ/HSpeXCVoZ2N94A
         v7ZgolCsA9jPrDX8gjjproQqw/eQJ/a8KVyyIWPs=
Date:   Tue, 16 Feb 2021 18:28:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v1 00/12] Driver of Intel(R) Gaussian & Neural Accelerator
Message-ID: <YCwApLLjNAVl5oLd@kroah.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 05:05:13PM +0100, Maciej Kwapulinski wrote:
> Dear kernel maintainers,
> 
> This submission is a kernel driver to support Intel(R) Gaussian & Neural Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor available on multiple Intel platforms. AI developers and users can offload continuous inference workloads to an Intel(R) GNA device in order to free processor resources and save power. Noise reduction and speech recognition are the examples of the workloads Intel(R) GNA deals with while its usage is not limited to the two.
> 
> For a list of processors equipped with Intel(R) GNA device, please refer to this link:
> https://docs.openvinotoolkit.org/latest/openvino_docs_IE_DG_supported_plugins_GNA.html 
> 
> We think contributing this driver to the upstream kernel project is the best way for developers and users to get the latest Intel(R) GNA support in a Linux kernel, through the mainline to any Linux distributions installed on their systems. Upstreaming also enables contribution from developers around the world to the driver once it is merged.
> 
> The driver works with Intel(R) libraries in user space. The Intel(R) driver exposes a few IOCTL interfaces for use by libraries in user space. The libraries are open sourced and are available at:
> https://github.com/intel/gna
> 
> Prior to the submission, these items were tested or examined against GNA driver patch series put on top of v5.11-rc3 tag of mainline kernel:
> 
> Linux Kernel patch submission checklist
> https://www.kernel.org/doc/html/latest/process/submit-checklist.html?highlight=submit%20checklist
> 
> 1. If you use a facility then #include the file that defines/declares that facility. Don’t depend on other header files pulling in ones that you use.
> (Checked)
> 
> 2. Builds cleanly:
>    with applicable or modified CONFIG options =y, =m, and =n. No gcc warnings/errors, no linker warnings/errors.
>    Passes allnoconfig, allmodconfig
>    Builds successfully when using O=builddir
> (Tested by building kernel with Intel(R) GNA driver config set to ‘m’, ‘y’, and ‘n’; allmodconfig, allnoconfig and O=builddir)
> 
> 3. Builds on multiple CPU architectures by using local cross-compile tools or some other build farm.
> (x86_64 architecture tested - this is architecture where GNA is present and validated, please refer to drivers/misc/gna/Kconfig)
> 
> 4. ppc64 is a good architecture for cross-compilation checking because it tends to use unsigned long for 64-bit quantities.
> (x86_64 architecture tested - this is architecture where GNA is present and validated, please refer to drivers/misc/gna/Kconfig)
> 
> 5. Check your patch for general style as detailed in Documentation/process/coding-style.rst. Check for trivial violations with the patch style checker prior to submission (scripts/checkpatch.pl). You should be able to justify all violations that remain in your patch.
> (Checked. Some warnings were in the output. We checked them and feel they can be ignored.)
> 
> 6. Any new or modified CONFIG options do not muck up the config menu and default to off unless they meet the exception criteria documented in Documentation/kbuild/kconfig-language.rst Menu attributes: default value.
> (No explicit default value is provided because Kbuild system sets it off by default.)
> 
> 7. All new Kconfig options have help text.
> (Checked)
> 
> 8. Has been carefully reviewed with respect to relevant Kconfig combinations. This is very hard to get right with testing – brainpower pays off here.
> (Checked)
> 
> 10. Use make checkstack and fix any problems that it finds.
>     Note
>     checkstack does not point out problems explicitly, but any one function that uses more than 512 bytes on the stack is a candidate for change.
> (Checked)
> 
> 11. Include kernel-doc to document global kernel APIs. (Not required for static functions, but OK there also.) Use make htmldocs or make pdfdocs to check the kernel-doc and fix any issues.
> (Addressed by adding new gna.rst in Documentation; tested with output from ‘make htmldocs’)
> 
> 12. Has been tested with CONFIG_PREEMPT, CONFIG_DEBUG_PREEMPT, CONFIG_DEBUG_SLAB, CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_MUTEXES, CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_ATOMIC_SLEEP, CONFIG_PROVE_RCU and CONFIG_DEBUG_OBJECTS_RCU_HEAD all simultaneously enabled.
> (Checked)
> 
> 13. Has been build- and runtime tested with and without CONFIG_SMP and CONFIG_PREEMPT.
> (Checked)
> 
> 15. All new /proc entries are documented under Documentation/.
> (The driver doesn’t introduce any new procs)
> 
> 16. All new kernel boot parameters are documented in Documentation/admin-guide/kernel-parameters.rst.
> (The driver doesn’t add boot parameters)
> 
> 17. All new module parameters are documented with MODULE_PARM_DESC().
> (Checked)
> 
> 21. Newly-added code has been compiled with gcc -W (use make EXTRA_CFLAGS=-W). This will generate lots of noise, but is good for finding bugs like “warning: comparison between signed.
>     and unsigned”.
> (Checked)
> 
> 24. If any ioctl’s are added by the patch, then also update Documentation/userspace-api/ioctl/ioctl-number.rst.
> (Updated)

What is all of this?  Do you see this on any other patch submission
00/XX patch description?

And please wrap your columns properly.

> The above results only reflect our understanding of the test and the code referred. Please kindly let us know any issues or different observations from any further tests.
> 
> Thanks
> 
> Series-reviewed-by: Tony Luck <tony.luck@intel.com>

That's not a proper sign-off-by or reviewed-by, why isn't this on the
individual patches?

You all keep coming up with new and unique ways to do patch submissions
different than anyone else, why go through all of that effort?

I'll look at this after 5.12-rc1 is out, but odds are, I'm not going to
be happy with it if this is the start...

greg k-h
