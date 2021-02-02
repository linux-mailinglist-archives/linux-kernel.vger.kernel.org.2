Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0494830B604
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhBBDpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhBBDos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:44:48 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB43C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 19:44:08 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id w20so11830655qta.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBhoyGWjkRsTCiTBILJWwj9Boa8VrzqKZ3SeTMdXre0=;
        b=ACGMOTA/8OZpInV0ItquQboxn9LAVxz6UJHSJIvcpOgRc/coMLx1GWsFQkrf+YlpPx
         qKl0peVuqCoKZgOsgH/lkY1YWvXBTQDZtsKsqa3pN56ktuWc8bCxVdtMcZ9DijXcnn8a
         HzvQ9PHH/ByPWra9+J1ObXTxEW87yRqD7/uoATM0MQlwnFIu5P6nXXjs3aGBKlOxpvzn
         ET30ue827ygRTsQUXCDmxz7gN7qMreMEcNECfW4FWSPyLETOQ3+iHGqPxP9CBy1aA7Sd
         wGrGB4VCEqQhJ97i4Un/bZQHCrDOZc6cEBI5X7V8zlJxZagNUFoyPVBQhLNc4Lj0hAe5
         aahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBhoyGWjkRsTCiTBILJWwj9Boa8VrzqKZ3SeTMdXre0=;
        b=Tvls71URiPkgZ9/xWB6wmSAn40kmwIJrVKKjLmnv40dyWfhOsdM+S4RsXhAJmO9Grw
         L5jxHM7HmJ0B/ePFs18099S7dHu90fcBg11xXmN6QKI/tUi4baFl8e8LZZeRvhaf2fB2
         am+C2z3iQCxpmT7shc3Y8ytB9DHyy6od6fwjf4lDIbFr3qX9qQW6qPsbkGcbqiEI8PT7
         n4DvVI3eie98Mn075SoodFRHXNhZRjEPIB7mxHa3kuFDIfwdaTKCxOVyChZRlsrTiZgJ
         VOZ4W94CZCaKh2XjzSJIv1GnM+zRhgY9pzaiJbt5SDYIzh8oF4+F/dR3IW55w8IMpykK
         NQaQ==
X-Gm-Message-State: AOAM531l6ixC295xpgTZFcYVmeuTgn2u4JNxjQA4LYqfwlIY8/lkWQrR
        4G9q5iatCf2KkjqrDgaNyvucyihC0aidZyu9jeQ=
X-Google-Smtp-Source: ABdhPJxzk7x152gj1ZR/fWJAgd6iIGwx/YPu/xELj1cCgD8ICJ9wFnTTN6i8d/IlUIhSBV9Uxps4qvOpKumMUMMgurM=
X-Received: by 2002:ac8:554d:: with SMTP id o13mr18240722qtr.55.1612237447824;
 Mon, 01 Feb 2021 19:44:07 -0800 (PST)
MIME-Version: 1.0
References: <1612236096-91154-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1612236096-91154-1-git-send-email-yang.lee@linux.alibaba.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 2 Feb 2021 14:43:57 +1100
Message-ID: <CAOSf1CHrTda_mezUCspges_yTbrhJPLekb1uibA7qFWxbBG_3Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/eeh: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 2:21 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./arch/powerpc/kernel/eeh.c:782:2-3: Unneeded semicolon

Doesn't appear to be a load-bearing semicolon. It's hard to tell with EEH.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/kernel/eeh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 813713c..02c058d 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -779,7 +779,7 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
>         default:
>                 eeh_pe_state_clear(pe, EEH_PE_ISOLATED | EEH_PE_CFG_BLOCKED, true);
>                 return -EINVAL;
> -       };
> +       }
>
>         return 0;
>  }
> --
> 1.8.3.1
>
