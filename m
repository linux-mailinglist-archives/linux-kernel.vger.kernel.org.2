Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43123D6D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhG0EoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbhG0EoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:44:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F8C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:44:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so14331309plh.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDWjDEqi47ElGh7C2oNgk2vsctUysNVRiZueqRzrN1E=;
        b=UHaoDeiHmVbqUuuK2tOuOy6bmjyToLI85HN61nQb2tVZNkd2tjyZnAE0C8ix1OEXHE
         XstQvUClJfmO+QPimqaKYZmvSDcqvIA67u/9Gaj1qIRPHBetk6es9VJuqhZKINhHKAK5
         sctWUmJu06jbfbPNf6YIOTKfznU19MKvKjqiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDWjDEqi47ElGh7C2oNgk2vsctUysNVRiZueqRzrN1E=;
        b=edevCQlLKb3UyfFVTxcpWavFQ4xhn/7uZB9gqnf5I4ScwDP9NZiAUA/60VL7XttasI
         0ds7BU6FMjx1KAMFyicnLc35/ZGfw0Z/nk6I1nbxcXkuUIvSh8EhLgRG6Vzhb5G3f/bW
         2dwp1npyl6014vhATBRlRc0hZz93RXg4n/DSgigGAcfZsmrOHQM7EhZHnYtuhP+Vb6ZY
         UDreX8CFknE9QymnGFKRBi3/mRhApNgYAYE6UBVwBzwVN6R7CjV5kEgJqERu4vNRSift
         JzCJCUbewTXSCBUoy/um0JKjD7lXsCHfTD3nR6y6szDynTWQKMcC2A6O4I7Nna/yrThN
         lgVQ==
X-Gm-Message-State: AOAM5332N8Xl7F+JTV6k3+MNPAaMxH15PA1BzfTeHW2tcFFjIlju/qjb
        fK8QvcFUMLyLmcBCp1LmfcYfnDUpqcnXHxEKFPcwjw==
X-Google-Smtp-Source: ABdhPJzE5fzikckD6W8BCnYoANGcUYqKRBGEc0+o7U0HuCkBAe7GdNeibY0DL5CaQN96ISl+gJhLzrJ2WX9YBmoTOiU=
X-Received: by 2002:a63:3601:: with SMTP id d1mr21373016pga.299.1627361040343;
 Mon, 26 Jul 2021 21:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-16-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-16-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:43:49 +0800
Message-ID: <CAATdQgDzh6yME2pDsLuHHMuKA8bfjwHMD5z9yd-VGcdDtBZEPQ@mail.gmail.com>
Subject: Re: [v14 15/21] clk: mediatek: Add MT8192 mdpsys clock support
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

On Mon, Jul 26, 2021 at 7:11 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 mdpsys clock provider
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
