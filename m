Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02733118E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCHPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhCHPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:00:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:00:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m9so15154824edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ekCZMHXgwaHxgHpJfRzLgVCiXSCvlL3z1p/Dj8xOMM=;
        b=qzhaVpe3MtPhdiVp0l3jqha8NzCFpAiM8aeUsjJRxS3L5KENy1c8yfkqZtl1p/2MT+
         b2EUtJdpmiZhSML+RIf+lvwpn9EBZxhfN4L/tC/oPHXVHobrzttURJ5Jnh2fCS3sdbGN
         MRu3iRKcbzq1ROqBQwhbWBTMo4ROam6nUZYAs4apKfOzFfjlS7jDV6eLKRAxkLcw+xkC
         Y+ze82nFTjLEz6h7cPkOUhz05GUDg7SE0j9nXPLV4jJpm3jjiJARp5f3iE0Z98Z2Wk59
         1xSmzLDQkg+RQx6FglT7/MEB46zg4tvsWqQwFEZo3h+yV3prOGV9Rd9NzoiIZcfAdUXF
         utkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ekCZMHXgwaHxgHpJfRzLgVCiXSCvlL3z1p/Dj8xOMM=;
        b=rcaQhYff5bw55uR4y8ymcd7dshgH9U74wkmQj0d+wvpoga/mjp46IqvTs2hE5S+RRT
         W/SOALXLaS2Cogh8XjwwhTKsSHF+T8cpRfen6yzyZpgMVqrUv2HmlyIcWeMCEVl4fxzP
         151lPuz/F4n/wOx4Kv5WXIXGk5sff22vtRBi1l/0VC/8K3IgC5jGw0bR3+2Tg/FENe1Z
         BzlEI30j5iMIiz6n4eJDrFxYLlZFAVUhKVxJY2YUEbNXjMsQyWe3IKqs1U5xTJu1beRt
         EDYc0uR4nC5y7YMxDsg2sCR9zpHT45Wan9+RSHp5RDqJoef5CIKI3fhvzB+tpaWuoj2J
         WDNg==
X-Gm-Message-State: AOAM532FepPfdhTOFjtuQtBffjIRD883Tebmgd1uT40ZN1So5xEAQI4h
        ndXsvdE376XNoIXA5fCqbTZRQnzclF0TogZWHKSccw==
X-Google-Smtp-Source: ABdhPJxWWk0qilC95RD9gboXObt6v0+Il8uPSlHzJv/u+Uw9jw61553R8rteYXGSKA6iSHJn6QAj39EybIrta2ysEa4=
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr22547852edc.341.1615215601861;
 Mon, 08 Mar 2021 07:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20210219223910.1831-1-luca@lucaceresoli.net>
In-Reply-To: <20210219223910.1831-1-luca@lucaceresoli.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 8 Mar 2021 15:59:49 +0100
Message-ID: <CAMpxmJVzShDO7b1i_KiTdu9DGexNmgR2oA241H9=mht0iYMBqg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: lp87565: fix typo in define names
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:39 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> "GOIO" should be "GPIO" here.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---

For GPIO part:

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
