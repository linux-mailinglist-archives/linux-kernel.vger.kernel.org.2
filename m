Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0534332802A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhCAN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhCAN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:59:52 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D72C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 05:59:11 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id r25so18509792ljk.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcR/dzHVgKkCRGIsBLxsPv1g4tIUIXKwFlYY1CUcxQw=;
        b=mcd+5Ms0K5O8lJfp+Hg3iiZK5GFnAcw5smpc5fYLfIDm2zwAkiBkL9cqO6YvU+Aaj9
         knpvZIeLv0NImoj/9CH6n7VLCasnSF7P6PiA2+OPqoGicmxFpv96j4WwVpG5r6V8erqi
         NDNBjlPg1TAG8NLVBP6F41NcwCH/HiW/88sWLxF/1mKWmQSH337Z5QDul2fQ1AvAGzow
         j1YRFNWiehgRJvlzc/03LGn3wL3smM5UTuMN/TiU6BA23c7L3yD3D7fRT2O7XHfibsSw
         jYFmq749oEuVU34DmDpez0xplb9IRHwVaSI3N2QvWz3Zjjmx5ERO8fCzrHGhn8rN7ICw
         HGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcR/dzHVgKkCRGIsBLxsPv1g4tIUIXKwFlYY1CUcxQw=;
        b=dxbaNz25CShDY+HtEG57IYOKWRgbJggtuSHYfIaRl/mbhccuoxLhiVjxr9GkubarHh
         RkWzXvbzwMX5t/ErgqT4UuC1E81z1oNn11uxgV47Hl4gRKbTu8hfewQvtDajwjJMU9XS
         c+ksgFzx2XcJeOTFKuiBKgwHWZ5MoOtU5TJF2wGlOtNvJke8puAoqJuxRCXKu9hIsrDJ
         VlTKfhodIuH1ma5aeV9r5RNkGFIxxdA8swGI3gi1/hKayvj9NXOQG5JGBUKXVYsFmY3e
         UxgZn5J7W6Bw7BPPTAP4gvE0WKEzBV/J1t41iQFLwYol9aIbEW1ZO+xqiE5cZhhIEy0B
         Nyow==
X-Gm-Message-State: AOAM532wwMTeZxv6BQ4V4k87K74KQy0G91oEOZmTPL98T1hNG+dKTf9e
        AYr0npxg7KwgE+WocxV/E3eV9rP4KdTX8yDSk4CqV8rgV+8=
X-Google-Smtp-Source: ABdhPJzJxMEWzzKTbRFbxSW4JSBPEDQHkV4eW75ZmlMLtfAi4mE1xdnnyaCGl/I5JiWt40FY5leZnjHaCzDmvkU5m4E=
X-Received: by 2002:a2e:9754:: with SMTP id f20mr7052483ljj.200.1614607150550;
 Mon, 01 Mar 2021 05:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20210228170823.1488-1-dqfext@gmail.com>
In-Reply-To: <20210228170823.1488-1-dqfext@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Mar 2021 14:58:59 +0100
Message-ID: <CACRpkdYpO6xXkswSO_wRLJNeeO6LZtT_W+KN-ECRyCc+ybU7VA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: tag_rtl4_a: fix egress tags
To:     DENG Qingfang <dqfext@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 6:08 PM DENG Qingfang <dqfext@gmail.com> wrote:

> Commit 86dd9868b878 has several issues, but was accepted too soon
> before anyone could take a look.
>
> - Double free. dsa_slave_xmit() will free the skb if the xmit function
>   returns NULL, but the skb is already freed by eth_skb_pad(). Use
>   __skb_put_padto() to avoid that.
> - Unnecessary allocation. It has been done by DSA core since commit
>   a3b0b6479700.
> - A u16 pointer points to skb data. It should be __be16 for network
>   byte order.
> - Typo in comments. "numer" -> "number".
>
> Fixes: 86dd9868b878 ("net: dsa: tag_rtl4_a: Support also egress tags")
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>

Ooops I send patches before properly going through the mailbox.
Oh well things like that happen.

David: ignore my patches to the same tagger and apply this instead!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
