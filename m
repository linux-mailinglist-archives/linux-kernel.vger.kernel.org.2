Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80C3066B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhA0VtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhA0Vr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:47:29 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:46:49 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a25so3922292ljn.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDziduizqKLpzoBTfR9X1C15EYhjGJSrZFRnbzR8wkE=;
        b=Sjt6qpSMjRGdPqWaG93wCYtNqxS14fnOJ/k6nu4XyAXGVIIv/rly30aKAzLT2OEj76
         cvVvrXZsa50vIIKIaYJv59R+A+jxNakDeJrrtUGKFDW8KpzNaW8R+riMZ8RhUxpHPvny
         jJKpCmHv804bJXjKvkkRUDaJtGTK5GHkMzvfnxnks1SI7cB094ppXqXY5wu7x0OfS6ky
         7oFZTJWqBgKvzmPOYNhaB8DiaeXohiaJB2efk+tmdNC3vLPXzbhWp/yeL1xVg6fntbtW
         ixCR3SK7tXP8EKE6fCpDzrF2ItCQieP3VDR7U4PRis+KQTJpTq6vcGjVYKNDSLus9SYd
         jO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDziduizqKLpzoBTfR9X1C15EYhjGJSrZFRnbzR8wkE=;
        b=UNIUBu7Gyzt6IOUqdnLcj2eDr0MWWpqi111pE7oVln33794qhQlU6eSv8Wx/wY+j3r
         ddxJFYFqHI4qI+kyQGGP1+6Domf1g/68Kf6kXu+9VO1EXB3HXf7N6yzEI9PRgPnDjenM
         Kn2BHDw1OpAyJZTuYKxG7G6PyvLXDbIsysebUqXGfXDJ6albY0uDXvZ3QO4Ke7zxaYpO
         6jLZdh/AQ7KPWX69j//kv2D7npYduSk8OY5rL6dzMv3stLb0y8fR99J9/gTkDr2wjGDv
         oXdwKH6FOhIqpfOXGVRoFDMHFi9RrLUHfzaNggk08W3EVMQMSVedZEVeg+Tyu7D8nflX
         bz4g==
X-Gm-Message-State: AOAM531vFBZ4eyflokr/Y1t4z5CD6pIR0ijTpEFhmX2Zcp0gaCGAP6tg
        sJdkHP1muZXq1+k6fGeyzg/dfw/3cRlguUQGu1SKPg==
X-Google-Smtp-Source: ABdhPJyCmTCCSzw7dGMtP7E/QxrnYxSH8Krbn+QOkMv4I4lfvVReRswKKpGPvI05wTvW29MPrDaMXYqMAsWXiIe7sgM=
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr1319826ljj.273.1611784007969;
 Wed, 27 Jan 2021 13:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20210127010632.23790-1-lorenzo.carletti98@gmail.com> <20210127010632.23790-2-lorenzo.carletti98@gmail.com>
In-Reply-To: <20210127010632.23790-2-lorenzo.carletti98@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Jan 2021 22:46:37 +0100
Message-ID: <CACRpkdZuf1Zy8hSzZuGVt7DzmAj+FpC6aYd32CMrAN6EimEjMw@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] net: dsa: rtl8366rb: standardize init jam tables
To:     Lorenzo Carletti <lorenzo.carletti98@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 2:07 AM Lorenzo Carletti
<lorenzo.carletti98@gmail.com> wrote:

> In the rtl8366rb driver there are some jam tables which contain
> undocumented values.
> While trying to understand what these tables actually do,
> I noticed a discrepancy in how one of those was treated.
> Most of them were plain u16 arrays, while the ethernet one was
> an u16 matrix.
> By looking at the vendor's droplets of source code these tables came from,
> I found out that they were all originally u16 matrixes.
>
> This commit standardizes the jam tables, turning them all into
> jam_tbl_entry arrays. Each entry contains 2 u16 values.
> This change makes it easier to understand how the jam tables are used
> and also makes it possible for a single function to handle all of them,
> removing some duplicated code.
>
> Signed-off-by: Lorenzo Carletti <lorenzo.carletti98@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
