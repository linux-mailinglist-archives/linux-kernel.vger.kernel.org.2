Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8B39B3F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhFDHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFDHfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:35:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AEEC061760
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 00:33:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w15so10325714ljo.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YEaYtGaODGYMRIOcxS82MgtLU/f7MT+ye6QOtsBBwM=;
        b=k0mfwg8RuZBC4VJUPvNHCgyWwdddHYCNtROCMCMUBKNkg9GnTz1wsdRCtp3u+JpX8s
         Bd8xiqdEg1/0d9t6/72HrB9QHSHJg4NgvzI4oxxKIKxoqWRAxXXiT8rID6nOgqDgpb77
         nI4Nkk6iHy0UP7tmIK+o2aZRaOG9YLUCBNyiW2cc56DLMg4dV+LX68pnjHRxNQjv/j+Q
         MC1EW8XWXWCjv3ZxH+FecZEPtv+Uzy/ZOboD0dj8cxd1PpzSD9LTpGKGdPkvKG3rcMSr
         QV2nuWASQJLxcQUXCNBvDyZuQT8200MzPiFcR1nVDOCEIXGK5DM7CGTYxqw4zW6zRs62
         eStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YEaYtGaODGYMRIOcxS82MgtLU/f7MT+ye6QOtsBBwM=;
        b=KxJQVudYZEyvLA6SZeEE5+C4OqFRFRe3Y50U2ijo4Kr8n5Crb6aSY/sBkiDy2tfzyg
         pZA49q4rnRXxEs64zm/DKh2bwsrGJOuvi7UGCq20fU3xq9sLWF+f2q/syLe27wiK5NYP
         nITEJ0NioitOhBrs4nwz9ZMJtp4BbzHevO8kFEHXAlq996YkRWumfhJzVz0w3mx482NL
         sb03QbDcVMJVvLVjodFQmldtrPcjlLDQV3Z3XT3yPYxeAfqYw0uQ9eBxzwlxv7LVhNz0
         jhf4ZkGm59x76UI2XyKqI4h7Nmq+hBF4A8QLVj4C+Q6kJPTXugGdhgECXl2tmTAN9usw
         tw6w==
X-Gm-Message-State: AOAM530aN2Xh4DpcepXkwgFq5bwuDHJsDiFkgn5JxMuN2wBpGv7PKOjD
        +U3WMSWyGU2I8hNVEbKBjlix6qTFi5zVcGAWUHFJPg==
X-Google-Smtp-Source: ABdhPJzgQx04zTlqpg/w82uH4e5VzZHYhg4xdsMgMS13UjBF/oq1+Otkde9ea6/c7c/a5OlXYTJg5cz4/ByP7q5md3E=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr2515456ljg.368.1622791984619;
 Fri, 04 Jun 2021 00:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210603043726.3793876-1-dmitry.torokhov@gmail.com> <20210603043726.3793876-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20210603043726.3793876-4-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:32:53 +0200
Message-ID: <CACRpkdZWkV6Uq98VjGMFp+EaoM8gZ_FYWF88PoRbwTjnGFcJfg@mail.gmail.com>
Subject: Re: [PATCH 4/7] Input: cy8ctmg110_ts - let I2C core configure wake interrupt
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 6:37 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I2C core already configures interrupt as wakeup source when device is
> registered using I2C_CLIENT_WAKE flag, so let's rely on it instead of
> configuring it ourselves.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I wonder how many bugs of this deep semantic type we have in the kernel :/

Yours,
Linus Walleij
