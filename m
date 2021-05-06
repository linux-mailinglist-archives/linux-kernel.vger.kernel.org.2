Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A48A375211
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhEFKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhEFKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:12:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA2C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:11:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 124so7001290lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjt/PedpEOJa3E0RgEs++V+fav/jIuCVCpWGGx6YsQ8=;
        b=H3j+3NXYNvdDsJwG8XlGkTZjPamz3UqSdmWigFRpKnB+5oGsFEuyBg0jR97JKCtGb3
         XYOQBBJLUWyT84gjNyxak/LV94zBQV/C01DDp8R3wPLr3dlwsYLkgpdbWBbL8tcPaxKc
         uUfYNRVuXoMZ0++5JfjUWepScgKARhZuDuRocZNqkdbzfuyWF//kogLPcpWyIQ82h4Qv
         4RzRQhY+htMc1aYJLmcgydETvqxUGAeO0dLlJ/h6fzyKU1IGkXqEu/rX/QxwLdDATmao
         Mer5fG6bm8e0oxWcLO04u1QdJEwcPXrjT09KL/65VPZOiL4C2cF3HQlB8i69hlNSl8ZE
         CRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjt/PedpEOJa3E0RgEs++V+fav/jIuCVCpWGGx6YsQ8=;
        b=H8yU1cEiPo28uqfDJd6JNI+TwEe8i3usukMN/ovpnqdP0uHLDMQgOmpr+3Wo2kViAB
         QRQrWRyBpPzIaNktKNifz9IALgGy3R/Gvm4sfD9zw3UvTm08mx7MOzW63FyLff8we3fp
         VBQ6NswNp9L50xRT7yJh/0GFPOR1pgrr0bWkM6SJDznSzYbBKjmlTl90GxukNQfrRznm
         3AxDi3HrMx5C2weWQMAzqjREqkE2uhB1tfwYNQ7SXd9++xpewRzNnxU+Xf5MqXycZxpH
         omKjt6ct2flFJKwMJFGEPGWS1QANeylDwM09EZAUzB3DMXR5oub9BCM4vYiWnNzQI23n
         BA3Q==
X-Gm-Message-State: AOAM530wepXbPSl/4fby79rOj241bw4wj/G/eU0iHZkpIj1nu38urBrM
        oDcpNQbMY3hcEFodvZE22FdUgBfzjC/7wCQjQq+cNw==
X-Google-Smtp-Source: ABdhPJx3Ehbj1JdGRSwQy0JowCkRq/FTV/Mo6Q+NCIY8hZFvXtSSAurF1rVBfVVjR/S7rsaSrw3NzA3uoqrjmEyU9Fo=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr2343035lfn.465.1620295911961;
 Thu, 06 May 2021 03:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210416114205.16469-1-clabbe@baylibre.com>
In-Reply-To: <20210416114205.16469-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 12:11:40 +0200
Message-ID: <CACRpkdaGb1j=mMRd43hSTLFbSEeW4q+eQNU24AdCk+X3UUQsqA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: gemini: add missing dts pattern
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 1:42 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> The MAINTAINERS entry for cortina/gemini miss all dts of this platform.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied!

Yours,
Linus Walleij
