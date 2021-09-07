Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02B402F20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhIGTtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345829AbhIGTtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:49:19 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D78CC0613C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:48:13 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso470321ott.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=w+pEkVJd/h+WI+7Ik9xWqY+Z8oL6sb51sITpdGLwuE0=;
        b=ZfXkyFLoNLwSCxIt2lcXw2d4jOGw2BhBPBTFYcXhipfSjLsFGRUgNK6ftpTAP5TXWq
         ruwHEv5trPt3h2I/CyAqcbyOo83YrThS3Kjacjot2cOxAKpRgjgr1lQizsZ7yTchvihV
         ErsPeqGVBrbrrKzNFlwtX95iDjPuVYP5wRuiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=w+pEkVJd/h+WI+7Ik9xWqY+Z8oL6sb51sITpdGLwuE0=;
        b=aNbHJ3QuQv2wMGPx1E7kAJ4nH8cvs1pMPmYAF2twAfp/makYelNNmBZ59cfK0m6uAA
         ko/dAMNacMchlHChQRuBCjcgOEp5mvpkLAccGIwRsJJXoV+yfpipgbkKS8s4bGXS4/hu
         L8hcU705cjGeAIgcJhBcmI5hELWLDHGcusFfbGvfvXCyreAJJIezKyB21R3mBRyQHoK1
         wOxKs1+fGsQ6nUNFL6XNWIBMU4gl2N010GnXJczyPKHtCJN8zA/6Z5GHAQIgQz9dHcj8
         EWjy9LGxGPizcABu6thNbY8GXFguhb7wgh+nNm31YcEwUji7k0AEYpwubD0aYJazr5ko
         QQkQ==
X-Gm-Message-State: AOAM530qA1tRCvN/WMVDbDqYa8sDjC4uclgqRBEpkm++0vJjj4+jZfIO
        ij+knvPjt4JmZR2weIFhBSxTqccNeQSQa6oBymXytw==
X-Google-Smtp-Source: ABdhPJxksUjTUTa8Exx6uQm/t3KaU/loUjkBf+4L6i+ATrGe4465p6dpfz+D435OVm1pzqfNM6HNZXNRx4Iq1MprmqA=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr58677otp.159.1631044092581;
 Tue, 07 Sep 2021 12:48:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Sep 2021 19:48:11 +0000
MIME-Version: 1.0
In-Reply-To: <YTe+a0Gu7O6MEy2d@google.com>
References: <20210905210400.1157870-1-swboyd@chromium.org> <YTe+a0Gu7O6MEy2d@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 7 Sep 2021 19:48:11 +0000
Message-ID: <CAE-0n52d_GBh70pSDXTrVkD5S6akP4O9YcE4tVRKZcvLtLZSmg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Don't always treat modem stop events as crashes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        Youghandhar Chintala <youghand@codeaurora.org>,
        Abhishek Kumar <kuabhs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-09-07 12:32:59)
> On Sun, Sep 05, 2021 at 02:04:00PM -0700, Stephen Boyd wrote:
> > @@ -1740,10 +1805,19 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
> >               goto err_fw_deinit;
> >       }
> >
> > +     ret = ath10k_modem_init(ar);
> > +     if (ret) {
> > +             ath10k_err(ar, "failed to initialize modem notifier: %d\n", ret);
>
> nit: ath10k_modem_init() encapsulates/hides the setup of the notifier,
> the error message should be inside the function, as for _deinit()

Sure. I can fix it. I was also wondering if I should drop the debug
prints for the cases that don't matter in the switch statement but I'll
just leave that alone unless someone complains about it.
