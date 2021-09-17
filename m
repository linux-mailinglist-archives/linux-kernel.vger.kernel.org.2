Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD040F252
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhIQG2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhIQG2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:28:04 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E21C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:26:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id p2so12660983oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=evM8dYW25rUmoo+jhaGEhb/KiP/SeJMcvT7KRQQj0k4=;
        b=GloPPC5iQ+gAScdWkJeOIsSgsZ5BSp9BiCqP1rzXOdxccRDtfeoX8O0HsiM7fJbpE9
         tUSl/aQESeWKK1uPMUO7DCltaBfer5Uo3L92ywAfuAXPYyuw0Q6UkoscP2In/ZftAmou
         tpYiHFxNgvo/7eg58Bk7Zn4HkLVXoT+1ihqFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=evM8dYW25rUmoo+jhaGEhb/KiP/SeJMcvT7KRQQj0k4=;
        b=7ACqDu0Iep/V4/2CTZb3rvr6RlUnV6mhGlqhvDzsa3YKY/kG39YZyKBybEROtdSFkP
         ZaLZt2cmxojzU2j78HAO31LRn0RvBoQ5ZVGT0tBcfuHJSnfZ1JQq9g3Y6ohuGU8BaBHq
         Ov2KLyc/AtUqWuNuIowFY+fQFoODdF2u/JwVHuvVaIOS/fGkpInoZGvqLZutgtoLaPTj
         P4Ze2ibpFW4oVeb9TG6thrPRWZliIGzkfWP5msuKEJxzV6Wh4iUbkbLhOBiHFL8QTp06
         PwI2hf+zOIAylyxCcMr2IxLxFpOdK4ikYArqIvkX3xx5N40r71C4+lTGbklG7DSdLG68
         reeQ==
X-Gm-Message-State: AOAM532fUt3t96jg3bM79a4YnUoriaQbOz2pCDAP+snZbTEubAQGrq6s
        2bam6/azuo5OOjQCxeoeAvv45oD3pF2s5Nh2AptQtA==
X-Google-Smtp-Source: ABdhPJyrkQzCWSDEUH1Rd5lLaPb2mxQs/iP6fiO2b9602AYM1Z/L3nqb7ScjuiLu6cPKzfoKXdFQgYK/XitKb8oyxGk=
X-Received: by 2002:aca:2310:: with SMTP id e16mr2823690oie.64.1631860002668;
 Thu, 16 Sep 2021 23:26:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Sep 2021 23:26:42 -0700
MIME-Version: 1.0
In-Reply-To: <1631811353-503-4-git-send-email-pillair@codeaurora.org>
References: <1631811353-503-1-git-send-email-pillair@codeaurora.org> <1631811353-503-4-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 16 Sep 2021 23:26:42 -0700
Message-ID: <CAE-0n501fpj13snR9Q+RyOW12zPqyY8W4ZqzFcrmeqiwA77GVQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] remoteproc: qcom: q6v5_wpss: Add support for
 sc7280 WPSS
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org,
        mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-09-16 09:55:53)
> Add support for PIL loading of WPSS processor for SC7280
> - WPSS boot will be requested by the wifi driver and hence
>   disable auto-boot for WPSS.
> - Add a separate shutdown sequence handler for WPSS.
> - Add multiple power-domain voting support
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
