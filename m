Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF723CB238
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhGPGNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhGPGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:12:59 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF4BC06175F;
        Thu, 15 Jul 2021 23:10:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 77so7651055qkk.11;
        Thu, 15 Jul 2021 23:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HkvTd5iaIk2sznDHmB0qT1piFPtlRiXutiCKn07Cliw=;
        b=hGEWMRCoK0tYN0OHIdja7INAL5BRsZO1/CJW7miWVlFa8DghO7aXJcLZFFb9m+x9lr
         FZ7Hnbi0FQPfKu2VdUTkhUwk21bVtCMLIhUKIJm1uCaqQmE/9CZYQ37T7eGuHZARGYZ/
         ifIpl6i/LuZqrpl27GRqjm03R8h+DJu29PJtzGe/qLOrsZ/fDpuwLzSihZO4Rsbiau+B
         PXrBLPi3t9zZIwOoAhKxkmlqkh3KbjJ5zCbSI2ttZi8pCqCYQGf+fdIER+HTrJ2ir8Ee
         6aHY7havqp/y7+uiSmxH7UaOFLE5+FtyhJv37MdIvyyKMKOnGFCMSvbent0i/9yCKVLn
         OISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HkvTd5iaIk2sznDHmB0qT1piFPtlRiXutiCKn07Cliw=;
        b=A/MAjk2XWVu/lnuyl33QLPNl7VJwxkkZiejp/gNB4hCH4yzcfleV+3+BVOFipqUpHv
         ugYdBMbEuIBUZUygkU8JcbD80N31oQ7prQNgsDfvEqnzK6FwBCzqDkSNkJ4nWw5ITz/o
         WSV8115e1XG4Dl7X98HQot1+ABS0XRZXjtUJz7TEjGjnfj0Gi/V76Hj530GhcC3epDgE
         +ZkdmTY47coeuKdaxH9WtsDegHjepEsxMrNoc45mJD0Jpf5pOk9gOSdEJhPaWnX5tD6d
         ytKR3Ch+AfSqvUGd1gtPDMExmP+xUHsU5B9jYITAzoV0hplYl6fYycwQ0iPVQT3G1WgV
         01Bg==
X-Gm-Message-State: AOAM531L6XKrKHicBHmTGfd/7QQus+KsVyWj0xBygEmwwxTnfzO776J6
        0gSD+kZZggEkbKNbyeYtYA==
X-Google-Smtp-Source: ABdhPJxWIyd0ZBU3ZsoFjHanCPdlt/csPNBfJqsVJGF3CzWaU47iVlkiLK4SgGW4GChUM3L37uY0cA==
X-Received: by 2002:a37:45cf:: with SMTP id s198mr8045552qka.267.1626415803783;
        Thu, 15 Jul 2021 23:10:03 -0700 (PDT)
Received: from PWN (104-9-124-193.lightspeed.sntcca.sbcglobal.net. [104.9.124.193])
        by smtp.gmail.com with ESMTPSA id f1sm3481330qkh.75.2021.07.15.23.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 23:10:03 -0700 (PDT)
Date:   Fri, 16 Jul 2021 02:09:58 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Zefang Han <hanzefang@gmail.com>,
        Wei Lin Chang <r09922117@csie.ntu.edu.tw>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: x86: Remove obsolete information about x86_64
 vmalloc() faulting
Message-ID: <20210716060958.GA2197@PWN>
References: <20210622031910.141262-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622031910.141262-1-yepeilin.cs@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
> index ede1875719fb..9798676bb0bf 100644
> --- a/Documentation/x86/x86_64/mm.rst
> +++ b/Documentation/x86/x86_64/mm.rst
> @@ -140,10 +140,6 @@ The direct mapping covers all memory in the system up to the highest
>  memory address (this means in some cases it can also include PCI memory
>  holes).
>  
> -vmalloc space is lazily synchronized into the different PML4/PML5 pages of
> -the processes using the page fault handler, with init_top_pgt as
> -reference.

This information is out-of-date, and it took me quite some time of
ftrace'ing before I figured it out...  I think it would be beneficial to
update, or at least remove it.

As a proof that I understand what I am talking about, on my x86_64 box:

  1. I allocated a vmalloc() area containing linear address `addr`;
  2. I manually pagewalked `addr` in different page tables, including
     `init_mm.pgd`;
  3. The corresponding PGD entries for `addr` in different page tables,
     they all immediately pointed at the same PUD table (my box uses
     4-level paging), at the same physical address;
  4. No "lazy synchronization" via page fault handling happened at all,
     since it is the same PUD table pre-allocated by
     preallocate_vmalloc_pages() during boot time.

Commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for vmalloc
area") documented this clearly:

"""
Doing this at boot makes sure no synchronization of that area is
necessary at runtime.
"""

Should we remove this sentence, or update it?  Any ideas?

Sincerely,
Peilin Ye

