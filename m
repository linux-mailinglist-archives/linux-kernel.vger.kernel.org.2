Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5197376AE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhEGT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhEGT6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:58:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D6C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 12:57:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n16so5815660plf.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIAfCugvv6DirQSOC8Meh100tr5jk83OTp42czR55xU=;
        b=PYWbUgy/7guKQxkZCsOb5rWv0hyfvGf5JhVAeuu0AQvD0doZk6RvnW+Gg5uf1FDYsx
         AH/QnsVCrKgj2xiz+b4qzbuA74E67z7lRcgVciDIYE6VD7rwoYXc+d1DCxtUnNtzto86
         MkAQJz/4YdUX3xahIKFkOSY8wSsXPwhgSwMEjgt3N49+2vmYOdvrS5wThkuEqKlI+iY8
         fKZq9STvVxdflWMsFuSygBxxEMyOtF8EwiylWV4torqaTRoQwERAoNdYmTCg6k8nGMO6
         0zKbou5rO9PToGyxiahdKXDdqfubCm9bcsPpt6e6cjM7scpXoRUyTy2fZ/9UzG+Lga99
         i6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIAfCugvv6DirQSOC8Meh100tr5jk83OTp42czR55xU=;
        b=tDm3W/nvrGqY2+M/cY5LHOxfX/VYL/g8NKAVBPGMpoKZ+3RqtxfkyS4ki0PH5AqNRN
         kzrd0S/VPl+RbN6fgklhGBmbjYfIvM9zZFfy0nIkzYBL9epQ1D68XFBPSkmde6x0dt5I
         xIKyHqCmv/Ipopb24XkL9oTo+h9h9QgFDyTKgJL6t/Y/TBbIxno1mEbiRYmRzoDWavBX
         Snj02z1WE+Hmo+ogPypXcWeUsYOEkAw/5wtU9i82i7ZQIDh+K5lItwagEmT53ncD6i5h
         aQgUWktHSwSJrcgPyZkmSTrcuDWDtjODTIppdsYmgUKRQagFk0VOSiQ1XIdoxGtMXuJr
         FEPg==
X-Gm-Message-State: AOAM533doUIW65SWeNatl11VKxLHIMbTw5pQv7rZ5ISTLGXUML1WqiC/
        Cl3j48PYyDNjMXIj2oI64YuL8xMSY0iy7MK8pmn8YQ==
X-Google-Smtp-Source: ABdhPJz9wKX5WGS2h0k3XqhaJYqzyGFcZaZ4Q33Hno1JgZWxJwPRA4R0mdpWPLYUI4JNiIFvQg7KyW+HguEjm3YtvWU=
X-Received: by 2002:a17:90a:7306:: with SMTP id m6mr25318877pjk.217.1620417451576;
 Fri, 07 May 2021 12:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210506205419.26294-1-zev@bewilderbeest.net>
In-Reply-To: <20210506205419.26294-1-zev@bewilderbeest.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 7 May 2021 12:57:20 -0700
Message-ID: <CAFd5g46TEFLWdBN80RxGwZfoyD-70C0pP59mhrynvD5ODd2wrg@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: aspeed: disable additional device addresses on ast2[56]xx
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 1:54 PM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> The ast25xx and ast26xx have, respectively, two and three configurable
> slave device addresses to the ast24xx's one.  We only support using
> one at a time, but the others may come up in an indeterminate state
> depending on hardware/bootloader behavior, so we need to make sure we
> disable them so as to avoid ending up with phantom devices on the bus.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Looks great! No concerns from me.

Nevertheless, I am not in a position to test this at this time. Joel,
or Andrew could one of you (or someone else on the mailing list) test
this?

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
