Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EEE3387CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhCLIkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhCLIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:40:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F166C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:40:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v9so44473403lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zd/n8ZjoI52cW2RYj7i2eUpePlcI6znelKNfg1+/N6g=;
        b=o1nZH2ZQ0X9VrXrbqEGFgEhNlN3QHg85Kk3IILWmL2ENheieF9vVLkN5fJt17kg3U5
         FvgjB1qbromZUMkt9zI6zOdss0FIje9puol31R/yXM+1rtLSk7FzhW8FSmloGOINUzAb
         OOEd8aEnqm+hyqnyl8d3C5sb1bGiWkf+N7iO66TyOvtPM9sI3Ps8kuwqm9vGUcuq87A8
         GiaDX4uOCCemdq8R7tZvrXiPFuwreIqRT6OlikLjxl/anV2q6b/TuJrH3yrBgVAJ87Nr
         nJ4m/y5Yye87cZvqse9uO2f8TErSc3CV+vh9yUFLx/1xqh6zkgCsNqyfEIPSD426uw5D
         LErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zd/n8ZjoI52cW2RYj7i2eUpePlcI6znelKNfg1+/N6g=;
        b=OpL0sVA6hnVqVAeXrnxkVgz4XmzJaByvBwroW8aoGIn0KeVQim8DbUWFcTp9Q3MmzI
         HurFBJ0OboRpZH7nOsXBq7Yk3fqBHqL2Wru87G5zfHEhuDMkuSFyETdH6yJyFfapFNyO
         EuBR2JHA/PlQqpc34IjFKD7MMW5aY6YSjMXcjNjWSJeunjD4n4aQa5yFFoiZ2LY0C1XV
         Gf/Fj75kSEs94T6L1hDWbOer6DFsNkPWg1vIJnSgvL/yLENBy03ZbyCXC29jEAEanFau
         jRazZHtLq3vLP/r5cXXBI62HTyhsIOciCM0jaedJmL8xgdNBGMkD9QSAdXDm4EhzqjZd
         43Fg==
X-Gm-Message-State: AOAM530ctIZmsVQDFHQCQPktoZUI4BGsBvcNMapP0D4HRCbBC8DSqcKJ
        UGVjWTkTTEgctSR2fi2tOjcS7NZNyQzzRAcg8hJJmw==
X-Google-Smtp-Source: ABdhPJyemyZC2ugXlOB2/+8Bbu5VIHXDl/v5G/z59y/hua8qqd9ZcFkO7qbCqiZ4L3RX5HZb+5pdHg2Je6jQM+soCbE=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr4985373lfe.29.1615538433856;
 Fri, 12 Mar 2021 00:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20210312083604.3708890-1-linus.walleij@linaro.org>
In-Reply-To: <20210312083604.3708890-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Mar 2021 09:40:22 +0100
Message-ID: <CACRpkdaHOf-WQVueBhiH20D8YvcoXe1Yjri5Vsp9sw_V4p3Cuw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mfd/power: Push data into power supply
To:     Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 9:36 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> - The power maintainer (Sebastian) provide an ACK

Ooops I noticed actuall Sebastian already gave an ACK for these
patches:
https://lore.kernel.org/linux-pm/20210128001700.pkuyfpq6uzcjb5ud@earth.universe/

Sorry for keeping bad track.

This means Lee can add Sebastians ACK and
merge these patches at will. (I can also resend
with the ACKs if need be.)

Yours,
Linus Walleij
