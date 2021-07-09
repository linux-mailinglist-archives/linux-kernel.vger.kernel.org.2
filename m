Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05D3C1F72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 08:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGIGma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 02:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhGIGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 02:42:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7AC0613E5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 23:39:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c28so20684685lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdbwvfH2damctRl688URppCcO8HiCSnYmA4puvxValM=;
        b=KARnKsI6wDXVlxoOJqqGBaT9Cvtu6meuaoim3L0lyRJTOtNHXTW15+lu+fX2Avc4SE
         sclUFBx2eXDhb5Ek6QXiwTQZFR7u0/lkRPCyWJj7CZ75DdaQuqELDVVUi+O3wDDsq6XB
         xaCqqW3u5S+0Z+S72yZYXwfyQ8NqtI/64qcv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdbwvfH2damctRl688URppCcO8HiCSnYmA4puvxValM=;
        b=BtMiOA5BQWfxXCcL5bu5XwAYMnXPxkUdQl2IKPGvh18UjlsOcW0KPCyLq5QLvS4xBY
         gvLgXji1H6osCeKgGlrTF7g4xYEyh+8s/EqbkAaMcIl8rj04jaFTzIdU7gLmVq8yET7F
         jE3wErqrS1nu/rcFklWlSOHfwXi9su5nD8wZbfaENShtYKSpvSFHxMrCiAd+tfSv+wSt
         1TrvnMF6Tj8aH4GHwFPTz3Y05S6RvURfPAwSyF690v+2ndrYyMeKoqusLRFp+KXjgh0b
         XyA+e4Vxdf8cIUic5GKNfH0PsmQ9WMSlCpwbANTFXkOq8Ju/+34He72mrIa9Xh6tf0kQ
         5O7w==
X-Gm-Message-State: AOAM533eAQRjaQJuEEfX3ivU6/mIJi4ILz3Ykby4gdx1QzG6cjo5lhsn
        ciEPJ0m2jnZPeN4/T8qlhX+JMeqt29o5DQbrVog+1g==
X-Google-Smtp-Source: ABdhPJyxfIq66PAyhcwZKY98vY9gxJePWfUzcQTs7lPlWbqVj656LIF99F/PEycna45aCaK+KtkLo7qALswN1VrtyeQ=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr27080916lfg.647.1625812785287;
 Thu, 08 Jul 2021 23:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-13-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-13-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jul 2021 14:39:34 +0800
Message-ID: <CAGXv+5Ggv1ouJfGwfk8XbTZ1c61-QU-=M1pA=VB4oJqWwE2r3A@mail.gmail.com>
Subject: Re: [PATCH 12/22] clk: mediatek: Add MT8195 scp adsp clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 6:59 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 scp adsp clock provider
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Same comments about commit log and Kconfig option applies.

Code looks good otherwise. Note that the datasheet I have does not include
the registers used in this driver, so I cannot confirm them.


ChenYu
