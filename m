Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EB13D6DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhG0ErY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhG0ErY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:47:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:47:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i10so11290550pla.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZrbt9yR8hbrQ8uYyC/1sSAYUKzr6dRf2IBuVuefs44=;
        b=M9rmhyJs0OAWFelfhkQwSWB48PlkyYfaxXouNKWkCTVZK5xj1A5A07a2FTc+WX50vx
         X9FWYB5LhBrtwtqOkD3mwjzsfFTNcUAiTalq8AU305lAgHdmskc6dPLVGWnAkhwxIhya
         qTtn3xB6e/XzKGTGhf5NqtsbbnhSwHgbTd71k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZrbt9yR8hbrQ8uYyC/1sSAYUKzr6dRf2IBuVuefs44=;
        b=XPqY356nzwskR4JQiEaPo3cAKFQsJqDqRcB0ytol8+v3IZHXGyiztcWrnr8XAl9qch
         HRIJ+cBoGIWo3qASTX2ocL4DisR7FloyPC0AqU8H6CaXnsF+SY54uRuGSerksXXjD3aT
         B7Bkma3qe2kL4C7Ehe1vDvJ2PMEfr/5CiM5ngndysitwNpvo0hLLsajCeWlFLSC1vYJ3
         gog6gsVGDAU6s2ulJTzfdLz8o44IHA2VryDqqWkIYziIX43Z4UmEtLfHazeevgjaGmhT
         9ahYYgZnjc98YMkRCh+EdfTbhb8QjARGmtiPnbr0DLiask5fnupbCN6INgqnF5utuJqK
         swgQ==
X-Gm-Message-State: AOAM532rGEYZqfYRdcGwsoxnupj7VjFMFYRYMgWplDptXPa0iJ3O3Cx7
        qfq3ddonfA39JT6NLxb9jhlcas7zXIXoLN4N5J5+5A==
X-Google-Smtp-Source: ABdhPJyMrzz2w0ZyuzNoS3umV6X1k23qvdWBuG/YbXZPQ68RCfZGsiO8UslIzHyStg5/1car2IaVGcpVboN/TDltUzc=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr2318141pjn.112.1627361243434;
 Mon, 26 Jul 2021 21:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-21-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-21-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:47:12 +0800
Message-ID: <CAATdQgCzVffmJ=CQ0JqFQPjreySQNUsfNamjP05m8Jq+e5g=gQ@mail.gmail.com>
Subject: Re: [v14 20/21] clk: mediatek: Add MT8192 vdecsys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 7:11 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 vdecsys and vdecsys soc clock providers
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
