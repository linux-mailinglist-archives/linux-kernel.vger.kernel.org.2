Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2C329A47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377295AbhCBAqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 19:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbhCASll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:41:41 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F5C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 10:40:54 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b130so5977214qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 10:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkLZdNbvLFDlwE1SwAhQ+C2mF/JHbfuAJhOZU57wMJ8=;
        b=TeklHcLCVQd59aWhG3y1h8Ry46VzF/QVz8mHAhk9QIno7HKuUcNcrOnxnA0jwfhEwL
         WL4DYrs3a4eJIIVAUnHHLF9KTQV7/ztyskEV1PELfHyB4Sd8Hm2+QcxHf8olsG+anMG/
         V9SLfZXBwuBRSsDn/BMHyRPogaOjl93GoUKBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkLZdNbvLFDlwE1SwAhQ+C2mF/JHbfuAJhOZU57wMJ8=;
        b=FHIS5je/FUlfkYUKkavboMZdHb5o/bvPqZsEcfu9VWtkdeVVRym7pGJMhX8mCv4sik
         cxAtPR5bmbkNkLGbHSya7W5Eonhl0jo1PMQBO02qaCC8Z0fD+ryXo4XI6J/T/ivnHk9V
         +UrOgLfvRr4tSdYNobiNUG5mLYjn6egPG7N7SZwgCLKJ+Laz9CJ3pSCIYywilbyaviOP
         UvaFGyKIXVvZ8IHSXBxYyVBz4iGs+JvKzS+tzL68JTEYJ6QFOvFPHlezPJYtuZxDnFp+
         D+0N/6R+E8MP3TuH7FtAvUwVzLzY8fEYYEt5UHFV7FbHfRYlf9thoASeREujwZXBC4x/
         pCfQ==
X-Gm-Message-State: AOAM531lU9pjepncujVBjzQpSBNVLU+ZEesJSY6U/R6xAuJZzABiQLtD
        QjH7y0Qg7vUlhGbdY6venX2eKV9GVfi5Zw==
X-Google-Smtp-Source: ABdhPJwf09qZmHKcIuBAfJY3pyKJSiORh2SpoBM8yf38nBZ5NeEpeUPf/kYCj7p2B/JsZfz+dupj5w==
X-Received: by 2002:a37:af83:: with SMTP id y125mr15509195qke.210.1614624053822;
        Mon, 01 Mar 2021 10:40:53 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id l6sm3033816qke.34.2021.03.01.10.40.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 10:40:53 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id m9so18002661ybk.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 10:40:52 -0800 (PST)
X-Received: by 2002:a25:aa43:: with SMTP id s61mr26388944ybi.32.1614624052460;
 Mon, 01 Mar 2021 10:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20210224070827.408771-1-sumit.garg@linaro.org>
In-Reply-To: <20210224070827.408771-1-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Mar 2021 10:40:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XQAWoAQ1kkyJ1QzhJgueCj0Lui1m5cxgPQXzThxm1SGw@mail.gmail.com>
Message-ID: <CAD=FV=XQAWoAQ1kkyJ1QzhJgueCj0Lui1m5cxgPQXzThxm1SGw@mail.gmail.com>
Subject: Re: [PATCH v5] kdb: Simplify kdb commands registration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 23, 2021 at 11:08 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Simplify kdb commands registration via using linked list instead of
> static array for commands storage.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v5:
> - Introduce new method: kdb_register_table() to register static kdb
>   main and breakpoint command tables instead of using statically
>   allocated commands.
>
> Changes in v4:
> - Fix kdb commands memory allocation issue prior to slab being available
>   with an array of statically allocated commands. Now it works fine with
>   kgdbwait.
> - Fix a misc checkpatch warning.
> - I have dropped Doug's review tag as I think this version includes a
>   major fix that should be reviewed again.
>
> Changes in v3:
> - Remove redundant "if" check.
> - Pick up review tag from Doug.
>
> Changes in v2:
> - Remove redundant NULL check for "cmd_name".
> - Incorporate misc. comment.
>
>  kernel/debug/kdb/kdb_bp.c      |  81 ++++--
>  kernel/debug/kdb/kdb_main.c    | 472 ++++++++++++++++++++-------------
>  kernel/debug/kdb/kdb_private.h |   3 +
>  3 files changed, 343 insertions(+), 213 deletions(-)

This looks good to me, thanks!

Random notes:

* We no longer check for "duplicate" commands for any of these
statically allocated ones, but I guess that's fine.

* Presumably nothing outside of kdb/kgdb itself needs the ability to
allocate commands statically.  The only user I see now is ftrace and
it looks like it runs late enough that it should be fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
