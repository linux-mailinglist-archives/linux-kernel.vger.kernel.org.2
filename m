Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369F930FE66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbhBDUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbhBDU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:29:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC7C061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:28:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m12so2359350pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IZXHMkkF5la794RToqIjRZW5Sf0o5ADpzH8P/DUSqM8=;
        b=WPv79kCio4eGaa+1n6kJbUiCr+03EUTatrYglWJE03qfeFrKHQzZVbBtF49ld+k4ze
         7lEEgOI28vEeRahv9M+5hNCWfrIKDpDdagm/LThs/rcnb6mqbDMlpyjeSuswWn5/cjQF
         8HEg8Q2Ubdq/QtSINwilr9Xr1IyuglpkxjnlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZXHMkkF5la794RToqIjRZW5Sf0o5ADpzH8P/DUSqM8=;
        b=Iksh5UCPHWX/vsQEdslv1cbUdvSp3XkR3xpopAysBASiHvslpu01L3Nuswp5rd5+iv
         DRT3TZzPOrqW8Nxw7sCf0v200xK4DuIG71vGx6t6aNsRrXZaBK+lHHcU3n7/0w4jT5wp
         FSngAumjOK4nZ61VRee9gTT5gnicsshlZZDAgOIXiRnOLcLmNkqZx463tHX9Mabcvy/R
         S3atODIiCiY1cyL7+sjtKZA0oA9c4mfZ8VkwmsIFmwQtRQTV/KjbuGHBl5rhUJLDSPSg
         RX4IlgaBbZzIyhaXyFQ3vkRuX4utSQnNPigCPw4UmlCpM1P2Btc/ZhZD0laUzDE5JJhM
         /32Q==
X-Gm-Message-State: AOAM531larp2FPa+zYgcFAqGH0+JVtzJ0/fH+t/nbwxvgHpE1B/URtiU
        iQ74Ye7h6Z7EOEPuqBki7IuCaA==
X-Google-Smtp-Source: ABdhPJxaLK/3FaRcCdBuM/ynvQhoUqRuwNE06CjEMBKRxvH0MC7s6Ljyc3PQcHyuCfh0R5pvWUrRfw==
X-Received: by 2002:a17:90b:4d06:: with SMTP id mw6mr708971pjb.24.1612470488976;
        Thu, 04 Feb 2021 12:28:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b26sm6838438pfo.202.2021.02.04.12.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:28:08 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:28:07 -0800
From:   Kees Cook <keescook@chromium.org>
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
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v19 19/25] mm: Re-introduce vm_flags to do_mmap()
Message-ID: <202102041228.E6FED55C@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-20-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-20-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:41PM -0800, Yu-cheng Yu wrote:
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
> 
>     commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
> 
> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
> do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapper
> do_mmap_pgoff().  Instead, make all callers of the wrapper pass a zero
> vm_flags to do_mmap().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
