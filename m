Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2130C3FE26E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbhIASeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhIASeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:34:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958CBC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:33:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s12so731324ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmlFp7IyZjhJM+UbKugZxR7EIWg6Bz16CqvqAdC73iw=;
        b=aO3JVvdoC0SVDHw81BnqPRgF6kxIUydorxW6tTvTFB4MtXnxf1a0Fm48pYWaQujiim
         dLsdxQ0vNUOunTxKmSEr9gJ0o0NL0XYCbLKU3AV2I7ckznr09qJ/3xJKozXgyoB6Gk25
         vn1MlVEcgjn8f8Si8qJ1ioGLyIrav6X+gUCt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmlFp7IyZjhJM+UbKugZxR7EIWg6Bz16CqvqAdC73iw=;
        b=iHgKfLWEi+JJ1cMNV38+Yw6HS3bjJeDpU0pfYMbNmgNia045rVscLdWH8J5aoVOCQ1
         ukCfFGRArP0gFFFh5L1UnkYZJZW/KMagTms8zDB8QcuAhlSFX67fc1D0e6IOdG6ESwLL
         uZJPQMwUx0bi7qSFxHiu5AziytTwZ5siI4f6J8zE67iFiIhfLbGXiB1xJ9nul2lQK7y8
         R1EXDYncB+eCi820Z9iGElNgM9GKHUasO2YJq15BWvFg1OOGtUX3S3CLS/UDoX6i4Oty
         VC/K0MUyfDsYuIhm0Ve/ZmWqtwBEHRT7FpRsByBwKSrtWpgMIeoYAj95ggW8bwFvD/dM
         ITAw==
X-Gm-Message-State: AOAM53191ttZLgdEkFGZwngBSxuVoqAnt00Uif6Cb91Xi/pmA57lcB1Q
        GwJtNhuPUc3sVnJCbTzF1343AvJ+MiBaKkfI
X-Google-Smtp-Source: ABdhPJzJXNh3UQR+Uqp7ifUcGaA7sVFQkvY+IO8wS8xXV5Y/3TCRf83teF0uR/1G+AnmhHmv7fnphw==
X-Received: by 2002:a2e:99da:: with SMTP id l26mr845867ljj.339.1630521202709;
        Wed, 01 Sep 2021 11:33:22 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h17sm47807ljg.131.2021.09.01.11.33.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 11:33:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w4so576548ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:33:19 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr836025ljq.507.1630521198866;
 Wed, 01 Sep 2021 11:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txeN-qCRJvYV552zdo2H9iVy1ruVrq=YdZBP5Dmpc3Jmg@mail.gmail.com>
 <CAHk-=whP_v5nrK9B5vefnZS6Xz3-vZDFxUvSmW8W82hhNh67sA@mail.gmail.com>
In-Reply-To: <CAHk-=whP_v5nrK9B5vefnZS6Xz3-vZDFxUvSmW8W82hhNh67sA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 11:33:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyPpwYLBXTdXi0DyMFhTKsTstmqU-LLjgD5fNxUnB_WA@mail.gmail.com>
Message-ID: <CAHk-=wiyPpwYLBXTdXi0DyMFhTKsTstmqU-LLjgD5fNxUnB_WA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.15-rc1
To:     Dave Airlie <airlied@gmail.com>,
        John Clements <john.clements@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 10:57 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No worries. I enjoyed seeing the AMD code-names in the conflicts, they
> are using positively kernel-level naming.

Oh, I spoke too soon.

The conflict in amdgpu_ras_eeprom.c is trivial to fix up, but the
*code* is garbage.

It does this (from commit 14fb496a84f1: "drm/amdgpu: set RAS EEPROM
address from VBIOS"):

        ...
        control->i2c_address = 0;

        if (amdgpu_atomfirmware_ras_rom_addr(adev,
(uint8_t*)&control->i2c_address))
        {
                if (control->i2c_address == 0xA0)
                        control->i2c_address = 0;
        ...

and honestly, that just hurts to look at. It's completely wrong, even
if it happens to work on a little-endian machine.

Yes, yes, BE is irrelevant, and doubly so for an AMD GPU driver, but still.

It's assigning a 8-bit value to a 32-bit entity by doing a pointer
cast on the address, and then mixing things up by using/assigning to
that same field.

That's just *wrong* and nasty.

Oh, the resolution would be easy - just take that broken code as-is -
but I can't actually make myself do that.

So I fixed it up to not be that incredibly ugly garbage.

Please holler if I did something wrong.

             Linus
