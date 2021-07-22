Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A93A3D2D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhGVTiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhGVTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:38:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234F9C061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v6so10401325lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScvvUzwC0mUIBKLPUKbQgnnyDEcWovKD2rBhWFrjn9A=;
        b=d2JeDYA2jQU9YvskfIr9TaUkNWmJdVoR5pYUF7kn1c2gjyXN192wRMpdGOAxuYQ4AA
         X9XH9uLsND0Rg8qsane2lxrHoAgIhceuiEHGcDiZwUldkcRiPDycMqarSwEm2pKu8x+L
         qbZrqYT6B5X4AEgHk/5NF/uQklGjfXUyuG5SijBOSMYJkwXLAXSCMQMRKcCZ8pEXwAsF
         cbntrR6UEB7tQzcaUxGod5d+Y5Vs669VCEg0DmHwTF/SMLYH7EpJS9PBiW8rttB3fjy7
         il03T+dR23KRgSEy6M4Fj+Ui7uNZA9BwbeniIrBG6HAxRNMQc3H0VJTKkUpvz6miAQrk
         bZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScvvUzwC0mUIBKLPUKbQgnnyDEcWovKD2rBhWFrjn9A=;
        b=jyQUVBb1J8oDkzr5kAxVoX/rhv4zoyid4zCslLiuQeUOrDMk0fM4zLeE7sTLPVOdYR
         EiwgmZToqQdygAJEwqWbfdag3n1YP2cbXqgw0XfZVfTpc45U9XPf3MBRkYElU4xEbn+Y
         q5xqaPdKNgikvhimUYumSO+0mJEApjMbUkavwMYSus+1RPO/Y/Av4gbTk3ui8f76P8ac
         WhBQ8P0Q4Gm1+aw7I53rrXOwgtkp9B2mdbzuCPxhid0gU9hAcVUJXu1JVcaOHQm7pPEd
         uxoq28bK6lRqpqWTz9UDtHC2HEXam2mBMBRUdyE3UwC3/pyDaYWLD036/0Fgp0bwlk/2
         mw1g==
X-Gm-Message-State: AOAM533Jl8C/9awlBEORIFvuiTgepAcbAPJc6FLOf0lcW+ysSruKFN3S
        PsuDd88sWaZg/cvNjSlhfM5/C7OCs2K7DRf+h3bhUg==
X-Google-Smtp-Source: ABdhPJw5aM76WFjmDDyOL9TeukW7Mf/fOw5FAO4+TlinsywTJsmj1ixM8rwFnLpUN0ZgeCjGsCdVXrG4cXBF4EIpiZ8=
X-Received: by 2002:a19:770a:: with SMTP id s10mr771756lfc.652.1626985161051;
 Thu, 22 Jul 2021 13:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151100.2042139-1-arnd@kernel.org> <CANH7hM7nLq9LthNi=D9qHsiS_eyhU8-CGjnXhsKYX9dqTaOmNw@mail.gmail.com>
 <CAK8P3a27ii4fPvB8QA149g6ofWHazPGb9EZL_7M4z5ymkepVnw@mail.gmail.com>
In-Reply-To: <CAK8P3a27ii4fPvB8QA149g6ofWHazPGb9EZL_7M4z5ymkepVnw@mail.gmail.com>
From:   Bailey Forrest <bcf@google.com>
Date:   Thu, 22 Jul 2021 13:19:10 -0700
Message-ID: <CANH7hM48BEob2tiNO2-ZnJqTtJ2PwPFF3WZqkYqW3RcCBXwXGw@mail.gmail.com>
Subject: Re: [PATCH] gve: DQO: avoid unused variable warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catherine Sullivan <csully@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Sagi Shahar <sagis@google.com>,
        Jon Olson <jonolson@google.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure, feel free to just treat my patch as a bug report and send a different
> fix if you prefer to not have an inline function. This is usually the easiest
> way to get around the macro ignoring its arguments since the compiler
> does not warn for unused function arguments.

Okay, I will propose my own fix and send the patch hopefully today or tomorrow.
