Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC53197B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 02:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBLBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 20:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhBLBDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 20:03:13 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:02:33 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id l23so6996830otn.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 17:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0c1aSIeooVn4US+T6upq5lsDdJzeDCNMF30EK7w2HE=;
        b=S1InspJro/5H+/PPv2oAx/fl5V6hyGWL2V07Fg3jY4OGhk7QkxsIb/sueJeRJV02HL
         vylAZdhY8uYBMpNfhqwnNreL+ozzlyjbiQMJWd4jGTb1kEpDzhINj1U+tZPDVsKqVQ5Q
         WH3ZM3gldRXDXrzlAyyhdu57JAketnJNAdAr3uMyVN8UkuJp0wmn+4NBd6sydZFeOdWg
         0KoknN/LH5ri3CTAElpVGI69ZBbINnYQ87g+CBt9UmFg7VPk+bE+a6KUrmA4rBWWDoPe
         t1JRPOJ0qO42TURynD57svVquAdzTlZ0lyrlpb7aTBUgHu/cbDF4GLgH9xh6JmBfEebV
         DNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0c1aSIeooVn4US+T6upq5lsDdJzeDCNMF30EK7w2HE=;
        b=eBmDg95MpCznoqK/UlFh1cFaK+doz884gBZG7/KCby8it5oCsFOXqieZG67SACBUtf
         fSi2J3OiuawA+e/nJkYjxOTXlrOi7Q376fMa0MsB0tXGwXUAijWhPzhQ7m/VrS8S8sOQ
         1MkA5VPRCaeM0onNMTsaOqjkSIJgWIex9689YQYh9yg02PF26K0vEwyyVhC58tKyq3lX
         7EJenhwob9fjrXkET+195JeLzWVAZrTbKet6y6/EOlHMLJ39iC0JDj42HzGaAME5x4j4
         qNITK7nESnAAzR/xTFJeFLbW95NqICY14p3jwOC6lFDpfk+4hBx7NEUcHjeg2OYo9wui
         3HXw==
X-Gm-Message-State: AOAM532GtrPyHnCrZz+yQcYkkQC84Ps7QpYdleIuEv3ne6PPiETvkKEa
        GFvdkLBB1oidVdWD1ONW1Km01FWK38h703TcEj7JBA==
X-Google-Smtp-Source: ABdhPJz9r6ERkoLQdfI+Dwjfs+b2Nx+GXUAiPbP59fdVrcF4sukekzYTaNysdabBFweaMURitABWaV8HPVOUGwzLdmQ=
X-Received: by 2002:a05:6830:543:: with SMTP id l3mr452534otb.241.1613091752913;
 Thu, 11 Feb 2021 17:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20210212003411.1102677-1-seanjc@google.com> <20210212003411.1102677-3-seanjc@google.com>
In-Reply-To: <20210212003411.1102677-3-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 11 Feb 2021 17:02:21 -0800
Message-ID: <CALMp9eR2fun289DuqSC87hkTyzT3KpvDwojhRis8KqLJS5_qaw@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Advertise INVPCID by default
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
> Advertise INVPCID by default (if supported by the host kernel) instead
> of having both SVM and VMX opt in.  INVPCID was opt in when it was a
> VMX only feature so that KVM wouldn't prematurely advertise support
> if/when it showed up in the kernel on AMD hardware.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
