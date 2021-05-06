Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42B937506A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhEFH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhEFH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:56:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FC3C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:55:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i14so4164545pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESVV/fMaAxNkE4WvbW0fxbJidb4bTYMGXoio537XTy8=;
        b=CBl6iUCMWBc1+XteGpbJ9leQZsxPoMSOwx/iAOt5hsVC8kF9j8ypdYuGO1NLGxRqgf
         3Ykk1ylqzolhm9eRIbT68h92NVteUANOM1QfT0FYefqAV18aaXzlczPZ45hztQHrFb+a
         gBbpnbW6Y49Lpts8ib15JwNOaHgWZoc9wZTZ9cdz0IFMH5Nu5zrJTlQBNsZCjHmTVZyn
         tl2Y4l3ES+7g3boCezH0i/M934Qc7jBnF/aHXKTo/18PFCu+BbVtiuo076Nt9W6eNOXA
         sg9YqOHJ7wRmVywkTdw4YdnzYb/EOOmYxhTQKtUnx61935Ac57esFpzZeAspbfmKjgeR
         HIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESVV/fMaAxNkE4WvbW0fxbJidb4bTYMGXoio537XTy8=;
        b=IASYsQBkO45YRGTzYHODRhmUMjjjvlkGU5P7gVw6s2gFRnKIuZNzuEoV/r5wztg9US
         92cw3pnA1v+ZASp3/uRxE5ZXHjEWJFYT4Sj/RN73a2KAkzubFzxcS3Acbzrn1EOFfvgm
         JqIcqCCLglHo3rbLDcibtkWrpRT1PQO45AMtE2khcSbKS6X9BXF2SkRNE4qaH7ukHu70
         OGCUE0Q2J3LqE4gW5nTkEGtQfr77J96c9sEgB59kj4iULUdI7c97UsqGG0GaRH+FWrP+
         XHsdSi9Q9rmk5lFBM0tVLEMQaYuB96zyfjHdOn8NJTk4db/dKc3//56nqi9NL+w1CTIA
         bgYA==
X-Gm-Message-State: AOAM5323PHh2q+3nG4rh3gKygQlCoWCGXMgbZYygBMfhus9KYdOu/NrV
        eM5LLuryIyZYwDQTahHabJM8WC0VpJMkneRebbN1lQ==
X-Google-Smtp-Source: ABdhPJz9+BbLcod0C8x9IKaB+7PNgAIm6oZ/AvRXYy2PJxruNemP5ifp+mZctZppylusL3o8E5DacbRjvD7abeeEMnE=
X-Received: by 2002:a63:9d4e:: with SMTP id i75mr2924857pgd.443.1620287720183;
 Thu, 06 May 2021 00:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <1620234501-30461-1-git-send-email-bbhatt@codeaurora.org> <1620234501-30461-6-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1620234501-30461-6-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 6 May 2021 10:03:53 +0200
Message-ID: <CAMZdPi8_MKyF8imaOc+9MGz4ifOKX=UMA1CzHe3aPuXC2BEoOg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] bus: mhi: pci_generic: Set register access length
 for MHI driver
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 at 19:08, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> MHI driver requires register space length to add range checks and
> prevent memory region accesses outside of that for MMIO space.
> Set it from the PCI generic controller driver before registering
> the MHI controller.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
