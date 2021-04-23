Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17DC369065
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbhDWKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbhDWKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:31:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D4C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:31:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h36so22622356lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nVeVlI4593fiW9RW+jOZR7+NI8aHLRggRFUJzlCEeiw=;
        b=L3yNbVR7vDqlEzKpr1hvuZi2AA3e606pV/+AC8izKBNA4rT7CETixrpyX1NTYvZ0ht
         OVTaTeyclEjTbP2SW+AKceSgQVQrh7zh2znDAAo2H4Jly6m9yz0kk3Gti6ludWRBO8Cd
         HIZjL1WxraFcf7p6X9KMDuEkZoIhf/+kf+zRXW38PJu/x1uuAAEBoaKwNSneD0gUuiev
         lBm1Vg6pdQo7t0GM5sQVpCEuHa6mIwqcbZm8VaMcqJNfiZYxhnf26a2rG/nvujI9KmVa
         8YsGuedLN7jGQtTcIscE7OCuiLkt2c9d6AARaaScixmWvKqjrPzSLKOXlO8A1uP436ch
         RMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nVeVlI4593fiW9RW+jOZR7+NI8aHLRggRFUJzlCEeiw=;
        b=tPQSsQxvW2tpxCDF9L4/6r82gArusqjHwR2cngawdKszkTOzNbrFezzr1XJ/ghffXe
         a5R2y+eLuNzOz9fG/I6IMy9uoADloWo7EICTRWbZysBJelZCiNL1hIDMh1A1ApQiuInW
         0VhwCcx0AQre/RXgyHeQZ2hcILOUutMWgUV4bmRvFdTLPkh8kUbABNCdYGT606sfvAQz
         DOkH4uTFtiAS+oFkfPDD9P0HTOX/Aeei6MbQ6eW3bP4SPfOjcbGeCxBI7J8YU5GknY7I
         J53+jcRGZ4ItIE7+OgDxyVK5EUnppMFOr1pX4UtuFok7mF6XjaKvZkEF6GonETcmXWkH
         KIIw==
X-Gm-Message-State: AOAM533jiwteWKVdoFkAJ5tANniK4uJ8HSPG8M19O+5JVQgKIp6/YcFf
        rEJeTNpNKQhWvdAf32SXDUeeSA==
X-Google-Smtp-Source: ABdhPJwVNorWa+AWglF5pbaAmSR9Pq5BC71Nyf4ZYyqMrppUpW+kSLOMonXik1nhCbMjO9HNpZZ1kA==
X-Received: by 2002:ac2:4a76:: with SMTP id q22mr2191519lfp.475.1619173873766;
        Fri, 23 Apr 2021 03:31:13 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j9sm512647lfg.49.2021.04.23.03.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:31:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E64B910257F; Fri, 23 Apr 2021 13:31:14 +0300 (+03)
Date:   Fri, 23 Apr 2021 13:31:14 +0300
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
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v25 21/30] mm: Re-introduce vm_flags to do_mmap()
Message-ID: <20210423103114.3hheurux4ixccrwv@box.shutemov.name>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-22-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415221419.31835-22-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:14:10PM -0700, Yu-cheng Yu wrote:
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
> 
>     commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
> 
> There is a new user now.  Shadow stack allocation passes VM_SHADOW_STACK to
> do_mmap().  Thus, re-introduce vm_flags to do_mmap().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: linux-mm@kvack.org

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
