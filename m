Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27D39783B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhFAQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhFAQnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:43:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC20C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:41:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h7so1938897iok.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFdJLwGpsrdmtRMVFJwCpWbbYUiZW+5X2OTtnqGI350=;
        b=Ksshfw9D0nIiqzefly2nH/m05dE+m9QixE8iSa/rqAsFzFJAreD63MSm+D5bkXo8AT
         hGshfEPd7HbY0pvMLEWIyGirnKjH6dh5OUpcHyjaxpeIp2o+ZywytCVTpVsmoEcvoUq/
         YNSehu2v+3O0FxSsseZcaMxljRItt7hZPo1Co7BD6X3b9iAiPToiA9LIAHuK5yaksbvE
         8CbcoL55bwCW/AvCkPayNPkiAgUtfi0rpAHAtAfArsncJldmdZmKysZwEJOwsK6A8j7k
         GGgPAXNxbb/RgVskFqSvIRhE53LoFk1OeMMMTumdVBrH4/8EfH3LtTgy/QvBFEfvg1sm
         +bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFdJLwGpsrdmtRMVFJwCpWbbYUiZW+5X2OTtnqGI350=;
        b=bA9PZ1AuLwVGRbwpt4KQYjCtABNXfL/R3AmIKcOBz3Obe+/RJ0ENNXMp7g725CU8yf
         978kYc3FlV1Z+XYsah3TIjrVSgsamKC4N0p1bmh+FFfWBNjAZ6gVjno+yYAxc521LO2K
         9JUgoEf206aFJk7zbvklCATMikiQ/x+J+JiArNMYPpZ34ivFukCOpJyL4mJ5G2hOIrYp
         4tdtR0HBF/eS9qErQOc1HC3aGxTvZOHPhzyvFig/TA9ASfe7ar2VisvdbkvOChhFPHvd
         li6G1apPQivROtC1BFOH1GxvIKwElvna3L3GxwZvzhzDpj4xz++ZqibcQP1FazQ+xKsL
         A3wg==
X-Gm-Message-State: AOAM533S5/1RHaQ5fGZjblwS6d8E2nUHsezcdlN8JQuplUWInbORMzKh
        yHCSZTk00YKwb6ZxCbxtkKx2fMLPWzEv1ZZW4mqFpQ==
X-Google-Smtp-Source: ABdhPJwTDlLZCHXvyVIlZCZ3A4Fm6zebWM+TjFDLzGI0KZbh1ynBI9DPNZBY2RJb2CHT0P0DL7d+yV6HSae4JNRXAs8=
X-Received: by 2002:a02:b808:: with SMTP id o8mr991358jam.1.1622565699486;
 Tue, 01 Jun 2021 09:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210601143432.1002481-1-glebfm@altlinux.org>
In-Reply-To: <20210601143432.1002481-1-glebfm@altlinux.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 1 Jun 2021 09:41:03 -0700
Message-ID: <CAJHvVch713YnMA6KYPVret2p6yB_5+mfRJ_JbC2q2Afeh-KZbg@mail.gmail.com>
Subject: Re: [PATCH v2] userfaultfd: fix UFFDIO_CONTINUE ioctl request definition
To:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching this!

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Tue, Jun 1, 2021 at 7:34 AM Gleb Fotengauer-Malinovskiy
<glebfm@altlinux.org> wrote:
>
> This ioctl request reads from uffdio_continue structure which justifies
> _IOC_READ flag.
> See NOTEs in include/uapi/asm-generic/ioctl.h for more information.
>
> Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
>  include/uapi/linux/userfaultfd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> v2 fix commit message
>
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index bafbeb1a2624..650480f41f1d 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -80,8 +80,8 @@
>                                       struct uffdio_zeropage)
>  #define UFFDIO_WRITEPROTECT    _IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
>                                       struct uffdio_writeprotect)
> -#define UFFDIO_CONTINUE                _IOR(UFFDIO, _UFFDIO_CONTINUE,  \
> -                                    struct uffdio_continue)
> +#define UFFDIO_CONTINUE                _IOWR(UFFDIO, _UFFDIO_CONTINUE, \
> +                                     struct uffdio_continue)
>
>  /* read() structure */
>  struct uffd_msg {
> --
> glebfm
>
