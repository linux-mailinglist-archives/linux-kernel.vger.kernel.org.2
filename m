Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49123FBF29
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhH3XAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhH3XAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:00:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C48C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:59:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s20so22087281oiw.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=23R8fKMXH4DxuDRCrTSwyAeEWCGLs+lyC4XMuQ81hJ8=;
        b=QEt5vB+J+ddmovN0j7CUy8wn8x5yFU4N0Y9ayi0DKxX8q+BVaY7929gtQp1ppB7KOv
         20u76lWLosHkqxaFAvY55PaCDYp0LTFIKsPQ4PUcA9jF+QuBHI47KbnibvX5WkFuzkYl
         pnho/WmKcYjwF1TMwom5aTzBNUFHZFb7LwTKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=23R8fKMXH4DxuDRCrTSwyAeEWCGLs+lyC4XMuQ81hJ8=;
        b=S9jwp31EDAXR6TQgCIwDaeom2FYyEvPycdfBp5Kw0ECa2JpElaE1tnyOH3jk60weUl
         t3aAoVuqMcvpWiXpyyTQmFCVdkdZXWKQF/7YYdwy2wVFpV+MXRzHFQWEvCFdrT8OPfna
         qolEihuTDzbJReN/7MyFHAyQxD7MKTRjJW9BjQ55YbkfHX/VIv1ezUZOxvO1v2JDEC2I
         YJYqZ6QbFfd0vGNAeadJuCF6tajw9ZYpONbDgUy9mh1vCDKMEJ0Rn1+eWD9A0I6mdSu8
         YNgVslxyy5DG+kZ5IJlW/MR9/5uGTQNMmPCc8vSMWmNWPPNddDGSnQIe5B2WdWX1j+9z
         TTHA==
X-Gm-Message-State: AOAM533hDT1Rz0/q0KAJ5vlNxVbDUE/lH2UuzS+pIVYSXp21KK0jfXGW
        YCpLoYu7xNVwTKElGUVUYLxixu0aRNPhMrQsR8Wodw==
X-Google-Smtp-Source: ABdhPJxlC/joPvSoDsoEOTZeOfqE7RatXYPvmu42VW0LMMlNpAJfL347e0/pP2v9YPue3u5i3tJskWLI5vGa9ZnmWZg=
X-Received: by 2002:aca:2310:: with SMTP id e16mr1139491oie.64.1630364354502;
 Mon, 30 Aug 2021 15:59:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Aug 2021 15:59:14 -0700
MIME-Version: 1.0
In-Reply-To: <20210830080621.1.Ia15d97bc4a81f2916290e23a8fde9cbc66186159@changeid>
References: <20210830080621.1.Ia15d97bc4a81f2916290e23a8fde9cbc66186159@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 30 Aug 2021 15:59:14 -0700
Message-ID: <CAE-0n52mwKmw5=_UmAAjFxCvMZYeqGrFfLy6RObf6LP-g=MB7w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Move the SD CD GPIO pin out of
 the dtsi file
To:     Douglas Anderson <dianders@chromium.org>,
        bjorn.andersson@linaro.org
Cc:     sbhanu@codeaurora.org, mka@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-08-30 08:06:37)
> There's nothing magical about GPIO91 and boards could use different
> GPIOs for card detect. Move the pin out of the dtsi file and to the
> only existing board file.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
