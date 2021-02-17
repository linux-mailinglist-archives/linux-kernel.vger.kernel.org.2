Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7B31D5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhBQHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhBQHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:10:28 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:09:48 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r75so13968275oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fl2ViOY9h56E961Hc/YiKWFXGdUJS84TzaxmxWiWeG8=;
        b=kVqbPlNevld/jctgmmXNvAy3mm/wZj+H6Y6B1yvKoGltN9WB9BtjsIGLhBdLfEgi5x
         XxlGDM8rPeNO5CJ/zqblFDECrO5Ki5MV/1uXzhdy8Jv3RiLSG0KDcbcULhMi10IJG0JN
         o9PM5TkDqgJYUS1OIaU4ihtgtL+ZxovJ3ns6/EbsG3xi4WjPgZJtWGosoudWLXvqrNn7
         NJJebomdfzd2KdPc7zPNR+POxpQ+ecc4hdxlVwkcOpUBCBe5cW+O1MEQuNhvRpeZLs0I
         ij7H5z4iyMgxIIQ4+RgVJOj+4L/ndVPVGpgEQnSPLpY3K9DjKeZxHxzvlmX6lbh5lZW3
         MgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fl2ViOY9h56E961Hc/YiKWFXGdUJS84TzaxmxWiWeG8=;
        b=jdLjLco2M0J4ZDfh6OFJL3vFaqdhzqalu7WHVXoWaROi10dTGHN0vQJEdtCsWEn7a8
         xZPDwSMIa5yBkXOqoVsDoq20aO6EPQECLUs9pWiEv+zvk2qw30EP/U8j3n0vV7nlR9qj
         ts7G8yd4I+buBtCAVTM+OoqQvEsHb4/FwI6j54gpNk7w6l6BqjGvwAmoAua3dhMTdQ4S
         jRZzqXnochpJO56x6z7WryGtH7PbqS236J/WlD4KP6xulISvoBiNs/kUkGSbz9GqZUaC
         8EY5wEY0YT78e5JsnEEXMPyRhkOYxZrEpMtna22+04godmV19ssHozx4MI6zxrek7bgg
         Bw7g==
X-Gm-Message-State: AOAM5301oTptbzwtYdrlk3RFlSdJLoP30SiNaoLtFuEaCuIK8GMsl8IV
        MCxmgUWoFe8jU/QnLygvkEjmc9heu33QdHcgdhI=
X-Google-Smtp-Source: ABdhPJwJn1U9AZa7VOgvauPTBDG8TJIOGQRC0UYjob/2kMwmml2/XmK8ewSCnFl3oP/gNoHaw21zJSAYadI0RTiFRNs=
X-Received: by 2002:aca:5606:: with SMTP id k6mr5170273oib.158.1613545788297;
 Tue, 16 Feb 2021 23:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20210217070710.7359-1-selvakumar16197@gmail.com>
In-Reply-To: <20210217070710.7359-1-selvakumar16197@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 17 Feb 2021 08:09:37 +0100
Message-ID: <CAMhs-H-in1wTtFSC+mVsvyCdNXArwOHqVxTp9D4KrgNqoCnjAA@mail.gmail.com>
Subject: Re: [PATCH v2] Staging: mt7621-pci: fixed a blank line coding style issue
To:     Selvakumar Elangovan <selvakumar16197@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 8:07 AM Selvakumar Elangovan
<selvakumar16197@gmail.com> wrote:>
> Removed an unnecessary blank line before closing brace reported by
> checkpatch.pl
>
> Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
