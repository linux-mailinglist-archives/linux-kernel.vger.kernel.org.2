Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D051F3E8BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhHKI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhHKI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:26:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6364EC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:25:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t9so3996739lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1pnCAwRASpn4fyPBkIzTBQEKpQcrtuBfGwIpH44ZSA=;
        b=qWzCe9dga955Cga5w7LhEv4Xk82pmQbdmUlVBdLOMkPX86nA8hsEPUdckpMeEV585/
         G/dHsMELydm5OjT26oiUny5UqrBwTXLpHaypWViqZiRfzgW9GyBz6wImoplFJnmPdjdk
         bNNETnaSu6mJlpsEDV1TY+nseYTNWxkdpkSG8R6Xj/sPBsX4+IWWcrcQ0eYfRbo034Hb
         9kqUs856OcyFHg57Tl4OIsE83+fin9YBLHRyuRn2mm/TCGPUX6bo4QZK8/PWJPQ1wiQK
         fZkbqvgtXKvYBnKcpuQKKBchXTBLHkVa8pIjfNXo4BQNKYHORgrE3Z5K2z7VX3kmUd/W
         TkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1pnCAwRASpn4fyPBkIzTBQEKpQcrtuBfGwIpH44ZSA=;
        b=lYK8zPCJFXX7aQ0s/bXNzyYIehKnuAYpYlUuYdRldfZF4glPDehl9cKL8vgobegmSh
         elqx3vs+6CBM+mwjdLZ3oD2y0nb7kVGf+dSOX5BGWhM2ndu+arITCU+2uz/tGyIKlndA
         eFFccqAV1ljDatChIu/Xho2ygY1Zu5l1aUGcNWh/hazDQztIcNd7EE3FevUjtFbCpm/f
         eO5YvwcHmqMr0vbpvFKHt73SKc1U4nLBlkcqUXUbNN9hoHOr6vnBh2RM70b/eg2geiRx
         1psOT1I0CZwwtx/9GlgX8RCJsS9+toHPYbQ15PWcCvlrHF3PrU0s2Gk0L9bsBu1kq1Li
         j+Sg==
X-Gm-Message-State: AOAM531Df1nap2gWn6oPZXATefGAxP9n1oXRlNoSkN2MW/Ekh1sC7cL+
        aoGPBYL7JeIY7D9MEqRqskZzeVXnZcahHEjtPajTHg==
X-Google-Smtp-Source: ABdhPJwzK1TTNyIYN73hVN5UaP15UGCZnTRveq/TFlaH8lMiEvIy1pw/7ZC1PP0URr0ybbS+xbh4JHIR63GJoVn1YpQ=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr24358039lff.465.1628670352818;
 Wed, 11 Aug 2021 01:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210717174836.14776-1-paul@crapouillou.net> <20210717174836.14776-3-paul@crapouillou.net>
In-Reply-To: <20210717174836.14776-3-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 10:25:42 +0200
Message-ID: <CACRpkdbMH5=r5wcxUrqL1DYPvERD6X+19699NwOrRT68tTU2oA@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: ingenic: Add .max_register in regmap_config
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 7:48 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Compute the max register from the GPIO chip offset and number of GPIO
> chips.
>
> This permits to read all registers from debugfs.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied!

Yours,
Linus Walleij
