Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D13EA809
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhHLPyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbhHLPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:54:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:53:41 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r5so11022166oiw.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=YcXaUw4eDPSG+MibJUQlx8InS98N6ju4q2yiypQBbR0=;
        b=eY2VUXIqGp8kazDeOfHaMJ+g18TUO57eZ+LYouhkM9bLOIZGIQqdthPR9pXUSzOXAs
         JFyAknP7G/UmIXDn2QHn+S62dxwxfp41XkIYXCnsVAo/5CU5rsaPnneRg/+oZz8D7g8M
         DxzXd8KWkIbl6MeMzFskY63SMJLPnlyyMZ3lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=YcXaUw4eDPSG+MibJUQlx8InS98N6ju4q2yiypQBbR0=;
        b=UgASKKr1fa7sVBhkZs9DB0IspxzBfULRDHIjqPODV1a/CXgHtNurPSlW3wQWbeECC2
         /kvSyM4RnW8h6hqobGFlX4Iw5s5pDcng0NjT6jNxzl1XefNPZnCq5bypdm7fxaaVV3ph
         tuHXMxRJJPt2h19XiyqwKK6To8bK6byoDyiAw+CoJ4BvzVw+ZqOG5VWeYDwVrXHhSZVS
         db+a/BagtEHLci3fF5pkwd0VsCTJ+8jtC1zKKTLkiIMGIKBKdn+LIoEFofKjH7X0P7LA
         nc59Lu9Ur2PHXQHZgvM2stWMK7x/QENITnYB28ewcAMQMs0LaA6sWHdp2HeiYZqv/WGQ
         3BYg==
X-Gm-Message-State: AOAM531W7KoMjaCJkSKIXinxHoSkA63/6QRDibNzKNuCYZRJOjpBGzyb
        sa/7HCYtsRtMnYc6DrCMQYrT29uSXFWwHeLySMGIaQ==
X-Google-Smtp-Source: ABdhPJynWHO9zzPKC9hMvlzNYdBNJqkKMc8hbKB5pdaY4JwKaHf1iPyzqrcRrL0iBn+5uP91BLlKpVvZ7fP36VKpn7I=
X-Received: by 2002:a05:6808:2193:: with SMTP id be19mr5050704oib.166.1628783620592;
 Thu, 12 Aug 2021 08:53:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Aug 2021 08:53:40 -0700
MIME-Version: 1.0
In-Reply-To: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
References: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 12 Aug 2021 08:53:40 -0700
Message-ID: <CAE-0n52=8UnRMRS698TvTKG2bpFHqmLp5r4xc_dmSTA1V269oQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu
 cpufreq driver flag
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-08-12 07:19:15)
> As remote cpufreq updates are supported on QCOM platforms, set
> dvfs_possible_from_any_cpu cpufreq driver flag.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
