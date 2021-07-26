Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395893D69CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhGZWJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:09:09 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:46749 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:09:08 -0400
Received: by mail-il1-f169.google.com with SMTP id r5so10439122ilc.13;
        Mon, 26 Jul 2021 15:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2IlFJeLoX9S6E38ixxClAC75U16CkOL1MsQpQIY5pms=;
        b=t/VA+T+IKDvZJ69jTcZfukOP2CBosPC2z6HzGofYZmwnAwgkmWcWLf1XSFJ2lQLwQH
         NLEEB8SzO/vtWUhuasA6+FWh/uEnZmLVsbgAEf47A4pjwSSlDJYnyA5uS3EZ3nVcva2p
         +4IjD2vN34dIzFTgZ+IGXzyXfXkbB9jXCwInTql6+yFR4q02/X1ES1zxUx70XWtJ+CBf
         xFBPCiSxPGOo1xcqbLCQd1Er8ACJ/VRQKBwuiHah/gwfwjeZjQni/Gf3xB83EuDG1/aQ
         j5agy7ID7f4q6REfqTPwFevZLuBzvPXix1qzlh9vgk3N7mLbdBxZ5OdVqkK6gUYpcM1N
         0KGA==
X-Gm-Message-State: AOAM533uHCLsgtjTwTuCL/HlD/0iyZBtW0+hHYv4YadnbvZptB6yYskR
        vh3KEbpSx6sn7/AjKylpwQ==
X-Google-Smtp-Source: ABdhPJy/fSCdGZmYVDrgIYVzg7FLjRghDAeypciSTLfXvOna/mS0cUY4SC9USb5fKw61r2pAz5aLOA==
X-Received: by 2002:a92:c206:: with SMTP id j6mr14771530ilo.152.1627339776143;
        Mon, 26 Jul 2021 15:49:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x11sm614696ilu.3.2021.07.26.15.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:49:35 -0700 (PDT)
Received: (nullmailer pid 1020860 invoked by uid 1000);
        Mon, 26 Jul 2021 22:49:32 -0000
Date:   Mon, 26 Jul 2021 16:49:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artjom Vejsel <akawolf0@gmail.com>
Cc:     devicetree@vger.kernel.org, thierry.reding@gmail.com,
        paul@crapouillou.net, sam@ravnborg.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/3] dt-bindings: Add QiShenglong vendor prefix
Message-ID: <20210726224932.GA1020830@robh.at.kernel.org>
References: <20210725221527.1771892-1-akawolf0@gmail.com>
 <20210725221527.1771892-2-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725221527.1771892-2-akawolf0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 01:15:25 +0300, Artjom Vejsel wrote:
> Add vendor prefix for Shenzhen QiShenglong Industrialist Co., Ltd.
> QiShenglong is a Chinese manufacturer of handheld gaming consoles, most of
> which run (very old) versions of Linux.
> QiShenglong is known as Hamy.
> 
> Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
