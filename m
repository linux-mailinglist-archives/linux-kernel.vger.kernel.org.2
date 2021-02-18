Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AFF31EF99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhBRTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234954AbhBRSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613671247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knU/yki0BfF5dJoH+kKkOxiLiSgQ2mddkhxf1LFdIuI=;
        b=I2QZ7EPLmo3y6/+B9X/xXw3YYpzj9C8yGvUnXapHeidjVpaF1J6LXiNtopkCBImP11P7q5
        Tdqxmm7QZzjKdxb0h+celnz7QYX9QKGok9Nz6KFki2sz2j3HFDaY6VDLwRLcR8TMveJDDg
        3fiZ2b8xEYHa0ptT5FCnJO4erWtgdoE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-sixDvoCNO2Oo8YNgWoVf_w-1; Thu, 18 Feb 2021 13:00:45 -0500
X-MC-Unique: sixDvoCNO2Oo8YNgWoVf_w-1
Received: by mail-wr1-f71.google.com with SMTP id q5so1276442wrs.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=knU/yki0BfF5dJoH+kKkOxiLiSgQ2mddkhxf1LFdIuI=;
        b=uWuPHUyy8jYrFGd8OA+7Vx3pWrlkgXAkkjjJkes9n1DhBzhPnbkrvVElZheyrkhgOK
         QH89shovUgT884oBPddKHN1mUPuk2qGQy2yKeVJlNt9mwECwMJxjJ/4c5Y6i+WGmU7nn
         2U4wRuTnLyK7QwbeJjyZWPXIg2gx+mLM1hN34+fvKEWtUyuerALJDtv4a+9iUGyAbutD
         T7cYyrv8cuo91LaC/GPHxfaJvoUflV8OcYqE1wVVqn0xZ//x8x/iWYIn4NtLiN6I6qfy
         pqq0r4J+VnjYN+mWHgav2WByOab6yy9tQ4DJV0RPTeRxFkf/nNAo2Wr4SGGb2GgjQdNI
         DCdg==
X-Gm-Message-State: AOAM530DNO1De6VKeRN7pWTnHliauMqDTL6fEPnpP1Eb/nT67uK11y/0
        rYMB+eiWXYgSincz6UtzmyQVmYAzKcNKKVcwF/jqUWjZOO2Ko1OWCdy2RYrAyi/+8yNmVvUpTbt
        MZE5qr2qF28cq2QmOWJcDzjDs
X-Received: by 2002:a5d:5104:: with SMTP id s4mr5336467wrt.277.1613671242968;
        Thu, 18 Feb 2021 10:00:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg81dCsuwIpBmnRINMv5sFy4QWWKQMpP2/bYb3VgK6odiPlu1XN3GP4HB1vH47LzUx80nnSw==
X-Received: by 2002:a5d:5104:: with SMTP id s4mr5336452wrt.277.1613671242790;
        Thu, 18 Feb 2021 10:00:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e16sm12302377wrt.36.2021.02.18.10.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 10:00:41 -0800 (PST)
Subject: Re: [PATCH] KVM: nSVM: prepare guest save area while is_guest_mode is
 true
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jroedel@suse.de,
        mlevitsk@redhat.com
References: <20210218162831.1407616-1-pbonzini@redhat.com>
 <YC6m8xoRUDtn3V+y@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf1b338c-68bc-6e7e-1a10-98bc653d34ce@redhat.com>
Date:   Thu, 18 Feb 2021 19:00:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC6m8xoRUDtn3V+y@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/21 18:42, Sean Christopherson wrote:
>> The bug is present since commit 06fc7772690d ("KVM: SVM: Activate nested
>> state only when guest state is complete", 2010-04-25).  Unfortunately,
>> it is not clear from the commit message what issue exactly led to the
>> change back then.  It was probably related to svm_set_cr0 however because
>> the patch series cover letter[1] mentioned lazy FPU switching.
>
> Aha!  It was indeed related to svm_set_cr0().  Specifically, the next patch,
> commit 66a562f7e257 ("KVM: SVM: Make lazy FPU switching work with nested svm"),
> added is_nested() checks in update_cr0_intercept() to merge L1's intercepts with
> L0's intercepts.

Yeah, the problem is I don't understand why 06fc7772690d fixed things in 
11 year old KVM instead of breaking them, because effectively this patch 
is reverting it.

I don't care _that_ much because so much has changed since then; the 
world switch logic is abstracted better nowadays, and it is easier to 
review the change.  But it is weird, nevertheless.

Paolo

