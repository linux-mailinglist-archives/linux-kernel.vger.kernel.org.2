Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BCD3D044D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhGTVaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhGTV3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:29:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBEDC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:09:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c1so666436pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1KpDtcbagCdJ8ZcB9ERipK82kYWQJWAaZ7siOAOkMw=;
        b=iC5/q3Dl6pQ0rDuXXIFsUAbTTQ6Y1iAmt2YRVwiDFilqazfKQ9eEEPIayC2+XoUaT9
         usur5pgbsW0fNlZwnXjGODqmC21M5aICjnd0qHR+a8GO8IcdohO4/jlCmYaIlbW9IpQ/
         9icYBfvLFjmRAGsIv2RA8ekw4kWlpmiVwY66u3OydYL7Z53+N5wZpVGiQAecWFBlLpLe
         sL9R9oq4gKRFUvlIZCwk423cdnRZmAN89qaHYNxWqXrQ1h70ThRegG+2GEW+VV4D7E6W
         We1DWyHavLAYbXFybe4gmSLh43r2YhL50quM4zqfHfvjJeqPygE3Sbq/iA1L8bSDsgIo
         MW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1KpDtcbagCdJ8ZcB9ERipK82kYWQJWAaZ7siOAOkMw=;
        b=ROKQUnTouhx3nOM2ELMbxg9ys7hQUasZMQvDF2d0YFxJvgwev7pSm2y8coIG13U9Yu
         8JG+n8OMnZWmwTXzqVefMD/bGzZm66ph2Ec/FX5VcAGPa2yB0nHyjnsE07hm+hp1z4Yh
         VIQgXpU91/m6T/caOCABiaSOCnl7YsrNffTwRfEitSJE3M0h8aAy1yn7wFE4zEIWIlwh
         Rg8U3vpuiUGDRoEW1u9Fs5SVcFoZPqZ+xunFNzBTxVvakAnCUGxQznOC1R0m3VH4R0dw
         MLGyfamfM7PbL8M4VHjzmbZJGtJ4eLRj+D+J3og9/ORoYwpb+cND3X82SwcDKKUQoMv2
         XL7Q==
X-Gm-Message-State: AOAM533jVYaJTBS2OGSCO8APnkiB6j3rWEJI8t0EmzEGe1SerML+E3Xf
        KSwGGGUT/KlHeVrxYt9lN6k72wk5sloDIQ==
X-Google-Smtp-Source: ABdhPJx8WtrWjs7nIJb96K+K/6fJyf4kxrPOkag79GDpR0/USJYJ5ph8uncx7oovExjawasHg85EEw==
X-Received: by 2002:a63:5059:: with SMTP id q25mr32834341pgl.9.1626818972887;
        Tue, 20 Jul 2021 15:09:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p5sm24369675pfn.46.2021.07.20.15.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:09:32 -0700 (PDT)
Date:   Tue, 20 Jul 2021 22:09:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 38/40] KVM: SVM: Provide support for
 SNP_GUEST_REQUEST NAE event
Message-ID: <YPdJmKXhXKOZdlld@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-39-brijesh.singh@amd.com>
 <YPYBmlCuERUIO5+M@google.com>
 <68ea014c-51bc-6ed4-a77e-dd7ce1a09aaf@amd.com>
 <YPb5yfKEyJjvDbOl@google.com>
 <0641fdec-48a0-b3b7-9926-3ce5a6e53eb0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0641fdec-48a0-b3b7-9926-3ce5a6e53eb0@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021, Brijesh Singh wrote:
> 
> On 7/20/21 11:28 AM, Sean Christopherson wrote:
> > Out of curiosity, why 4 VMPCKs?  It seems completely arbitrary.
> > 
> 
> I believe the thought process was by providing 4 keys it can provide
> flexibility for each VMPL levels to use a different keys (if they wish). The
> firmware does not care about the vmpl level during the guest request
> handling, it just want to know which key is used for encrypting the payload
> so that he can decrypt and provide the  response for it.

Ah, I forgot about VMPLs.  That makes sense.

Thanks!
