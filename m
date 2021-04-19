Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EF1363954
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhDSCRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:17:06 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38487 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhDSCRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:17:06 -0400
Received: by mail-lj1-f175.google.com with SMTP id r22so26866059ljc.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=n61yGtJZyCGljbJcAu8LO/oqfzd6a+DBZ7YJWNVUUPM=;
        b=DcMersjhGdHbgIjQGLxIgaKwsrBTv2OlvtRY83K7tkGH6lzCW69gMJSchn1EYRLbQR
         dsx5eMYsrsXxZ0EVwq3nLUEsKkXokDoHUWFENOrSO4JIfaRQ/prrdaM599E76NcPDM5o
         ZRvfkKereqadHiOEHhcYEtJ/SiS1V7xc5o17Tw9+bvNNIYMqD5E3ESYhtKBOMgTvPmOg
         dqxy27pyRmgazIeA54VURFKuuA4ER9eB3M1+7REWKSZpLxISWbwqb1HPpqVsCk8MdBIC
         ABvk7ZRuoGr4W41l+0iVwULxnjfJz2uhQjM0gu5ULVbqvvxTQtWhRqHKV3AkZWTUGkEZ
         7WDw==
X-Gm-Message-State: AOAM530eIG0cNFHn53a5v1kCU2XSxVzFzR+rcRnPe17DwWMHN+zqq0bl
        An9HbY55/FMj+9taYRqtGiG0h4xGJY8BBA==
X-Google-Smtp-Source: ABdhPJyI78HPrdo1gUCjMSNazm72G5RSbxrmtZBnHt62N8QhwMjMPBV2QQgEo4zTZcBz54gLPdmB1A==
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr10176328ljq.474.1618798595983;
        Sun, 18 Apr 2021 19:16:35 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z22sm482991lfu.200.2021.04.18.19.16.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 19:16:35 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id j18so53558496lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:16:35 -0700 (PDT)
X-Received: by 2002:a05:6512:487:: with SMTP id v7mr4379009lfq.57.1618798595558;
 Sun, 18 Apr 2021 19:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210419015815.38910-1-samuel@sholland.org>
In-Reply-To: <20210419015815.38910-1-samuel@sholland.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 19 Apr 2021 10:16:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v67cs5nVJihF7+zfPv7f2y+xxDG5ihAJ4pciZ9zm0b5nOw@mail.gmail.com>
Message-ID: <CAGb2v67cs5nVJihF7+zfPv7f2y+xxDG5ihAJ4pciZ9zm0b5nOw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: sunxi_sid: Set type to OTP
To:     Samuel Holland <samuel@sholland.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 9:58 AM Samuel Holland <samuel@sholland.org> wrote:
>
> This device currently reports an "Unknown" type in sysfs.
> Since it is an eFuse hardware device, set its type to OTP.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
