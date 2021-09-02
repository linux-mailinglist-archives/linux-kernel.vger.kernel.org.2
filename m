Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E633FEA41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbhIBHxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233393AbhIBHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630569140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1zrtN+htQP7xr1Bqb6rRmQLPOtg+BqgHIFdnhiJS+g=;
        b=QB6wmSoZ4t2UuYG5YXEFwp7e78fM30uiqGOjpGN3YNg7RUqBhoO7LCa5rXpamydP9Ik9c3
        luXD+0smP5zlpmYJLumzs71+XUVXKCC4wdw7Cp0qZ7gOjPeog1aLjv2FUQWGZgfaEFJ0tC
        eKmPdzeJLACp/PpEgsLziZbmAT7F8rU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-sIr6--_uO_qBBEJphlmX9g-1; Thu, 02 Sep 2021 03:52:19 -0400
X-MC-Unique: sIr6--_uO_qBBEJphlmX9g-1
Received: by mail-wm1-f71.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so380431wmr.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 00:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v1zrtN+htQP7xr1Bqb6rRmQLPOtg+BqgHIFdnhiJS+g=;
        b=jAazVbGySku4mXoRnb3xa3vY/a6iHlf7uGx8AjC0gUDnfkPBBf0YGLsmz958Uf+Z1Y
         SmWw3XMbE1fhWiRW+RFpt8jlb8jT+p5SGjebdyfIVxoMid4Ktws+98BWJwhR4b7vfQbG
         8oQkv05Tkuq+RF1Z6PnAMOOOg4+6jsZ6t4aJicoFfhFIcHTBoc6DYgTfDTkuzLhOcwi1
         mcbQ/3SyoknScMdpdIh2qEKnnYQmxgKIw5pd7ZLfFhQTVNErgAC49IXNlMwlrPSdBhYq
         AAf2rXzN7kRApzLci2DXtfo/9SB0XUH8DMo3kIn+iIYYrEXZrdjwLegKrV7D7fTcVlQT
         5y9w==
X-Gm-Message-State: AOAM532F1IFwXyuKbz+qRRgBl0phX/YbSHlANpP90U4zjXEb+rSOOFlq
        Sk21F0ts/R/rqaNGwsFc79cqAg4XhBoisN9ncJqcAc6x160+AUpbErIKjR2Z6ZSEpL7JUeNurNq
        aZGoiva/94YrE20z9c9dHECc8j82pFFwWT6R2ejl3ML9P82hTxeBwyT/6aUb5UR7MkkOOlhpV
X-Received: by 2002:a1c:3b05:: with SMTP id i5mr1749509wma.136.1630569138050;
        Thu, 02 Sep 2021 00:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmkx/MuN7lj3Eng3z3BIUvPWKZxoUQY7JSreotQt1UFStf7tIp9soH19O3T/A5w857FLpAlg==
X-Received: by 2002:a1c:3b05:: with SMTP id i5mr1749484wma.136.1630569137743;
        Thu, 02 Sep 2021 00:52:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60bd.dip0.t-ipconnect.de. [91.12.96.189])
        by smtp.gmail.com with ESMTPSA id b10sm1075585wrt.43.2021.09.02.00.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 00:52:17 -0700 (PDT)
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210831202141.13846-1-david@redhat.com>
 <20210831202141.13846-2-david@redhat.com>
 <16141669368a89f8304b1777094e982942d51bba.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/3] kernel/resource: clean up and optimize
 iomem_is_exclusive()
Message-ID: <22be7bd0-3f67-0e9c-87d4-1ec2c184cc6a@redhat.com>
Date:   Thu, 2 Sep 2021 09:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <16141669368a89f8304b1777094e982942d51bba.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 21:43, Williams, Dan J wrote:
> On Tue, 2021-08-31 at 22:21 +0200, David Hildenbrand wrote:
>> We end up traversing subtrees of ranges we are not interested in; let's
>> optimize this case, skipping such subtrees, cleaning up the function a bit.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   kernel/resource.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> That diffstat does not come across as "cleanup", and the skip_children
> flag changing values mid-iteration feels tricky. Is there a win here,
> the same number of entries still need to be accessed, right?

Right, most of the patch changes falls under "optimize". The cleanup is 
using for_each_resource() and not using r_next(NULL, p, &l). Sure, I 
could have split this up but then I'd just introduce for_each_resource() 
to modify it immediately again.


Let's take a look at /proc/iomem on my notebook:

00000000-00000fff : Reserved
00001000-00057fff : System RAM
00058000-00058fff : Reserved
00059000-0009cfff : System RAM
0009d000-000fffff : Reserved
   000a0000-000bffff : PCI Bus 0000:00
   000c0000-000c3fff : PCI Bus 0000:00
   000c4000-000c7fff : PCI Bus 0000:00
   000c8000-000cbfff : PCI Bus 0000:00
   000cc000-000cffff : PCI Bus 0000:00
   000d0000-000d3fff : PCI Bus 0000:00
   000d4000-000d7fff : PCI Bus 0000:00
   000d8000-000dbfff : PCI Bus 0000:00
   000dc000-000dffff : PCI Bus 0000:00
   000e0000-000e3fff : PCI Bus 0000:00
   000e4000-000e7fff : PCI Bus 0000:00
   000e8000-000ebfff : PCI Bus 0000:00
   000ec000-000effff : PCI Bus 0000:00
   000f0000-000fffff : PCI Bus 0000:00
     000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
40000000-403fffff : Reserved
   40000000-403fffff : pnp 00:00
40400000-80a79fff : System RAM
...

Why should we take a look at any children of "0009d000-000fffff : 
Reserved" if we can just skip these 15 items directly because the parent 
range is not of interest?


It gets even worse for some PCI buses:

8f800000-f7ffffff : PCI Bus 0000:00
   8f800000-8f9fffff : PCI Bus 0000:01
   8fa00000-8fbfffff : PCI Bus 0000:01
   90000000-b1ffffff : PCI Bus 0000:04
     90000000-b1ffffff : PCI Bus 0000:05
       90000000-b1ffffff : PCI Bus 0000:07
         90000000-b1ffffff : PCI Bus 0000:08
           90000000-b1ffffff : PCI Bus 0000:0d
   c0000000-cfffffff : 0000:00:02.0
   d0000000-e60fffff : PCI Bus 0000:04
     d0000000-e60fffff : PCI Bus 0000:05
       d0000000-e5efffff : PCI Bus 0000:07
         d0000000-e5efffff : PCI Bus 0000:08
           d0000000-d00fffff : PCI Bus 0000:09
           d0000000-d000ffff : 0000:09:00.0
           d0000000-d000ffff : xhci-hcd
           d0010000-d0010fff : 0000:09:00.0
           d0011000-d0011fff : 0000:09:00.0
           d0100000-d01fffff : PCI Bus 0000:0b
           d0100000-d010ffff : 0000:0b:00.0
           d0100000-d010ffff : xhci-hcd
           d0110000-d0110fff : 0000:0b:00.0
           d0111000-d0111fff : 0000:0b:00.0
           d0200000-e5efffff : PCI Bus 0000:0d
       e5f00000-e5ffffff : PCI Bus 0000:3c
         e5f00000-e5f0ffff : 0000:3c:00.0
           e5f00000-e5f0ffff : xhci-hcd
       e6000000-e60fffff : PCI Bus 0000:06
         e6000000-e603ffff : 0000:06:00.0
           e6000000-e603ffff : thunderbolt
         e6040000-e6040fff : 0000:06:00.0
   e7000000-e7ffffff : 0000:00:02.0
   e8000000-e80fffff : PCI Bus 0000:3e
     e8000000-e8003fff : 0000:3e:00.0
       e8000000-e8003fff : nvme
   e8100000-e81fffff : PCI Bus 0000:3d
     e8100000-e8101fff : 0000:3d:00.0
       e8100000-e8101fff : iwlwifi
   e8200000-e821ffff : 0000:00:1f.6
     e8200000-e821ffff : e1000e
   e8220000-e822ffff : 0000:00:14.0
     e8220000-e822ffff : xhci-hcd
       e8228070-e822846f : intel_xhci_usb_sw
   e8230000-e823ffff : 0000:00:1f.3
     e8230000-e823ffff : ICH HD audio
   e8240000-e8247fff : 0000:00:04.0
     e8240000-e8247fff : proc_thermal
   e8248000-e824bfff : 0000:00:1f.3
     e8248000-e824bfff : ICH HD audio
   e824c000-e824ffff : 0000:00:1f.2
   e8250000-e8250fff : 0000:00:08.0
   e8251000-e8251fff : 0000:00:14.2
     e8251000-e8251fff : Intel PCH thermal driver
   e8252000-e8252fff : 0000:00:15.0
     e8252000-e82521ff : lpss_dev
       e8252000-e82521ff : i2c_designware.0 lpss_dev
     e8252200-e82522ff : lpss_priv
     e8252800-e8252fff : idma64.0
       e8252800-e8252fff : idma64.0 idma64.0
   e8253000-e8253fff : 0000:00:16.0
     e8253000-e8253fff : mei_me
   e8254000-e82540ff : 0000:00:1f.4
   f7fe0000-f7ffffff : pnp 00:08
     f7fe0000-f7ffffff : pnp 00:0a

I didn't count how many entries these are, but it's certainly more 
entries in that subtree than I have directly under the root, meaning in 
my setup we end up looking at at least 50% less entries (actually, much 
more).

> 
> BTW, I had to pull this from lore to reply to it, looks like the
> intended Cc's were missing?

Yes, I messed up this time, sorry -- I forgot "--cover-cc" w ... I will 
resend the patches so everybody has them without going trough extra trouble.


-- 
Thanks,

David / dhildenb

