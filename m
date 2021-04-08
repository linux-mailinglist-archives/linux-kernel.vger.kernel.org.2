Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80130358522
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhDHNtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhDHNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:49:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68EC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:49:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w28so4156759lfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UTgjJ3FHb3vPYX9JqUC+Xv2zcOSZzBL4YmbnqLtgQjA=;
        b=o4TSUSwHiiAAjF3VFtEcrQ4tpvWBkGs9ERxSNW5uZzLtvNG9jhjcMRPamT/5o9/e0W
         BUsZ3k5gpkaZogfOl7aOj5p62Oese6YpCGS1rgrCXQfWePMOeL+xw7j2qYtwC3oGjanw
         U84H3swzdTy5ppJvjX24OvmqblWycknA1u1OC2ULZTxrvia7LAa04EAJKyrkIYN3XSDk
         jveX6QjfyaoRGwlXxWhn3whB5h8igUqUcgNjB3dLBmsU3D54LKOv4tZeNzCRB+YyTfnr
         /kKlug35HLva8AbJEfxcKjzSsIIm3XucQlzZm3btrgmKxZs9G9ycKYJCdpfwr22w4m+f
         LPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UTgjJ3FHb3vPYX9JqUC+Xv2zcOSZzBL4YmbnqLtgQjA=;
        b=lh02hKiKb1Me3BZDfZEUAIHFw7vjjLDkWxPzu8+AvMzkV6kCZ2LswoZJwjpknqXCnQ
         5XtkohtFlq6dChFntSmg6pXzk7tZ9uvGM2Gx4/KC3VHpNDxw73L9Jo8aj6wEWSEvuaVJ
         7sQ+Vt9LXjejnRLfK4i7vmYLP5l1gtxKXLz/KKnfYXZ9jgGHZT/VuAl+Wt1n/SFKWY0e
         /TmcdiGwvGwJdCv/l7PPU0W+vpPL2kRUsSLGE+eEKXVi7ZDHcT0r0o5m1S3dUWzNEGB8
         /UyLCTjBr531ti+HeQKCwzHfSuzhExkWn+ZQpgf6qDtJMt1xc8DWNOkOFciEAMTZusTD
         2CJg==
X-Gm-Message-State: AOAM5339JYfuFqZqYGmWiiPxztJr9erpeidzwvWa3ryFLRleRgLKxaur
        rfMDBy1R6WHnIEl47GofEgGptS57HS0KqJN2Oi4C7g==
X-Google-Smtp-Source: ABdhPJydpnKNmcXAhArU85kHqM2ACtHCS13HM3NEI5XCdxT+1HfyDzLnwnpcyag83BGtGZUhP8Z6T0MKRnvupiqYS78=
X-Received: by 2002:a19:ef18:: with SMTP id n24mr6305733lfh.291.1617889743784;
 Thu, 08 Apr 2021 06:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <1617280546-9583-1-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1617280546-9583-1-git-send-email-skakit@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Apr 2021 15:48:52 +0200
Message-ID: <CACRpkdbD6E3PY_JCEbwNiVfb8LoT6F5DzV7x71Us3Z7U3BaX=Q@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Add GPIO support for PM7325, PM8350c, PMK8350 and PMR735A
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 2:36 PM satya priya <skakit@codeaurora.org> wrote:

> satya priya (3):
>   pinctrl: qcom: spmi-gpio: Add support for four variants
>   dt-bindings: pinctrl: qcom-pmic-gpio: Update the binding to add four
>     new variants
>   dt-bindings: pinctrl: qcom-pmic-gpio: Convert qcom pmic gpio bindings
>     to YAML

Please collect the ACKs and rebase like Bj=C3=B6rn says, sort stuff alphabe=
tically
and resend so I can try to apply it! The YAML conversion may need a nod fro=
m
the DT people as well.

Yours,
Linus Walleij
