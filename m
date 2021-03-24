Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43157347D68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhCXQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhCXQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:14:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAF2C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:14:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u9so33818219ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yjhqFa53PHX3d9loi2O5cDwSziH761lUQLlt0NCNAQ=;
        b=zQWguNtnv0Yt7bqUE/htWdtwGen8f7mmY+4nHUqapCdolk+vH6JOS5t4wNtSed1UXx
         6Knv17C0BSMUvvbA1rrPVn0OEfkY5GLOLy5aSgulKlInrm/Hej9aBXPyVp3gGcomtIDk
         OLLyWPZYFEAfloqq2E/+v+/AKCscRCH2BOdqaGfgk1W9vTFIZD7DdwoyMEbBVv9WZCZF
         sXae0TtY1uCyX0Izh0weLyYMjeVmEXtPij3SwbZK4N+jEwZW1K3VfUPEClC5SmomoXml
         rDZrh8qnC0opiZdVcHN3hGBKo1gRAKbfMhHxbEOILf3OK2gMfN8J9AAgHCP5E9JYvA9F
         diJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yjhqFa53PHX3d9loi2O5cDwSziH761lUQLlt0NCNAQ=;
        b=rPvTzDvuWXF5hH5kDRcHm9TKdPJ1M/ieczS24RNoDXkxutKOf9DlSCU4h/zCsqKiqj
         2j2pidF9QSzavF+ePRI4HFpjo0RaQQouyTjpFT4HwD4ErkvycjcqeAu+t4PJIfjS9yy9
         +b84+cqPMheTeVgadSC+cIDj93NViii3mzjRCWgEE2YiiinsYaEPAfmLbHUOOkU0jnIT
         p8oM7GbAoC+ZGXaLt3mic3DY4jFJK2+HdCn1c0BpKiSQWstklSv7pEx1mqc8BaQzlRl3
         SGYTsSWnZmbMAl+4cAxI7ScQlMgOnwd/HVQa8rwYm8IBexEV7pHcdlWobURDQ0xyBjQG
         OXaQ==
X-Gm-Message-State: AOAM532j2JcFZVvxeKw9qFjd4I84fSMOFMpB8C7V8Skr1xw9I6eFIJyC
        w97ORBCDJSp2Lk0Av2OhQYbTR2tfUuW99SoIUfcb
X-Google-Smtp-Source: ABdhPJy56s6lXQIeHNRPTcHF5WZ4yLX87CphzyYXVhw0puQNNlJEliZr5FjZU9e4w5eArUh+FbfkW4m2chbwuqpkfHk=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr4630582eja.178.1616602463170;
 Wed, 24 Mar 2021 09:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210322162807.679370-1-arnd@kernel.org>
In-Reply-To: <20210322162807.679370-1-arnd@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Mar 2021 12:14:12 -0400
Message-ID: <CAHC9VhQEyA6iy84j=Bryvxwp7EYVN2JibTqMmWHk_hTs6Kkadg@mail.gmail.com>
Subject: Re: [PATCH] [v2] audit: avoid -Wempty-body warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Eric Paris <eparis@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Jules Irenge <jbi.octave@gmail.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 12:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc warns about an empty statement when audit_remove_mark is defined to
> nothing:
>
> kernel/auditfilter.c: In function 'audit_data_to_entry':
> kernel/auditfilter.c:609:51: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   609 |                 audit_remove_mark(entry->rule.exe); /* that's the template one */
>       |                                                   ^
>
> Change the macros to use the usual "do { } while (0)" instead, and change a
> few more that were (void)0, for consistency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: convert two more macros
> ---
>  kernel/audit.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
