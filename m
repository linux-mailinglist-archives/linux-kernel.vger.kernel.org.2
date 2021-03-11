Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2833795B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCKQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233710AbhCKQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRJOqyfDaUlicETbZC6GzKoFoUyCtPY6jEDl336fEOc=;
        b=ghhA4gy94rDyBnhRWpGN9/puLp/kDc9W6OmKimw2w2dGuQP/G+JxPFjUF0GvsptDx1urzd
        I2FcpJqYIxb91H2L1e0qYDe0GygIDu1zO+JZPbokt8tjJ8GspuR3ktNuEDwFPJFBa3fKau
        f/hMPNbCROaOU2Y9gotQWAe7zWqo7Bk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-RFti_eNzP8i70OFniEU0SA-1; Thu, 11 Mar 2021 11:29:39 -0500
X-MC-Unique: RFti_eNzP8i70OFniEU0SA-1
Received: by mail-wr1-f72.google.com with SMTP id p12so7171998wrn.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kRJOqyfDaUlicETbZC6GzKoFoUyCtPY6jEDl336fEOc=;
        b=ZfwUZZHK+TyuHlLfwSTD7lwMXhDnvojr0OfZm0zdSaO4roh0bf7K84cE6H99Quw/4B
         nvTLd1wrwMhHvLoV5MFVSf0rH5ZdgkVWQH8Q7b3RB03mP1v2P6eoyyaEZDLhB7HMVW0j
         YPddmSUFRlgrNLFTzahyUETWgjIDQktVxYGTp/7hc0RwRop3gRHbsnuc08lIyyfVrMLr
         10yspH8ClsHO6j4oZ7esELfbZdRk/hO2AHumtmIPceF1dQbW4VcqgR2niOdZdmjteWsS
         b/rnt36FbVpvM3si3f2Z3lyPP7bI4aNgzezldj20/Wz6yzQKdOXMPVvucs2lWnzBtVx6
         rbVQ==
X-Gm-Message-State: AOAM531vlqXjauPvXm4xqNVXzzrENtAh43zwbQ++QiBUrqfv5fdO0+lS
        ssy6YnXPi6eydjsYqv9NwbTQ87spTXDQuGtTqFbdCyutYt/RnnoDO45/BO5MELzn6wBD/k7MIRo
        pE64jPg0m6gI3g2ky9piLnS0M
X-Received: by 2002:a1c:22c2:: with SMTP id i185mr9007783wmi.99.1615480178189;
        Thu, 11 Mar 2021 08:29:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEFHHV6ROfRyeJhcfcGGw38UajN0mcbhcLEwuXT8dr51uqlFAl5VOj4+hNEHVIYMJCOM7V5w==
X-Received: by 2002:a1c:22c2:: with SMTP id i185mr9007767wmi.99.1615480178025;
        Thu, 11 Mar 2021 08:29:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x13sm4522105wrt.75.2021.03.11.08.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 08:29:37 -0800 (PST)
To:     Tobin Feldman-Fitzthum <tobin@linux.ibm.com>, natet@google.com
Cc:     Dov Murik <dovmurik@linux.vnet.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, seanjc@google.com, rientjes@google.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Laszlo Ersek <lersek@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>
References: <20210224085915.28751-1-natet@google.com>
 <7829472d-741c-1057-c61f-321fcfb5bdcd@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
Message-ID: <35dde628-f1a8-c3bf-9c7d-7789166b0ee1@redhat.com>
Date:   Thu, 11 Mar 2021 17:29:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7829472d-741c-1057-c61f-321fcfb5bdcd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/21 16:30, Tobin Feldman-Fitzthum wrote:
> I am not sure how the mirror VM will be supported in QEMU. Usually there 
> is one QEMU process per-vm. Now we would need to run a second VM and 
> communicate with it during migration. Is there a way to do this without 
> adding significant complexity?

I can answer this part.  I think this will actually be simpler than with 
auxiliary vCPUs.  There will be a separate pair of VM+vCPU file 
descriptors within the same QEMU process, and some code to set up the 
memory map using KVM_SET_USER_MEMORY_REGION.

However, the code to run this VM will be very small as the VM does not 
have to do MMIO, interrupts, live migration (of itself), etc.  It just 
starts up and communicates with QEMU using a mailbox at a predetermined 
address.

I also think (but I'm not 100% sure) that the auxiliary VM does not have 
to watch changes in the primary VM's memory map (e.g. mapping and 
unmapping of BARs).  In QEMU terms, the auxiliary VM's memory map tracks 
RAMBlocks, not MemoryRegions, which makes things much simpler.

There are already many examples of mini VMMs running special purpose VMs 
in the kernel's tools/testing/selftests/kvm directory, and I don't think 
the QEMU code would be any more complex than that.

Paolo

