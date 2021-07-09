Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BF3C1CC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 02:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhGIAjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 20:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhGIAjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 20:39:03 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8FC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 17:36:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so7773068otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 17:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=WN27oMEfY9NvPwjWgA4bGtEV8WjeXNxGHtmdD1XiQgg=;
        b=LYb3C7pX7CdWNjzz/dCcvpGx6ZT+diawAVGMRVLOPoNQwMwCfwv6gN1TkdNzGFWlH2
         nmG1zxCK2EojDkDVGT6tkoN7H30xt8iyNKH2EiGgBpPP7lHz2GGc3OfSg6Cx0JpUaOvL
         MLalO4PXIvEf+gFx2YkgVJmTPsSNbxUiqRx88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=WN27oMEfY9NvPwjWgA4bGtEV8WjeXNxGHtmdD1XiQgg=;
        b=jpuDekQ9yVbSoptilG4rwiRDxqazD8PuJXAsU7LGBAz3Wa9acEeedjubPFAi33UgOG
         6Fe6XN+mr2eN/awGK5cpBmr/jQPSPvYdYgYUIhJ3rxm1WEupj3YDKRwfjsPupyasjd9F
         yCxZO1Jgn6odybCSavcIykqsMGqBMzML7qKF9kykeW3keJRD8yjj5kI0IX/rXCqkc5cg
         /oO07ucvXzQ2T2t5ryKAYdCKFp9XzQ/qN8wjT9BW+Ixt2hjtxDw4xcuTxu+5ADDKzfhP
         pwBeMxoTtsNgu3zuK0U8orcDM5s9qyBCXGzSArfWUquYgiCNlhqTugnQnMkXT5mBgaVY
         U3kA==
X-Gm-Message-State: AOAM531BGRUNgOxEIGymuHFw3kEiChJlRTB/w0WJx0EOgExNZdV4yPXn
        A0SQT+K8sO73q2rxasmEKJIHXRLnw6ExwUZMRFS6cQ==
X-Google-Smtp-Source: ABdhPJzFkW00qYYeua+6zU03xXprYJxRcPLW1BYAEd4K+IzQ0JKM3/M4Exln63R8Zri80MwpRkZYNR0JH2U9ee5UxW0=
X-Received: by 2002:a9d:2781:: with SMTP id c1mr25341894otb.34.1625790979986;
 Thu, 08 Jul 2021 17:36:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Jul 2021 00:36:19 +0000
MIME-Version: 1.0
In-Reply-To: <1625576413-12324-3-git-send-email-sanm@codeaurora.org>
References: <1625576413-12324-1-git-send-email-sanm@codeaurora.org> <1625576413-12324-3-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 9 Jul 2021 00:36:19 +0000
Message-ID: <CAE-0n52x1ZY1kOsbmt-8P1gzZhbRBTkZSHoeRQXb1Kpgvb23aw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add USB related nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2021-07-06 06:00:12)
> Add nodes for DWC3 USB controller, QMP and HS USB PHYs in sc7280 SOC.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
