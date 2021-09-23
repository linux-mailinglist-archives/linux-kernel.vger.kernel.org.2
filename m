Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247BC416747
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbhIWVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbhIWVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:15:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789AAC061760
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:14:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p29so31042828lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxXxNcv/6eNzAAN8fhaS7vrxJGE+bzvZ/0gEIXI7wcI=;
        b=jHIfJLb3BXmF+5JxcPHSppPnmHldOagXEqQtdmYJ6UCEWoN+L4C7en6niQqKH4LjEj
         WRljS8nwJabdImoaxR+jNi5fF2R/yzTGr8DkzPBq0kYDag8JUYcvaIj7e6x0Kaa7jsiX
         yguO97P3arV/8jhtRSMu56XT2EaAcPXfvQiSpNmWC33jSmLRvUpGdQ+N1QWQstbFnrsD
         3lmcz5jSNs8ed+cuMW+rT9Tx9I0ZaE2u1BkGhiCPwBJvhEwXufYboW5LIguU81PZYM0/
         d8AqVkgogAvO4YzJOZjYdT9OOArON3+9wzJPA60WrrybIXQ4juypeK4Kj346wzMrLpm9
         6VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxXxNcv/6eNzAAN8fhaS7vrxJGE+bzvZ/0gEIXI7wcI=;
        b=2+lA6DU+UdnBpzzp5MvfFJapYAqWUWYEUbuJkiQBCnIjHQGfwAEtb2+bVyaa6esobH
         R8STY4xEHIqXijjOZ+oqxenw7Z655gVn2hy7Ep/58BZG2+tEV4sjlf0jSKWCbrg6sDiT
         9E3Mpc69rcCkKnh+cBK9hrfc4sWQ2vgdoov7o6UhAPSF9R7utNuHcLeSNpSnmT2FzQUQ
         aAlgBg4KFIXWNwnAj3K/ATEUs2H20gJG8v3WXQAz/jRtORMxTgU5zaIy4igdPNM9O9oc
         yxYTFU4sbsu6hGqPmC7QAaSyn6de/zCpl06tBBAy9HBZtPGuWxFmYbb1uZBUY1KCFhNB
         Cp2A==
X-Gm-Message-State: AOAM533WdRHdcTF0P77zub53bzr9VCIgNR6lwRahJcf22ihojbclrbC3
        4WKA9evtBaKZcH4Qkfn+M8seqCXPuu3ILewSiJYezw==
X-Google-Smtp-Source: ABdhPJzbKGH3XuXNt657Q/JIhfFDaP9v7epYX50bsUVwc/TDc+/11OZkYy+zqblwdRJwbdcOVrHae5NCS20RcG5oIsw=
X-Received: by 2002:a19:f249:: with SMTP id d9mr6450803lfk.229.1632431653837;
 Thu, 23 Sep 2021 14:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210923033224.29719-1-shawn.guo@linaro.org>
In-Reply-To: <20210923033224.29719-1-shawn.guo@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:14:03 +0200
Message-ID: <CACRpkdZpOunX2GHSmRkWuJoakE=Rsdey2KbbK5Xy8SV61NyUpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add pinctrl driver for QCM2290
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 5:32 AM Shawn Guo <shawn.guo@linaro.org> wrote:

> The series adds QCM2290 pinctrl driver and bindings.
>
> Changes for v3:
> - Update function enum table in the bindings doc.

v3 applied for v5.16!

Thanks Shawn, good work as always.

Yours,
Linus Walleij
