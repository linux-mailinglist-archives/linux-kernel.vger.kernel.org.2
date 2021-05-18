Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB278388137
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhERUSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhERUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:18:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23CCC061573;
        Tue, 18 May 2021 13:17:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lg14so16548002ejb.9;
        Tue, 18 May 2021 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3J8CL4Kku/3J5MKdzSmZWuexbF26F3wECGjeGWRhKg=;
        b=fpfMiAu3isF6LHOLZkGWFknEu73N1fOnorzRPQi69EwtY+NAlrj/NB445vlcmtch0S
         RGYIlkgb+m9NDCZ8M32vV+A3W0iOGRN66/5MTZPEujvmG7bHtHcxFbWS9r30dic7oYwe
         /EC56S38OG7FrxkvNZl3jg070wgVTEpQu+QHVSYM0vhLhhnf1a0M0ZZQZUtDQus9OXB1
         nxYClaFZfS+m6H5Na40RxPAbDFeCRpFpDuldg9M8DotbUBFwsmzfIee38Q6Kr2spdx/t
         PPgENtlj2R90cXOgXz+MB7PdjBNX6BFl+PNozHo+G9kpOL14fU+EM2c0j/1gP9py4Wsr
         6ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3J8CL4Kku/3J5MKdzSmZWuexbF26F3wECGjeGWRhKg=;
        b=NWIHXVdyXwgp6xEoxQ7fSAC8WrN7t6M3FOuepydWLZlQh3JAIaBHEO9a52bDiBbMSt
         GXs5yhrlZgxSUU1feRndVYhjeurXdM+/XelQeZKf0eY9cufXJXv0Cf4kXJTkGApCW9TY
         5U8/ZWNOyAZnDdNTYaSCE1pPWJqUd634Czs99oZTj/8tJs3PyMRZrkUfZSTt7rI0M9ch
         2hEfIZR6NZ4o5z9ivE+53RqKXUHEWSbEqim+4hX70UZDh0pcLyOQe8xEerlrKKWS/S9N
         ax0jLY/ySHIHqIkY57/IhWtjjnJmtVJx68V4JBnNuvQwXeT3j5v0iMYjhY95iWyqU06C
         7dRQ==
X-Gm-Message-State: AOAM530us9NPeK6dq82AbcICDHa6Y0vmSB6U+dJzZZiKiMgPVs1+laR4
        H0UxAt4hWyIN6YnKSXHTXxutDPdLzQI4StSkFOY=
X-Google-Smtp-Source: ABdhPJzsMxFuu/rnJeQroifD1yPbnbttaZmc4s+1erBEeCemW50Kj4x36wY/D+9J7SnHhJWCj0D/54S5QXfthG2Tfhs=
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr7864716ejh.172.1621369050674;
 Tue, 18 May 2021 13:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203724.1006254-1-martin.blumenstingl@googlemail.com>
 <20210517203724.1006254-4-martin.blumenstingl@googlemail.com> <1jo8d81nw3.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jo8d81nw3.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 18 May 2021 22:17:19 +0200
Message-ID: <CAFBinCBREyEp0gj_-ac2OccjSruULPG1m2=L5D7GEA4HoqQqLg@mail.gmail.com>
Subject: Re: [PATCH RFC v1 3/3] clk: meson: pll: switch to determine_rate for
 the PLL ops
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, May 18, 2021 at 9:50 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 17 May 2021 at 22:37, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > This increases the maxmium supported frequency on 32-bit systems from
> > 2^31 (signed long as used by clk_ops.round_rate, maximum value:
> > approx. 2.14GHz) to 2^32 (unsigned long as used by
> > clk_ops.determine_rate, maximum value: approx. 4.29GHz).
> > On Meson8/8b/8m2 the HDMI PLL and it's OD (post-dividers) are
> > capable of running at up to 2.97GHz. So switch the divider
> > implementation in clk-regmap to clk_ops.determine_rate to support these
> > higher frequencies on 32-bit systems.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Looks good. I see no reason to keep this one as RFC.
Great, thanks for checking!

> I can take it directly if this is OK with you ?
That would be amazing.
Obviously no objections from my side :-)


Best regards,
Martin
