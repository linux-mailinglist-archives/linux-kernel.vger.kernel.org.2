Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A445D3E02F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhHDOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238677AbhHDOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BFC260F25
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628086789;
        bh=UhV/SQfdLBYTc9D9nBIqPDxNpUescq5pja8sCC7bUhg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GqW+Ix8bE9Xpa1PchSe10rwy9phm1XMd4MtWpBN7X3eojLy8JN6KQp9n/43TFtwni
         80y7yvlPbt9DWFp/kScILAMs5dZoVWsxp5peA10/x5cfZa5vObdwIDWpX0jkQFvYaT
         2MgpL23FyoaDUNhgSS2nyNLYahv0fdWor9n5QSwmUSsJLUvt7JoCZyDZ33EVspregL
         jDwdyiYhAt5flGpgHfIHdpgTM1ACwW61TYHC6twk5Khz9kuXn/Gp2H4ZEQb28P8yN1
         FPN6Bs7CKtVW8/Ig8CE1Yf1LpEy2t7/uIkXgk1gg65UZJGajHvq52xvBjKFLdOLOay
         vieUvKuAW7pSw==
Received: by mail-wr1-f47.google.com with SMTP id l18so2460729wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:19:49 -0700 (PDT)
X-Gm-Message-State: AOAM531zr1zDMgQC4yOe1lMn6VqX56TXtOXuqmk9/ljgL7TAcmrI4n/k
        uy0KebWAVi5vY9KC8YDcpqrtZZRIPTtylDzdhG0=
X-Google-Smtp-Source: ABdhPJz4webvoPA0EIBz9Nqvki0G4OjA8pvIy/LkSY3nQYdB4tbtdSxD94XNSCYZc0/wF2Fsa+T9PiEhNiWOJgXVQLE=
X-Received: by 2002:adf:e107:: with SMTP id t7mr29131713wrz.165.1628086788270;
 Wed, 04 Aug 2021 07:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0i0WP24Z0TScmPqKxmM2ovtKnmm+qZq6+Tc1ju+hma0w@mail.gmail.com>
 <20210804141049.499767-1-kherbst@redhat.com>
In-Reply-To: <20210804141049.499767-1-kherbst@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 Aug 2021 16:19:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
Message-ID: <CAK8P3a136c_L3yVn-841Sbfib9UMOf1M-pk+2SqWt0wD2zfRKQ@mail.gmail.com>
Subject: Re: [PATCH] depend on BACKLIGHT_CLASS_DEVICE for more devices
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 4:10 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> playing around a little bit with this, I think the original "select
> BACKLIGHT_CLASS_DEVICE" is fine. Atm we kind of have this weird mix of
> drivers selecting and others depending on it. We could of course convert
> everything over to depend, and break those cycling dependency issues with
> this.
>
> Anyway this change on top of my initial patch is enough to make Kconfig
> happy and has the advantage of not having to mess with the deps of nouveau
> too much.

Looks good to me. We'd probably want to make the BACKLIGHT_CLASS_DEVICE
option itself 'default FB || DRM' though, to ensure that defconfigs
keep working.

      Arnd
