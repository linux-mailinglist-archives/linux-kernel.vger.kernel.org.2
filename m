Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B03DAEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhG2WaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:30:13 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:33663 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2WaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:30:10 -0400
Received: by mail-io1-f46.google.com with SMTP id n19so9176660ioz.0;
        Thu, 29 Jul 2021 15:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nxHho6RZxjUuYURjfVw+2b6ILg8EjvBd3YtWTTGJ9Is=;
        b=S/zN7gDbM3Dqyv9tSR3znu98IIja/mHSyq2yh1eq0kHhXEYEWyk3CG7beVadp7Qgn3
         PBM+ibUw5xDtoRQLTfEm9fqzmtUuKepwBfVFtE9rlny1/51G63mjRoUpZ1F9iBnEaGvU
         IcxCBLnWPG24xW9vFaKablZODmnhF6Fba1x77aNMaqPgZaGV1sgFPiApMIbX9IhNus6t
         trItCwEIyoIkOBw2/FNP5KkFeDjoCUtNdxYcz52RlJjzm6QK8M2rOAz9LoHIseDqjXjq
         V9fIml6sDffHCwdPuYm6kOxkbaFoEf0v0b+x2mjVVwYhDU/XIEkAYrBEJguXR3LPb3mL
         B+KQ==
X-Gm-Message-State: AOAM533MDU7EfLG4EL8ezBJ+JwojnG6vD++7VwYfxb+3br43ZRN4+Ta4
        9ilLDWSYzCn8m8wnyBZbfg==
X-Google-Smtp-Source: ABdhPJx3FAFP9axGNQ3Quk45L4+xPnWPLhYc926b4evgK46BUcmGvFDnG8jsDH5SjroGIGATVhBwbQ==
X-Received: by 2002:a02:6f1c:: with SMTP id x28mr6371373jab.95.1627597804911;
        Thu, 29 Jul 2021 15:30:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y14sm2335867ilv.76.2021.07.29.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:30:04 -0700 (PDT)
Received: (nullmailer pid 1020064 invoked by uid 1000);
        Thu, 29 Jul 2021 22:30:02 -0000
Date:   Thu, 29 Jul 2021 16:30:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
Message-ID: <YQMr6slu/Nvt6UYr@robh.at.kernel.org>
References: <20210725140339.2465677-1-alexeymin@postmarketos.org>
 <CACRpkdaaQeuVqJbczHndsgmmMv0NycwRDdzFTDwM=BJnc7SseQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaaQeuVqJbczHndsgmmMv0NycwRDdzFTDwM=BJnc7SseQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 09:51:40AM +0200, Linus Walleij wrote:
> On Sun, Jul 25, 2021 at 4:04 PM Alexey Minnekhanov
> <alexeymin@postmarketos.org> wrote:
> 
> > The Samsung S6E3FA2 AMOLED cmd LCD panel is used on Samsung Galaxy
> > S5 (klte) phone.
> >
> > Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> 
> Grr gmail put this in my spam folder, sorry for confused mails.
> 
> With Sam's comments addressed:

What comments? Sam's mails seem to have problems getting to the lists.

Rob
