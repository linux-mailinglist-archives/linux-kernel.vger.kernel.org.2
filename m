Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18143F40C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhJ2Aol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhJ2Aoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:44:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC2C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:42:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 131so8325406ybc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pb+iwuiJ8p/4MIMVnIOyQbjDhcWFiizWoltni+EWZmI=;
        b=ZBJrpw6UbIRQuOY2Y8gUJZIlZtVkMHenS1p7jpUc9LBXjUjDnGV94wYKC6w2m5GuW0
         /lacn6LcB1nXlSd+HZobc4M+T+Zh0OUjj9nJxBJKHEhf/2etIlDq4kcXGKWpCuRjpndf
         QkgRA8ooZlRgCudzMPNhHBsTtirhjwZDOtlyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pb+iwuiJ8p/4MIMVnIOyQbjDhcWFiizWoltni+EWZmI=;
        b=sL11CglvyOwbe0Sx7Waq8GgyfFQLUAcYBndj/2KgFrunHznk2HalA13HUjL47Ns/Il
         lS6GX6YQV0Xntd99cHXJoEe3Tc3cqLZSLDGTIQHbXuu9435AlcN9kci447/9hTrHonCS
         HRFtpGrzMHLzUEfjO7Z8372sI+dHjdPL+a+N+cnIOB/rcD5H/o/8dOaQf8EK85KLlEWV
         trNM2cpI9+kwBU9+1HrNCoH8V2sxZujNzb4CW6PLelm8N7/fd/NVe/qr/3a9K7lwtWjv
         8EIuUWjQhH1b9P+a2CCBhVafAS7hTXKRPbNs5OJtxbnWNsu3f3Q00ru0k2N4AciskLYu
         TJVA==
X-Gm-Message-State: AOAM533JpPMZdtsT5bcU5AmdAcWV9T18bVBnYaXv4Vr9jJGX+GRJSZAj
        B4ITVbiEkO83RYZ8D6EY6Rep9iJ8+nWMsw4nWVQasw==
X-Google-Smtp-Source: ABdhPJwOuNGQu8+3XrKEjWdE1HBVStgkNtYlbLjd708bFv3LC9VpaMwoGHcvAUiEjfxZRiz81b6ggRubWZkXPsS3e4M=
X-Received: by 2002:a25:a567:: with SMTP id h94mr8504221ybi.532.1635468131444;
 Thu, 28 Oct 2021 17:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211028151022.1.Ie56f55924f5c7706fe3194e710bbef6fdb8b5bc6@changeid>
 <20211028151022.2.Ib9070172c8173d8e44c10352f68f2f507a151782@changeid> <CAD=FV=UK0KABr5NchZgrjSFa+7G7Ez_JPcgCVnsN0K1q++O-AA@mail.gmail.com>
In-Reply-To: <CAD=FV=UK0KABr5NchZgrjSFa+7G7Ez_JPcgCVnsN0K1q++O-AA@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Thu, 28 Oct 2021 17:42:00 -0700
Message-ID: <CA+cxXhmV6dvk-980_kNSrAijX6Qbdn9gd7eshRQeWbgbJD7Lcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sc7180: Support Homestar rev4
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Oct 28, 2021 at 3:55 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Oct 28, 2021 at 3:11 PM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Support Homestar rev4 board where Parade ps8640 is added as the
> > second source edp bridge.
>
> Similar suggestion about mentioning why the include of "sc7180.dtsi"
> moved around, but otherwise looks good.

Thanks! I updated the commit message in v2.

>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
