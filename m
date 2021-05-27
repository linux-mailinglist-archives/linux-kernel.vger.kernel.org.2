Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7CA393565
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhE0SZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhE0SZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 14:25:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56144C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:23:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so969678pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uMO4i4wwVG/AE3wpGIp8mzXo7xx2zRYpkL1opH1TeQ8=;
        b=NAku7tJLvHkw7QPh3IlY5/GBM5jcRuewoncx8jMIxbJlWGz0LYMGBKqKWT3Y9MyJPK
         3C/7fQHLXuF9aobdguYD3ONiql+2i4OHCGOMyA+D0HvRWokQScSiPBtQ0qPZp8uzcqaB
         juZWoQgJ+Lr+BunPQ4AsHRrliP7KqjzYEOJfoA2Re9P5UZaUKA5KtcJZb6XADGIWepja
         7RQkX54Bg3RrYFO9rTgiA70e1naVOjGf63a9bKcxqnIWddKl8L9c4QMXMpEKcs9kx8wB
         gQDAloUWlfzMZx9hqjLo+PH6tmGpF8/7UDA/RggBSCOXjPrEGci294ZHo1Z0e7b8S1lS
         A12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uMO4i4wwVG/AE3wpGIp8mzXo7xx2zRYpkL1opH1TeQ8=;
        b=fnnt9B7VGBGzAwWNRABSu//nl/4oY0xM8/BH/RQDUkwD6AW5sREDtkcZy7juMCkKAy
         5qFD87UoirLwZyviiMz1bZ5fm2STh5nDwv8uV+LHHzup6ijxUOB9b06RY9LVImhSFHhn
         5XVC3DjZb3JxW9pcTIy+QTBDUO70F4oJBj/5gjvLOKd4flYkwm2GRU93Bp4XUkTWPz4m
         XKhNNrh1/i1Z1hBTiLQT71oRpbpFdF0n9KLwXaCQfCs+QkFtr4QRgpg3JdJSplrIOzzR
         McLWvIDgXSmTSiMxPS0DzVuQfSqMaLBj+53fAC3KLWzxrtwp6XrrutddEFiU+PX4EfKt
         NOuQ==
X-Gm-Message-State: AOAM531UCi31txPFqtRfzakDHv90LlqHxyGJcvyFx0s2Fneqr61DKqh+
        RQEABb/cMSIez1/l3Cooyq8=
X-Google-Smtp-Source: ABdhPJxNIJkBBR20+/l+Xms+svLnIEXb0CuSXGn8HEVNkUa3RUgJtFJhpT6DRHOlkfyL5HMprWmZ/g==
X-Received: by 2002:a17:902:44:b029:ee:9107:4242 with SMTP id 62-20020a1709020044b02900ee91074242mr4412620pla.18.1622139838453;
        Thu, 27 May 2021 11:23:58 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id q196sm2621241pfc.208.2021.05.27.11.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 11:23:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [git pull] IOMMU Fixes for Linux v5.13-rc3
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YK/dheM2NZz6KOkb@8bytes.org>
Date:   Thu, 27 May 2021 11:23:56 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <34DB5CF6-B53A-4AD8-8DC9-DEED941A4217@gmail.com>
References: <YK/dheM2NZz6KOkb@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 27, 2021, at 10:57 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> Signed PGP part
> Hi Linus,
>=20
> The following changes since commit =
d07f6ca923ea0927a1024dfccafc5b53b61cfecc:
>=20
>  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

For 5.13-rc3? Not -rc4?

