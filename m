Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692233FC4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbhHaJJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbhHaJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:09:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1468C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:08:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x16so8568168pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTxJXnRnnalWZJuFXpjzUKednFVCieUvYxYV8lHL8KY=;
        b=ruqckO53AblQ34q1ZT0jydIzhi6uJGo23HSI1EInQtSWymAhbRuafetOHWN8WICCQF
         OYZxIBIZYdiaQ/l9CdOYjNfBW3AzTrQu+rE0Ok3S3yLbYrNPNJp6qsV7GLAFOgoYKBhd
         xGcu9oJPrstSjbNl44T9ZEF9yp+B3r+cIlKZjGHT0GXdJ1kOONmP1/NXbMVrKgjuErdH
         +UvjdHMwSyzWmh4zSA+El+1GcVmqgJikVXnbejTlBCv5UoC5SqJ7BWvOR2yb2LGbuh9o
         vOEQLZTA89XqgYi2ff2AJaFSehPnAJ8UF4vu6XEHL0lEJzWj0F39//eaEWO2KjzuwhER
         Oqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTxJXnRnnalWZJuFXpjzUKednFVCieUvYxYV8lHL8KY=;
        b=oJcWdYKQ+xWeliDm5i/lYoCMt0r+DNNG65ljTkoNup5x6gDHcl29Byn6oStSSeSI9f
         gNcDkfinW6iXPvHSbSIIQqNTpLTcgU3P0bk2+MsAEnqiFbuK6GXayxM8TW4AzTAhvE+i
         WV0/oDQgCFatb1hb4O+oi1lJ01PbK+lPdMdvO5+GTXY3sij9QD1Luy/JJGP7sSF7faE5
         9OsMLUW4FtPDtP31HTs9BAQxijO3tD1LwrKYVX4h5r4p2Voo/6VS5SZ1p7C/IYVLmhE2
         /cNI/XitVjcY717MkCc/maFVo1n9951BsPUYY4Tq6Unxes1+KgJ1Du3SsmiMwaBqe3ML
         MIzA==
X-Gm-Message-State: AOAM531gEcYNFQAprLS2S2H++7jg2DWDjT8nXCF/ARPuQV8faQJ9JKtk
        1X/LxWs9Gb6rQG4VEk/zWVFbIl7fatp9tMPGgSc7FhQ/k0k=
X-Google-Smtp-Source: ABdhPJwz97BCEL9VXsx86CUfQyn+MNaxhuJW5kHvtxfjg7JRj95GGdbr0jWlR+nMdcmJDK61Am0i+x1lvvw9hWjHmoQ=
X-Received: by 2002:a17:90a:10:: with SMTP id 16mr4201403pja.162.1630400899232;
 Tue, 31 Aug 2021 02:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <85959c1f-80d4-3fd9-f8a5-d7688e337e95@gmail.com>
In-Reply-To: <85959c1f-80d4-3fd9-f8a5-d7688e337e95@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 31 Aug 2021 10:08:08 +0100
Message-ID: <CAA=Fs0myEC51-RoTDFgW4+9KkprdKgQ8=C5Xuy9F7ta0z1fFeg@mail.gmail.com>
Subject: Re: staging: r8188eu: Switching encryption to use lib80211
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 at 09:40, Michael Straube <straube.linux@gmail.com> wrote:
>
> Hi Larry and all,
>
> I'm currently working on adapting patches from the old rtl8188eu driver
> that convert the frame de/encrypt functions to use lib80211.
>
> Please let me know if it's not worth.
>
> Thanks,
> Michael

Dear Michael,

Having had a brief look at the code, and given that this is a stated
objective of the other Realtek drivers in staging as well, it seems
like a worthwhile effort to me. Happy to be corrected of course :-)
Thanks.

Regards,
Phil
