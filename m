Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7544BA13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhKJBwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:52:03 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C993FC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 17:49:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso399886pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 17:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Q1Ic7kOOPETyhFj1cyuEbcKYl8I2Bp4M76inzkMgFYw=;
        b=JcAnLtwIyMNf+NQlLdTltzTN9P1vrtht48UYiVP+F3KKoXsfKMUrO9NfTaeljph4Of
         Vzlb/zeuw+bEjm6OT7k5Yn0baMAKCdyYJhOA/vwx/B7B8X27L9USKYnxUvmF5u957/tu
         bbbko4KszdScfVbNQupYSbrum8MHOlaGjSl+mXwhXma85vfySda772H3NqgYBCDrRz1r
         xGVR4RBFSw7GPbrvT6KMIYrbv/6h/t3Xt0VA9Q+5IA27yfD5wUYlHVIB6U0ASiuU41OO
         XrHz/MCfrgyc3J0JS/AqoHpj16VPyLlV07JzclV9mMxKn0a9W0oWHoZ++TMTv9eG6/ci
         emug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Q1Ic7kOOPETyhFj1cyuEbcKYl8I2Bp4M76inzkMgFYw=;
        b=DuEjizD3qzYtsZM5EKRzeywE4W4t+DYpSdlNs1qYQm8tB515njP6ASnKdqn7dpveW4
         S98VX0hvsjyhH9L558cMfzKydbFHqEN1mrFQvo488eLQa3ClY5bfc7f2Q2vMEXRR/b1n
         noQVDyXje4cmCmVzJ1/J5gE/I9Sr0E0LmmLcCZdi2prx6eIG+Qjn6Vn7IM2VTHtV+1nx
         xcutjbhSZKR5WAfIER0vcfIZgSJilJBZNXikX1aEzsu+5QBksdG1PW81J9BCfWT9O9BB
         pOb64x4hY17uAqyEDMcxfx328AfiVwzRYC+dt533esgr+grXyRrR4KYFU8+ztzNlTIYz
         5dag==
X-Gm-Message-State: AOAM533ZTIBjAHi9RODiT3cqFendhAzjXxRvJ3m+gQuRsqJ/cAkuG8Zn
        i6znOOa1eILo4FSEZvFirhQrag==
X-Google-Smtp-Source: ABdhPJywsEcL1jsUSgZb/S9gKVQtVO/v+FSrb8WQK3KYJE9KG+KL5Zqq+J57CUAmXi9vSqcMhFS5JA==
X-Received: by 2002:a17:902:784c:b0:138:f4e5:9df8 with SMTP id e12-20020a170902784c00b00138f4e59df8mr12132125pln.14.1636508956033;
        Tue, 09 Nov 2021 17:49:16 -0800 (PST)
Received: from [2620:15c:17:3:9e39:3ebd:7991:6639] ([2620:15c:17:3:9e39:3ebd:7991:6639])
        by smtp.gmail.com with ESMTPSA id u9sm12051146pfi.23.2021.11.09.17.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:49:15 -0800 (PST)
Date:   Tue, 9 Nov 2021 17:49:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Marco Elver <elver@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] mm/slab_common: use WARN() if cache still has objects
 on destroy
In-Reply-To: <20211102170733.648216-1-elver@google.com>
Message-ID: <146e59b4-76c-69e4-969-ce8a75ccfe5d@google.com>
References: <20211102170733.648216-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2021, Marco Elver wrote:

> Calling kmem_cache_destroy() while the cache still has objects allocated
> is a kernel bug, and will usually result in the entire cache being
> leaked. While the message in kmem_cache_destroy() resembles a warning,
> it is currently not implemented using a real WARN().
> 
> This is problematic for infrastructure testing the kernel, all of which
> rely on the specific format of WARN()s to pick up on bugs.
> 
> Some 13 years ago this used to be a simple WARN_ON() in slub, but
> d629d8195793 ("slub: improve kmem_cache_destroy() error message")
> changed it into an open-coded warning to avoid confusion with a bug in
> slub itself.
> 
> Instead, turn the open-coded warning into a real WARN() with the message
> preserved, so that test systems can actually identify these issues, and
> we get all the other benefits of using a normal WARN(). The warning
> message is extended with "when called from <caller-ip>" to make it even
> clearer where the fault lies.
> 
> For most configurations this is only a cosmetic change, however, note
> that WARN() here will now also respect panic_on_warn.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: David Rientjes <rientjes@google.com>

Thanks Marco!
