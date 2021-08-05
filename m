Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C243E1B49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhHES2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbhHES2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:28:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18968C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:28:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso6112833otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ZRC0I+Fj57vTGFwWYvogXG/k+4kQPnUbqniQWnYcZfg=;
        b=l67J4s2FdbEQUdpUjbdwxT5ZWXBo7coElkyvPRot8BzRGsD7OfluQhMQXvWMN8wera
         HTFLYJfJ4dTstUbMW8RULuPXW0gNkJXbVeoM+2yuMI1ZnIpgwyBaJjyO+nowGugZ90OA
         E0Mr0nSqRSn4Glsgud+j3MH9hsV0zVRO7E2W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ZRC0I+Fj57vTGFwWYvogXG/k+4kQPnUbqniQWnYcZfg=;
        b=kP817WbAXHeJ6gVngYN92dqu8zGo78ZO0BT4Lo6bcTEYNzK7W7hGz/L2fFyuyZ66/P
         vshjKpLBaM9JP91En627d1LUL9D2XrwW4q5vQD7YfX/O7BOOasd00lvubnP11va62+we
         AsILgDD5agaxayeqdMS4x/AGa3PjM/ZEcYSduAlMAkhFvt44Lok+8stNV0JT8niq8qWZ
         Kf7V1NZECmBwsc7B6essLfyOqeE3UJhtTtxx7AmKIr0kpt3Z4n5bRvahpoKtcZZabyCz
         WMhIc3dAg2UioBx/zR0tVh7+7G9UmZHqnxlvguGuz7VjJpDOu//BFCN/6J/BuJEl8O+g
         189Q==
X-Gm-Message-State: AOAM533k903vKu8xMGVev/f6IB7tuMJoA4hEVl0JG1YocmsCqBUfgwIR
        dTzVgIhCz9XTg8rU1L9z4HDYbXa1fUfi5lJVj+U78A==
X-Google-Smtp-Source: ABdhPJxZ7zEQf3N1JXL0AeBYTCc21Hm0ef4XDvHY6j/YfT9L0BSzQ9VCUhwtGjkQCHc/t3d3W6Iz5b6rbfe9RR3O1so=
X-Received: by 2002:a9d:1b6e:: with SMTP id l101mr4676043otl.34.1628188099488;
 Thu, 05 Aug 2021 11:28:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Aug 2021 11:28:19 -0700
MIME-Version: 1.0
In-Reply-To: <1628161974-7182-3-git-send-email-deesin@codeaurora.org>
References: <1628161974-7182-1-git-send-email-deesin@codeaurora.org> <1628161974-7182-3-git-send-email-deesin@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 5 Aug 2021 11:28:19 -0700
Message-ID: <CAE-0n50CM=DpXx7fzrcnWox+ZSfqvWuEb-R_rTP8ghR+bd54eA@mail.gmail.com>
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

Quoting Deepak Kumar Singh (2021-08-05 04:12:54)
> It can be useful to control the different power states of various
> parts of hardware for device testing. Add a debugfs node for qmp so
> messages can be sent to aoss for debugging and testing purposes.

Is it ever useful after device testing? I'd prefer we not apply this
patch as it looks like testing code that won't ever be used after
developing this driver.
