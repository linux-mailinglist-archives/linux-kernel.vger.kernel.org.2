Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C343412A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhIUBm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhIUBjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:23 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3244C03D757
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:45:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso25175630otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=0lMjcJgjA5p0L+B4D8/C49hBGj5m1tcUAQw/zX+WFkQ=;
        b=ksyd34+2zy67ZFy+o9RsD8ZuJRMj3wPjZFUQ6wD+1poORRNPXvC5/IJtaDVf3siH5X
         9NKyFWrUDOB21pvuk/f9kkoRQPI6c6C2dsP+nEEGCL9rfGOljX2aWJjhv80Dyel5Iit+
         RR8ZuyTwyd6sfYEPuvyIi8mjc8o7Z7DNeTwPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=0lMjcJgjA5p0L+B4D8/C49hBGj5m1tcUAQw/zX+WFkQ=;
        b=bZaoNBkSf25BfmoRjq2TwgAXhUDn6PNC3EOddEYSUFN7i6B9HuhBANFSr8dgx00Tyq
         tdcsx47psXmR9Wk8EWuHccXGYbHmRz/kgVazF3UxxgbSzrfLJZLA/54EaHDVMoBHeJZE
         BgQmsytMYbVbF5yZSc4GGPn6jX7HX0Oiq0Fo1bQZvz01zrlJh8MNF7o/A3sI4ozQ3iIS
         XblcKhcmTV4vZcoqh7Kb4beqGU9U2A68dPSg+31HfcftT8FOyPVX+i2jzfiysdJlYNpS
         HVbvDu2PwjjgdzRCKrSglqQm3SVRouHGXWdy8tn5U2XVU8us117S2fp4s3FSWG9hH94g
         qK6A==
X-Gm-Message-State: AOAM530Em1PsVGV70ZYq5XKloUa8qeTRSrafA22wPjhDuqhSl5Bia0w4
        EmovV7KxFxa0JqX8cxmIZsD9NPSBMowPHOZpAIWh1Q==
X-Google-Smtp-Source: ABdhPJz3P613FgQ878WOniCM5odr0R25PCsqU/V2RNIJbHTCJFwHFka52ezTdPmQNIkSOMpsdSkh6167RS1bPhrp3T0=
X-Received: by 2002:a05:6830:708:: with SMTP id y8mr2313750ots.77.1632167137966;
 Mon, 20 Sep 2021 12:45:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 12:45:37 -0700
MIME-Version: 1.0
In-Reply-To: <1631872087-24416-8-git-send-email-rajpat@codeaurora.org>
References: <1631872087-24416-1-git-send-email-rajpat@codeaurora.org> <1631872087-24416-8-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 12:45:37 -0700
Message-ID: <CAE-0n53TxT9zkMuGHRsg6HUk-hdDAz3B14JODFP9kbb+qFa+QQ@mail.gmail.com>
Subject: Re: [PATCH V8 7/8] arm64: dts: sc7280: Add QUPv3 wrapper_1 nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-17 02:48:06)
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
>
> Add QUPv3 wrapper_1 DT nodes for SC7280 SoC.
>
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

With the same cs_gpio node names fixed

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
