Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4104A3D2238
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhGVKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhGVKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:03:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9537AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:44:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j1so6737551ljo.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hx+tXCeNVlZXtP+zeduOnxQkOT9122ALhOtDZeoZNYo=;
        b=XHNb946JijWn6fWIJz37eBqa+L0/00CGYSz43JufTa+O8q32+cGY5gSPTwYJFTtXAQ
         XxkLY4cCFMjHWGRH0p7iZIwt2hlsh+J2MpVmn729WSl2Qdf4Z13JjoScV5wTL7VSLLGj
         gMOuLQZ5b6bHYDffjl7L1OeAcbPCenUj6AE8qZGqcxzcuyKMxGxdV1QlIEfCUNUU1pYS
         6XP3N+EVo6klcB+Zra4z7NsCRnsNGHH8VI78l4Zoi4buKBArSuJRB9DUzBLiM5MEAisd
         E7G524Q4uyroYLZNtWNOO+NtlbR3IRJikhWHhkuCAvJEyHM7QuCN31g6yqTkvaVWcust
         Va2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hx+tXCeNVlZXtP+zeduOnxQkOT9122ALhOtDZeoZNYo=;
        b=Kj9z3sGh3n07hMQez6OH+sLeWATSa5Rsg/8irQkr8RUn3QyaDU/SwCBzr96f9gVDZ4
         JMFK8X+LufSZB7UGhLkuW1zIwUvePeAZsYrd4+SxxRR/yG7EIbDF5yduDvWjuafeQk7N
         MWeH7PFtfGNvfDg6Ipp2ttY32Eg2kaqWKZwwxMdrjMzr+U7/jG8cpqxRnChwTFBYRdIv
         E/NPVKfuykYIt4u+qypBjL3970lBn3moJ5kJFkOw+0zAYtK1+aVwYENcHlg+mbldYI7k
         cbd1+t5LHStW+JXh4jGRgFVeVZJcB5zpOYpKcP00RHUxDnBWZgKfYEkgDQcoIremElTn
         130w==
X-Gm-Message-State: AOAM530z1zvy8rutaqfotNj9JBCqd93SWkh0Hps7QgsMoKbNsIH7TQIX
        B3owCFkydQN7AEMwECkws5P1Ci/cdlHcTLFNWhfMGw==
X-Google-Smtp-Source: ABdhPJzgWyducs5OR634fAQXIR2yxlEZtTKfJ30TfxVuMcWKkVY6KimUQEmZTpGJXeO+P1NXIlvcAn6pi3AZABBTJ0g=
X-Received: by 2002:a2e:908d:: with SMTP id l13mr33468095ljg.467.1626950671828;
 Thu, 22 Jul 2021 03:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626947923.git.mchehab+huawei@kernel.org> <95289c73673861f462954ae8383eb88804ae7a0c.1626947923.git.mchehab+huawei@kernel.org>
In-Reply-To: <95289c73673861f462954ae8383eb88804ae7a0c.1626947923.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Jul 2021 12:44:20 +0200
Message-ID: <CACRpkdZsF-mESJNZnN42YsfVoCtm-sOGu=Ud3Ce_EoPdQgo36A@mail.gmail.com>
Subject: Re: [PATCH 14/15] MAINTAINERS: update intel,ixp46x-rng.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:00 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> The file name: Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
> should be, instead: Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: cca061b04c0d ("hw_random: ixp4xx: Add DT bindings")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Oops. Thanks for fixing this Mauro!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
