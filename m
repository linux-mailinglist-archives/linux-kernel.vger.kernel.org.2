Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2445375465
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhEFNGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhEFNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:06:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504B5C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:05:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x20so7690828lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuRMg/p3XcDliVBSgwL/6V4gjxClpTJd4DW+g4l8Xng=;
        b=tY+IThXQYOpe6FQ492ndMN8tzQu2mNCijbG2rwp5heuJDJq5LUmUtVtReXzJpH+u7F
         p//mzGeN8KObivJXyDIhwX04m3RygLMWCBcV3bL04diWQjaKe5uDGfWjQlVQ/3qg1rMV
         Gd2kZhwaJIzAwLAMLSpY1dl54VDQymjcVxOvD2QWyHTiRueiwbz9cO6cbPPKXkSqtFZp
         iVK8Q3/btQM5gDAy6LlvIT9swLzP+qARz3ioMeduP3rMplhFgP7c80zm5Woclb0+7BcQ
         TT/vKeT+F/0svsfArijPMxaGvAlBTlVN01DMxcl2qh9LyPH0ovQ91xgI1nySphIM1z1u
         oicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuRMg/p3XcDliVBSgwL/6V4gjxClpTJd4DW+g4l8Xng=;
        b=OPGqs+uC8wgYxHW3mIAH70Bk5YAx/jGxQke0G8E2bLFG13bgVu/Q3zn+RDRwFsQ0Fj
         6zCwelfosUunIfDM6qfhC4b0pPeHbaHxS4gfsGuYbJ8tGauq2MLki1sLL3L7zuVlojDM
         PgnfzfzBupPMGhH6+lAuGDlCarFfPip89xgglFKpJ+ndYz+tPxi8sFJlEt0roowgBRJY
         CSyvvf8UX+l7RlY5ft82wRllCmw1byr3T7MHyPE8piSdbvECCkQlmq+c1N1cJIdRXq4I
         izfMjrNUp6ztSGiUEOobzHMvsmDcGcyxfAG7saUmPzA8an13yDfH/h372WhC9u+enroz
         C02Q==
X-Gm-Message-State: AOAM5318u4eMfRQGrgiBaFrpwk/DmiuPw032SX8cyRy1Nt5NqVGRt8aT
        Vq3u8d19ttabGOOERrdZWgi1XC+EX+ohfPdteXtezw==
X-Google-Smtp-Source: ABdhPJyUGRSu7ce4hdQJtL6n62WTj9npsWK0hdYAHjTMtnVkF0ZjJGViA4xhHzR1vUmUsDTkrNKtph4dSkX1R94xwPg=
X-Received: by 2002:a05:6512:6d5:: with SMTP id u21mr2857313lff.586.1620306313768;
 Thu, 06 May 2021 06:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-11-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-11-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:05:02 +0200
Message-ID: <CACRpkdaUVx3mRkTbRki1vXDpP7Cjvj_tYiR0iefjjX6=uGeDfA@mail.gmail.com>
Subject: Re: [PATCH 10/11] mmc: core: Read performance enhancements registers
 for SD cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> In SD spec v6.x the SD function extension registers for performance
> enhancements were introduced. These registers let the SD card announce
> supports for various performance related features, like "self-maintenance",
> "cache" and "command queuing".
>
> Let's extend the parsing of SD function extension registers and store the
> information in the struct mmc_card. This prepares for subsequent changes to
> implement the complete support for new the performance enhancement
> features.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
