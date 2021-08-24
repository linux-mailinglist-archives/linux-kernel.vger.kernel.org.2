Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36E3F60C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhHXOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:42:50 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46836 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbhHXOmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:42:49 -0400
Received: by mail-ot1-f42.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso46627532ott.13;
        Tue, 24 Aug 2021 07:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhGPEZBjkq08uUtd6l2IpriYzbQMG6LhVhlNs+OO1DE=;
        b=VT67zrdxBputg43uUUwXRZujFpXomPCkAy9l5eNeEOAb418wRvk2t7TsWApvRfT3TE
         uElRpYDA1sHnQG141KBTtPwcctUYN6QIBXugkalaCyYhOW/NNl2uYga2YpgZ2P+MImko
         sgsNioxCnqlXxCDX8mc/lFNJ32KcdUz+p54ACZ9F+5ZIkiNFrlj0zy5+JSIslpFWY9S3
         pJfuPXxFn2KpcK1E33EAQFjmH3ljAz1wQzjWhuz9SrKBaLrp+v5jeAfJ6R89zMwhmfVg
         CsDzpbBJLQAHMf7jjetYmYnZaDI8nzhHVEtUBOKrjJTWZsfdBV/Sf6ibk4BYwMmwLa1t
         xVqQ==
X-Gm-Message-State: AOAM533wVo/Cn+0daOD2kVJdFOaR86L+lG2CUeYKoynPLjZGJkuFkfe7
        IHMZKfbyzn87acz1JhHBOw==
X-Google-Smtp-Source: ABdhPJzHcjEmPd8Ul0HajXxCl4SEILDsVRnXRGJhoo3du7EoOS2bgMCAKLJVO4seL7oOj1SfWO0zrQ==
X-Received: by 2002:a05:6808:1889:: with SMTP id bi9mr3081101oib.139.1629816125373;
        Tue, 24 Aug 2021 07:42:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r15sm4702268oth.7.2021.08.24.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:42:04 -0700 (PDT)
Received: (nullmailer pid 412187 invoked by uid 1000);
        Tue, 24 Aug 2021 14:42:03 -0000
Date:   Tue, 24 Aug 2021 09:42:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, sam@ravnborg.org,
        dianders@google.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        daniel@ffwll.ch
Subject: Re: [v2 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support
 enabling a 3.3V rail
Message-ID: <YSUFOzdFQAqLUMW4@robh.at.kernel.org>
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
 <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com>
 <20210820070113.45191-3-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820070113.45191-3-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 15:01:13 +0800, yangcong wrote:
> The auo,b101uan08.3 panel (already supported by this driver) has
> a 3.3V rail that needs to be turned on. For previous users of
> this panel this voltage was directly output by pmic. On a new
> user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
> to turn the 3.3V rail on.
> 
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
