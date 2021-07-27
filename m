Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484DD3D6D95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhG0Emv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbhG0Ems (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:42:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBCFC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:42:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so3242292pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAG3r4q1eXvW4jnmIxPlqvAFPEHnfRa806/4BqgTPyc=;
        b=e7wngxPzpp0yJQOTn+ibbOBw2mwLX4Sys3bp7NiFrw+mlxjWp6RHpc7h/0VT+sGgJK
         Aeev4HodmIPg0iBkKNcOQFWj58CYndJ8oCY+gZn8C1RSygbYI6G8sm0+hnfTXoHe6259
         0I+UhsI0GlYWAUpmtZjsOGa7VRJio3Nb5CSfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAG3r4q1eXvW4jnmIxPlqvAFPEHnfRa806/4BqgTPyc=;
        b=k49SVTOC9awPFEd2yVV7Gj0dXDHioGoYETwjKB/A4cYReC7Ks9ttELtsd+Q69GDUV9
         5gHKW56JM/Yh05AOw/iD+KsPAg0PUq/MJzFkZKj31qjKjh+HxMKp1VRvk7oNg0XKRoMy
         RBg2tv/TOXXBC9lip61CyPvAg7koJspdUajMTyBeH6vTamAstbZNbOZWf8rxXFpgVak3
         /H3uSTPTmJ7emrifpxO+axkPcC8A18qmFJsAIv0QonHhBb6p8bSWUu/yLivQ+jyEpdpV
         lAc0cvx56w+g8u/zccRR9m6B/4sBXdz8wTjz8o8fJf5iCw0GTPtaq01k/SJECHMGO9n6
         msXw==
X-Gm-Message-State: AOAM53027HhK9Lkmvlny1SVQQlbeKz2m79qvbpvqlJ4/u3hacsliZF3i
        ivnyB0jRcMTrppUITZ8HobmMTNskJtaa4/qhpUFSKg==
X-Google-Smtp-Source: ABdhPJwdTmIIqDIkRt5Ak/lU9NfF+K5qaQxw4lncfdy5vGygLf6ht6RWYKwum/QaKt4mbq4xALxTpF8TnTjnoO5kRaQ=
X-Received: by 2002:a17:902:b788:b029:12c:2888:9589 with SMTP id
 e8-20020a170902b788b029012c28889589mr6389338pls.60.1627360968879; Mon, 26 Jul
 2021 21:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-14-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-14-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:42:38 +0800
Message-ID: <CAATdQgDuSuaP=10-WN5DpCEisJYMVjbGdSb81tFyGC5CXyBs2Q@mail.gmail.com>
Subject: Re: [v14 13/21] clk: mediatek: Add MT8192 imp i2c wrapper clock support
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

On Mon, Jul 26, 2021 at 7:08 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 imp i2c wrapper clock provider
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
