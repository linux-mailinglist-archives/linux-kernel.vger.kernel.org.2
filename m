Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD96C33C5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhCOSmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhCOSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:42:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E815C061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:42:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r3so50318722lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8V+rz6dHaPmJOhTso7qaASysVmTy2044POg4ldMfuo4=;
        b=jRLwWt7H0Pi4ZkUjPDCFeT16PhziKfzVweJicDH6BGT2nG7Cy/kRDUnJPioZ/JnWAn
         bwgHa+chUnQvk59xxIJpUbENzw99d0R9GTDLDRPnq7XHtxvvh3s8n3EEsGXJXEYlq4et
         hqPq8AqYf1iKq9yb7kfKB8SBpScpb+CMlOGq43zaknms2PxRynqWw9cnj6tOZeMOT/OZ
         S+yqa58GRS2ncCJBI4rmykPvMeuhGIZ2yVsPGzrLNG/8dlSApnPsJSZAnMtr+s8t+P89
         QdohGlPsG8m0y7+qonqrmrEV7aad2z3vPHEkCLlF91M5LRQEe63Df/Tq1qlBqlp2pPGp
         8J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8V+rz6dHaPmJOhTso7qaASysVmTy2044POg4ldMfuo4=;
        b=cyKnPL/tdQo1AKzuk+mch5ql0CRia6BH9PPr8W9rSYzJscxIWy+2Xw6iACJKFYuK10
         ScrgHu6aJcIGnCWvBB98JoO7jTPEE8fruqh6xZL9PEVIMV1j+8RrVp4LhLmcRahPAygw
         QWHR5y0die5h9NFe7qscKvevaqVDWp2C4FpLBVVCzA9Ls66w0E1sCLVPRZzdtSfDYE6I
         qZHbOuz064sgOXvBkgM3sH/yhSK49MBlSujTjfhG90gkN5MYQEBT3Wxrfuq0a1v0YVFf
         wab4scJ/QNcKnVHYSrds7GHIPez4Jx9CkzRJRi/HFpzpai057vpEd5OvflXktWCdneXP
         N9YQ==
X-Gm-Message-State: AOAM5332yXlZPJcCn/N5ZDWKONJng3AQsuBnHUl2KApxlfoZRLefjehe
        Mh8QL62qJpwKwAK6rlvMnio32V46JGtRipKPtnWkxg==
X-Google-Smtp-Source: ABdhPJz2wKAyWfvmM0JOI48gzt1V0Qdip+vbLcJCzgXWjWu8sJ4chylMWs3OtOsW0Qw0gKwjeJnLXJ3gpBLK9eXKm2M=
X-Received: by 2002:ac2:549c:: with SMTP id t28mr8490298lfk.7.1615833728903;
 Mon, 15 Mar 2021 11:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210315123303.10218-1-colin.king@canonical.com>
In-Reply-To: <20210315123303.10218-1-colin.king@canonical.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 15 Mar 2021 11:41:58 -0700
Message-ID: <CALAqxLW1VaMTVx3piKnLcEqWxMcQFG9LujH1ijHP2dbXBQaxqA@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers: Fix spelling mistake "clocksourc" -> "clocksource"
To:     Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 5:33 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a comment. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Akcde-yb: John Stultz <john.stultz@linaro.org>

I kid, I kid!  My apologies and thanks!

Acked-by: John Stultz <john.stultz@linaro.org>
