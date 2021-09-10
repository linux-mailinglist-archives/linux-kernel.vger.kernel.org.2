Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CED407312
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhIJVri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhIJVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:47:37 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:46:24 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so4140003otq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++QHrqgiKekFVysXZMhd2rrKBQpZDTBgQWBiMBTyRX4=;
        b=jKmbyI3OsVkjKnLxNtHb5YDUvhK+qmwz3B+k3Bt4ABaqQRJXU394z4mRHUDPdhgfKX
         V5qR6n3xkjts2ZQ+SBlwg6JWuKzWHseHwhsUbbVrxEgCdZpU3a1gM5HRkwdiOiKF850l
         7ssOKJyRkCCTQZp809Hfjjk/UcvACIBD/aFW9NQXALrvXwsnLD/U53RLTlL4UaknPG5q
         zLc0U8CoU/hKWcJEX9NfgFZDs4M0bNZhz3irslcUy5gW1ti4XdwVDKnue2DkYMx8wgbs
         hSOp0nHLNkByJX6Si+S5/UMooHqRHyebui6t/tVd65uizdduDT/mh/CcRPg+d3o0z5Iy
         LG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++QHrqgiKekFVysXZMhd2rrKBQpZDTBgQWBiMBTyRX4=;
        b=Dhu4GRzJfR0KmY2lL2R4r4qr5JKpTHV8+tG8lqtG54/mLLWp6xxVLvrUjl8bXbe9lh
         36wHlgkz67OnROx3rpQrh7RXgBamZBgN9hB5zfA/V8OesoyC4kD4L34LP4VFR/22Q2aH
         GhvtK+R4ZE56Drpr3qBf/Vw4naJTk+GYAoayJP/hSnhqMk7REnexaBEctLrV+4uZpGoG
         FW5TJ4tXEOOBUM3fcEZJvGxrLe/OgpdRtwVKM/yCUAa330HyBAF26pnIAQB8pLBumEHg
         3oaEfncYYdBIb6FMNFm/MxPo28kdOqZIjbEdR/adzIq2sB4mnfWOa4ze1U9tNkHWHTYY
         wIOg==
X-Gm-Message-State: AOAM532uhRc7P0aQBRkVFhOTANATBr+J/vk2FgVg8nR14Nb7og+CsayZ
        o6Zyhy/cPvzBmmzlUXfdFt0lFYGWmoeKGadi9mXUJQ==
X-Google-Smtp-Source: ABdhPJwjV66Z2n5sSFAkbvXAaXHm+ruJI4hvVih91Zj1FFxpt4TZGjeQfAlq28ovXILknWUiyC1+F7YTGIG2abe/afE=
X-Received: by 2002:a9d:5a89:: with SMTP id w9mr6336406oth.91.1631310383564;
 Fri, 10 Sep 2021 14:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210910183220.2397812-1-seanjc@google.com> <20210910183220.2397812-3-seanjc@google.com>
In-Reply-To: <20210910183220.2397812-3-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Sep 2021 14:46:12 -0700
Message-ID: <CALMp9eSYfXQScdHa84xMaXoReZZow1dCzWw5i7T4URHGpq3KFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86: Identify vCPU0 by its vcpu_idx instead of
 walking vCPUs array
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 11:32 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Use vcpu_idx to identify vCPU0 when updating HyperV's TSC page, which is
> shared by all vCPUs and "owned" by vCPU0 (because vCPU0 is the only vCPU
> that's guaranteed to exist).  Using kvm_get_vcpu() to find vCPU works,
> but it's a rather odd and suboptimal method to check the index of a given
> vCPU.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
