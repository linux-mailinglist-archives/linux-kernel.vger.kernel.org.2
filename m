Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B206A36E05A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbhD1Ue0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbhD1UeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:34:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FEDC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:33:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p2so30134149pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1UitsZpR0FImv5ggcDLypma8EKgOpgnJx3YkJXeeP/g=;
        b=ARndYMZQdTMTKo8NpDPqCuYDKZF9djP2UPKbAdC42uZHJJBbMeK0GE/suIIWmROC0q
         9nS0a4P6emTISkcViGmQk/z3XR4G9JRpfAadBQb/Qo66eE9w7baiUQ4lxzMjM1Kt6lPm
         WGrhIK7HSGS2a3KHvCIcIH3ny+PK9p4PqXxpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1UitsZpR0FImv5ggcDLypma8EKgOpgnJx3YkJXeeP/g=;
        b=V5sAroXEEMOIdc80zax/aSv0R8VEG6hshIgCXZnIk9lJnyFwYrw6oaoLuEuV/Sg/qr
         hDXy6nsveRQGdc+Hhm3G1iqMZOppiLwiOwe0gcJfkE5qP/Y0Ss3twKgocKrGnt3uC+00
         aGc/N6JvL2IbM3pKP4hRmKunGRNCV7touXVlGskLUM8PI8fIjtRKxQ4wvbXHdlyRiSgd
         /TVEQDCEu04QAsg2WsTmavyccVgwA26APmuj3SW8NVB6yIlv9y/9J3x0GyRM/NC0kInt
         M7KNpyITVw/FoBVGotBpwmU+BiU+VTs/wYIvik7ZHXG9H4DRD7gfs5rslqd13I7NX+yp
         1tmQ==
X-Gm-Message-State: AOAM531ItwjYAElEm4K89D9wv8x457dqorQWbwEE9bOdQmix8yld+SbV
        3gtJcSnzzTtSJYk+UMJ6vq35Ig==
X-Google-Smtp-Source: ABdhPJyExRbj04hU9L/qeRvDTKQXZcSQ1B1hKudxqf671tB0dKgDQVVHOB8oNmiG7IBV6qX21CsVfw==
X-Received: by 2002:a63:fe53:: with SMTP id x19mr28088284pgj.449.1619642010363;
        Wed, 28 Apr 2021 13:33:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b140sm491785pfb.98.2021.04.28.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:33:29 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:33:28 -0700
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
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v26 7/9] x86/vdso: Introduce ENDBR macro
Message-ID: <202104281333.D76723E@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:18PM -0700, Yu-cheng Yu wrote:
> ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
> component of CET.  IBT prevents attacks by ensuring that (most) indirect
> branches and function calls may only land at ENDBR instructions.  Branches
> that don't follow the rules will result in control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually.
> 
> Introduce ENDBR64/ENDBR32 macros.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
