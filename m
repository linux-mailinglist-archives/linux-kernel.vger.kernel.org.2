Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B44353E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhJTTj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhJTTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:39:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F422C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:37:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3223529pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lWYe9rn5e9oEHLDCI62/+vmQMjjh/6S+KCip52ZzywU=;
        b=sxzdOq1oGrm/5AwX5lW7IzpVq3HI19eImCfYcLU54BhAw3OF57B9QYP+5sHBYQRueS
         z6VKj+WcD//I6Nrm/ruyvlIs63Tw5IEuNq3SzsIdtOC5o+5Kfxgc7IBuEflDDilfR3dI
         DPaSF8gp6IbGl4Q1EF9hYK37y8Zs5d7NmXmnxHnTG/fRq/NCAUsAqHxcL8rwrH6ndMkT
         biRowKPaS3LEoqz730TT8jo0I/I49PtG5qtR3JQkWCFJfTZnMquY+umz7Lme9uRs/ETK
         QlSbb2oNEQxuG8Rv9MZr4pDWVI5LPfwmlgYl7iHxrt6uVzMzu/79ULW8NYIPXG14/8QE
         S/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWYe9rn5e9oEHLDCI62/+vmQMjjh/6S+KCip52ZzywU=;
        b=B70E3k5tcqIpMJUSg53AMpytkFAYL5JhLFuKpWcjG9Z5CRAL6IAEXqqbKsZVMqAyKL
         Rdx2xloXJc/F3kSoX814lZU1U/Bh3PGKqDuESmvGd3aYpp7gq2S5TR5lZQvtrxy+AXor
         s8cgVlK6N9ZMjn6tbiEvZzUou8ZYF00fK3i1/HWQ6ymcAPWz4IC2qA7FIwWz7CziZSIH
         4nGCFwHUr41Ry7L7jidL/WGY1PftFVwTuosQGkZ7WNMC9dceEKFl0kyAr/bWIMEmWDmT
         Cn3zoVbj1+IxGKb7l50VGM7lW0KBi0v+qEnV43acYWOcV5dtN2nPELFW+8T7nYlSUJ/7
         Q9DA==
X-Gm-Message-State: AOAM5307vCE8Ols4i3Ed4AHys7AFaCjALRwQf5I0XBAONPpJ/XwBXp4B
        YTGbhjW9RLX4qr7H54ydudT9xyOReryJHg==
X-Google-Smtp-Source: ABdhPJyswwvwef6Te/xzJRzb75gIE1AxwGiGRBSEd84RsmFl1n7vfv/a6xaWDNzw3SPvGn+aAjyh1w==
X-Received: by 2002:a17:903:1252:b0:13d:f3f6:2e1c with SMTP id u18-20020a170903125200b0013df3f62e1cmr984499plh.73.1634758661626;
        Wed, 20 Oct 2021 12:37:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u11sm3490396pfg.2.2021.10.20.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:37:41 -0700 (PDT)
Date:   Wed, 20 Oct 2021 19:37:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        wanpengli@tencent.com, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: promptly process interrupts delivered while
 in guest mode
Message-ID: <YXBwAbbRJFfEVGxY@google.com>
References: <20211020145231.871299-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020145231.871299-2-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021, Paolo Bonzini wrote:
> Since commit c300ab9f08df ("KVM: x86: Replace late check_nested_events() hack with
> more precise fix") there is no longer the certainty that check_nested_events()
> tries to inject an external interrupt vmexit to L1 on every call to vcpu_enter_guest.
> Therefore, even in that case we need to set KVM_REQ_EVENT.  This ensures
> that inject_pending_event() is called, and from there kvm_check_nested_events().
> 
> Fixes: c300ab9f08df ("KVM: x86: Replace late check_nested_events() hack with more precise fix")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
