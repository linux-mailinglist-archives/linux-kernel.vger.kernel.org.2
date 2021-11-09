Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117BE449F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhKIAdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKIAdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:33:35 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A0C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:30:50 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso9351890ote.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWOLg/TjdfsihzJ5MjAZua2eODby7ABOKKXMhSMpxIA=;
        b=sN9/kcyrGV71FgwMjDXLU9oyYsKobWGMHlwoeh+H6r6+ttdcw2dIGT9EODixMzTmf3
         sPDv7ueTlgzvo6ncQF1nN/IqqNqOJkqiCQKlOOVg2W2JTugQCofVHiHJm96KuNnzcurs
         aarAL6o6O+yTAj8i6i6I/p6oSH4SBLrOgZTN9rDSwFi5ygMhoa/nERJq8ey57dZDUOM4
         NEjgbedUv6cmna0v2/OvjKAGfci5uh63FERVDUJ3GUsbTP9JaJn4SMPd+vCTnnhrE5u2
         du6Y1D2G0tgorJbYWoHQEs27fILFzJEMUy/JeSuLRus3PYipADVg1sQoX91e1w8HWxkl
         uRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWOLg/TjdfsihzJ5MjAZua2eODby7ABOKKXMhSMpxIA=;
        b=VrqIvQwj5kf7IQUErGQjz794W3AEqVUtbmIsTdl4XV2662MgzoICG9DYgjo4w7/HdI
         aFza+pcCOR+dZzikcyEHwd5K8qUleZoUeKfacJOH0ZenXjxUwjFrinldwEwll++jXAQo
         EV0KrOGmpxVbdkIjQzFu8QP0i25/txVh2TcJ/Z4OncndCL3KiOaSC9Y3sjak4dyiTvyV
         aLBm4dRplDOTzQ4PavljLf1fQCv18glBX9f2JMM9uSjRCV+bz/Ism9JfioJOjPprplog
         z9XO5Z+3XfGGlIjasS9D2YMI6vPnXEqpuFWEaS6PXUloiZjG1acVk3sSN+vKbcc3cPJw
         2AKw==
X-Gm-Message-State: AOAM531SFs4YYaU6IjR33k5GzUr0LRy1p+oQVWWMLFbDvUOP4E8+WmCK
        RS//BI2FNwcnCw3DMp+eVAbNPrqylJBXDjzbr2drZQ==
X-Google-Smtp-Source: ABdhPJxGcQ+6oFfc5rMf7oTfLgAK69TFbXU2aavrfhreX3DPCotCJiOwOPhx7R5RSV9g9kfwzmO8PXMieiHgMRXoH/U=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr2592888otk.179.1636417849971;
 Mon, 08 Nov 2021 16:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20211021123021.9602-1-pshete@nvidia.com> <20211021123021.9602-2-pshete@nvidia.com>
 <YXq3/1AXX7KiwpTy@orome.fritz.box> <YYE7aXo0mfCfCqGF@orome.fritz.box> <DM5PR12MB240697948C6DFF64E45AFF00B78C9@DM5PR12MB2406.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB240697948C6DFF64E45AFF00B78C9@DM5PR12MB2406.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 01:30:38 +0100
Message-ID: <CACRpkdZto=5Pa4r7-eufUqteaJS5yYeTL6Oh8mFO_g=6RzV+mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: tegra186: Add support for Tegra234 gpio
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suresh Mangipudi <smangipudi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 12:01 PM Prathamesh Shete <pshete@nvidia.com> wrote:

> It would be helpful if you share the update to the device tree bindings documentation patch with me I will push all the changes together.
> OR
> Can you please resend these patches along with device tree binding document patch that you have.

I'm just gonna assume that you guys sort this out and I can see the
combined tegra234 support in v2 :)

Yours,
Linus Walleij
