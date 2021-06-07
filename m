Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4850839D567
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFGGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:53:13 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:38440 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFGGxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:53:12 -0400
Received: by mail-lf1-f52.google.com with SMTP id r5so24523462lfr.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEtZdFOxi2WohaLJrH6hnLr6MFGZSRIDHi+R4JvrIcI=;
        b=W13HojxSWvO241Su+Gj2Zdl7yjy4mC/bUOJljN3tTGNc5NchSgpfwCUoKxSN0q7zL8
         wUvamevQLsxu5IoPY0kiozcMWxiAQqT6CmdLMIdR5GLbjIHNRd2J3MRK1r6i5IoODKoo
         n+l0tJKS8NMG2Xd8UlZHrfnG1FlIJBhPpZudimkO+YsmXcrHIDwJf3Je7t/UQPMQxDq5
         yyDs6zVMCX7D78sts/nVaifjODzU7AfTBfxy2tB8BzQGa+xdIJpda7QyNa25RLgpv6OD
         kC/qbxorMU+UvxpFZUsgwgFDFVgKW9lFWXirgKztBnGYxThuAcKk0jshW0lYc+LT0S8M
         UgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEtZdFOxi2WohaLJrH6hnLr6MFGZSRIDHi+R4JvrIcI=;
        b=roBMRRnX/2XGo25UGkccZikKyvKR+L9ZMhUWAl25FVWnrHeFOuluSTbxSyiSffaqOc
         iEvDADb4U4JtqqEaexv4AYpLKgY8fA0RTHnmslFNpAgF2S0WXtO7a4zdp0oTUtjmIbLw
         qRNj4qhi2fNlINdtUnhTKJUQGBtoxX1MTpMjXUEdYTG99a/HsxB9LBFYKo/J9mG2CB/a
         m5/frsibLdCjYXU3cOz9VTXtOWciYwEwUaGRdxNSLY7DqePOphhjhOtpQ2lwdZabND2z
         vuqlXwu66/kjGsbvfOyBSzYzK2kmw7lAkFSPpuVeUDM2t0kvOd8CO+rQKjIWt8PChowT
         aRSg==
X-Gm-Message-State: AOAM531tSygJxkM+E/o5UgsPgMmvDMRrP7malS6tIFjyRCN8LCG5yxsr
        2oGiQpgRTiGRfQc8ggRC2Wo9ZQeW8e3Rp+0LQBDIrw==
X-Google-Smtp-Source: ABdhPJxu0u67u8AL1sud+fd7Es11M7bae85Zz9n0rMoRUq2L4YQijpaghyC6ARdY0MlCXGAlBRt8yQjkHtHHBhhELFE=
X-Received: by 2002:a05:6512:3241:: with SMTP id c1mr11381576lfr.29.1623048609542;
 Sun, 06 Jun 2021 23:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210605123636.2485041-1-yangyingliang@huawei.com>
 <CACRpkdZi-W-vnCH05C4CkQdnYtUKuD4NWoBTh8hGXmok_=Dsfw@mail.gmail.com> <da671768-64b8-e658-20bb-c536df8c1aae@huawei.com>
In-Reply-To: <da671768-64b8-e658-20bb-c536df8c1aae@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jun 2021 08:49:58 +0200
Message-ID: <CACRpkdZ+sT=YMZbvYmArZB50CPObsKe3CiBW=KysVubPt1-+_A@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 3:05 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> On 2021/6/5 23:17, Linus Walleij wrote:
> > On Sat, Jun 5, 2021 at 2:32 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >
> >> Use devm_platform_get_and_ioremap_resource() to simplify
> >> code.
> >>
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > (...)
> >> -       dmares = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> -       gmacres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > Should you not also delete the local variables
> > dmares and gmacres? I doubt they are used
> > after this.
>
> They are used to print message before returning gemini_ethernet_port_probe()
> static int gemini_ethernet_port_probe(struct platform_device *pdev)

Yes and after this they will print something undefined since you never
assign them anything, so the dmares and gmacres prints need to be
removed too. (Which is fine.)

Yours,
Linus Walleij
