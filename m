Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572C13DF5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhHCTdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbhHCTdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:33:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAADEC061757;
        Tue,  3 Aug 2021 12:32:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hw6so123341ejc.10;
        Tue, 03 Aug 2021 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6aAs8+0bD6TLDZsc90toizQHtNCGpVqyhMdWMcDyPY=;
        b=HPyPjNAeb7f0hz2e/L+LyJRnNuFkerE+gU/ZS4zST7TQDJ6/nORmT2lVcAGki5Kv5i
         0zR1TMKG+4aRVzb0WlTCtnCR3wawppukodqi8rO46PwM9s9HqWSTtT8kcnTJz50DsyF1
         Y7V8ie+eiW0082wi6+9QA/KQmGg2t6RIZL1M/is9SYnpswB/e7QOVtU2gs8ztFNcVo+y
         fx2cVHgM3rDz7xmlsNegwYZXhqIF9+KlSZ1IKnVftuzz33rZiLwiYcJU+P9fXjjrDe8a
         h6hs1wzFqengVzv7mbXGYdIRe6PRgbcDOHtGn3dpv7RiEeK8fumhtkk06c22D9sZVS01
         G2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6aAs8+0bD6TLDZsc90toizQHtNCGpVqyhMdWMcDyPY=;
        b=TLgpdrxqrADavO9q5iY4hJY3Gh+x25cNUqpgeIakqvWgGZUSgtY1F9fnL7qDaZkPbF
         NO/spzniaGE9vkb/6YnO+FhrlDHVXFc7OsLzNs9hCeuud4XykCGrOgjIBO78i7KpSCox
         yhzLzbksXM0PVLAS8foWeYx2NCgRlOQS4Pmvzc6Vp7uGZp+PrhyVIYRcrrMc9nBbPDWy
         np6tZ0isWutXRJekP1FwevHsqoRB26FfbuvDwZEbTifokWPyjrUD0XOf3GZKvVTFZB8u
         u4uWkD9JFJUWDHZ+ZRo2QQV8JP281fm+JTPJl+EiGlOXKj7Z0Y8dw2XQ4iB9kBktF2ho
         1Zkw==
X-Gm-Message-State: AOAM533T++SAZsFrlQrqFyV2ZN7cRo6FAgqkfJ2Y7evxF6g1JDw1LBQ7
        G7oOI65sP6a1pv+P+1cIsu3TI72JO9MhuDFyzfq1AbIN
X-Google-Smtp-Source: ABdhPJzDlmmCxa1Gm7xSn9HFqX7zJVaujUZBMw7ldKjec3V1/92BHARi8ZJBRQErTbupEF340i97zEQbvJ8AOAB3yW0=
X-Received: by 2002:a17:906:6686:: with SMTP id z6mr22150785ejo.539.1628019172331;
 Tue, 03 Aug 2021 12:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Aug 2021 21:32:41 +0200
Message-ID: <CAFBinCDGHdqEDv4DA4QU9T2pmMS3GMSo_tJDzya=Uhcr8Fr5Uw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] clk: switch dividers to .determine_rate
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


On Sat, Jul 3, 2021 at 12:51 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> Martin Blumenstingl (6):
>   clk: divider: Implement and wire up .determine_rate by default
>   clk: imx: clk-divider-gate: Switch to clk_divider.determine_rate
Abel has already picked this patch (thanks!)

Can you please take the rest of the series (that is: patch 1 and patches 3-6)?
I can also re-send them if you prefer that.

Best regards,
Martin
