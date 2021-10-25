Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D50B438D05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhJYBdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhJYBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:33:35 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD93C061767
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:31:13 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o83so13420675oif.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOLlZX762RU5af8/NNyJtzm5bln7tTCbxfFHlagVxqU=;
        b=TkNaOXOJkzMC/4YS68UKZsixboDKL+fTnwKOI4TzlCB+1Ozwmv2detwjUcvSRQJDq+
         nmB+TBXyDhTBoEChQ7wjOVDk/Ga5X3LMg9Hj09ObYr5+Ez+IV5DG58zOvlbOO/m7yJyS
         pLJVxkqzZCk0TFsYoqt2gLvBgnXcQjR1pKL+xLbm/5HdLAyVKb3h5sEy17VxhUjKpYRl
         0kTi0+CFF/fx0vJGJa8sDJerOImUFf0KMW/0mxR7S4O1B2FdaGGOjBdrtoBrpWkkzz4D
         eEp3VF4O/Y/1ynX8o8d5JRiVQakJOQnU9mBggLGsCUT6gEmxGSNxCemEoeArO16CkX+u
         5blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOLlZX762RU5af8/NNyJtzm5bln7tTCbxfFHlagVxqU=;
        b=xpM2yPEqQDmSRt/PmM+y45cF+1m8AbueWFCMDry5fx5Uqy0KjHx1c4QRffC6Atcaph
         EloNjJiPagSsi9/+OtyxvrIpZENeb9xKwAWE6EF5cD9FabsPMzoTh0taGBM0njXjunnx
         lAPwr4Hh/rgrCYPSkk/n5FHGA/Saion/yvNb+fOjm6cCLKRzRJj96YeUXmFI81oUOsiv
         DxN6xtF9dAzs8/XhwaPLpuTUcFchQvzIAQpb5zBZdPxRu1nvfVnyXXHSO/6cozGHRC55
         KbkKFbryrcfNc2nKq+hjlezZg4H0ajmgUH3wVnQU7rv06EiPGnJIxyHUpYHS26lPncbe
         4qNQ==
X-Gm-Message-State: AOAM5336tmgb/i6lAGxI3pQYjIbTel9HnBtNHTxUv8ZpTa3T6otUa7Zp
        fuOxhOdN8cwHkCJndbdjSI0r5/ve3JISIgeQO2531w==
X-Google-Smtp-Source: ABdhPJxkqlrn6yzg7NbUmuoSSw59iB5BMUcKKymhSB5iUtlMBmlGx95WG5qSV9ulBNfrf9ZTYivUPfVzYp5wgs2HNf0=
X-Received: by 2002:a05:6808:a1d:: with SMTP id n29mr11806544oij.164.1635125472740;
 Sun, 24 Oct 2021 18:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211013165616.19846-1-pbonzini@redhat.com> <20211013165616.19846-2-pbonzini@redhat.com>
In-Reply-To: <20211013165616.19846-2-pbonzini@redhat.com>
From:   Marc Orr <marcorr@google.com>
Date:   Sun, 24 Oct 2021 18:31:01 -0700
Message-ID: <CAA03e5F8qvkbnPNvDHjrnM1hLs2fu5L_Mxtuhi3T5Y7u+_ydrw@mail.gmail.com>
Subject: Re: [PATCH 1/8] KVM: SEV-ES: fix length of string I/O
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        fwilhelm@google.com, seanjc@google.com, oupton@google.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 9:56 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The size of the data in the scratch buffer is not divided by the size of
> each port I/O operation, so vcpu->arch.pio.count ends up being larger
> than it should be by a factor of size.
>
> Cc: stable@vger.kernel.org
> Fixes: 7ed9abfe8e9f ("KVM: SVM: Support string IO operations for an SEV-ES guest")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/sev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index c36b5fe4c27c..e672493b5d8d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2583,7 +2583,7 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
>                 return -EINVAL;
>
>         return kvm_sev_es_string_io(&svm->vcpu, size, port,
> -                                   svm->ghcb_sa, svm->ghcb_sa_len, in);
> +                                   svm->ghcb_sa, svm->ghcb_sa_len / size, in);
>  }
>
>  void sev_es_init_vmcb(struct vcpu_svm *svm)
> --
> 2.27.0
>
>

I could be missing something, but I'm pretty sure that this is wrong.
The GHCB spec says that `exit_info_2` is the `rep` count. Not the
string length.

For example, given a `rep outsw` instruction, with `ECX` set to `8`,
the rep count written into `SW_EXITINFO2` should be eight x86 words
(i.e., 16 bytes) and the IO size should be one x86 word (i.e., 2
bytes). In other words, the code was correct before this patch. This
patch is incorrectly dividing the rep count by the IO size, causing
the string IO to be truncated.
