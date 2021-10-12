Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B242AE86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhJLVNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234787AbhJLVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634073110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HJGSIN2xKq0W1I1KYpa25UxJU8ELuu6VCKra+BOIUC4=;
        b=LozTO0x8eC7hISiP/9Tg7YCND6Z/xzW/3Ws0dnRSkVid3xgKASFARsdWT6bn3VJBWP78Fq
        b0BE/cxgIVU3vrNndntiROmsay6/8XHl3hi79BG/Z32dtdbe41pfh+klh7ydTeqh/gYVWC
        MbqEfrd5Y3Ea4yp1Sheds8prrptTTro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-uhR1v-B8O02VRsA7tbCLqw-1; Tue, 12 Oct 2021 17:11:49 -0400
X-MC-Unique: uhR1v-B8O02VRsA7tbCLqw-1
Received: by mail-wr1-f71.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso298710wri.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HJGSIN2xKq0W1I1KYpa25UxJU8ELuu6VCKra+BOIUC4=;
        b=n/dqNIF4CqpLXOGrt9RrFV6twBiry1dM96X/M4iLRRPbKYsW7hj8aKqUsa1RNseZLC
         IIGc54Bc2S8whbJSbQgwEyw5i5HdD7czb4ikA5Le+/U9Rnh4Rz393eexXY/567XWx2oA
         4BjnbzJ4379vZ9uMZjtBWD1y007cvtBahmBnkHam32MU6zfUAg/bNriK30DoafQlaW5C
         TwwDEE/QhBWc+5J+BkolJQnhBF7EMD8wHwmkE7yeWyjqq4RcQsCOf82Fhr7qUrb4J/CZ
         7Y5Q2KYnTdCGfIynHuEQzIGLVZTv7tU/6Qsio+VztStWNBXJedMwtAmw3Op4zer4UtAi
         xBzg==
X-Gm-Message-State: AOAM533Mnxwbw1xPtET3t+HPR5/lvluZlIBi8txx+4JHZsilXlvt26jg
        WIjWWbN+TlJ2E6PKslW6jQ4/ReDGwWGLmgz7IUb9JYVPhkBVG0iIMLRGRvYFj86MlZsqRHiCpqt
        Jt3rC2AKTXT2VMJbrYSCWvdaa
X-Received: by 2002:adf:a78a:: with SMTP id j10mr35380814wrc.231.1634073108396;
        Tue, 12 Oct 2021 14:11:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpVXZ8CwRxxdc3jOF9zqv7UA5V/rSW0PqfcHy6Y1h8eiycZBeLZrenWoni8OECj28KdQIXIQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr35380772wrc.231.1634073108176;
        Tue, 12 Oct 2021 14:11:48 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id s3sm11456516wrm.40.2021.10.12.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:11:47 -0700 (PDT)
Date:   Tue, 12 Oct 2021 17:11:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211012171016-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> > others) in init functions that also register drivers (thanks Elena for
> > the number)
> 
> To provide more numbers on this. What I can see so far from a smatch-based
> analysis, we have 409 __init style functions (.probe & builtin/module_
> _platform_driver_probe excluded) for 5.15 with allyesconfig.

I don't think we care about allyesconfig at all though.
Just don't do that.
How about allmodconfig? This is closer to what distros actually do.

-- 
MST

