Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67D39C971
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 17:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFEPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 11:20:46 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:40795 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 11:20:46 -0400
Received: by mail-lf1-f50.google.com with SMTP id w33so18577901lfu.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZnFe/YPkagTwcuo6+qZIKKsCGRjyloxniZLJsXubJw=;
        b=QchpKmlTMdYVfzB4+RCQf/u3zr/bhQ5zBYpwpBROhpQjG5sTgbJOyI/v8swbAF5Myl
         zuWsLsK1LdCr3gAYujwSbr77aQPYQYWfazK6qhC6Y/m1uzGa6WE/sRZ1zzDVW9bHaPQj
         QozKFmsjqd/jRWeEyXrday1ChQLvEJOxTGnkHkyzx8MehR0DP/1I8gS0K+m3GiR9SJaU
         x3XlXc629qCNu1MXKVVKQfVlKVu4kHH+nothQtgm2rCY8YQDwSAPTOwGYazkZLh5r3R2
         p1DfrIn6JQoGlWMxeKl/kTKLpw5arhJPY3CdKOMq+PIrgt0mUTknx98tA7BeAziN1o5A
         9k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZnFe/YPkagTwcuo6+qZIKKsCGRjyloxniZLJsXubJw=;
        b=q2pgncl6isK1kv18+5bpMxWRSor//F1kCxSUy14iyOgBXtJXXQD0rx9JbQYjxGjfyu
         b+2ie+BkjVCJh5z0lWRsst+RPo3Go7VpFZdRHdetU6KmFyWereJGMyBbKXQPeM2DRYbs
         z9PoWtco5llai9id8NGKbd3JhgapeaVNTaP+Mkb1GUsEv6RfwjIo18KF5DreljAGcfjx
         P+DyN3zlNuF3ulYM9eKHG1oyUNIbwPA70a62rHUvE9OzkKQU7WPbUcOMvh3wVGMc3U4z
         3SBmeWPDn4t/ZJ/IrIvm+tCuHLZpV+zt5bG5ZT4tOXQL2v3lZZZiwDtJVGx92MjHXk6i
         nFtw==
X-Gm-Message-State: AOAM532ZPfRMtiFXjFSCJBk6bJ7IshmPujB+Skhtt4AQJYKftUe6LFlw
        tlOwiM46vDpLm3RWdF5lSVEjkvfd3bc1f+llnklzMw==
X-Google-Smtp-Source: ABdhPJy2RU2ANSqGxvNcpJx5nyiCZ/gsiRuRmAEhi9SMJ1hnSjkVHHIGoaxD+IUsSAZ3phSXJRUMLKhwxkblqc4D8tE=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr6108972lfn.465.1622906264687;
 Sat, 05 Jun 2021 08:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210605123636.2485041-1-yangyingliang@huawei.com>
In-Reply-To: <20210605123636.2485041-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Jun 2021 17:17:33 +0200
Message-ID: <CACRpkdZi-W-vnCH05C4CkQdnYtUKuD4NWoBTh8hGXmok_=Dsfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: gemini: Use devm_platform_get_and_ioremap_resource()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 5, 2021 at 2:32 PM Yang Yingliang <yangyingliang@huawei.com> wrote:

> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
(...)
> -       dmares = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       gmacres = platform_get_resource(pdev, IORESOURCE_MEM, 1);

Should you not also delete the local variables
dmares and gmacres? I doubt they are used
after this.

Yours,
Linus Walleij
