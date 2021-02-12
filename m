Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936DF3197AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 02:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBLBCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 20:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhBLBCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 20:02:09 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25982C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:01:26 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id f3so4590515oiw.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YtrUSFE4UJxIRgtprGaYSyVbZ5RUtrrAW9L1A1aPAM=;
        b=aNEO/kRlojFeLEP0qjB/cvQQntewciuY7gOlX5Ut+MMKNwBaRnN3hRur6M2YQJ5y9Q
         /W66JF6PWlKAHDA1g0/VD9Zle6jAp6s4SfbMXMNTrLpHXOTp3tsjySfTJ+dhWW3Z2S5D
         uyPGFySWIYZMh82pa3sZG6IXH/82xKew7RCP8R78lIMatjIME6vpfpjnHifxjP99Iffm
         1ihZybbbrwRxpWw+/vw2lDBdDIjdN5IjzO95mpVdyCxqKVde0sqCoGDnSABKMLLEP3DQ
         0Tt1w194wddNSqG6ZhGp8W1id3KtZOKG/0zi9aaZFtsRT22Fuan8UIKRXhac4rSx9kNV
         0BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YtrUSFE4UJxIRgtprGaYSyVbZ5RUtrrAW9L1A1aPAM=;
        b=LmcIq+QO9xea3c9RZu+3nunTN30TtcT82ldP7YKLQin5DBYZNMv97l2oTokj6YLzyL
         8W8b6oCqZWkOkXMECT0F0fXhEkSR4yk4ZJ3+Srh5c6J8P5mUANg9f/oitwcCE8yCSpyw
         CxBZ3HmNa3uUh0yraYDn7OUc9y7PNoBmntVJFdN+F/t6CdLm8S1I5xrC/16Znhf2mhSp
         /CaWMOP21AFcHHmrOuUFtz65oyzUsNt+vASoXye1H6xF6YgK/8iN+FD/rsvHiTSg3B2O
         SzzSXeYqltJDxL5fEyIT9zJ9wbMcLdvY9Tqr7xKaWvPXID/MQk8YoBGWlk2zVL6npODS
         RSqg==
X-Gm-Message-State: AOAM5324KOzuDEHT3LiKSjHCsm6b+tbt/how5czcF97qA5rFQsHBvr9d
        TfKytWN8yfMGMbeD/JAnSPfmjua727zy0Kgs+b7D2g==
X-Google-Smtp-Source: ABdhPJwLhfqYPeRsmtMMO97n8ySrNv2UOTZ4UHhf8NE1lf1LkIuaq0Ygs5pm6LUH3negoPkQwg2BYittfMhqW95bHEs=
X-Received: by 2002:aca:5008:: with SMTP id e8mr344509oib.13.1613091685350;
 Thu, 11 Feb 2021 17:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20210212003411.1102677-1-seanjc@google.com> <20210212003411.1102677-2-seanjc@google.com>
In-Reply-To: <20210212003411.1102677-2-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 11 Feb 2021 17:01:14 -0800
Message-ID: <CALMp9eRhSCWWEcxR-UoRoQ-g=ZFhj20Cd15Tu5jP8LZ7mBi9FA@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Intercept INVPCID when it's disabled to
 inject #UD
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Babu Moger <babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 4:34 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Intercept INVPCID if it's disabled in the guest, even when using NPT,
> as KVM needs to inject #UD in this case.
>
> Fixes: 4407a797e941 ("KVM: SVM: Enable INVPCID feature on AMD")
> Cc: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
