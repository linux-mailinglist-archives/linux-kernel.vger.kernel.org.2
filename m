Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096093911AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhEZH5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232193AbhEZH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622015777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YZTnNp0GHc8FBHqwGo8InF/6LifI/fpn3t7IYqBLJbk=;
        b=Yu/kpOh/9lRtzt8EJxt8JM6No/L5biUr//5lCJuWqmrNW2dwM7TFXZGev56hR0PeEXKieF
        YvKQ8BV3vBMQy0ju74UkNyj8UEuw4dS5ja9L140Rax0KTmCfJEV1X28yjw7ol0t5MaNutW
        XohAWFujIx63lZJCAr06ymGgno6tSmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-UntS37u6MAeBB0VV-iASQw-1; Wed, 26 May 2021 03:56:13 -0400
X-MC-Unique: UntS37u6MAeBB0VV-iASQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E46B1854E26;
        Wed, 26 May 2021 07:56:11 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6A931001281;
        Wed, 26 May 2021 07:56:02 +0000 (UTC)
Date:   Wed, 26 May 2021 15:55:59 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] Documentation: kdump: update kdump guide
Message-ID: <YK3/DwN62/fP4dXJ@dhcp-128-65.nay.redhat.com>
References: <20210520103729.13696-1-bhe@redhat.com>
 <YKzidlzM6UCdzpA9@dhcp-128-65.nay.redhat.com>
 <20210526071108.GB2872@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526071108.GB2872@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,
On 05/26/21 at 03:11pm, Baoquan He wrote:
> On 05/25/21 at 07:41pm, Dave Young wrote:
> > Hi Baoquan,
> > > @@ -180,7 +191,7 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
> > >  
> > >  	CONFIG_SMP=n
> > >  
> > > -   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
> > > +   (If CONFIG_SMP=y, then specify nr_cpus=1 on the kernel command line
> > >     when loading the dump-capture kernel, see section "Load the Dump-capture
> > >     Kernel".)
> > 
> > This part should be obsolete?  Since for X86_64 we can enable smp boot
> > with disable_cpu_apicid=X set (see the Notes on loading the dump-capture
> > kernel part)  So I think no need to disable CONFIG_SMP at all.  The
> > current RHEL use of nr_cpus=1 is just to save 2nd kernel memory use.
> 
> Keeping them because they are not wrong. Talking about default config,
> currently we only care about x86_64 mostly, not sure if we should remove
> i386 part too. Anyway, I am fine to remove them and the below
> relocatable thing.

I also agree it is not wrong :)  But I personally think the doc should
target for the most common use cases.  If CONFIG_SMP=n is not common
then we may just describe the default words for CONFIG_SMP=y,  and we
may add some words for exection cases

for example:
Specify nr_cpus=1 blabla
Note: if CONFIG_SMP is not set then nr_cpus=1 is not needed ...


> 
> > 
> > Ditto for the text for other arches, not sure if they need update
> > though, see if other maintainers can provide inputs..
> > 
> > 
> > Otherwise for the CONFIG_RELOCATABLE related part,  it may be better to
> > update as well? 
> > ''' quote:
> > 3) If one wants to build and use a relocatable kernel,
> >    Enable "Build a relocatable kernel" support under "Processor type and
> >    features"::
> > 
> >         CONFIG_RELOCATABLE=y
> > 
> > 4) Use a suitable value for "Physical address where the kernel is
> >    loaded" (under "Processor type and features"). This only appears when
> >    "kernel crash dumps" is enabled. A suitable value depends upon
> >    whether kernel is relocatable or not.
> > 
> >    If you are using a relocatable kernel use CONFIG_PHYSICAL_START=0x100000
> >    This will compile the kernel for physical address 1MB, but given the fact
> >    kernel is relocatable, it can be run from any physical address hence
> >    kexec boot loader will load it in memory region reserved for dump-capture
> >    kernel.
> > 
> >    Otherwise it should be the start of memory region reserved for
> >    second kernel using boot parameter "crashkernel=Y@X". Here X is
> >    start of memory region reserved for dump-capture kernel.
> >    Generally X is 16MB (0x1000000). So you can set
> >    CONFIG_PHYSICAL_START=0x1000000
> > ''' end quote
> > 
> > Since relocatable kernel is used by default now so we may just not describe it as "If one
> > want to build with it =y", I feel it should be a corner case instead of
> > the default use case.   Maybe HPA, Vivek, Eric can provide more opinions since
> > they may know more about the background.  
> > 
> > >  
> ...  
> > > -Boot into System Kernel
> > > -=======================
> > > +       crashkernel=512M-2G:64M,2G-:128M
> > >  
> > > +   This would mean:
> > > +
> > > +       1) if the RAM is smaller than 512M, then don't reserve anything
> > > +          (this is the "rescue" case)
> > > +       2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> > > +       3) if the RAM size is larger than 2G, then reserve 128M
> > > +
> > > +3) crashkernel=size,high and crashkernel=size,low
> > > +
> > > +   If memory above 4G is preferred, crashkernel=size,high can be used to
> > > +   fulfill that. With it, physical memory is allowed to allocate from top,
> > > +   so could be above 4G if system has more than 4G RAM installed. Otherwise,
> > > +   memory region will be allocated below 4G if available.
> > > +
> > > +   When crashkernel=X,high is passed, kernel could allocate physical memory
> > > +   region above 4G, low memory under 4G is needed in this case. There are
> > > +   three ways to get low memory:
> > > +
> > > +      1) Kernel will allocate at least 256M memory below 4G automatically
> > > +         if crashkernel=Y,low is not specified.
> > > +      2) Let user specify low memory size instread.
> > > +      3) Specified value 0 will disable low memory allocation::
> > > +
> > > +            crashkernel=0,low
> > > +
> > > +Boot into System Kernel
> > > +-----------------------
> > >  1) Update the boot loader (such as grub, yaboot, or lilo) configuration
> > >     files as necessary.
> > >  
> > > -2) Boot the system kernel with the boot parameter "crashkernel=Y@X",
> > > -   where Y specifies how much memory to reserve for the dump-capture kernel
> > > -   and X specifies the beginning of this reserved memory. For example,
> > > -   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
> > > -   starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
> > > +2) Boot the system kernel with the boot parameter "crashkernel=Y@X".
> > >  
> > >     On x86 and x86_64, use "crashkernel=64M@16M".
> > 
> > For the recommendation of crashkernel it would be better to drop the
> > @16M since most people do not need it?
> 
> It's only an example? Change it as "crashkernel=128M" instead to make it
> more helpful?

Hmm, it would be better to make the most common use case in default
example, and put the corner cases on corner :)

> 
> > 
> > >  
> > > @@ -392,7 +432,7 @@ loading dump-capture kernel.
> > >  
> > >  For i386, x86_64 and ia64:
> > >  
> > > -	"1 irqpoll maxcpus=1 reset_devices"
> > > +	"1 irqpoll nr_cpus=1 reset_devices"
> > >  
> > >  For ppc64:
> > >  
> > > @@ -400,7 +440,7 @@ For ppc64:
> > >  
> > >  For s390x:
> > >  
> > > -	"1 maxcpus=1 cgroup_disable=memory"
> > > +	"1 nr_cpus=1 cgroup_disable=memory"
> > >  
> > >  For arm:
> > >  
> > > @@ -408,7 +448,7 @@ For arm:
> > >  
> > >  For arm64:
> > >  
> > > -	"1 maxcpus=1 reset_devices"
> > > +	"1 nr_cpus=1 reset_devices"
> > >  
> > >  Notes on loading the dump-capture kernel:
> > >  
> > > @@ -487,7 +527,12 @@ After the dump-capture kernel is booted, write out the dump file with
> > >  the following command::
> > >  
> > >     cp /proc/vmcore <dump-file>
> > > +   scp /proc/vmcore to <user@server>:<path>/%HOST-%DATE/
> > > +
> > > +You can also use makedumpfile utility to write out the dump file
> > > +with specified options to filter out unwanted contents, e.g::
> > >  
> > > +   core_collector makedumpfile -l --message-level 1 -d 31
> > 
> > Looks like scp and core_collector usage are based on Fedora/RHEL, but
> > since this doc is for generic upstream, it might be better to describe
> > it in generic way, eg.  (maybe just drop scp)
> >   makedumpfile -l --message-level 1 -d 31 /proc/vmcore <dump-file>
> >   scp /proc/vmcore <user@server>:<path>/<dump-file>
> 
> Right, forgot removing core_collector. While scp is also a generic tool?

scp is good to have, just it is similar to cp, as these are just
examples I'm fine for either.

If taking scp then just drop the " to" and %HOST_%DATE/  etc.

> 
> Thanks for reviewing.
> 

Thanks
Dave

