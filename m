Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64558404836
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhIIKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:07:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44410 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhIIKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:07:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 659A722311;
        Thu,  9 Sep 2021 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631181985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6xcNsSwzzwbyGGDvll2fWt5jcnOiGP0/VGXDC81ybU=;
        b=egSsXmMxS0Lng80t5hWrpuqYO8ke0cUimwRjIz7N8b+Pwb8oRhzmPAPCFQPSCkr0n2bJVF
        4ftS5d0ekn7OI+6pa9LXHaDKIUcBuwXVWg4kmXj2lhLUgzRDuS+NY13XMmTa3VAoRXqDMU
        240jQYlBSwF//H42Krfv3HVFq05axq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631181985;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6xcNsSwzzwbyGGDvll2fWt5jcnOiGP0/VGXDC81ybU=;
        b=YNco0YwIrCMQC1axCJulfv2hohzGTnteG3SsFxQSMWxlxRdsq+1ApIe4V8iHn34TeN/mZM
        hfevW3Z1X82BBtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49B1813342;
        Thu,  9 Sep 2021 10:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kxG9EaHcOWHwLAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 09 Sep 2021 10:06:25 +0000
From:   Hannes Reinecke <hare@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <20210902092002.67614-1-dwagner@suse.de>
 <YTXKwOvCtJOHnhpu@infradead.org>
 <d63a15af-63a7-3fa0-1559-4518dee3a99a@suse.de>
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
Message-ID: <f211ac99-cddb-8515-e34f-a82a62e26d79@suse.de>
Date:   Thu, 9 Sep 2021 12:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d63a15af-63a7-3fa0-1559-4518dee3a99a@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 10:40 AM, Hannes Reinecke wrote:
> On 9/6/21 10:01 AM, Christoph Hellwig wrote:
>> On Thu, Sep 02, 2021 at 11:20:02AM +0200, Daniel Wagner wrote:
>>> When we remove the siblings entry, we update ns->head->list, hence we
>>> can't separate the removal and test for being empty. They have to be
>>> in the same critical section to avoid a race.
>>>
>>> To avoid breaking the refcounting imbalance again, add a list empty
>>> check to nvme_find_ns_head.
>>
>> Hannes, can you look over this and run your tests on it?
>>
> I'm at it.
> 
Finally. qemu being it's usual bitchy self.

But managed to test the patch, and all looks good.

For reference, the testcase is:

- Create qemu instance with two NVMe namespaces:
  -device pcie-root-port,id=rp80,bus=pcie.0,chassis=2,addr=8.0,\
   multifunction=on,pref64-reserve=32M \
  -device pcie-root-port,id=rp90,bus=pcie.0,chassis=3,addr=9.0,\
   multifunction=on,pref64-reserve=32M \
  -device nvme-subsys,id=nvme-subsys1,nqn=slesnvmesubsys-1 \
  -device nvme-subsys,id=nvme-subsys2,nqn=slesnvmesubsys-2 \
  -device nvme,bus=rp80,id=nvme-rp80,serial=SLESNVME2,\
   subsys=nvme-subsys1 \
  -device nvme-ns,id=nvme-ns-2,bus=nvme-rp80,drive=nvme-2 \
  -device nvme,bus=rp90,id=nvme-rp90,serial=SLESNVME3,\
   subsys=nvme-subsys2 \
  -device nvme-ns,id=nvme-ns-3,bus=nvme-rp90,drive=nvme-3

- Install the system, and create an MD RAID 1 on those namespaces.
- Enter qemu monitor, and detach one controller:
  device_del nvme-rp90
- Check in the OS that the device has been removed, and MD has
  registered the device failure:

# dmesg
[ 1801.076236] pcieport 0000:00:09.0: pciehp: Slot(0-2): Attention
button pressed
[ 1801.076251] pcieport 0000:00:09.0: pciehp: Slot(0-2): Powering off
due to button press
[ 1806.250017] block nvme2n1: no available path - failing I/O
[ 1806.250030] md: super_written gets error=-5
[ 1806.250036] md/raid1:md1: Disk failure on nvme2n1, disabling device.
               md/raid1:md1: Operation continuing on 1 devices.

- Enter qemu monitor, and re-attach the controller:
  device_add bus=rp90,id=nvme-rp90,serial=SLESNVME3,subsys=nvme-subsys2

- Check in the OS that the device has been reattached:
# dmesg
[ 1845.634613] pcieport 0000:00:09.0: pciehp: Slot(0-2): Attention
button pressed
[ 1845.634626] pcieport 0000:00:09.0: pciehp: Slot(0-2) Powering on due
to button press
[ 1845.634821] pcieport 0000:00:09.0: pciehp: Slot(0-2): Card present
[ 1845.634826] pcieport 0000:00:09.0: pciehp: Slot(0-2): Link Up
[ 1845.770969] pci 0000:03:00.0: [1b36:0010] type 00 class 0x010802
[ 1845.771307] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[ 1845.773503] pci 0000:03:00.0: BAR 0: assigned [mem
0xc1200000-0xc1203fff 64bit]
[ 1845.773646] pcieport 0000:00:09.0: PCI bridge to [bus 03]
[ 1845.773671] pcieport 0000:00:09.0:   bridge window [io  0x7000-0x7fff]
[ 1845.776926] pcieport 0000:00:09.0:   bridge window [mem
0xc1200000-0xc13fffff]
[ 1845.778816] pcieport 0000:00:09.0:   bridge window [mem
0x804000000-0x805ffffff 64bit pref]
[ 1845.783970] nvme nvme2: pci function 0000:03:00.0
[ 1845.784227] nvme 0000:03:00.0: enabling device (0000 -> 0002)
[ 1845.798918] nvme nvme2: 1/0/0 default/read/poll queues

- Reattach the namespace to the MD RAID:
# mdadm --manage /dev/md1 --re-add /dev/nvme2n1

- Check that everything worked:
# # cat /proc/mdstat
Personalities : [raid1]
md1 : active raid1 nvme2n1[1] nvme1n1[0]
      4189184 blocks super 1.2 [2/2] [UU]
      bitmap: 0/1 pages [0KB], 65536KB chunk

unused devices: <none>

So you can add:

Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
