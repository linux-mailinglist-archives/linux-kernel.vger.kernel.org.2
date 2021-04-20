Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B05236629D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhDTXya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 19:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDTXy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 19:54:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A9C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:53:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u17so60865984ejk.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1HVqw2u+ZEVP3LLHwLN3iHI1fOIOC87ihGMFz6AjvQ=;
        b=b1J20iHm9woqr0rW5wfn/QNVzNKS/tbNwU/8AHh1VWxJYJjPKn7fyCzGkkLajwpoEQ
         Q68quh7pNoBXlSWxJTq+kC4PxdR7SyMdBk2cXUfROUdNWSfNRV68IY9Xu3a9515AWa0A
         OfIxQooTfPELmkSEShUytc9HSqM+7JVpKS0J7J9IPJBhKTd0kZ3SM4PaIExchFWkLJMq
         SDdMqMl0GWDuNbIVmPpy6HB9RC9Oseo099u46R3ddDpo0BvxQSmuqiwPa07LiXcq6ifF
         X2G5yxAOHhv6+SNHF/Xc77dIPxGSBrri5xNklqftApMVughkKRtDZJJHTsD4bfc9fnNw
         GQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1HVqw2u+ZEVP3LLHwLN3iHI1fOIOC87ihGMFz6AjvQ=;
        b=OqL+ua8KrNSYVsAF+obDjOputYZw4WOIr02yl7burmPCOEa7DsGq5tEtIMpNsFUvjC
         qdGEoAGHgTOhISOUa9oY3qffx023LoUlIYEKHJvk99A3Box3CNiYV++9k4Uf4Cfa2Ynh
         TFTvVrxbYBgTBlgp4yPzHv4PSw4K6IHLy+8Q/DUPYhviW1np3V5ziA0nbhq2Iq9i+KNX
         8LR6mp8skA9Negag4Kjra4yKJBbecnvnJZRcXFMtpVkv9nWuMFVwGAImNIj20lCDbHnx
         zF3GZy9PrtlF6g0QEu4tzOHyx0CcmxKHVYCtyH2hL8MEekEVzhGcLrKs+FjCiW71cF6p
         Nmuw==
X-Gm-Message-State: AOAM530LOEtrLYQsThW1mbmDbPQE3jwx6/eHmiOZP+6GFDygIKqOUXzP
        vj7YJn+aIVTqBtY68dfMkOXvcjJGqNGf4iw2N+UUvQ==
X-Google-Smtp-Source: ABdhPJx7DVe4eGYTkfyHx5Ac3TAE1uFjzufLq7qJsb3b/XxdLVyHpG3GbU43jLpdqE9RHaPhLD54mGNKJr/i1JUafb8=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr13565044ejf.341.1618962836302;
 Tue, 20 Apr 2021 16:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com> <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com> <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
In-Reply-To: <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Apr 2021 16:53:48 -0700
Message-ID: <CAPcyv4hmA=V+wQA7JsvBNYnm+dHkRZtJSSxSZM8b2Xwnjq2kWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper functions
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 4:12 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
[..]
> >>> Also, do you *REALLY* need to do this from assembly?  Can't it be done
> >>> in the C wrapper?
> >> Its common for all use cases of TDVMCALL (vendor specific, in/out, etc).
> >> so added
> >> it here.
> >

Can I ask a favor?

Please put a line break between quoted lines and your reply.

> > That's not a good reason.  You could just as easily have a C wrapper
> > which all uses of TDVMCALL go through.

...because this runs together when reading otherwise.

> Any reason for not preferring it in assembly code?
> Also, using wrapper will add more complication for in/out instruction
> substitution use case. please check the use case in following patch.
> https://github.com/intel/tdx/commit/1b73f60aa5bb93554f3b15cd786a9b10b53c1543

This commit still has open coded assembly for the TDVMCALL? I thought
we talked about it being unified with the common definition, or has
this patch not been reworked with that feedback yet? I expect there is
no performance reason why in/out need to get their own custom coded
TDVMCALL implementation. It should also be the case the failure should
behave the same as native in/out failure i.e. all ones on read
failure, and silent drops on write failure.
