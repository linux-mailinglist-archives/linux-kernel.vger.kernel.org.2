Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1E3732B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 01:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhEDXZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 19:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhEDXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 19:25:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 16:24:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d10so368866pgf.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCjpzDhrttWsw5MJ/p42z/oli5HL0EZ4CCcwCVvuAoc=;
        b=Jsjd0wfSASc35JMy8OFI+WGWdedhSmWjdc9/8egrIrj/OAUw1r3z0rbzxov+fJMCdB
         8LCoDvmG6EHJ0veMHcaOO2y7esjJsxDR02u80b6HuYIjk01mdo+M80bFI99KNvDTT2o4
         C50gnrXKnC5OkpOvBU75vnQxbhNksQ5ThdJ853VWIGHmBzge/oFgeNt568JWwqhlYhB9
         IKt15CCP7c08U+Q0LG907KjvgkJnGsCgY0ZWrp+yrxSDIWSLEDuXul0XFnx0ULpszY58
         JtCOAM3G2shxJVixfcKgUnxCsuGrToUGIFC8UvSHym/6qJ5Q9bO9KLESGkA/1Zf4uY5G
         m61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCjpzDhrttWsw5MJ/p42z/oli5HL0EZ4CCcwCVvuAoc=;
        b=CrbmYXGo5pjbs7MSToRGVecH8pT9V91oWtO2sxOx54hryZ2DDvziTVLEmln6e//6fU
         oHZQkmEynJqqot0CHVGXyqV/xiNU3+Nzk4pxByd1BJOy8XYPivHfaqbrpuDPZbTp/brO
         Midth3iPEIxziAYvEELgoYG6Fk91TwZE7dY/a17EiAZ+uuiwye2DrJQm9o6i+Byl0dnN
         SFsD+hUKTMI0nV/m8fUFpjTSp3s0WslCeEZJauJhEwYSkAzmw5fVyz7F5M4hhsiA7szX
         ve0bqYLItlRn5IlKTwvCtObK5DCmm7dBNxLxockxm2IAFR9E53dCAqilsQiTLhN4SJBL
         F56Q==
X-Gm-Message-State: AOAM530Gr25s/McA/t4Qd78iBvExgEfzABQmyvdA+/GpHTU8ecsxvlt1
        E7AZUKbMCf/Amw+u9ywTUBuWv75hj5Mos8sjlg12TQ==
X-Google-Smtp-Source: ABdhPJy/jLwkYb2DIgxmx6j08hXvs0Rg7hT+i/eMkXx+ku0j6lxB7XK8qoX13mi1aZrW9aon251R0axwu5gMzqpW2tE=
X-Received: by 2002:a63:ff25:: with SMTP id k37mr5373178pgi.360.1620170652347;
 Tue, 04 May 2021 16:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-5-seanjc@google.com>
In-Reply-To: <20210504171734.1434054-5-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 4 May 2021 16:24:01 -0700
Message-ID: <CALMp9eTh6JMdeAW9JAP7L6CciBQYgOPgogcQzcfKf=quY0k_2w@mail.gmail.com>
Subject: Re: [PATCH 04/15] KVM: x86: Move RDPID emulation intercept to its own enum
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 10:17 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Add a dedicated intercept enum for RDPID instead of piggybacking RDTSCP.
> Unlike VMX's ENABLE_RDTSCP, RDPID is not bound to SVM's RDTSCP intercept.
>
> Fixes: fb6d4d340e05 ("KVM: x86: emulate RDPID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
