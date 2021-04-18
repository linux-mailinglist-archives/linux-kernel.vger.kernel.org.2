Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA936377E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 22:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhDRURH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 16:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhDRURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 16:17:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EC1C06174A;
        Sun, 18 Apr 2021 13:16:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o20so11934019edc.7;
        Sun, 18 Apr 2021 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vm1TuA39RV830rM/Py41JlCpY3m5T71EQqnbFk4N8Kc=;
        b=mm+zEQCSZczOVNYBvQy6LA1axst8NY0jpOSV1OrfIKRimKZwHhbuXlYY5ePoBzxaof
         sAPuWaCsA9sFaT8IhOz8WWDs3guTv2JGdbPpnzg+FRBZViwpcHxN0B7jLT1bGgO0aQDq
         lLW4CyAVLgQqyCyQcjMPlyM73GbonMgMNE80XBq+OwroJC8Yt6wS9MJ42xc5NPGVhBI9
         O9FSoCF2jcA0tpZwqlMjUF2e/jw+WxuI6ULGDpZ17PXJsCxVY6GOovVntEaVXQ+Fi+7q
         dMl2LV4ad95BcwwOdXl3CSX+3IgxRRbKioKZWD9Pu+xLj3yD7415dQRFQeLLwgZ9tZ8j
         eyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vm1TuA39RV830rM/Py41JlCpY3m5T71EQqnbFk4N8Kc=;
        b=TipRX4/5uJGW4ad3w4LvF/nlHWVGTbf6UJ+JU0edWoy2vbIBCaZrOn41Jqn20Gmbim
         1onWv8Io2ulyCJmMtTEpx002WL+49WS3utkBpDNmufeswE/a7yrPmMm86wKg3+oLNumR
         wes3PnlT+L1ZKFse2umUNAjjVH3Uj1+n6mExsUiyGh3pqHYLJ6zwLRPOL3kRhzOLeIIt
         CP54oCSHzOkwJAy6HHDAL6hmqoSupZuiw+0kBVPR3w7yOGS48ne4RCOU7XLvyU+YMhN6
         drAb3R531lMz+TbObWq1ifDi2IZEhCSGAGoZjJm5+gXwW9C//cmrC6DJglCbNk+fb+2D
         FswA==
X-Gm-Message-State: AOAM531aV7e46QfHW3KXdyia0jr9gKu0zmFMeRHwozqRrzA8gw7SZ9pu
        SR2b6RC/YYx1L9X7cFo+H926DDRSILouiKBEqIc=
X-Google-Smtp-Source: ABdhPJw1Bm+UXiVL+hXhIU6zHK7TADZXYP/7LDL9pFxaS+1Fu3pQYfoCxhsMo2xU1RdocGGa3Q4rFMPYTiIk3DyHxbQ=
X-Received: by 2002:a05:6402:54f:: with SMTP id i15mr22041465edx.365.1618776992766;
 Sun, 18 Apr 2021 13:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210407042609.9736-1-christianshewitt@gmail.com> <20210407042609.9736-4-christianshewitt@gmail.com>
In-Reply-To: <20210407042609.9736-4-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Apr 2021 22:16:21 +0200
Message-ID: <CAFBinCAhC6c-Q5Hhmb60TCeokJ805ep20WBCfzmctqxArS=eng@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson: add GPIO line names to ODROID N2/N2+
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hyeonki Hong <hhk7734@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 6:27 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> From: Hyeonki Hong <hhk7734@gmail.com>
>
> Add GPIO line-name identifiers to the ODROID N2/N2+ common dtsi.
>
> Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
