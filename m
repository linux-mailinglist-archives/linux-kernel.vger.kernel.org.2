Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0FD3FE5EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhIAXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhIAXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:05:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6533C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:04:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 17so1056723pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HxwuV0BeQWwpRI/6sMdLU80DQpiU/qy8K3f3w8+UPd8=;
        b=YgccQiWfa0BA9wl5D4A783k/FalQF0lNHO4CTlk62dckfSkCv2umLqsVmA4WOY9Uhu
         /uKCmHiSmee+sZmM7URFxlal/t+4wUNjAYv9qo1H3XYjnlR4yEiIsWl2w5iqQJdc4HcA
         8LurG6+D/DZZxa3coCp1vKSk7DAHrep7HsfjBVSlptdQAgqt4VrACpu7jw1K4w/VU/SM
         9XfO89VmNU2VK6QP/VgS8LrZflFFNdpOB9lSYv+eHZ1FiKpJa5c4ED4e0gRhi4wQXUNw
         eQGdcdK1prxWmFmOXVJmiTw0hJ2bxrH2M3YXfgzbEjZZ4o6t5MWZtMmPNY+hKTTaagoM
         e3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HxwuV0BeQWwpRI/6sMdLU80DQpiU/qy8K3f3w8+UPd8=;
        b=cwM0NMQZduwDQmPxVWkIPdlLeUj4ebkdjxKi7fUKXyBuUgIjJrD4dddV5wIOsh7GcI
         UYXH4Wf02yHxLruIEHa1G3Hrc5HuRR/UQG9UG5Hl83nYZYPLZLHRDxQRo0p/i4ECwlmj
         1IAMCZqXAhVoVV0UAwVgl50YPZg54WFuW+G6Fc0INQG8rS+9FARf+ITG17H+I7DheY4Z
         Ryh1g2iHKX6dFkkUe/9j8oKyh+TkSEs1LryMe8XGIuIBZtB0rsXgWVManMKSjX9eZafr
         V/ArJWfL5P3XNDVlmMl1XEgBsq5itjwL7e8XlRXHsvxjplzgAaBBcEa8Zz5buJaQL3FZ
         N4ZQ==
X-Gm-Message-State: AOAM533JaKyblLR4pLoXukxtCkcA1D+QE1A9q5SPNZeFjimBvCcdezPK
        Bo1y2TPtkLMEkgN0AqfaD0yGcg==
X-Google-Smtp-Source: ABdhPJxdBfTPmVgabIaZnNcUrXB9D85oAvIJmKM+/BPP5iSbVGIX6qA6iBfEfa9p4qZHwhnY/mApCQ==
X-Received: by 2002:aa7:864a:0:b0:3ee:a4f6:af02 with SMTP id a10-20020aa7864a000000b003eea4f6af02mr223134pfo.23.1630537449197;
        Wed, 01 Sep 2021 16:04:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 17sm52662pfp.28.2021.09.01.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:04:08 -0700 (PDT)
Date:   Wed, 1 Sep 2021 23:04:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@intel.com, David Matlack <dmatlack@google.com>,
        peterx@redhat.com
Subject: Re: [PATCH 06/16] KVM: MMU: change page_fault_handle_page_track()
 arguments to kvm_page_fault
Message-ID: <YTAG5We5dS9THNJm@google.com>
References: <20210807134936.3083984-1-pbonzini@redhat.com>
 <20210807134936.3083984-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807134936.3083984-7-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021, Paolo Bonzini wrote:
> -	if (handle_abnormal_pfn(vcpu, fault->is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
> +	if (handle_abnormal_pfn(vcpu, fault->is_tdp ? 0 : gpa,
> +	                        fault->gfn, pfn, ACC_ALL, &r))

Spaces!

ERROR: code indent should use tabs where possible
#90: FILE: arch/x86/kvm/mmu/mmu.c:3991:
+^I                        fault->gfn, pfn, ACC_ALL, &r))$

total: 1 errors, 0 warnings, 84 lines checked


>  		return r;
>  
>  	r = RET_PF_RETRY;
