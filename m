Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F5B30CDFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhBBVgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBBVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:36:35 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C278DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:35:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id y9so10678011ejp.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3W0QXjSj6WJdZVt7QsEUQadUyum+DiV55Mp+gEhAQSA=;
        b=d+ioP7sCaJBuJXvHwqoiZkEy1fSQnPjbkM3hLPyHPGkhyM12QUHqiQpfXxkBxOqlso
         g2oRQkNGTMdbOEClUK7wvNNJ1KRBiIqRoY6BLvWo6nvzYgSAugliNnm0CBfmxqfgVKax
         eFvR2xxj6KhPiaVr9ytFW5OZnKzSdr/adPKmrvwj43sjPcFi11sCcYNC1ESVuu7KkW+Z
         qk9K4GzNywex+/J0ypp2mfI8g2lB/oomiuYT6RsAdxwwGPcj1jb9M9TmG7xet3K/xzf6
         TnJu03I1Y9vxqB4iU3fdu/h3rYxfVAEchEzZnlI5bmTkwVtjfqChKW2xMLWk+LAhkdrc
         Ky/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W0QXjSj6WJdZVt7QsEUQadUyum+DiV55Mp+gEhAQSA=;
        b=Q6HMGrJZAhOa3+lBZLDeEiiRwHgCfw3g4QpK8SYqUX/mlEvIwJ6fLSjxVaZqqFUa2b
         nXdIYeUDI/4IHNIQLOI40i3hkWFJNsSaY5XFlOkd2juSR4D+HuEJi1de26JrUr4ogiUb
         sfqvZPYDM0f0RFvZNPjVgJcsXAFJ2jZ1Sh9+3Fe4djx1SVRTZoEujpSm1kvTutzZnKtS
         yqDu3YQJNdsPqB72CnKBWkHcCfRhGa3woMkMaDLkBCLm8lVu68uJBv4UHo+1vBdxiM/O
         3B6DraLGdb8EAsreHqabiOjyjjgIcZDwb3ObUDNpAyfAclE3ADszQ2IGw13GfxNCwymw
         bl5w==
X-Gm-Message-State: AOAM531zpI6e77MvSJdArM7RFjejLiFpnJdPO85E1zmyYSpt/xxeBI6/
        ecA3v8+QA/qn2Q0tet7Yt9qB9hM8iXMYbvAo9FVa
X-Google-Smtp-Source: ABdhPJxMKVdU7ng8yeFfmrPNdyZcm9VSHIfKD9qQljEp7HDLPkm9J0tzuIfNrwP4xKIR4fZRaLY2dvkmvsyF+J5DC+s=
X-Received: by 2002:a17:906:35d9:: with SMTP id p25mr10945ejb.398.1612301753339;
 Tue, 02 Feb 2021 13:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20210202212930.18845-1-danielwa@cisco.com>
In-Reply-To: <20210202212930.18845-1-danielwa@cisco.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Feb 2021 16:35:42 -0500
Message-ID: <CAHC9VhShkEJHWmuE2C_RLQy-Z3CpvAhTj68ki22v=AKF5hfvrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: show user land backtrace as part of audit
 context messages
To:     Daniel Walker <danielwa@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>
Cc:     Eric Paris <eparis@redhat.com>, xe-linux-external@cisco.com,
        Ruslan Bilovol <rbilovol@cisco.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 4:29 PM Daniel Walker <danielwa@cisco.com> wrote:
> From: Victor Kamensky <kamensky@cisco.com>
>
> To efficiently find out where SELinux AVC denial is comming from
> take backtrace of user land process and display it as type=UBACKTRACE
> message that comes as audit context for SELinux AVC and other audit
> messages ...

Have you tried the new perf tracepoint for SELinux AVC decisions that
trigger an audit event?  It's a new feature for v5.10 and looks to
accomplish most of what you are looking for with this patch.

* https://www.paul-moore.com/blog/d/2020/12/linux_v510.html

-- 
paul moore
www.paul-moore.com
