Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5243AE830
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFULax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFULaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:30:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:28:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d2so24680276ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eA59wexvGxuIfnxS1I40lteq43LjJdSMF5kxpf+tK3k=;
        b=C4x2iI7Bn9oQ9MlHA53oPaygzRNuqoIOA/J3LcXjfdW+6RylfPkrFROSlxsj09ZitR
         pmU25nD1YJy6IDu2aLeh/xzoTi0OEpc+Ku0fd13/nTvzLZlnz3TiH756kexP+ET3M2jK
         ihfJumU8Q1mXDd7FTt4/0fmb68mBAAQ9s7NyI7HJXNQIQ33dr0Vd+ek+RXZyjSnKJdiQ
         Q5ZVYRRe0KvK+ul+KeYXv1mExnaUZ91DlipPX56JVobAp8tRD1ThLkBSYsvScl5/l51t
         4a0lQSt4aJY3ETND3vRzXdvGkjl8JoVfh8ABq5kiGtF2Edsw7dwWuim2PjytvpL2BdCB
         6iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eA59wexvGxuIfnxS1I40lteq43LjJdSMF5kxpf+tK3k=;
        b=WitQuJ0cyW9Dm5035jQUZOcsX1SMMxDAl2leQIktByCDrhgGqXEtNxr6bFO/Gq0crH
         OCEwSgxl/DedsHPBcUzucJCac64r5kEJwdE56MVjsg0OoEqJcPnRxqphlRQTMGQxCIRF
         6owc+rvVqgxrk4uCOTvcVQJbbgGjgUTv3NKpXuLLZSyg3/9EEVEk6OBytFXXR38nsaIk
         lrMEvRjgddXUCtkPswBYJJwh8oMJhIdQCf1jBc6+kfeV54Nkvg7P4Pgg8w/b/Fmthxqi
         a3t1YqA9cu+VNJUbSxfsLPsglCafzwHOZMNwCy/PR5C74po2puCyadzR+omJgkXDtAfd
         FFNQ==
X-Gm-Message-State: AOAM533mxEdtUSrVSUBCJG+Bdx0DRPvubNdPcgr+3N2WsjMcld8Sa/wI
        G2nZMKtnPsqjRCQPSXkBPRn2KwtGLYB8kjkitbA=
X-Google-Smtp-Source: ABdhPJy2fGOG3eU9Hto3GJaTAGVjXn2sEaQ/pWWTsXvnab4svNA5KodYzYKzvK/WIP9x2Ou6WpNKNuOcaJqfrDUP3jc=
X-Received: by 2002:a2e:9757:: with SMTP id f23mr7070671ljj.53.1624274915298;
 Mon, 21 Jun 2021 04:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210609141150.14637-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210609141150.14637-1-thunder.leizhen@huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jun 2021 08:28:24 -0300
Message-ID: <CAOMZO5ApmFP4Gh=rSJ1kPvOxJw+HGcYhHP5GmT=X5B0gw4ZqMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] irqchip/irq-imx-gpcv2: remove unnecessary oom message
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 11:11 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
>
> Remove it can help us save a bit of memory.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
