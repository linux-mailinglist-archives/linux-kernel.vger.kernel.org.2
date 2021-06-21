Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE43AE300
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFUGOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUGOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:14:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8EEC061756
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:11:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g22so654977iom.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSFuzN2SuxKq1n1SNZdRAp1aXuGH5Y42fh3AlSS90EA=;
        b=Sij76q+uTpQ00KvQi7ls8l00DYif5m9lYQuvFuhYdRxR/t/ckl0T+V1q8fPxYN31N1
         dCxKKzW9tyE0Ju//9FlNWgqt4TntnUnlj4qiadt59aMDuDd+qzkFxb2X1nh+AIDNuc1O
         Czq3FPkq5JKyZu9ERdK3CMF7MJMjxmPzjIGBoa3jSuvcTMa2NToJZ5ZENdTJiTE0i0xk
         1hmwfXiNch9Dr5ln0D66nO/YHx/tvBVTorhOn+vIeHU696yh76czqX80s2Jn8NSvLaeb
         NBvom2keZFysmHucYoDBdtVgbx9757nlAKN4ehkpSNBUPPs7OXy3/Sit/twj93KcSjxr
         S3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSFuzN2SuxKq1n1SNZdRAp1aXuGH5Y42fh3AlSS90EA=;
        b=WRf0wSjPaVH54tCEefyzcOiwIuK4+TqH+z0hXiGYd3rIyqhEPOfRmpPesw009yySPJ
         bmTF7eL/YOyL+sLIlM2fyeMo1Aspt6Xba8/RntHNr+oWWvop6w2mAOVG3KWS6aFE4Pdy
         BatuaOWJ07E8G09ouiHEl1buetXjJ7yLO802wSx0GeSXRtuTb6E9Iu5Rko5AiN4qbkrP
         OSon3lp3q6jyBryA4ezWQOBw7I5HHE9eLOdh+qMyTnbBFZroxqANPl+yveTQTjHojZF1
         arWBsbxAnQaQfKv5oIMM97W8bays/MOkwHU1Tdettd/jgJOYAMi8oeBud8F3ZIjXM2gF
         pNjQ==
X-Gm-Message-State: AOAM531P2NvSCXLgCQWbDYTP7wESMaVE945En4cSHK3PQq7lcwnhZ+4L
        p0FLG1+/kEJ1yquxC2ZZGCLIR+edQbN5smVL54sf3g==
X-Google-Smtp-Source: ABdhPJxIwxj31k43j8vYelOlq5U39zPdCtBSaGPst4/RHOpXkrqfSUGGIVE4TyFa8wYehSZFxTcmlKG3sLqNMO6wYCo=
X-Received: by 2002:a05:6638:109:: with SMTP id x9mr10662455jao.85.1624255910052;
 Sun, 20 Jun 2021 23:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210620134954.15233-1-Christine.Zhu@mediatek.com> <20210620134954.15233-2-Christine.Zhu@mediatek.com>
In-Reply-To: <20210620134954.15233-2-Christine.Zhu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 21 Jun 2021 14:11:39 +0800
Message-ID: <CA+Px+wVx6hv4ZVFNw_ZodiMrDu30sQkT1Emsk_5MLaPcK_LmHQ@mail.gmail.com>
Subject: Re: [v1,1/3] dt-binding: mt8195: update mtk-wdt document
To:     Christine Zhu <christine.zhu@mediatek.com>
Cc:     linux@roeck-us.net, robh+dt@kernel.org, wim@linux-watchdog.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        seiya.wang@mediatek.com, linux-watchdog@vger.kernel.org,
        rex-bc.chen@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 9:50 PM Christine Zhu
<Christine.Zhu@mediatek.com> wrote:
> update mtk-wdt document for MT8195 platform
Please write complete sentences.

> Change-Id: Id18393e8deff2c3492e21c85e97a28e88bc9ca0f
Remove the unneeded tag.

The patch needs other proper prefixes.  For example, "dt-bindings:
mediatek: mt8195:".
