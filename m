Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BBF3D6D81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhG0Eho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhG0Ehm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:37:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:37:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b6so16035886pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHCpjMG3bJheGspgPwPgXoTuuhMeCojN1Vcw1raYNbg=;
        b=XImY6I5BO9PSo6vX6AyLIflKwvN5weee2a4Oh4nHjX8SbZeTMAYJXg0QeK2FKOnAh2
         J7Iao0Pmh2ZE30+livAgtKfi6ljvex1FccPw3GWqwx2pJ3E6axqUC/LTf0Atarck2uor
         KuPkt8VrZlVVYG3ft4eCSuLwyqmxlEFIJFots=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHCpjMG3bJheGspgPwPgXoTuuhMeCojN1Vcw1raYNbg=;
        b=MpYbI1Ggq60raoBL84XpTBr3QyU6ua9lwEmtNtxVWbHbAEQ5BB1r6c9Ix8TC/EkvtB
         3H8HC45wCZDzaQ6PMnQglt+0mAVRTB3v6YhMTse/566L79RmWJz+BfwWGz2gPlX5c0CZ
         95WW2fH5WC0DXKywFGiYcdwbZLcMz0Evq1fOfHR4iBMJGonBwvi1nazB7+lAIOijH/ip
         DVTepyOD8m3XaSj4t2D5LfZBIabOfMg/QXy10AD8Ai3FZCwgrjW9WMGpXW+7RqziUFIG
         +ZQkUOhCXoFYlAjDhGwSzTMvtVnkEWTl/K78rMYNJWITEqUZOYWaQTiTnlJQocrbb5mZ
         6dkg==
X-Gm-Message-State: AOAM530BY/i4NuYKfm8jI431VJ4ecPvIj6Er5YqBrvp0ADcCjMcD2+bN
        2n2S11+m5BOGxq3Zt6Fd9jsQ9FItcspLx/jdb23P5A==
X-Google-Smtp-Source: ABdhPJxoMQnZyC8tW7HpIKMFF7+41G/TLa4K7yYK4o+MYvmtPlRKMcIhTLK2m30euPRcf43I2fDHvUwmfzLx9pB6wjg=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr2289387pjn.112.1627360662060;
 Mon, 26 Jul 2021 21:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-6-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-6-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:37:31 +0800
Message-ID: <CAATdQgBdSqotJ_ZWSGzq7SbK-=qzwc+ptQidNgXFjR2C2VcPgQ@mail.gmail.com>
Subject: Re: [v14 05/21] clk: mediatek: Get regmap without syscon compatible check
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

On Mon, Jul 26, 2021 at 6:59 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Not all clock providers need to be marked compatible with "syscon"
> for system configuration usage, so use device_node_to_regmap() to
> skip "syscon" check.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
