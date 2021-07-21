Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45E3D0A01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhGUHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhGUHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:07:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F518C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:47:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ee25so1219844edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zsjvy1qsrTGnTOxXbEsGYch/GJur+b3ZaPfAaLrOvvY=;
        b=FjplD3p8O/mtqU64FCyP8IxhgKh8SMR0CKo3ev48LIlVj7XOxvQ8BbDYP874ktFzQR
         V6SYaGr0XHlaIOZ5DuFt/LGx/RGdM7rVBSiJWnsx2KdckW8MYjLkc5GGP1Y8gwAhP4Wx
         zdKZn3P4jHZv+J/Tno+uOHCEFUJHqUb+ouLfZY4VrPMwwW9ybJ9JrrgVfbsHgCCENW34
         vIa13puP2dlYsL3urDuS33MfegqXzxd/DaFoO2Izd3iWK9aDO4h+gpuKF2V33E//Cp4k
         yK6sNBomUQ1o6ATZxDVQKzjEvfBnr8q1qQoqvayNjoZT3GTjRXl3qFyduS6RVYHQ2ore
         TjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zsjvy1qsrTGnTOxXbEsGYch/GJur+b3ZaPfAaLrOvvY=;
        b=GDnvfrqWtK5tTHplfEhLkSaMSe6y5P0JQwx9ZHPOfzZ2mC9duzf/cOKIDeiCC8r5nj
         nC0n9Z6o0EcRFCps74eboLLVM1pKhrFyd4bPHpy7oxaVpEqVpvkArh18lQW5GgB3IYRS
         wrmEVpvW8WpYFZ3W4IBTROQhPR6Fh0LZqlR+btmyk2hZTc+M3m88iQNIG8UEkKqdsVQC
         q8X5I7aoh313Xm6qsS12j/uNSSvTXZbYrnQt1SMCRm0pAoTSpWZah4sqPLdcGq+aILmR
         jns7Rt/7/Z6lzoY3cH/buG6baJ0uulrfQOH15yU2HXPJ2I044nDRxGZHaoHJLMrkxlFq
         7dhw==
X-Gm-Message-State: AOAM5305WoZb7Q7jKwQAabhWjpP4OyprxDkDMqWRVfnU5V4CWyv3Zj5H
        7nd7n1iu1OKVYjtDr8a3RGA=
X-Google-Smtp-Source: ABdhPJymYHuzT8ho1hPbc8T3Dco7xUCtNsjHu4dfZMBQnoXoiIsEpgktSm13e1WHP53nVCzi8NQJAQ==
X-Received: by 2002:a05:6402:22c6:: with SMTP id dm6mr46878436edb.228.1626853663992;
        Wed, 21 Jul 2021 00:47:43 -0700 (PDT)
Received: from agape.jhs ([5.171.80.208])
        by smtp.gmail.com with ESMTPSA id k21sm10328265edo.41.2021.07.21.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:47:43 -0700 (PDT)
Date:   Wed, 21 Jul 2021 09:47:41 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <20210721074740.GA1415@agape.jhs>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
 <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Larry,

On Tue, Jul 20, 2021 at 07:22:26PM -0500, Larry Finger wrote:
> On 7/20/21 4:00 AM, Fabio Aiuto wrote:
> > maybe the information we will need one day is:
> > 
> > will the core/-os_dep/-hal/-include/-directory-structure be
> > welcomed in mainline wireless subsystem, when an rtl* driver
> > will be perfectly tuned?
> > 
> > At the moment I can't see such a directory organization
> > in any of the realtek wireless driver.
> > 
> > Sure there's time for that;),
> 
> The question is how much lipstick do you want to put on that pig? The
> current version does not use cfg80211, and it does not work with
> NetworkManager or a modern hostapd to create an AP.

yes there's a lot of work to do...

> 
> If you want to get the rtl8188eu driver in shape to be added to the regular
> drivers section, then I suggest you start with the v5.2.2.4 branch of
> https://github.com/lwfinger/rtl8188eu.git. Many users of the RTL8188EU chip
> use that driver. At least that version fixes the two problems listed above.
> If you want to flatten the directory structure, you can do it there and
> offline.

if there's a version closer to mainline (as lwfinger seems to be)
why keeping the actual rtl8188eu on staging instead of the lwfinger one?

> 
> I want to caution you that following this path will take a lot of time, but
> once you get it into kernel shape, it will at least be useful. I have never
> had the time, nor the ambition to undertake this effort.

yes, I understand, it's taking a lot of time with rtl8723bs as well, but
it's a good starting point for kernel newbies

> 
> Larry
> 

thank you,

fabio
