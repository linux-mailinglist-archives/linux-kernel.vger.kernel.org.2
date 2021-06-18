Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2C3AD2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFRTX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhFRTXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:23:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40596C061574;
        Fri, 18 Jun 2021 12:21:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q20so18374119lfo.2;
        Fri, 18 Jun 2021 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUD8G36VdsiWC+n5lUqd4hu3Ex5au9XROzjkjPU2dP8=;
        b=IzJZ3MvKB72AkKG9jjEGQSnFkYIn542CcJXVkiQKpix92CvAx7y/WuuLAv1Xs+C+CX
         N854TOa+OWVSdHnNZ1CZNHPhCnywcx+Fpg6fZqC48LR00A5b/XYGCkqNPxpb07iiVaHC
         BfsKu6rMtqeej80nhcG2/Ff4I6EbShg+h+pamaBMxgpo1lo4ixx6Saw7Sk5XC+WFjle1
         amvUxVVh5mAWyAG2JMnG5qh5wJ0mFbAnc581SR4C2NLaXKMa153JSTw36/rnKVwYnrzO
         bFxt/Mr6ojNYUsHXp/4TkxorH+xHW0dgTh32YafQ5TbTXhznj8KfNdzzoWBoKnPuVhV6
         pXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUD8G36VdsiWC+n5lUqd4hu3Ex5au9XROzjkjPU2dP8=;
        b=pf90z13LJFhUpBgzZMAb+AeSJbGRtr3fmXlUVj9KxwwIWCppfaGcfrjWM1PTEUr2J9
         edHNfk1iA5Dhxy4NAsozc7EyzACT1DYSfCaVtpARo1HkoB7caIZm28reVrszqmVzl3uT
         qd3QyjSPlB6sLXAGjIiU6DtT7ZOsDrA3AC/OnJGaY5rwLFKIyH9/se+C8ac14Qck7sNx
         H0zXiCcNkN+F8y8vyj69ET6eFNSTm7W9um+Nmw4aLUg1ucBioUneebtZmYMUbP8aGXgw
         GEwGa4GKlYOEMJvXhYSH7DVBbE/Tp4mPHC0xKq5PZVtk0vY6fcBhIhhcENxGOpnW7Rrd
         s1cw==
X-Gm-Message-State: AOAM533Sc5IzkDQkvKR9dcCWlO3PAc2XYpDk2L4fWKe2nEQeUXdeVTqj
        J3QOMzeHU6/r2bOwxIGGPRsMVt9ZUDquA3kaNHA=
X-Google-Smtp-Source: ABdhPJyGIKidY1tG/LXuXRUf1mMo5ZxqEZVwQ9e0WaUYsuo2c8MfdNNalTrFIqThoXFLfBcSBo+JcxkC0f9t8j/xwRc=
X-Received: by 2002:a05:6512:3e0b:: with SMTP id i11mr4483889lfv.139.1624044068616;
 Fri, 18 Jun 2021 12:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210618183524.590186-1-colin.king@canonical.com>
In-Reply-To: <20210618183524.590186-1-colin.king@canonical.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 18 Jun 2021 21:20:57 +0200
Message-ID: <CAMeQTsaEO_FVrC-X8GC765xDa=MQxd8Pwn2X1VPndhU5MYw20A@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500/oaktrail_lvds: replace continue with break
To:     Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 8:35 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently a loop scans through the connector list checking
> for connectors that do not match a specific criteria. The
> use of the continue statement is a little unintuitive and
> can confuse static analysis checking.  Invert the criteria
> matching logic and use a break to terminate the loop once
> the first suitable connector has been found.
>
> Thanks to Patrik Jakobsson for explaining the original
> intent of the code and suggesting this change.

Applied to drm-misc-next

Thanks for the patch!
