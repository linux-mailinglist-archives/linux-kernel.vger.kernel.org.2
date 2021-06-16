Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6091A3A9E74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhFPPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbhFPPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:04:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B744C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:02:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j184so2915296qkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j51VtbWEsPmNthXDSqqlA/0JAvr0xhkR2POpSAUOx9c=;
        b=ZUIi2qzqYGHwJx+79Fc4944r16x9UMQqqYLtcBz8HCOT0nsZkxfGcmRp23lvyNfAP+
         2knAodSGIE5+PM0wcoqn9rQAvNIbG2+5Sas5+iUH6G+5iioPe8sGy4aqBr4h9MHBFQLA
         j4DhsbCGODeTQCqVCt1gM8KYJ3xJ2R6oiax+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j51VtbWEsPmNthXDSqqlA/0JAvr0xhkR2POpSAUOx9c=;
        b=IpptPvULxZnNSWKfg0IgZypgCKXxAWn5ifJKB5D6ewoUnp4aBOBREGJZox5aOZ3lb4
         FpNkzLU8yoDfnUVkF8BqwKPk5YVlq3jvvcNEU8/iWT+tvDqUEvR0qtbw7T56IrtISzfO
         LkoA+SyG3ggROywOQfL6my94QqVH7bCJl/G3cBR1xbMEpF2+p1LKsoBemScBf28/aSJ0
         rg9ZuM/FnllyNFggh85tMpvH9kme13WvKxSA1u19EYe8FGmk0/BBvlgMplLHsicwKl/E
         pf9m5FEjwHVqW30UjJZTUqjcKQvX24wH7RfsAFwcXrOM4RsOj/g736cWCXJ270HWfFf0
         uWNQ==
X-Gm-Message-State: AOAM5325dyykHAwPyNg8MoHp9Uc1mjfW/kUDWsCDdlfoM11zCWXhfs7p
        aSQpta04yfoZhWH7EOkYKe2KdAA+UZ8Z+g==
X-Google-Smtp-Source: ABdhPJzJW5t/BCmmGzkSqvkuYXOC/Ufq/1C1wZMwzB/BAMqKnsimQLQiTiJykruRX1sxRZnAjW45Sw==
X-Received: by 2002:a05:620a:1444:: with SMTP id i4mr502564qkl.48.1623855743174;
        Wed, 16 Jun 2021 08:02:23 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id q16sm1715763qkq.121.2021.06.16.08.02.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:02:21 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id b13so3463408ybk.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:02:20 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr207252ybp.476.1623855739461;
 Wed, 16 Jun 2021 08:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <1623499682-2140-1-git-send-email-rajeevny@codeaurora.org> <1623499682-2140-6-git-send-email-rajeevny@codeaurora.org>
In-Reply-To: <1623499682-2140-6-git-send-email-rajeevny@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Jun 2021 08:02:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2_LJkXX-9v2ArSspKHy6PABn1E-hkCOeT=Dk5R0CQ+Q@mail.gmail.com>
Message-ID: <CAD=FV=V2_LJkXX-9v2ArSspKHy6PABn1E-hkCOeT=Dk5R0CQ+Q@mail.gmail.com>
Subject: Re: [v6 5/5] drm/panel-simple: Add Samsung ATNA33XC20
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 12, 2021 at 5:09 AM Rajeev Nandan <rajeevny@codeaurora.org> wrote:
>
> +static const struct panel_desc samsung_atna33xc20 = {
> +       .modes = &samsung_atna33xc20_mode,
> +       .num_modes = 1,
> +       .bpc = 10,
> +       .size = {
> +               .width = 294,
> +               .height = 165,
> +       },
> +       .delay = {
> +               .disable_to_power_off = 150,
> +               .power_to_enable = 150,

As per <https://crrev.com/c/2966167> it's apparently been discovered
that these should be:

.disable_to_power_off = 200,
.power_to_enable = 400,
