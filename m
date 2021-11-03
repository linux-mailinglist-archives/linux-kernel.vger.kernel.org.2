Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B6E443A40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 01:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKCAKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 20:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhKCAKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 20:10:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA3C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 17:07:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y26so1682084lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTPaTBnI3uTKahtUXWpwKrD7YLY0qqSnFOplkZZDwHo=;
        b=GWoIAF5+7S75wVjiD4B+y2LUrJSa2rebj6DdjV9vt4snLgE1AZLikSmqjhgqM83btm
         +V/ImMuGAxqWsLF/+//yPy7HanwrOoUCoCMHtxzEpz0KHFfeAKAhji1HokhBSgMWtXcD
         pGG7rNUZzWBGJ9ozwiFBAgLcWS0iSidSDFbjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTPaTBnI3uTKahtUXWpwKrD7YLY0qqSnFOplkZZDwHo=;
        b=mgXi0jxKjMjzFll6XoFFIGqku+RgeadXkX+5J9adBugTu1N9SJ2YglC9O0dCQwEFWz
         9ekvr+6cE6ZvTkep9Gqo6rnvtiMefbC4MLLXZpJq6woB/CpQnvQm81+HxxuiHAFV2kDd
         sg2ymLw1GMNI3Scw4fJZW+EzmMi0qwUEF5Ckuvvt28dZPY6bR8L4uXa8Ufu3Xv+q2Jvh
         xPMCQhqaCNa6b7ZQ75mORQKGoQ9J9yQN66Ge7Nh5UqCfoROAfhAqVxwT+i7vAPcU3gs5
         HyE6IbDc9rWLdg9MqMlDq4sxGoLQWHF4EykMPm1kjfntQTKVGbVeW4/zXsuvB3psPhX/
         jlhw==
X-Gm-Message-State: AOAM531Rbc5uK8W5iWo9ETRMLLzasIMjJZdXU6JJrghar8UjGESP3L9p
        rKN74bCieKw+thqPEr5gDJFnYjuZK2QghT19
X-Google-Smtp-Source: ABdhPJwAuPJHai6sw09QAeUcY4aFRgSymOT4a8MLzMUaRJJ0Jwixj5unprwPMy3qGY/37ZAngETaCg==
X-Received: by 2002:a05:6512:ace:: with SMTP id n14mr36936496lfu.460.1635898056901;
        Tue, 02 Nov 2021 17:07:36 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id q6sm32431lfa.267.2021.11.02.17.07.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 17:07:36 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v23so913424ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 17:07:36 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr14555294ljp.68.1635898055944;
 Tue, 02 Nov 2021 17:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Nov 2021 17:07:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com>
Message-ID: <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v5.16-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 12:55 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Daniel Lezcano (3):
>       thermal/core: Make the userspace governor deprecated

This one is very annoying indeed.

How about making that "pr_warn()" be a "pr_warn_once()"?

Because I don't see the point of

    dmesg  | grep "Userspace governor deprecated" | wc -l
    19

almost immediately after boot.

              Linus
