Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B823F19BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbhHSMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:50:02 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41980 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhHSMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:49:50 -0400
Received: by mail-oi1-f179.google.com with SMTP id be20so8351057oib.8;
        Thu, 19 Aug 2021 05:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DoBMmwE1xMwHj39wis0T6SrS2LzAGaiwOQbXQYLmvlk=;
        b=l3F90budBN7Ph/ihr12EmrfNw9j1UocuOWImq6TvoEA66Mz6dXyOVh/4ih9yf7XHj5
         /4q1VGw/B6kqYF7Ekdg2oPvkWi2QdhAFeluT9DjSfzlLcK6Rbue22xsl0yn78+6Fftis
         lnAc1NLPSOxqTBK6OmG5HIH1XyQ26siufUrtDm/YZyOE++AqxZQkhwt37oHtS5mzPQYQ
         slx/li6tl1/yWiRGNSKIAMuEItv9aBtJ/8ur5Ce+hDvh+fCR72nK4Vm4dxAY36+ftlTN
         eCVuMjLXaAb9GL7EYkQNXtc0S+OgcuX6lvPnwRGEJqOx7aCVVyti4voLCz9qxXmpSXWi
         z7jw==
X-Gm-Message-State: AOAM530zkioBfJfRvBLOc5k95o+VQIm8dRzOslgDcPzw3tIXK8HHPaOx
        YUaT0H8I6RqWyG2Qgoch2g==
X-Google-Smtp-Source: ABdhPJyXde09prDPCRyTxmwMcMN/kXtavHI6GGf6AlItNytnsf7Ai/IxKpXpnFJO7Re0+6S2irWP7w==
X-Received: by 2002:a05:6808:13c8:: with SMTP id d8mr2491242oiw.169.1629377354079;
        Thu, 19 Aug 2021 05:49:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p64sm665192oib.4.2021.08.19.05.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:49:13 -0700 (PDT)
Received: (nullmailer pid 288213 invoked by uid 1000);
        Thu, 19 Aug 2021 12:49:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, dianders@google.com, sam@ravnborg.org
In-Reply-To: <20210819092943.719433-3-yangcong5@huaqin.corp-partner.google.com>
References: <20210819092943.719433-1-yangcong5@huaqin.corp-partner.google.com> <20210819092943.719433-3-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: [v1 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 07:49:09 -0500
Message-Id: <1629377349.165324.288212.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 17:29:43 +0800, yangcong wrote:
> The auo,b101uan08.3 panel (already supported by this driver) has
> a 3.3V rail that needs to be turned on. For previous users of
> this panel this voltage was directly output by pmic. On a new
> user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
> to turn the 3.3V rail on.
> 
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.example.dt.yaml: panel@0: 'pp3300-supply' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1518552

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

