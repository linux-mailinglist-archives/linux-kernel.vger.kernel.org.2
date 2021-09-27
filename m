Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0541A35A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbhI0Wyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbhI0Wyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:54:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC786C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:53:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u1-20020a17090ae00100b0019ec31d3ba2so326810pjy.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JA7b+17NeQa8MxRoYAOMDqy2vhM9dB7W8X4n526ZCa0=;
        b=Z5O9ySOI18c257QEjUpy/S8DkTMRZbS+Opwm+B06YkbXyoON66i8zm0NmG1G1POeYS
         EBc7b9mKjFHhjnVmjWrHyrtObPg/oquR2Jn3r5VzpoNSSmbzAFUXVpMR0KdMkvSO3ils
         f2HFYDCiCdJkcZJt36DLQZwmQu3Xu5F9SFcdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JA7b+17NeQa8MxRoYAOMDqy2vhM9dB7W8X4n526ZCa0=;
        b=RBPtWA25q6IY9whhaBjpfqecIi2gd0aHOwJhCe7mv3EKNth2hz3mZBBvh6vCnC1BCv
         YcXEEQ2FAQuklHwda8RAy2klXNlomCMDEyK8kZXR3dojaDEG+AWfNmZHOzhLk5esb7aM
         hCI7VbfNgB6PW6Ma7MEGTwZKuQKnVqeAlbkmDc0/opTqrVa6U9YrAgj5K5oqOCi69giX
         981X0+Vn+25bCTFSh2EYTz+LkfLb8zE1h8ybGRrL0mlZ3/5mO6X7bRWa0A6ywAoh590z
         rW/co25w6SdeH8lmS7qNlDXoWGDtZmRhDVXYesgU4UrLEk67oVIhEVKzUMZXabm10Ia5
         Aydw==
X-Gm-Message-State: AOAM53117o8RnsxGvxOu1GSEQg7SrjPJTXTRK0wGRSv9432vDcUMyQKs
        o1Iwn+4YD84TsJXBcvHjVB10tpxMf/iCMA==
X-Google-Smtp-Source: ABdhPJxkB1+hIdcbUYUE1kpFcUSeQp8QyXRmiFqUkg3nIfTORYYZ8be8QnFQ8D4kae1TnKknxs4a/A==
X-Received: by 2002:a17:902:db11:b0:13c:7a6e:4b57 with SMTP id m17-20020a170902db1100b0013c7a6e4b57mr2025768plx.43.1632783184202;
        Mon, 27 Sep 2021 15:53:04 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:82d7:f099:76bc:7017])
        by smtp.gmail.com with ESMTPSA id gk14sm172195pjb.35.2021.09.27.15.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:53:03 -0700 (PDT)
Date:   Mon, 27 Sep 2021 15:53:00 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Thomas Hebb <tommyhebb@gmail.com>, dri-devel@lists.freedesktop.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        aleksandr.o.makarov@gmail.com, stable@vger.kernel.org,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>
Subject: Re: [PATCH v2 1/3] drm/rockchip: dsi: Hold pm-runtime across
 bind/unbind
Message-ID: <YVJLTLuNHNAzVq5V@google.com>
References: <20210927175944.3381314-1-briannorris@chromium.org>
 <20210927105928.v2.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927105928.v2.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:59:42AM -0700, Brian Norris wrote:
> In commit 43c2de1002d2, we moved most HW configuration to bind(), but we
> didn't move the runtime PM management. Therefore, depending on initial
> boot state, runtime-PM workqueue delays, and other timing factors, we
> may disable our power domain in between the hardware configuration
> (bind()) and when we enable the display. This can cause us to lose
> hardware state and fail to configure our display. For example:
> 
>   dw-mipi-dsi-rockchip ff968000.mipi: failed to write command FIFO
>   panel-innolux-p079zca ff960000.mipi.0: failed to write command 0
> 
> or:
> 
>   dw-mipi-dsi-rockchip ff968000.mipi: failed to write command FIFO
>   panel-kingdisplay-kd097d04 ff960000.mipi.0: failed write init cmds: -110
> 
> We should match the runtime PM to the lifetime of the bind()/unbind()
> cycle.

Hmm, sorry to reply to my own patch so quickly, but after a bit more
testing I'm finding we still have yet another problem here -- that
suspend/resume does not work. For suspend/resume,
drm_mode_config_helper_{suspend,resume}() are expecting to only do
teardown/setup via disable()/enable() -- there is no re-bind() (which
makes sense). But the DSI hardware state may be lost, so the resume-time
enable() may find the panel initialization timing out yet again.

Possible solutions:

(1) I can add PM suspend()/resume() operations just to call
    dw_mipi_dsi_rockchip_config().

(2) Switch back to using mode_set() for HW configuration, like the
    downstream/BSP driver does (and the initial versions Rockchip and
    later Heiko were working on did the same), since that's always
    called at the right time before both panel and encoder enable().
    That also happens to be where some other DSI drivers [1] do similar
    init.

Have we been avoiding (2) just because that doesn't really match the
intended purpose of the callback? I can't find any cleaner callback for
this at the moment, and I'd rather not try to introduce entirely new drm
helper callbacks just for this particularly-unfriendly sequence.

I have a patch written for option (1), and may send a v3 soon to include
that as well (because that's also a regression from the same commit).

Brian

[1] e.g., drivers/gpu/drm/bridge/nwl-dsi.c
