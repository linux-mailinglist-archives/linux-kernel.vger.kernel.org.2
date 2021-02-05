Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6B311335
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhBEVOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:14:50 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43779 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhBEVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:14:32 -0500
Received: by mail-ot1-f53.google.com with SMTP id v1so8217378ott.10;
        Fri, 05 Feb 2021 13:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdOl0F13pxJge2R1Q7jKYcIE1H7EbBbjBC3RqfEIO3k=;
        b=oJpO53vQo7a0elW4GG1GIXGyKLEnvl8A6A5AWUcj2khe2Q5XftTozEEj7X9lhcLf4K
         AG1C55maOsn3wAusHHQEr278ZWRmsPqMzkae7Au5L2jMB9b6hebpb5PA2El6C7s1K3Ym
         xgZyRj0vgEdCeQwSHzdKaC703AS1Vk5r8BP+mD3mdstHv0KAEPayZzTJ3803rTPSB2Il
         Yvcn/75CaSppsv/Fjg/XOKaOxrTu1Ag4D51ccmCt757GJfFA+SPzobWZS0n+w75nmTqP
         eXbKSyKXp4Kv8vKkQkKlE8OCIVrimSTabHVjYLEXWHlB4TWgQxTgxMF2Qqdr5SIsrx2x
         87Fw==
X-Gm-Message-State: AOAM531Z5wPUbY28mnSLR19HGppx/+mPjTkHhJlodAVz/g2dWOlTcGLP
        /cjYuot9AGaF9uY3uIf43A==
X-Google-Smtp-Source: ABdhPJyd6R3+xDA2JpgpcbY/ydGNCUbkfDj67fDjkvNrm0njnbdd07rSDZdrKN2f2wEsxFivft3RWg==
X-Received: by 2002:a9d:461d:: with SMTP id y29mr4820689ote.307.1612559629911;
        Fri, 05 Feb 2021 13:13:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm2003674oia.40.2021.02.05.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:13:49 -0800 (PST)
Received: (nullmailer pid 3752133 invoked by uid 1000);
        Fri, 05 Feb 2021 21:13:47 -0000
Date:   Fri, 5 Feb 2021 15:13:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philip Chen <philipchen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, dianders@chromium.org
Subject: Re: [PATCH v6 3/3] dt-bindings: input: Fix the keymap for LOCK key
Message-ID: <20210205211347.GA3752072@robh.at.kernel.org>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
 <20210115143555.v6.3.I96134907488f41f358d03f3c1b08194f9547e670@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115143555.v6.3.I96134907488f41f358d03f3c1b08194f9547e670@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 14:36:17 -0800, Philip Chen wrote:
> Decouple LOCK from F13 and directly map the LOCK key (KSI3/KSO9) to
> KEY_SLEEP action key code.
> 
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
> 
> Changes in v6:
> - New patch in v6
> 
>  include/dt-bindings/input/cros-ec-keyboard.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
