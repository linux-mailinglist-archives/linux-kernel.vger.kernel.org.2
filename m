Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8C30B468
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBBBFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhBBBFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:05:00 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A1C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 17:04:20 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 7so18645134wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Zh2Ei6J61XQxwQGIOp0JjNjlDIhrnbirBPmQD0bdfE=;
        b=oAq5tF2giAnF45SikHwCnfJ/wedC8EeUwTbA9Xj81mtid2GED8hf+tcDz5ofDAk317
         Fppcmk4PAncYIQh4qiEBMLQ9hI2XMwTQaxLakLvLXyC0gSvobWI1m5Moy+vPe2DeSYFe
         lguwTOuTfogmRYcze/aKTYtC9cye3ylJrwMi1Jpzu4yNv8e7IDp2F/gOygZUNu7PSmct
         qbA3KYuxMnPww+TJfeydaQRrB+5WhALpNiGlx+khPIViqqawzIw2Lq4gVG6JWFgkPDvA
         sysMD2kmf36qyUbNUWxlRYMbb/kCdaxqzxeZDYWcmOgKX0IYUIzE2NBDijHwBXDXwKbl
         CKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Zh2Ei6J61XQxwQGIOp0JjNjlDIhrnbirBPmQD0bdfE=;
        b=d+nM0G4SlcxX4wsk9D7TnBsXoY2Vvs3CoLtlYtxCElX5I9YoTLYlXAck4jO6C3tsaz
         pw5zF1kETPTZ/S0n0IiiMy/in07ksoA6iYI8sBBiW5xP5dYYxO+a6adSs5D+WXKd+KZT
         NVLgADR09HNdPyry3YKQgHUwON8XklaFJEma3gMrv63+wpBdnwkEuAqVRPJPw8dHq160
         3zhm4WPaWxbsxHvFyEpTmIGR95gZ9TRQ8pwhXVgDbsrqVPCdlg25JvZ9u/iGNDN88aD+
         XTkY65SX8vIvfe44qAgJBELHIZkK3C3eJplypju9X1nrYeoKusg9p3uBCYejycDRxNJd
         0Nng==
X-Gm-Message-State: AOAM5337yATh3UWMgsJ07kuYS/zfY//Q1n7QtxZRufdTLTAM9JfXSz1V
        CivCnJrUXPgMTYaYCFPEA025soqM2B1U94qVTAQ=
X-Google-Smtp-Source: ABdhPJzgYO8rG50sO+X2rVodTZe3f9r/4Cc5A9+EWJ7mWEPGrb9BUttVfkcu8UVWXTTk+U2kkzsGYdd6g2rGkiO1bdQ=
X-Received: by 2002:a5d:4b8e:: with SMTP id b14mr20353628wrt.130.1612227858834;
 Mon, 01 Feb 2021 17:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20210127194047.21462-1-christianshewitt@gmail.com>
 <CAKGbVbtaDHmukvfF=sfSmWHVdAYoF6-i4RTzsPQ6zfsjHcGNCw@mail.gmail.com> <2c8d2b9e-c1cc-1157-19de-409957ecf9da@arm.com>
In-Reply-To: <2c8d2b9e-c1cc-1157-19de-409957ecf9da@arm.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 2 Feb 2021 09:04:07 +0800
Message-ID: <CAKGbVbuLRvZaZNfU-pi=7vqJZO2zOHAkrjTo6vs9BKLrV21O8g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/lima: add governor data with pre-defined thresholds
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I see. Patch is also:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Mon, Feb 1, 2021 at 5:59 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 1/30/21 1:57 PM, Qiang Yu wrote:
> > This patch gets minor improvement on glmark2 (160->162).
>
> It has bigger impact when the load is changing and the frequency
> is stuck to min w/o this patch.
>
> >
> > Seems there's no way for user to change this value, do we?
> > Or there's work pending to expose it to sysfs?
>
> True there is no user sysfs. I've proposed a patch to export these via
> sysfs. Chanwoo is going to work on it. When it will land mainline, it's
> probably a few months. So for now, the fix makes sense.
>
> Regards,
> Lukasz
>
