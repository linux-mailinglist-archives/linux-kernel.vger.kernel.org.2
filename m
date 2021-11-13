Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2F444F258
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 10:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhKMJvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 04:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbhKMJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 04:51:41 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9FC061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 01:48:49 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 13so23454649ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 01:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eVVBHbfcnHbENvpLfwe3mTM6CIsHi7ue3snsouE+OY=;
        b=Ity1z2NigqKV5EUC8DB7qyQ0Hhd5Yx/Dnj2mk0ca9ifbw7jeTqlLnjEkpkJdov+eYt
         FmPksCdG3A/drE3vMfmnXjJALWBORBn6bX9+wgPjrVgltwQ247o+g4x3DF7CW48Pr2fU
         OqFs+M5imbKWTvgCQ+tSg9L5x6q6VsHlZvKyuRQas4KISKoQX2SlWRD3tMkZzrG/0Tyy
         96cxyoIRWcXnacsxLHfrBP0VKrC7ROpXb46xbitA8d6uBNc2MNYqBt+H7eEsLZ9DwXZa
         d4/7eF5zNjMyEoKFoq2nNDG1tUlAnEsjGdshEFvl/mjeS6avFo31LZoGAJwr0bTWocRa
         1lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eVVBHbfcnHbENvpLfwe3mTM6CIsHi7ue3snsouE+OY=;
        b=eF4vUVDO91fUqnFLJF+3fozWBzyuRqlNLNH9kpGsF2jx969nB1eLMTsFQd0vi1ZlpQ
         yxY8btxxZh/ZSt26fRKAlFKUVnIe9GCZ8XVf0Jxx++qEbAgv+nGlJBhQAi6GXTH+F7sq
         vMExuQiD4ZNLxAMc5mnO3LeZGk/ajL2MZCxWoi1KJVKAdRKIkhWwePlzds3sso20o+cm
         pmGDld6DpNT6SOO9seB1JANu5A7wdVgV5q56DFpAQiY/V7jmk+nzEVgpNjClkDlxBMlR
         758ii9qEPbC//aoaqv+MXoQuygOT3/4zLZVCfV6KFBEpQlIjghgP3dAmuEMU7JflD5Kc
         8M0Q==
X-Gm-Message-State: AOAM532KnW+QQE1399J9+pTZ526O5fv5G/pphGAwFodOUpSCgvhk0uQy
        fdds8EC8AbyjoSOSLykqJw3Y0gRI884Mf3mwRdo=
X-Google-Smtp-Source: ABdhPJz5A3xJ9U3YyemcWmC6QxVljfUD/rLLxJWuY+4sKSwbcpSDHg3fvd46EJGjyhXZtUTcCbm3b6kdrufez5k7hb4=
X-Received: by 2002:a2e:8189:: with SMTP id e9mr21852509ljg.333.1636796928178;
 Sat, 13 Nov 2021 01:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20211112202931.2379145-1-anoo@linux.ibm.com> <20211113002948.GE14774@packtop>
In-Reply-To: <20211113002948.GE14774@packtop>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Sat, 13 Nov 2021 09:48:36 +0000
Message-ID: <CAD2FfiH2YaD=m0wPrqEaKaUtJDEHmxMXwCU3LW9UdOfC+AnCeQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: configs: aspeed: Add support for USB flash drives
To:     Zev Weiss <zweiss@equinix.com>
Cc:     Adriana Kobylak <anoo@linux.ibm.com>,
        "liuxiwei1013@gmail.com" <liuxiwei1013@gmail.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Adriana Kobylak <anoo@us.ibm.com>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bruce.mitchell@linux.vnet.ibm.com" 
        <bruce.mitchell@linux.vnet.ibm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 at 01:58, Zev Weiss <zweiss@equinix.com> wrote:
> Hmm, how common is it for BMCs to have a USB port?

If it helps, the evb-ast2500 has a couple of USB ports, and I've
actually been trying to enable USB (additionally with CONFIG_HIDRAW)
so that I can do a demo that uses fwupd to update the firmware on the
attached keyboard or mouse.

Richard
