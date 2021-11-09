Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1961E44B1CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhKIRSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbhKIRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:18:25 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C5C0613B9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 09:15:39 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id m11so99654ilh.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYl/0RFwOVcvzV5FJNNc8TPk6OF3cF1Os+dfyzaR2sc=;
        b=kkML1A+9NWE2na1XNjUxPeSc3GWNNqJ9ssD/HEhYNryUJ22ut3IKWAdXmYPaCX+MpQ
         CE72bmzyaKD2hx7qGkts4/B3zbUMQNCJ8AMi5LUAQZXysiLvg6qrpG289EB3APFfHjWL
         vFssi7WrVjLh32AoOXqYwgHHqkBovgB7OsgPpyHr3sfqnnpXZYk1Hpn+pvWsSU/2VL0b
         2AKlYnHxNLsQw3+kiTYcYXMAy0EtXgZWXt3WuCGMJGN3BvrPUsl2+0yiaGfVDz0Fn6By
         qF3+jMQyVAX0+rBdrI93JM+gNiYXdUEqEqEfiquYUFMPR8D4VRkAuSJzmd2hQ8FbUaQI
         uPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYl/0RFwOVcvzV5FJNNc8TPk6OF3cF1Os+dfyzaR2sc=;
        b=AFAFdze2jsFXfdOJKD1IjJzc2pl9k19VS74clDkSJrBqeX+O6Jj/BciVpIl9lBUo/R
         GJVGLdfXoswCJNv9cMNurrv5T48hjHDtiYppNQY1ykSTl6cS4loh2PGGyBHassOX8ucG
         hn+79pPXDM3YwUVCmbHgZquq3e/s7NcSLiF0bDTChmYAxhrZTX800imcZgIgIv3l099y
         HFVjckzm9kEP0H0omjo3p8egyuIihFH0uw4cY7QsOUKDec7J0H1FNRW20F5PSV45x7SE
         oAiYrr3R3vJEXw8+Jx1oC/67lfzfupjpm1nNG3qdFc2t4L3WOEhJZpAEVl2qQqIoan5J
         hirg==
X-Gm-Message-State: AOAM53021D897wCUmOzcf68DeC2I6VwKESbFpN14kHithpMYWrqshmge
        VKsGsT8RnOEtQ/2SbeyNcovy9q9UkZxhasD8PWEEFA==
X-Google-Smtp-Source: ABdhPJwjNTgvbLy1g224mg+aP1u4fbve1xo1WmmvV5DGlp3Q3vRrl6HubYy1Hp6u3SiArybZKdMLa7wYNLBGwtV45fw=
X-Received: by 2002:a92:cda2:: with SMTP id g2mr6190318ild.2.1636478138921;
 Tue, 09 Nov 2021 09:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20210913135745.13944-1-jgross@suse.com> <20210913135745.13944-2-jgross@suse.com>
 <CANgfPd-DjawJpZDAFzwS54yukPSsUAU+rWsais2_FCeLCZuY0A@mail.gmail.com>
 <CANgfPd-njeSYSiytAYEXLG8wwTmLBA6viV7YAHj5uVeukPde=g@mail.gmail.com> <c4f051e2-2c85-d367-549a-d5ad34af7a13@suse.com>
In-Reply-To: <c4f051e2-2c85-d367-549a-d5ad34af7a13@suse.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 9 Nov 2021 09:15:25 -0800
Message-ID: <CANgfPd_+B6SZ0sPNDguCic1Q0SG+XL8-4+xModzcYu9d1-puBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/kvm: revert commit 76b4f357d0e7d8f6f00
To:     Juergen Gross <jgross@suse.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:47 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 08.11.21 21:15, Ben Gardon wrote:
> > On Mon, Nov 8, 2021 at 12:14 PM Ben Gardon <bgardon@google.com> wrote:
> >>
> >> On Mon, Sep 13, 2021 at 7:51 AM Juergen Gross <jgross@suse.com> wrote:
> >>>
> >>> Commit 76b4f357d0e7d8f6f00 ("x86/kvm: fix vcpu-id indexed array sizes")
> >>> has wrong reasoning, as KVM_MAX_VCPU_ID is not defining the maximum
> >>> allowed vcpu-id as its name suggests, but the number of vcpu-ids.
> >>>
> >>> So revert this patch again.
> >>>
> >>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> >>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>
> >> The original commit 76b4f357d0e7d8f6f00 CC'ed Stable but this revert
> >> does not. Looking at the stable branches, I see the original has been
> >> reverted but this hasn't. Should this be added to Stable as well?
> >
> > *the original has been incorporated into the stable branches but this hasn't.
>
> Just yesterday I received mails that this patch has been added to the
> stable branches.
>
>
> Juergen

Oh wonderful, what a coincidence!
Thanks,
Ben
