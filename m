Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E507F316F39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhBJSvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:51:37 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41016 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhBJSof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:44:35 -0500
Received: by mail-ot1-f53.google.com with SMTP id s107so2753001otb.8;
        Wed, 10 Feb 2021 10:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JLKTPoir/h9R65s1iDflvlmy5CWbPRCBVjFlvRoyomw=;
        b=lg9ixo4cXxQveA11bx6o7dyK8+LSRARIQwR6Xs7QGZ0CdMyYhEI4KWiOCm7Hb2l1CH
         RStdDdmLCh33g0PFxFzoM8XZHbvsGY7MJ8z+Ek/EzGx/2fBEVKj9HatGdHr9lTTZADVR
         wIktFwpRgDamlTvs2AD7Je78DNMYtA7xZm2rAYvP35KbS6kg9d5qdGV8qILStndtoE5Q
         vPYst4iGghV78ZZvCnDhpCirvb4Hgrpab0t2cmpBAk+suKHMe+Ye/mzEyeboJiGqU2Qx
         +tv+G0V2ULgG+5RAHyp154bBXyRCm9BRJX18qFUUYxpPOuGoDfV6Avk2KmstD1YP96qc
         SKcw==
X-Gm-Message-State: AOAM531dO2O5A+GxEzHAirjdKxV32CaM1W0m/SYNtWPmRx/h3ad5eU4v
        KFYDYVjqqoNf2kPNXYxZyw==
X-Google-Smtp-Source: ABdhPJxM1FaimNqlBQvzW+q9M3P/dnUkivLE3Ea3GcFgSXrF/r89b3iadrMmpJCYaYpo7zH5UMgNkA==
X-Received: by 2002:a05:6830:1496:: with SMTP id s22mr3099422otq.249.1612982634364;
        Wed, 10 Feb 2021 10:43:54 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w13sm541373otp.51.2021.02.10.10.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:43:53 -0800 (PST)
Received: (nullmailer pid 2520857 invoked by uid 1000);
        Wed, 10 Feb 2021 18:43:52 -0000
Date:   Wed, 10 Feb 2021 12:43:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, balbi@kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 6/8] dt-bindings: usb: dwc3: add description for rk3328
Message-ID: <20210210184352.GA2520802@robh.at.kernel.org>
References: <20210209192350.7130-1-jbx6244@gmail.com>
 <20210209192350.7130-6-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209192350.7130-6-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 20:23:48 +0100, Johan Jonker wrote:
> Add description for "rockchip,rk3328-dwc3".
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V5:
>   add select
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
