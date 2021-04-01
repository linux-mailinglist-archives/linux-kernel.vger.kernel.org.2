Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A073A3521DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhDAVqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhDAVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:46:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5DC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:46:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j25so2392777pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=usJD8QXCUUQ3yDD19nRhcfJUMWYiKf+EiZNOMzSngU8=;
        b=G4ChGKwb73jivZgOdREGW7Jl/xK+07gkogP9+1kyu2QispNTwwRqLKZMdl/YtU/+Lt
         /6pS84xtYTduYfABsJSoN4e+N+/d5AQAGm1DhERFMawsMiwP/sKWF3z+8kShjCvWc2Xx
         J1qo99Tg1cz6t80SOTCoCClKVew6dbnE2D8Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usJD8QXCUUQ3yDD19nRhcfJUMWYiKf+EiZNOMzSngU8=;
        b=pocvOOT/cHtZ3eyV0qwnsJJohYRhsoNlIx0FPJ7jcdneSoWXbJf6c/a/pPYidO8E0Z
         na5zbFEUzeLeX7IG6ChS0oznj7kBGOb88QkovxQNhAR5hIIhWnzB6XMu0AKmCL6sJ5Ua
         V+tJDl9Qkd6fpOCPYikevlzkJyI+bB5m4EabsAU92PcoFnU3RxAXOrzJIKGHvT899nso
         UrJic2zrHBAJJZFOXz09nxRiSX+MzpllUqJXZV8x+MI+oKjocsJzUy6AJULBgZ0GXRwS
         QeBESJVPQdS9u8kJJklp3DsCrNNdna5qQbgN0Z4hL78va2aFUrmlTugV5CNUaFZglmyi
         rv9w==
X-Gm-Message-State: AOAM531ik2r+ZrRyIDetTyu0IGckoX8wXKQIiGywniP+LWlFtwf9hpj8
        YmOROKRbzg6etgnxlVR5SMnxVg==
X-Google-Smtp-Source: ABdhPJw2Igjg2dUPUc361qNdAsnz5koMvMjgAifwUOU3txfIVOmKgYERtvxS6R3TbAJ8ajqzLbNIRQ==
X-Received: by 2002:a63:2f03:: with SMTP id v3mr9286709pgv.408.1617313584551;
        Thu, 01 Apr 2021 14:46:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x186sm6325466pfc.65.2021.04.01.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:46:23 -0700 (PDT)
Date:   Thu, 1 Apr 2021 14:46:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Roy Yang <royyang@google.com>
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, corbet@lwn.net,
        david@redhat.com, elena.reshetova@intel.com, glider@google.com,
        jannh@google.com, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@linux.ibm.com,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 0/6] Optionally randomize kernel stack offset each
 syscall
Message-ID: <202104011442.B20F2BAFC@keescook>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210401191744.1685896-1-royyang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401191744.1685896-1-royyang@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:17:44PM -0700, Roy Yang wrote:
> Both Android and Chrome OS really want this feature; For Container-Optimized OS, we have customers
> interested in the defense too.

It's pretty close! There are a couple recent comments that need to be
addressed, but hopefully it can land if x86 and arm64 maintainers are
happy v10.

> Change-Id: I1eb1b726007aa8f9c374b934cc1c690fb4924aa3
> -- 
> 2.31.0.208.g409f899ff0-goog

And to let other folks know, I'm guessing this email got sent with git
send-email to try to get a valid In-Reply-To header, but I guess git
trashed the Subject and ran hooks to generate a Change-Id UUID.

I assume it's from following the "Reply instructions" at the bottom of:
https://lore.kernel.org/lkml/20210330205750.428816-1-keescook@chromium.org/
(It seems those need clarification about Subject handling.)

-- 
Kees Cook
