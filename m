Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D745683D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 03:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhKSCk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 21:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhKSCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 21:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637289474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnvDNFDoF1VU/jQCFmwfaddk/jfILNPNPxV1ymT2X7E=;
        b=ZLbS7RTZoXPptR2DgaHo5kIsoyBFA89jx9scff3s8HqksnVrjbVCYzY5MM/5RIyneUQ8sU
        0f80u5JkGkAID0xR/J3EUS15cet8Cu1CzOST4+Qp0wWSXIAdKcIRpLLVtD8i7NcDLcCSEP
        W7azVKIEl7Z4nzB/5pLhOEGWeWCuGdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-566-fyn5wuNNMQSpuQgysatyBQ-1; Thu, 18 Nov 2021 21:37:50 -0500
X-MC-Unique: fyn5wuNNMQSpuQgysatyBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB9A1023F4D;
        Fri, 19 Nov 2021 02:37:47 +0000 (UTC)
Received: from localhost (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7400519730;
        Fri, 19 Nov 2021 02:37:38 +0000 (UTC)
Date:   Fri, 19 Nov 2021 10:37:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Message-ID: <20211119023735.GH21646@MiWiFi-R3L-srv>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 11/18/21 at 12:49pm, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr which describes the CPUs and memory
> in the system, must also be updated, else the resulting vmcore is
> inaccurate (eg. missing either CPU context or memory regions).
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility.
> 
> In the post https://lkml.org/lkml/2020/12/14/532 I outlined two
> problems with this userspace-initiated unload-then-reload approach as
> it pertains to supporting CPU and memory hot un/plug for kdump.
> (Note in that post, I erroneously called the elfcorehdr the vmcoreinfo
> structure. There is a vmcoreinfo structure, but it has a different
> purpose. So in that post substitute "elfcorehdr" for "vmcoreinfo".)

It's great you finally make this patchset to address the cpu/mem hotplug
issues raised before, I will review it carefully. And I have to say
sorry, because I ever promised you to do this but didn't keep it due to
personal reasons.

Thanks again for doing this.

> 
> The first problem being the time needed to complete the unload-then-
> reload of the kdump image, and the second being the effective race
> window that unload-then-reload effort creates.
> 
> The scenario I measured was a 32GiB guest being resized to 512GiB and
> observing it took over 4 minutes for udev to "settle down" and
> complete the unload-then-reload of the resulting 3840 hot plug events.
> Empirical evidence within our fleet substantiates this problem.
> 
> Each unload-then-reload creates a race window the size of which is the
> time it takes to reload the complete kdump image. Within the race
> window, kdump is not loaded and should a panic occur, the kernel halts
> rather than dumping core via kdump.
> 
> This patchset significantly improves upon the current solution by
> enabling the kernel to update only the necessary items of the kdump
> image. In the case of x86_64, that is just the elfcorehdr and the
> purgatory segments. These updates occur as fast as the hot un/plug
> events and significantly reduce the size of the race window.
> 
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, which reflects the current CPUs and memory regions, into a
> buffer. Since purgatory also does an integrity check via hash digests
> of the loaded segments, purgatory must also be updated with the new
> digests. The arch handler also generates a new purgatory into a
> buffer, performs the hash digests of the new memory segments, and then
> patches purgatory with the new digests.  If all succeeds, then the
> elfcorehdr and purgatory buffers over write the existing buffers and
> the new kdump image is live and ready to go. No involvement with
> userspace at all.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr memory must be sufficiently large enough to accommodate
> changes. The CRASH_HOTPLUG_ELFCOREHDR_SZ configure item does just
> this.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>  - Disable the udev rule for updating kdump on hot un/plug changes
>    Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
>    or other technique to neuter the rule.
> 
>  - Change to the kexec_file_load for loading the kdump kernel:
>    Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>     standard_kexec_args="-p -d -s"
>    which adds the -s to select kexec_file_load syscall.
> 
> This work has raised the following questions for me:
> 
> First and foremost, this patch only works for the kexec_file_load
> syscall path (via "kexec -s -p" utility). The reason being that, for
> x86_64 anyway, the purgatory blob provided by userspace can not be
> readily decoded in order to update the hash digest. (The
> kexec_file_load purgatory is actually a small ELF object with symbols,
> so can be patched at run time.) With no way to update purgatory, the
> integrity check will always fail and and cause purgatory to hang at
> panic time.
> 
> That being said, I actually developed this against the kexec_load path
> and did have that working by making two one-line changes to userspace
> kexec utility: one change that effectively is
> CRASH_HOTPLUG_ELFCOREHDR_SZ and the other to disable the integrity
> check. But that does not seem to be a long term solution. A possible
> long term solution would be to allow the use of the kexec_file_load
> purgatory ELF object with the kexec_load path. While I believe that
> would work, I am unsure if there are any downsides to doing so.
> 
> The second problem is the use of CPUHP_AP_ONLINE_DYN.  The
> cpuhp_setup_state_nocalls() is invoked with parameter
> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
> the CPU still shows up in foreach_present_cpu() during the
> regeneration of the elfcorehdr, thus the need to explicitly check and
> exclude the soon-to-be offlined CPU in crash_prepare_elf64_headers().
> Perhaps if value(s) new/different than CPUHP_AP_ONLINE_DYN to
> cpuhp_setup_state() was utilized, then the offline cpu would no longer
> be in foreach_present_cpu(), and this change could be eliminated. I do
> not understand cpuhp_setup_state() well enough to choose, or create,
> appropriate value(s).
> 
> The third problem is the number of memory hot un/plug events.  If, for
> example, a 1GiB DIMM is hotplugged, that generate 8 memory events, one
> for each 128MiB memblock, yet the walk_system_ram_res() that is used
> to obtain the list of memory regions reports the single 1GiB; thus
> there are 7 un-necessary trips through this crash hotplug handler.
> Perhaps there is another way of handling memory events that would see
> the single 1GiB DIMM rather than each memblock?
> 
> Regards,
> eric
> 
> Eric DeVolder (8):
>   crash: fix minor typo/bug in debug message
>   crash hp: Introduce CRASH_HOTPLUG configuration options
>   crash hp: definitions and prototypes for crash hotplug support
>   crash hp: generic crash hotplug support infrastructure
>   crash hp: kexec_file changes for use by crash hotplug handler
>   crash hp: Add x86 crash hotplug state items to kimage
>   crash hp: Add x86 crash hotplug support for kexec_file_load
>   crash hp: Add x86 crash hotplug support for bzImage
> 
>  arch/x86/Kconfig                  |  26 +++
>  arch/x86/include/asm/kexec.h      |  10 ++
>  arch/x86/kernel/crash.c           | 257 +++++++++++++++++++++++++++++-
>  arch/x86/kernel/kexec-bzimage64.c |  12 ++
>  include/linux/kexec.h             |  22 ++-
>  kernel/crash_core.c               | 118 ++++++++++++++
>  kernel/kexec_file.c               |  19 ++-
>  7 files changed, 455 insertions(+), 9 deletions(-)
> 
> -- 
> 2.27.0
> 

