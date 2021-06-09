Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54D3A1FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFIWMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:12:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C1BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:10:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l1so20915995pgm.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z5AhBfpqP3gat2Xo7WmpL+INYzzgwJmtJNXeXywDiHs=;
        b=mjBoBWYx/JebUJ5m+WqpayYBePydDymtxwGR7IdD4HK7G88SU9MDNjzfQTzSZUhW7E
         pVypou7T6C4KVN8gR7pjEWOf3jQqixLZWl2wlOY5mx4Swv9+kqu7A1n6GMEHoYKBBhIc
         UUovg/7VmrYxau5mhdHu9wN7vUTfvaWT+knDx7ZAtVeM7jt8d1bKxQ9TJeXRwGNMF9i+
         5tjbTQBbLLJ7qDCgyGTuqXGkpqu+27rrSm3g0Z4Pdm5bkJ2QJIFqen89nMgrk5gaYzbL
         kf6UfohwmuSft1CojI0twZWkNoExi4ZRqPgcng8wC2juLNvpjkcXe3ITy00Kg77b/ooc
         DN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z5AhBfpqP3gat2Xo7WmpL+INYzzgwJmtJNXeXywDiHs=;
        b=osycdgWnpXQnWdkhU3ECMVhK44XZvwxSDg9N5ZEWVLdydyRGiuFlGIGTXFKR96V0+H
         rjBUbq4C8AxMo3sq8nabWOveZIjFPqb+Dw/bqEDbbpmGjUXfdb8/AZJoP//1K/MYFiGj
         R8k0YkDBJD7Thf5134OIZVdvPUA3MzFpSkSghtex3/B8qfk1b7H/mKF3KCrrUWmiSsBS
         cfDxAPKemU9H+Rrr+/oKyrk2qoNsKYaRrlwi3AT+Y7nuvlGYXuTvDn5AZC8RbPDJWHOa
         ssa76GyGWDQ+aQL0yMNvZwJr4NXWqdOTWAZyqjY1+Au1VYtVuOiii3cP+usdICSfpdgd
         aX1Q==
X-Gm-Message-State: AOAM530nvs+wfB7rE3TrN2/3uYj55GASfVb9rfUqOLK/eOpLmMAQbc0I
        YzPacOizD+1aQdU3HXLr84JtnQ==
X-Google-Smtp-Source: ABdhPJwx/2yEIWEw4VYHQeKuiME3PW+fR2fCoXP4ekCi9WYe2/orCGwPM2moM2aVvnhaAbcnS6kiXQ==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr1800571pgb.110.1623276653975;
        Wed, 09 Jun 2021 15:10:53 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h8sm645022pgr.43.2021.06.09.15.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:10:53 -0700 (PDT)
Date:   Wed, 9 Jun 2021 22:10:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/10] x86/tdx: Handle early IO operations
Message-ID: <YME8aZVqI8x/a/Ld@google.com>
References: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210609214555.1955404-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609214555.1955404-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021, Kuppuswamy Sathyanarayanan wrote:
> +/*
> + * Handle early IO, mainly for early printks serial output.
> + * This avoids anything that doesn't work early on, like tracing
> + * or printks, by calling the low level functions directly. Any
> + * problems are handled by falling back to a standard early exception.
> + *
> + * Assumes the IO instruction was using ax, which is enforced
> + * by the standard io.h macros.
> + */
> +static __init bool tdx_early_io(struct pt_regs *regs, u32 exit_qual)

If y'all insist on shoving "tdg" down people's throats, at least get it right.
