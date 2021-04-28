Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3136E050
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241965AbhD1UcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbhD1UcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:32:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A59C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:31:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o16so19912020plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X8hdJrj+BWcDqZ4bW4h2pNAqs92BmI2AsU4ld/EBkiw=;
        b=iI0jec9SDqWTC7iVkmmleZKmFxnoAhgXjmhD3GBMXI6hAcgWgxdE8rk8pw1d8gwKEe
         jiiEowLOMDPAOnn341yCsTffY8AeQm4SMl8U1OQbFW8sXyyX3ojyqLLXxDHGhi6FZYZi
         kwPvnwSRg8ZIzYwNIHaDMsdRmYUm/aznEAU5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X8hdJrj+BWcDqZ4bW4h2pNAqs92BmI2AsU4ld/EBkiw=;
        b=kp9cI6x5mWbJo3Vnw269ljzXWFfuMlwFMLYtsQ+ObnHkDq6XAaYECl+xu/52ZpsSRB
         sSFXcueZpFnhhMRWpIKaV9kx62tCeBYkF5qIlFPxonfABWyB1PvoKHM4xdSGXVU2Rq55
         VBEIMEkHFTvd+sd5rfFexEKF6h2KFrpQUYUU/xEVS4EDwlDKE7R55CrODyDyDJkjzDU3
         RcbRu6qBKn+au9LEpTnktfV7Hl0410Th1uSYXDjIDzokHdhtOTCLzOYvEkom7R/oHAaj
         etwwrzcyUY0r840D5QPl7GR/JPBHWcr43izFAF56p7b/cxXCLmb/cRYu3fwTKJF+kCLB
         xSyw==
X-Gm-Message-State: AOAM532UJrGNpNw+vbeohjjmkUTOtvlpeOmzxk1ngl02Xz3k3vqG2KEJ
        BDTFHWckfpnwsoE7kWx1JcoX6Q==
X-Google-Smtp-Source: ABdhPJzu07p9Ep6FFlV4ekxK1JTBTpTjmwV6obAgpk10d2D/VzX4t6Ftslv5gywEH3Rs23w7Ak1szA==
X-Received: by 2002:a17:903:185:b029:ec:b44d:7c3e with SMTP id z5-20020a1709030185b02900ecb44d7c3emr31893977plg.44.1619641889956;
        Wed, 28 Apr 2021 13:31:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm448450pfv.188.2021.04.28.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:31:29 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:31:28 -0700
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
Subject: Re: [PATCH v26 4/9] x86/cet/ibt: Update ELF header parsing for
 Indirect Branch Tracking
Message-ID: <202104281331.1CCFEFCF1A@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:15PM -0700, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates features the file supports.
> The property is parsed at loading time and passed to arch_setup_elf_
> property().  Update it for Indirect Branch Tracking.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
