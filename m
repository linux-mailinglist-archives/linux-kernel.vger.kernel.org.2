Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4447E34F1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhC3Tge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhC3TgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:36:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B48C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:36:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso8189198pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=9h8dWO9Y/kkQWnFlnTkJqc6pPWZhg9rrsYYtR6+oFgE=;
        b=M5/4VQPOT/0qHi1DXW2EX3CgUnJW6zpvmR1u4LxaV/+N/1G13p/H04Fj4cYL4vGvq/
         9R5RUaPYhy+4Ota88HPJ0K4Qj8Vju1+BYamvwP2/GwRb7x3gXemLsdf7YPXLyePFDPP4
         ez0A5pAB3z3/AWQcdD8ONqXZmm/y68Z3CEeMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=9h8dWO9Y/kkQWnFlnTkJqc6pPWZhg9rrsYYtR6+oFgE=;
        b=U6JjY0G7GUAG+DWctUx9Xhz4uES7Os3mQE5VVoSh5OqTUotsxpjqiiyUkJMo6WTZvO
         uNJGwsDwEQ7JIkR9fexvDzZOEEWjZrmGLMRXv/NTBzdwSfypDQix2CsBY60tNMwx22Hg
         rbEoU3ZVqIDc5pkKib1yMSX3Gb/GdH7H/NTqTASiPxjYi7Z/emJ+SvNgJ7KEa9eFg3Ms
         2Xmo64YTiAwMTieIxUhFF2FqYb+p2cPGRdbDakvltotq/ZrPub8cHqdY7U2AIlpQJuev
         KnH6AuBiQf4hEi00/SlvkM7ae770NzFxnS0Tv88cB3cTtz4aBoZ9a8JywSWft3p2XSjO
         SS1A==
X-Gm-Message-State: AOAM532hB+d60oiQ/McLTrEceFbd8Rw5/xaHIwcVeRxj/DZXBYRVKIdz
        hcY26eJUWH0yTWmOufNd31b+vA==
X-Google-Smtp-Source: ABdhPJwSGhPouJmi5s8MDDwugVa9IBI4veWbNwI5eL335kFYGCye2KnquEz9kqPuEkbqQV7xonI46A==
X-Received: by 2002:a17:902:c1c4:b029:e6:7bc9:71fd with SMTP id c4-20020a170902c1c4b02900e67bc971fdmr34066305plc.5.1617132974890;
        Tue, 30 Mar 2021 12:36:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id d13sm16596pgb.6.2021.03.30.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 12:36:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210330185056.1022008-1-saravanak@google.com>
References: <20210330185056.1022008-1-saravanak@google.com>
Subject: Re: [PATCH v1] of: property: fw_devlink: Add support for remote-endpoint
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Mar 2021 12:36:06 -0700
Message-ID: <161713296600.2260335.7459463781834702722@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2021-03-30 11:50:55)
> remote-endpoint property seems to always come in pairs where two devices
> point to each other. So, we can't really tell from DT if there is a
> functional probe order dependency between these two devices.
>=20
> However, there can be other dependencies between two devices that point
> to each other with remote-endpoint. This non-remote-endpoint dependency
> combined with one of the remote-endpoint dependency can lead to a cyclic
> dependency[1].
>=20
> To avoid this cyclic dependency from incorrectly blocking probes,
> fw_devlink needs to be made aware of remote-endpoint dependencies even
> though remote-endpoint dependencies by themselves won't affect probe
> ordering (because fw_devlink will see the cyclic dependency between
> remote-endpoint devices and ignore the dependencies that cause the
> cycle).
>=20
> Also, if a device ever needs to know if a non-probe-blocking
> remote-endpoint has finished probing, it can now use the sync_state() to
> figure it out.
>=20
> [1] - https://lore.kernel.org/lkml/CAGETcx9Snf23wrXqjDhJiTok9M3GcoVYDSyNY=
SMj9QnSRrA=3DcA@mail.gmail.com/#t
> Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=3Don by=
 default""")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 5036a362f52e..2bb3158c9e43 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1225,6 +1230,8 @@ static struct device_node *parse_##fname(struct dev=
ice_node *np,       \
>   * @parse_prop.prop_name: Name of property holding a phandle value
>   * @parse_prop.index: For properties holding a list of phandles, this is=
 the
>   *                   index into the list
> + * @optional: The property can be an optional dependency.

This bit conflicted for me on linux-next today so I dropped it in favor
of 3915fed92365 ("of: property: Provide missing member description and
remove excess param").

> + * @node_not_dev: The consumer node containing the property is never a d=
evice.
>   *
>   * Returns:
>   * parse_prop() return values are
