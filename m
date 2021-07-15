Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958713CA189
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhGOPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbhGOPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:36:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBEC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:33:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so6649321pju.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XqUYb9cn2ckCdyFD/js6NwcqwhuMxknz5Gt0P6Fa+nI=;
        b=DdzOhQifr3b8MJGVqCjHFlZGIXN6LF/+2DiAVy+WIRe+brvhw6ve1VMiE6wEb5KKed
         4ZciHRg1lxpB9MgJg/6uB2X9sZyfS5zHWR/AYtpjisWDtCyuEsT+38m3+dJPWTonJwsh
         bgR1xnw1e/e7DOXC1TNw9FQl3W50vkbcHBOr4yc15SE6086TSpGwdYB/FEGDMqJJSmjS
         pnCMIxE4K1UurOratL8Gpyox5XmGePPjA6cLGTsHdBo+2qRmnehOJnQzOLn6bnMOoyN+
         OuVlN87zS+N9OyjP9esvkefeXcpaDCnaCVFYBp2lXEg4DwCElaspfkjjtc8noeguwUds
         3mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XqUYb9cn2ckCdyFD/js6NwcqwhuMxknz5Gt0P6Fa+nI=;
        b=o8uSx3AchGGW+hq5gtQXhjqsNPqoAtjPwJs1ovLr5Awp+RBYaZi5rngysWdbKwg0e2
         AYkaKpkZDv+uzymBzfWqcHl58f3Wrchqng9yNpopjQoLpKFcjuXdC7TFx9u5j7xPtIhV
         F8XdWPQkctSg/uTRpRf81x2g7yP8tl8cWoEOwS11NiXaXuMI4crCTr1NESwkvNhKi9+N
         k6g/NG9GuM8zGs7cpiSdznEX6S7o0lLe/1YE5cxC8wWwHz8dJUQWDG6AC2CfA/M6lDb5
         QLi1w1o/fad5IhJ8PFBCnY4E85vCQjGV4Eyd41gnKDEcT2atRHhNrepWL/FfG4rXscl3
         FY4w==
X-Gm-Message-State: AOAM533mBdwXaWxnGTWlGMZTYwv45enlctL282c4fXMnlp18u+0gOoIQ
        Zp7njV4Ya+Srh2FfoE9x2uQSZQ==
X-Google-Smtp-Source: ABdhPJxr1lIoz4YNwU6ZeX8GSViY8AdSGILxEwakSZo+7pag0EclqNZRM9oFqnsA67Uyg1okRq/bnQ==
X-Received: by 2002:a17:90a:6708:: with SMTP id n8mr5077917pjj.32.1626363224492;
        Thu, 15 Jul 2021 08:33:44 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j16sm7359754pfi.165.2021.07.15.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:33:43 -0700 (PDT)
Date:   Thu, 15 Jul 2021 15:33:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86/sgx: Track phase and type of SGX EPC pages
Message-ID: <YPBVVGetUyN8TqKS@google.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
 <20210708181423.1312359-2-tony.luck@intel.com>
 <93845f78-120d-7522-bd3e-fe042380d29e@intel.com>
 <31668f36583844cbbae0b10a594193d6@intel.com>
 <00114991-9075-84f4-797d-f0f953d34660@intel.com>
 <YO9uZKLYCIBc1HsH@google.com>
 <c0fa2e9e65da4f58893386279ce914c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fa2e9e65da4f58893386279ce914c1@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021, Luck, Tony wrote:
> > I've no objection to tracking the type for SGX2, my argument in the context of
> > #MC support is that there should be no need to track the type.  Either the #MC
> > is recoverable or it isn't, and the enclave is toast regardless of what type of
> > page hit the #MC.
> 
> I'll separate the "phase" from the "type".
> 
> Here phase is used for the life-cycle of EPC pages:
> 
> DIRTY -> FREE -> IN-USE -> DIRTY

Not that it affects anything, but that's not quite true.  In hardware, pages are
either FREE or IN-USE, there is no concept of DIRTY.  DIRTY is the kernel's
arbitrary description of a page that has not been sanitized and so is considered
to be in an unknown state, i.e. the kernel doesn't know if it's FREE or IN-USE.

Once a page is sanitized (during boot), its state is known and the page is never
put back on the so called dirty list, i.e. the software flow is:

  DIRTY -> FREE -> IN-USE -> FREE

> Errors can be reported by memory controller page scrubbers for pages that are
> not "IN-USE" ... and the recovery action is just to make sure that they are
> never allocated.
>
> When a page is IN-USE ... it has a "type". I currently only have a way to
> inject errors into SGX_PAGE_TYPE_REG pages. That means initial recovery code
> is going to focus on those since that is all I can test. But I'll try not to
> special case them as far as possible.

Inability to test expected behavior doesn't mean we shouldn't implement towards
the expected behavior, i.e. someone somewhere must know how SECS and VA pages
behave in response to a memory error.
