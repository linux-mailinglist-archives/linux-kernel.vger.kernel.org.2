Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036AB35B87A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhDLCVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 22:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbhDLCV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:21:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B343C061574;
        Sun, 11 Apr 2021 19:21:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id m16so8220940qtx.9;
        Sun, 11 Apr 2021 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUa0+v7ZAmpSxoFCTfkyDehsOXQpvArXtqZL4rhnDLo=;
        b=PPyysoNW5WX9vhBEw5cG4Yo28z+2nzR60QmqN40agf6AO/FdWOGhnlcDFNslEOORCe
         hkMrPDMSiGmbVryxNnlfLJldTkhZ9uTQDJHxSqONQiaX7fMzmtYU8wHNOwRIqBeP9JOb
         36rWTawpZzthJkMUq2Gf4q6s2gs4evnoJRpSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUa0+v7ZAmpSxoFCTfkyDehsOXQpvArXtqZL4rhnDLo=;
        b=gCkcsnB5yOGkW9+AuPk35GB6fTVS2QEaD2F8G/ViMlT+ICR/uNIrJOLBgC08vnGqng
         /VnGiuI5CeiZrt4NNh3hgxPTkpFgsYNhEqpmyOrwLflEse/29ap8nBSclBr9CwLYZ0+U
         DKJNfG7qAsP+FIxfjmO+dcgFhPQx74KhGX++IOmyLeI4xUG+mWORB6/U1BmQ6TkDp6Ba
         nm105VsDi433bdVEcNW/1518tMw1wgwDuK+2CSexySgvxouIFFOlEdwtFxzuKzlQ6729
         +Hz3G2e2fJ4kQDZCIHPSVIX3mQgViZDOCAovO71W8TqAs1gM2od6rouIpJf7C9wslJ8X
         i0Nw==
X-Gm-Message-State: AOAM530Bd39Sbi3J34twVZAsgSocAc4IYeGaDxkoD4+KrEhFyIVdB7w5
        1OcI4Z9qxWqPub6uLJsEpHZbkht3xEr4uBZgIMovJZE/
X-Google-Smtp-Source: ABdhPJwgShwjSPbZOaMDW2xVE5vVojGnL4E4qEoi1et+sCot/oBxZVRZg4cjukyg1q+Ub//cpLDgSH2uUEXf22RIBOU=
X-Received: by 2002:ac8:4d1b:: with SMTP id w27mr18336343qtv.363.1618194071540;
 Sun, 11 Apr 2021 19:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210401044232.9637-1-zev@bewilderbeest.net> <84202973-1a94-4630-beeb-f33d044a0364@www.fastmail.com>
In-Reply-To: <84202973-1a94-4630-beeb-f33d044a0364@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 12 Apr 2021 02:20:59 +0000
Message-ID: <CACPK8XcfuEyqGmO72taXFPARxwzLyct5__0C0CF-nyEf6Yubnw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 at 02:16, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Thu, 1 Apr 2021, at 15:12, Zev Weiss wrote:

> > +&vuart {
> > +     status = "okay";
> > +     aspeed,sirq-active-high;
>
> This should probably go away, but otherwise,

Zev, this has already been merged (both to mainline for v5.13 and in
openbmc), so any fixups need to come as patches on top of the existing
code.

Cheers,

Joel
