Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552D230BCB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBBLL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBBLKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:10:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0894AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 03:10:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so2033085wmz.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ovhx5C9K0mtaqY6XtiS1biDzAm8u7MdzCszIDE33A1k=;
        b=BrCtIu1R36f/I7pRSjgLygk181SAV9U7Yxrap3fUhshC7UlJ1zyjoFRLngg6VVnBO1
         6xwVVpSBlzFRbAshELn3LdihVafMR88ZBQdD1Lmy+/wF6QnWFCvWeMZLGGfWbLykeD+O
         RB75SGuCpXHeknNGBmpJNtRxlefkGz7rqmKZqAzRgjxG3TmvTV/OHb65s4K5sH+9z+ap
         VFXFa90fzPr+aLdJmf+qjQ9LGr+aIbyRV5FkoPuo+LXlvqfaZMfs0xwHkvrCMd4GdnnN
         ULwzsKGwJO+SEuDI0CJB5gnr4SVv6ibZb8/Oa5Mn9ac2pnS2hlGSzgBVD6tSFvf69x4C
         uZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ovhx5C9K0mtaqY6XtiS1biDzAm8u7MdzCszIDE33A1k=;
        b=bEI5WpPbu0MVDZUoZ96LtVET4VPgL5sFPlBYIJQK9Qykquk2Ul2xFpqMSplDcNUR0C
         kRPIathEQ9Zy9wySO+uRi5g7NcKc72zL6jgpusolbtBv1e2+Go6Pz7ipQticEHJ9FfHM
         fv8iaSHp6rgvxtCTfzRbtjoX7YnoHNIQNp5G9tYgBP1IHAtZA0GwHPxZkzUV2tOyMJka
         eYVilXOZb+2/rxHFWAM9vcD38Doo1DivjbLdQywp26dR8djDHe3XrRkqXPtiFu0isyyb
         fvLSbPwIbVsdub5NbktmbpRDAvIIVtFlDcb8cCUiiNT7gXmRCYSlxeDIoC+ZEJl3DYZj
         R7ng==
X-Gm-Message-State: AOAM531ZSXdwkH2AvwR2Div4r5SLouspOfcaVjiOqsK2Qn6bF0Odlgqu
        KS0iJmtKOeBmjFabKXr5Owm8YcWvtO7VfNL3IYAH6cn1Ck8=
X-Google-Smtp-Source: ABdhPJxtISbwoAPA4/f8pKMubkFEjP8BsCANvKL+r86oM6j9mMbRYcbRvXOveb7hiF8ngnC7pIRMBDr8ofGjDdQzwLw=
X-Received: by 2002:a05:600c:28b:: with SMTP id 11mr3101421wmk.98.1612264211771;
 Tue, 02 Feb 2021 03:10:11 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com> <1611737738-1493-3-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1611737738-1493-3-git-send-email-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 2 Feb 2021 11:10:01 +0000
Message-ID: <CAJ9a7VjB8-h_0DBuMHvv4A+mHpz1GUczbGB6Tx1cBocRghm7mQ@mail.gmail.com>
Subject: Re: [PATCH V3 02/14] coresight: Do not scan for graph if none is present
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ansuman,

On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> If a graph node is not found for a given node, of_get_next_endpoint()
> will emit the following error message :
>
>  OF: graph: no port node found in /<node_name>
>
> If the given component doesn't have any explicit connections (e.g,
> ETE) we could simply ignore the graph parsing.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 3629b78..c594f45 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -90,6 +90,12 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
>         struct of_endpoint endpoint;
>         int in = 0, out = 0;
>
> +       /*
> +        * Avoid warnings in of_graph_get_next_endpoint()
> +        * if the device doesn't have any graph connections
> +        */
> +       if (!of_graph_is_present(node))
> +         return;

The problem here is that you are masking genuine errors.
The solution is to either call this only if the device type is one
that ports are not required - i.e. ETE, or upgrade the .dts bindings
for the rest of the ETM devices to yaml so that the ports requirement
is checked and validated there.

Regards

Mike

>         do {
>                 ep = of_graph_get_next_endpoint(node, ep);
>                 if (!ep)
> --
> 2.7.4
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
