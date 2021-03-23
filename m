Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD20B345C18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhCWKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhCWKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616496132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gNbDvqmHSmOS17Uw36LiU1hQfbOR+Uaf4HP1sWsQm8M=;
        b=Z+VfKyDyoitbzWpf5uRe45uq4WUqbWwxfbizTwhQ6V5LJPagpeTZH2ssa66JCmID2mRANE
        go2QZs+t9ew/OFV5OwZD9PdWQTAYMgc81Fwqs6xsJRPDVf4qO9P4c6PNcp9hdOqNAqVzEp
        mPiSwbYubPhcaipgzz9bVdtg9sm4EF0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-2uzuLfsCPYS7yX-nLIk14A-1; Tue, 23 Mar 2021 06:42:09 -0400
X-MC-Unique: 2uzuLfsCPYS7yX-nLIk14A-1
Received: by mail-ej1-f72.google.com with SMTP id au15so870169ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 03:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gNbDvqmHSmOS17Uw36LiU1hQfbOR+Uaf4HP1sWsQm8M=;
        b=VdgfdiiSAi4oGmPwlG7RcMaJGPpWr1mKQ0a4JZ1E0I0WNa99al6QdXjs+IKJeO1K3N
         lycwdBKINdNMXrtQhaP7Fis6J1eHIDV39juA3lDVxUi69O+7IJPjdRwCsFguPL9QijwA
         NPC5XyIRXqqvwcRY8evRnNv7DedDzHpZof0N8oaysSBioQJhSMXwy32LDbuUGXrTeaLE
         fNvCQPaD3XpEewEbVcA+4lO1cjFHNMIR3L9LGn/vWkakVqz7J2yHR+LVvLBum/ZiR6Uc
         0RpRpfR9ii/4QOiA68n06YUmd0ydG1QYRDcKSdbw1wkOJjcmthyOw5PqvssmR0zs2Udy
         rchw==
X-Gm-Message-State: AOAM531GKQ0fUi5xFjMEa/Ool9t3N/auSpTIOdjQLe5ZbmxbFdYrO+eA
        maRoP4yN1zcDMJw9hTjlXjNa4sJnCNTfORVnPytQT31IzWiJE48KO0CPHGyIKM+zW6TaivXuhsY
        KYFOCDCH8hVifkXdeeIMP1JegGbBJ0Niuln5b/K/iYU5ovnscH0fLRvPy1acjfpavUF6QCny8qI
        GM
X-Received: by 2002:a17:906:c058:: with SMTP id bm24mr4259402ejb.335.1616496128739;
        Tue, 23 Mar 2021 03:42:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHfV1x3tHtVhnWgVqKlxX+gGynmicskM/QyDg69WoGaur0WMcJJEOYrnEMKEzPFcvqr3TD/g==
X-Received: by 2002:a17:906:c058:: with SMTP id bm24mr4259380ejb.335.1616496128521;
        Tue, 23 Mar 2021 03:42:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g21sm10903399ejd.6.2021.03.23.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 03:42:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: make hardware_disable_test less verbose
In-Reply-To: <20210323100311.zq3yzru4heg4zomu@kamzik.brq.redhat.com>
References: <20210323085303.1347449-1-vkuznets@redhat.com>
 <20210323100311.zq3yzru4heg4zomu@kamzik.brq.redhat.com>
Date:   Tue, 23 Mar 2021 11:42:07 +0100
Message-ID: <875z1iyww0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Jones <drjones@redhat.com> writes:

> On Tue, Mar 23, 2021 at 09:53:03AM +0100, Vitaly Kuznetsov wrote:
>> hardware_disable_test produces 512 snippets like
>> ...
>>  main: [511] waiting semaphore
>>  run_test: [511] start vcpus
>>  run_test: [511] all threads launched
>>  main: [511] waiting 368us
>>  main: [511] killing child
>> 
>> and this doesn't have much value, let's just drop these fprintf().
>> Restoring them for debugging purposes shouldn't be too hard.
>
> Changing them to pr_debug() allows you to keep them and restore
> with -DDEBUG

Ah, missed that we have this for selftests! v2 is coming.

-- 
Vitaly

