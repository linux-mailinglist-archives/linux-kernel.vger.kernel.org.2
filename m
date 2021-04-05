Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4C33546C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhDES1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhDES1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:27:48 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BEFC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:27:40 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w2so7949376ilj.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCxby3Jp5TDKJXrr4ksAkJ+LF8mSCwQ/NlCo5Zzkrdo=;
        b=IUDndj+NlOsbnvqLrJrA4zHuJt9Vs7IworFD6VxxbROtpkqg0l2ynBlNto+4cLzSjv
         CBqCXCrn7WDsHK41/JMb2NgQwLVmTdMQTnrxCAXmS8Qdqk1W5NnVnKJWYrVMMN6mJ8sE
         Sd4VQc3CyR1Po4veid4ACzu0WGqPi+dh7nmptm7mxALpp5JyCX4c3QAX5eLlfGADiWCo
         BWDXyf8f38hNv/BaDmFZp61lDr0ByYbljch++BE2NJPOHMahZF7ygmcfYx2H9aKCnhRN
         Aycyc1u6/yoa6o5urIRmSi+f+7FAXxJN3oiSyUEyRw7LA7cQtMgqqMIw4/VK6b6bK/ys
         FGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCxby3Jp5TDKJXrr4ksAkJ+LF8mSCwQ/NlCo5Zzkrdo=;
        b=pgRo81dFyR5YNnzemj2ZR2VZbJDI7Fgp0bRpo23SoulYRRxVkcOqBdM28k5KPwePC5
         HchRb0oUV3YgkJshWyt/CJuYwJi84ErYkwV2pmoxdinD5fOwePBpOIvSUxVsJb5BogVA
         FLOzcOkLfkhCY8ILiICWQc0wYLbGWYK3WSSnbapD0sQagJ3FYXh6Jps0e0DDRdTV3fh/
         Hr492lMIcywddzHUkfK11LAkCbMNtrdx5RcbUvvhuegTFnObIvpUQA5ad1sO7E9Iaf7v
         bMt4g0tybjXNCat/+/GPOjB1eNzcWJbOUExoSdtNg6i1SF9wHRvXdgC3YY0F7Aw8yna8
         tMLA==
X-Gm-Message-State: AOAM5307ZoJb6Ip2oW69Z8yHAfRDfUh4K9ztRIaf8XDKwzxoE5wxAk2/
        jvgwIa7qEufiQ6mnGNl/XGE2aFt5aS97EnZT5vYveg==
X-Google-Smtp-Source: ABdhPJxS8I/5yEmMhDbQWAaiuF3BBv1UnvC6mGDWjwLfslnVX8VqYQJmI6QNB80ecemQTE2HG6SIkG+u1KcaJimmJtQ=
X-Received: by 2002:a05:6e02:792:: with SMTP id q18mr8124507ils.212.1617647259435;
 Mon, 05 Apr 2021 11:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617302792.git.ashish.kalra@amd.com> <CAMkAt6oWF23YFiOGW_h+iyhjkaAp6uaMNjYKDXNxvNCWR=vyWw@mail.gmail.com>
In-Reply-To: <CAMkAt6oWF23YFiOGW_h+iyhjkaAp6uaMNjYKDXNxvNCWR=vyWw@mail.gmail.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Mon, 5 Apr 2021 11:27:03 -0700
Message-ID: <CABayD+dDFMEBTzSxEax=wJLwg7-xQi2C5smPiOh=Ak6pi72ocw@mail.gmail.com>
Subject: Re: [PATCH v11 00/13] Add AMD SEV guest live migration support
To:     Peter Gonda <pgonda@google.com>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 8:17 AM Peter Gonda <pgonda@google.com> wrote:
>
> Could this patch set include support for the SEND_CANCEL command?
>
That's separate from this patchset. I sent up an implementation last week.
