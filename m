Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C277130FD89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhBDT7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbhBDTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:53:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39616C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:52:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l18so2435629pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T9AG0M0o5O+h9fP2xKRDxPlB8Ctdkqhf6o2D4rpy6+g=;
        b=RAOV7LdWTzqKAFqnvxTN/A7FE6XLME1YD2+exfJflocSTPK0YEmGOdX5o134MKOn3w
         3e132GGs/Rrn66muOUOTMHl/0FdfpJXiSp02skj/T7NO8geQxKHEM/K26V1fSG8W0vFq
         6AlcCB7zV3dWnr4cjWNj2b1nXANmZXfVYAjcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T9AG0M0o5O+h9fP2xKRDxPlB8Ctdkqhf6o2D4rpy6+g=;
        b=Svz0emwjWCYy0E45ZE3ppBLJj7I0w9CK/pZKTAFl09um1dAiPm2t7oVTwxbU67RBQ2
         V46PnHmPVJDaStDOva3C445EsrZmn+Jr/GBv5jiidsrh0yZ6xEbs/f1LVIqMzo2/Otuk
         qY9ENMgYLN1mSZ3FuCrw7t1y4TJLOwegbR6Y3gsA3KrYzWCAADWLV56x69kh8eBXD47F
         oGrtkOwbvVIO4PfJoi5TvNvs8zThO2Eh8LQlIg7Gxy3C00shT7ovic2hg6z2UYZ93A9k
         +3G39/4acIkBqVwa+SFqRW0+vbPfvLDFtOOemE8cMuQKcfMBBtvxqew0D/aVqxTZQUu7
         ZL6g==
X-Gm-Message-State: AOAM5321lF2KMKxcqj+2ePKznp3wA8FuEUDnkYSDteB0ZIQMTX3xttmS
        svyoEBZphWyRo3f5zUByGhsUBQ==
X-Google-Smtp-Source: ABdhPJzp+1ZimY7nJijJSKbz7msA3e2GL3ZygWVrX3UvWeThNpaUiW7HjJrS/JYH1z9vn0t+7eB3Zg==
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr595128pjb.44.1612468374865;
        Thu, 04 Feb 2021 11:52:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a24sm7359811pff.18.2021.02.04.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:52:54 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:52:53 -0800
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
Subject: Re: [PATCH v19 01/25] Documentation/x86: Add CET description
Message-ID: <202102041152.E257D3E2BE@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-2-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:23PM -0800, Yu-cheng Yu wrote:
> Explain no_user_shstk/no_user_ibt kernel parameters, and introduce a new
> document on Control-flow Enforcement Technology (CET).
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
