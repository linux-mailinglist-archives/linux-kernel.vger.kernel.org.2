Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4382A3A1EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhFIVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:15:49 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39829 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:15:48 -0400
Received: by mail-wr1-f45.google.com with SMTP id l2so27009559wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=cAUmhDMcAs6pVQpZ39SGVcYjz64esmLkl1UKed+u18o=;
        b=pNeRzIRnaTGmkgMPbCsKBqgdbBVn9dylp+G0Eqvxu807/HBsMAHxFUc5a+XIu1yHK6
         SKaaUgzOTNFBC4rvP2sqwz3/JVHsQc+6eTBDV1LrgowQmYyY2ozO+r3AudwfHuKHMPOt
         nGTVhRY7x9UToA6cGogqALMWoCpW1Q/oI5ZWOeIz6AqDIsPLFWHwkV40xCBf57Scki0W
         chuyVwZKLNkuY0csTRr/Q2Pu3QnvfhgPVge/m3gQajCdvc6Xhcsz3s8PJvC/bTEeK9Mh
         BS/28jwR12tLz6YgMI3N38oshG8cqKarWsMbTtKfAbFsGm1SAiDy1/0jJCJf3CZOQ/JX
         ZaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=cAUmhDMcAs6pVQpZ39SGVcYjz64esmLkl1UKed+u18o=;
        b=PMSAwXDZV76uTa+UL24mTQO9wZKAMxYR6r2XIruXAuBGJqCruvbFSF4uZG9SL8R33V
         fJCEXpInI4QqWIaH3d1VxuQ6My2+8chaP/5dtSvpjZ63Pn9NORVQJdHNdhZ2lUO8N4Ns
         2x+0gwUisabQye3DY7a5GDbA2CHSnvkLXFI0QOJl5prmQgOtp2pKHopQvjoKC84O6O+t
         B5ZA9sLPRfzzCWUphgvrdvsP2pRXTEv6BhFzA2e17kJujsWueVdVW6Ac1QGte+9RkqA/
         sOng+Bwo64lXK43vr9BPR8RceTrutcWMpIAKlnTxslJvzlooF7vohbuLhVjTSRSE/JHT
         C34A==
X-Gm-Message-State: AOAM530b3KYxHSnzz7ihRNCBwRMUPgDkezjaEFvf5zrlc1P+b+Ui5P+u
        QSDipJmO5ta/FCEFVl2ZKXCsIw==
X-Google-Smtp-Source: ABdhPJyQoNukEOdgVu3ZKB+pj81tAMSWz8KS/fjVm7EvL0ZxydElHHPfNS/0BXv1kWn2Op9TO/p/xA==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr1736396wrx.22.1623273172798;
        Wed, 09 Jun 2021 14:12:52 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id m21sm7088297wms.42.2021.06.09.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 14:12:52 -0700 (PDT)
References: <20210604032957.224496-1-xieqinick@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     xieqinick@gmail.com, narmstrong@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: Re: [PATCH] clk: meson: g12a: Add missing NNA source clocks for g12b
In-reply-to: <20210604032957.224496-1-xieqinick@gmail.com>
Message-ID: <1j1r9a214c.fsf@starbuckisacylon.baylibre.com>
Date:   Wed, 09 Jun 2021 23:12:51 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 04 Jun 2021 at 05:29, xieqinick@gmail.com wrote:

> From: Nick Xie <nick@khadas.com>
>
> This adds the Neural Network Accelerator source clocks for g12b.
>
> Initial support for sm1 already exist in
> commit 2f1efa5340ef
> ("clk: meson: g12a: Add support for NNA CLK source clocks")
>
> The sm1 and g12b share the same NNA source clocks.
> This patch add missing NNA clocks for A311D (g12b).
>
> Signed-off-by: Nick Xie <nick@khadas.com>

Applied. Thx.
