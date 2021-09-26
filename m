Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D05B418B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhIZV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 17:27:35 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C7C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:25:59 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r1so19252748ybo.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMPgg6KbNR7SBuS84OoPSFsPWPTjKDeqDpJ1FZRuuU8=;
        b=fhyf21dva/dA7hTHOYfThNp2a7oPQD7YyLzd4632YHpv0fb0+yw9pI03VHxZJZtBmh
         bLXUOqGgDnXHgwmjViGuewaY3Xx8o+qWn3frItKEciD5a+jG8G5VtOHpZhSUYb0XqNAu
         +3sCbmfi+L4+rjmOl2VhNyMQWLzYlHrz75rX8kiFOll2po48Dp+NdPZ8dsNMr5bG/mnk
         ErqATV57SoZMoWI9jrvxPKmmAo8KdFkeXmG8a1T8lP/WvRJP/FXveCsdvh6ymlljUZC3
         D+X9May/v0D1qa6RML4ptAAePQDnC2qOtr30okRtHyKpGBoropDdRNaJTzfMHEScVuq+
         tA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMPgg6KbNR7SBuS84OoPSFsPWPTjKDeqDpJ1FZRuuU8=;
        b=eBm1i2PhgD2e+4wKTpzbtx7GEo+mIhvruCwMJRPcKpMx12/khOljJbYVNWmnqsyBal
         9e8gapI5fyGFsNmnzobS52o7sCeCQkt9UyQeUscXuhcrxiqXbNqcffXKoKhsrQshVjb3
         ex6IdAA2y0I9VeIcy88IcO1ZjNjhvlSUvJB3eNqcRtFHyBLYkezCUYWusqVtEPQF5oxj
         bl/F3Y7/Trr0U74FFEeb96Fuk9bTrY53vuJOl/5p6j50IVlwO+tz8xDcRZEOkyr2tVR5
         uzzk49KEXNuGvmkTYV2Di/8pj5YOzYCCLvAMoKIo24dK+nN5//oP+e8LjMYxlG8uuPpO
         BLPQ==
X-Gm-Message-State: AOAM531qpoBAC86rAvREoMExzwyqKHTTBiJG9dRa4HX33TzyGyxlD+3a
        0tfgSOjzpmk8WL0O8POExdqKQDhke3t1ZZcwWl0=
X-Google-Smtp-Source: ABdhPJx1NfwleFcTxfWxFAiysMSCTHZoLytPJlIZhAVZFpLQob+c9Yfkd5HCRMqU0I4M13juZpZCFm9+SNyTaY3E4E0=
X-Received: by 2002:a25:4543:: with SMTP id s64mr24430101yba.346.1632691558433;
 Sun, 26 Sep 2021 14:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210924135530.1036564-1-maxime@cerno.tech> <20210924135530.1036564-3-maxime@cerno.tech>
In-Reply-To: <20210924135530.1036564-3-maxime@cerno.tech>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 26 Sep 2021 22:25:22 +0100
Message-ID: <CADVatmM7KEW6mGTHrfWt2mU4J79cJBjDH99rhefsz724gN7-Hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vc4: hdmi: Remove drm_encoder->crtc usage
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 2:55 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> The drm_encoder crtc pointer isn't really fit for an atomic driver,
> let's rely on the connector state instead.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
