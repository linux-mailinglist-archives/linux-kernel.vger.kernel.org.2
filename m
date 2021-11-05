Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA34466D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhKEQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKEQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:18:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83896C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:15:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m14so34130802edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fo5WRx7n3ArkB8eDfEFv4FaY8/1jMcTZmaJV+POREt0=;
        b=WCtXj8gOes2SaG7jpSAxXbXxR4xLBI67q1WHq70bFAZEaE1wCdJKlRlLFLvddkCIZb
         I+e3bh0cWfczVK8tAdmCsFQBB6vOA6rYsP9YLjQRE5Z9TUURbbawqPLMuACNyhJ44pjM
         9IsbnCySW/r1HAjAQ9JT6cqqg5q7U3GP++fiSfuidzjoDDTYY9GUiR2Tc/5BsNtAzJ/F
         F3NaLTyoWkCJ/XOd2/1M1Q/cmPZ/jFuHD47/85f7WW7+lbvtyVHLCy8H6JPNqb1Rq5jP
         GF2KHXXCqKvxRHV+8ubf6F+CkkfcYQIQpOjjoENCu2hUgYfGCBtl8lmtpm1LxfvS5HKt
         qPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fo5WRx7n3ArkB8eDfEFv4FaY8/1jMcTZmaJV+POREt0=;
        b=aYxcP+wBap0WrTkeirpykaiMmk008Ka4oVQ83HBbIJAvlgibYQQ8RXrDV/nQCXrDwc
         JWoSAH9phUNDYqk04wkU8wlz84hL1JqdkXqeTQnO8UcgeCZ3hmH5quk+srA4t0+6Alnk
         b3xZio9W5hFISg0sGg031cGyeSlHXniC+NgFR6m9k1HgpGhLF393Ec/xExE4PaZpCnzg
         0mowziYVqWTgYgDQLLdzVZvi4lYl8fs6QrzIiTxNmUvg5gLEudYwvEvpyUoyfhucBead
         ahXv4141R9mkOyZ302cEwXSylg/q42lZjJfAC9jaN1GHG/Y7u2MuRZIDF4X15LUR1sVf
         h9Lw==
X-Gm-Message-State: AOAM531ashoTj6I9kD4mPHt/XUJr+tJNMQTeh99fzp8Pl7+l/8MilBTG
        gZ+lf1nrseH/TbmkN13uXrtPrQ==
X-Google-Smtp-Source: ABdhPJwUtzT6sQtzMDHJt9p4oSHRNVr34lkoMFb2dP3cZt1piIfDlw35/0HNrb77gxRVlHS8GSpAmg==
X-Received: by 2002:a05:6402:51cb:: with SMTP id r11mr11629630edd.45.1636128921908;
        Fri, 05 Nov 2021 09:15:21 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id sd28sm4880765ejc.37.2021.11.05.09.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 09:15:21 -0700 (PDT)
Message-ID: <0bb90ec7-65b2-1eb6-b9b5-57bea35179a2@tessares.net>
Date:   Fri, 5 Nov 2021 17:15:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] scripts/tags: add space regexs to all regex_c
Content-Language: en-GB
To:     Zackary Liu <zackary.liu.pro@gmail.com>,
        gregkh@linuxfoundation.org, ripxorip@gmail.com,
        maennich@google.com, masahiroy@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
References: <20211103152234.GA23295@pc>
 <CAOk_PdOsSjPHogrYJ9Nd7GdnZYw1G4zbaZFGUrK1rQ0dSq101A@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAOk_PdOsSjPHogrYJ9Nd7GdnZYw1G4zbaZFGUrK1rQ0dSq101A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zackary,

On 05/11/2021 16:50, Zackary Liu wrote:
> Hi all,
>     Excuse me, everybody.
>     I submitted a patch yesterday. Now I have a question why the
> maintainer's mailbox was not found during "get_maintainer.pl".
>     It outputs the following information:
>     ---
>     linux-next$ scripts/get_maintainer.pl -f scripts/tags.sh
>         Zhaoyu Liu <zackary.liu.pro@gmail.com>
> (commit_signer:2/4=50%,authored:2/4=50%,added_lines:68/74=92%,removed_lines:72/74=97%)
>         Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:2/4=50%)
>         "Philip K. Gisslow" <ripxorip@gmail.com>
> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:5/74=7%)
>         Matthias Maennich <maennich@google.com> (commit_signer:1/4=25%)
>         Michael Ellerman <mpe@ellerman.id.au> (commit_signer:1/4=25%)
>         Masahiro Yamada <masahiroy@kernel.org> (authored:1/4=25%)
>         linux-kernel@vger.kernel.org (open list)
>     ---
>     Is it a bug in "get_maintainer.pl"?

I guess the main issue here is that this tags.sh file has no official
maintainer:

  $ ./scripts/get_maintainer.pl --nogit --nogit-fallback \
                                --norolestats --nom -f scripts/tags.sh
  $

So I guess someone has to pick this in his tree.

Maybe a maintainer of the PCI drivers could take that as the "issue" was
found there? Or Marc?
That might be quicker than waiting to have an official maintainer :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
