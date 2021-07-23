Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FFA3D422F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGWUrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhGWUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:47:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AF2C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:27:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so10811885pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFuTgRXMPN7XesmqvYLjMAPBljN3gr8l3Heds4D6W/U=;
        b=wxUNqR6FR+61i7kJOTC35pHkHJL2Zza7K6i3d2JpUBfw2TAXNnWmOOkfG1p1NF/tGX
         UHk1d5nwI6aVMJiwHGb4N0C4TAKB3r8OnKyNFSAucm4Dn4LSO8wCyquEhe8Ius2Go3wZ
         wV63JbzG9OcVxu3TQcCN8PN42Odxna+2KCx1zbSBNjRByqPpSi/+Oz6YHizDWjUCNBYq
         y/XZMZ6qP2RzWYp4O7PuFfY66pTvfW9pHmBZR1cjZGKfdHdeP8wAR7jS56XazTGtFn0g
         fa5bzeOUXxvM9/7LJdO7x4W9Lpx/2/O11FAmNLcKgvezQ/aMaIABNOrBQnenMeM9RSkk
         ymwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFuTgRXMPN7XesmqvYLjMAPBljN3gr8l3Heds4D6W/U=;
        b=CWkjSGBgPPYku2btwjIpGSsxP69frLWK/yDdSp0e11btspdshUOEQWxB+/uq8xK1vw
         cD2MUA9NsnItxanCF5oBdLfFPa1vJiQq4RALjSUNfWgSof4rMQSkYJSAYcOQJ8OBRaQ2
         tPQg3GwewxPppI/dXWO1lHm2u7Zic7LQvGs3ILhUZs29WCteDgzcuQBfOl00mUKQ9Fkh
         BuY8V6m9ZCaZU9j+5r/xnDRRibEIdJ9VYJoWMEhgKvvW1wB5wdcX8wsRUHbr//sH3xho
         9EE4jlamPp9dE60uvja0mzQPcq9GZxOzw10nHjwlwiu/+Aya88ClTqsT2xjS6ABvBO8E
         u2LA==
X-Gm-Message-State: AOAM5302E9Sk5m2mhzi2MgA5U/ZlNbo2h7tHOSPykJ0BmHJlTzPl2E9z
        1jn2iS3n5es9rTMbqkZ0wH5FiEX3+23v9pjo0AO8Bg==
X-Google-Smtp-Source: ABdhPJz1Jvm6TvRzQ2kUhoOAIEoIyKIBW6K2ImOiY0kVwmmDwUmn0FVmom+CzKhpBmh5IHhzLHJryY8a2MNJfzJ0EcI=
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr6199786pjp.217.1627075656546;
 Fri, 23 Jul 2021 14:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210723004214.912295-1-phil@philpotter.co.uk> <42086ca2-69b2-b2d4-893f-82418df2ec7a@lwfinger.net>
In-Reply-To: <42086ca2-69b2-b2d4-893f-82418df2ec7a@lwfinger.net>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Fri, 23 Jul 2021 22:27:25 +0100
Message-ID: <CAA=Fs0nWC2kbSgwdmUnP_RNxWEZ74KnHLBTyBYTxKDb7VCfRDQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: rtl8188eu: replace driver with better version
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 at 22:08, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 7/22/21 7:42 PM, Phillip Potter wrote:
> > I had to break this patchset up a bit to get around the file size limits
> > on the mailing list, and also I removed the hostapd stuff which is
> > userspace related and therefore not required.
>
> Phillip,
>
> I'm sorry that I have mislead you, but the v5.2.2.4 branch appears to be broken.
> I have not been able to get that one to work.
>
> The master branch, which is v4.1.4_6773.20130222, is working quite well. It
> suffers from the problem that when it is scanning, the USB receive buffer is
> ignored, but that is a problem with most of the Realtek USB drivers. As a
> result, the ping time to my router will sometimes get to 2 sec, rather than the
> usual 1-2 ms.That is something that I will try to fix. My suspicion is that
> scanning should be left to the network manager.
>
> This version also behaves nicely with NetworkManager.
>
> None of the source files in this branch have trailing white space.
>
> Sorry for the confusion.
>
> Larry
>
Dear Larry,

No apology necessary. I will do a patch set for the master branch in that case.

Regards,
Phil
