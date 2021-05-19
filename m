Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645A8388698
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbhESFfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbhESFeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:34:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B771C061763
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:32:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso2842910pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhLf+eMTqvgVmDy1JnhP0/EYBvns5BKG0ZaFzBFNEck=;
        b=i2Y5024Ku0UYqibr3fbtLbTgkYGj63aqutNzgHEugRfo4iK30nrXYchV4fEuL/+s0l
         1q/Ns3ADPIF79+7O1lzlCqR2g1HoSon6U5z93DG7IZzWIGo7I0qlbp0kcVaYNAQSxrJF
         rqBSGDs/LcM6mg53ob75K6XRJdHXUeFNzmPqkOZrqE1WyU02o19LsMg7dPMq0mvXh5j0
         hWqKnLFUIrCyMqOZuXUotkm3lXIgOg43V0iUgYMPIIve+vw4aVvG90VZeTlC/0LGjAdq
         E1OyV6OLJFh3HYTYB6EJW9G+boXopMKDV5n2qsvl3JhDfdBTxde6NsCp5B2Pi23eK7DU
         yFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhLf+eMTqvgVmDy1JnhP0/EYBvns5BKG0ZaFzBFNEck=;
        b=hH8ZzEjsaYGkbNfGkh13MmeiaSb2b7mOftzORKi57jd2ucIsGSt8+ejf1e+J9NGPKu
         7HYB7Fs7e9L5E0ritZtDqc6p71op+3N/5VFKQ5Z70+IGGNlpm6e24PVNgmOx4pWUIvY8
         baFvm2G5vr9BkdPOuOrHjZ0hgXW1eTafU+jve/gqrt3dUChooOsslARbGlpPDbDif41Y
         +guFM4YLkFw7kOccIPHQ6QEDZJqXsujlu6NV7nueqhhTaLbryAGgR7jwYhC0jU1ht/6q
         j1bV56hvKrFpubBt9+OiDj5wSl4yu2nCk1Cg0cjV6qWMXnt3qID4V9nFd1yXUVD07CUf
         YM/A==
X-Gm-Message-State: AOAM533jCcRgooXnLMJALUwJXPu/TuCJ3ZsiV+z2//wiSAuAzqUNydsB
        0roo8jD0MvqZ/RW+0hUDodwCjgE1W46GE9Gp1/c8UQ==
X-Google-Smtp-Source: ABdhPJyHf8aBcSGEAC466lj43/rFw+b51DrLrBcTKoV9XmrepGyYrUWRjJsBoUEkzRpOzt2TaY4g1J0q2qtUR95WCXU=
X-Received: by 2002:a17:902:b487:b029:ee:d04b:741e with SMTP id
 y7-20020a170902b487b02900eed04b741emr8755124plr.45.1621402367014; Tue, 18 May
 2021 22:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-9-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-9-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:32:31 -0700
Message-ID: <CAAeT=FzE9BREDyK2C3LWdGxArucCi8jF24OLTsL4QrYz0p57Yg@mail.gmail.com>
Subject: Re: [PATCH 08/43] KVM: SVM: Drop explicit MMU reset at RESET/INIT
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

On Fri, Apr 23, 2021 at 5:48 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Drop an explicit MMU reset in SVM's vCPU RESET/INIT flow now that the
> common x86 path correctly handles conditional MMU resets, e.g. if INIT
> arrives while the vCPU is in 64-bit mode.
>
> This reverts commit ebae871a509d ("kvm: svm: reset mmu on VCPU reset").
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
