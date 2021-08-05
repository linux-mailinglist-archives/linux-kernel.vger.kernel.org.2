Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350C13E1EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbhHEWfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbhHEWfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:35:36 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2439C06179E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 15:35:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g5-20020a9d6b050000b02904f21e977c3eso6816513otp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVTnHbOM2DIScdbOMEPWTzanu221l3U7VK0cHnd3T5E=;
        b=jSeCtqHhi/x79MnldARKBL7d9Q5jQRTtyGjjvO7BlYCrgANaxgE/iHQrfOzrtugUN6
         HzjuE/bbR6a5M3ZVLtyoDbDvjPoFZSCPw/s6Ae3pUgYA/wdS4WVLYf/xmsswwI0ByBAX
         f6XnZy05IkxYlIbdTviVjXeZHWYWN5xr1yto4Hmp+knx9DUH67jN5ur+HjlAXU9MBfkz
         LVo2vdBlDjeV5WnLyemK2vl9IWA6UoF35BJUo1cdrMq5Z5UbYdn0qYzh4LycMTXEGI0D
         VMasLhu35ZfoiBiSdk6A7Ylx5RlBtvIFOajLumF4zXSbUz55tCpzEBUOjg4wzzGctQcd
         2xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVTnHbOM2DIScdbOMEPWTzanu221l3U7VK0cHnd3T5E=;
        b=s+gtF376Am2iPUrRFjosGq9SmU2Oqd1Fc8rOwJMTJWegoSPwJXvKXUC142P+6jLv4M
         R2Dw5FYQO9Uxx6DmlxElRNEfR1bO/Q27PmTb9Me/T/Ww6EBWQoaSGJswu5+vYnVbctAz
         o3PA0aF1BmYSBS2sTQttBK7uMfGByFmYsaZgovZCltVATqFLekZYZFnJ+mGQhiQfyBJl
         PAOX0ed+PQI1dSS7oN+mLhTzbkwwdYoeVBLH42xAIQw6+eQi8UY1DiJy9F3rjfOY5xrK
         h6ogctt066/Rse+rM2AB8UuL+4Qxz1EiGZa8SUh67xNQb+RHVkUviwtgmbKAc/S8m2tq
         H24g==
X-Gm-Message-State: AOAM5336boReMHa9H08D1Z7Au8aKFciNz3JUejUg07par4QoerCCKggn
        bL/ywsBhLm4A0YgFnmUlwDVtMhLWTT5Y8t1JfcfyNA==
X-Google-Smtp-Source: ABdhPJwxSWHS+jWe2WlBMi7czuy+aHK6+kskkhu0+UuEKMMQRlav68RJx+SLTsRlLAw+CToodEymMqDOm4/rlrSOz2k=
X-Received: by 2002:a9d:76d0:: with SMTP id p16mr5424740otl.241.1628202919840;
 Thu, 05 Aug 2021 15:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210805205504.2647362-1-wei.huang2@amd.com> <20210805205504.2647362-2-wei.huang2@amd.com>
In-Reply-To: <20210805205504.2647362-2-wei.huang2@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 5 Aug 2021 15:35:08 -0700
Message-ID: <CALMp9eQ_SHmFn0ahTyOnyk+JDs_D0qxN9Hc9VFMGDDixc13jUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] KVM: x86: Convert TDP level calculation to
 vendor's specific code
To:     Wei Huang <wei.huang2@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
        wanpengli@tencent.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 1:55 PM Wei Huang <wei.huang2@amd.com> wrote:
>
> This design assumes that all x86 CPUs have the flexibility of changing the nested page table level different from host CPU.

I can't even parse this sentence. What are you trying to say here?
