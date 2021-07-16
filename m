Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CD3CB282
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhGPGbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhGPGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:31:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36818C06175F;
        Thu, 15 Jul 2021 23:28:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v20so13476291eji.10;
        Thu, 15 Jul 2021 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQbnoZ4GXI+Z/rBFLWYGRWA+0vR/EX50wcqWIvvUhI8=;
        b=NP6XNMxQc37xj118IifdcxKmgwuiZ+s0zb8sCoyhFMA0Trez8FyAUk9m/ZfUKppvjq
         WdaaPeD+IubA/cHuuO/64D3ChjKsuCDzLgjxSsWuVJEL+Moutr3tlF7WyZtpl34YHYx8
         rUl4ewW1qWPcqfgOff2FXe/9EjK+WAC708CeRz8Mav83FEOGUwHRO/dgF83SofkGeLIF
         Vizuad5jS6WfH7rMp7vmPGfSelPkskFixkA7LGm3mj3K/CHKJR/YFCuQDwXFKnHyVBU2
         bnQ45b4tutRZhmjHGNjm6m/oHuMG5aXn0S0Df9DuwqmRTBT1uExA02sU9nfPJwwp9TOi
         voWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQbnoZ4GXI+Z/rBFLWYGRWA+0vR/EX50wcqWIvvUhI8=;
        b=L84i+FmUvisACVyeWj6O+iDj1lxs4dsMI5BUBXSfi4n+IwB8D48FWCmmZeG1jjXuEL
         IKFyObRBlecthV1MKcMlSmFJxSYf6FhoQQAr8VPicA5MoHiik6O9PiEHLmmCOAqLhopF
         seK4EEADPDRapzVFpXkF0Hg1N79gycBq8tjGi8Id/7NhYOpioXuW8rd5V9/nlUg62WxT
         +GV8W6CG7fo0oQ6WjGCB7VsaDHBr2W5bnup+9+W/4arxwGzCRZr947EZTlZ/E74oIlfT
         gD2EBS4EjHz4n19i+N7TQ+gGvx47C0ul/BxW24jLg71KoTBsfkdl7Cn0Yl9FXtSzfc/H
         YWBg==
X-Gm-Message-State: AOAM5311h7lONSit/zTZRvWue+kS1hhVcxXcDOK03YFkpovGPmelrude
        jf6unOY7e6RZPnVhst2K8/l0s1JeqF6ExdO2R96hb6q/xySOWg==
X-Google-Smtp-Source: ABdhPJw/bcGLwdj0/xP/xdMIz2z7UnMYkykbaqfvQIwLSYO8cGV916JAHIqxJK0WavDf0aJV77IgVtHrWpyjtb6V04I=
X-Received: by 2002:a17:906:7691:: with SMTP id o17mr10364345ejm.209.1626416924808;
 Thu, 15 Jul 2021 23:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <7b314145-cbb9-b491-ccf5-d6021a574339@windriver.com>
In-Reply-To: <7b314145-cbb9-b491-ccf5-d6021a574339@windriver.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Thu, 15 Jul 2021 23:28:33 -0700
Message-ID: <CAEdQ38Ht+WfROb1nvQBJaMjn49d98NYpEa6idAaWNMVJ8V-PFg@mail.gmail.com>
Subject: Re: Concern about arch/alpha/kernel/smc37c669.c
To:     He Zhe <zhe.he@windriver.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 1:31 AM He Zhe <zhe.he@windriver.com> wrote:
>
> Hello maintainers,
>
> There is no "SPDX-License-Identifier: GPL-2.0" in arch/alpha/kernel/smc37c669.c
> and the following copyright is found.
> "
> Copyright (C) 1997 by
> Digital Equipment Corporation, Maynard, Massachusetts.
> All rights reserved.
> "
>
> Does this conflict with GPLv2? Anything else we need to know when using this as opensource software?

Unless you're using a DEC Alpha CPU, you're not using this code.
