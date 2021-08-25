Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857173F73E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhHYLAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhHYLAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:00:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BE9C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:59:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i9so52038174lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OhtRqxuCWyLk1aLabWzxilmd8Ou8PbDbdnIDNsifyg=;
        b=UCe6OdgVEduJpDvUvnAB3x/x/zZNszEyU5ZHOrt4vlHiT818x2be4JzjZm1vnIunjQ
         r1CtUT20ws08Uh6T6/kTMmgQLJGl7oTjRiLcRK6Mf1qYkU30h/xSAMX1K9Bcvswq8lPI
         r6YRJ7p9V8s8NFEGw+nFTtgOeo8brw/PWIhKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OhtRqxuCWyLk1aLabWzxilmd8Ou8PbDbdnIDNsifyg=;
        b=eSzhFX+NcwamcXHAf6hm7XYRR+ydw7t/V9zxCeXFQkKO9YbnfFtyq28rePjRw9HcXT
         eV5J68aLPPpyY8AAVaARDP1MxNDRFEzka6gdf8Z/mObL/p21vHrlutRV0XTniap8ABey
         lEvSe59qjJtd5EnxX0FU58d+0gXX2f+3Y2VvXk+yOo7oDLIdo/Q9FEXjWezFV95tkPM6
         V8geDoCFgNGQ+CdQyA2S/q7+OvRs439eEf0Gq0iD3e5ZMXube9It/tgMB0kglG+OUKkd
         aavL0uqL5xpDQ4O40VlQtVES1ORNa+sqxRa8pzjN3Uct8EYg2AclnOBNkWQliqFqkfNx
         5vow==
X-Gm-Message-State: AOAM533rT617ZgJWxe4PR/N2kW3VVDxYqpOPuJCmXm9/Rgy6TyAIUMUE
        ZiCMMBG6fJ/QDvaff0mlYa9+am5pQYgrTncdhofo1A==
X-Google-Smtp-Source: ABdhPJyw9wcy/vAjWZ534fGWZnouFc2vvtw4pcR/SBh/M85HrKYrTsRz17gVQOJwNERGX7rH1TL7mUrMZyB/6EqcRRE=
X-Received: by 2002:a05:6512:3b98:: with SMTP id g24mr24830249lfv.276.1629889183532;
 Wed, 25 Aug 2021 03:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-21-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-21-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 18:59:32 +0800
Message-ID: <CAGXv+5GC=3E_Kzes1QKQtJykvGGugUUwjcO0EeDnmoDG0GHFvA@mail.gmail.com>
Subject: Re: [v2 20/24] clk: mediatek: Add MT8195 vppsys0 clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:33 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vppsys0 clock controller which provides clock gate
> controller for Video Processor Pipe.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
