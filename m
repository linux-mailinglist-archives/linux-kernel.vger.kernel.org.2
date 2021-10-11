Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6374296EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhJKSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234540AbhJKSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633976940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G16gwMe6+CYnKg8tN/Sjy4s4dxSh+B0vWdkeXZ6WaCc=;
        b=Zl6EWmCQoR9O8W46q+A4dRrfHiQTShQFOTcz0tY7PrUuWMyL44KiH19MEOzhf5AxCgzXXQ
        SjoZZuDstLs8pcIf19wDm7AJ7RkABwi6eCGPySFC8DSvEZ0PkUoHx0WxvmuSY1rVjOlvZt
        mpSnNvhZtphISW5C+2iehx2nqi4Iztw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-GZXhh79cNIea5MFWyrWf-Q-1; Mon, 11 Oct 2021 14:28:59 -0400
X-MC-Unique: GZXhh79cNIea5MFWyrWf-Q-1
Received: by mail-ed1-f70.google.com with SMTP id e14-20020a056402088e00b003db6ebb9526so7038630edy.22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G16gwMe6+CYnKg8tN/Sjy4s4dxSh+B0vWdkeXZ6WaCc=;
        b=VA+PAHr/hEJC4eJhaty6huN4v2vKJtdc84roUthCGvMjrW9D6o/xm3Hd7l7lYFOVMj
         nxW5WowRw7hGcvMc9atPoID06CAX2N3K1oGc4LTtOwg0u6gszSJho91DOfjUkqV4BXHg
         0Q0lRrJ6rw0FwyPKpXni9HbHyP/sxUtbgXpAQYH1+I6iUGh9oNSR+1fr4A6xh9u4cfaV
         kGbh3NbVx76AYhCSy/BJxRutw80RkxzMSEMVizWFUBbTC/9bKDFMvbMULT6rxnvToojC
         sgPcQMyaugtQyxZicwscAn4Yap+ZUTZTbaQyEqP3Z3hPV0JeKSY0ktCEB2oDSQu0aeG4
         OjJQ==
X-Gm-Message-State: AOAM5311lQGOeRqha/0wJwAcNtAuVRLBkJCE5DVedrJIy5RF3bZ1W7fD
        vd5jrAzDsdDT9VR9x+9/UOkMSm/4zklnJ2HiSEbG4gOcG1WAgHS0QO/Jv+W6zCGAerK+jlhGrcV
        O14hCoVMX6GT4EJDodX5S0eC8
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr29341715ejb.5.1633976938261;
        Mon, 11 Oct 2021 11:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJs31ZBNnkMDy6Y3/bA4NkSUevwMmxI5GLaEsaPOhFcbZtCu9lTE6tYoeFaMp5H2duksbEGQ==
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr29341674ejb.5.1633976938096;
        Mon, 11 Oct 2021 11:28:58 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id w11sm4722003edl.87.2021.10.11.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:28:57 -0700 (PDT)
Date:   Mon, 11 Oct 2021 14:28:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
Message-ID: <20211011142330-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
 <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:35:18AM -0700, Andi Kleen wrote:
> 
> > Presumably bios code is in arch/x86 and drivers/acpi, right?
> > Up to 200 calls the majority of which is likely private ...
> 
> Yes.
> 
> > I don't have better ideas but the current setup will just
> > result in people making their guests vulnerable whenever they
> > want to allow device pass-through.
> 
> 
> Yes that's true. For current TDX our target is virtual devices only. But if
> pass through usage will be really wide spread we may need to revisit.
> 
> 
> -Andi

I mean ... it's already wide spread. If we support it with TDX
it will be used with TDX. If we don't then I guess it won't,
exposing this kind of limitation in a userspace visible way isn't great
though. I guess it boils down to the fact that
ioremap_host_shared is just not a great interface, users simply
have no idea whether a given driver uses ioremap.

-- 
MST

