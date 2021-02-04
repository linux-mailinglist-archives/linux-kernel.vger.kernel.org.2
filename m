Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04930FDB1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbhBDUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbhBDT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:58:50 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC35C061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:58:10 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g3so2348736plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WHZcK8QVoi2vD+8PmR3PN87wlH3ll61Of0Qx4MDMC64=;
        b=molOl3IaFUBpm5yvQ+A9OSIeN/orT8NNAi7aoCp/sWRTGk9g8W86tnSPVFkc6HCXf9
         hsJE5R/PsP/yXgKBnMfhV0KWTTuF8GznA2Hes0318EUCdxwVk1O/ne9RKEddHsRO0MXM
         Pm1woq1H8TFsGBL88AcxlJjWoS26XDCKZu0Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WHZcK8QVoi2vD+8PmR3PN87wlH3ll61Of0Qx4MDMC64=;
        b=XhkoW/TNzJb6oAE45NQAUqS9k3HibryofAY+bT/M4JnIGIPQBdh92JNuUumFcoLeNd
         s2UscMNJL2wE+7zaWxY65q5rCgHCErJjKFpKA/LqXFRxSAOX/6ejCubgVrmleEBdnL6F
         8pgtsoJt46mH17H0HemKZeuStW73wVVu9sOaSyVP7Cx5CvkLe9pds+m0V8gYmXWHIDPU
         /IZRGoI3tRqj4Q4AwSq3U/mbA//QeWh0DD+IWE9i6NsQCB3txLD9kbCd3IqZmF1vSweI
         fwHJddY8Nne6m0nLXBg3YWZEyN6g+IMPvWVyPXeQeJQ1GnnRGcyDqd9DK2eQZmn5oGCI
         f8ew==
X-Gm-Message-State: AOAM530Wk1Uy/hqSALbc08ZlC3GtuZEXUuz+ZiRHqa4wgvhBjBofHBSh
        /DrtezZNA3/A0YICdmFQeRm9dw==
X-Google-Smtp-Source: ABdhPJxtMvQzzAKeafYu89Dua1ck4lx/YDvotcfb9toALK3g6OzDBl4EIMTFJTA/ZhIrZDHFEQPLzA==
X-Received: by 2002:a17:902:bb8c:b029:dc:2e5e:2b2 with SMTP id m12-20020a170902bb8cb02900dc2e5e02b2mr702471pls.10.1612468689661;
        Thu, 04 Feb 2021 11:58:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y124sm4219551pfg.166.2021.02.04.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:58:08 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:58:08 -0800
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
Subject: Re: [PATCH v19 04/25] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
Message-ID: <202102041158.9EBAD9392@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:26PM -0800, Yu-cheng Yu wrote:
> Introduce a software-defined X86_FEATURE_CET, which indicates either Shadow
> Stack or Indirect Branch Tracking (or both) is present.  Also introduce
> related cpu init/setup functions.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
