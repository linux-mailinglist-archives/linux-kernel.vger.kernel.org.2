Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C63B4ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFZNxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:53:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B25C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 06:51:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q14so17520825eds.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8BednVfZNPeXesyJxP0kndhNa6NZwGUlsHO3tLnUb1A=;
        b=ot3Fem7NQbFJhFb3Kk3hkgGHr3lDV/wmetr416ZWKTs4/2iF5aJOhbDyiWJmG/jthk
         2LtB3vx/rqzkvrDC3DSG26/0SqDVhsTZN35MxgxDvDU6J1MIFHRCRWV8EXPkSKemPYaa
         QmMgKceVX+hgxntM5yT+A/3Q0drcmBYBiqNnm+eCp1o9rUAUqD0o3kwYFXKIdJTYa+tJ
         Yv20fbYdTkM5AhmWHd8TsoHP2VlszCJTbTuqOGBJfbyjhBKsFg8P+aoXQ9SpwDAqi9Qh
         lPulys8Y0PeFjPIqH+AdCGY+s4HGWl84hct2sLt/wxQoaXMNhgeudHh3mq4liUAnDe1u
         FAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8BednVfZNPeXesyJxP0kndhNa6NZwGUlsHO3tLnUb1A=;
        b=NSOWFb4Oik85nS/Jh4pAXe/i3Lu7Qm+wvQFq7wnY6uTURvadrJGivHIqbO5pH/7qNk
         FO2v0J/LZHkLrJVD8kOdRDgybYlHE5bDBZGJEEe6F6dHUqtW4xXGoPh+CzLCrUemgcNT
         5C97EuMguR7MDKqIYcQfoVGo2YyRhzInPxkKMV21QFr7Fb/0h8PiDBbDPe5xAiMAi5SD
         XGMuhhi1bNwqma5LsgzYsJsS4ZUlwIX5zX+/k2yg9kQQUtW+REM6zMjxdHTroy6erVko
         k7rsLQiPCx98ESALj5AtOe69RGx7O3SGVsrEFVaFpzt8Rcjbmv7Cl8rIn24zD6+/3JsY
         0TLQ==
X-Gm-Message-State: AOAM531Yf1TDj/i4puJdJZUjXwuz7LFYoOW4ogUXYwOqnFEEt+0XEHzr
        LHiCl+/bO9Dc0KYMYWvSbxoXM7fE1vKbvdl6Dh1udQ==
X-Google-Smtp-Source: ABdhPJzb1BsPsyoy+Fs6SEqpqYvZJm4S5TwFyzyFtuNYX6JK0a00CmizTrWVuq2yrwU0ixHX0kGfkXfYvKmSSdsTQ+s=
X-Received: by 2002:aa7:ce0c:: with SMTP id d12mr21912731edv.49.1624715483533;
 Sat, 26 Jun 2021 06:51:23 -0700 (PDT)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 26 Jun 2021 21:50:47 +0800
Message-ID: <CAFRkauB=0KwrJW19nJTTagdHhBR=V2R8YFWG3R3oVXt=rBRsqw@mail.gmail.com>
Subject: regulator: rtmv20: Wrong mask for strobe-polarity-high/vsync-polarity-high?
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiYuan,

In drivers/regulator/rtmv20-regulator.c

#define RTMV20_STROBEPOL_MASK   BIT(1)
#define RTMV20_VSYNPOL_MASK     BIT(1)

                { "richtek,strobe-polarity-high", 1, 0, 1, 1,
RTMV20_REG_LDCTRL2,
                        RTMV20_STROBEPOL_MASK },
                { "richtek,vsync-polarity-high", 1, 0, 1, 1, RTMV20_REG_LDCTRL2,
                        RTMV20_VSYNPOL_MASK },

Both "richtek,strobe-polarity-high" and "richtek,vsync-polarity-high"
read the same register with the same mask.
Looks like one of the register or mask definitions is wrong.
I think this needs to be double checked.

Regards,
Axel
