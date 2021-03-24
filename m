Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEC346FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhCXDBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:01:06 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46815 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhCXDAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:00:43 -0400
Received: by mail-lf1-f44.google.com with SMTP id w37so29732419lfu.13;
        Tue, 23 Mar 2021 20:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=d1dReRBrfstAdxcP61fTebHNjPiLX2kfp7/R/spgjuo=;
        b=jf7tSXkr5wrIW10NcGesQlBbhOHBxYc/c1ngU5YAY+InOOQrp6bpSwnCIDrKB6BnMa
         Fi2Zl88ljKCRlacHPhI6DE+QWoOm92JY4geACEqb3bumg1hSSUu+zFTYiwVg00lKWBk1
         EWPe1zK78FQMwF8ZzfPXn5XtfQuyhj13w1m3Z2QOkdby25jhtKygAWztTfK1H/1c28CG
         qZCLKCQX72oR9VTnbBNNn2OldnXZregt3GWE0U6x1GQebou6G3v5Eo5j1Ykjxxuf3AQK
         cMoiCKgvcLW7jU+zO7W5dqj2yQzjNWl1M11ng2KBADYvgZApwgEPoVHbZyowU79ARqS6
         FXqw==
X-Gm-Message-State: AOAM532n+ksmZXuWsHYPPYuT3XauM+IsofXHVXVZkqeetgExiezjh1bq
        Azq7so2fv/353CPdlPufg5F4tiybPWDwWQ==
X-Google-Smtp-Source: ABdhPJxgdlUh9cqfPjsTXgVhR4loTDPlDV7/UZ0X+Syex3wC9IBWh16VYMijcaKi9GNL5+0Qx3zW1w==
X-Received: by 2002:ac2:5e36:: with SMTP id o22mr664868lfg.525.1616554841761;
        Tue, 23 Mar 2021 20:00:41 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d8sm117738ljc.129.2021.03.23.20.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 20:00:41 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id f16so28370075ljm.1;
        Tue, 23 Mar 2021 20:00:41 -0700 (PDT)
X-Received: by 2002:a2e:1649:: with SMTP id 9mr648961ljw.74.1616554841085;
 Tue, 23 Mar 2021 20:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210323204341.28825-1-jernej.skrabec@siol.net>
In-Reply-To: <20210323204341.28825-1-jernej.skrabec@siol.net>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 24 Mar 2021 11:00:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v645M9rrQ_c9P8yBckxz8QsZW6-srhOeTyQkSc0cOo0Wug@mail.gmail.com>
Message-ID: <CAGb2v645M9rrQ_c9P8yBckxz8QsZW6-srhOeTyQkSc0cOo0Wug@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2] ARM: dts: sun8i: h3: beelink-x2: Add
 power button
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 4:44 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Beelink X2 has power button. Add node for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Chen-Yu Tsai <wens@csie.org>
