Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52D5311AAD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhBFEGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhBFC7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:59:50 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F80AC061A27
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 18:52:16 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p19so2784143uad.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 18:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESjeBadsRkrAl+qIXzCFj686nO8RcbYAT55ppoG4TfI=;
        b=iyOTr5Y38WWt2U+DhmDSY+CBq4jfRgX8ILyD7YpxBzkeNUR+cxPUF9DY77zDG0zUYh
         DyNhMeCsWL+QjDtPPEWCOyYQJ4FylyTU8H84s00folBHvMWIKo9oX2jesaP/QL2lJ0rL
         aXve1wzBt16y3WeQthTKPQsrVGvCaOT4UPeEq/IAdrd9P1sqxr8LmTsTcyNl9Nq81g04
         OAd2RRJg93oImvbz2d+9QM8gehWtbZ/kO+ItK6g8jE3h2YMCN8jCJpQYkUSY210Wl85Y
         9EjT7pAimi5fyPPnHw+fMRJjaOpwrHMNJf16Egtyy+81UeFVzXnN5IkO+VuCNFbKrYme
         2fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESjeBadsRkrAl+qIXzCFj686nO8RcbYAT55ppoG4TfI=;
        b=VAJhuAd8Rjoyuwbu4PL85W0dVDFG9PFI/9n/oFNClCX0ffhF9d2ZNTAbAAlFV8REe0
         VIsRGfmYD5gHpNe3aHoEBMw/K0xHdQDSR8jhJqutpIELE9c2JjbK0zr5RSeYPo6feBBE
         SkxWSM5I2csbfqtAk+3qJ46WSxa/CQ1fBHQdRGoVMwmDaMJgKvegy3Am4h/WnMbE78wy
         CcAtQ0PXA3IQjpU6XN4pAoGz32fLBye/JcOSr5EXv74nfjaUEbJtvCnsYOzwJ6cUNdmZ
         dw6Ndq+Sr2ICQL+CUanCVeDvSHrVuNvIHjrcx17AmeantOojaV1Dg+ddz3xJP5sN32PA
         fQ8A==
X-Gm-Message-State: AOAM532rRD4T8pdZgWqnX12UTY9dqtyfWm0F/YNDRXid3gCmdw3hmRJP
        2RhAaMzdhenTe+YLBP7m2APNAvEalBY=
X-Google-Smtp-Source: ABdhPJzogM3serKmMghnQtVT+X4UHoIc7BBrlzs72ttJcps09N2N+imfMt2AjNNTZvLrK02TDMrfrw==
X-Received: by 2002:ab0:146d:: with SMTP id c42mr5119650uae.56.1612579934935;
        Fri, 05 Feb 2021 18:52:14 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id u18sm1292322vkb.26.2021.02.05.18.52.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 18:52:13 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id n63so1912499vkn.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 18:52:13 -0800 (PST)
X-Received: by 2002:a1f:ae81:: with SMTP id x123mr5333772vke.1.1612579932931;
 Fri, 05 Feb 2021 18:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20210205224124.21345-1-xie.he.0141@gmail.com>
In-Reply-To: <20210205224124.21345-1-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 5 Feb 2021 21:51:36 -0500
X-Gmail-Original-Message-ID: <CA+FuTScLTZqZhNU7bWEw4OMTQzcKV106iRLwA--La0uH+JrTtg@mail.gmail.com>
Message-ID: <CA+FuTScLTZqZhNU7bWEw4OMTQzcKV106iRLwA--La0uH+JrTtg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/packet: Improve the comment about LL header
 visibility criteria
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tanner Love <tannerlove@google.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 5:42 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> The "dev_has_header" function, recently added in
> commit d549699048b4 ("net/packet: fix packet receive on L3 devices
> without visible hard header"),
> is more accurate as criteria for determining whether a device exposes
> the LL header to upper layers, because in addition to dev->header_ops,
> it also checks for dev->header_ops->create.
>
> When transmitting an skb on a device, dev_hard_header can be called to
> generate an LL header. dev_hard_header will only generate a header if
> dev->header_ops->create is present.
>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Indeed, existence of dev->header_ops->create is the deciding factor. Thanks Xie.
