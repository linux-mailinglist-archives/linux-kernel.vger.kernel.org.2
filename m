Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5230F349
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhBDMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhBDMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:39:04 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E0C0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:38:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f14so5002725ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKomFTi9KTzn7Zn0jL1T3pTrVBNdlY+OQxh//6pcE8s=;
        b=M7KAxwkuxx7MdAYkSQmVYG+psy4i5sppaoZmY1uR8ER2+ptiAAHINR3gh5ZtM9u1aG
         q+AvfRfKKQ2Or8uZHLSvPgIjf6OnTt+HDva3QMNepeBvKTwQ6KciUyvsVD5wSqYgrL20
         DWLY4Y08qhFYG10YXe9A+s3xsHrMSraN5J+ewOHOHh52D1ivpRE/JFXPyhq3tqcBS3t7
         L6HowwXSL46Gf2Q57VmDT31orIfXz95BaBZMjdxKYeYGUHLUj3ptl29yL4kSt16aeNbD
         wnv/fFgGw1qCRr7CqaHdfrL3gCOs5QGECK3fBiOw8xuzLV3eEr7Bk8oksOQZKBpHr7CI
         jp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKomFTi9KTzn7Zn0jL1T3pTrVBNdlY+OQxh//6pcE8s=;
        b=n29J/uiAO5hX6xfnohaEAbVLWWoEoAwe520HQro/toK5ztQBOebtM/s8SXpqzXxG9F
         lvP4OwOa56WUKGKKDLUjUUNWjwDq0xEfk3f6dhg37RJyokyOdIWCXK7+7o58nWLCu0mL
         mJ81tx6ZPFURPshruLq8u1ykKsN+hj8FLF07Cp5CumjN1DEwcU681ZldIyrAPUTNI4uX
         6NI27gB9dSm57cOpZ6bf/BN7CUwxF92Vw/FIsY5zK9gaS2cEIHR7GjX3lNxuQ/pmh9iJ
         DHH92SMdyuAbpRtjV7qmnEB5VxXHJL4jgSvN2kd+NM5Zj72xFWcLKZvzvsi/lX/0fXyj
         eL0w==
X-Gm-Message-State: AOAM5319YdHWY1jR3rZ0RFdNf+R5BZyIuI6ZgsHlN5geDm2IKFnW9DoV
        dtGGzcy04Jrmm/smWQAXRUiYS6KUVdXRLAuSrXK+Ow==
X-Google-Smtp-Source: ABdhPJyHA+6o1yvtdQtzPO9bu+J82Yst3tsnQkB2BQj7v7PTjY7pbf3j7A5mqGWKvABHBEAFQMaKgWiv42O2Z8cEsf8=
X-Received: by 2002:a17:906:b042:: with SMTP id bj2mr7773910ejb.261.1612442302496;
 Thu, 04 Feb 2021 04:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20210105135614.32104-1-brgl@bgdev.pl>
In-Reply-To: <20210105135614.32104-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 4 Feb 2021 13:38:11 +0100
Message-ID: <CAMRc=Mf-eqJMxTDF8RK_jMMALJJ=+kwmyy-BOof1_ou7OoDCVg@mail.gmail.com>
Subject: Re: [PATCH] irq/irq_sim: shrink devm_irq_domain_create_sim()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 2:56 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We don't have to use a custom devres structure if all we manage is a
> single pointer - we can use devm_add_action_or_reset() for that and
> shrink the code a bit.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Gentle ping.

Bart
