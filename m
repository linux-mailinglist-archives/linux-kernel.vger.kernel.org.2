Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E453111EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhBESZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhBESZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:25:09 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C4C061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:06:53 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v3so5932261qtw.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1SnUQvvJFVGUDmyI/HbNzv1A+eazXBXJNt9uOQ1H4g=;
        b=fMOeQikRm2vVrJjbOCuDn0Ioz73F7UllAc6wHTQe/TPFng8G80W/6+yvjyWw9YIRIk
         L+o7Ypci0ff3UNDGzyTiq1Av56cFJrJn6VTcQLbXBoJUTTTkShhKAuwX4+KnfqaNiL7z
         iQAg/dK/y8uAQDT6HCfaB0SPhwzwyP+i23p/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1SnUQvvJFVGUDmyI/HbNzv1A+eazXBXJNt9uOQ1H4g=;
        b=GkgThQSyUI8JWVmDCkg7UM3YbswGkwei2Jmdao9DlrZbtG9aYtQ66d0gPIekwCdsSl
         QUvXRfH3OcmovYiIKazU1nlyaTY0bJPTAMNmLEHGpdEhrOHOznks7kydqCfzTn32cy2N
         PQBvpEQ3C3fO6bQyJb2a8kbBrv+hczDef/lDaXJxJaeJxc4KOgBPRHy3VvlJy5OU00MD
         RzZZtx83fC+KPVPiD2PFUbGhJuaA8yoDT6XnN+5afQjV2ZPSCouTyw613NvypijBBOre
         AQapAdE81u8EULAS0c+Y53hWnmRsMgxymjQKUmFYph6sGGzKc3Aw9znzgvFun+7hQs5Z
         dzXg==
X-Gm-Message-State: AOAM5310jkabjxhyPSDCL7O/TYmQJKpUoi7nbi1jcl2gCUA6vpuKc/xU
        5LWSueJuN/0P88HTmPs8bsQmkF2yThZsd7dq2o+6zA==
X-Google-Smtp-Source: ABdhPJxNUfh1pF01fFr43TmJNHcgwuxtGvmUQk1PyBjIcjWkcN5j2hMZFbuz7/74YAJiwk9rvmogTmhGqxV4E3hC3UM=
X-Received: by 2002:ac8:7456:: with SMTP id h22mr5849556qtr.297.1612555613044;
 Fri, 05 Feb 2021 12:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20210205195113.20277-1-rajmohan.mani@intel.com>
 <20210205195113.20277-3-rajmohan.mani@intel.com> <CACeCKafY=mFBC-6VKsnOgZc6f0Y_FraQrdRnbKQ-k448OgExDQ@mail.gmail.com>
In-Reply-To: <CACeCKafY=mFBC-6VKsnOgZc6f0Y_FraQrdRnbKQ-k448OgExDQ@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 5 Feb 2021 12:06:41 -0800
Message-ID: <CACeCKafOshFWFC2pCCitNqBA1WtumhTHyC7rJgwpcLosup7j9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_types: Support disconnect
 events without partners
To:     Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:05 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Raj,
>
> On Fri, Feb 5, 2021 at 11:52 AM Rajmohan Mani <rajmohan.mani@intel.com> wrote:
> >
> > There are certain scenarios, where a disconnect event might
> > occur on a Type-C port with no port partners. This is required
> > to enable communication to Burnside Bridge USB4 retimers.
> >
> > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> minor commit message nit (apologies for not spotting this earlier):
>
> This patch alone doesn't add support for the "without partners" part
> (that comes in the next patch).
> This one purely adds support for disconnect events. So might be good
> to update the commit message if possible.
Sorry, I just noticed that I interpreted the ordering of the patches
incorrectly, so this commit message is fine as is and I retract my
nit.

> But otherwise LGTM, so:
>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
