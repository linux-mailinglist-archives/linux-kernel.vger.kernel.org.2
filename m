Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0030330A31A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhBAINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhBAINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:13:17 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA231C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 00:12:36 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id g5so5617578uak.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 00:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghOqdm7965Gyfaczx/hxpxYfT0qkQ9gCpoLT7+xG74E=;
        b=fkTdqYP24xqMbBr9zQ4dt63z88f/jqNr/xwUM9kB5BVATXqxBSq8ehXlD7ugepoxVs
         wTWOi66SBEXchDNUcIQKspJbcJqCrqg0/k69uYevD6TBKbnH0T2xA+YEAHc9RuCbCI5L
         YYOE9E7eQefltNUzWL9YZ1wTS+VerycfA017c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghOqdm7965Gyfaczx/hxpxYfT0qkQ9gCpoLT7+xG74E=;
        b=r2A1j4pANZKL4jWO0UPFpabIJj3QoaVtVIaQ2hLg365H8HB8QgwdIrYfFmA58Ax1b3
         bjoHZqXdMo6R+JOIohYLzQasaIEYEH3tOuaUYg9U6XO7P33+kSC4klthKxfiwYfhP5WK
         oDKSac9lajrQhcxuW8ueptJ7QWNyok428AW3MdmKSSQWa0MQj8F7XqtIvnQAOu/E56pt
         XLSrguP26r4rVryaEVL1BOgNpGWysITkvGhChr1eaWExzNy2twlMm6kSJ5xSK28oFeq8
         PoUDgCvW/5iCbnaIG2AM2ZytLw73hBXFuO5crhtD168IQFnQnr7ZyOwMKm/TTx4fKqq3
         QWJQ==
X-Gm-Message-State: AOAM532ziUN6WDwAo300LdUsc1kF0y9N5MPndaFf8U8A64tTu4onEx6h
        fXs12NPClziJgMuOJvDagikzOmZ3wQdnq/kkId1Iqw==
X-Google-Smtp-Source: ABdhPJyAIHRtcWwRgGn6OmwSQ8c39e4lJpKCtvim4TD3znSJq4dgdezFFZx0jQQd2cgv4aQySL5Hi7BPEse9b5HE2SQ=
X-Received: by 2002:ab0:702a:: with SMTP id u10mr8228537ual.11.1612167156168;
 Mon, 01 Feb 2021 00:12:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1598331148.git.joe@perches.com> <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
In-Reply-To: <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Feb 2021 09:12:25 +0100
Message-ID: <CAJfpegtp9zC5u+D=YJt3Ec-moALCJxkVswmZEFJWb-VXfLXmaA@mail.gmail.com>
Subject: Re: [PATCH 23/29] fuse: Avoid comma separated statements
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 6:57 AM Joe Perches <joe@perches.com> wrote:
>
> Use semicolons and braces.

Reference to coding style doc?  Or other important reason?  Or just
personal preference?

Thanks,
Miklos
