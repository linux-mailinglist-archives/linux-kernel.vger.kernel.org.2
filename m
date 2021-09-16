Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8240DDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhIPP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbhIPP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:28:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F680C061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:26:46 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i13so6995008ilm.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxG3dbZgPARu0xvQnjbpkCvQJvDZ73qgLTLb513Zo/4=;
        b=b0nQLKsmhRBdwAOVP7WfPx0gukN36TpAywM9O7OxxgmVkDWF7QIHgckba/ROBSlDup
         f5wzigGcYhRa2LTTtj4Ah76HGXjG3oUOx8yp1qO9kL7GtlOdruAt+V4fCeah5R7s6HDV
         A7Ol1K21yqh8t0fVtK3zz5kOOx/LFJJEtDWao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxG3dbZgPARu0xvQnjbpkCvQJvDZ73qgLTLb513Zo/4=;
        b=2O69Pi7oq2jYuywRxihEY17jpvQyZm9YNhrfGHj8JBFGJ5pg1jVkrnstfoVt8FITJa
         ykOpADpAl8oIcil83oo+kgqNY6K80k96g5oCvkDWMapGBoucxCXqQU5pethXvQkN6P21
         5znTlTN24bqL3a8kFTmexehROrYtVeBsrh/ErnEgueypDZsPGigfsnxjP5kejcklwT6V
         9ADbDElgudMNbqq1ejhv+VeViUe7QTvMQnteR5zjj3Y9ksvP0p6mnQH8Y7hFGc0o9bWS
         G5g5TCjYINokWDPt/PeCG3708oA7OJ3nXHZzlQAKhgL6dlWYV0yOGSUgTE9WH7/MLXIT
         xKEw==
X-Gm-Message-State: AOAM531oqTB/9/8wBC+teGk9oKoTf5E0KceyMAUh9ZZmUfajwwKenJnV
        9w8SS9AmpGtcvM/k5KSRN9rDZjeRx0zOeA==
X-Google-Smtp-Source: ABdhPJz+uvCUdaR3R32RH8QZzyEH6MQOTiGVvD4THoTjaxkJhLS1XZ66Am+XvlQkCLKQn/Aq48yUGw==
X-Received: by 2002:a05:6e02:1cad:: with SMTP id x13mr4390042ill.60.1631806005286;
        Thu, 16 Sep 2021 08:26:45 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id x5sm1888905ilo.11.2021.09.16.08.26.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 08:26:44 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id m11so8376369ioo.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:26:44 -0700 (PDT)
X-Received: by 2002:a05:6638:dc8:: with SMTP id m8mr4934839jaj.93.1631806004132;
 Thu, 16 Sep 2021 08:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <1629887818-28489-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1629887818-28489-1-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Sep 2021 08:26:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXC_GJFk0SAnwVas2YpWT=GFt0rHGqoFD8-a3fo6efEg@mail.gmail.com>
Message-ID: <CAD=FV=WXC_GJFk0SAnwVas2YpWT=GFt0rHGqoFD8-a3fo6efEg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Define CPU topology
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 25, 2021 at 3:37 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> sc7280 has 8 big.LITTLE CPUs setup with DynamIQ, so all cores are
> within the same CPU cluster. Add cpu-map to define the CPU topology.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Matches how things look with sc7180 and is correct to the best of my
knowledge. I think this is ready to land.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
