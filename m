Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90821346A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhCWU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhCWU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:58:16 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113DCC061574;
        Tue, 23 Mar 2021 13:58:15 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso20848930otd.8;
        Tue, 23 Mar 2021 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4LFUuvacEBtLCJec2bwGks21oMmeJwUPGKWv10C7C8=;
        b=aWqwV9krBYdgh9hR8z79d2Qzw/sRzYFWMsWJk9Ozj4GxrngcfN+8qvMLXiHzdAi3Nt
         LBwARDJl4FwHlwTiJ59wLv6GcfmTMr0VcwMXV7eegwjnD+kVp/IdNgDpWJzFry0eyv5w
         RRtXqv3oidstONhzh13gAtV+oSj1B7yREwtFDmAjPVdc7ng8LlInOO65/DrPuao6NHBF
         dWP35xM7aImsonOMr6Svmpfgm1H+DpBZuTFNb0qpLHPagthaXAHhPjX0OfiwyXQp6Qoy
         KgytKqJKB4wJ8CBRfaGGC3Dd6Ey8ZwCaJjkkbNjVawQBK39Y76oH6pFc5bHexFRVuV1l
         pdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4LFUuvacEBtLCJec2bwGks21oMmeJwUPGKWv10C7C8=;
        b=ady2pj6ZBbuhWrmF7CH6tyNHVp/3tqAbla9Q5iCHHVr2wuYx99Bzo5XcgflSL8ktxv
         tJKXqAHxiSBGERI70ntWaO4y2WJsaOegEweN9I7HTq3VgAgpzLgcW6eqA47mmrdzEQOD
         GkEzURRycEBF8NjMPoOUkWlSbgkxiyFLe4tfDoP15Dw4xelMGuyIL48amjDPijaalq8p
         4uRAeY0YqG8h8wRooy9cy4VS1OAynd3HsCoiOWxFBGpyqj0qsLrLbz8hZQnLWsI2ihgO
         5GSQa66R5dYAcMuJuBT2Mwax2zFxmI5bdDkZrl4iP+2m7FuyeiwRMymNbm+Fx5xDKrCX
         NrdA==
X-Gm-Message-State: AOAM530bKTG8A3M0vMcFNRoKS7RadPqmz2tSU0nKTkKcUCO3lS0lpwUF
        6RwSAMKo+2bclwpVkWR1u1guelJ94ibJo69V2D8=
X-Google-Smtp-Source: ABdhPJyHZ1pae6Nl2pvb8qk7MYGjCTtqtWRnJhavUHApDVyIXkNdKqNK1n7ZWNeQ7Hp9hZaoN0cvhGQSiep/mGFUBWU=
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr202422oto.362.1616533094272;
 Tue, 23 Mar 2021 13:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210323082410.22818-1-zhangqing@rock-chips.com>
 <20210323082410.22818-3-zhangqing@rock-chips.com> <87e50d5b-604b-508c-f3cb-ee07fcf15241@gmail.com>
In-Reply-To: <87e50d5b-604b-508c-f3cb-ee07fcf15241@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 23 Mar 2021 21:58:07 +0100
Message-ID: <CAFqH_53kBf++SPfir_5mA9Dv2v=u4s1zpqnztAH8Tt2-9dLVnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: Convert the rockchip power_domain to
 YAML and extend
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cl@rock-chips.com,
        huangtao@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

Missatge de Johan Jonker <jbx6244@gmail.com> del dia dt., 23 de mar=C3=A7
2021 a les 12:06:
>
> Hi Elaine,
>
> Some comments. Have a look if it's useful or that you disagree
> with...(part 1)
>
> =3D=3D=3D=3D=3D=3D
> There is currently already a patch proposal that does the same.
> Could you read that review history and port the good things to your own
> patch serie?
>
> Re: [PATCH] dt-bindings: power: rockchip: Convert to json-schema
> https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/
>
> Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
> https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/
>

In fact, the latest version is v6 which can be found here:

https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.65=
3095-1-enric.balletbo@collabora.com/

Feel free to integrate and/or improve that version in your series.
