Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4135F7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352280AbhDNP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352278AbhDNP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:29:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E808C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:29:03 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x11so21743479qkp.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9Oa3BGE0nLdxfYSEJulYCQMQ2MOOmW16QvouCtA+Ws=;
        b=Trw4QaVx4IDtynizdbhRMzOZ6NQrZOQkImB52ygkyeKLdYaiE1ZQofk/brnMhXSpSS
         84gc4QfaWVXCoIWRgBQ+2U/V90JRhWBtDdeODEyCIwoQ7RTmvB+6v8tXi4ZltwjX7XbJ
         UBthN1H+rm9GC2LQJeI14t5WmXgg2Zgh075As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9Oa3BGE0nLdxfYSEJulYCQMQ2MOOmW16QvouCtA+Ws=;
        b=NpY9eO0+hykQngQu1qNqdL2jqOiNtPIodPqjQrG8nC8dpw5qFROw0uWx9E61lvnkZD
         ybFbW6KLOqDzmnYlZdJu8wmL4hY7MhOVu3KyY0Udht00esxrCoLv0Pi5IXxznnJM2GUt
         YnYquNrD7+iUcMh9hdkwldbGl4xOJ1kZDSLAJiCMu76PvgUdsoS+2o2OAZgEKPefFlZn
         ygabOWB4R0sjtfiQ1R0c0yUzEdzfEpxT2Ga2/3lgob+xR+qAf2fSDIm6h/N+ukXdGmM/
         CW6rc/jDXdJHJHSjWcq409txEOIVtyUDNolfMSbwn80uadkmNkQUEiXBaMt7DGRL9lXW
         dL8A==
X-Gm-Message-State: AOAM531caO1uLYSSVnyPW84l8jWUeG3V2M30zUjrYydrNZizDuW/rj24
        oc6xs9eyWFq9BAEGom17kHddV3MfUMrtKQ==
X-Google-Smtp-Source: ABdhPJx0unGGXbUg5T9Xo6Y+oqfqM3ntkTn0vxSANCrVMelcpcEtmZeXYH/j7ZmVhAoCxpXXTX3TLg==
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr30535336qka.145.1618414142202;
        Wed, 14 Apr 2021 08:29:02 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 2sm8395552qko.134.2021.04.14.08.29.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:29:01 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id k73so16289675ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:29:00 -0700 (PDT)
X-Received: by 2002:a25:58d5:: with SMTP id m204mr55376026ybb.32.1618414140336;
 Wed, 14 Apr 2021 08:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <1618276850-27178-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1618276850-27178-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Apr 2021 08:28:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VvrWKKbLExpFaDLTDGTam3rbwd7CwTLVFdCY=_c7-eag@mail.gmail.com>
Message-ID: <CAD=FV=VvrWKKbLExpFaDLTDGTam3rbwd7CwTLVFdCY=_c7-eag@mail.gmail.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Skip ELAN power-on command after reset
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>,
        Jingle <jingle.wu@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 12, 2021 at 6:20 PM Johnny Chuang
<johnny.chuang.emc@gmail.com> wrote:
>
> Fixes: 43b7029f475e ("HID: i2c-hid: Send power-on command after reset").

Note that the "Fixes" tag actually belongs down at the end. It also
shouldn't have a "." at the end. Presumably the maintainer can adjust
this when landing?


> For ELAN touchscreen, we found our boot code of IC was not flexible enough
> to receive and handle this command.
> Once the FW main code of our controller is crashed for some reason,
> the controller could not be enumerated successfully to be recognized
> by the system host. therefore, it lost touch functionality.
>
> Add quirk for skip send power-on command after reset.
> It will impact to ELAN touchscreen and touchpad on HID over I2C projects.
>
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>

This patch looks fine to me, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I can confirm that after applying this patch I can recovery my borked
touchscreen (which got borked by a failed firmware update ages ago):

Tested-by: Douglas Anderson <dianders@chromium.org>
