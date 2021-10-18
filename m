Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B87B432624
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhJRSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:16:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B80C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:14:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso617805pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rECEro2baLj28FSIARXDaUkJhvRjUYb9oi+C1vxDjLo=;
        b=ZPAAz3A6icCyKCw14of499s/0spphqJ/ZWgJwfcRlvd1YpuGt9dv/+LiPGJ3aUGt5k
         vsg8ZYbBy6vKpCEVJzyFe4zXgXmf9i2aIkh4AxCr8KvKBzX3q44m0xa7/Ky7gzmtFQSB
         LjCoZkxHQGwgLXCul1rpyttz1uGBm7xwA5Dn+LqLUZ++MgZ99fe/f08zORHFvlsYsmN/
         qAJj7rucZF08y20Q/uqNJX09z+jaNu2znWMBuYAc6BiIikLuiKMUFkitT3O0+tHxwOUh
         fAtYP+tIiS0M+5LDZU8q0dDFZWSX7msC1IW13qEF9d+vkPCgAPQlludDHGu5cFhG3fh8
         +Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rECEro2baLj28FSIARXDaUkJhvRjUYb9oi+C1vxDjLo=;
        b=eaG0bApyA2xSiFUXgaXKWKSruQzeCUpPs5KRm+IopkhhHn3ePXE9LQ66aRi+NptOrO
         iBdPM/fToFSOlWtOMNHA1h6BNhT1U39Y2xYtkH0lty64ldbaBMqCFI6XYOjh+WHCOUgI
         Tgpu0WnOytZLi0+I9CBOKoUmYIlsknWKvQ6Q76gvGXBAczT3IBvgBwTRSEsKOp8hCmXE
         rDGKe9E9riLwf1N3nTiIpoIpjLbiZN9WBscT5K8QXTwbdBVZMi4pV6ZFs+etKdDRTYWZ
         wFxVx1BT0x3rT8MlEJVET7YPDmwC4TcdI3ewjREDuaOFN8J9dmnbza/JkdQ1khMPQgk1
         Y+tQ==
X-Gm-Message-State: AOAM531w//AtHtc+hYGgbPBTZ/1nMGRMZTiQAUNJXNzLYslAIoJmhT8d
        MHx71SPoTPRB0jyRdpmndtHIFSPm2qw=
X-Google-Smtp-Source: ABdhPJyfVUsmm094Q3ucqV7kDuWKir2JuRbECVohe1J75tjn9kE/pODxyxISBUCQtmGEf8ALRTQmnQ==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr515308pjb.192.1634580842194;
        Mon, 18 Oct 2021 11:14:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m28sm13860556pgl.9.2021.10.18.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:14:01 -0700 (PDT)
Date:   Mon, 18 Oct 2021 18:13:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH] KVM: cleanup allocation of rmaps and page tracking data
Message-ID: <YW25ZiTE1N6xS4FN@google.com>
References: <20211018175333.582417-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018175333.582417-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021, Paolo Bonzini wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Unify the flags for rmaps and page tracking data, using a
> single flag in struct kvm_arch and a single loop to go
> over all the address spaces and memslots.  This avoids
> code duplication between alloc_all_memslots_rmaps and
> kvm_page_track_enable_mmu_write_tracking.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> [This patch is the delta between David's v2 and v3, with conflicts
>  fixed and my own commit message. - Paolo]
> Co-developed-by: Sean Christopherson <seanjc@google.com>

Checkpatch will complain about a lack of 

	Signed-off-by: Sean Christopherson <seanjc@google.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

...

> +	bool shadow_root_alloced;

Maybe "allocated" instead of "alloced"?
