Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE473B72EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhF2NHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhF2NHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:07:41 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB5C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t80so4705099oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEV/WRF0Y0ujX/WfxQA0NcsIjvbaet/AXkvfL06Fxro=;
        b=Fu7/abfpV6kGILaO1P8/3DbMiuH5lUgY6AXOOuHwB9qMXmA6bB2cxMLthLx6wCwyd8
         I8BTv7O1FzKvqYDTWbMO2hHn7ztrhhm5vjk6VSDIDR+zjwosu4eZ0+mx3sm4KLPgPj6C
         D8PlzwaEte7Tt3Y0zVmLOBdcF7jKLL9Kajy6L2MWft4T0zAbXP2gvdytbmigqkk38KE4
         i7t9t26AsiaRZTsUkznZ9O+SwA2TTX6fyBdAQI+wgDg/hqD8g1mEFCTVVMYOgrNYvq/2
         IMtZoPb0mSSe4OZGg5UjNVsMcs4uKEE5vQlmJdNKUhc/WcKEHt13MBAQXZSA6h8u/wiG
         oiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEV/WRF0Y0ujX/WfxQA0NcsIjvbaet/AXkvfL06Fxro=;
        b=tqi4OiEY7b4u61vzqntaknW7Pe7uafi5fjL1sMfiLdpZ8VyhR2YULMLFAcHmhrnaVO
         vuNfW8E9ObZNesx8xWIH6cElwb/odHhQWcjumWWsI4dKInxcmZ3L5ANp8kVaxAcukHAL
         F5Y58h4Ud3xG7EpOZpAepw3B3CJQPamSHz9DjilPZLBeHkaa75jDhOEnkDb6nS46Wcug
         9lDaX/fTIRvOxhgQ4PxVw5QVVHtpwj5378bemR1DhdrFd7wDLz7R8sa16TCV8eKY8Owb
         1je4BgDM0miMjnXAMSptg17pkB+Ml7QTw6cko4B9xCSlOUIeCBk2/yCTCz+/DFJ91FaE
         s/qg==
X-Gm-Message-State: AOAM531PkJE1nFU3K/F9qAHoZLg12IB/3bdZz4dqvWL5vDBJFdCa+ufi
        4Don8QP663FfIBy0KwdwLKfpF1Ft7qUi3YZmLzldDw==
X-Google-Smtp-Source: ABdhPJwn6TCJ6i41XF6zt8tugLcu+tQNibbvlhwV6CqK+CCWRGK+s7Fb13zbr/iDARVi/nPlFWoR/Mdn8UsLbL2H+M4=
X-Received: by 2002:a05:6808:bd5:: with SMTP id o21mr21256488oik.172.1624971912663;
 Tue, 29 Jun 2021 06:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210629130048.820142-1-glider@google.com>
In-Reply-To: <20210629130048.820142-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 29 Jun 2021 15:05:00 +0200
Message-ID: <CANpmjNN35j2Sf17TMqpOVZZv2N6ELzBZOsG5-jpFoPvgfuVzFA@mail.gmail.com>
Subject: Re: [PATCH] kfence: skip DMA allocations
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 at 15:00, Alexander Potapenko <glider@google.com> wrote:
[...]
> +       /*
> +        * Skip DMA allocations. These must reside in the low memory, which we
> +        * cannot guarantee.
> +        */
> +       if (flags & (__GFP_DMA | __GFP_DMA32) ||

I think we want braces around "flags & (...)", so that this becomes:

    if ((flags & (...)) ||

> +           (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
> +               return NULL;

Thanks,
-- Marco
