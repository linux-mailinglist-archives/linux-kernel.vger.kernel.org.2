Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88383EB170
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbhHMH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239402AbhHMH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628839661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+56+meTQ51PDKaVBuCzizjlRCe9SqN27YTBVgW4/XKA=;
        b=DaFl2m/Occ/jaUxwdY4WRGHgSNCoga2vwm0ze+HF3PVgblI0LZL1reD3mJMFMuqLcmSJTs
        gK+TQwGZB06DZQIhLSMHQRnmUb4BuiBeHcRLPWT3LgCp6XuQwA4DjsfjTWCXAMY20tOju/
        ht00pa43bKBG70QGlqnEOMls4vg3pmc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-5EEhx_9OPzCvrFdMnsUoGw-1; Fri, 13 Aug 2021 03:27:39 -0400
X-MC-Unique: 5EEhx_9OPzCvrFdMnsUoGw-1
Received: by mail-ed1-f72.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso3228023edy.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+56+meTQ51PDKaVBuCzizjlRCe9SqN27YTBVgW4/XKA=;
        b=mDd/UaMNbQfNInkOF9R8eriDCm0YVnvpg38XvhEcAXfztxyrMo5f9LNoluXBPThYE3
         lF6KO21ZrIYHcGcchk3qWxyFgpB330RgkWYldcuWm9woUhGC25QBCFL9J+5EPB5w04jr
         /dEqnXCfLIKvqcFIxBudsyFRuZK8jFuh2f/fUCZf1crpmQ1X/mHIqXS860GFqASTjkwV
         kSNma4tj4fafjt/9IHPYUQ6YoNUqQH576hHXNlIELG1X3+3ZxU3qU7Dsh6sKfvYvOOBI
         NFw79CXLtHppUU6YTyV80GplpPiEqz5JT5DVXgHQZAVsUYIi4BvXBG4m/I2BBwJajEzl
         isZw==
X-Gm-Message-State: AOAM532DYtaCMDR1mgMH3Rmz8oR13VgnrU1NWhGtJagIm5c5d2U8/0Vt
        cOkQmd0BUC99m05B2fOIFiz3AK1xS9gLwCovO62OBqvDjXuqSCVmtihZ6beOwsHkFTPPIiHXU6r
        eyup+isVW9p07WIyqeOSNyRvUMgR8dUhlJ3bK85Ji3dTgLvVfwJOnvwGQk0gxkf8Q30Op5kIa7g
        GA
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr1112734ejc.263.1628839657754;
        Fri, 13 Aug 2021 00:27:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHEtaVP8ZAHfgIjyyDcFB45xD+bvzHBpqKMp9W44P/qp+xnFs22IwYLl3SbiJWJy7Z49/FpQ==
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr1112717ejc.263.1628839657499;
        Fri, 13 Aug 2021 00:27:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ay20sm428084edb.91.2021.08.13.00.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:27:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Don't step down in the TDP iterator
 when zapping all SPTEs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210812050717.3176478-1-seanjc@google.com>
 <20210812050717.3176478-3-seanjc@google.com>
 <CANgfPd8HSYZbqmi21XQ=XeMCndXJ0+Ld0eZNKPWLa1fKtutiBA@mail.gmail.com>
 <YRVVWC31fuZiw9tT@google.com>
 <928be04d-e60e-924c-1f3a-cb5fef8b0042@redhat.com>
 <YRVbamoQhvPmrEgK@google.com>
 <7a95b2f6-a7ad-5101-baa5-6a19194695a3@redhat.com>
 <YRVebIjxEv87I55b@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b08a7751-20c3-26fc-522e-c4cf274d9a6c@redhat.com>
Date:   Fri, 13 Aug 2021 09:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRVebIjxEv87I55b@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/21 19:46, Sean Christopherson wrote:
>>> 	if (iter->level == iter->min_level)
>>> 		return false;
>>>
>>> 	/*
>>> 	 * Reread the SPTE before stepping down to avoid traversing into page
>>> 	 * tables that are no longer linked from this entry.
>>> 	 */
>>> 	iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));  \
>>>                                                                        ---> this is the code that is avoided
>>> 	child_pt = spte_to_child_pt(iter->old_spte, iter->level);   /
>>> 	if (!child_pt)
>>> 		return false;
>> Ah, right - so I agree with Ben that it's not too important.
> Ya.  There is a measurable performance improvement, but it's really only
> meaningful when there aren't many SPTEs to zap, otherwise the cost of zapping
> completely dominates the time.

I don't understand.  When try_step_down is called by tdp_iter_next, all 
it does is really just the READ_ONCE, because spte_to_child_pt will see 
a non-present PTE and return immediately.  Why do two, presumably cache 
hot, reads cause a measurable performance improvement?

Paolo

