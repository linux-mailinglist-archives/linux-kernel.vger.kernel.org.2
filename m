Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701ED3D997C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhG1Xcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhG1Xct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:32:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8E4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 16:32:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a20so4737292plm.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NDt6LLEUimAPczTJgPiEJiiKPpudtm/rlQjxG+q7NI8=;
        b=TvC9Hgm5Pi3lEkb2NMGk2B1U0bCYhFVvXQjuVYn4VLSgVmU8e3JfFRUP04G24+iB5y
         ETOsw9ISd1Y3Tt4rA8B1JoP8wsFMfz5FvdODOSv3B52KiRnAMu3FzbnBDIiEEVLHSiar
         5bTEm5ghBUPRmYgiN6L6BLz7Lz4lm+i/dLz4oc8At8n4KLQHjRhTmQFA0dw9KDdMchhE
         lZDQUpXE5ykOcuFD5eBQOCcmjcvwsowJpuKsGoNsGNgIaFA0Lb5fm4SCvVtnrN8uFsZ5
         JTMnyEsc0Ly5rjA3hROxn4Gui/AIkzUcq0WCI2HBzgmq8eKlRUWF0nOjjrR4//SgNcxD
         84eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NDt6LLEUimAPczTJgPiEJiiKPpudtm/rlQjxG+q7NI8=;
        b=LzR7E1hKt6EUlin5K2x2Gux1nfPUqfsTZiFRFJEjh4hWscqDiIMlB0ZqcPLEuPnopD
         fJOrYV5c/rWvPmeOiZNZ9kV+z8PNr/C3vVSeVsTd2XF9aEjHpROOY4qUvd2PDtpH8dJl
         2MXRpc0bEDr1+yXhPF+fSHd0JRHlqNVpc20WZj1dkFU26xRGq1vnJMxobrTYcr0Gzlaj
         elCxFGzuY8nmjgrF1mVSAc65GJIzlG//alrUoezGYSWjEH+3seu7ANx9WFiGJDXVrISN
         pQ0I7vofI0HRX3r1GutmH4ek064L/AucUVPyi6dO+d3AL4CFJaj60BxI0NyW9fw/b20B
         7F9A==
X-Gm-Message-State: AOAM5322TLwIwlqR4qc8QnfuDl3hTXLqD0pSIKQIxghZ8xaCnHGKuAHu
        F10t5G9mEnUzKzqcwmXBTJWpmw==
X-Google-Smtp-Source: ABdhPJwqwOu/3FuHxIHqFY5jzWVD13P9DSw0Pb1wwzJW9ZTwGt1A4+uKAsWy5Itw9wsg3oGGMyJMGQ==
X-Received: by 2002:a05:6a00:1a0e:b029:34c:4f4a:af3f with SMTP id g14-20020a056a001a0eb029034c4f4aaf3fmr1971544pfv.61.1627515166695;
        Wed, 28 Jul 2021 16:32:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o20sm1043695pgv.80.2021.07.28.16.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:32:46 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:32:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Message-ID: <YQHpGq0GyAsYpE+D@google.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-2-tony.luck@intel.com>
 <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
 <f2685d7c8dc14792a4e0f9807f742ea6@intel.com>
 <fd8f8e79-f63f-7d6f-277e-1ad08ab7b6b8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8f8e79-f63f-7d6f-277e-1ad08ab7b6b8@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021, Dave Hansen wrote:
> On 7/28/21 3:57 PM, Luck, Tony wrote:
> >> Wouldn't it be safer to do something like:
> >>
> >> 	page->owner = owner ? owner : (void *)-1;
> >>
> >> -1 is non-NULL, but also invalid, which makes it harder for us to poke
> >> ourselves in the eye.
> > Does Linux have some #define INVALID_POINTER thing that
> > provides a guaranteed bad (e.g. non-canonical) value?
> > 
> > (void *)-1 seems hacky.
> 
> ERR_PTR(-SOMETHING) wouldn't be too bad.  I guess it could even be:
> 
> 	page->owner = ERR_PTR(SGX_EPC_PAGE_VA);
> 
> and then:
> 
> #define SGX_EPC_PAGE_VA 0xffff...something...greppable
> 
> I *thought* we had a file full of these magic values, but maybe I'm
> misremembering the uapi magic header.

Rather than use a magic const, just pass in the actual va_page.  The only reason
NULL is passed is that prior to virtual EPC, there were only enclave pages and
VA pages, and assiging a non-NULL pointer to sgx_epc_page.owner, which is a
struct sgx_encl_page, was gross.  Virtual EPC sets owner somewhat prematurely;
it's needed iff an EPC cgroup is added, to support OOM EPC killing (and a pointer
to va_page is also needed in this case).

sgx_epc_page.owner can even be converted to 'void *' without additional changes
since all consumers capture it in a local sgx_encl_page variable.


diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 001808e3901c..f9da8fe4dd6b 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -674,12 +674,12 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(void)
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page)
 {
        struct sgx_epc_page *epc_page;
        int ret;

-       epc_page = sgx_alloc_epc_page(NULL, true);
+       epc_page = sgx_alloc_epc_page(va_page, true);
        if (IS_ERR(epc_page))
                return ERR_CAST(epc_page);

diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fec43ca65065..3d12dbeae14a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -111,7 +111,7 @@ void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
                                  struct sgx_encl_page *page);

-struct sgx_epc_page *sgx_alloc_va_page(void);
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..655ce0bb069d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -30,7 +30,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
                if (!va_page)
                        return ERR_PTR(-ENOMEM);

-               va_page->epc_page = sgx_alloc_va_page();
+               va_page->epc_page = sgx_alloc_va_page(va_page);
                if (IS_ERR(va_page->epc_page)) {
                        err = ERR_CAST(va_page->epc_page);
                        kfree(va_page);
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628acec0009..4e1a410b8a62 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -29,7 +29,7 @@
 struct sgx_epc_page {
        unsigned int section;
        unsigned int flags;
-       struct sgx_encl_page *owner;
+       void *owner;
        struct list_head list;
 };


