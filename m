Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67A9373278
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhEDWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhEDWay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:30:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C39C061344
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:29:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t11so14103205lfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=dQBiEe1w/Wbleue4r5yuQeIdpsQf7Sq0aXc76H99xao=;
        b=iIufQxxW8hySWIa22QbcxyqBs5YEgAI0TzCsFn+ytIXv5e7I5oEBMqVSt2Kcxl4K6P
         o2h10ypehs0O6e58uG8pxTjkP7KZjKLQ1RzkCne3i8EJxYHYCuueIwt0c0mBjSUut2xA
         cngewEY7xVeBS3XtBiGVPuLuqPpC5+rMCMiEBwLoplnA/nytJPdAFc08+Ut+RgXd5B3f
         Lzx71XERAyoXpczck4cTyikyu6Pu3v/isgjWJq3FRuYq6gDgeVckMdHeIaxLNiwDCcZe
         CvDH8Eao1l09zROQx9F0oiUDqbqTIkhiF9pEtJklM4FRBlZ7lGEp5ay1jDNwkc8WSkR8
         Gp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dQBiEe1w/Wbleue4r5yuQeIdpsQf7Sq0aXc76H99xao=;
        b=VPuc0TgwLPNEQxERQW34gfB5C4ZYm3ByBssSHWUtNNNO4aL6Ikye019t2kgwBH/d2E
         yGHyNUfA9/sfrw06vh3B8zyki6zf5/JKipU425G//T/cnknwjqKFlY+KVJDojgMce/b0
         HGDRA2+pr0/J15K0qZ0WKGaUNwWCLJhEEitBnTGINVkSkPFgwcbnSUgsfMW3xJCb4Nip
         yt2kIMcP30bCbzKj6V1ZjxcQNOdE6o0p7Q7rPMq7TnUhiEKtUvxDCgIaIw+N6X6dSdBy
         10Ad3EuzPfgsOlVdAGTiqX0CYlUWmhNSe3Ya0U8EJ729xujkARIXK/CWZeDUtQj8/azW
         O+Dg==
X-Gm-Message-State: AOAM533XEP1gjP5gNj40QG6jn27t7XPmUawTnKIalAmA2qIxGYAgbsNM
        KYeiEeG+hRo1AXvMXV2/u3NuGA==
X-Google-Smtp-Source: ABdhPJxRxLdubDJWaJg/UlteggEmdsQrkIcrzJbwJZMWZFEkixU+yJP3eFRtZaAKkQfQOpT+MXjXQQ==
X-Received: by 2002:a05:6512:21cc:: with SMTP id d12mr17574280lft.512.1620167392186;
        Tue, 04 May 2021 15:29:52 -0700 (PDT)
Received: from wkz-x280 (h-90-88.A259.priv.bahnhof.se. [212.85.90.88])
        by smtp.gmail.com with ESMTPSA id r3sm1082273ljc.32.2021.05.04.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 15:29:51 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     "Huang\, Joseph" <Joseph.Huang@garmin.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "bridge\@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net 0/6] bridge: Fix snooping in multi-bridge config with switchdev
In-Reply-To: <685c25c2423c451480c0ad2cf78877be@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com> <6fd5711c-8d53-d72b-995d-1caf77047ecf@nvidia.com> <685c25c2423c451480c0ad2cf78877be@garmin.com>
Date:   Wed, 05 May 2021 00:29:51 +0200
Message-ID: <87v97ym8tc.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 20:37, "Huang, Joseph" <Joseph.Huang@garmin.com> wrote:
>> Hi,
>> This patch-set is inappropriate for -net, if at all. It's quite late over here and I'll
>> review the rest later, but I can say from a quick peek that patch 02 is
>> unacceptable for it increases the complexity with 1 order of magnitude of all
>> add/del call paths and some of them can be invoked on user packets. A lot of
>> this functionality should be "hidden" in the driver or done by a user-space
>> daemon/helper.
>> Most of the flooding behaviour changes must be hidden behind some new
>> option otherwise they'll break user setups that rely on the current. I'll review
>> the patches in detail over the following few days, net-next is closed anyway.
>> 
>> Cheers,
>>  Nik
>
> Hi Nik,
>
> Thanks for your quick response!
> Once you have a chance to review the set, please let me know how I can improve them to make them acceptable. These are real problems and we do need to fix them.

If I may make a suggestion: I also work with mv88e6xxx systems, and we
have the same issues with known multicast not being flooded to router
ports. Knowing that chipset, I see what you are trying to do.

But other chips may work differently. Imagine for example a switch where
there is a separate vector of router ports that the hardware can OR in
after looking up the group in the ATU. This implementation would render
the performance gains possible on that device useless. As another
example, you could imagine a device where an ATU operation exists that
sets a bit in the vector of every group in a particular database;
instead of having to update each entry individually.

I think we (mv88e6xxx) will have to accept that we need to add the
proper scaffolding to manage this on the driver side. That way the
bridge can stay generic. The bridge could just provide some MDB iterator
to save us from having to cache all the configured groups.

So basically:

- In mv88e6xxx, maintain a per-switch vector of router ports.

- When a ports router state is toggled:
  1. Update the vector.
  2. Ask the bridge to iterate through all applicable groups and update
     the corresponding ATU entries.

- When a new MDB entry is updated, make sure to also OR in the current
  vector of router ports in the DPV of the ATU entry.


I would be happy to help out with testing of this!
