Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4A36F161
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhD2Uvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbhD2Uvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:51:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC442C06138B;
        Thu, 29 Apr 2021 13:50:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t4so18609541ejo.0;
        Thu, 29 Apr 2021 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uxYngYQxqk+PVDP3WJw3Xc00kGb4JNoTKGlf4NQlJc=;
        b=NjFf6rcAhMZJ3GP8Kb1G1y+aZenxrUqBwabfgT9kgHGhlUE35Z5svXqKB7D1HsLZdq
         4vNZ9y1RAcJ5oSk/jgxWokzecNIGV8ebSCUEZtF51B7VxgxodF273ui10iaT3aFhA12w
         1TPuOI4kc+JyLYRZ1CmWjuH6t+150V7CvpAkJbbpAWPx6VI+mUK+9zv+BzgyQ5hl6L7K
         o8hlMHPcZvR/APjvGsXVTr9dTOCUe+OKBeGt0WoxRHNro9aI+XgHNcJtGeBt5/RlFHtP
         EjASYbSMruZvLJtXIwSCe4AVMBavhyv2RG0l10u50udkJT+Td910zOzpPEsc5FDzxVjT
         3O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uxYngYQxqk+PVDP3WJw3Xc00kGb4JNoTKGlf4NQlJc=;
        b=qNO1hTchVEmTQWDrwmlJaLo9eofGPm519cRW7ZaGO50nq4fBMFUSGeAV6yAvZlFSIl
         SEtUpFftSPrxQQ+7b5nNllSDasjW7WNtXWi8qJaflAhfY4tE1fnuhr01d0XJu/+AUuKZ
         4DA8CydVwkKo9KwizGbzChDlN6GMn/qUBdmMQY1Pr+BWxDhTzLffQnVqBKkSu70VRpa5
         wdIWfqevQyAv5F8CniJNpXBKroKHu0xGMwcvdMrI7WrSw+hQC9LMB7aDX1mDFKmM1JK6
         2gwfPuGWY7Y0pkCill+mXoamCcbm4o9MwaTTxRu/MLsbFxX45MHHn7WswtoD7Hbi+65F
         h2XA==
X-Gm-Message-State: AOAM531VyvCON5bRJX9OZVCopFUAS/gikT+MZvJKcRJDCI5kZ+ahh12X
        8d7ryOKGXiiVEWT0RLh8TZJc+GSejSfD3kjwaDk=
X-Google-Smtp-Source: ABdhPJysjlV6wcuLfYd06FMw2pBaznePZVcE1hTvCj8elYYMmCQAATV5o2uqzLuxQYLtP0GSZtEYWBLOTySqdAlfFco=
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr454865ejy.216.1619729442540;
 Thu, 29 Apr 2021 13:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210429170404.3616111-1-narmstrong@baylibre.com> <20210429170404.3616111-3-narmstrong@baylibre.com>
In-Reply-To: <20210429170404.3616111-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Apr 2021 22:50:31 +0200
Message-ID: <CAFBinCBJvW2i2P98d_0d-ZJq2=Koh4vaQXUW=Sb94mEq_KWt2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: amlogic: add Banana PI M5 bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 7:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add bindings for the Banana PI M5 board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
