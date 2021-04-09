Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A725235A1D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhDIPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhDIPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:16:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF029C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:16:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 12so10170895lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Z/yYSNAypvLdcknWdN0jFKSTVmGg2skM4f2irCe/+4=;
        b=F6WCL+h0/tP9in+fDqwT0cY3mMu3UVsk7LgdOGzIIy+irtGR0w2X9fIQdkSR7xRD8r
         qP/FA+1JIVvPJF8oaP10W0+t4M3RUjWjn9WFbABDNr8k5khi8T1y8jpPH9Uuuxp7jJQp
         li5UhFx16sJQYASv+x53DDCGLFxBuKWm4ncrsUyJ+s9Rd/Jld4NbDsr+ZIb351AKQCDI
         /Aw7CgUuxAfkKgkUgZEU/yBDqwNItOTV/h5C5u9vhJGK8p7SfQeWaob4fAnHSgxiwnTF
         S7UH1hSKQdncOqaMF1+rDkbOh1HBu2G+1tsKM+xL9G+Hu0cc6rT74yo8tFIyU1xbLTiv
         ZLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Z/yYSNAypvLdcknWdN0jFKSTVmGg2skM4f2irCe/+4=;
        b=rJek8WRA7wIU6bSvOcAk/lAg3xOg+Vl5th5BQb6cvEKQoWi58VUpZ2uv1YbfFSkAzO
         NOEb3l4DFSIOBA5VKu+oO3K0jECWzh7j7G1vqIhvtl8qcEKaeG/xMHarSe+O9ThjZ1FR
         Uy5aw8mJLAYtGEeWEFy8/SUXNRtL0VIoH+u+2v7t8k2i7Qj58moxlHbbdJDLQZRGK55w
         4wah4Mk8A5idEf/gpDnlmPqaEzYxcC+LVDZpIsV+iIhWFRYSjOO7FNFjNgJFnoQTyJzz
         TmOaOI7ky+aKrHd/tXWYTlLHwC0JzclHsd1AJnAsFcmtNB7gAfRLqLmUpyVphiVGhPnF
         Lslg==
X-Gm-Message-State: AOAM531hKkUYxrHs2p70vy5XclAithBihqJFZltWdGts8RrDTBphX2fD
        e3NNT6uVjDfDeMkMXb1hyZ8Cjg==
X-Google-Smtp-Source: ABdhPJxZOdHJXf6KM2DKtMXusgwm4xwoirT3CFK/2cTbRJYimDigKyBqA3B926lUdKv5znBu6nRu7A==
X-Received: by 2002:a05:6512:c27:: with SMTP id z39mr10687224lfu.244.1617981384391;
        Fri, 09 Apr 2021 08:16:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e11sm299296ljj.59.2021.04.09.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:16:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 35536102498; Fri,  9 Apr 2021 18:16:23 +0300 (+03)
Date:   Fri, 9 Apr 2021 18:16:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v24 15/30] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <20210409151623.ffydw3ckzbl7qboo@box.shutemov.name>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-16-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-16-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:49PM -0700, Yu-cheng Yu wrote:
> When serving a page fault, maybe_mkwrite() makes a PTE writable if its vma
> has VM_WRITE.
> 
> A shadow stack vma has VM_SHADOW_STACK.  Its PTEs have _PAGE_DIRTY, but not
> _PAGE_WRITE.  In fork(), _PAGE_DIRTY is cleared to cause copy-on-write,
> and in the page fault handler, _PAGE_DIRTY is restored and the shadow stack
> page is writable again.
> 
> Introduce an x86 version of maybe_mkwrite(), which sets proper PTE bits
> according to VM flags.
> 
> Apply the same changes to maybe_pmd_mkwrite().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
> v24:
> - Instead of doing arch_maybe_mkwrite(), overwrite maybe*_mkwrite() with x86
>   versions.
> - Change VM_SHSTK to VM_SHADOW_STACK.
> 
>  arch/x86/include/asm/pgtable.h |  8 ++++++++
>  arch/x86/mm/pgtable.c          | 20 ++++++++++++++++++++
>  include/linux/mm.h             |  2 ++
>  mm/huge_memory.c               |  2 ++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 46d9394b884f..51cdf14488b7 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1686,6 +1686,14 @@ static inline bool arch_faults_on_old_pte(void)
>  	return false;
>  }
>  
> +#define maybe_mkwrite maybe_mkwrite
> +extern pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma);
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define maybe_pmd_mkwrite maybe_pmd_mkwrite
> +extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */

Move it next to other THP-depended stuff.

Otherwise looks good to me:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
