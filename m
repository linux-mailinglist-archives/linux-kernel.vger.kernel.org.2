Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9438739AFFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhFDBrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhFDBry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:47:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EF49613FF;
        Fri,  4 Jun 2021 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622771168;
        bh=Lpi5gmvDUTHrxYBJ0AOqlt011SOYDrHyNVmLe5HdGy8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZuyAvsMb4lFdlwmcPxUZP9zxROGdeedSPDV7yiU+Jdix88lBjlybEKKWTJfDEehta
         Laah6xJkGs+MM9Kdy93FpC6ZQKRoENJX3yqvv+deRKewPHTiDNpeTowmCsvqGdDBer
         bLab3XnKzHTMFLhlCXFOZehxjyeutpnEeVbkaGGSXBfQdtsMOYQdqK3PAmHSEauX5k
         iP31NEOcqDyeXWHpqrHeeRa3t123whXOsexrTWJZ2s83u7vVGdp3ikBbdpgcUXDOj2
         7CzUK19NjFOAGn65bgG0nIP8udLpMi6hnDBZ8Cc2Lc07rDrLkyaoOitruCGj6gcdhq
         wd09XZC21d/cw==
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
 <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
 <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <308e7187-1ea7-49a7-1083-84cf8654f52a@kernel.org>
Date:   Thu, 3 Jun 2021 18:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 4:32 PM, Andi Kleen wrote:
> 
>> We do not need an increasing pile of kludges
> 
> Do you mean disabling features is a kludge?
> 
> If yes I disagree with that characterization.
> 
> 
>> to make TDX and SEV “secure”.  We need the actual loaded driver to be
>> secure.  The virtio architecture is full of legacy nonsense,
>> and there is no good reason for SEV and TDX to be a giant special case.
> 
> I don't know where you see a "giant special case". Except for the
> limited feature negotiation all the changes are common, and the
> disabling of features (which is not new BTW, but already done e.g. with
> forcing DMA API in some cases) can be of course used by all these other
> technologies too. But it just cannot be done by default for everything
> because it would break compatibility. So every technology with such
> requirements has to explicitly opt-in.
> 
> 
>>
>> As I said before, real PCIe (Thunderbolt/USB-C or anything else) has
>> the exact same problem.  The fact that TDX has encrypted memory is, at
>> best, a poor proxy for the actual condition.  The actual condition is
>> that the host does not trust the device to implement the virtio
>> protocol correctly.
> 
> Right they can do similar limitations of feature sets. But again it
> cannot be default.

Let me try again.

For most Linux drivers, a report that a misbehaving device can corrupt
host memory is a bug, not a feature.  If a USB device can corrupt kernel
memory, that's a serious bug.  If a USB-C device can corrupt kernel
memory, that's also a serious bug, although, sadly, we probably have
lots of these bugs.  If a Firewire device can corrupt kernel memory,
news at 11.  If a Bluetooth or WiFi peer can corrupt kernel memory,
people write sonnets about it and give it clever names.  Why is virtio
special?

If, for some reason, the virtio driver cannot be fixed so that it is
secure and compatible [1], then I think that the limited cases that are
secure should be accessible to anyone, with or without TDX.  Have a
virtio.secure_mode module option or a udev-controllable parameter or an
alternative driver name or *something*.  An alternative driver name
would allow userspace to prevent the insecure mode from auto-binding to
devices.  And make whatever system configures encrypted guests for
security use this mode.  (Linux is not going to be magically secure just
by booting it in TDX.  There's a whole process of unsealing or remote
attestation, something needs to prevent the hypervisor from connecting a
virtual keyboard and typing init=/bin/bash, something needs to provision
an SSH key, etc.)

In my opinion, it is not so great to identify bugs in the driver and
then say that they're only being fixed for TDX and SEV.

Keep in mind that, as I understand it, there is nothing virt specific
about virtio.  There are real physical devices that speak virtio.

[1] The DMA quirk is nasty.  Fortunately, it's the only case I'm aware
of in which the virtio driver genuinely cannot be made secure and
compatible at the smae time.  Also, fortunately, most real deployments
except on powerpc work just fine with the DMA quirk unquirked.

> 
> 
>>
>>>
>>> TDX and SEV use the arch hook to enforce DMA API, so that part is also
>>> solved.
>>>
>> Can you point me to the code you’re referring to?
> 
> See 4/8 in this patch kit. It uses an existing hook which is already
> used in tree by s390.

This one:

int arch_has_restricted_virtio_memory_access(void)
+{
+	return is_tdx_guest();
+}

I'm looking at a fairly recent kernel, and I don't see anything for s390
wired up in vring_use_dma_api.

