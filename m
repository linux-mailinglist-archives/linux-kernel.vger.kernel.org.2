Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980FA3AE72C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFUKcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:32:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3384BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:30:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q64so22732975qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeySwvB/L6nRcxyc3RUUU/XORVsjO8A0OuiLh/T9c9E=;
        b=e3fOXIsdHN8zBR5AjQWgc4RNrsDP1MXpB7+IkfN5wdlTVxLZn8JKTfXMYbfZeR95XK
         S5ft47Nf2INeLNoUgoXUSrOPeX5tsT0+kbat/e75YnxfQxJ1RdX4AXSxI6cdFb5M4H9w
         Z8KqflUOF+SZCWGRLTL5qW9AV3tfIVjYyAWdtT3bjFseHVHp+YjabZ3IZowO5tHiL6S6
         7yVu/h8HleEmpKORVXdljtApCwHoVXccETcuFSxuKdPQOgeZAXOgBkoqRWPQKEDZ2ZpS
         hu5il66gQ3oID3VF6R7aPQICa3fXo2PjZXXQy6GJ/l3JSDq60riUZxczsTnfs8ahPv1H
         +pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeySwvB/L6nRcxyc3RUUU/XORVsjO8A0OuiLh/T9c9E=;
        b=s0FGryh6o1ielhW35eKM0xR+qIbhuemFK0Pm4NOkIbdzukNv3CnKxOlAcgo1p5rxuG
         vVKpBKznzE7N+78AaSC1mItVATLtOTtBRtfAbLKRl5qHguhkPRgst5h45QqfvyqaFiM6
         PcSrrYos6bhxnsMalGbjFJqxLY2vhQkpXb1S/XBHxXEiJmHKcHGYuuVMeeGUviJKz/ra
         td4Le5efn/nRfgqDzQCqu9rbDOxKhYW+EgUz2NzDNvHwmaqX9TRfQv6Xgzscdo84QTMd
         uGYCHMLySCOfOvz8FMoNsfsv4nbNakxmUhMAkRAcRfrnw3wPWXTavEuckp29pgkF8vOJ
         J3ug==
X-Gm-Message-State: AOAM530uhfSQ3sD0ntVYODOC3SIjJzrDtM1uB0kq/0DuRKXXtCwfppay
        hVaQDYcKYeB10gHnIcJJe50rr94wsiFXRqgbScX68g==
X-Google-Smtp-Source: ABdhPJynErsP1ymVSnLK/htXoVZUp48gWLGb5+JZcWWEkfT3WPJcFvso38Auforwlu+DimLlQo3C8a8PDp40Kmu89do=
X-Received: by 2002:a25:738e:: with SMTP id o136mr8451107ybc.469.1624271439447;
 Mon, 21 Jun 2021 03:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210531120753.719381-1-iwamatsu@nigauri.org>
In-Reply-To: <20210531120753.719381-1-iwamatsu@nigauri.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 21 Jun 2021 12:30:28 +0200
Message-ID: <CAMpxmJUcscOAf2_VsOF0TbKT7KyAi6MdVkptF5+4_hmdEUG2pg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: zynq: convert bindings to YAML
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Soren Brinkmann <soren.brinkmann@xilinx.com>,
        Harini Katakam <harinik@xilinx.com>,
        Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 2:08 PM Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:
>
> Convert gpio for Xilinx Zynq SoC bindings documentation to YAML.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---

Applied, thanks!

Bart
