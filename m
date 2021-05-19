Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943DC388686
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhESFcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbhESFbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:31:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053AC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:30:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s20so6351598plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgnXGca0Sj0Q6Z+AnySOLxHV/ucQfpgB5ZEXSsAu5Q8=;
        b=bRC23/Mld4+4uILCqIPUnHY2jHl3CZi3T7iD0gSmsxCdlKa05Ao/B/UgkGOeuoQmhp
         UOnTn2IOAPVgXeV/H+pczFQeylg5HouR+ULoN6jgZbwfNVMRVqdMcUZP5E9QE7gSwRzn
         8CsDFHcCPl7Y/Ntt8X9xFJxRDFYZQIP72O7S4Qa1xJC33t60nkpdulyRsOT+vhZO+WWa
         r85DllRRgfaoVrB3lppKzk65uLwvKBRSRaiimxmxOSiN5lyKU0u3PKJhfjBvweEKYt+V
         Nhq7jkRTaaUO/De4e1eAxoM5GMcK40CiK0mjpRX7n+jSsEgF2OJYLR9N8gW5liz5qSR9
         o98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgnXGca0Sj0Q6Z+AnySOLxHV/ucQfpgB5ZEXSsAu5Q8=;
        b=TIsuRvWAH1fCSyfZUV833DK/NA2K3ALYZO6RBjRfD90iLm6Zn3vx++D6zj6ZG2jqoP
         1/y7WLoOZDBGpSA6mWJ6HBcmR/0xDXUfEeK65Hkd/Jc4le88m1y8RiISDEuL/obwAxC6
         UBL6i0p05/zBraYC6NwrJSMBIuuQaY0SQOj6tQF3LaV7ki2t7CU/5Jp5EMZfozpEFh/L
         bvXR4X8yEngXJ6xDT8ulhKpCCSEb78vyI3PYH2aA0+A8xvNxRHKaiFxq2cIePn9mJwJh
         WlylwGd5uQ6+zk1TYit93vtEBAwGa4xK5ELcgc3jMeceiWo+lINnOm6DQz4Xn5jAZbhS
         0X5Q==
X-Gm-Message-State: AOAM533rTOZWAgzM1PRcQYNpbxENElixtgt+nqDvM73tlpZR+81wA8TG
        k5EvcUkBo7y3JqAzCYNIb1dnryz7poZfdStaCh07zw==
X-Google-Smtp-Source: ABdhPJxhtMPkfKErvsjTiGyK8JketB+r2z2FH+qqg9oXaQ6PmUAru4AZI1A9bFUDH0sBGcYWdWJLONefMzBmQySvzhQ=
X-Received: by 2002:a17:902:f20c:b029:f0:af3d:c5d8 with SMTP id
 m12-20020a170902f20cb02900f0af3dc5d8mr8741262plc.23.1621402234545; Tue, 18
 May 2021 22:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-2-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-2-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:30:18 -0700
Message-ID: <CAAeT=FzRbCLT1AKE4QYbG6LwUhgtRfgjRDPVqsu0Y8QU+USHeA@mail.gmail.com>
Subject: Re: [PATCH 01/43] KVM: nVMX: Set LDTR to its architecturally defined
 value on nested VM-Exit
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Set L1's LDTR on VM-Exit per the Intel SDM:
>
>   The host-state area does not contain a selector field for LDTR. LDTR is
>   established as follows on all VM exits: the selector is cleared to
>   0000H, the segment is marked unusable and is otherwise undefined
>   (although the base address is always canonical).
>
> This is likely a benign bug since the LDTR is unusable, as it means the
> L1 VMM is conditioned to reload its LDTR in order to function properly on
> bare metal.
>
> Fixes: 4704d0befb07 ("KVM: nVMX: Exiting from L2 to L1")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
