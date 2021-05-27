Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7939319C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhE0PBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhE0PBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:01:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C5C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:59:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e2so1232981ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xbGiR54Yx6gg+pVE2EkTSvl0jDhj1rav2WrSXNnIPE=;
        b=U1CDiYnRkPbC0bAmRjtb86+lsNu8KCuS0oRuTosKG6SCR3E/3L9BEi5177vck2m7zA
         MgV6Ont/sAdDPDRIT+ZzjeUt2r9DGVsdlVzag+Wi2dMRxW5F8OIBT+kOhxY2vqW5Uw2X
         m3T352hrAGv991hA89cVPZ83+mEAA+s0Cj0g4dgdTCQptZNE7XCGc4McY0UZMpZlrk3u
         ZPB/QjBiJfOGFRU3fz4OZi+Si99M4kNr+oLeSG446m8azInQcNEIn1u/PRB+6DoD5lz4
         xsIe47OTb4GBfzaK6R6QZf4YW9TJYIb8iw2VAIL+wxp+W1JeOFUyHIWhIFnBPhNliBY9
         uIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xbGiR54Yx6gg+pVE2EkTSvl0jDhj1rav2WrSXNnIPE=;
        b=r6aH4UUxMxplKH92mlcs2ZejAa8HlExS0LiOMkS0p5BfPkfbaldsgeO2jIj2Y8trs5
         1EH0nHf5VdChRcdppwN04lPNEKOc0RNUqY0BiYkTQDv2vx6+E7GBXCntXRIQA3l28HVy
         h1a5kNndxsQeQHYPMeJGD63ophHmyXk8K2RJYYv8Oj8tDhjnbsOnGpf65uhtN5ZYIWHK
         EMQIGCGuPq/bKyQ+qq9Cz23Xc2Wax5YG4LJbW+P042+Z3BqWEpmflI1oFrXk9rBKvPU1
         SE65l+r+g9NJGmdwvfCYjfPxJZ8OAyyOqy8/ENpeDOaT8wt7pNz+Q+i/gt0sc8NOjsI4
         2vjw==
X-Gm-Message-State: AOAM53122aWHChRDbW4gzy+rZxNRLFoDidSD2yAN2gleZFlII2sq+rQy
        NL+AiI+pPuIcqrdV3lA1OdrqZJAI0ldUMg+1L1Iec8e2eY8=
X-Google-Smtp-Source: ABdhPJzKbt5zIp2uVTh5CSDjLDATaaINbEMq/M8s0jX7ciAj7dfweUNH5poTdJ7pW9yPY1DQ+VUJ36hs752rsbqMFZg=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr2997277lji.273.1622127576068;
 Thu, 27 May 2021 07:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210523173910.661598-1-olek2@wp.pl>
In-Reply-To: <20210523173910.661598-1-olek2@wp.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 16:59:25 +0200
Message-ID: <CACRpkdZH4mqp6xc40XZmNS3+UmrZ9K3Kkj3ek+u9bz4im9QVXw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: gpio: stp: convert to json-schema
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 7:39 PM Aleksander Jan Bajkowski <olek2@wp.pl> wrote:

> Convert the Lantiq STP Device Tree binding documentation to json-schema.
> Add the missing pinctrl property to the example. Add missing lantiq,phy3
> and lantiq,phy4 bindings for xRX300 and xRX330 SoCs.
>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
