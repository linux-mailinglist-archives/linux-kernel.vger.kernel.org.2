Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8383807CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhENK56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhENK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:57:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C454C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:56:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j75so28057544oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydhimE0ShUzHe5UlupIsgatmNxglV8e9FXvQTc9zlwI=;
        b=A1kyzqpGDjlbsvSYO4qFEgdZfzizIa7TOArkgaJ9dmcbJFbpOhq8LbFMdxVOfuXTrH
         AGD/ogrQ96G/xMSy1T0/vHzdIaLb9BJkMk19EdJaB/7ZMtfKnuaDsFLFMqbo+SLULqJd
         9WRsPVAVjb7elDv9eFCVFoGmtRVrifKCuNB8zzTIxelDeeNoPdjrPL1Fycz8N+SfhOce
         yzrzIeL4Lx9fscJpWygEi67OxbKLPe7+9zg1/jJKmTRBUPNeVfIjJNTDi0rIztM1zFCM
         3ldukGspD2l3fgVWZfhcSiIOTq/AdWDKkcdCAENeCDrp72DNp20Nyfcp1DNXZWKvEHoV
         L8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydhimE0ShUzHe5UlupIsgatmNxglV8e9FXvQTc9zlwI=;
        b=OX9N1sGQDQQG2Oq4xYEuPWB3IP8tcVzui83CAdarEBU35p2SxwToWvwg9lMNF5ucoB
         WMat7h3K38zwzcjcC1xL+AslJ3nzRHhP/HCNlg1Vcuk+zyMDTr6bftM2rCT4Ounm+eKI
         yKUWZmpfd/R0Gd5srhQZJrrnzV0g1Tj0o3pUTivFwn5AG9/OXQNNJa7cl/CxnelXVhYh
         qmESciO4U3fa0RhwyALlOj7e31ckjp7poQtz7kF2JzwNe2fABXmZ3N++iNDtUCEVDlhU
         77Pik7nA3xqPvzif917Gl9m2JAe2decdXgjyr9HGMZTWjh9XUop0Pmmz+ZQFEy2O83bD
         Uq2g==
X-Gm-Message-State: AOAM530wz8LqInSfsMdsN6SyBF45RXoP3Sp5cWy40v6VF0vq7SdJYg0u
        rujXeWk/l0nxWKa7hu1RyRPTGgADmLab8lRu4CgYjg==
X-Google-Smtp-Source: ABdhPJxYrgbpkEBXwUwLeoNOTFSevaanrWIytPfAWm7hboSHAWsk8jD59cOnRsC/L0RyJZ7SSauCSktF7CIJQHmTyvI=
X-Received: by 2002:aca:408a:: with SMTP id n132mr34058523oia.70.1620989801557;
 Fri, 14 May 2021 03:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210514092139.3225509-1-svens@linux.ibm.com>
In-Reply-To: <20210514092139.3225509-1-svens@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 May 2021 12:56:30 +0200
Message-ID: <CANpmjNMViC4thxCESfmj8j1ZWvNsz2oPSraPta3BAUQjFBoDtw@mail.gmail.com>
Subject: Re: [RFC] minor kfence patches
To:     Sven Schnelle <svens@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 at 11:21, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> i'm currently looking into adding support for KFENCE to the s390
> architecture. So far everything is straightforward, and i get the
> kfence testsuite to pass, which is good! :)

Nice to see KFENCE being added to more architectures.

> One minor thing i encountered is that for a translation exception,
> s390 only reports the page address, but not the complete address. I
> worked around that by adding a function to kfence which allows to mask
> out certain bits during unit testing. I wonder whether that should be a
> weak function that can be implemented by architectures if required, some
> kconfig option, or some other way?

I've commented on the other patches.


Thanks,
-- Marco

> The other thing is that s390 (and some other architectures) has different
> address spaces for kernel and user space, so the decision whether an
> address belongs to user or kernel space cannot be made by just looking
> at the address. I added a small if (user_mode(regs)) check to
> kfence_handle_page_fault(). But this could of also be done in the
> architecture specific code.
>
> What do you think?
>
> Thanks,
> Sven
>
>
