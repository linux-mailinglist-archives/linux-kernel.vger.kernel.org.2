Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EC387F70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351142AbhERSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbhERSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:18:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9ACC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:17:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so5560534plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kLurRiFyhtczUeXHLNIB4esFHRT3cHm8pgOkVCHundQ=;
        b=Wvj2Sqm8Ytx2wC43ED+AU1CDqk/+5VvwOusfZRTFz62poKCXIdUKTb7ZSDtdoU6sLB
         PGQkTLaHMdUtsKySgoaBVfYwePy4Ar7h+Xwt3Lp9utM1FTMQ3qnPLeHTHWwXNo5n1LR1
         eVWtBAE9nvK3Fcquxy8AU4EddtTy0EjOuyxU/5smyuVp2grBcFKJkg8zeJDzjXn6HjYq
         iHiCqVXuLEzGNhNVYIXgV63Bmv9VPB1kXiC0IE3ulSqQJcEZoXTM37Y1TaNaqQmyY83A
         A53UNbn35mnM8HiVEY0BgREv19AI9r2jCvcL8PUZA0uGwtVeH6bH9xpoIX2o8tJZioVh
         Hr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kLurRiFyhtczUeXHLNIB4esFHRT3cHm8pgOkVCHundQ=;
        b=QRFyGejsLZnTf0iBg5ROdOcwxCYa/H59sgoh3cWcaVT2Ka8+YH6RoNqh8FHt6QC3PC
         SXrsYOCQROI+uWtNReTKfeyfGk9EhAElf0CtoYvXYENY+Afh78Y2yGqWJFr+etSQp8KY
         JxLRMiIUApq8GAX6jx1u788vFOVrgy6ntNKCXYhrojuxXKhltjo7J8qaR4UDUEeL6rCi
         iQ8YgZOdSgNUAQ5ejNn2BM8cXv6tPZcOL+nRcKUNX7srBIX5owTVzUvI/IaHeYven7jz
         unYTNmdXuP6yuzJesAJASlbGpepWTv+pV64DHA3yArODVmX3GHc6Doycu+ysEw5MPjNo
         apBA==
X-Gm-Message-State: AOAM532Kj/l0+QuJsTovKvZisZ+qUvjSdF5tWDPBg5v9kYgXecEydGRf
        8gSiEeyjC1LS6alkYW+vxmDVOg==
X-Google-Smtp-Source: ABdhPJxL0BrDRoa0uLwNdNM3XEn5ivbY6ikPpUina0K46OQLQ94Z9pbXH2Ig5ygxNGyk7H9ncf9+MA==
X-Received: by 2002:a17:902:7b82:b029:ee:f548:2a18 with SMTP id w2-20020a1709027b82b02900eef5482a18mr6012254pll.75.1621361828613;
        Tue, 18 May 2021 11:17:08 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id d10sm9516765pfo.65.2021.05.18.11.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:17:07 -0700 (PDT)
Date:   Tue, 18 May 2021 18:17:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
Message-ID: <YKQEoMau3ovCzJ1W@google.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <YKPo2Zde5b0QxIPJ@google.com>
 <d8c87904-d994-8a5a-c0e8-be861fcac6df@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c87904-d994-8a5a-c0e8-be861fcac6df@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Andi Kleen wrote:
> > Why does this code exist at all?  TDX and SEV-ES absolutely must share code for
> > handling MMIO reflection.  It will require a fair amount of refactoring to move
> > the guts of vc_handle_mmio() to common code, but there is zero reason to maintain
> > two separate versions of the opcode cracking.
> 
> While that's true on the high level, all the low level details are
> different. We looked at unifying at some point, but it would have been a
> callback hell. I don't think unifying would make anything cleaner.

How hard did you look?  The only part that _must_ be different between SEV and
TDX is the hypercall itself, which is wholly contained at the very end of
vc_do_mmio().

Despite vc_slow_virt_to_phys() taking a pointer to the ghcb, it's unused and
thus the function is 100% generic.

The ghcb->shared_buffer usage throughout the upper levels can be eliminated by
refactoring the stack to take a "u64 *val", since MMIO accesses are currently
bounded to 8 bytes.

> Besides the bulk of the decoding work is already unified in the common x86
> instruction decoder. The actual actions are different, and the code fetching
> is also different 

Huh?  What do you mean by "actual actions"?  Why is the code fetch different?
