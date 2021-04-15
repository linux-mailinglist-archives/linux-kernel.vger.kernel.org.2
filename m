Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C084361458
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhDOVuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbhDOVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:50:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 14:50:19 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso15358264ott.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 14:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4DOTBbYEKnT3EnjXiuFlp4qBusHe05Bi/ZftDfP8iI=;
        b=TMs3OTkoZpQrTMVqb9siJB81H/SU2Cyvmxywxt+jCDPZDntfBjWKju8NkqmM8LRauy
         7mq11Y1DF+8t6GO9EJC+OGSDXGMUeqskaGEMsoKZ0I5NalIf7Qsy/iv+gnuqcmMky26s
         NTye3gCqGBfPMNKocHfwkpOjNG89fZAqmgetBwfa7qQl6fSG4GdjcxE88FBVK1/Km184
         V2sZDVXWA5Dee3wZCXJhrJ0ZlqT5QMojlOGgcw2doeM2TazMY8pATAAPACTotEnQ9YIR
         m7O7rRVYVg6Y+hoytZiy9Ziuy003oMK+rxUyvxR5aIdn1xBrr4KXXmsfEmR128k6Vw8T
         3yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4DOTBbYEKnT3EnjXiuFlp4qBusHe05Bi/ZftDfP8iI=;
        b=I1RhWJqP4YgrVU7W8q/xjqcCjr2z354SjIMpY6NbEQ3oKiWQ1THbAt7l9+fMabSZRJ
         OYB1TM62AKmPZLa1kLWO+NR/cGOuQQSbt9OysMe0BX0WopiwfVKr15rNUAMNhcVt8e5G
         VZC/4UzMCTcNMjNdbux+kHdgRaG4aAQzx/l607OvdjkIt+Inp1MfNiaKvmRRVbfgjL3G
         xX/IV0WMQcJUO+b4kIeA9M5psai3Hw0ZjWzOAgdaeeemfzwGeHUNQQjnBxlHr2eNAx7P
         26Wi2ZaDhQGkOB/f3eBFOwQ1bJfGb3naKPtN3N/hnWBGWEhve2IMlkFIrNdHHIOZ4o9j
         E5fQ==
X-Gm-Message-State: AOAM531OlOGTaTfUlQvYT+9m6Sbuc05tx/zlLTh6gHalUSdfXe17Kby0
        YJkChWwqqusRdXNzgG1XisyliMuWVhWNfa6fXw/xKtNdiWk=
X-Google-Smtp-Source: ABdhPJwArKObs6KeZLmWKpYAJZakPx4EL1VEG6f5D8lDks543GYniDSSnRM6fFDXWgTL3A8vp0CsV2Ay1/oPYxpMers=
X-Received: by 2002:a9d:2f29:: with SMTP id h38mr1039188otb.241.1618523418458;
 Thu, 15 Apr 2021 14:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210412222050.876100-1-seanjc@google.com> <20210412222050.876100-2-seanjc@google.com>
In-Reply-To: <20210412222050.876100-2-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 15 Apr 2021 14:50:07 -0700
Message-ID: <CALMp9eT_pXwZZFGywhp3FQHESKC9LVncuJDDWRcYr=fLB=OTng@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: Destroy I/O bus devices on unregister failure
 _after_ sync'ing SRCU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 3:21 PM Sean Christopherson <seanjc@google.com> wrote:
>
> If allocating a new instance of an I/O bus fails when unregistering a
> device, wait to destroy the device until after all readers are guaranteed
> to see the new null bus.  Destroying devices before the bus is nullified
> could lead to use-after-free since readers expect the devices on their
> reference of the bus to remain valid.
>
> Fixes: f65886606c2d ("KVM: fix memory leak in kvm_io_bus_unregister_dev()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
