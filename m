Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77944EB9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhKLQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbhKLQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:55:45 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069CC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:52:55 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n23so8489106pgh.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zgvW9FuxSDlvjidn6+j+BtBuiiEW1gXL653B7SOOudk=;
        b=LEi709KrmaL+u/rY618lmBZ0UobYD1L5zZWJ8FoHmc0sk6TXC/sR+p1JhQ9xVSpWqd
         8l5ogamsfy3lyD8Cbj3jm8NWnEB3nIuvggCYbKp5fMNqPHC93EKRxygbuho6+wtYIELA
         yiIcuEaNre/YllRe8cVTn0Iaj6sdDUq81uoL6pyRYe8B2TQs46suqNHeGddNbFWoyWzx
         4yfVCp5Q6VYY8Oo9HlfSNpGBDzpNkcsXE7CoDCF6fxS0uq6IW+1Jw4fpGp2tzRnt7xg3
         zuZRTQIEgh75a02jmXQTuWMJrj4FhSCY4MwjOW+XGNFkt4+Nwi2Wq5y5NdCICKdEeEf0
         ew0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgvW9FuxSDlvjidn6+j+BtBuiiEW1gXL653B7SOOudk=;
        b=4CKFYFYM3lAj6PKSJFig11P7iuPZWg9157nuxdhxq8QGVpjgGABLeq0X1KffDJJ9Ym
         DdevACiXdA5Ru/y43HpDsKEAZKBwH8FijoDu2o2R1YPqPaqA3wLvJP8p8gqT6NR6mXns
         tBZZ0Mx3sfEdK0WGdx/LkFvz1FiGuItqlVDyUbzbk48m5fyvtH8whZa0Xkw/o9AM8yQS
         ak1fqYJj90ArjSIsrdNopMGfD5djvuiM1/r2CcQTLa+RBpIvlxLE1tVr+eLfP5KWUJvf
         zKk6OMLHtC6eEyJCW7SgdnRGmb+OxTknj+idj7xrmUZsPIMvLO/AwFggfQDuqw5Ag+H6
         uMAw==
X-Gm-Message-State: AOAM531hy38Jnx/sMFeXAWu+HfYM8zQlGNV7RDkT8cu24DlC4V40vqwf
        Bqf1lmoCpJ3aRuvC8u4oP3/ZFw==
X-Google-Smtp-Source: ABdhPJz++Y6HAiJA+KwLtby7VzO7I5bTXmB/IdEzVJLiqDa/X8dy8+6G8ER2jTixEaeTKqLvOLnKiw==
X-Received: by 2002:a05:6a00:148d:b0:49f:def7:9cfe with SMTP id v13-20020a056a00148d00b0049fdef79cfemr15359043pfu.69.1636735974327;
        Fri, 12 Nov 2021 08:52:54 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l21sm6784585pfu.213.2021.11.12.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:52:53 -0800 (PST)
Date:   Fri, 12 Nov 2021 16:52:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@intel.com, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH 10/11] KVM: Disallow read-only memory for x86 TDX
Message-ID: <YY6b4n8xPaKspoNI@google.com>
References: <20211112153733.2767561-1-xiaoyao.li@intel.com>
 <20211112153733.2767561-11-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112153733.2767561-11-xiaoyao.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021, Xiaoyao Li wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TDX doesn't expose permission bits to the VMM in the SEPT tables, i.e.,
> doesn't support read-only private memory.
> 
> Introduce kvm_arch_support_readonly_mem(), which returns true except for
> x86. x86 has its own implementation based on vm_type that returns faluse
> for TDX VM.
> 
> Propagate it to KVM_CAP_READONLY_MEM to allow reporting on a per-VM
> basis.

Assuming KVM gains support for private memslots (or memslots that _may_ be mapped
private), this is incorrect, the restriction on read-only memory only applies to
private memory.  Userspace should still be allowed to create read-only shared memory.
Ditto for dirty-logging in the next patch.

When this patch was originally created, it was "correct" because there was no
(proposed) concept of a private memslot or of a memslot that can be mapped private.

So these two patches at least need to wait until KVM has a defind ABI for managing
guest private memory.
