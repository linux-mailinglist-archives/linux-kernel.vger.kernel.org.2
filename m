Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DDA344AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhCVQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCVQLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:11:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42927C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:11:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so22209058ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/AUtBaGI9CnR9/DqWeJf3hjAPYoclxfcYyUmUiEtsQ=;
        b=0qo/4PJUC/Enlck3rYWsBzPBBDRgAZHY169EQXzCSbNjX/ve+Q9Zv6UB160D6TGfIO
         wBOHs3sguwSEPp2aT498ZXR7yzT9Gm9ZTvR0INjcf5aka51gKBvzxvzcm03dh57uZkrJ
         uEPPoDHuhSX+QlN6Nh+88W6QbuDrjgsop0WIVChNQVKzuqflECkassa8eIEGsynZu8IU
         WR5dWFuLpYuPerhSmHLfE8lmTZq2Vih3/6fylJT8pStOvaeCNJYG+BcVMf1WWpm0EdGo
         Sc6fwzgPKJSCnudhykFtXEXAgLl1NtcpAUAq2JvQV9/nAL4X72npLxxH4x9oTd2fulU3
         Piyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/AUtBaGI9CnR9/DqWeJf3hjAPYoclxfcYyUmUiEtsQ=;
        b=NfPsZkF7XpK6vtPph/BiYrbhZOWP4NJ9cKYT8mTkmeLLVzmTJ7w37NVkHAzldMG9cr
         MeEKzpbmzj1iJWfNAfLXk4yJQq5WUfdRynNHAZ8pCJaLSqFe5/oPzYchIdT6c77IDRuc
         Ay7n02T3+0Ex+PS9xyE3chc9OP1n80+LgJfEFulZHtY5jk67aroD1oZr8weVeaTryhOc
         hcPWzHNCDzT6vV9y6yPIybjf2LR4Q+rctSzPtDvzskKKhx7gFWBgl6k/tKtgjvRJFKBf
         RFPusvXxNyxXD3aGnJNJZxUdIzzQm40SNMUT0FYfIo7HHLJMS41St2WY/mVFSbeyJYa+
         dWKw==
X-Gm-Message-State: AOAM532yBZqbH2Hm2cf1T7YKgCV1ms9MKxl15HaH4/sKgAfAFHMbCNZm
        EjXDOXmFDzH84xUYlnUAqHMeswPcJRNgV8kEnojpNQ==
X-Google-Smtp-Source: ABdhPJwIndKOmeEx4PPwNBwhPt09B0tQMn0i2g4ul2GEkjoVT0CF1bU/9/Ka9Eh1FJRpEhDXxnGmdxECTwx795lLSC4=
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr525033ejc.45.1616429483036;
 Mon, 22 Mar 2021 09:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210322160200.19633-1-david@redhat.com> <20210322160200.19633-3-david@redhat.com>
In-Reply-To: <20210322160200.19633-3-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Mar 2021 09:11:14 -0700
Message-ID: <CAPcyv4ijmTQgPwD+mS4JfSC-=1dLM6jhMqt6vL8TJd-_FbZa+g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] kernel/resource: make walk_mem_res() find all busy
 IORESOURCE_MEM resources
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 9:02 AM David Hildenbrand <david@redhat.com> wrote:
>
> It used to be true that we can have system RAM only on the first level
> in the resourc tree. However, this is no longer holds for driver-managed
> system RAM (i.e., dax/kmem and virtio-mem).
>
> The function walk_mem_res() only consideres the first level and is
> used in arch/x86/mm/ioremap.c:__ioremap_check_mem() only. We currently
> fail to identify System RAM added by dax/kmem and virtio-mem as
> "IORES_MAP_SYSTEM_RAM", for example, allowing for remapping of such
> "normal RAM" in __ioremap_caller().
>
> Let's find all busy IORESOURCE_MEM resources, making the function
> behave similar to walk_system_ram_res().

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
