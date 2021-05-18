Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B20386F25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345711AbhERBa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:30:28 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39508 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbhERBa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:30:27 -0400
Received: by mail-oi1-f170.google.com with SMTP id u144so8257240oie.6;
        Mon, 17 May 2021 18:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G5rlvH5ctDOjiEvtgp0QPj5NTMf+LJJxdap62IYZ7rc=;
        b=KOkrQgw8I5u9XqcRzoCZL0KDHIeNMSil/4+Vf0LqHU7PtrqNEee0vJiDlsu4192Fbi
         P4USUGAkKA+Db3kzCro9w+/9AM70o8JOf54GLE2lnvceoO8mjuUcovylv2paCCt+KC1Z
         2kVbtIKay22r9lPJFvTgew2CrgsEqblNUWCJR0Mw7ax+s7MM/iHn8mlFLPKqhnMCXW1W
         9J+8aWLuqzqgeeBwAxTwEpnTfNedBRGF4NP2i5dGiUMp+jcAn9FOpAL3Zn/XwaR+IZPe
         b67zBlATP4COqI6oYs75cH5h2u6CbPWKyO0XLO3uNhK8UDXsBFJhNgSGbMzJLYVLhY1Q
         SYhw==
X-Gm-Message-State: AOAM5310kF/pJvJg8WsP+Deccrcyhs79G7Vs4TAkRWlgwJKxdoN3KjZY
        GoZ8iD+2hPMh+PZJbNlKsg==
X-Google-Smtp-Source: ABdhPJxu5sCBoppCrV1nenGEOaEw/iO0i1K0SwPC+mMOngSMEQKGgJoq2mqtZkwnXVi87nKERpCbZg==
X-Received: by 2002:a54:4104:: with SMTP id l4mr2023654oic.48.1621301348704;
        Mon, 17 May 2021 18:29:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c13sm3511147oto.18.2021.05.17.18.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:29:07 -0700 (PDT)
Received: (nullmailer pid 3602690 invoked by uid 1000);
        Tue, 18 May 2021 01:29:06 -0000
Date:   Mon, 17 May 2021 20:29:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 4/7] ASoC: dt-bindings: sun8i-a23-codec-analog: add
 compatible for Allwinner V3
Message-ID: <20210518012906.GA3602631@robh.at.kernel.org>
References: <20210514134405.2097464-1-t.schramm@manjaro.org>
 <20210514134405.2097464-5-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514134405.2097464-5-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 15:44:02 +0200, Tobias Schramm wrote:
> The analog codec frontend of the Allwinner V3 is compatible with the
> analog codec frontend used on the Allwinner H3.
> This patch adds a compatible string for the analog codec frontend on the
> Allwinner V3 SoC.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/sound/allwinner,sun8i-a23-codec-analog.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
