Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4781131A59E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhBLTsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBLTsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:48:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF2764D79
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613159242;
        bh=BmIc8UmrBN0qpGXEF6i+dQhqy1Ntyp4pcVslG82HVm4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FWh9gC5bcTG4Gk5rDYUskS4SG3p4Inw3C2BZFTaZ+pYiYV5AQ2LPBTB2ElOAmiXbp
         Qm+Kp9fx2Dx89pF47Y9SEGx7V85/najwGQ20TVMuifYVcw2AtyfCquvISKzqdkQ1R/
         ccPxP+Su8kbhmB/h8eFNwANDByRtq2UEYZ2tlsxjpHXg2hRaC/hicFXEROoNRsrKEj
         XwJlAT+XH2AyqX1x0ZcdhTKRcmhoaOVtfDIbOx77xRmKYrUDbx2WAFIc6GaPFUBk/D
         u9NOSY8+S+NknnV52WQ/n2JF+xIgKHeT/iKA9inR8XJIiNXOk3Nfh9jEhautgPTHPI
         ryC1d9MfAbUXA==
Received: by mail-ej1-f51.google.com with SMTP id b9so959124ejy.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:47:22 -0800 (PST)
X-Gm-Message-State: AOAM530F+2vx0ypwkwdkUg0DX/4cp3ihe5yUkPcg9GioBWNGPJUTIY9A
        eQ0Pl4JG2ksW6hw9ZeiEetNfvI4aNgDLUeOkN0ciNw==
X-Google-Smtp-Source: ABdhPJzQBe4fNFR2I5n0XOe22kXAYBPM9/sVy7JT+BU+vAm+6Nz6xzLNd3gJvcNagfcXKSTdRfKxlBFI2F2NAZUNPuk=
X-Received: by 2002:a17:906:b0c7:: with SMTP id bk7mr4599904ejb.214.1613159241106;
 Fri, 12 Feb 2021 11:47:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com> <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 12 Feb 2021 11:47:09 -0800
X-Gmail-Original-Message-ID: <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
Message-ID: <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:39 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> The TDX module injects #VE exception to the guest TD in cases of
> disallowed instructions, disallowed MSR accesses and subset of CPUID
> leaves. Also, it's theoretically possible for CPU to inject #VE
> exception on EPT violation, but the TDX module makes sure this does
> not happen, as long as all memory used is properly accepted using
> TDCALLs.

By my very cursory reading of the TDX arch specification 9.8.2,
"Secure" EPT violations don't send #VE.  But the docs are quite
unclear, or at least the docs I found are.  What happens if the guest
attempts to access a secure GPA that is not ACCEPTed?  For example,
suppose the VMM does THH.MEM.PAGE.REMOVE on a secure address and the
guest accesses it, via instruction fetch or data access.  What
happens?
