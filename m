Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E690E42DEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhJNP5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhJNP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:57:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581A1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:55:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so5076137pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nCjSrgHZmKOVAdrKCnmUBpdugUK0T0BY++sW/F6Q1jo=;
        b=aK8KU6bwWTdisuYtuFQyuEhM4tDiueBvfPud37Z7IBLRRvNGmoFkSb9IWCBeKGup/S
         S8T6JZ3m8e4c76oFVYz4+wqBfxSg7Esz0qiMhk77BRzNvIZ4E/7KGvS3BvaOMpr+HQeM
         rwu2dy7yl6nkFdM7oU3r9oBb5TOfOF4Nj+P/6mgZlOVm70JnHS1jDYZBqYO1IxjgNcOY
         z/Hlpn5O9FDrc0Yl+IfjCrlETo+ThsRRURqAh/gXuO22p7zjU3JTV8UFvZeT6ZlehHS3
         yU5N+I6Wld6ZgvtXVKrMPIAB2g9DuTbMw+5HlQsQ2AtzVExFO7QjZkKONlJc2uucIVih
         FrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nCjSrgHZmKOVAdrKCnmUBpdugUK0T0BY++sW/F6Q1jo=;
        b=L6zZC6vTgQ3wNWBy3bvVvlMj+fwBjGdcxwCKbhUp1/jCh6Ht0vEUfPRVNBDsk9QMca
         yYXEv1Lw/r0heV+7XxdGhu9/9xIFBRc8VjCQhmTFH457blKhmxgjrZGWHS6utzmSP6wl
         0Y/QV/1L/S0UwnxTljrAQrUGNy7pzyLIkpRonGiu9vhJyPw5nlaAzuTDgSGzdtm5Wsnc
         lCDPVItcWFUnI9TGU2LZBD+oXsjuHzcbWb8heHxgf7thIksEDKDUWvrDmKFORNtDG3VX
         Tg1jhHTqmoRK8ROuSxA/ZDIH7YMMgd1pBdx9427s1AEko4HBqiItDJCLMhnuSI4rUkkQ
         j21g==
X-Gm-Message-State: AOAM530ilBlvex4oT8VtsE6Gxp14Y/uhhvO+SeJ2pGbqSP5O5CEr3qlz
        e4G8SiujPepSjxEns1aBUIE7Ag==
X-Google-Smtp-Source: ABdhPJxF4Kv/p5cpUeU23MX/nRu6qLKglUBe8wOxSRaiAWh93w4jg2HGkhUAXoDVOS352Is40q1+7w==
X-Received: by 2002:a17:902:b583:b0:13d:e495:187a with SMTP id a3-20020a170902b58300b0013de495187amr5688436pls.9.1634226905538;
        Thu, 14 Oct 2021 08:55:05 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:1564:8387:11bc:4e82])
        by smtp.gmail.com with ESMTPSA id h1sm3058100pfh.183.2021.10.14.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:55:05 -0700 (PDT)
Date:   Thu, 14 Oct 2021 23:55:02 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Fei Shao <fshao@chromium.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] mailbox: mtk-cmdq: Fix local clock ID usage
Message-ID: <YWhS1qkwqkmwAyi8@google.com>
References: <20211014120352.1506321-1-fshao@chromium.org>
 <20211014120352.1506321-3-fshao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014120352.1506321-3-fshao@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 08:03:52PM +0800, Fei Shao wrote:
> In the probe function, the clock IDs were pointed to local variables
> which should only be used in the same code block, and any access to them
> after the probing stage becomes an use-after-free case.
> 
> Since there are only limited variants of the gce clock names so far, we
> can just declare them as static constants to fix the issue.
> 
> Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for
> mt8195")
> Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
