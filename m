Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947C03D6D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhG0Ek6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhG0Ekt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:40:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E9C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:40:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so3156055pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZkLU5+I68BDSpPUBxl1D1RwJQIxuQUsCqbOXE0ZiPA=;
        b=dONWso6Xo2S65eXHJ3a6MOLOGmiJLOocwrJ8F9zzqt+sh1tr4IOowdeANx5B4QRv3J
         uW9rYNyF6I/HJg2TCbpnsogvvQv4aU2gaJTuRnjia9nr6Tzgrs47MsnPWdGxZjgIomNu
         /WRyPRS2yydvYLgsviGGRJSGKoHvDQ6AEdV9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZkLU5+I68BDSpPUBxl1D1RwJQIxuQUsCqbOXE0ZiPA=;
        b=VikzVjgauV7LHgiM7pWrx3G/HCYpEVUGC1XzrGipEgE4YRFIsWO8qArqcb4u8h+Lnn
         TNrv7Njb0f4AfIABwCPW9iaOAbDIyrjRcWDSYMdTgrey6KuyhI6ru/N0dH+nwhhRWe8w
         zJLBsa64cnKszC7nL16p2u5/cHzHDmp6FKIDPwm+HukiJB4VgDnd4ou/L8CRJUSnFz3C
         DE1504CSxmFz9IRMYoYAqjDm1rsNR5dsmgU9qTAZJu3kchxmV7nwjPbgW6fNKKlsZBRa
         3OgrdIBd6KDg19lt36RTXOWlcf16LZ9eve+yjmp+U6ibENJ1mgJxnkL09c0Emel3o9vP
         plHg==
X-Gm-Message-State: AOAM530/0Xd8rlgb+lywriqc33nxWCNbISIXjFmd4ITEvWkxvP8oPxQg
        UNsjQSspE4dnUjgWJyOiD/9ebzApNmpAOGsEwSCV+g==
X-Google-Smtp-Source: ABdhPJwsbl6R45nDXufrB/990yLoLfbG3vMw+gUt78UIcaNlMR4EJGIo1SDOVr+Sotax4A15ROr6FzxBbyl2wFCd0WM=
X-Received: by 2002:aa7:8387:0:b029:395:a683:a0e6 with SMTP id
 u7-20020aa783870000b0290395a683a0e6mr10051268pfm.12.1627360848905; Mon, 26
 Jul 2021 21:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-11-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-11-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:40:37 +0800
Message-ID: <CAATdQgD63DTWWq1chx4n3sMEc_Y4ghnx4z6gOa=feFkBGsy4uw@mail.gmail.com>
Subject: Re: [v14 10/21] clk: mediatek: Add MT8192 audio clock support
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 7:00 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 audio clock provider
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
