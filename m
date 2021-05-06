Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC937524E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhEFK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhEFK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:29:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C6C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:28:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 124so7063564lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZNOhBeEM5C31xha9JfLvtCS2oxix//QwEq7N4Ccskg=;
        b=j8oZbJn1c5LOWmijJnuNMmKBK4pnlwUx/8kw2pJ3W1xrCxF+lzoVwtvQoUT/uj5W5H
         rJQ30kHDn5BMpTCRj+SN60JSQqQiIrDMZqdyo79gkS2QM8leSWaL6g2Ntdu+JolyAENG
         S97+q187JWRYSstjnQ+dFJyQFH0lCprEzQ3qPmMjXPI0BhYEOBHnvgIXO74Ez5vn3/IO
         Cu+6Y8L15l/+llqsxsm4ew16mJ+6FQRoqA9I8yK5whqgJuu6OOx4qBG+LOEf/rigotJk
         SAOsyvN3Js8ObkvIizEoBHH7RsjjbDf7jq0TwJDzP/NQZVTlV+ZdjgW0htJ9L7jNDRm7
         tW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZNOhBeEM5C31xha9JfLvtCS2oxix//QwEq7N4Ccskg=;
        b=jYdTDDg9oXW6bS80ukfLi6J2XhKz0D30JhxKMKfEmY4VVCKIplXvYABsEKziyIFNqn
         toRERyLSexEcWy/+SlTKAGLnRtD9TkVDAJks/l2kmSBn5M51+vcFWb9ATmehj9gLKFfM
         D+DE4WH1LFdv8kxMzt486xcc0ivJX21MIOd0z5p4lyfl7nU5uPaPFyW9x6kaiWK0gA05
         kN7VtETZ+FIuo4UhXQRjnVTMdq9w307xJ2H/bNG0pZFf8jle7WNcTkbsFS4keLLUCXb7
         oKT1F5sIQQOmdmacyEOyx0o8e5Cs1QE9z3pIk665OyW+strBJmVmZ/PCX2tBnJ7BmKMY
         oLNw==
X-Gm-Message-State: AOAM530DfJ35xGNLl2JZwd1GJ7Q6VVeZeQs5fLSj5edTdvsYQYSjEwat
        6vOp6pXsXBpZxnTMcm/xtFQfdGAID11D4vEOhKl/HQ==
X-Google-Smtp-Source: ABdhPJwlgHJu+1IskB7Q02tOABmCQAAeHyauwOrO5GLFd2PnQBk76TGD4o2lCLpBIaRneREhAq5GXjvJwb3QpYzkfck=
X-Received: by 2002:a19:6755:: with SMTP id e21mr2490150lfj.29.1620296910200;
 Thu, 06 May 2021 03:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210428185457.3719842-1-clabbe@baylibre.com>
In-Reply-To: <20210428185457.3719842-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 12:28:19 +0200
Message-ID: <CACRpkdZ60R+AKTKahbZfktDqCBzaspRqeOjQdR2VV4YW8gAwSw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: gemini-rut1xx: remove duplicate ethernet node
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:55 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Two ethernet node was added by
> commit 95220046a62c ("ARM: dts: Add ethernet to a bunch of platforms")
> and commit d6d0cef55e5b ("ARM: dts: Add the FOTG210 USB host to Gemini boards")
>
> This patch removes the duplicate one.
>
> Fixes: d6d0cef55e5b ("ARM: dts: Add the FOTG210 USB host to Gemini boards")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied!

I even have this device, I just haven't had time to fit the serial
port.

Yours,
Linus Walleij
