Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716B23A2132
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJAPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFJAPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:15:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6322C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 17:13:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d16so95091pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSTfafxW8jHvQ2GiKeE5XDJLg/7+FRVYgrPDJi7cshw=;
        b=W1do3c7kHlos/j2HFBOZhEyEtfCuQOYqlVSMIr2+i573SiKv4ko6UyChw/rNzMjvm+
         qLOr3/sIDyGQd/C+uOHJX15d4GVi+yxeTJJWASHyVOAeemnvKNc3wh3eJHVrufnphECk
         ZchcvBW6lSgetHS9lpbGrecVa9S9NV5zJ3X0jjoL0e24ws7nGHeBZjnOwC58gsRhv3i0
         wMTojU42ZWtWpG53l+PvSj+9xNR7iNhdvmaZ8iUq155Ic4cUNYoM2CJoNKx9gdbCI1Fx
         s0eKiikmXIwrQstcmKgZpWLPX0HEDf7MDUlD2VlnG6hqdKHX6lKPeh3AuKodpJ5l/4iD
         7+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSTfafxW8jHvQ2GiKeE5XDJLg/7+FRVYgrPDJi7cshw=;
        b=lnjJ1yfqdYerBxfnDLo/7ivenflCy5rsuC3uqbom43Uyi8MiTw/LYgEYKOVsDFgWXC
         gyVbjzJY2YZ+89wDzIO2iLG9/LCnKFg5nVuSNKKQkHeyB71bitEUNhr+Bnw6RBl9wOaH
         yaQZKPUBWG+hrL0t2TswVXOICl0zn8bfDBZcI7SjTMCLVnLqCjgCskdICXjlb68yl37W
         2virMXyAPFZ3z78CmyJg094KydX9ezHOaGNSNAxjzWETK+9X/8jOw1t3WZDqiHGDU35o
         IaO6Ee4k0WEX+miUYSm1BDmUdT+eYHwPlgyciNkPKmibnQhsW+0WdsHd32ZHxVGsWYl/
         Bf0Q==
X-Gm-Message-State: AOAM533Z+dHe876fV0gVr8A/ka0MJJiC+SnQo9ZCmLDnu5XFG89i1eFq
        nzGAduBtMwndMK4ZpNR/vzofRbrEUqy9Bq7Q8TsWQg==
X-Google-Smtp-Source: ABdhPJxXEx8PA+MQyKX30F1sCaOuUd0fU9rSx22kMYgGIJdxiYDm9+Q/HVnI206Bb5oriHXtTn9lmY2hjPeNlD5tano=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr2235485pgm.279.1623284016402;
 Wed, 09 Jun 2021 17:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <202106100613.JQBEtsqj-lkp@intel.com> <CAPcyv4jAkutNExqao0Q1HYL-pQxrSbAN3F5N9Uj=09KDa_uynw@mail.gmail.com>
 <10c9fdc0ace04013b7d4999643aa8b21@intel.com>
In-Reply-To: <10c9fdc0ace04013b7d4999643aa8b21@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 17:13:25 -0700
Message-ID: <CAPcyv4ioLR4UyG_h3Z6Yaym9Yfg1CsQ0o_2gtrUbd3SKiS9i6A@mail.gmail.com>
Subject: Re: arch/x86/lib/copy_mc.c:30:1: warning: no previous prototype for 'copy_mc_fragile_handle_tail'
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 4:55 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > This routine is only ever called from ASM code, so the fact that there
> > is no C declaration is expected.
>
> Does the asm code really need to call back into C?
>
> Could you just have the asm code do "jmp .L_read_trailing_bytes" (might need to only do that if %ecx is non-zero)?

I could... it turns out when Peter did this:

3693ca81151e x86/uaccess: Move copy_user_handle_tail() into asm

...he did not also go fixup my cargo culting. I'll take a look...
