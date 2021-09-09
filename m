Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80622405ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346815AbhIIVbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhIIVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:31:23 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DDC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:30:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w144so4427727oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=r79cmgNDDidxXvaxTI5T8bA/u2eCAhe6oAZULslvRNg=;
        b=Sr7U0TQjASjopEl37t4IJYyJD+TW5mSxY+2fu0BItg/tsM3alK382ZCbCLYEO2YANd
         CstrafRvDeNUHSbOBQAZFa8Qg76MfYcQVa9kkQC64JsOJCoSV/jUF1AzH6v6mjjNLJbQ
         8JgNs0iVDeJSrzXP3AKOAsGIRYnsXsJEw6mVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=r79cmgNDDidxXvaxTI5T8bA/u2eCAhe6oAZULslvRNg=;
        b=XzuR2/icAevSsFPvcImBPjUhlumH2x4pG395bGFCP7HONNpqYVGRDehrRm0cM++5fG
         q99ShcZ7EvgDmBi3d6Rzpb5Gzk9Jodg7oHyVFP1VFIqMgTimvcplMUP4mOrIBXmA8/mW
         of5uI3EjitGuoRH7TM2aQU7Ds8dgtZcpklwvkfuZ8ZD3QXBbojuDdeuRrZG2UIVQuU7I
         mBFHYoyIDPJamVVMPY75F9u2v5mSitcwqDE9DxFFBkCyOSj3M7VWIicDBQ5NjAenY6uV
         jtqXtHb73tE0VLMVKEeCu3f1HpJouf+KBcryBcC0wPIE7plxV4ryLXSLzEBXbl/KAKl2
         BRqw==
X-Gm-Message-State: AOAM533VJAK6MoomSen+59qKVQsZ9xa0t2uOY2Z8NcRZrZqjxDtKNml8
        c8ui/auKNusSqKwqN4VCJh72EuV5/QDKJhR2GnDq2Q==
X-Google-Smtp-Source: ABdhPJwCMD1N9F/MFmV5OSnlhCcqSqYaz+by8eltnOy/usqsU4stZm11gxAv2Oo8qN6yrYQ84iAMPseV0RSShDJWq0Y=
X-Received: by 2002:aca:2310:: with SMTP id e16mr1581007oie.64.1631223013219;
 Thu, 09 Sep 2021 14:30:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Sep 2021 17:30:12 -0400
MIME-Version: 1.0
In-Reply-To: <20210909122053.1.Ieafda79b74f74a2b15ed86e181c06a3060706ec5@changeid>
References: <20210909122053.1.Ieafda79b74f74a2b15ed86e181c06a3060706ec5@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 9 Sep 2021 17:30:12 -0400
Message-ID: <CAE-0n52kUS9cWh1oWOoAivYQ5TUu-mE2RPqjHZ=-QPN7Y=Y92g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add sc7180-trogdor-homestar
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-09-09 12:21:01)
> Homestar is a trogdor variant. The DT bits are essentially the same as
> in the downstream tree, except for:
>
> - skip -rev0 and rev1 which were early builds and have their issues,
>   it's not very useful to support them upstream
> - don't include the .dtsi for the MIPI cameras, which doesn't exist
>   upstream
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
