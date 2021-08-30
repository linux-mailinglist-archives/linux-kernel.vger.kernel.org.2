Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1653FBF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbhH3XCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbhH3XCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:02:07 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83AC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:01:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso10284893oth.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SBvWEFE7ZHRV6dF93YeVztgkppDJ5iGt+SWnxMoR3Zo=;
        b=K2aL61yrvUo2pFacIrBVkLxIAHZ0ijDkNx0/BdyNj2ChxOpGGi2qY7C9FxzMzGGMOu
         I20sjcqzzPEaxBrwdCj351IE5YaIWm0Wx/E/ou/QxI9ebJ6K/zg86A+ujSPHIphzLG9K
         RA8odMrTuEgsYD1dRHXJAjSU2vAdSrFMTRgIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SBvWEFE7ZHRV6dF93YeVztgkppDJ5iGt+SWnxMoR3Zo=;
        b=srtPMUAszLKdV/37qHOW7BedsC6csmO4Np1PNJ4GLIwjzwBijBQlO/kDHR75TQNHsV
         PgMkZXjpe6xdGHIEesoOzb56dscqdUqfG3RBqWAvZhsG9QJc0BeCIsqKjAXmHeEn9Y/7
         JW9v1M2cNLKkMVSq4wk3p66v2T1U/lqSkHSJGqNUo0MLfT1vAl1x9dbApbeR58mL7v/x
         OnoJ6qvElY84julzKAUsgfCTX3iMdJrWp+wA6/WgHahL4o3Ppinfn6aNxsQauPFqWWcQ
         HM6xjoyI9Fhq6od8nKP53eqtIMApDplEBVuF17onUL/bhyxENw2RtT3UBYrn/uO49HM7
         SfZA==
X-Gm-Message-State: AOAM530SKNfFvAcG593cJjk1i0AWIsPRmCFuW2SbwwTLxGdERafl25BZ
        tws67WE5X3BT3zW2I/TTn6BKwA1sU8AQzj5i74MApQ==
X-Google-Smtp-Source: ABdhPJzSgj0nb7XkGDvk91kYGxUZ0WsaC4P3ErcshYBpH3DFM0ygLAqpUPjQZwKpE4ssB9Qo4tK9MMB77S1hsManWOI=
X-Received: by 2002:a9d:123:: with SMTP id 32mr22337333otu.124.1630364473117;
 Mon, 30 Aug 2021 16:01:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Aug 2021 16:01:12 -0700
MIME-Version: 1.0
In-Reply-To: <ff8ede00-008e-4dfb-7a39-19242d421462@codeaurora.org>
References: <1628161974-7182-1-git-send-email-deesin@codeaurora.org>
 <1628161974-7182-3-git-send-email-deesin@codeaurora.org> <CAE-0n50CM=DpXx7fzrcnWox+ZSfqvWuEb-R_rTP8ghR+bd54eA@mail.gmail.com>
 <ff8ede00-008e-4dfb-7a39-19242d421462@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 30 Aug 2021 16:01:12 -0700
Message-ID: <CAE-0n52YXvTzvK4B3Aggg1fcRyjy=+HzNADP315-J0iJ8bMWUQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] soc: qcom: aoss: Add debugfs entry
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-08-30 04:46:53)
>
> On 8/5/2021 11:58 PM, Stephen Boyd wrote:
> > Quoting Deepak Kumar Singh (2021-08-05 04:12:54)
> >> It can be useful to control the different power states of various
> >> parts of hardware for device testing. Add a debugfs node for qmp so
> >> messages can be sent to aoss for debugging and testing purposes.
> > Is it ever useful after device testing? I'd prefer we not apply this
> > patch as it looks like testing code that won't ever be used after
> > developing this driver.
>
> This is not only for testing. Some user space clients can also use this
> to send messages to aoss.
>
> One such example is setting higher ddr frequency during boot and
> reducing it post boot from user space.
>

The debugfs file system should not be used by userspace to do things
like that. It's a debugging file system, not a configuration file
system. If you want to expose userspace control for this it needs to be
done in a different way.
