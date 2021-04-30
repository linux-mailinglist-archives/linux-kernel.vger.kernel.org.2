Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EAC3702BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhD3VNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhD3VNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:13:22 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF920C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:12:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a11so16671838ioo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcgEFKNCdnw42RIDsezljjhLnXK1qfiVCOOOweDYBlI=;
        b=eohrjV0GyDvZLNvHWpUDMAY8Uvpi+r+aZ9OIo2Va8CZqkCppfDp2HyuI/SsMFlv/A9
         3t9wsz3op5E23cdblkz0r+Hjs8Dnmt7nZiz1ioMLhIQLzLeZa3Q5nkiYCg38HoBlEzQI
         qRxNQLYaUyXy449HxxYJrj8I7sMbwL6dagtKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcgEFKNCdnw42RIDsezljjhLnXK1qfiVCOOOweDYBlI=;
        b=o7paMqNyKQ1JyP5YakOEZA5ZwkwwkMq8sC0P3V1J0HJvCmFwvUBsJDo+S/kq/4UlNs
         5m33uSuslh8bODOE2ETqbZcxqJUsPlV9QXAhceukTBU9061X0xRoQwFu+x25s+T1UP6m
         YnBkO42Ru1uRGEQ5Yx0xV50ArjkEqeNaf6wD7tzbS+wUIqQJPB4OEdsdPGbv6Cez869E
         43wclIQn+xToFrQECygaYh8YFbWBqdASrO+tcGmlXNxvSBBcH1CSHKfJPM2RXU3gqez3
         HnDMlQhb0UAPU46NYN0K4STeT4VKE5KWm7z/OFw3GpDVVBNjYYkqKLqYutYf5evkE8jw
         DTQg==
X-Gm-Message-State: AOAM531tRd6qZ4tuZzX3zvrz9Z1CDzW75het2i+76659Cc89IMuygzE5
        XYRvb4dFTSEXj6Xc24NisVlg+FgTSxMiRaOeMf0ytg==
X-Google-Smtp-Source: ABdhPJyYs89DRFVo91HEXLB1tGBFG5INxqSWzmI18cw6jcElxNQlRe/4OGx1ze4NTem+KSY4uP7wzeJ5BdmZDPIlQe0=
X-Received: by 2002:a02:cab3:: with SMTP id e19mr5933863jap.64.1619817152185;
 Fri, 30 Apr 2021 14:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210326035035.3057800-1-jwerner@chromium.org>
 <CAODwPW_rdHnkKuAhCxbF9Lb3bPvAKR54G1wowFGyoDQ_sp-3Cg@mail.gmail.com> <3cf12c9eae59e4014865866529e580d7d0ede020.camel@perches.com>
In-Reply-To: <3cf12c9eae59e4014865866529e580d7d0ede020.camel@perches.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 30 Apr 2021 14:12:20 -0700
Message-ID: <CAODwPW_5gMmo8p6Amp=+u41=m2nPTQSgf2uTE1pvo8_KKnjGTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Detect suspicious indentation after conditional
To:     Joe Perches <joe@perches.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Ivo Sieben <meltedpianoman@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*another friendly ping*

Hi Andy, any comments?

Joe, if Andy doesn't have time to look at this anymore at the moment
(if I'm looking for this right I think the last mail from him I can
find on LKML was in 2019?), is there anything else I can do to
convince you to take this series?
