Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2E3462CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhCWP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhCWP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:27:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A5C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:27:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r17so12064046pgi.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+q4ajk+mvriJOj6DX/n/ZppGdC7koRzzrZpC32hPb3Q=;
        b=umzKhAGs1TMWIaaMArXgz4HWGd/SlOHR91fZHJqErP1IZAqWCknAXyfkhvQwxr+CFG
         uUeWBmfrmfypfND2jZZwXWZ8VfRDj2gbxvZB9hz52yWYdB+Brv5QUT8jUwm9erPKgGzy
         RZ76bM+1XpE5J6QARiRt1AtJCh4fyTZF9d6mVMqB94sIPYX6eGMHmq/xQYIKkMAjKNZK
         GnZX3oUX+Md3fAWSpfkoLrxkBiVpxvumEWTeSo0QxPFknlF3BMG7S7zOZngEoBSRPhvK
         WN2/jLF3Mi0LI6LMU0sFpi5NLhV6Yk/hIlnQKaULLT2i5BRYgORqCT84wMbigyKf4J8R
         50wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+q4ajk+mvriJOj6DX/n/ZppGdC7koRzzrZpC32hPb3Q=;
        b=lGQQK617I2O1CXWljKzeYJBpN7fRzyjVaN/AcDcaU9tRBB+6porb24E0FDSCyA9G9M
         q1kAzBw7ngkHjjqLrOkn7igBud6+LJCehFTn705EvA2nBFr8TZ0vXSEX0yiMKgw7YKvH
         fr0r6o0C1+ruVxv12/b3apDamXqkm41PDtKEO2QEFj/odREgw/14jlCa+3f54PAGZoRp
         BIpNOObWYswRTWF8wfv79OFVEJG3fT74L6d/O0fjYxskKJXnEET8r6dznciWNgfG+qr3
         ZYvPvtpb2l3aemUwKWmhBCUfmINDh6vm8Zn073+WNlKnUmlVUbnYLsA6xKevV8msxm53
         +ezg==
X-Gm-Message-State: AOAM532vst9CpLEwAjNFew8hkqcX+Of+pKcx6jLakb5DGtbEf2Bmdqqq
        lYYYGwcYg5V+AXWzMF4zCbahh3Sadm7B9C4QPzFo8A==
X-Google-Smtp-Source: ABdhPJx2bftmnq7RHCX1El68uj6CuWJqbapCMo07V7M2E2AXoSLaInK7xzowbUr30s36j58NS2yVvPTVFaZebu6Z4cs=
X-Received: by 2002:aa7:980a:0:b029:20c:5402:5de9 with SMTP id
 e10-20020aa7980a0000b029020c54025de9mr5130024pfl.18.1616513242364; Tue, 23
 Mar 2021 08:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
 <20210308120555.252524-3-adrien.grassein@gmail.com> <CAG3jFytoE9hWvq2e2Caqn4qP_RuEOnm4r9VQ85ffbAcguSLf+w@mail.gmail.com>
 <CABkfQAGvPy3DzXQnDJqm1q_rOLWR7BQTXb8z05iML3s3Mc8LJw@mail.gmail.com>
 <CAG3jFytmJSjvWp0Bu7MaJ7EVuJov8gbs6cguatoOtTJpXTGVLA@mail.gmail.com>
 <CABkfQAGcSsQ74FtvAK4_awHRXswgBrThKww_xhpmTzordZ5X8w@mail.gmail.com>
 <CAG3jFyvQt=Bv2_Hi8UdOhgznp1gVZwAw8gZv6FnLwHJV4WD6Kw@mail.gmail.com>
 <CABkfQAGS24AM90veQhGA+=V4S50y7JwzqLMspMaEFptcYpmdMQ@mail.gmail.com> <CAG3jFytY26tdktwE+iorKjM1EDsdAFxo9MBhxsJHoCNLSRsM_g@mail.gmail.com>
In-Reply-To: <CAG3jFytY26tdktwE+iorKjM1EDsdAFxo9MBhxsJHoCNLSRsM_g@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 23 Mar 2021 16:27:11 +0100
Message-ID: <CAG3jFyvMpO9YNCB=qZgHovU9=zT0s1S3jNoeYoj0YkpQAjh5Rg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: Introduce LT8912B DSI to HDMI bridge
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I think the best way forward is to remove the polled HPD support.
Don't forget to update flags and function pointers.

With that, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
