Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE43343FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCVLbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCVLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:30:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE7BC061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:30:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x28so20682689lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x6ubUNjx6+f9aZgR0qyvp8uW3/HtmY16lip4ro05SAQ=;
        b=ePRly2x2WoK6lN4TSv0XU6lzsR2b1uzRbvvlhjELd5TyYHPw2XuVFSAU/w/QAAL0P6
         FcRP/TpYnxj21I4LmrU4tQFPX7zH8OQqvZmdgaWZOwN8lx4drHJN150/ItdxDtW9jzjy
         S/2EtRXnEqKsd/+fr0zQohH6tjrWZtcE6RAmuUIQxeYGzS14Q7RROW6mswi0II1HF/hR
         nodgfYRp+OAQcIiVX/Q3pwwu5PXrHUNrpkEunO5uY+5zsVoxzNJFP9aZwG2f6UfuysA5
         j+SksoMuguCCM4UKbKN+M9tHfWBCPQRQvvM82LF1AePGt1kfGZ0BbU1DdCs3U6TRpgNh
         mpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x6ubUNjx6+f9aZgR0qyvp8uW3/HtmY16lip4ro05SAQ=;
        b=A5ILETgQ+sjIFgPBXZPLAefKsRIJnHL3anRqKCqqhn+1eU4n+4AfNC8oMY7qOSzDWd
         6k2XTA8wTqep2+9k2v5RxHUlhAIBkaPu6j8mxQHAETLINjKnszDwIsd0TWnfFUg9x1UT
         S8K6zNgQ8kMk7r8L8/anzv1kDmbNhpa7hxThk1uPhg1vHwmxMU5wL9TBGLHBNImZ6DFj
         x/pAu2WnWQ8+IbysWCH2A0+72vbHAzFq+TpX+alIKsaQ9jiAT/O2hGqSgxUH6keh+cYs
         c1jHKDpFzDcaj328EGXNZnJHsUZS5MFsavv3KORvpZQEsL9J4yx1bWkP/sN6hW+fMQRl
         wviQ==
X-Gm-Message-State: AOAM532eYlpo33fVsuIb0n4IO7ESGHQqG8C362fvuqTyAT7P3F7YIH3c
        lwGGR9WtIGh/W/uB3EE5YefOyA==
X-Google-Smtp-Source: ABdhPJwt98w+Yjrf6cZV/dNr/8CRCDoMtRfzLkiX7EM4gFIJmpMf+USTE93ZxQOXixhU6Ha+Gttf8Q==
X-Received: by 2002:a19:4cc1:: with SMTP id z184mr8354709lfa.599.1616412634138;
        Mon, 22 Mar 2021 04:30:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y22sm1543336lfg.133.2021.03.22.04.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:30:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3F465101DEB; Mon, 22 Mar 2021 14:30:41 +0300 (+03)
Date:   Mon, 22 Mar 2021 14:30:41 +0300
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
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: [PATCH v23 10/28] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Message-ID: <20210322113041.phqnydchvhyx35jb@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-11-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-11-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:36AM -0700, Yu-cheng Yu wrote:
> After the introduction of _PAGE_COW, a modified page's PTE can have either
> _PAGE_DIRTY or _PAGE_COW.  Change _PAGE_DIRTY to _PAGE_DIRTY_BITS.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
