Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AEF3F26BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhHTGX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhHTGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:23:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D774C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:22:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r2so8155829pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=99KnB+URAYBtBEFeaEEoqvbN3Lia8bbvXa6b4D4VGvk=;
        b=AelbYVYXhvB2C9bFtneY/yrgfG2toP1CjqK6lvDsXri4wpxXyhmsJgoDY6ahx/XN61
         vKAczg+E4fXnnS8G0G93MoK9T+n8JSHY8ekq/8I4u69XNDvXXmaeliXWl3ny7DbR459m
         W50jTwNToE1LmUUokyr6le1aob0gVY3GnP1Ka3mI4XHwRz2fWCsY/l4SMPzwsS0xTXB9
         EixGvESxoBHqQEVnBddxUt4aKYU3B3NSH4JBU4qDMkK7Jhzi3FgC5Vb8HdCiGR2LwcMT
         sxBxULIIw3r+NvwPaEY2Ixaz7kUmSTr4+dFabybVlm+sD0srX/k7GhsedXDOGcsj6xyH
         5o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=99KnB+URAYBtBEFeaEEoqvbN3Lia8bbvXa6b4D4VGvk=;
        b=S1hDkIdm0hBUXd50/i7v/UBtulwaYmmlgvSPJ6dmAuHpadawsZ7dP4c0/jpJtUZkki
         H/U1WML4GbUAUMmESMqYB1M+vx74QhjYasBU4g0TSsczQbJR/Vl7AhpbAgkFqlEaFCWk
         TyvKFyS2BzBKcsVbqzU35vHeo5d/0hTg5Ndc2quFAZ7vCzB33woGlFow9HHZMefTp942
         /E+DRSPOILHCBToXwG7MtmUoarY8CmoSE5RrL4ifLgShuHdKOseH8vkzjj1+a0xTjatf
         IawXWwZWsAvKqShNX68Ehh1KUdRtAEYmUclwZWKyYDe7zhhOGXLTzi6BXncqNdehkNHi
         wrNw==
X-Gm-Message-State: AOAM531uNifX/Bsm/6UsIkz/nCy+ppxtvLDP8zOBAF7H12To+g99fFqy
        BDMtW+vX6CWybqOtqQnAucs7/w==
X-Google-Smtp-Source: ABdhPJypGMO2Ed7IdFKaQRO9FolvH4ihNSVV3QakhuP+Wz6bn/ypKEJCBJHQBshWUbxfQ2Oh/Vy6BA==
X-Received: by 2002:a62:b414:0:b029:317:52d:7fd5 with SMTP id h20-20020a62b4140000b0290317052d7fd5mr18445201pfn.30.1629440567069;
        Thu, 19 Aug 2021 23:22:47 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:549a:ad5a:e5bd:8c8a])
        by smtp.gmail.com with ESMTPSA id x7sm5507625pfj.200.2021.08.19.23.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 23:22:46 -0700 (PDT)
Date:   Fri, 20 Aug 2021 14:22:43 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] dt-bindings: sound: rt1015p: correct indentation
Message-ID: <YR9KM5ubMr9JLLb5@google.com>
References: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com>
 <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
 <CAL_JsqK1dhwSKbmCbuaWtBWQH0e-+rdJaWkzfx5b_5vX0toAjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK1dhwSKbmCbuaWtBWQH0e-+rdJaWkzfx5b_5vX0toAjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 04:52:38PM -0500, Rob Herring wrote:
> On Thu, Aug 19, 2021 at 5:12 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> >
> > Use common enum instead of oneOf and correct indentation warning:
> >   realtek,rt1015p.yaml:18:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>
