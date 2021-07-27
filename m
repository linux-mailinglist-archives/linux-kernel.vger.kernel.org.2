Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44D73D7D41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhG0SQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhG0SQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:16:27 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:16:25 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso2647ooi.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vco8IpmvI6e4OgtXcayTW8PQqRayAHHPZ/9BbWzucA4=;
        b=KN7/6VIjU3/F+4L3/EZyEx+FP90Tprwrv0m8vVXi0CnormS05ojsXWgodoDjclStRp
         v/rpN6F23Yvjn1GdoYiP+07pe7wyKSbASEi3wA4Yjn12db1j57L2AK/nB9edsXDJ0oph
         c2q6vRz4lc9woO8aP3+5WrZpsIHK5vJY5GbXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vco8IpmvI6e4OgtXcayTW8PQqRayAHHPZ/9BbWzucA4=;
        b=HlNaFnA3IwVP21S3wxTDz68+Hbx8TAnv5y3bsdq8dDE9nKqJP9jj9dr24wpCLERGBX
         U8aiaNb4uuaESeu1WNRa61lW51XeptpKfhkBeYOnA9Rh3E+PrLCynlohOBl61dcDZQm+
         y1qStWQMa5CbkzlW0Z1ffIj6sv35JVVlx/NQo/uoyshf9WGn3qv4HMw0bL63XiWJxZsf
         QCFZH98tcMlB1swP21peAyogIbN33OLl5DyS2xcbSiNMZbVOL8RKpeg4MqVqK/jWsva3
         jkkXYCAC5CUyHrobS0hS8R7cKJ8sUlBn8VBROR36EipK1CbJMqhdo9/RLJcGnuNsXgGL
         4o+A==
X-Gm-Message-State: AOAM531r6nrAmQlmRbBo1M+6ecAESO/035eTUvEeLZQSWRAx/AM6fuTK
        llRyDqJkhvP5clS6hoslYUCp01k9+nGstg==
X-Google-Smtp-Source: ABdhPJxKb97LqaKdN7pRZV+rqGf2ipxB3tFs+4c7/+zOoyr9d7cZP8ewst2s9rGeFQveWSQOjO8ugQ==
X-Received: by 2002:a4a:434d:: with SMTP id l13mr7850924ooj.83.1627409784887;
        Tue, 27 Jul 2021 11:16:24 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id m83sm677297oig.25.2021.07.27.11.16.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 11:16:23 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id a19so344027oiw.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:16:22 -0700 (PDT)
X-Received: by 2002:aca:304f:: with SMTP id w76mr3634238oiw.77.1627409782401;
 Tue, 27 Jul 2021 11:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210718084202.5118-1-len.baker@gmx.com> <87eebkgt8t.fsf@codeaurora.org>
In-Reply-To: <87eebkgt8t.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 27 Jul 2021 11:16:11 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNm_aKAJcJVCx45VqAXTgXjfOju7xZPa_3MAvBzn2r7_w@mail.gmail.com>
Message-ID: <CA+ASDXNm_aKAJcJVCx45VqAXTgXjfOju7xZPa_3MAvBzn2r7_w@mail.gmail.com>
Subject: Re: [PATCH v3] rtw88: Remove unnecessary check code
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:34 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Len Baker <len.baker@gmx.com> writes:
>
> > The rtw_pci_init_rx_ring function is only ever called with a fixed
> > constant or RTK_MAX_RX_DESC_NUM for the "len" argument. Since this
> > constant is defined as 512, the "if (len > TRX_BD_IDX_MASK)" check
> > can never happen (TRX_BD_IDX_MASK is defined as GENMASK(11, 0) or in
> > other words as 4095).
> >
> > So, remove this check.
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> Are everyone ok with this version?

I suppose? I'm not really sure where the line should be drawn on
excessive bounds checking, false warnings from otherwise quite useful
static analysis tools, etc., but I suppose it doesn't make much sense
to add additional excess bounds checks just to quiet Coverity.

It might be nice to include the true motivation in the patch
description though, which is: "this also quiets a false warning from
Coverity".

Anyway, feel free to pick one of these:

Shrug-by: Brian Norris <briannorris@chromium.org>

or

Reviewed-by: Brian Norris <briannorris@chromium.org>
