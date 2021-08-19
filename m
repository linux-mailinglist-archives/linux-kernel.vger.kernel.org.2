Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483423F1AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhHSNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbhHSNpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:45:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEFAC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:44:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h29so6016978ila.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ug1OSGTt9qLTp56AgUL2RfL1TSKASvvRSNzqRc2tcqw=;
        b=XfvaZ7ZW98kSfzUdcrLY4dFpOgBvtifT09w0hvXSRHNg0WtGEFaTODfTsIuOxZs7zi
         vBeZ1DlAaHqzXB/EpOMgzPWPDgODvbSMzvLb0HVSicDgzWNojNr3tDeMY2HFyZQoBt9O
         XlrMazdrCg8Kz5EAqXZnxUn0g5BwvYEoLQZNDIR1/Xk/QlFSSfW8DBmCoxaigl6MIkdQ
         ICPu0Z4JFoIuVPMd/RrJomE9SqGH/B5eWSHbxytuM2S/n0XS9TvtgmJ0hT4KPqnD5ACp
         HHjXeUW7AByGw8JQZYmzTv10iV96woEDRmibQiowyvtN15cK34kkiVx4u6b7ZiNtrm/C
         Y1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ug1OSGTt9qLTp56AgUL2RfL1TSKASvvRSNzqRc2tcqw=;
        b=ntiyoz1AB9bNR0iiYCmolfTcULT3N0DmKCAH8BqQyF3x+odW0B+CA6qvJYh2qrlFHI
         cuKfl9ikQDPE+dL9WGe89TiERDik14IeEnmkSt+04NZcmkS5ZXdAVtzcnS9Qw4ADHAWY
         rKl4X3tw4faSzTBjBpKmcHZKVkwC8RQiQMKBSTf8zjU6ZSQTfD6nSoMLVviNtO3Kvm82
         4nFBn4J+B5pLohlsasqVwLKaqRsAeAm4rMXc/1MAeeLyPvLXASKKrNDg5yzU0pMDU2cd
         XvAZ75EawfDK77H6fjbCcV7T7swbDkt2EIig81F69ovjY9XIPWj/vRTZqdoQMIK7PORG
         I3pw==
X-Gm-Message-State: AOAM532s0NB6dTpWKH+Cu55AiZ0h3Ke4KI8Se9LBtTNpiij+9U9GJ251
        3R7QZbyPJDOkTyYT+GjvTW0ljnIA9/BiifKdzURTXQ==
X-Google-Smtp-Source: ABdhPJwmtqmWXSprK1vhwc2gg4x6OTwPqzsJkVqyF5yv9RgHlIUTV7TV6oYqT3ZY2f6S/bmRmGGnAfG82XXx36knYQw=
X-Received: by 2002:a92:d304:: with SMTP id x4mr9982073ila.82.1629380680491;
 Thu, 19 Aug 2021 06:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <1629132650-26277-1-git-send-email-sbhanu@codeaurora.org> <CAD=FV=UqFczZ6tLzVuXhgKG9teSNTGt_RdqAxP4eXBN_eDDAtQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UqFczZ6tLzVuXhgKG9teSNTGt_RdqAxP4eXBN_eDDAtQ@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 19 Aug 2021 06:44:27 -0700
Message-ID: <CAD=FV=Wq-+Xzjc-o9p49pvf4A_q7L-THHp_wUQce47E+yMEgvA@mail.gmail.com>
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7180: Use maximum drive strength
 values for eMMC
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, cang@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 17, 2021 at 6:58 AM Doug Anderson <dianders@google.com> wrote:
>
> >                 pinconf-data {
> >                         pins = "sdc1_data";
> >                         bias-pull-up;
> > -                       drive-strength = <10>;
> > +                       drive-strength = <16>;
>
> I could be convinced that this is the right thing to do, but I want to
> really make sure that it has had sufficient testing. Specifically as
> this patch is written we'll be updating the drive strength for all
> boards. Increasing the drive strength can sometimes introduce new
> problems (reflections, noise, ...) so we have to be confident that
> we're not breaking someone that used to work by increasing the drive
> strength here. How much has this been tested?

From further discussion internally, it sounds as if this should be
fine and fixes more than just this one eMMC part. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
