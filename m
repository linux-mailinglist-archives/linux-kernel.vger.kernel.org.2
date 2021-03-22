Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92420344001
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCVLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhCVLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:38:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B1CC061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:38:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r20so20614439ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYQGe8GavJNNQqRVgKmXAqfd/LyDn5OkU3yK0hg/4Ds=;
        b=Mv8hzSF9y/WlPpAJoV0/oEmocDMZi3VCHHD1hVvUTkZJ7qEWAWnJxRXeCr+OHb5HNn
         eY7Dxmno2nebZDo/jr3ffQqERrasGX324IDrbmh0YqW/3M2iAwCjalyN9DiG94jWvfVl
         9ECZZ+H87jPB+Lzt9FBAgBuOBOeWOpNtrNjoB/ndPCLCB/+LtjgU5jQgaqHqZzEBVp4e
         +4IMIPORukxDUlKUYmQDQmEjR/9dHQxDGo45e4Fv2aa0hU8ukxyzogwyd3XzjwG40e+L
         OmuBlsWP+kqDFGWSPQiPxCfGDa8GllhzwiSc54smaN2fCDEIT01/8DwkN0yBOBbP2jL7
         sBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYQGe8GavJNNQqRVgKmXAqfd/LyDn5OkU3yK0hg/4Ds=;
        b=oLEOT3JTBig9W0IbIvCEio0gYy1JyOnQrlPxkEZo7qtd8UY25MD9JgW8CCMKiwqdJW
         tPRiczjv+RFs2qD/nYwynTByYQDLkTvMmEGVZeuAbW9WXBo+lMCmTJ7PlHl1QBvph9mD
         +tvzIq7QbJ0ZR5axfU9D25MNr44xb/Wl2NgfBnSDc83D/TgrWQ+3S8zlMcO3MlwuinhF
         AahxuSGmLh9PxjxnC3ZfKyhI1TL6MkAZCXwt/jnj8rSrZ7or4QV+DmJQftvLZvvBXp61
         VpfQGE2w1bG7a1+EZ2gbtDWA/YNe45Tv1fjxtHCaYQ4aK1qWGAXS7UiuhNYkRR+KZoD7
         2iRA==
X-Gm-Message-State: AOAM532HNjQI+Q0jz8NoNTnqAy5zhe4YJj8T/J91ktGMAZapyv3vpToJ
        w3at/zNZ4yz3QE3KfSluTkj9IQ==
X-Google-Smtp-Source: ABdhPJypWrQG3ZuDSQnHHtofx4HFDssoJDVyC/HSlMvOsjsQ3kQJLqjwWXFFLw5UM6XnXEB17KFpUQ==
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr9499521ljo.279.1616413122447;
        Mon, 22 Mar 2021 04:38:42 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l12sm1912343ljg.39.2021.03.22.04.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:38:41 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5BE39101DEB; Mon, 22 Mar 2021 14:38:49 +0300 (+03)
Date:   Mon, 22 Mar 2021 14:38:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 12/28] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <20210322113849.snfoxcijpwoks4go@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-13-yu-cheng.yu@intel.com>
 <20210322101502.b5hdy3qgyh6hf3sr@box>
 <YFh1fabrBok74F8X@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFh1fabrBok74F8X@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:46:21AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 01:15:02PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Mar 16, 2021 at 08:10:38AM -0700, Yu-cheng Yu wrote:
> 
> > > +		pte_t old_pte, new_pte;
> > > +
> > > +		old_pte = READ_ONCE(*ptep);
> > > +		do {
> > > +			new_pte = pte_wrprotect(old_pte);
> > > +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> > 
> > I think this is wrong. You need to update old_pte on every loop iteration,
> > otherwise you can get in to endless loop.
> 
> It is correct, please consider why the old argument is a pointer.

Ah, right. Sorry for the noise.

-- 
 Kirill A. Shutemov
