Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369B3306B55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 04:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhA1DA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 22:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhA1DAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:00:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650D5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:00:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so4907556edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AP3tGQs6s5P8wm/ejXQRcsMvZE63wwCDiLfyGUDNGfs=;
        b=WohYZJxnkJWs7NUVxkokLpSvh3aAHm2vQIXOj9GWvPnRR5T21Lg8BGQhEbGdVR2vVm
         2oxfZ9l8wkZqomdDEA9hoK61SjNAlGoDAFsUyiY1xkNrmhXePZ1Sr5mvv41ARAWPYS7u
         GbbFV/towIWajZDXdKWz/4MlrN0665aWjhpQSLsKrLCtw5+V4rdA9JgNWgODMrojrDD8
         A7XKdvcYEHwy4hquJ/wG5xNRSrzs71yTDDursIPIC5MixJXC1j0knZNQlF8ZFbhz2hZ+
         /il6MsyYVgig7FrlcGMB7ZwUemtPb8ZYRy6iUuKTnYage2YlZpj326CCKhlpn2xCFrma
         77Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AP3tGQs6s5P8wm/ejXQRcsMvZE63wwCDiLfyGUDNGfs=;
        b=YqLB3BeeV0L9Bncso1LUR6F53AxRVVDLrf/ql/GG/nuLElzlPK9iAey4omq7KTPH2S
         PeafhS4t2nZYPQ7dmu0zhNqg6RSsoA5+o+AUNirZU3wUtPu7NHdr58VcPIM+KDEfkJpu
         0T6n0ttYanSeYsIwGwmsX9pQcV6rZMN3M3TwyzYmG9ToTci43yX2h4QT45eqvFoMIBGZ
         lZ79YHU+ARK/kziMfNfAnHlWSiSNtlXB0dtaHa8PjtRHkI6DHbioScWqCox6362JY5OQ
         HO8xyOg11Ie3BlD5qQuit4/u0COD+xgMhfYEiqBREUl7P+w0TAtTWO1mD7a6gPvDspZ4
         QFHw==
X-Gm-Message-State: AOAM532xSsCNweOAyhaerjOekSJPTyfRGZq73H0KEUrj1YzEWURDQuv5
        ghaokdimPyPwdpXcC0ZewruEr13V5HboUvxxa8Sw
X-Google-Smtp-Source: ABdhPJyGUyWZpntm+TS64e45JgJCqkq+loUyRGPu4UOhP92e5dbVN00ikHNfAurqWEkwaMzIrKqGJDgoiCAg37Ck3qs=
X-Received: by 2002:a05:6402:54d:: with SMTP id i13mr11785340edx.12.1611802811444;
 Wed, 27 Jan 2021 19:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20210127025144.24253-1-yang.yang29@zte.com.cn>
In-Reply-To: <20210127025144.24253-1-yang.yang29@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Jan 2021 22:00:00 -0500
Message-ID: <CAHC9VhTsQ4j8EYd4H-PXmZeFhqHeyV2GDpNikU-tw2qMtbFyUw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Make audit_filter_syscall() return void
To:     menglong8.dong@gmail.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 9:52 PM <menglong8.dong@gmail.com> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> No invoker uses the return value of audit_filter_syscall().
> So make it return void, and amend the comment of
> audit_filter_syscall().
>
> Changes since v1:
> - amend the comment of audit_filter_syscall().
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

This is a simple enough patch so I think merging it during -rc5 should
be okay; merged into audit/next - thanks!

-- 
paul moore
www.paul-moore.com
