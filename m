Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D03F60E9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhHXOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhHXOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:48:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:48:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i21so3649351ejd.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnPUVfUgYHSOqP3q+uA993Pwu7eBA1Aa+0lCfjRXQXc=;
        b=wvdmGiCMZOR/4dUX6jTk0PRzMkxcXwKO+u9ksozwcU3gZu4J6vrO1h3lhyVdbQ5zf2
         y6AZGFe2x3XJDft1AvQhWGewc1mXepvTnS6D1h4zMJm5o64B9NOGxg5VGhn+vQbDIkH3
         NCWU48hDd1JeV8fVtc9as5+f8hSr+OGBPHu08basolmrcnOyxVrd40vxBYHwmCA7NtIK
         SFi9e42xBS00Puy5lK8vRveNaIspZfdRiJ92ff9LUuBa9KZI/55adtF8KVoRu4oBMxsB
         ghDxErVWQWiClWpoEtx650mpFCQf0my+3zbNb+PWwV+M0mfWVj02yQl5JW/YWYapk4XV
         ruvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnPUVfUgYHSOqP3q+uA993Pwu7eBA1Aa+0lCfjRXQXc=;
        b=H9zrlMbpEJZGZFVlJ000oyNu1NmBfYoOnjsJQuHPCcrz1LfWOpRbcFzSBr/2DDiFEm
         QOHlR+ct5GuGx4cmPtpDEgqFy3zWU+o8M2NoH/7/0WC+xo9BxpROPSziRnODpoNslmnk
         Yru1FdZbBfEXVDnQjBj+Lj1jYa0CKnkBkdprtj3m1gTMAqsO3teMLJpGLR4c10yzeJdK
         bngBHGVZxYm3qwqmqbTIw8pWFf2zIhXFhqkpeCnAZOvkXj7XqaMpf7l12VshZHt4hmVL
         wUtxdDUdFbBun2Dz4NYOXVheDjAYi3bqrgOpcGr0SNdUfhdiTTE8AgFmZMaaTzqknPdZ
         X9uQ==
X-Gm-Message-State: AOAM530D6Z67oXOncqrD4cghmvf1wgxlpgKymaIQa3XFKqfKP5nYHLzl
        fzVSEdXCpV12uHGFHsIHqgojYbEM/kH9zxegFE6u
X-Google-Smtp-Source: ABdhPJxxDRaVp902LyjVDf+++7H1g3lySJYE9BZ6QHXVbA1LPabtUCfvWTFh7RVPbzZMkPo7LlN4qe4Aq61ZtmMifrk=
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr40640335ejd.488.1629816480152;
 Tue, 24 Aug 2021 07:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
In-Reply-To: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Aug 2021 10:47:49 -0400
Message-ID: <CAHC9VhR3E6=5HmRaWMWbp4WHsua02niwnzaRGM3tLqd4Y4LA6w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 9:36 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
>
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
>
> Convert powerpc to that bi-arch generic audit support.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Resending v2 with Audit people in Cc
>
> v2:
> - Missing 'git add' for arch/powerpc/include/asm/unistd32.h
> - Finalised commit description
> ---
>  arch/powerpc/Kconfig                |  5 +-
>  arch/powerpc/include/asm/unistd32.h |  7 +++
>  arch/powerpc/kernel/Makefile        |  3 --
>  arch/powerpc/kernel/audit.c         | 84 -----------------------------
>  arch/powerpc/kernel/compat_audit.c  | 44 ---------------
>  5 files changed, 8 insertions(+), 135 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/unistd32.h
>  delete mode 100644 arch/powerpc/kernel/audit.c
>  delete mode 100644 arch/powerpc/kernel/compat_audit.c

Can you explain, in detail please, the testing you have done to verify
this patch?

-- 
paul moore
www.paul-moore.com
