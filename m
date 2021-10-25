Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2165439D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhJYRMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhJYRL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:11:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B75C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:06:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k29so7641384qve.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=do-not-panic-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEb6OCV/meZ3qzeNt+5KNW40f1lAyUtMsMWRhcGrcOs=;
        b=ROCND4Rrq3ERDpMlxkDUvJYbkghYlm/tr8lRGB44vQ9uYCsCqTj0N+i+BotqxD8vFb
         m7Vg45HDeZs+dYG6X6F4LOEbEiRRr8G6hxaP4gNzPkIAyhGTD8ehy/Wkoc2WJgM9S28d
         AXJkRM8XpVhEPhq8/PuIDrd41k1MuT4W3D/pnKsTFCJ2Pz8soXWebjw0OjSNpjp7qQxq
         CeeOw+9AEvwnz8xIQ5vHk1UhouhdYlnmvWhymvy7uVUd0A0OsnJ8mv7dayEeD/lVIHXb
         LsMdDXb4hFPb5gVpbrsGv1N9miXS59xZClwGVYhkDOlRpMMtOpMU7+78b9SuPJe58KQy
         47ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEb6OCV/meZ3qzeNt+5KNW40f1lAyUtMsMWRhcGrcOs=;
        b=OVDTR+9KjsjdI/4lEahnxbcKunqC9VIyFbCWauHrkifRAieWrC6ImfYpAFeAACZE2s
         fRdwUT4AFiQ80Jca7nX7M5GrGz1e1VeG5pSKrrQpKHJ7PTUh/Fz8G9viZMgCjoX4QC+d
         3dVVaGjhf2VqqTCibgU4jz/rajlfICCQbWxkfEqyqeKgJzuFDUwaEjscQ7qr76ql4k8a
         kEpf/sei5eAemtnWekPiWayqz0ZxM5+0xaZZqF+LiAMfaUC9Sx9MUH7jFK3BSwlXt8cm
         4Pmhs3X7/ndvkVN4hB6mgIS03XaffWg+jZwTZkwu9cn0myjFE//jnuPWisH/tRRhlVzu
         HeRQ==
X-Gm-Message-State: AOAM533rQ61j/hmfQqmRHHALuFlqORKzuLS3mTesU5cYiVrbrRJmlZVg
        ik4MR8gSf5bhtjGdMM/gqr3cr2AZJjO1zQ==
X-Google-Smtp-Source: ABdhPJwHabANTbD8aE666pR5q2QUELEX4aGCGEEGyiPBc1NXIPF87+ha2Oat0v0M+pn1CX/n1ets8A==
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr17217217qvp.51.1635181577756;
        Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id m2sm9736813qkp.124.2021.10.25.10.06.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id y6so5734402qvk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
X-Received: by 2002:a05:6214:5085:: with SMTP id kk5mr17550416qvb.12.1635181577058;
 Mon, 25 Oct 2021 10:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
From:   Luis Chamberlain <mcgrof@do-not-panic.com>
Date:   Mon, 25 Oct 2021 10:06:05 -0700
X-Gmail-Original-Message-ID: <CAB=NE6Wk3=iRrR_U7PBpkF6=JzUtcPHf4wZ4jkArQ59GzhWhpg@mail.gmail.com>
Message-ID: <CAB=NE6Wk3=iRrR_U7PBpkF6=JzUtcPHf4wZ4jkArQ59GzhWhpg@mail.gmail.com>
Subject: Re: [cocci] [PATCH v2] coccinelle: update Coccinelle entry
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>, cocci@inria.fr,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <kees@outflux.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 10:10 AM Julia Lawall <julia.lawall@inria.fr> wrote:

> -L:     cocci@systeme.lip6.fr (moderated for non-subscribers)
> +L:     cocci@inria.fr (moderated for non-subscribers)

BTW if one was subscribed to the old list, does the subscription move
over to the new one? And do posts to the old list go to the new one?

  Luis
