Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0A3CF363
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbhGTD4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbhGTD43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:56:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7402C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 21:37:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gx2so1905025pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 21:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbJ5l/mzifntQdZgcoAMozoV8xnurm7BXOSvdrIxbhg=;
        b=mq949U1s2+kAYZI0X3lgUoNXTGjhIZkrl7UOL0sPaK2QLJ/i/YLoHlNHs/Kasexq9o
         aonmjdVagasMfgKQ7UHxzTrkrwCiIIsnXbg9DfmeDxLkHUkV37XBWcNWfZj0Swx9vqWi
         ELkbuloc5D29K6er/zFevAbSakKTLFOqO24nHFIql+8yx+A8Wn06QH0MMn3AeD2dL+nb
         /IXgREyPLNTEf7yoCCZ3ltix3nR2xw2/zeoNg6ioFHOxGt5XBwvD1Kk0pA2IqKJUo75O
         23yfUcc9Eu7N1aV1wduxNTFPcCd6d70zGzujjMQMG3URPmmx+2KUYp+U0Z7mcdzLYXl6
         iBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbJ5l/mzifntQdZgcoAMozoV8xnurm7BXOSvdrIxbhg=;
        b=LmPXKzHr9FeMFbfNW4cXRxL4px8D0NF1AnkiQQ/P1IJYdyWd70HgVAh/lvKEzc5KwT
         vSmR7Ezdlxuveq5pM6+Zdh4B6a5A6i1oOlDxPrkSmLvSCu5omjdaaAzI/fDOCVqCJd2g
         ZU14NYTyiCG+cZLzS2g+WsleGTGFbOWeFNPdfj2UUMkW06PuOcu3CollFDyONpLbR++F
         nDTA1mGWNTId4IfbQFy8+MzaZIsPbQacL/pk3Jngq1hIVVZ/LmSfRJrM6bnft1+NAzr0
         evq/HUaf4OllTegiQH9z/znfCVFL7zL9ED8X5mVEjeonMeq5wgq4nAG3VJHjyrmsDyhm
         YWQg==
X-Gm-Message-State: AOAM532pKAEHKT/orJwi9nNLQD4Uh2gD250n6epoBOYmD7pijMuBUFfe
        b6Su+DrrEGPH4Y4CrpKAY0ySNqdKQeAisxWw72VeQw==
X-Google-Smtp-Source: ABdhPJxVYzjLwg+WrH2DJ++AV1AOi2rqP2W42mIUyF1Blf/p9WzgLzJ4wqRstvUbJYWqQh3FCWDRx57OJD7EJ8N01dM=
X-Received: by 2002:a17:902:8484:b029:101:7016:fb7b with SMTP id
 c4-20020a1709028484b02901017016fb7bmr21740363plo.23.1626755824154; Mon, 19
 Jul 2021 21:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com> <20210713163324.627647-46-seanjc@google.com>
In-Reply-To: <20210713163324.627647-46-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Mon, 19 Jul 2021 21:36:48 -0700
Message-ID: <CAAeT=Fy_x6ziS2BE+fYigm_i-UxPyGz=QQ7yuB2HA1TtXBSD7w@mail.gmail.com>
Subject: Re: [PATCH v2 45/46] KVM: SVM: Drop redundant clearing of
 vcpu->arch.hflags at INIT/RESET
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

On Tue, Jul 13, 2021 at 9:35 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Drop redundant clears of vcpu->arch.hflags in init_vmcb() now that
> init_vmcb() is invoked only through kvm_vcpu_reset(), which always clears
> hflags.  And of course, the second clearing in init_vmcb() was always
> redundant.
>
> Suggested-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>

Thank you for removing the redundant code.

Regards,
Reiji
