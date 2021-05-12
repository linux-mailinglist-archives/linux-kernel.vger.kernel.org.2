Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2DF37BDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhELNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhELNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:09:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:08:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z13so33663068lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Iw5ZdnIrZYIGz1+2Q8w3rA9D0sH6uyzMgpL7tI8AL3k=;
        b=ksfGqKym2FPVhYBacELqLrOBKjbC4fUgw6JdQebX2sVsgMnVWP3I9FtMVtLUx5QnY3
         cVq1a++ulPmSS3okWx/HoDiZPeLOzjKmZK/9LArL0khfgtxcBNbNBDhnB06lsTLbaNvi
         Tp3MkXFpsH7mP8Q7uDUqAmqCeAGwyajMU3+b1Z9P+ojzB/19H45dTqVMf3zElJEV+Szr
         Aq0YM2IpCpFufsgO2SF5gVKlcCmoDv+HlAe0p10jhHNpCwr2kvSc3cAlC6dp3M2AXUIW
         85Xial4PyGQgnCWEdqigbqX5+goW7UI49tSHv0IUu6J9Dppnu5GJaEU6v95QrqUUO60A
         yu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Iw5ZdnIrZYIGz1+2Q8w3rA9D0sH6uyzMgpL7tI8AL3k=;
        b=XIoTv1guyZrmeN5yWFC+H3VZghWBvzCXEK5HwQApZ/4AD+s4l5PmSgZ2x9FEDzHpQb
         2phMfQbvncqczl7XoDeQnCX5Mwq+r9wO1bHdpjxZhOrWL+23uP/oNSRWB1KV+PK0Pe03
         jgbWzZC2HNQ9QUX0eHW5lZQQp1p2ksCDBxdOo/WjWI9c9/2g5RH1l7kcJfgYH1TYLzs4
         cy28CHzYZdgyHYO8L685zmwXboaMYA8+ZlitgbO33kVozLnp+CdjcMeCdU9t/9U+jo1b
         Mwme+3mwYCzdjJjkYpJcCrTyYp2anw97SlP0UeZw+5DU2Zt3dLQ+QtECzm7zS8kriIOP
         tZcA==
X-Gm-Message-State: AOAM530/5C1tC98AOG058mQyUkfK+SYGCvJj71xFndpeancLLu8P4HVu
        a7TG3s9nDtFGP2pfgRxDo3ZxQw==
X-Google-Smtp-Source: ABdhPJxABrzJreB8kapKFo1bvTNEo0K1BUkIGFbgYZMqsZY/6S7j0iLjsta1W2WidDoy/IymaaCqzg==
X-Received: by 2002:ac2:5e25:: with SMTP id o5mr13873313lfg.638.1620824900510;
        Wed, 12 May 2021 06:08:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c14sm810992lfb.129.2021.05.12.06.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:08:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1B24910265F; Wed, 12 May 2021 16:08:21 +0300 (+03)
Date:   Wed, 12 May 2021 16:08:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
Message-ID: <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
 <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
 <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:23:29PM -0700, Dave Hansen wrote:
> On 5/10/21 3:19 PM, Kuppuswamy, Sathyanarayanan wrote:
> > On 5/7/21 2:54 PM, Dave Hansen wrote:
> >> This doesn't seem much like common code to me.  It seems like 100% SEV
> >> code.  Is this really where we want to move it?
> > 
> > Both SEV and TDX code has requirement to enable
> > CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED and define force_dma_unencrypted()
> > function.
> > 
> > force_dma_unencrypted() is modified by patch titled "x86/tdx: Make DMA
> > pages shared" to add TDX guest specific support.
> > 
> > Since both SEV and TDX code uses it, its moved to common file.
> 
> That's not an excuse to have a bunch of AMD (or Intel) feature-specific
> code in a file named "common".  I'd make an attempt to keep them
> separate and then call into the two separate functions *from* the common
> function.

But why? What good does the additional level of inderection brings?

It's like saying arch/x86/kernel/cpu/common.c shouldn't have anything AMD
or Intel specific. If a function can cover both vendors I don't see a
point for additinal complexity.

-- 
 Kirill A. Shutemov
