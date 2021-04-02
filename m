Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B42352C14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhDBPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhDBPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:01:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881CBC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:01:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s21so2829185pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B4aR7GQ45Q6gcx4+A7SR+lq57+x+iu7A15kxK1uxDw8=;
        b=Y1RpiKElC5IcRA+tvkWQQDQOYuaveVlroBy+bX+KwaMDZxmvl8VuT+Wr1L03CsY2kr
         WTn8KuMLTRWbLnKYo5OUZi6VqnCO3tHBPd+olDL3TRGeWfA+0kLGsVEc2y1KiBw2UAhX
         0a6afsFfuZp8mTT+dXabdOkAhADiuAqG218Lz9dHgRZjKuP410cDMmYQR26/iqDRNnFW
         GiZn34bvY+YHmnfqOM7s1rOfOMAC6mAOcCdDRFghM06tpMlYlKqxxZgbrqlPayPVXOCc
         Whw6W8qA/jPibXV5bRBP8v01ctlkv1qA+SdwwYwA6lIqTKKQkSSm3gThBqqUARJEmVS4
         FB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B4aR7GQ45Q6gcx4+A7SR+lq57+x+iu7A15kxK1uxDw8=;
        b=l8B78wTeYXOn1Hp56kZSn1jT8qLP15n5jQrV+zD90TGVDacv6ojFU9wMdHg0kgQQdd
         WwkRarQorK9WeYc/4oH7Yo26PYuJFlNdR4ZxZQVuFy+PgpHvLNRuCWfQ+m93SWnAZet1
         cOlod2gnaDWVm6ecdQ1neZzkv2SbyTdmpKP/8MyQZE8D3i172+Mu5RRaApIHf64uK6ez
         B0Fgoikb/GXbuaKsJow4A5NTbFxvguXg5HJd7J5GKj9gSTxHHlbgcV9BzhFuxvSgPiB8
         hda/teo28Bk8p29lVCw4zC25fYEHCc3j7btAZt9W0X5wo59YSX0yRMSvki6sSxZXukGm
         D57w==
X-Gm-Message-State: AOAM532lvEhNwFPuUVxxqvt2O6V8fWJ7dRBpzKNy3ZqBSdAZ6Hz+lLnc
        vrW5RPaW8iKr8TdzCzZEgyWQWg==
X-Google-Smtp-Source: ABdhPJyHTdyW00d2fYIUBu8Gb42GRW8lHrIhdOr8eH36swUWCSaDZadQMjYvzkAFLilDtLjc1nPT2w==
X-Received: by 2002:a17:90a:f0d2:: with SMTP id fa18mr7041831pjb.187.1617375716012;
        Fri, 02 Apr 2021 08:01:56 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id y12sm8754606pfq.118.2021.04.02.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:01:54 -0700 (PDT)
Date:   Fri, 2 Apr 2021 15:01:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 2/4] KVM: x86: separate pending and injected exception
Message-ID: <YGcx3+6KKhpWkgbw@google.com>
References: <20210401143817.1030695-1-mlevitsk@redhat.com>
 <20210401143817.1030695-3-mlevitsk@redhat.com>
 <YGZRrOBVvlhVTyG8@google.com>
 <09c74206-ded2-900f-ef28-a2c5065a6626@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c74206-ded2-900f-ef28-a2c5065a6626@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021, Paolo Bonzini wrote:
> On 02/04/21 01:05, Sean Christopherson wrote:
> > > 
> > > +struct kvm_queued_exception {
> > > +	bool valid;
> > > +	u8 nr;
> > 
> > If we're refactoring all this code anyways, maybe change "nr" to something a
> > bit more descriptive?  E.g. vector.
> 
> "nr" is part of the userspace structure, so consistency is an advantage too.

Foiled at every turn.  Keeping "nr" probably does make sense.
