Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3331B58B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBOHOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 02:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhBOHOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 02:14:50 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 23:14:09 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r17so241728edy.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 23:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CefDFEkybrGN+T0rEOjeJyX9h7vbSSt5IaSGMgW0+xo=;
        b=f5Wwm1hWE+mDtDxQ+nbbthGdlpMHLlmM1euLBrGWWdIrnY6G74c9RYVywxJr2uc7L9
         2OcvsjJTFjiaCavupGY0u7Xxth2iCWqM8wwcL5ZBwJqs13YTrvI838RuLaSQwJx835j6
         5rw3a6zi7+iwTD9ecpN3ybmaOPveo/rT47OvcdZLP1Olj5rWl86MJXi4EUGaMzcJ4z+f
         IAjRnpM6iJ7zPcgvyJTE1Qo59aFfH+5HL5mermNRKytDCa1dKLSn+tUMLlpNSMlq2SP4
         aU361Tbfw+Edd26882xCMXCBrwZim/ij6wlRgaxdDc+aR+KjmeDBi3J+wztm3KHt+zNN
         F/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CefDFEkybrGN+T0rEOjeJyX9h7vbSSt5IaSGMgW0+xo=;
        b=OjSEKzfxoq8mf4RETKv5vJm2jw300bXnLT9y4+3MyjuLpGWS6a1efPQLSdWTLPfmr9
         ZVv6Zb3f4z6trrY91e2kB+WIdR5ST1YTGOn+ib4QeW2+ih+v7TEgDw0GDZp7rhto3qd8
         jCcmQS4oANt2I3P0LsYCNKSMnq6sGNfPqEYqncANoZhfzA3mhJWON30CS6rknEDhKwsW
         eH0SLA6onMmRBNAyCQOupUQAojrgNz0frJbwfUl1eUVeQPL62gGwVb3S62JHhA9FsE5w
         RrhTuRvieeXKVnVxVF1M1MAS1hfkcFhLUgd1/nN3R+KKGu4I8MmpPbni61eSpHKKTgWF
         jn5w==
X-Gm-Message-State: AOAM530x//P29RCR5e8CjWDhbwZY0gssirgG5rQB1WZ0Zrb1E5HqJxmp
        lTtqJhTtJTFMpITb9sIZbG+tj3P+yzu9THUiVajuwQ==
X-Google-Smtp-Source: ABdhPJzIsth1gsdugeCLLoJgTgiNWZTF2WcqLI2r3yh5TzjlOIcaBmKjSd9FcsEPjXKzYZuBgByPYVCc06Fc+mIiXtI=
X-Received: by 2002:aa7:c308:: with SMTP id l8mr6661209edq.366.1613373248473;
 Sun, 14 Feb 2021 23:14:08 -0800 (PST)
MIME-Version: 1.0
References: <1613176814-29171-1-git-send-email-jhugo@codeaurora.org>
In-Reply-To: <1613176814-29171-1-git-send-email-jhugo@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 15 Feb 2021 08:21:46 +0100
Message-ID: <CAMZdPi_xpDmGRWP7TObR-Sj45pAiUK9YXoSXQgEnfoL6YQy4Fw@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: core: Use current ee in intvec handler for syserr
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Feb 2021 at 01:41, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> The intvec handler stores the caches ee in a local variable for use in
> processing the intvec.  When determining if a syserr is a fatal error or
> not, the intvec handler is using the cached version, when it should be
> using the current ee read from the device.  Currently, the device could
> be in the PBL ee as the result of a fatal error, but the cached ee might
> be AMSS, which would cause the intvec handler to incorrectly signal a
> non-fatal syserr.
>
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

So in that function, 'ee' should be 'previous_ee', right?

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
