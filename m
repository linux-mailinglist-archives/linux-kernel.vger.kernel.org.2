Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01E339235
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCLPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232311AbhCLPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615564117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvDHhjhApUIGkxAldXJIyTxY9YDcb/M12Kv81Sgxp0k=;
        b=KSvvj66B0F0UmX4/dagzxliH/V9y46e0E77lUkS7sGmFveV04xtJnWITD0QTILv9y4llfE
        XWOwm60T9ZDbwss5s1ja7yI5ipg3e9FNA+5iUcRv2XXoSrTMCEJE9oPIq0NXQbKMdeVK2x
        9MX+TNdFms/iYiBKkLx3yC+SdUWYMzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-L5H8X6_8ONWGSZHGuZ-8jA-1; Fri, 12 Mar 2021 10:48:33 -0500
X-MC-Unique: L5H8X6_8ONWGSZHGuZ-8jA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 083C99252F;
        Fri, 12 Mar 2021 15:48:32 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED217196E3;
        Fri, 12 Mar 2021 15:48:29 +0000 (UTC)
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liang, Liang (Leo)" <Liang.Liang@amd.com>
Cc:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
 <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b5faa9b9-6f40-f8e4-cf7c-795b429e02a8@redhat.com>
Date:   Fri, 12 Mar 2021 16:48:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 8G (with some carve out for the integrated GPU).
> [    0.044181] Memory: 6858688K/7200304K available (14345K kernel code, 9659K rwdata, 4980K rodata, 2484K init, 12292K bss, 341360K reserved, 0K cma-reserved)
> 
> Nothing particularly special about these systems that I am aware of.  I'll see if we can repro this issue on any other platforms, but so far, not one has noticed any problems.
> 
>>
>> Increasing the boot time from a few seconds to 2-3 minutes does not smell
>> like some corner case cache effects we might be hitting in this particular
>> instance - there have been minor reports that it either slightly increased or
>> slightly decreases initial system performance, but that was about it.
>>
>> Either, yet another latent BUG (but why? why should memory access
>> suddenly be that slow? I could only guess that we are now making sooner
>> use of very slow memory), or there is really something else weird going on.
> 
> Looks like pretty much everything is slower based on the timestamps in the dmesg output.  There is a big jump here:

If we're really dealing with some specific slow memory regions and that 
memory gets allocated for something that gets used regularly, then we 
might get a general slowdown. Hard to identify, though :)

> 
>> [    3.758596] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
>> [    3.759372] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
>> [   16.177983] ACPI: 13 ACPI AML tables successfully acquired and loaded
>> [   17.099316] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>> [   18.969959] ACPI: EC: EC started
> 
> And here:
> 
>> [   36.566608] PCI: CLS 64 bytes, default 64
>> [   36.575383] Trying to unpack rootfs image as initramfs...
>> [   44.594348] Initramfs unpacking failed: Decoding failed
>> [   44.765141] Freeing initrd memory: 46348K
> 
> Also seeing soft lockups:
>> [  124.588634] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [swapper/1:0]

Yes, I noticed that -- there is a heavy slowdown somewhere.

As that patch is v5.10 already (and we're close to v5.12) I assume 
something is particularly weird about the platform you are running on - 
because this is the first time I see a report like that.

-- 
Thanks,

David / dhildenb

