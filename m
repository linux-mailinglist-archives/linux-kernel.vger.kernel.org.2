Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD533729B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEDLxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:53:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 04:52:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v5so1973745ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GW6GUuONPABrx2BFXGJh0SjTmP9t0U63hpuN8y3MW9g=;
        b=paTEGtC0YjJRHiY0XOtzrdDks/f7ssjpY2ykEb4lVja6Dqw4GK5Ga52klAdM+1Xw7q
         wYk4uJ3b66kTTbKWcExYHyV7cA6ddteEovzt2gq7WMb8k1tQQ+t+CZhER7EnYfCuVLyE
         gixMlraFmO9yfKx3OiiWGqbzYZZlZxOf3e2OHWIksJhCEvvXXF5XWCZGgHkfeV4+Elwh
         GFLYTE331XE1cE+y7dQ5fgbQHsaQ49Ibr8UQ8XuGj/A1Xj/Vx2rLBcsoniWxhsiyIHVP
         Xp63OAGUA4dE/iV8sNsZkXYE4o6EuWihVaPxnDP4v5joLhgNVGbLmlQGXPk7L2H+TGfP
         UbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GW6GUuONPABrx2BFXGJh0SjTmP9t0U63hpuN8y3MW9g=;
        b=tvgP5Pj879AN+B19THBW/lDmeHpQlSF6jWJ95RNVQb490mmSgN3HEO4xDNPZTsc5iA
         XFvGysDGYFPAlSbJk3F2MSMCod0aZXTrMr5nhX28D5FwUB+0OE3qNIJCUvxA4Vzu+Oen
         jlqhh+VCHQpFlO5Wrxw0Zg604yVB98XnXp5YP6FCRYzKczdgiYc2ofdlel+JYywposTm
         9vhE9GiN2RF75CrZc10p1Fe2EGiZn1Du/nfPyH3d7N5dD/6S6NEFySLQgM9nfjIuF9Nd
         XT2WTx473QmVl5dIcEMPBu/SjC9Ta8jgydb27+pqW6b7VIUqwmlmVEPnReaH04wBJVFi
         +/rw==
X-Gm-Message-State: AOAM531quZJrtR0Pq+Kzwi5fqoaBFcflXHaMkW3iACSdqKHG9KOTXLRG
        fZIJC93/NSipBX2ouwBwQzbDT/Fyi+cATjBV+MFJS4pm7M9lZA==
X-Google-Smtp-Source: ABdhPJwMvWaROJxTzyqUMWt9k4L0D4nP4H1qFA1CD+B6GTbN3tnsxm5nrOc/d15IqhKbm1BGUA/tOjYmKar7oUPcKMs=
X-Received: by 2002:a2e:9606:: with SMTP id v6mr16780985ljh.79.1620129132801;
 Tue, 04 May 2021 04:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABPxzYKjxW+P_cMLmZgtQN7nbCB3zzksYQWpChC70tbVb6VJCA@mail.gmail.com>
In-Reply-To: <CABPxzYKjxW+P_cMLmZgtQN7nbCB3zzksYQWpChC70tbVb6VJCA@mail.gmail.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Tue, 4 May 2021 17:22:01 +0530
Message-ID: <CABPxzY+USNoiFDO8VYtLzFDK-0+PU1wD8ah7KGPWGZ+uEStH-g@mail.gmail.com>
Subject: Re: Module versioning + Missing CRC in symvers + export tracepoints
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mmarek@suse.cz, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 6:26 PM Krishna Chaitanya
<chaitanya.mgit@gmail.com> wrote:
>
> Hi,
>
> I am seeing an issue of no CRC being generated in the Module.symvers for a
> driver module even when CONFIG_MODVERSIONS Is enabled, this causes
> modpost warnings about missing versioning.
>
> The module in questions only exports tracepoint related symbols (as
> struct tracepoint is
> part of the module CRC), I have seen this with other modules also e.g.
> iwlwifi with CONFIG_MODVERSIONS.
>
> Though I am trying on 5.12.-rc2, also, seeing this issue with older kernels with
> CONFIG_MODVERSIONS enabled e.g. 4.15.0, Below are a couple of snippets
> to demonstrate the issue.
>
> modpost warnings
> ===============
>
> WARNING: modpost: EXPORT symbol "__tracepoint_iwlwifi_dev_ucode_event"
> [drivers/net/wireless/intel/iwlwifi//iwlwifi.ko] version generation
> failed, symbol will not be versioned.
> WARNING: modpost: EXPORT symbol "iwl_remove_notification"
> [drivers/net/wireless/intel/iwlwifi//iwlwifi.ko] version generation
> failed, symbol will not be versioned.
>
>
> Module.symvers (after modpost)
> ==============
> 0x00000000      iwl_remove_notification
> drivers/net/wireless/intel/iwlwifi//iwlwifi     EXPORT_SYMBOL_GPL
> 0x00000000      __tracepoint_iwlwifi_dev_ucode_event
> drivers/net/wireless/intel/iwlwifi//iwlwifi     EXPORT_SYMBOL
>
> Any ideas?
Adding people from this
https://patchwork.kernel.org/project/linux-kbuild/patch/CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com/
thread to throw some light on non-asm version of the issue.
