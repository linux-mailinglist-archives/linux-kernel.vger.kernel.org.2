Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3E388077
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351837AbhERTYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351817AbhERTY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:24:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6FC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:23:09 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j30so10121403ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXi9ZJTQ7L7FSHgEGdvSYj+oXb2IqANDPyavbrcuBn4=;
        b=E3AGjHlTYVk7+nTSuYrNsectzZCPRKmUEnWS96aPpztrVrJlWneXFE+XFLJ1VNLUfC
         aMfrnR7HCcW33p6XEaTVTZhd5cSLZL96EdwyIF/9tTmKrywDDNL46dzlUwl0mk5CsX7E
         DcErxGTiPwnpLdOTcZdFpOoMJ6M6o2QWdvSGZeW3qeSg6vUJYcCsGN3N+41wj/CS9V1Q
         JadECSjVTJli/NAxJz2H67r2Y39ygVHZSijyjghCz9DYFJ+QnhFNLq/teYKQMvFFmEWW
         WNK7ywVnwY3UuSao5HRkSQeU8VrQKG4CWf/hRzuuFWOWqEXlocJBdo4l1e6y2FWhB3A8
         KU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXi9ZJTQ7L7FSHgEGdvSYj+oXb2IqANDPyavbrcuBn4=;
        b=Wk4BjtAW+aCvJ+lujXfAC1EHWPnYAYBuQZNMT0a/MfgKAnp6WYiI+89USopKFwPNeY
         A1zHcgMv1Jf2I3FgtV3T7CnkhOtBD/ZwzkWesJwch4GRwn5Ld5sDWWkJa0z/QPAbWnRT
         O/r7tFeGMiyVdEUi/o25JdNj+Hb52JNVdSLwKhXKUjeBpHw0MzMtRwjfHULk43AspRnX
         pzYTfipZRHbfKpiIcluhSawGzzGemKSVSEjUhgqHAaADRQpi4AyxJoL5WKODMHwBBoqU
         eFdYYimkwAEhJiaTrpp8OsGJ5BlqgCxJo3pXqgzTBl7vcKw3qbii2A9y9Fp5LO+DJFrN
         Fk2g==
X-Gm-Message-State: AOAM532QY7g2FK+wDklvdlAe+h1toxEn38HI7QGdJlrLcPmiBTloXvV9
        5BKWv5XQXxLd3w1H60zh0dlXPMsq6OCbQeh8mbnjhiwMnRteefJU
X-Google-Smtp-Source: ABdhPJxDRkz/qvYqPjNf13OqweXH5naZq3dR8WAuBzqxGMF0MCERef4c4fo4ta4aVrcHwj4MgRizjmQVHKYs+LX1Opg=
X-Received: by 2002:a92:4446:: with SMTP id a6mr6088757ilm.9.1621365788410;
 Tue, 18 May 2021 12:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
In-Reply-To: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 18 May 2021 12:22:57 -0700
Message-ID: <CAA5qM4BWkSTwSz4PCcn4WOKFFjVaFuZ+Jz-EqTAGdVV_42Y0BA@mail.gmail.com>
Subject: Re: misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:32 AM Colin Ian King
<colin.king@canonical.com> wrote:
>
> Hi,
>
> Static analysis on linux-next with Coverity has detected an issue in
> drivers/misc/cardreader/alcor_pci.c in function
> alcor_pci_init_check_aspm  with the following commit:
>
> commit 3ce3e45cc333da707d4d6eb433574b990bcc26f5
> Author: Tong Zhang <ztong0001@gmail.com>
> Date:   Thu May 13 00:07:33 2021 -0400
>
>     misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
>
> The analysis is as follows:
>
> 135 static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
> 136 {
> 137        struct pci_dev *pci;
> 138        int where;
> 139        u32 val32;
> 140
> 141        priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv,
> priv->pdev);
> 142        /*
> 143         * A device might be attached to root complex directly and
> 144         * priv->parent_pdev will be NULL. In this case we don't
> check its
> 145         * capability and disable ASPM completely.
> 146         */
>
>    1. Condition !priv->parent_pdev, taking true branch.
>    2. var_compare_op: Comparing priv->parent_pdev to null implies that
> priv->parent_pdev might be null.
>
> 147        if (!priv->parent_pdev)
>
>    Dereference after null check (FORWARD_NULL)
>    3. var_deref_model: Passing null pointer priv->parent_pdev to
> alcor_pci_find_cap_offset, which dereferences it.
>
> 148                priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
> 149
> priv->parent_pdev);
>
> When !priv->parent_pdev is true, then priv->parent_pdev is NULL and
> hence the call to alcor_pci_find_cap_offset() is dereferencing a null
> pointer in the priv->parent_pdev argument.
>
> I suspect the logic in the if statement is inverted, the ! should be
> removed. This seems too trivial to be wrong. Maybe I'm missing something
> deeper.

Hi Colin,
Thanks for pointing that out.
You are right. I made a terrible mistake here while refactoring the patch. :'(
I think I need to get away from this thing for a while and have some rest.
- Tong


>
> Colin
>
