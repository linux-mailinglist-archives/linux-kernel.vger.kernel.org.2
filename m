Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515C0311947
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhBFDBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhBFCh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:37:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492CC08EC2C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:28:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl8so4407313pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9Vg/6Y6014A/4yyhkeEbYIw9mlQkZEORNcu2Rw0bog=;
        b=wI2uVBwS5PbFdoFG+KbacEaeNBxCQ3oyY64EOGPG5AcFvJZ4olpJbXtMEASZWkg2B6
         geXh938YPsD8dUaGtFkQ5n4biXCnp9lK6mA6whQo1OhJ99s9+Dc+4kzk858AzxKG57/p
         LkBTtJOmjUw4VHpCbvxJIGSnNNj+FYfYi3CrZN//nW1CzlKhLQVe3QEveEH50iHQM1Kx
         CEHHp+xuWZc/10S/cr2+lisNuKqP2HgbsBug90mre6aJiQvxbBgr52liXmmP4d9GhWTn
         3gZnYxx5WsCtdUuZ4FmivqOoY/5vWDKNJ3bG2MZ0YVQWerYOL9ncWQ6QhbFTs8BpJ2oI
         C1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9Vg/6Y6014A/4yyhkeEbYIw9mlQkZEORNcu2Rw0bog=;
        b=cHLM11CN9KWj+ZD3A8Du8P4iIQ1mVuYyJ4HYGDSW8prgG041t+dFom3jCXgpbHHatI
         +XjfO612JfqsuD+QqIN3NWGPDisnvjTkTKuMCHDIox9caL10ggMP5QM/7QbD1Bi2O2zF
         jo6OdfO1Rz2AoJyXo3wobNKEW17eI4DQC7kGssCWtCXyk2Xy27mLGrEPg8pek8MDOljd
         oxRU52Piwyd2plEcKu/Fq7tbSI0kZe95T+YmzsJX4NITCIZaWWO+Q3SMbmwq/sZpAOlb
         xKqqcuzI9wDGrfN6xEmBwK+lBxHUkFzlm7zlCQ9bzq0HuRedxmfy+7SPq470C967qypU
         aLbA==
X-Gm-Message-State: AOAM531nA8SbJbtLv9TywT5WzwwdV3LmR1cfKYksWQLlgXWlP4zHSKW4
        864YovJENYm7eOktCA63vGmla0gpoVlT9S4ZQIkbC33OKYh6aA==
X-Google-Smtp-Source: ABdhPJyVIPrAcFHOnglt8XDNInhZpcNOqOkXnbSdoBOR5tsENhqfuHfWCoO8PScTHv2GRVbNVQ+yAJxh0MQLPmROmC0=
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id
 l6-20020a170902f686b02900de18c741f8mr6048292plg.65.1612564107195; Fri, 05 Feb
 2021 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20201208232102.339587-1-dlatypov@google.com>
In-Reply-To: <20201208232102.339587-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 14:28:16 -0800
Message-ID: <CAFd5g456hj7D_xQkYQZbSD4yhKxaJNY0iF1LjjkzLYgiB8avAA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: simplify kconfig is_subset_of() logic
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 3:21 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Don't use an O(nm) algorithm* and make it more readable by using a dict.
>
> *Most obviously, it does a nested for-loop over the entire other config.
> A bit more subtle, it calls .entries(), which constructs a set from the
> list for _every_ outer iteration.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
