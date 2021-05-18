Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD243881D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352345AbhERVHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhERVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:07:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B1C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:06:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k15so7882627pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C4q8U+G71BGWewWidR79hthoGxSDsJQHYPmB+z8bH0k=;
        b=shUs5CXlyzZPJ1uFMvk6P8+4/zeWAeoTAjrVTScZYjYaHYLisIdEW/u0bVWOvZpTKw
         FPeojwgYychUv31bK4X5+Fx53RZYASRZnsNMsJBhNuliI+v4nft6y301AgbdiLXWNs9A
         dsBYNbRK5yRGE4+o3/1LjarPmReFqF3sRMhe2lFUvT8Sv6oMG2NKE+DUso7y3VFNRi1X
         XPjvm7SLFFl/I9N2cmj96sAt/tQ48p1+1wNN0uFYV5h60WYpaFxSteN9OyZVVpFMrD1p
         a3+NCN9HxsxoN7wAwDodezj8V4o/PoT/iKJ1w2sxSuwOYMWmE3mi37ExZdmyG9pVTHD9
         uuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4q8U+G71BGWewWidR79hthoGxSDsJQHYPmB+z8bH0k=;
        b=XNOOVx9nuHHXvkWA154j/p3IPtwGRm8S788JKLe9qVLGu7b22/x9GjPJgHWWhVtict
         jx74NFKZwLoohRMOtYsk9YZBILjLn7+HQMbod2cqrZtLXQ2hYTc+FnY1dmv3eRWFQj0E
         9Q8YG9DhMWPil/MYFBq3klGob0ZJcCsAAZ/RBYPI9W6nx23k2QW4BmiE8D+Fjv1StYyO
         ux4H1ef43fEuwrhg9xmr3W7ZXyCsgOPm3jYePKcMnHZip8viIy7OgTeW/gtH7FL2yHwK
         U4PhI1iJqniGakJ/xDRjdz5PLl8BqbJq3J3rV/qTYKRFwokWzo3j1DRVCEKDVXF5Mi+p
         7IMQ==
X-Gm-Message-State: AOAM530OZf5L3F0Hdc9RQiAZ/9yWRbBKOvgPDif+Bt0Q9DCEsCRqxSz2
        7FKj+HB5THYc5A4s+bBU2jsQVg==
X-Google-Smtp-Source: ABdhPJyGun4MMDb32J/F0DG1O6VqMPVAo66ylxeliHDy68zArWjFVZjeeyz7VVbQpySd9W4N08lW7w==
X-Received: by 2002:a05:6a00:bcf:b029:2d5:d695:d52f with SMTP id x15-20020a056a000bcfb02902d5d695d52fmr2422696pfu.38.1621371961701;
        Tue, 18 May 2021 14:06:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id q23sm13836189pgt.42.2021.05.18.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:06:01 -0700 (PDT)
Date:   Tue, 18 May 2021 21:05:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] KVM: x86: Invert APICv/AVIC enablement check
Message-ID: <YKQsNb7VXpFqAltt@google.com>
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518144339.1987982-5-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Vitaly Kuznetsov wrote:
> Now that APICv/AVIC enablement is kept in common 'enable_apicv' variable,
> there's no need to call kvm_apicv_init() from vendor specific code.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
