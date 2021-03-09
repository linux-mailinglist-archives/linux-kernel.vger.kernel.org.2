Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA9332EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCITIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhCITIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:08:14 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CDBC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:08:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d3so28906042lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZtjmevkTD4OwnVekKT3y0VDqJKshXYG7EZriwiqfrM=;
        b=eHr4XURQG7ueBti6UgZfsaOJ82SLWkchlP0UMKAOZVYpvAAINpOK2r2zoV9feZAy2S
         LGrWrwaHz+XMPpMa2XXT/qyXcp2G44njqEEO2ME93vfPP+r4FJnUvL4Y5hJunsJU2n3D
         8nVmVTvOXSpRoP0qE9iqsbYNWv6/EiAI7OBiUzln1CGUpKPI5ZSDH9DnjSp1xSCfxpdx
         rrYpEw6uzKv8P6+nH1UQqP2CdcrjWcoFxrxo33Q8G20Y5UMo+fMthyggJOD/hOylDIce
         7Yh8WClm98Wm+Pz9yOKpoJmZKQFXLkIK7YYqKtUjmCPlJ8JnkNz7zo7RtOLBl4Q5qgMW
         1aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZtjmevkTD4OwnVekKT3y0VDqJKshXYG7EZriwiqfrM=;
        b=bJ3/OHmnOusScmETo0Il7rpbUrCLOmX764GAQAMtdcYW0HhWU7vYhX4b+83UFOZhLS
         aXLpIT+AvQOFaYLFZZlbrI70/0GC7cSdkY9Xr0nvHiEh6WmPcFph+gawpM4H3Crz+XV0
         UM21Chtb5UrJB+ij/MbCDuR6Yvrq21BPWJHATUzvsBH+u6r/K4R7XMYUOPDTmNigdmsM
         YhMF+Ki1TIU16CsyD4Ne5ie9U9XYvDunS5j/hOX13IQuywJNf5JW7IrqNyU6m3mauhE9
         aEEEpsu6VnJ57G7HR5ZN7eZS934v9ZHC9r7yuo/iNl2TQ1DIRNi7vZusz5ROhvIhLEzt
         5yFw==
X-Gm-Message-State: AOAM533sFQpjog4+ax51ROnRIxamUEmA9xWxWdXNJpAPZov+DKAP9LJ0
        valiy+VbBE1AvPAw9vKbHjqpkmze9s2JXqjY85A0xw==
X-Google-Smtp-Source: ABdhPJxi4EkLPvb3adcLZHV8k26dgNv1asUlJdCPJWrCcvaEh4Bcr4aFXpSmVPW7eIrxmlqmq3zw37dHXDqoDWOHzY0=
X-Received: by 2002:a19:7fc3:: with SMTP id a186mr17385948lfd.626.1615316892281;
 Tue, 09 Mar 2021 11:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 9 Mar 2021 11:08:00 -0800
Message-ID: <CALAqxLVf2_GJg=krRmwoqX_GxDMsuR6BYOoZfWoFk0dC0xVhOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: sdm845: array out of bound issues
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 6:21 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> During testing John Stultz and Amit reported few array our bound issues
> after enabling bound sanitizer
>
> This patch series attempts to fix those!
>
> changes since v1:
>         - make sure the wcd is not de-referenced without intialization
>
> Srinivas Kandagatla (3):
>   ASoC: qcom: sdm845: Fix array out of bounds access
>   ASoC: qcom: sdm845: Fix array out of range on rx slim channels
>   ASoC: codecs: wcd934x: add a sanity check in set channel map

For the whole series:
Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for fixing these up so fast!
-john
