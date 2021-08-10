Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C53E5A42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbhHJMoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbhHJMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:44:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA6C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:43:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z20so4080515lfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOi0FzJnU1WuNHAREyHt3NRP6amd/ZUjldzq+Pj4Qwg=;
        b=PgxtWQmKoEM2unN+JYTi6YU4uufVUt5SoE3Y0CqtBvDox7f/OWllpXL3er56FDo1s7
         EMgmYSt9+RTo1FQn0Sw6UQxwpqHYoJz9obk5QTSXYbrJk10+udCbCdbCHL2GT6siwFHn
         nbrxmGOF8GOh0bqYTPxwCGIWMY80rrTZoAWP5ZNHYwII+hBdqXNZhZ5RTKuPCOmr+sZ6
         2uxu7NtQuXI4Dy1Tb+RTt0ciEZSpI9osu5tI4SxAODD028SXvXmgVYUj5ngkZ5ONelDV
         /AeVyaL7O7yH7Eh4t6L5scgsaWKk/PiK+m0eiTHFiVHWDEGJfiBVS+2i4E6jELwPus9F
         9a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOi0FzJnU1WuNHAREyHt3NRP6amd/ZUjldzq+Pj4Qwg=;
        b=fhKS8oU3NpGHKfYFW2SjEyO6DZVK99jFHaK+fP9VtndgBuIoaO+dCI87BQukPMbFLY
         qaf0ulgHdfQQgSBeQdzwErm41ArMGUD4U9cDBzrHp67QuKDGv3VrNCPJhrSHvHUKifrG
         XK+ljxclJnLO4poL07ies9o3SvtIXve0QqG3WYSaWFShHZmX3PArQ933nSzkSyCAR+bk
         IKNok+eCPJpkUUISBLycq9dgVIH9glMFejRODEk8Q/V8Vdaio9qKpZQh3aEel+ol9uSZ
         gX9WEaCMVdQ4AmJwk9TrIEw52wwx3Q82vK38HDySpCZG2NixtfKCl/8/t68rXtssOrlU
         3qVg==
X-Gm-Message-State: AOAM533tJ3+41Dx/tEO4P8DYlynL/xs/uCC3w/mVRBtY1V3lyuQf+iQI
        XXyqhGMM3aQ3wAuXW2T1kfBt/H6lYPvYMa+/v1jSug==
X-Google-Smtp-Source: ABdhPJxbF1bBXolhzTgqSiZogGeQ/LtVQ5tXYydF5PKis8x8K6NIU/AkGspTNHz97t9pSfFBm7Le9MEdxNZ0nsKHYRI=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr21283639lff.465.1628599424634;
 Tue, 10 Aug 2021 05:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210722033930.4034-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210722033930.4034-1-thunder.leizhen@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Aug 2021 14:43:33 +0200
Message-ID: <CACRpkdaHDZpHayo+ytHJik6CAkx2NhYrmxoObxQiu3ELRxCBQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: single: Move test PCS_HAS_PINCONF in
 pcs_parse_bits_in_pinctrl_entry() to the beginning and fix its return value
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 5:40 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:

> v1 --> v2:
> Split bugfix and cleanup into two patches.

Patches applied! Thanks for fixing this Zhen, sorry for the delay.

Yours,
Linus Walleij
