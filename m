Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2073DB6EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbhG3KKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbhG3KKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:10:02 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:09:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l17so11640874ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZt2R133aCx7XeK6whLxqaGJp1CckD0/+/JHAVnXBII=;
        b=qXXjWCTvb7bQswrtZtIPf67p5nwps+22Uk47mCX0d5Jje6qrncObzeMkX5+n2mbKkd
         UdL4cdVrFa0m4DSDbjTjeBTVJChl0GbQmB3ho95UZFvhF5yt2y6DM9o9qn0TAsNQBzPg
         xm0mbJwIJlCtUKpzjqCDoG5xFNRiE7pAng9biymgmIj5rWzkCqwrI5C8gs6Wt7WlmNIu
         APE1Rdm3HxkZngH1pqovpSywdHFK1rYyd4mgL9XDxk/4tCJMeZhIIlha4C2Q+0Mgs/1V
         f7dtsX91a1OTkIFyIxEeCVs1HY+7bdbyluWeya+Qra7hAmClRJcx5o92LIpGwJIVRPM9
         PS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZt2R133aCx7XeK6whLxqaGJp1CckD0/+/JHAVnXBII=;
        b=Kb9Us/H4HqQsh5VSHYA3a71bpm0+5/zSUp+LkSsgGgZDBEPVWoy2SYtYb6051DfXm5
         7WCCPZwD+MHtLu+nFjnLdIfXmpiW/SY+Wsyr5vMmOWtLu+dff3kd2HJQeIhSxlQkissz
         nXR0WZPVyvRX0fsDZRzpvMoIPqzRAbzEaqjNcpAxK2mp1q83EQMZ6nLn5LbsxXuaJiV2
         Kn+UNaZ0+0R7Qd+dls5qW3mh+wHC+cRMxRE7onxygbGUSsiwYubBhXXhFMLYV6bh3b1h
         2/EKD8kYlZZU5FM44CgqQEDIXTmfGChuuy2WEvKW/xI9g9JvOeJrNJy6+jgDyWxpO1ms
         vaEg==
X-Gm-Message-State: AOAM531yB55qAArVHByzhvxG4A6SmE+P8saVVnfrCBGA9d3r90smZ/vi
        8TX+AClv55txIVMAR32koJ2nmIWmpWCxJGjamin9nw==
X-Google-Smtp-Source: ABdhPJwxkks+ITUepWrL1L3hw7VwcJL4sVJlR7cMf5SD/e9d6hShbDT1dkUClPs1CHg5QtZfiCHJvce2hoLfjU3iPUs=
X-Received: by 2002:a2e:950:: with SMTP id 77mr1164198ljj.438.1627639794915;
 Fri, 30 Jul 2021 03:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210717045627.1739959-1-daniel@0x0f.com> <20210717045627.1739959-3-daniel@0x0f.com>
In-Reply-To: <20210717045627.1739959-3-daniel@0x0f.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 12:09:44 +0200
Message-ID: <CACRpkdYtnvwwStSpyhy=ZakkLviMJbLoW8QQNPhJRJaN=gF+Dw@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: gpio: msc313: Add offsets for ssd20xd
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 6:56 AM Daniel Palmer <daniel@0x0f.com> wrote:

> Add the gpio offsets for the SSD201 and SSD202D chips.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
