Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1797E36E03D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbhD1UaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbhD1UaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:30:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B803C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:29:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s15so5095643plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UeII31CqNuFlE2BoTtr+fZN9wyzsy3hprcPYll4covw=;
        b=jylj96Rw3QUQm4doFDBK0kop0iQgCV6NfySkOr5T98cqbEgl0duruUVIG5KC7g1OvD
         XbTL/oRiSQ9ur3CZJRvyYbHIxY99dg3xegs4Ok2C8JzBM74t3TX7EC/VLwhZfoPz+u4/
         RcByLq8jJDIgsj0tknp3coppc77n13njbPFO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UeII31CqNuFlE2BoTtr+fZN9wyzsy3hprcPYll4covw=;
        b=Rxi1WxVnOgidHps4ZgCpnuX4Var8mrDlV6BEwEGHjx88uB3y+d72Xn8slLElECGHOW
         j/2vivdmKVgGLUAbcCFLhfT69R6xIQtsv6za/IVC9mZC0QXvr5EtGyI6gxtscFGHMOjo
         70o8xAG1MahX23boJ1/AJyN2WXWmohWaFcdGC2exQNIEwkPlpaN8BwCDVQFhvTdsiXUN
         LFfGOBRvc3bT9lTVaEShnm8clE0Vmu3IttoEebXrmQpSt324nU1Xb/ZUYFvVPXf2ueaZ
         KMqT8XThifVmLS8qUeGFUh9NUj1U2TUp+xN7S2+2kEkr7kuRKv+zQFM7lIv0OQvkj21/
         gWEw==
X-Gm-Message-State: AOAM5304mnET5EYsb4beBmSEajmBMBsqZXGfabU/GESs/xBO1OumnFqH
        OfxtbNz2MvaBjuYMqCSJ3gu20g==
X-Google-Smtp-Source: ABdhPJwYkEDNlOuREptaQ5l3kQMV3gSjH3e1SrIdJIlzfjRSlDOr3aN5Uamkiddf+M4fmetyZadajQ==
X-Received: by 2002:a17:90a:8c8c:: with SMTP id b12mr36346748pjo.35.1619641762540;
        Wed, 28 Apr 2021 13:29:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm516116pfi.0.2021.04.28.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:29:21 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:29:20 -0700
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 1/9] x86/cet/ibt: Add Kconfig option for Indirect
 Branch Tracking
Message-ID: <202104281329.564AACB@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-2-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:12PM -0700, Yu-cheng Yu wrote:
> Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
> oriented programming attacks.  It is active when the kernel has this
> feature enabled, and the processor and the application support it.
> When this feature is enabled, legacy non-IBT applications continue to
> work, but without IBT protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
