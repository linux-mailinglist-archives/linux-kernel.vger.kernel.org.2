Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1264B3F222C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHSVTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 17:19:51 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35813 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHSVTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:19:50 -0400
Received: by mail-oi1-f176.google.com with SMTP id r26so10346068oij.2;
        Thu, 19 Aug 2021 14:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6ndjQ7qKsm3BuTtzm2lsx8jxF6MbixFKOgts6IRJ5+8=;
        b=pOhvV4eeduGB56TdVziRU4l/Pc1Z6tda7EDswIcK1Tv+UkCnrboT9IjqIcp6pk3Zzt
         AbFy/eLgpovWgQsjQtBtXQJmZCvgEO/4DjtF6dbp7S6gKd9s4fuM4NPtXUoR5PEXkAhN
         vyB4Vxheyt9AOCLAZHxMU+Nq2PdVpgFOscN1tMzcOYyEM94e5x11DMoIaLGl0ujBZ41a
         GWU66ImJXOl9ynue6bKWFDjh5Z9Mdr2HUwR910jJGz61RfaXEvn7beBf9Sf+qcI+ZOoV
         sEw+0t8LaF8AqE45oaw4X/7PQmF+5rtYgxP57R0EIhShLLlr3QcQJ+e0sKbpxsTdjjTz
         pz4A==
X-Gm-Message-State: AOAM530ft02Idy7JfqqO4G0TZE9g8kxsaOQiKU1p1fKY82I+oJbLf2V6
        SC92osVlM7OZmoApoFth5A==
X-Google-Smtp-Source: ABdhPJxXUzWsn+3Lyb8xHlM4XaqeFdxFTJhM4+LmDbUIinWDqggh+Xp8sgMp4ePnrnvS8JfUkyCm3w==
X-Received: by 2002:aca:bec2:: with SMTP id o185mr528567oif.151.1629407953436;
        Thu, 19 Aug 2021 14:19:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o11sm975827otp.8.2021.08.19.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 14:19:12 -0700 (PDT)
Received: (nullmailer pid 1418773 invoked by uid 1000);
        Thu, 19 Aug 2021 21:19:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sam@ravnborg.org, thierry.reding@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, devicetree@vger.kernel.org, dianders@google.com
In-Reply-To: <20210819124844.12424-3-yangcong5@huaqin.corp-partner.google.com>
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com> <20210819124844.12424-3-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: [v1 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 16:19:11 -0500
Message-Id: <1629407951.445122.1418772.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 20:48:44 +0800, yangcong wrote:
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

See https://patchwork.ozlabs.org/patch/1518662

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

