Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD732FAB5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 13:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhCFMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 07:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhCFMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 07:46:52 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEAFC06174A;
        Sat,  6 Mar 2021 04:46:51 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id r25so7941908ljk.11;
        Sat, 06 Mar 2021 04:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2g6ss6rYKOP4lmEx+LB3UxrMMnguT0MjRtT2mTAeZs=;
        b=bV4kzdGdE+CEJGifEziaa7CAs1FAczELonSZHQYs7MQsybqCfFQF4mobSTpPcwgo1S
         wIZm3YKW7QZopStzM2tvyuUukpuo26SD/PmcL5wabkX6UU6cjmElwix37kM3HMHs6qAC
         gFsWGFuYG23x+0CHnDIu5nLk81ax55SHWx3Y3kMjqX07oLWJTavjOOGKsPlHo1JdEeyk
         GdYWmph8E3+3JqS7wHf/rF6Ii/05GUgwBBdzmyFkPNcDgx/faAoWdjjrd+aEemC02Iiy
         dyyjYbjDDh5BgcFdik+DbWYRGFT4rc7+ucUphFeQBw2r/eXrA5XKIMJGxTtlvlHXyh3q
         Vwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2g6ss6rYKOP4lmEx+LB3UxrMMnguT0MjRtT2mTAeZs=;
        b=HAesqh3jZRh2vlh7eCEzX8frUZssLeeFWWHVq269a8O/9Fpx1dKPMYVc8VXRAMJfPe
         vlsCsHDVo2DH/haKHorOjvcjQOZabALtyzSefcUlK0tBWqNTExB9qZ9vtWihBXrzygwZ
         Ycq7met1+h2Z9285P47UkQ9325UKyYIjegd2Xx2vIoTxz+XgyQHWzC36GKNvGPdieLkq
         zTsRHo/bxOErCwmGzNHLZjsfxy6btgTrodPXIlsXqqponjJrpJXQnq6+k8IXfwItQXyu
         0Atvef+He4ZLhQ9SOZhNA2CCERmF2VwHQSjuKj2LuRlUPR6/j2r+xhBS24GQOAzWsTLe
         6Ilg==
X-Gm-Message-State: AOAM533ANug21ixm4G2SDEFHs1+bkDROIFf6ERJ9JvX7RRrjH1Km9tK+
        BZ5wI15LCeUvUBrVMOdk/yreVIZ4UICqpbPGq6g=
X-Google-Smtp-Source: ABdhPJx1ZvVxwBE+EAJhHYtvZQgfQ3C3X1V8ubcPz5t1unbzrKwm0OXIVk/rxjCtGqGFespcEcTz3V/c8m69RsKBo64=
X-Received: by 2002:a2e:6f15:: with SMTP id k21mr8281700ljc.444.1615034809963;
 Sat, 06 Mar 2021 04:46:49 -0800 (PST)
MIME-Version: 1.0
References: <1615030121-23439-1-git-send-email-peng.fan@oss.nxp.com>
In-Reply-To: <1615030121-23439-1-git-send-email-peng.fan@oss.nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 6 Mar 2021 09:46:40 -0300
Message-ID: <CAOMZO5DDJ3746-sBFBuQBDxJqQZKP1BBZTG9Brn8WZBnbe7RJg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: add wdog2/3 nodes
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Sat, Mar 6, 2021 at 8:41 AM <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> There is wdog[2,3] in i.MX8MP, so add them, all wdogs share the
> same clock root, so use the wdog1 clk here.

The patch looks good, but I don't understand this sentence where you
state that "all wdogs share the same clock root, so use the wdog1 clk
here."

wdog1 uses IMX8MP_CLK_WDOG1_ROOT
wdog2 uses IMX8MP_CLK_WDOG2_ROOT
wdog3 uses IMX8MP_CLK_WDOG3_ROOT

Please clarify.
