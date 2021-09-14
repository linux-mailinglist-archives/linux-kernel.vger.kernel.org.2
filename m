Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E740B7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhINTNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhINTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:13:26 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24195C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:58 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j66so602143oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=BSSwT7oxjsgFOMu+1NGwhgQtpViayCWoOwG64CMoBRk=;
        b=hDSs206v3195Y560qB95htiH1r7XdiqlWoYYGIMmZKsme0wdt3U7Hl0DEmzORETQAl
         oY7mro96c7tw05FWPje4aYkbJ+sv5WycBN3Nw5uuG+YACDPdMvZNHwpOSPLMWJ5tSv7Q
         K57nIq7SsAR9mAnQlW2a/GH3wsihNJPESaOnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=BSSwT7oxjsgFOMu+1NGwhgQtpViayCWoOwG64CMoBRk=;
        b=dGuvYGZJ0YqJ07smi9djybtE6w9VPCpCWS67a53esQbHBkj1lFdJ0uDgivwAJE7z0x
         nfXW2fV6OEfcKs5k2SHc9eWqJ4OWYdb7yilp6Az9Ohy+y/HemL/dJhk1zLev4Pbt8xuw
         ifyW/TCM1HnPFpj2DC4hAZdzbUJVKQXpihlgWN8FA5CpPPANiQOQIYubvSTWGMia3+1E
         RNxiZR2BOIUBviFYa3D5zU3yEJ4M95CzbnjVNjEvJunwKN0rNRvk38Yxla4iZ30h48VF
         saWejxM/htH027K86JOvvxlrh3E/QJd2W8hds5R9yaq07KlYIWFTVWh/oDTK6dIq+zln
         jsig==
X-Gm-Message-State: AOAM533mGoSnxWusZrVDAej2Td3s6/soWQMClMvFdnjmGn2c9lxJmxMG
        gsU7TA3aS9ajrTwTg/GmrQ2bD59dxISSk38GLcBufA==
X-Google-Smtp-Source: ABdhPJxj/G3bL5HF0hTnBTg2JQFv34CpmMFfj/HJPwzL7skUSH+a239+sjhTD9p4IGQVFNxccYFtNL83KeC+Bp7Fvi8=
X-Received: by 2002:a54:4419:: with SMTP id k25mr2725351oiw.32.1631646717560;
 Tue, 14 Sep 2021 12:11:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Sep 2021 12:11:57 -0700
MIME-Version: 1.0
In-Reply-To: <20210909135838.v4.1.I1116e79d34035338a45c1fc7cdd14a097909c8e0@changeid>
References: <20210909210032.465570-1-dianders@chromium.org> <20210909135838.v4.1.I1116e79d34035338a45c1fc7cdd14a097909c8e0@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 14 Sep 2021 12:11:57 -0700
Message-ID: <CAE-0n53Pp1F5dZRk98WT5+K9jz_XpMkKUvYAs_suZFaOE0K39w@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] dt-bindings: drm/panel-simple-edp: Introduce
 generic eDP panels
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-09-09 14:00:17)
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-edp.yaml b/Documentation/devicetree/bindings/display/panel/panel-edp.yaml
> new file mode 100644
> index 000000000000..6a621376ff86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-edp.yaml
> @@ -0,0 +1,188 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-edp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Probable (via DP AUX / EDID) eDP Panels with simple poweron sequences

Should that be "Probeable" or "Probe-able" or "Detectable"? It's not
about statistical probabilities right?
