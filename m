Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E30336B50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhCKFFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCKFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:04:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60497C061574;
        Wed, 10 Mar 2021 21:04:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gb6so2863860pjb.0;
        Wed, 10 Mar 2021 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eayOjb0KZ31qj1N8PdToC+xRVUBfCHUPI3Znks8WR0k=;
        b=IL1N7vM7p9PzFcfpvhgRRMuOzhmjBlfibWkIcOQbYlGbPOJMnLhIzjCy8LxBaJ8EGU
         KJjjEgkbLtjbaD4sqhZ1ochG6cVFghEOlubEd7dsbfPijX8lC9eVqiLaeiTO3VXqhE5j
         YprOjLc8isTrNz1yxLNXa7sz1Bhn0z1t0w+HJ0pPJUXLLao5DKoPWk0aWURYin4FB6OE
         oTFCyRJLtkVFf3JLLGhSJTXk7wLVT433snzVLTFp5sM2sqXb87myqAsWS9pqaTfVDExL
         f+ojkMFllNvYboAo4xsrXYacF/clYDZcJc779Ph0MFvl0b3brsNawqyYAhHoxSZKsU/v
         mTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eayOjb0KZ31qj1N8PdToC+xRVUBfCHUPI3Znks8WR0k=;
        b=I4ncpXqV/XpjiiQX8IYi4CdCJYg6u+UUQki2biO5+yUXOx5pSccehVOvYteAU7kgvO
         aEz0lt88Vk4KIKxJ5zDKqpLIciJi5uPu5GR3buuyhQV8zIcRdgijb2GEWieTTtSs3Zub
         rypbB6ssKgGZzIZsFCgmlsYU62nWJtiK+IGBetFjhq89XC7uXm75dqM0xz37Mm1d69m9
         YhWJOpbRZ84zKZRIbM8pOyFf7da7xZtOt81fRhpqtJZxiGyu4sVty/PHWBTrtPY7Ruk+
         bdp39KdOqWlf/t7YipSwzanbBPt42sAHCDjktRdJVFJ4vWGlU3Y0pD/1/rApYYwARwG/
         mJtA==
X-Gm-Message-State: AOAM5305GSU6tBYodjwZeMnZCExazBP9c0XsWNtgHEJRXqCF5MOwOHIa
        lP5XWPIYl0T89/k8YGw6x90=
X-Google-Smtp-Source: ABdhPJzomvd6XDgwv/fL+vlX+FLEQgGyCWkzPbL90UL/BQndPGhzKH0Q4L/hjqK/fMjpcf3zxKU3vg==
X-Received: by 2002:a17:90a:a403:: with SMTP id y3mr7078020pjp.227.1615439087609;
        Wed, 10 Mar 2021 21:04:47 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y2sm979638pgf.7.2021.03.10.21.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 21:04:47 -0800 (PST)
Subject: Re: [PATCH v4 13/14] dt-bindings: of: Add restricted DMA pool
To:     Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Claire Chang <tientzu@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Grant Likely <grant.likely@arm.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Thierry Reding <treding@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <20210209062131.2300005-14-tientzu@chromium.org>
 <20210310160747.GA29834@willie-the-truck>
 <CAL_JsqJE6A4awYCvqzw3qk2uAJEKgkSOKbk9tPaMKup8zes8cA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a5a684fe-5ed0-a12f-22ca-a8ba46124341@gmail.com>
Date:   Wed, 10 Mar 2021 21:04:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJE6A4awYCvqzw3qk2uAJEKgkSOKbk9tPaMKup8zes8cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2021 1:40 PM, Rob Herring wrote:
> On Wed, Mar 10, 2021 at 9:08 AM Will Deacon <will@kernel.org> wrote:
>>
>> Hi Claire,
>>
>> On Tue, Feb 09, 2021 at 02:21:30PM +0800, Claire Chang wrote:
>>> Introduce the new compatible string, restricted-dma-pool, for restricted
>>> DMA. One can specify the address and length of the restricted DMA memory
>>> region by restricted-dma-pool in the reserved-memory node.
>>>
>>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>>> ---
>>>  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>> index e8d3096d922c..fc9a12c2f679 100644
>>> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>> @@ -51,6 +51,20 @@ compatible (optional) - standard definition
>>>            used as a shared pool of DMA buffers for a set of devices. It can
>>>            be used by an operating system to instantiate the necessary pool
>>>            management subsystem if necessary.
>>> +        - restricted-dma-pool: This indicates a region of memory meant to be
>>> +          used as a pool of restricted DMA buffers for a set of devices. The
>>> +          memory region would be the only region accessible to those devices.
>>> +          When using this, the no-map and reusable properties must not be set,
>>> +          so the operating system can create a virtual mapping that will be used
>>> +          for synchronization. The main purpose for restricted DMA is to
>>> +          mitigate the lack of DMA access control on systems without an IOMMU,
>>> +          which could result in the DMA accessing the system memory at
>>> +          unexpected times and/or unexpected addresses, possibly leading to data
>>> +          leakage or corruption. The feature on its own provides a basic level
>>> +          of protection against the DMA overwriting buffer contents at
>>> +          unexpected times. However, to protect against general data leakage and
>>> +          system memory corruption, the system needs to provide way to lock down
>>> +          the memory access, e.g., MPU.
>>
>> As far as I can tell, these pools work with both static allocations (which
>> seem to match your use-case where firmware has preconfigured the DMA ranges)
>> but also with dynamic allocations where a 'size' property is present instead
>> of the 'reg' property and the kernel is responsible for allocating the
>> reservation during boot. Am I right and, if so, is that deliberate?
> 
> I believe so. I'm not keen on having size only reservations in DT.
> Yes, we allowed that already, but that's back from the days of needing
> large CMA carveouts to be reserved early in boot. I've read that the
> kernel is much better now at contiguous allocations, so do we really
> need this in DT anymore?

I would say yes, there can be a number of times where you want to semi
statically partition your physical memory and their reserved regions. Be
it to pack everything together under the same protection rules or
because you need to allocate memory from a particular address range in
say a non-uniform memory controller architecture where address windows
have different scheduling algorithms.
-- 
Florian
