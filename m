Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8283A3884
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFKAVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:21:43 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45577 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhFKAVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:21:42 -0400
Received: by mail-oi1-f175.google.com with SMTP id w127so4041191oig.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fVbGkzDMbWH/xzjd9fVHiPChuwdtXQFDYbGkUbQ+LM=;
        b=NAcNxoZoGKx25E1SGTp14Ho7XpwdCNkwzT1GSk14egrMTvsNx/jUPKkUBmBJawp24D
         7VQiJylG3YqtKPydCOA42iU7b1pipt1zXZi8k2TGwaTK3rl90JR0Uq2NZLrLLRx8nVGR
         Xrtno2MSBL6+95zqvtXHNipz+4HmVNbF6xw8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fVbGkzDMbWH/xzjd9fVHiPChuwdtXQFDYbGkUbQ+LM=;
        b=YH6tmO/7GGceYaJIGgkxTU5p2e7Z+xjqWFfI3VElQKKLvEKntOlknT010fPwdQsVIC
         YC5SwIRwUwB1M5Zba5DkVWrEkXFI605DBxUvp2GWeOmpr/IN7wXBh5l2Q2JB+g9ToOfF
         bXu1YxlVPZkpg8kLzo7Q4c+yzLGgDWrG9aIflCeZcyx7F8Z0n4fJ0HfXviF5UNgu3TV0
         92rFH8H8AGPYD0st9nqlEy5j+lI/kl1eQCCIuKVokYS5f61PCRJEC0P7mC7vOYkItT5C
         gMbwfKe/i5/YCcgYC0A9rO5yMo3l0aqZ3gGhj8ZPh//EcVNgPYTVGb6baj3MUaSh6tXz
         O71g==
X-Gm-Message-State: AOAM530Yy89LBKfI2OV2VgS9sL9RPQxnctCsKJTCd5RBCfkzRWy6gt3L
        wxlsVVE8HMXGZ34G6ohnZDszIpV4/bm1Pg==
X-Google-Smtp-Source: ABdhPJyzhSYVY+e3gG+DEn0+hObI2XDPByPC/DqQyZZfbT7pNXHsArk0FxT6M2JqyRkFoqnupYxnYA==
X-Received: by 2002:aca:6041:: with SMTP id u62mr646138oib.23.1623370724866;
        Thu, 10 Jun 2021 17:18:44 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id f25sm941884oto.26.2021.06.10.17.18.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 17:18:44 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so1490145otr.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:18:43 -0700 (PDT)
X-Received: by 2002:a05:6830:168a:: with SMTP id k10mr734314otr.203.1623370723322;
 Thu, 10 Jun 2021 17:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210515024227.2159311-1-briannorris@chromium.org>
In-Reply-To: <20210515024227.2159311-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 10 Jun 2021 17:18:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMDtWpZ-xrymmq51j4TjPT-NXs61-7q=sn090BoJu9qDg@mail.gmail.com>
Message-ID: <CA+ASDXMDtWpZ-xrymmq51j4TjPT-NXs61-7q=sn090BoJu9qDg@mail.gmail.com>
Subject: Re: [PATCH 5.13] mwifiex: bring down link before deleting interface
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        stable <stable@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>, dave@bewaar.me,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 7:45 PM Brian Norris <briannorris@chromium.org> wrote:
>
> We can deadlock when rmmod'ing the driver or going through firmware
> reset, because the cfg80211_unregister_wdev() has to bring down the link
> for us, ... which then grab the same wiphy lock.
...
> Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-wireless/98392296-40ee-6300-369c-32e16cff3725@gmail.com/
> Link: https://lore.kernel.org/linux-wireless/ab4d00ce52f32bd8e45ad0448a44737e@bewaar.me/
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reported-by: dave@bewaar.me
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Ping - is this going to get merged? It's a 5.12 regression, and we
have multiple people complaining about it (and they tested the fix
too!).

Thanks,
Brian
