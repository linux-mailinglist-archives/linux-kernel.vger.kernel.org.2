Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F0309E86
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhAaUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhAaTs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:48:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE41C061226
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:37:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v24so19849226lfr.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=my2oXzkPo/tQWCpnLGRbv0pAizeXOsJ9cPzchjq5RxY=;
        b=BbxDxf0zJFDqSzGNZANAVcXfNNc6fQsN9oQ7j6Qy2FKIMRbEc6Ke8yskPVCRoVcKXf
         jxBI72igoEB409ACYiVp8qJoYTAcAM6WsnMT2fMY3nnp82sCxarGfyHvk+tm+F2Zr3vJ
         pkmHBI36v2nlztLVixQ4B2hk+LFQTTC3WpN7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=my2oXzkPo/tQWCpnLGRbv0pAizeXOsJ9cPzchjq5RxY=;
        b=A8gMd+rsvgqxm+nMPF3xAUC0jPOdIW8PCnrbmnpkbMTpO2UbqLfW/868+R2EkRNhTu
         esgW+YrXaFJNyhJeiLKFjkeT94/UNUO6y6EuB1i/o54GFxa8Ni9eM1sGhXnfGJBk14mQ
         tKnrrcwGOWQEFXwSFAyV4t+05vUbc1Vjs7fqJ6nKGMjGrtoEWK5V7kjU2GOHwn0wmyXE
         xukza/DAVOXs5MdiVSiJO3rLyMPfo+eDpTBTfQ9iaHJf8I++r9Lc1YGojxJ7qiLe57IG
         lfQFAv1RMyKmqPFS5vsbH5LBU03w9pvhQJfyqD6VTCXg3sO94XhHaODx1MCYSuSYNd65
         8Hsw==
X-Gm-Message-State: AOAM533AjUfHEjbyeg2QrFl0ut/byG9xd/EOcDNm2rX1FUeLhgmrey8E
        4FI4vDEXcgmz94v4Kam6DYJFthzjA4fSrA==
X-Google-Smtp-Source: ABdhPJzzfRED9Uyj9RkkKJktFKKrRjHwCiYApAvADG8ckaYS9n1T294vKJtfxFFSqWNRwYtxAZIVxg==
X-Received: by 2002:a05:6512:2251:: with SMTP id i17mr6480641lfu.566.1612121858014;
        Sun, 31 Jan 2021 11:37:38 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c18sm2735957lft.258.2021.01.31.11.37.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:37:37 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id b20so9086525ljo.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:37:37 -0800 (PST)
X-Received: by 2002:a2e:8116:: with SMTP id d22mr7942108ljg.48.1612121856862;
 Sun, 31 Jan 2021 11:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20210131094255.GA31740@duo.ucw.cz> <161212172023.26762.11083214605908540466.pr-tracker-bot@kernel.org>
In-Reply-To: <161212172023.26762.11083214605908540466.pr-tracker-bot@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:37:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjTQCoVztHjyMeKiM_OLJcgaBLc5seGcJAnugcLvKBew@mail.gmail.com>
Message-ID: <CAHk-=wjjTQCoVztHjyMeKiM_OLJcgaBLc5seGcJAnugcLvKBew@mail.gmail.com>
Subject: Re: [GIT PULL] LEDs chagnes for v5.11-rc
To:     pr-tracker-bot@kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 11:35 AM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Sun, 31 Jan 2021 10:42:55 +0100:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ for-rc-5.11
>
> has been merged into torvalds/linux.git:

Oh, look, one out of three (so far) did get a timely automated
pr-tracker-bot reply.

The automation isn't dead, it's just not feeling well.

               Linus
