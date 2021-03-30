Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5534E29D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhC3Hzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhC3HzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:55:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76439C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:55:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7238234pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbvBjbJlgSBferfsc3fLK9nLFbUPcwisVgWM/8EwoFQ=;
        b=scYaCXldbH24Yaj8rf20hooRzaL9q9mYQBox7S1Fzbhj8hDrOaVV4fzaMHOtOEXAaX
         95RlALWtcFv6kRHOuVWpX5Dhjkd3W9JdIk0G8w7wmNK2Iqo2CV2x0EoeTMDg++hy/Tme
         Hfaa20LTNCQGObNP0zpY95l7LxdNrnx8FW0dMLXBk/JjVZepwXUQKF06Yj+/85g0KbwG
         Jej5kGa8F9C+wcgn6wgPmO6wh4fDbjJqWPEwpV9XVwdPbygsvnawGiuyMshaNaZP+231
         ia2JDfx/oQKyG7rUuXFYCvzWihYT1mhnlG57DNVfmUemSP6a9dZ/9d8QpEOePeze7ET5
         lo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbvBjbJlgSBferfsc3fLK9nLFbUPcwisVgWM/8EwoFQ=;
        b=BZHpWNFO1hPrWw+qt3muWn/pKShsMXxnTwflG1ax+pNRCazSENHY0cs8AU7nWtd3TN
         4dEfJSyvIWEVY+VkGznTaoq8N0u2NavLnn7eK5ZW/LGvBWdh3fRjS/NneawLkzc8zYtF
         2LfM9BkRfdErudVXOYGdqHQonpFkeMF2zs9kPLGbkOK39IRQypPkKDu2f5N/EIM+c1Hw
         fbT9qmMmVWlGDGPtthDHLTTJhW+D+L53HmEyncSH6KN5MjzKlSZF40silj9emEJTzTzt
         tLJ7oJZyyCfUXxDm609U57sd9jjSwzP+8ujqnCVKjqi7iFVgou8KO3SEzA5ardHAqlkQ
         9MBA==
X-Gm-Message-State: AOAM532IqzIV2V1XUZUQMUhiAcieCMAm4LlF8kEwopqSCNmu9DY0GwOn
        kQsNOROn0xr0K9edphWDR6fAuDhkPB/Fnl17L/TWxA==
X-Google-Smtp-Source: ABdhPJwLEQ7tJ14eRS/yUEDEjYj48E8XhgZEj490onsnM44cWvBVkBRDKO0uYSr2bopLWyuPamm7GuYkbBqnmEuFoAk=
X-Received: by 2002:a17:90b:4008:: with SMTP id ie8mr3146042pjb.231.1617090924013;
 Tue, 30 Mar 2021 00:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org> <1617067704-28850-7-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1617067704-28850-7-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 30 Mar 2021 10:03:32 +0200
Message-ID: <CAMZdPi_SWn9a_KvfpNnKCLcq2gb+A7KmUth7zVTgWs+H-Okv=w@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] bus: mhi: core: Wait for MHI READY state in most scenarios
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2FybCBZaW4o5q635byg5oiQKQ==?= <carl.yin@quectel.com>,
        Naveen Kumar <naveen.kumar@quectel.com>,
        abickett@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 03:28, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> When moving from SYS_ERROR transition to a different execution
> environment, MHI host relies on the BHI register read to spawn
> the next image download or wait for READY -> M0 states. The
> device can at times move the execution environment to mission
> mode when a pass through is expected, which can result in a
> stall. Initiate a wait for MHI READY and write M0 such that the
> device can proceed with state change event updates for any new
> execution environment being entered. This allows us to remove
> conditionals in handling firmware load for PBL modes and keeps
> the execution environment out of the picture as it can change at
> any time.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
