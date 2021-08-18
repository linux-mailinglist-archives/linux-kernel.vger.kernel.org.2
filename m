Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B23EFD12
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhHRGsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbhHRGsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:48:18 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E9C061764;
        Tue, 17 Aug 2021 23:47:44 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k65so3185763yba.13;
        Tue, 17 Aug 2021 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fIobYlmAUEQ+cWu8Nt94YkzjAjD9Udp6o8+WboS98Ek=;
        b=ZyzLAxocL4Wr+34i2qh3FN/60ikyQuGOT7sFgQjZKDyQ656FelU2odUTRCicp+fYid
         KrcHbezFt+lFUlmTafPQLStvV5nskdzxeX00pX0eexZMf9iGfSpyoHQq/xKV8KMZtnky
         ASLhFYja4iE0ew61bcK6hwVncq7vRTbQWpRTinNta0RRoYDmX+puNbQjilXVpIQ6mEZU
         RX0qbodkWFQ37hlQkE2IOkJ1js3JxyHW3ZyzgJ9JjFHBRXRX5s2VUNLWGQHlasv2GcDP
         6Vg9dNxSzz6Kt4sB/eYt8iufUP6kUIMxt7dlh8qsGn3qA7RmEZ2WQ6uJdaVC0/Pu9/0H
         CvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fIobYlmAUEQ+cWu8Nt94YkzjAjD9Udp6o8+WboS98Ek=;
        b=sEuD7NUkXqfE78bSffUIhxvI53zD3lCNpYAJVu7XDzKiZtQG5OSa5762e/Cx2keh3x
         rVdl8/yensYbZnuQd82iXCQwV7SIW1/+tBUCbdNgpHzkcBpklYn2CAf1/1AzLnBvUi4M
         fkhDo+cBMVt2fRuRp0Oy2McdONdRzR9iARv3oA3cqw8c+soDktXrxzXFWW5CWxsWnktW
         R9x/oAat+9+nRSMX1NVDMban03o5twE2mVejuL2q5Xt4mjgMKz1oWm4CpHxRmbGvcYju
         RrjMuHqv1zL4Kt6IX4Q90IZ/11vuDAdA2jDkxd2CfiaSb8V4uNo9LHpTj8XHyad1bVKT
         SuMw==
X-Gm-Message-State: AOAM5327G7E/wb1xJ5e2q4XphaZjkQ2F0AHR4wlfUSEOFsD/M3afW7u4
        y6B1fVpELaTa0PSBpYTdYhFA2OwyXfENIv82R4u3v1duEEk=
X-Google-Smtp-Source: ABdhPJzfLXhoqdw/1DW6cYiBYZj8gtpZVYOnlIySCNHNTHt6bdBg0idowOTnsmEWaxsIUvauDRq+/orIguf++cC6Xa8=
X-Received: by 2002:a25:b948:: with SMTP id s8mr9276071ybm.281.1629269263114;
 Tue, 17 Aug 2021 23:47:43 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 18 Aug 2021 08:47:37 +0200
Message-ID: <CAKXUXMwgWfX8+OvY0aCwRNukencwJERAZzU7p4eOLXQ2zv6rAg@mail.gmail.com>
Subject: Dependency of USB_DWC3_XILINX on ARCH_VERSAL
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Manish,

Commit 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
adds the config USB_DWC3_XILINX, which depends on the config
ARCH_VERSAL. However, the config ARCH_VERSAL is not defined in the
current mainline kernel repository.

Will a definition of ARCH_VERSAL follow eventually (soon?) for
mainline, is there just a further out-of-tree development for which
the dependency is useful or is this just a mistake and can be
corrected?

Best regards,

Lukas
