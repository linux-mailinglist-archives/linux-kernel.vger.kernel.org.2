Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2565439EE7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFHGDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHGDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:03:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9AC061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 23:01:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z26so14887888pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mInCAkdFNsOSgJMQOvgFddBhxgTbOx+8STgtkOSwHpk=;
        b=MegiSZB/fHn0KVkgcSc/ACKJJ4i2H1+sYXZFerjV9FVLN1r438LmfWmr16AfFtkvCl
         0QX38v5wOvEbTZRG0BsFhmu7uowF5siG7gyw8/wjnk2fvJn8NPq6mNCygDcSA1Hbsmpc
         6BA2ywt3MoVceOiIXST1tMwT3CGC4SACmhbgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mInCAkdFNsOSgJMQOvgFddBhxgTbOx+8STgtkOSwHpk=;
        b=kepXAYZPBSmtIu5vUIBXrJLu8pk1VmL7tneROhH4LfBQEmBXRAy9IDYDNxDztae3vk
         I7q7ZE63H3KCoVm2ckBlmgHmZUMmJvD77NdV3CCzgz1R0tdSP2OlAEb/LdhxC77b+85S
         RO3gUF4XA1ZAuQSKUAUqlr6Wm9B75Bx9j2VOTRDvP8do10yjAzgW9Kxgc/tK1Gza1f8y
         QlUlmq0puneNkgsYpjf1Ob+bJBHhtq8KU6sljG9higvRbwa8yx9j+l5sq4nEWuBbdkIt
         gsacc+th+XfrXQM9a6kaOLwr88zX8JBNAySKV15iQdSOqtOtuLtiZNXoT9TyPaRgePlZ
         YyLw==
X-Gm-Message-State: AOAM531zexvyg6HIoui7k/TYi5gsPE0JYjdzomKgVl2ZTr2oUEgt65Zs
        IIXXUtjZ25syhH/cOPH2odRG93D9lgWcp6/hpyToM4oAdvCRKg==
X-Google-Smtp-Source: ABdhPJxgmdNOCZs3zYNAq0l3AecgoflIwtcOva4dsMFDzA70fejHEsL+2Yow29I7OpW+gdUpJ/Y/JHRZ5XrXjjl7YmA=
X-Received: by 2002:a63:7f1d:: with SMTP id a29mr16163327pgd.69.1623132091439;
 Mon, 07 Jun 2021 23:01:31 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 8 Jun 2021 08:01:20 +0200
Message-ID: <CAOf5uwnZvJWhwf=h8nx=MmZz4BOyaq_BTr8vyDcGHqnBO7jK1Q@mail.gmail.com>
Subject: RFC power domain vs generic supply regulator
To:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm trying to understand how to deal with devices that do not provide
a supply handle connection using the device tree, or if there is a
generic way
to connect to a regulator. The pinctrl has a generic binding inside
dd.c that allow to mux pinout during probing or it allows to define a
power domain,
According to the code I read the power domain can be only connected to
the SoC power domain but in general a generic power domain can be
connected
to any source aka a regulator. For example and spi-nor can be powered
but a gpio regulator or any kind of supply connection and bunch of
devices
can just need a supply if they are probed or binded runtime. Can
someone give me feedback on this topic?

Michael
