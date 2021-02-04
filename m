Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059A930FE7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhBDUep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbhBDUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:33:51 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678FC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:33:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t25so2952236pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NeprK6JinSqU49dQ1nFPWFvDyk0tPt3L+sHTBjkAdOQ=;
        b=D8TSY/I574CxB1blhR9D6u6bOcOmqMCyck3xJ5THhC5s9Yd8CgpIT8NoEAaCVNnzIF
         hqt9PagwwXSj48djg6joitbyoM/L0tatsbpJDqfEOWr6yEJgz3sBN1eQVR4sg21XZUPY
         mkH0vkZw4SIIvp4oxgImT0qojz0l3OFPib5Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NeprK6JinSqU49dQ1nFPWFvDyk0tPt3L+sHTBjkAdOQ=;
        b=EuRmSUp2k1UGta2tbK21ug7m+96RtQUo7WE+1eUVTnnn2vlQQqksPCzJNnf/+jJd/g
         m57zVEaU08Y8kgOHVhzICmpfYo2VVyVPWhmnT5xmC51N2z7HLjT2P7N32e/Mj9rDQ2FZ
         VjJR1fysPP2MHGOEp5vqt5HVyGHoyOUdl4erU2M8XN+r7ptkyMtfomDtTvUfq6cw3LlX
         hXiw3sFk8dQ+oXgsRjcJrPYZt5i5Ari2PKpszz+AMGEyZ+koxDJRV/rcrc2mbshmDxtU
         u9w6HOES7gBRTW30MQtGDHCgo8XKQtaUXZZ/dbyQSGg8kWztKrDlUP3ctnKAs0/QcEHK
         qU9Q==
X-Gm-Message-State: AOAM532KyTGgeTACaiIoD2gePj0vC28AixxIMl87agaD5+Zodh/B3x+v
        bxPNzaOop7wKk8lzUKypa0zCjQ==
X-Google-Smtp-Source: ABdhPJwJ8tkFZ1GvM2rS6EIJq9lw8kHUx/wvUF88J40CKTwNhAGVZNsM8/4iFq1PZVwRDJJhoNR3nQ==
X-Received: by 2002:a65:6246:: with SMTP id q6mr807193pgv.6.1612470791075;
        Thu, 04 Feb 2021 12:33:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r14sm7806546pgi.27.2021.02.04.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:33:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:33:09 -0800
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
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v19 22/25] ELF: Introduce arch_setup_elf_property()
Message-ID: <202102041233.2FCCEABF1C@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-23-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-23-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:44PM -0800, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates arch features supported by the
> file.  These features are extracted by arch_parse_elf_property() and stored
> in 'arch_elf_state'.
> 
> Introduce x86 feature definitions and arch_setup_elf_property(), which
> enables such features.  The first use-case of this function is Shadow
> Stack.
> 
> ARM64 is the other arch that has ARCH_USE_GNU_PROPERTY and arch_parse_elf_
> property().  Add arch_setup_elf_property() for it.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
