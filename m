Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9284F458285
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 09:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhKUIUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 03:20:47 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:35682 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhKUIUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 03:20:46 -0500
Received: by mail-vk1-f181.google.com with SMTP id q21so8388073vkn.2;
        Sun, 21 Nov 2021 00:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YPdHw4igg7YGQnROWzeeN0m+U3heN/q62UEOUxqqzSU=;
        b=19iLz+Tfx5W3CrhGjwKwUCFPtO7Xy8ke5rwypina3eFBy1uiJ03dF+p+XTyZl7mVMC
         DZVq3EsIKJfsqzkUs1SGO2UR2fQ5hyYPCkVbX4G0THJ1SPpEij7xVziUTD7gPBawB3VA
         ECsfxWSLIw23HdXOCjfs/y19DHoiWa5MUHdBq4QienFYXc/GkaK3r/L8OBhG2rgOwkfc
         jiXr/CBqG4uIo8t95kd+ydwPST0/DXZJ89xEqSWJ3dG6C7XPMSnMfl3XPtYyPsN7oFSK
         aQQdJ9K2olioOjpUtzfhRPqDZwGKLPh7IRpk7rekVFiE+fvIl7WEP3BArCu1XLLDjLau
         VqIQ==
X-Gm-Message-State: AOAM5317EDQ/SqRJK4wbfKby0R/uunSgRzBWEC0E3/O1yMRjSW+RIlBG
        WIm33Dmln3LiuyH/oKZtoalYCc9EcOpN8w==
X-Google-Smtp-Source: ABdhPJxLAQMjHhEzGuxaFek8uZ0VDoqJalO8OMwjd4YbQXG5xKPw1UD46akVTFUY7VWdr+0WVFKORQ==
X-Received: by 2002:ac5:c55a:: with SMTP id d26mr144537344vkl.25.1637482661476;
        Sun, 21 Nov 2021 00:17:41 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id y24sm2902118uaq.17.2021.11.21.00.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 00:17:41 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id p37so30165174uae.8;
        Sun, 21 Nov 2021 00:17:41 -0800 (PST)
X-Received: by 2002:ab0:4324:: with SMTP id k33mr71136243uak.43.1637482660900;
 Sun, 21 Nov 2021 00:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20211121070321.601659-1-jernej.skrabec@gmail.com>
In-Reply-To: <20211121070321.601659-1-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 21 Nov 2021 16:17:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v65KpiW7s4BVTfiBRp1o=wM+CS5SBH1RT+2ZJP-ymtT4CQ@mail.gmail.com>
Message-ID: <CAGb2v65KpiW7s4BVTfiBRp1o=wM+CS5SBH1RT+2ZJP-ymtT4CQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Sort nodes
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 3:03 PM Jernej Skrabec <jernej.skrabec@gmail.com> wrote:
>
> Nodes are not sorted alphabetically. Do it.
>
> There is no functional change.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
