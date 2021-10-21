Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628FD4366C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJUPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhJUPyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:54:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F3C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:52:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u5so659178ljo.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BUvP8gOAW+gS53kPlxXdoNqtgg1DkSCa22z70BSxnQ=;
        b=I+iTjOWqkYhJVtzXfdMre6FfEyLSuXDaBYozZfIYBSH3kMhaYGXWYtjtP1B7gapJQL
         vSzII4lgrHaC51FeaRLzfkB40M/OPld6+xCnfZxzoxcuyKaBxVsn03kuLknslzaSV2nI
         n+9I+zXONhFUpoSFeDxADY8QDCwla7TwhTZapL8AHuiV9HTCphiqdp2tBhcV6QICh/Jf
         kvd6doqB/uH0pjdmQveYZcGR2rUK1FVDU2lGBw+DF3qrtZDhK7x0dd4+G9Kgl8TUm1px
         RE66xJ04SNvoU2Ywy5mjN31sfOzlUIqMcNCeDaQW6jmW6Bu7Hs+LERiUmc4BYS05V6Wy
         8ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BUvP8gOAW+gS53kPlxXdoNqtgg1DkSCa22z70BSxnQ=;
        b=vHAQP2OgGGqNgovCBqdqzX/QLgIiLe+u0Inm++u01se83kmvoBOSY5SrZ41qD/D+NZ
         lVHCIat172ZG2DDQNLlU3rGJTjSVIqnoFaM3uor50gXcEHDDiTn7RhXBZI4My7xWNk3N
         KVvUEDddhGBCTLdQImAbTD6RK1RHXPXLEjicTmNgfDsi/xg5B5mW0URZ0J1/D8lv4aeo
         0irFlLsYG8wMUmeO6bCACOHSN5HRkXjjaq4vfRONrrFjzSG2xUIrgLAhwyo/U67+zTSx
         4JU5jW+NHmRd7Hy0mdbSQuoYUff1mUGdft61KwETwRq7gabSpuyYnjldTYqk62v0PoU9
         TU9g==
X-Gm-Message-State: AOAM5338/6uJWPxq69fqNClIX3co6nfka910N49wNO1MctpcVNPAH/LK
        azvFR7LmnplGB0muU4APZ2LJBy0nLpClYnIJo7U=
X-Google-Smtp-Source: ABdhPJyLor5rGZ8iutyKqzvNE2yY0NApkvP4xs4TvwXArYQ74T7MBfpak0JbbNDZfbpVAqD3HdcrvftDC3I1Kd1uXOw=
X-Received: by 2002:a2e:9857:: with SMTP id e23mr6795532ljj.132.1634831525715;
 Thu, 21 Oct 2021 08:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211006174910.2964885-1-daeho43@gmail.com> <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
 <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com>
 <16840026-35ba-cce6-4e0b-3332b0902d2a@kernel.org> <CACOAw_xW7MZi8BVi-2Zo-=LruZr6k7fC7huYiYuWyaDDDti6WA@mail.gmail.com>
 <02abeeba-c359-cae3-4759-ee2087f21cc9@kernel.org>
In-Reply-To: <02abeeba-c359-cae3-4759-ee2087f21cc9@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 21 Oct 2021 08:51:54 -0700
Message-ID: <CACOAw_xh2HSQDjb_tGopvssipDJYnpi4O1X5_eJqSOLpLebqsw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in compr_written_block
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay, shouldn't we Cc stable mailing list for this patch? otherwise
> userspace tool may get different stat number with the same compressed
> file in different kernel?
>

Oh, could you let me know what the address of the "stable" mailing list is?

Thanks,
