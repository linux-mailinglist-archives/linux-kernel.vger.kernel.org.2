Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB35038B7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhETTe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhETTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:34:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF86C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:33:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so5847817pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DKaftpjv7H83Jh/uRtII0tq3p9ECwTnXtKKu/Rh05PI=;
        b=vz5G03Jq3T+zYlANXUXDryLqsRfrAPGj9W2taWRFdoAqGpZb9TiwgFz6Ogsh6l69kb
         JdPBtixQGnCKuAjOaWr3RFRc37fQZXsY9umWWFIr9btcsZ2H6JvT/yUdwCaPzbadtkk7
         N1Ozq3SS/8ad81RVsvUvY0I0pwjvMahpz/+P0lx9rO4DvRc3eowOqndgZyTWno9I4ZXO
         qm1nnrbXkFkzbI6LM68ZxsFc2B4C8MgChsg4h8eU7hTrpYYrvE6c/6Wo2z76zNKgTbBO
         E/Y/DGO0KUByry4G6Cp9DKF7jIUQHysttBXkHfXRkQWEOqyqWRD14EtyaLwftyOhAUfL
         FSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKaftpjv7H83Jh/uRtII0tq3p9ECwTnXtKKu/Rh05PI=;
        b=mjbqTcFZFAD27BfvIybHzEzHbVRAtPDO910GOCzTPI8YHFMmYU8seOoOksLpEgkFHv
         nnzE2PykkMk4wdOfdUi4RWm5KTsL28TWf5blCVkUjAC/b3vVJLmDZh8ZDjrRRtjG/IDp
         vIbz5bQy193sRBoTm3Xelr4m+jwK4sxZkvQAjNhd/32jg8v/g4j10yU/192czLCUGVuD
         kBe6Jhq0dJibNvisBDmrN2JX697Lv8kEX4hYrP+bHULvyqmLnhlw3oHAuU6QeLOdsVZp
         y397K/sawPxLyo3cq85LAhtaKF/yfra6rxXiklV9t+plJmyBPGcYnkxekRO7yJD3ODiP
         DzqQ==
X-Gm-Message-State: AOAM5310POLd5MdyrbwRQZ4ulzncMYvMzaRJX4IalJBx3eLSsvXkcfnK
        38CH+TFfYYpWQp55f4dcsG10bw==
X-Google-Smtp-Source: ABdhPJx2cEANB7DElFy0DEIg4GJXnR9d7vcMndsj8xxQv4VsXHSdZwNwbkTVvozR7t2BFM6ZIHpLeg==
X-Received: by 2002:a17:90a:7486:: with SMTP id p6mr6949639pjk.216.1621539207345;
        Thu, 20 May 2021 12:33:27 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id b17sm2565876pgb.71.2021.05.20.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:33:26 -0700 (PDT)
Date:   Thu, 20 May 2021 19:33:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
Message-ID: <YKa5gkwGTIUFpzzH@google.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021, Kuppuswamy, Sathyanarayanan wrote:
> Hi Dave,
> 
> On 5/19/21 9:14 AM, Dave Hansen wrote:
> > On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > tdx_shared_mask() returns the mask that has to be set in a page
> > > table entry to make page shared with VMM.
> > 
> > Here's a rewrite:
> > 
> > Just like MKTME, TDX reassigns bits of the physical address for
> > metadata.  MKTME used several bits for an encryption KeyID.  TDX uses a
> > single bit in guests to communicate whether a physical page should be
> > protected by TDX as private memory (bit set to 0) or unprotected and
> > shared with the VMM (bit set to 1).
> > 
> > Add a helper, tdg_shared_mask() (bad name please fix it) to generate the
> 
> Initially we have used tdx_* prefix for the guest code. But when the code from
> host side got merged together, we came across many name conflicts.

Whatever the conflicts are, they are by no means an unsolvable problem.  I am
more than happy to end up with slightly verbose names in KVM if that's what it
takes to avoid "tdg".

> So to avoid such issues in future, we were asked not to use the "tdx_" prefix
> and our alternative choice was "tdg_".

Who asked you not to use tdx_?  More specifically, did that feedback come from a
maintainer (or anyone on-list), or was it an Intel-internal decision?

> Also, IMO, "tdg" prefix is more meaningful for guest code (Trusted Domain Guest)
> compared to "tdx" (Trusted Domain eXtensions). I know that it gets confusing
> when grepping for TDX related changes. But since these functions are only used
> inside arch/x86 it should not be too confusing.
> 
> Even if rename is requested, IMO, it is easier to do it in one patch over
> making changes in all the patches. So if it is required, we can do it later
> once these initial patches were merged.

Hell no, we are not merging known bad crud that requires useless churn to get
things right.
