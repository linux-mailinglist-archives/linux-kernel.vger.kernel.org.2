Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27E2425A49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbhJGSFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbhJGSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:05:32 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE949C061764
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:03:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g15-20020a9d128f000000b0054e3d55dd81so3391653otg.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UqU2sc6nimwttVNTsN+KoIq0D+bxjGjE0Uy7w4zSjso=;
        b=jLbW+7kkLTNwDo7nzsbCqMtw9ge068L0fVwd4nYZ32DtCDgR3hrMERyqPF8XokXjKM
         gGvLUrYZf7iFOiN1n2xwIsANaEuHWtjXxisOvMsRXdB3vug5TsidLpUHrzXyRP1KVZ7S
         nx3EaPhp3M0WGPkZEFcQG+oB01yueTwuhQ5W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UqU2sc6nimwttVNTsN+KoIq0D+bxjGjE0Uy7w4zSjso=;
        b=8EpP/ZZz47LH3Uwmb2tDz3NnAujfZDdJnwvq0KQuCQNjUx00deFwInsi1niRwTplY1
         2wTVJCtkC8YJLqJXCIi5R85UfV6F2THsg2HYiscx/NrN4zGn6TWvgrvM3P0cFzGdjoqX
         CREYOZmGbQhTj3OspKUH2GPMoX/YgAWsoSGvksrH5LghhjHJACWUVxRMiIcghjJ7CxAo
         4MP7VFe81+prXEFyqB0+ZU5TJdn08cINH0/8VMOdVqIj2KazLW1COPjwWQZuQyph445j
         d2VYw+y07Try0nBRVu9eXm27DJxWMCUkV7y7DASOOLrEVjvXYP+xDkXCTpsyIWmWjwsP
         315g==
X-Gm-Message-State: AOAM531m8DD+oLT91A5Ps7S6RudylGKR4x2ny3dxbQeOndO6VouN78LB
        SrwrEwu3kiRCRPbG1MsvObE2p52wyvsodpDsvjY+cQ==
X-Google-Smtp-Source: ABdhPJzdP57QnKdUaciIKhWDyQMB6RtxGohINlseRKeMlntrQwhQiwnOaiAxp80/FctFi0Fd4EUCp1h/9sGJoPkWh6k=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr5000139otn.126.1633629818067;
 Thu, 07 Oct 2021 11:03:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 14:03:37 -0400
MIME-Version: 1.0
In-Reply-To: <1633628923-25047-5-git-send-email-pmaliset@codeaurora.org>
References: <1633628923-25047-1-git-send-email-pmaliset@codeaurora.org> <1633628923-25047-5-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 14:03:37 -0400
Message-ID: <CAE-0n51NfLevCSwDDK0pxg=zmdw7pqw-wGEV2_MxBZZvh_caOQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/5] PCI: qcom: Add a flag in match data along with ops
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-10-07 10:48:42)
> Add pipe_clk_need_muxing flag in match data and configure

This commit text isn't accurate. The flag isn't added in this patch
anymore. Same goes for the commit title/subject. Can you please update
it to say something like "Point match data to config struct"?

> If the platform needs to switch pipe_clk_src.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---

Otherwise code looks fine:

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
