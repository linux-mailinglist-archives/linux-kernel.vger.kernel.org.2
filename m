Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E855E3ABCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhFQTcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhFQTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:32:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:30:02 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so7293924otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96aOqFV+Msept1aExEkb8x6Rqhfeyqwt0lWHBevMNvo=;
        b=oIB+8RnNPZyuKWRqD2bU8tkh/BghW1F0ppi6t9hKA1zF5buiMYjTkXkIhwTvmKhdxm
         IGq5N8xt3LwhgoEG6ydIYCuY/1sQwkMdTD8fQsrz0Be+jZIMtY+Vsq78m4XdWHmKznN1
         1c/XxoKiFU7kyNBAhN8hjv+3S0KhkfFo5cNok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96aOqFV+Msept1aExEkb8x6Rqhfeyqwt0lWHBevMNvo=;
        b=OhBQ0ZXYISBl1Q5l2qoPTgDFPFg0tyHdxQctvKNd7CqrLNMIiI8ksCcpqM6hpGtO8Z
         FBJK539L/jRI5bGq0auyf0clmiAf7wD/Xj4U/PRkkE2QHLo86ahSvBH8GUBa7ehObhE7
         nz64cd2Um5xUcCOVuZKEh1xGsnDS8DPmCHIdEp7Mh3iafP+774UMr6ROU1ybBQfVPOwp
         q5kTfq7ma3dI7Fe2IxWfVHsBlFZFf+6rEXrK9fGZ9Ocgq2prYJAmwcthcZ4zd0uySvF5
         VKJxZpOOQsZKRpo13Y9SQgS74EPGq7zfQhm1KdjFKEY8G+XOFpDeeFgy2IAFM+CfE841
         gSpw==
X-Gm-Message-State: AOAM531sCfM7OIKMv3jvdOm8jkHBRxrj2F+i4aK3pOwJzZzcIaBFTXwI
        a15Y4o8E1UtErObdKTtrO+ykWr6Ia9mCVw==
X-Google-Smtp-Source: ABdhPJz1pHwt4CslihCJwaBgnjoWmucC+CFevPr2BmQYvaI3soPqqz1fDggtGBoMcsfYWLcBsNHTdg==
X-Received: by 2002:a9d:3644:: with SMTP id w62mr6046192otb.205.1623958201093;
        Thu, 17 Jun 2021 12:30:01 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id t26sm1505355oth.14.2021.06.17.12.30.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 12:30:00 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id t140so7788616oih.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:30:00 -0700 (PDT)
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr11266904oih.105.1623958199878;
 Thu, 17 Jun 2021 12:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210617171522.3410951-1-keescook@chromium.org>
In-Reply-To: <20210617171522.3410951-1-keescook@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 17 Jun 2021 12:29:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOE2EgkiqyqkiXrUCMas+aVU1hJy4uDwafhWv6REjsefg@mail.gmail.com>
Message-ID: <CA+ASDXOE2EgkiqyqkiXrUCMas+aVU1hJy4uDwafhWv6REjsefg@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Avoid memset() over-write of WEP key_material
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring array fields.
>
> When preparing to call mwifiex_set_keyparamset_wep(), key_material is
> treated very differently from its structure layout (which has only a
> single struct mwifiex_ie_type_key_param_set). Instead, add a new type to
> the union so memset() can correctly reason about the size of the
> structure.
>
> Note that the union ("params", 196 bytes) containing key_material was
> not large enough to hold the target of this memset(): sizeof(struct
> mwifiex_ie_type_key_param_set) == 60, NUM_WEP_KEYS = 4, so 240
> bytes, or 44 bytes past the end of "params". The good news is that
> it appears that the command buffer, as allocated, is 2048 bytes
> (MWIFIEX_SIZE_OF_CMD_BUFFER), so no neighboring memory appears to be
> getting clobbered.

Yeah, this union vs. the underlying buffer size always throws me for a
loop on figuring out whether there's truly a buffer overflow on some
of this stuff...

> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks like a valid refactor to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
