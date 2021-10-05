Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D342321A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhJEUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhJEUfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:35:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6AC061749;
        Tue,  5 Oct 2021 13:33:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so575604pjb.3;
        Tue, 05 Oct 2021 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cWnkiNHSwi55ZiD4L0VvG3TUUEbuFBF808HoHr4qCDs=;
        b=lW/bsYb36msG5mDUrWNvMOAHzongZSZJiThoide+rKf1M57QIiYwFdSNrzgHHmnNAF
         OGgNfXZR8DKpW54EcYU+bQo0MG0nrzxzgbldKaL0mQ+Hn/Lha3DsTnMe+rhhiVDdtZ55
         qcdCQMzBj3nIxSQi1Pdh3PJl/v3YQC+U9CXUNlhSlcewOWXwR8lfhejCOsgex9h/HbYk
         ZPhfkQakt79q66qJLgXK1ISLv5XLlWvWq/B6/+OXIx61niCHGipVMKpRMCi3XLh3yWsE
         8euXn9QnC1heHppsiQWMGT7WrtXwFNQa1hPDVMx0Zs24pRtpZyv5T0ePilv2vTBziCxc
         571w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cWnkiNHSwi55ZiD4L0VvG3TUUEbuFBF808HoHr4qCDs=;
        b=E/CxDif44ZxnD4EpdpzcWfMLvEZh8oyZf4EovhKA42f4to/szS/u55f6U2iEsdDes0
         deQ0JJdcvWJpZgvqE1nWVpcEgMgMKVC+5ldxtDz+4GMk/gEShmY9lQFS429B1nYO+L9C
         5UcK2oIbL2//U3uB8QNVOuGUja/hUDq4cCVf/7tCpeSfXxHg0L1mNbueMqg8prZ08SZX
         /OXMf0IiQKSIvhr2TC+ALHHRcA7sbyeTcsdl78NMszYsEeaos8hM5m0nh5bWzqo9k+tL
         zJq9KhpN2oGJX+MR7dcMuwGeRze8yNZH6UxoH0ltei90YLLwv/Uav7eD0Vxte6WyXPb0
         7E8w==
X-Gm-Message-State: AOAM533XYXw/ap9nNgdKLtdBXSjrnKiXinauaTikbAq6as0T7mTG8nqf
        vKFHnv2XMNlOv6zkyU3dkas=
X-Google-Smtp-Source: ABdhPJwPUJPyBu/rDVipbDnhmtYUuiMmS30qjgHig0GIDLYr4X8vlJ1/77KO6+9CIka/gR8frmf/Ow==
X-Received: by 2002:a17:902:7fcd:b0:13e:8b24:b94 with SMTP id t13-20020a1709027fcd00b0013e8b240b94mr7103473plb.45.1633466027909;
        Tue, 05 Oct 2021 13:33:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d0a7:4716:8e1b:a15d])
        by smtp.gmail.com with ESMTPSA id i13sm3193680pjh.0.2021.10.05.13.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:33:46 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:33:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/11] MAINTAINERS: rectify entry for CHIPONE ICN8318
 I2C TOUCHSCREEN DRIVER
Message-ID: <YVy2p/lmAtIFfaW6@google.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
 <20211005075451.29691-12-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005075451.29691-12-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 09:54:51AM +0200, Lukas Bulwahn wrote:
> Commit 04647773d648 ("dt-bindings: input: Convert ChipOne ICN8318
> binding to a schema") converts chipone_icn8318.txt to chipone,icn8318.yaml,
> but missed to adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> a broken reference.
> 
> Repair this file reference in CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thank you.

-- 
Dmitry
