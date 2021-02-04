Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E6430FDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhBDUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbhBDT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:57:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C69C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:57:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s24so2313769pjp.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mc7koCFdBCM4QqjJSOU9cMj9Z1hXBQ4lmWyrTn3L0c=;
        b=EnD8y5C9tnrx7mX24x0SzpWobewSUEg1SAdrluNCKUh12ljNCsVkirYqiShSKNlsKa
         xsRi+eb+jTferbjeWUAFTZcgQYeDzubETPjwMBp58Msk92q3Hys/Nc4CJaACBm3/rjRC
         GvNCjLeIsVfLb9UgxqgnuVtL8xuHQDzZ4nhmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mc7koCFdBCM4QqjJSOU9cMj9Z1hXBQ4lmWyrTn3L0c=;
        b=rGB0PIYMHAX6LTpejQcPIYtYKFLHoYpnbYmgUexrvz0pIKe4KoLvyl2PmMBiXpw2RY
         7yqlXVSprm5l0puf81d+GmW//hZoEbLPCEO68fNWwbCwCktXURf39bbVtsoqqqi0e8Cv
         ciDoJmo8LZOOk2eg6jyAwt0CdM1NgLctOJrT9KRV+Tovb7rACSlvo/bkal8FDOgEmVYY
         XJzcD1BfrcK6Sd6cQ3up8XKZdJ1rP4gdw7QWYbbZpsdg0ICH7hyaV1QFu0UaEimi+2TJ
         3o0ewHOrPpZhuklE+6U88mDn6YidLwTfkb5pQxLFLSd5X1LmFXHU8ngilQhsLMzTFObu
         gjJQ==
X-Gm-Message-State: AOAM533slzVnZcBYl9O/MhyteXOiXTcl3ZKcAuDho+h6tDfzrBvsw2eU
        c8PgrcMylilE5j2U7dw/sBIebg==
X-Google-Smtp-Source: ABdhPJwtXiBuI/xhNFZbYjzoCMZ7QTIDZ72P2hHtcVx/bckk4z+4MIhXEnynF9XH7xe8pNQlO3pu3g==
X-Received: by 2002:a17:902:82cb:b029:e1:2b0f:da57 with SMTP id u11-20020a17090282cbb02900e12b0fda57mr748892plz.33.1612468634241;
        Thu, 04 Feb 2021 11:57:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm7150366pgq.1.2021.02.04.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:57:13 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:57:12 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 03/25] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
Message-ID: <202102041157.05BDDAE1@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-4-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:25PM -0800, Yu-cheng Yu wrote:
> Add CPU feature flags for Control-flow Enforcement Technology (CET).
> 
> CPUID.(EAX=7,ECX=0):ECX[bit 7] Shadow stack
> CPUID.(EAX=7,ECX=0):EDX[bit 20] Indirect Branch Tracking
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
