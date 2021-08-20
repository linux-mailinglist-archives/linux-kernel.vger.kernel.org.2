Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD6A3F2680
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhHTFea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 01:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhHTFe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 01:34:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B694AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 22:33:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mq3so6567159pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 22:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t77CbxubGxEGTMmMwfQTPijc/96kf1szGuSMv1EFAD4=;
        b=Ja222Isqq11kr4ZhqVigTCcrL9fIFtekeWme0RhNsM6otO6PdQquD7rbRU6+ee4EKm
         XhdcOSsskOxlBbZcG1GD5chnwgliVOp9yQsp5Nu7/g4B1ZIGmfUmWUnWSqXnXG/mH/vN
         QiqPfBEv/7xk8Mw9NlHeSrwnpWhRQHDn5K0ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t77CbxubGxEGTMmMwfQTPijc/96kf1szGuSMv1EFAD4=;
        b=U5xCyBRQU9ZlZJNgk0qMo0j4KA2w/knHUSAw7ocFk02RsuQ1WGcsTMtb29GuHTiWW8
         v3DszIpUMfMCWuppv4DRbLELrjz16HfPUMMhZVMaMXGaPYpauNH73yCgZ4ASNliGa2ZP
         SkiaTHHoIWM+LIJZ8oqDgQLAXvBeoBHHlFQz3G+zBBQ+CU1dJQlsLlJBfcoAXNBvHI4t
         QsIZBEjjOGKv10vskGSvZruuv/Y4bxaL+omLQCXeh3UDYCW9rFG3/FVCYm4ZAkxOlgCV
         Jt1cHkXTPtslmL50V6niXpWsOztw+t5hriLjok3NZ1PE7sChTJFZsBGTUOBXH/vr6X/R
         sh5g==
X-Gm-Message-State: AOAM531v+UQlzxTI/J1X1IyfiWWyvHYtyRes0icjL0w8uWNdpD4qWhyS
        Dq8WD8D6lkbTbVZ4OsgsvOFM0A==
X-Google-Smtp-Source: ABdhPJzzhNgBKICixn1BmX+FEFq9VN9d5pl11Uew/GhdXyhQuIKrjSjYMnX4OzZV4gM7ZsT0Y14CTw==
X-Received: by 2002:a17:90a:ba0b:: with SMTP id s11mr2736424pjr.96.1629437631270;
        Thu, 19 Aug 2021 22:33:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r78sm5560641pfc.206.2021.08.19.22.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 22:33:50 -0700 (PDT)
Date:   Thu, 19 Aug 2021 22:33:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
Message-ID: <202108192227.8BE02F1C@keescook>
References: <20210820043339.2151352-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820043339.2151352-1-jordy@pwning.systems>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 06:33:38AM +0200, Jordy Zomer wrote:
> When a secret memory region is active, memfd_secret disables
> hibernation. One of the goals is to keep the secret data from being
> written to persistent-storage.
> 
> It accomplishes this by maintaining a reference count to
> `secretmem_users`. Once this reference is held your system can not be
> hibernated due to the check in `hibernation_available()`. However,
> because `secretmem_users` is of type `atomic_t`, reference counter
> overflows are possible.

It's an unlikely condition to hit given max-open-fds, etc, but there's
no reason to leave this weakness. Changing this to refcount_t is easy
and better than using atomic_t.

Reviewed-by: Kees Cook <keescook@chromium.org>

> As you can see there's an `atomic_inc` for each `memfd` that is opened
> in the `memfd_secret` syscall. If a local attacker succeeds to open 2^32
> memfd's, the counter will wrap around to 0. This implies that you may
> hibernate again, even though there are still regions of this secret
> memory, thereby bypassing the security check.

IMO, this hibernation check is also buggy, since it looks to be
vulnerable to ToCToU: processes aren't frozen when
hibernation_available() checks secretmem_users(), so a process could add
one and fill it before the process freezer stops it.

And of course, there's still the ptrace hole[1], which is think is quite
serious as it renders the entire defense moot.

-Kees

[1] https://lore.kernel.org/lkml/202105071620.E834B1FA92@keescook/

-- 
Kees Cook
