Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0FF41855C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 03:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhIZBRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 21:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhIZBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 21:17:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38BC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 18:15:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a13so13307235qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5GR1cfMpuWQbSaXT73937ELZ/sCiVavLQIUW7HngfM=;
        b=dluCVlL5cvwzJcvAB3nBshLLzL3Ac9WzKg5H7+/uFJmxtYTQScRYyt0WrCc8ef5xnx
         VdDae+eJVVNRZSndQMkX9KpiAQR5IagrSzdSKkd6T0q4p4B3rx/Jq9nLDK5oJIhIPHfb
         SoUKfqTrHuCAM8WGR6XtzEUUxf2JQUzvH9AhprQEXpL0S8yd/fC4K66QPpwtmJ7udc1m
         lOIFy+/trTPeJI4mv6Jai1dj6x4BdoCzOg+Mm5ckCMk+0ouHIbsvjlAVCEQ5pZrSoE6U
         JTVJ7t4sc4UJCMlY+ub50wkMkoDgHcVUwCI08c+i2v5HV+meQgs+YZH5mgQAUpzKoniV
         fV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5GR1cfMpuWQbSaXT73937ELZ/sCiVavLQIUW7HngfM=;
        b=Z0O0yyYdRg2Iujoz5g2XbEtqUy3amyWwXIm2RtaFN9xZ9Kxdqnye5qpON/YUqo+fGM
         I5Vym4brz1U6A8eOS+Lu7ZRY8ERi8kIxp44ClK9r7wOqd9WbOjrH1ezMGyzpCCQHp8+e
         LuzNQ2PHp6xC8gkrVP37iPAcFCuaBvTREw44AdAvQSfBm9z2C1j2LqUrcP+72a2FrOHM
         m0Xs1aIoOVaQewPWZ+nOso2Ago7SR453hZyog/jmFBMqLxBbA6/r+CpJzTO0FJl2MKlg
         xnZaVUI/huivl9hbSSAQU4HSC3giR5yprkfxqZL2/wSGhvjfIg0M1hxuz03TPU2b7h3F
         5L7g==
X-Gm-Message-State: AOAM533RMvm+E0LZvj7fnnHDt1MJw3rBy1BBpy8dGV2tNBui0rk+drId
        LtIZBXngGN1Ic/mzv/h8IePX0thtoXW6WOpU5C0=
X-Google-Smtp-Source: ABdhPJyr22+5Em7KnSu/Bt2MF9WfPtSAvejffbjajPVVOKJqqmSzkhHS6UWI8c4awxFAPd/MPQpVDsNCYYebPqBNtBY=
X-Received: by 2002:ac8:530c:: with SMTP id t12mr12247750qtn.111.1632618931445;
 Sat, 25 Sep 2021 18:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210924143347.14721-1-broonie@kernel.org> <20210924143347.14721-4-broonie@kernel.org>
In-Reply-To: <20210924143347.14721-4-broonie@kernel.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sun, 26 Sep 2021 09:15:58 +0800
Message-ID: <CADBw62rxg4ZfCLj9CZvXPdtX-qu_tMJbe87mpABit+ifVuh6jw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mfd: sprd: Add SPI device ID table
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 10:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI device ID table.
>
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks Mark.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

-- 
Baolin Wang
