Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4651A36E1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhD1WyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhD1WyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:54:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F82DC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:53:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h36so47650121lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKANjrQcc8T28iTmna0zzay301FHOU9c/uarbcg93cg=;
        b=DV+i93IRz26ZXsSUri4sDaWIUZD/zohqw7ibjTEw8xAHO6EiAXX5xVDyJuVY72bhUv
         UK0BotFUbLjDDKyxvjnARri4HCfdqgJIXxenvmtg54g0CkHWLD2COvTyhbxojD+Ydqjt
         plT7kaup7kZ/UgpgFlN6idxwKl+I/Eu1NHGNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKANjrQcc8T28iTmna0zzay301FHOU9c/uarbcg93cg=;
        b=Sdc0KFbQL3ktZBXOKntO6ETTsYHhXs8bWDTCVlHBHfmNY1bfuftR8LRaJ4q6naINiY
         bNvfkzVJLOtTxGwzzJDEOIBHlgiEne6lLYH78C5/G7oIaOyMnNkiYeprbtHHumHrJdWD
         wB9Nl62GCimtey5YxVAWkH6cErYb6YxILqGAGgmXJT9R1dOJcjvBPS6coWVXBOArnzEl
         S+o996pMWMwdZGIgToyUKBd9EKjJwdfWvA92MY6utYXz8ahx67skvVg6s0GTVfZNvwew
         dzmWv4wOkhstelzuKl+XdJha/7V595IQvp4UVMJtQyqQImZAXKOBYnsmeiMal2lzDMxA
         eudg==
X-Gm-Message-State: AOAM531hIm2sBTsorkYuRivl1k+XUYWi2Izr0BpsI25fbPieRPzYHy3s
        cqMPySgl03ZbaDGH8XCyNp6Qf2br9wPv0O1l
X-Google-Smtp-Source: ABdhPJyYNPWM2dWPjTsXpk5QYSCigp0phKAWYjFS+nPnTHiFKyi7TA09Qj5X9g0jBXApYHBeodNlPQ==
X-Received: by 2002:a05:6512:201b:: with SMTP id a27mr21480545lfb.131.1619650402556;
        Wed, 28 Apr 2021 15:53:22 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o21sm271796lfl.297.2021.04.28.15.53.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 15:53:22 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x19so71447302lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:53:22 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr21975685lfu.201.1619650401841;
 Wed, 28 Apr 2021 15:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210427214944.GA2052002@robh.at.kernel.org>
In-Reply-To: <20210427214944.GA2052002@robh.at.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Apr 2021 15:53:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd4Ku0e4M8eBQuqKHAgBp81WWimFiw-hhBV1wZNdoR-A@mail.gmail.com>
Message-ID: <CAHk-=wgd4Ku0e4M8eBQuqKHAgBp81WWimFiw-hhBV1wZNdoR-A@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v5.13
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 2:49 PM Rob Herring <robh@kernel.org> wrote:
>
> There's one conflict with your tree in drivers/of/property.c kerneldoc
> comments. Looking at it closer, I think the linux-next resolution is the
> wrong one. Take what's in your tree instead. It makes more sense to
> take the code author's comment than what's part of treewide fixes.

I picked the one I personally found more readable, whichever that was...

            Linus
