Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EC45E766
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 06:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbhKZFd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 00:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344125AbhKZFb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:31:58 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B4AC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 21:28:45 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g17so17101765ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 21:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOkzClK58L9KFyLkDZDvUq7JA9AjBI1vkUpVIs5Rlsg=;
        b=B0JqtRcEypAzvY+/FM3GtMs2SwDR+GugrIk8bVkoNM8K1SXCzGgpqib7ZKYvMRokOT
         R7rz30b3vH3LuUCWsuZ30dnc5ypEcFBH/RHBLRg/jhHYLSzYPQrDlmOJQUsTvTMbLkdG
         rdfNiBkHFY6qfxgyOufYCuh2cT0tXkHbpLaUoNb2LJbfq7h0P9ayQekBkBwXXSdRa2lx
         22+GNhjntd6sbnAUGECSlq8O2Kjf5MQ3K0OAxa+iyMQ4LnrJeKKabu4/NEh/zFY6ZyEa
         i4eIW/j0LurHx4C6iixxyeoCrQ0JUkAZoUE47b3HaV6Pw/X9zB79+6VZhCHmIDVCXOrD
         dJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOkzClK58L9KFyLkDZDvUq7JA9AjBI1vkUpVIs5Rlsg=;
        b=qAaJgUXkX7lI2g+nvmDUa2cfbMRyMoC2DxkUMOrY+veWij7flDCf6l15Qo6xNh+7I0
         DH43K4yYdv3jgaaf++n8DbsHKvvM3za6z/RVNi0Zx49LrgymZT+mvNGYaNUSmZdYn95G
         vIqbDW39YI8N9ZZ3JbYhSX1XrufKcV8RxRsmwkiQex3HOwLG/oar3Li7myMHrONeaUIF
         Mq3sJoF/8DTsp2FS7WVVM/N7KcKukvfuScbUT4IHz4gTG0E7gqoOrC7d8puu4qXMFJA1
         ftLZXOxcWu3DR4bsWltdnCqjS1rrEUVwmF0pNHHF/K4RW36Owz0I1xldGiCo9D7at9Eg
         5L9A==
X-Gm-Message-State: AOAM530HEby5K04RnqFJN2Wa2m3ZQXFxeObzNpk0XR/OtZa5pupH3ZkU
        VomMtPL8KKyiXB1wAZZFtTA1gVJ/WLWscjQLs+oHJddhGBu7DCh9
X-Google-Smtp-Source: ABdhPJygl7k2S9FnANNO921zXArJzimRsOoLhvbPSNF1JaMRnN+OGWNFXRtd2+C/4j064rocKveYj1sFW4kdl40ybCo=
X-Received: by 2002:a05:6902:72f:: with SMTP id l15mr12655859ybt.279.1637904525080;
 Thu, 25 Nov 2021 21:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20211125090635.23508-1-colin.i.king@gmail.com>
In-Reply-To: <20211125090635.23508-1-colin.i.king@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 26 Nov 2021 13:28:06 +0800
Message-ID: <CAMZfGtWJM_HqtTsiaNB5n6sC0P5EYyHpSOBoZvDS5SCHaUarbA@mail.gmail.com>
Subject: Re: [PATCH][next] hugetlb: Fix spelling mistake "hierarichal" -> "hierarchical"
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 5:16 PM Colin Ian King
<colin.i.king@googlemail.com> wrote:
>
> There is a spelling mistake in a literal string and a comment. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
