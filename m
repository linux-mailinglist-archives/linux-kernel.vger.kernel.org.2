Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159023F8545
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbhHZKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241425AbhHZKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629973450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BOy94jtHdM+WsIgWm9uXDpgZeKpyFjwm3X/elfW497Q=;
        b=SM9fdiYOZaS1ZBdagdlHhWdo35GiJyQLMPkuEsE8JGHneEMhdqFFIrCjkM7/8CfexlLTSr
        ZuqLkYGKDjvVqfOCr46YlXTab7AppYOrNe2HsFAPiUVc9gjwncEaisKk8EVoq9HbnPL0ux
        9ysLvRtdYExI6R8+oBUYjdeeHW2AfUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-RhS9-JT9Ou-mZMz7q84psg-1; Thu, 26 Aug 2021 06:24:09 -0400
X-MC-Unique: RhS9-JT9Ou-mZMz7q84psg-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so758346wmj.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BOy94jtHdM+WsIgWm9uXDpgZeKpyFjwm3X/elfW497Q=;
        b=DHOffavEqY/cpHt07r6wOa3npSqbDIZffCTJPRaHdKk7Ca7zGm+4BCSKhBExy/W7Zi
         RQX6R2F3tQi0ary+MyckgDMUeE/yzl5UlrkTJUDg7L4Cb8s/G7Yp9KBNfdq57odSlKwU
         yyWH70BRdObGqVj5tx5OJwbGDrjGQa6vDTXMAv8/KAe3d0JXMZe0ZqIoc6NntNflIdDQ
         7VR0ka+SmH1SCA/5/kLSB9zegbuNDcD2FUylEh7rj4HR6jVbOSWwhjGwd0GVtmt0MaTj
         s5r0egk8yECL4qt3UCJHt2QKvDQa2+dCelh/1MYNh5bA6DfdnhcQThpCma6D91VMQ7/F
         ActA==
X-Gm-Message-State: AOAM53097wfe4Dn+dAYrO30euT+6mj7s8ghkld7wT+pJixCVZXgtums7
        m5lWxtJH3vgOCzojdRyCi2Sou1DdQI/s+IJ+R6IGA8khC6f4Ki8XQB5bsx7BtcScUsjgKrhUEzq
        aetnaqaWI5LhQ7PI51eJnfU7+
X-Received: by 2002:a05:600c:3b98:: with SMTP id n24mr13330807wms.11.1629973447863;
        Thu, 26 Aug 2021 03:24:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQappUQgXxVoQGN5Z3dHEEwlNg/3FtUE++2Kejy7gQkngqtKxQ8s3i2YsypuYKfiZtrZSh4Q==
X-Received: by 2002:a05:600c:3b98:: with SMTP id n24mr13330793wms.11.1629973447680;
        Thu, 26 Aug 2021 03:24:07 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d4sm2648498wrz.35.2021.08.26.03.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 03:24:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: Re: [PATCH 2/2] KVM: Guard cpusmask NULL check with
 CONFIG_CPUMASK_OFFSTACK
In-Reply-To: <YSa8z5vQKbFuLtew@google.com>
References: <20210821000501.375978-1-seanjc@google.com>
 <20210821000501.375978-3-seanjc@google.com>
 <CAJhGHyB1RjBLRLtaS80XQSTb0g35smxnBQPjEp-BwieKu1cwXw@mail.gmail.com>
 <YSa8z5vQKbFuLtew@google.com>
Date:   Thu, 26 Aug 2021 12:24:06 +0200
Message-ID: <878s0ojygp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Aug 25, 2021, Lai Jiangshan wrote:
>> On Sat, Aug 21, 2021 at 8:09 AM Sean Christopherson <seanjc@google.com> wrote:
>> > @@ -277,6 +277,14 @@ bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
>> >                 if (!(req & KVM_REQUEST_NO_WAKEUP) && kvm_vcpu_wake_up(vcpu))
>> >                         continue;
>> >
>> > +               /*
>> > +                * tmp can be NULL if cpumasks are allocated off stack, as
>> > +                * allocation of the mask is deliberately not fatal and is
>> > +                * handled by falling back to kicking all online CPUs.
>> > +                */
>> > +               if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK) && !tmp)
>> > +                       continue;
>> > +
>> 
>> Hello, Sean
>> 
>> I don't think it is a good idea to reinvent the cpumask_available().
>
> Using cpumask_available() is waaaay better, thanks!
>
> Vitaly / Paolo, take this one instead?
>

Sure, putting this to my v3, thanks!

-- 
Vitaly

