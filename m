Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF13F8F32
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbhHZTtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243454AbhHZTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:49:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2769C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:48:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q3so5241390iot.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9r6P/TUxb0E3FmM0klJiSdufzbjU3qGMGKgnCkSAmo=;
        b=rWuumi0cfmaz+Lq5UB6OEufM3QFy/niE09oV2rgA+PbfiPEOoK1hTHciBG5KeN8SF7
         5Z5Yz6e4Q5afb33HPogWx8soUhzsU7hw8jofc6CqRO4tF28CHqXlBccSapfdRl4vdzP3
         LzsphsRQQLwYpOo1HaOWAKmHE6pbJOLERiYf3n2lZXh54MfZJj2O1i2COeZAM/X93cJj
         JCsT7q+7EKToEi6rVR5kd33yzvLgxyfVzx8hsyL6QIXPwmFeJhLSimjVLx6w4jyBtyHq
         RHCU059H60HONmAFsjzea/Lo8TR+TyvC3YpUUPm5xuEgljFczvB2K2VzptjtTB20kaup
         XEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9r6P/TUxb0E3FmM0klJiSdufzbjU3qGMGKgnCkSAmo=;
        b=kLEqVmynwjHfJM2s9Ua4E49+SvVqvCUsl9sqJtkT8xRvv2fhhP1jLEDO0fR5WsUVLV
         bnWxcCVRp+/zQw2/oIGIeTwPgts9qXbf8i8e0/XUYM3pI2rjAHX2rnijnTUyqFJrar90
         HK/sY6QCBMPdIXthzTpWm7m9JeXxo44/ZkT2RnxgqiysE7WeTYi7kPY/zT/eEVr/sZ8I
         cuRyKiG7lcDMj0LK9Ig+4M/AQCZURwgLVCRZhCAPntE/zrxhOpHfDr1kwg1rJNX5sELT
         XsqmXbDM4kCuAPKj/ouRe4RMOabVWntGIvcL7q4G10AYjZJqqtA4UDCvAL92QSSEBjsR
         Ykog==
X-Gm-Message-State: AOAM532B5BBdaSihwy8I8aGrsQCeOqzkAW4/7C9dnT6/j8X5kxiZnn6E
        fu/jz21bbCOVC+xjGz+Bdcbhsx6PHO4Iv0N4sQICqEoIq00qNg==
X-Google-Smtp-Source: ABdhPJybUiZ/1aDkojLeaVirp1rPMj1gGTcE/+wAcvdKIseIFYTffMk7FQo9U8EsVQNVmvDuU4vmZXIsrIte7MMrQfs=
X-Received: by 2002:a02:cca8:: with SMTP id t8mr4919268jap.51.1630007325141;
 Thu, 26 Aug 2021 12:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com> <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210820070113.45191-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 26 Aug 2021 12:48:33 -0700
Message-ID: <CAD=FV=Xu4WoQ=cTTQw93NaT1=+QePmDSYQ+4oDAjLnrNAdMx8A@mail.gmail.com>
Subject: Re: [v2 0/2] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam / Thierry,

On Fri, Aug 20, 2021 at 12:01 AM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Compared to v1, "pp3300-supply" is removed in the required list:
> dt-bindings: drm/panel:
>    - reg
>    - enable-gpios
>    - pp1800-supply
> -  - pp3300-supply
>    - avdd-supply
>    - avee-supply
>
> yangcong (2):
>   drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
>   dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
>
>  .../bindings/display/panel/boe,tv101wum-nl6.yaml      |  3 +++
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c        | 11 +++++++++++
>  2 files changed, 14 insertions(+)

I've been keeping track of this series since this panel is supposed to
be used on a future Chrome OS project. It's quite simple and the
bindings now have Rob's Review. I'm happy to take care of landing them
in drm-misc-next if that's OK with you two (since you're listed as
maintainers in the bindings).

-Doug
