Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EE44AC90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245739AbhKIL2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbhKIL2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:28:21 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3799C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:25:35 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso11401185ote.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDizYRLdhl/XpmR617V9H1nya21GLh5Jm8U5bQ4LhoU=;
        b=pcchXYWGxC8TUsHCp5znzNf5KqyQkyCyzfUCSvDkKHtx5mWHUOO8WNnGzpEBxmV+6x
         aS53nZCnimN8PLnkVqe+PR9PUrCbU4qVIArU7eio+orLNFpyUvA57zYi6QtFSL9yQwyK
         toptpZysma61dUrGogLMOO28VVX3X8hltPZU/6jiQzXHizfhRgzTVDI6omem/foZmPRr
         By/xAszBff15g/bTqwowz6AwZtZlD+LEJlB7UhaqxNA+cNQGVNdGq1MA4grHWL5Se8Hu
         nXf9RHpSS2PYZ1saAT1TJe5mHgonWHRqsxCU6t5J5uuEtdrLOdR8Z/RuPs7d9CmpsVrs
         Ij/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDizYRLdhl/XpmR617V9H1nya21GLh5Jm8U5bQ4LhoU=;
        b=a0EQcVDAZyPaxg8UD5oQmPMLB4waS2/J7nDbvdqHFJ/PDj5oN5x6FglQFgLVx/XrMD
         vtBIL/rnKF2qKiXsbBvPI5Mk+u8dxIR8LXjgbnWZus7yVSV3UNcazMDwfWW1JapNmCxv
         C5A9KbPyQ2SsFRiqBd1o4nKOjezxjZSuybToMZKE3FflgmOoKMygyykoEp5E8k0AXPpJ
         v0oJ8FF3YMNxh5cGruWRC75NFjNvhaDvAin7h1I5sSV6iw8+8zfu/AgHOyr3BWk5iF/Q
         nK3YM8HK4gERwahsmjlG9sMkhHxrjZtUZ9rVlCKL5cDhkDEyLUh0I3e4e3NfuiUWmJRg
         o63A==
X-Gm-Message-State: AOAM533tSWK8J+qjfs83od4sduD2BOLwPpIiZSqaECq8qHWIjjeHI862
        69GQBgPuxmtMDNJ3O0YiAR/RNmrthjErSYIHcwq7Hg==
X-Google-Smtp-Source: ABdhPJyRH7wRwc40p2pr7KQ1rJshmkwLCVnX0dMDih0C93l57ktFNpTLf45fmsBytgVH+zEml5yVgY1zsZUMIy6VYk4=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5349659otk.179.1636457135054;
 Tue, 09 Nov 2021 03:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20211104133645.1186968-1-arnd@kernel.org>
In-Reply-To: <20211104133645.1186968-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:25:23 +0100
Message-ID: <CACRpkdadqcKr-Biq4oS-zeO0RLQHOXk+V3ORLeTbbRk2+XqE4Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: tegra194: remove duplicate initializer again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 2:36 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> An earlier bugfix removed a duplicate field initializer in
> a macro, but it seems that this came back with the following
> update:

Thanks Arnd, patch applied for fixes.

Yours,
Linus Walleij
