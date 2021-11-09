Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4D44AC58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbhKILQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243334AbhKILQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:16:23 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1BFC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:13:37 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so30302230otf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rmMKAGMu9q1bt/xJxmsQRIydLge8X38RfFL5KTg1z4=;
        b=zKm0tHObkFcyJhe8cIZ+aod5kdhrpicYdVF7sabDJLMygRfiOcvf1vrK/tXMOzXPfX
         2mwnSV9Be4WaLvX4UDDIQDRmdH1aZL1ATCdqkOyWG1EcO+g7Cr/iukWPrEDTGhjEWTQW
         C/Uw5dEjSYeKuBcCGaXsWhClpUPOPWErp/6J/PIACuCy5QWgEQqpbUe9mBjgrl10+OYI
         81ImE5OVBvkP5RAI/KbfBxlB9eb9Bh1TtP6LA1/qZNlbJCrLyv2o9XK0Meu7tZ4+pzR1
         FlFFDF0N317bjOGmyjs1C3eKyTSaepyu6/EdeaOYMc9aOJF6QPkbL5kww+P/K0NQ3j1J
         3DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rmMKAGMu9q1bt/xJxmsQRIydLge8X38RfFL5KTg1z4=;
        b=gzfF0FkDXxq4FWUK7vG1thY1nya7L1pv/jrTsGev1oLEZyUS1COFxt/YdWr/UJUBVG
         nZpwmLtMXtcC1dqffUII1s6XbpWnk/6BPGnxozvnYSyKEFfKylWI6F5DFoaCOncQmv0d
         vwuR46TInNLYMON28f2rkwtmiBMjPkGWAtH1Y/7PoTYQfUcUTyQ+2BS6xQeXqG6frpxY
         6WTyxUEsXRwhFv+XGWEPEkHqTaS5qe5gkgrnTf/RbmiguWAvgzeEjgNU/+90MNpCYdyZ
         Ttm6sTEdyFSfSuDndt6+kuW++euQ2Q9EcHEIrv/W39FRDaeIbRhkJcTfQfDy5GZG7s0j
         +HOQ==
X-Gm-Message-State: AOAM531sYUtyta96Bny0hf9tP5hhkeThzqWHTlKn/ZFLm2SN/Zku6b+z
        jqcrR14zuwfHfiqjyUKLM9Kf4G0QbTRPYOd9LC+6UIfZq7E=
X-Google-Smtp-Source: ABdhPJzdhHbkEqGSb0yYmdRySxpF0Rdk3RbVBe3IZd+eo2juUOhADMrdjNFKxGdHuUlC1xd2k2Jj6r2gb5v+5Js6z90=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5286291otk.179.1636456416779;
 Tue, 09 Nov 2021 03:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20211102220203.940290-1-corbet@lwn.net> <20211102220203.940290-5-corbet@lwn.net>
In-Reply-To: <20211102220203.940290-5-corbet@lwn.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:13:25 +0100
Message-ID: <CACRpkdZzrnw3NdUEzjWP3VVqvUvtrBW2xXcuYYto4n=XHYxDBw@mail.gmail.com>
Subject: Re: [PATCH 4/9] Remove unused header <linux/sdb.h>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 11:02 PM Jonathan Corbet <corbet@lwn.net> wrote:

> Commit 6a80b30086b8 ("fmc: Delete the FMC subsystem") removed the last user
> of <linux/sdb.h>, but left the header file behind.  Nothing uses this file,
> delete it now.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alessandro Rubini <rubini@gnudd.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks Jon, I simply applied this for pin control fixes since
I feel responsible for cleaning this up.

Yours,
Linus Walleij
