Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD741D206
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348009AbhI3D6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348004AbhI3D6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:58:15 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ECEC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:56:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so5648600otj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=pbICwdgUqYk+MY3CjajdFyZDTldPCutWBH9nPk1NU9M=;
        b=dYYg+xr2qgVzVQpnw1vKySEYeTZUMyLCO3IjCFtkwCbD9pKzqZBm0wXSYwHIqbVnZB
         j6j/az0gTXbKp/PPg7uz9Ed09jHYplqn0gK7ylwDo/7ULm7qTckwzVEwAQxTaMQ02IEW
         qPujZVK/wt6fs6hmVDo6J410aSqfL7yzXjTro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=pbICwdgUqYk+MY3CjajdFyZDTldPCutWBH9nPk1NU9M=;
        b=203+o2kb0QImjo6A+IBKULpgL+X4BgDCN0E/a+2gKUH/gHCSODTCE6Pb8UhZ5XRUDG
         gqAjpZjIhnMrD4iZLVdOreV6y+m+bRUP4C+406S47KogRHSYP4De/OoRMNdC5vBZmAf6
         oimBkmSHpDpWmDcB2I7GG2lsjC2EEnzyq5c0wkoncI0957d43zSGeKiQ9dz/Js4ToNmo
         ePZZlRK5DhKg3XkviiEXOS/XMih+YGMyYMo5M8VdL2uP5AL64Cl/9uzAbRhDEhvyhxZ9
         HDCIWWeWxTbhBblVmbCajdGu+2QB7cRPXVsXGrGV9kQXUD4LdprGT+tJFC7Abbe2GYsB
         GW1A==
X-Gm-Message-State: AOAM531RjWEVO1eHgPqtcBYPsvew20QNzGMmPdvcHT6d90eT89vzWJMI
        ueSRxQnmqVdtQYyf6aLIhiasIV0ZliI31a1JnLsxfPUBMmI=
X-Google-Smtp-Source: ABdhPJyg5d3ErOcJIXToSHSHSONJcSYacRkFBefewskavVwKz804P1gLqh9+QSY2AHtW62MgsT4klS34ZxzhA+GxzKA=
X-Received: by 2002:a05:6830:358:: with SMTP id h24mr3010200ote.159.1632974193021;
 Wed, 29 Sep 2021 20:56:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Sep 2021 20:56:32 -0700
MIME-Version: 1.0
In-Reply-To: <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 29 Sep 2021 20:56:32 -0700
Message-ID: <CAE-0n51sDbBfS82K7pY_yvWEQYdBVheqtzZcNVm16AZxaFMTng@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: drm/bridge: ps8640: Add aux-bus child
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-09-29 17:34:57)
> dp-aux-bus.yaml says we can list an eDP panel as a child of
> an eDP controller node to represent the fact that the panel
> is connected to the controller's DP AUX bus.
>
> Let's add it to the ps8640 bindings.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
