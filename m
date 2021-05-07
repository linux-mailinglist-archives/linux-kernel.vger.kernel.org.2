Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932B3376975
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhEGRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhEGRXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:23:38 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4959CC061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 10:22:38 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so2224185oth.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQ3ipQxbX73bGU2SXA3y2Bzh59V5vke4f329EGQixvg=;
        b=KH8GL3iNV6Z/uD3TMYgD+CrCfLVaUDeAs0zqsk9jCpnDJJCpW0QyHmMSjWWmSLhvJ1
         FDtdqZsKLe2uoN2TDpAYLCOrimwhcklk1sSa42lMZ/jWzznAXKuD2WvTNhdBcUnJy88h
         Q+lub5DzGRR83dIb2AC9agASP4rw1QyRLhGkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQ3ipQxbX73bGU2SXA3y2Bzh59V5vke4f329EGQixvg=;
        b=p7Pn4OxWIpA2qMUftSJPSlOF+UOI7S8vnGmF9snAruk9WR3u6OwDBLethfgzFRM30e
         F6FadThgwi+H+V8n2cv0XDERlgOO5jAP2QX+ov2eOP51JWm3DX5kj+7KjMhkZD4du/a9
         wA9LKU+8Nt4WPgRMzbHqukLKGxkERtgjHELxEK7UqNdp6NJjl7zqdtpwB6tgl7oRSWF6
         qiyfwUEI4QKIUB39m6POjWNHXdjBGVfcTfVjUfALFx6fy+x7CzSZ6jE+5nQjHQLv0xAv
         A0HXw2B1IeHPf3yp6mIFwx0Z6RVo2GE1VKwlzZJ6MeJuJIi/0ORK3u46s64/pRjW2Eq+
         bJFA==
X-Gm-Message-State: AOAM532qT3AHmg8cLz8/56wXTRbhmk00SrLYaW1yJXyi1AXbmELZjZSH
        nsON++VhFqg+V1B8uvhGKxEKi4y+RAssabec5UCBZQ==
X-Google-Smtp-Source: ABdhPJxDU02k2Jf2AhhsznQct+cAPyxL7BbEYKFvu6VMh4FAxQjvUIGiWjfmwnilcwXbYXtl5qcWmP5bc5q29/lz1jM=
X-Received: by 2002:a9d:764f:: with SMTP id o15mr9279052otl.164.1620408157620;
 Fri, 07 May 2021 10:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210507150636.94389-1-jon@nutanix.com>
In-Reply-To: <20210507150636.94389-1-jon@nutanix.com>
From:   Venkatesh Srinivas <venkateshs@chromium.org>
Date:   Fri, 7 May 2021 10:22:25 -0700
Message-ID: <CAA0tLEoyy_ogDc11r_1T907Rp5CwgM64hFwRt5SX40THp2+C3A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: use X86_FEATURE_RSB_CTXSW for RSB stuffing in vmexit
To:     Jon Kohler <jon@nutanix.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 8:08 AM Jon Kohler <jon@nutanix.com> wrote:
>
> cpufeatures.h defines X86_FEATURE_RSB_CTXSW as "Fill RSB on context
> switches" which seems more accurate than using X86_FEATURE_RETPOLINE
> in the vmxexit path for RSB stuffing.
>
> X86_FEATURE_RSB_CTXSW is used for FILL_RETURN_BUFFER in
> arch/x86/entry/entry_{32|64}.S. This change makes KVM vmx and svm
> follow that same pattern. This pairs up nicely with the language in
> bugs.c, where this cpu_cap is enabled, which indicates that RSB
> stuffing should be unconditional with spectrev2 enabled.
>         /*
>          * If spectre v2 protection has been enabled, unconditionally fill
>          * RSB during a context switch; this protects against two independent
>          * issues:
>          *
>          *      - RSB underflow (and switch to BTB) on Skylake+
>          *      - SpectreRSB variant of spectre v2 on X86_BUG_SPECTRE_V2 CPUs
>          */
>         setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
>
> Furthermore, on X86_FEATURE_IBRS_ENHANCED CPUs && SPECTRE_V2_CMD_AUTO,
> we're bypassing setting X86_FEATURE_RETPOLINE, where as far as I could
> find, we should still be doing RSB stuffing no matter what when
> CONFIG_RETPOLINE is enabled and spectrev2 is set to auto.

If I'm reading https://software.intel.com/security-software-guidance/deep-dives/deep-dive-indirect-branch-restricted-speculation
correctly, I don't think an RSB fill sequence is required on VMExit on
processors w/ Enhanced IBRS. Specifically:
"""
On processors with enhanced IBRS, an RSB overwrite sequence may not
suffice to prevent the predicted target of a near return from using an
RSB entry created in a less privileged predictor mode.  Software can
prevent this by enabling SMEP (for transitions from user mode to
supervisor mode) and by having IA32_SPEC_CTRL.IBRS set during VM exits
"""
On Enhanced IBRS processors, it looks like SPEC_CTRL.IBRS is set
across all #VMExits via x86_virt_spec_ctrl in kvm.

So is this patch needed?

Thanks,
-- vs;
