Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED743403C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhJSVOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJSVOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:14:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEEAC061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:12:04 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r134so22024601iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30BnP4r6CE0OkZvT19kcbgPK/6Ckj3KjznbN6qKawuk=;
        b=fpA7N/KYD+Fh+EqegyotiKveYMCDZtJ4zi3/phXmtjRDphoY5PgXliB8+bY62n45i3
         JVOV/VITICl2sudKvC91/HihnhlM9h8FXhI0rMD4Qmh3tsLTyLPBNsuAf+vNtdsiQ/vd
         X8ZS+4C8t61x+oCuOd4J4MlzH+H1psJwjmzHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30BnP4r6CE0OkZvT19kcbgPK/6Ckj3KjznbN6qKawuk=;
        b=o8ciEJXDEt/lh9Z6fbxKdYbi4o+tOF0EKwqantVYqchfUJNS3ry+Okh/lZa2C7tAul
         2qDy9cwrkPDbH9GOtqbWO7IsmOvW6Q/uZmRMMT+Ur/zUqAtysnUZDfka/wsl0cbNfVw6
         EC1OP0B4kHyplMC1kdXcFZ87Smq2HFZa7+zuKhzBEYo8+0a44iPLhXm+zQhkQbu2+hlt
         PtiWeP/6JVKQhTVvu39twnk1QiM3QvJqO629sBKMn/f3vBpMouSLj0VPXEwkkNmbbV4q
         ySzPxddf4fP2MCj9Ps/4hBzoaURQPmLDdedO6581pPMl12zfMFvFty5iy46eI6zuCWq9
         jgeA==
X-Gm-Message-State: AOAM531Qe8lwjqYVxbVcCnacJYpHNXYVESZuKhh2PkUEU84CguPQ6PGP
        Kmq5DUE+9MsKz7VzlyTtGt96nW9rn+VLhw==
X-Google-Smtp-Source: ABdhPJyHBq2S5sGwKYY1uslPk3Qk/BfdJAijWTvy5K2CC1VVnw8VGcFr38RQeiVgti/SYfQ/FAa0Gw==
X-Received: by 2002:a02:9469:: with SMTP id a96mr5994213jai.5.1634677923372;
        Tue, 19 Oct 2021 14:12:03 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id b6sm94396ilj.39.2021.10.19.14.12.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 14:12:02 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z69so18906984iof.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:12:02 -0700 (PDT)
X-Received: by 2002:a05:6638:258e:: with SMTP id s14mr5926528jat.54.1634677921595;
 Tue, 19 Oct 2021 14:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <1632399378-12229-1-git-send-email-rajpat@codeaurora.org>
 <1632399378-12229-9-git-send-email-rajpat@codeaurora.org> <CAK8P3a3KuTEAXbSTU+n3D_fryquo8B-eXSF2+HrikiNVn6kSSg@mail.gmail.com>
 <YW8xl0fLnQE5o3AQ@ripper>
In-Reply-To: <YW8xl0fLnQE5o3AQ@ripper>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Oct 2021 14:11:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XsiMp5jSpX5ong27KYW=G-XYhCfjo48E5cC6Cm+oU-mA@mail.gmail.com>
Message-ID: <CAD=FV=XsiMp5jSpX5ong27KYW=G-XYhCfjo48E5cC6Cm+oU-mA@mail.gmail.com>
Subject: Re: [PATCH V10 8/8] arm64: dts: sc7280: Add aliases for I2C and SPI
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 19, 2021 at 1:57 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 19 Oct 13:43 PDT 2021, Arnd Bergmann wrote:
>
> > On Thu, Sep 23, 2021 at 2:18 PM Rajesh Patil <rajpat@codeaurora.org> wrote:
> > >
> > > Add aliases for i2c and spi for sc7280 soc.
> > >
> > > Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >
> > I saw this in the pull request, can this please be reverted?
> >
>
> Yes, this can certainly be corrected.
>
> > Putting the aliases into the .dtsi file is really silly, as there are
> > likely boards that
> > don't connect every single one of those, and then will have to
> > override and renumber
> > them.
> >
> > Please only list the aliases that are actually connected on a particular
> > board.

Hrm. I know this gets into slightly controversial topics, but I'm a
little curious what the downside of having these in the dtsi is. In
the case where these i2c/spi/mmc devices _don't_ have "well defined"
numbers in the hardware manual of the SoC then I can agree that it
doesn't make sense to list these in the dtsi file. However, in the
case of sc7280 these numbers are well defined at the SoC level for i2c
and SPI.

Said another way: if you have a board that's got peripherals connected
on the pins labelled "i2c2" and "i2c6" on the SoC then it's a really
nice thing if these show up on /dev/i2c-2 and /dev/i2c-6.

...so I'm not sure what board exactly would be overriding and
re-numbering? Unless a board really has a strong use case where they
need the device connected to the pins for "i2c2" to show up on
"/dev/i2c-0"?



-Doug
