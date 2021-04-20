Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E66365E45
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhDTRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhDTRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:12:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC820C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:12:05 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u8so29150850qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYRqF4CHPCCN117xwzw8BkK9BpE5HcxJRT8xDh3fal0=;
        b=DdlrJegkSCSy9AsWRXtdsRvZe4HeZHOa1vzaISWjF8o8KW32U39DYIzW7yw32fxRx2
         AX62bDW245Cmonky4OcfyMBykKbqbt3C3oAdohiDLYDKIa5OwvCJv7FaapcMe4LCqrcB
         aUd2lm7tqHdrzP0Fy8msoQiaEdvQr/iPd9GcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYRqF4CHPCCN117xwzw8BkK9BpE5HcxJRT8xDh3fal0=;
        b=SWha0JgV6EeAY9qrkug+pMO6t12eIwiQKpo4M5hifJnaYoBjkyqaBy+0Ppy7jCPhQA
         7sEWuAh6afCjyw2aH8TYJoosRqkusm7PIkMERjoQX/r9CPubxRJJF4lyPl8vlq1hlgjh
         xB49CsY516trd5bWGj7TkT9n+ByypIKpA5YCZbjVvXe9KIvVXhmVzp7qXlEVVcTOA/Pu
         uJj4LV1WfHvd8EzbNxw/GWktCVbaoopcDsQn6rcKIU7kieK25+vxuAn95COXtxl0VcOL
         HT8DpzA/K3vdPA4G/pTPAEcu0KfXAzJ5kyMil0JN1QK8kUXnlJgNxbOGby9tDISZfsDE
         q0Hw==
X-Gm-Message-State: AOAM532d/o1zZFn3nYtAhxsSmo5FULkQfSlfek+WOER3RH7laFKf1IUf
        C6vE7aXOlBoauEeeITtPjnYqn2irD87xiswhi4mJHw==
X-Google-Smtp-Source: ABdhPJzG+BkNtdjZXJlAyMBT0l/xNAejtnCOnIJEjUGHksRXE8u0W20/sODV76lxa9JYaqf3TnBN7GJnXzOlBXo2sfA=
X-Received: by 2002:a05:622a:1044:: with SMTP id f4mr18398911qte.224.1618938724951;
 Tue, 20 Apr 2021 10:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210416182739.2938473-1-pmalani@chromium.org> <172e5982-5544-7170-4c88-95e196e28fac@collabora.com>
In-Reply-To: <172e5982-5544-7170-4c88-95e196e28fac@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 20 Apr 2021 10:11:53 -0700
Message-ID: <CACeCKafNfDZzXM72PdzCO5FTK4YKV-bkhJ=nR=+R_gszGoY4Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: Add Type C hard reset
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Apr 20, 2021 at 3:00 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 16/4/21 20:27, Prashant Malani wrote:
> > Update the EC command header to include the new event bit. This bit
> > is included in the latest version of the Chrome EC headers[1].
> >
> > [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h
> >
> > Change-Id: I52a36e725d945665814d4e59ddd1e76a3692db9f
>
> Please remember to remove the ChromeOS specific tags and add properly the Signed-off
Sorry, missed this. Will send another version.
