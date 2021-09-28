Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB041A416
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhI1ASZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbhI1ASZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:18:25 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:16:46 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p80so25031224iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5dEdhTiuiXUcKyE8+qu27KWg9nkXOmkfc3S6tONh9w=;
        b=eV1eZYpgLdAFLMSBnQumKi/NMNPzCruD5J7NcP4BHYyTIn+LWVnWO0xiT3PxB+26Ss
         zbF+nMv39DFBxk93ke10knTVmSoUanCgN2HbO8LN8QuKskolr2kP+uBdo6Nt+wiQa17m
         7HSqYbZAlgk1TyuIsMvPDN9pbxmto1TS6bB3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5dEdhTiuiXUcKyE8+qu27KWg9nkXOmkfc3S6tONh9w=;
        b=tW/wkLGOWWGkwK7chuun/rj7CD9FxF+cxpYPPDSlaVnIDpcah/7sqxfgah09MuHyXN
         Q/n6qPW4XCVSJPdAIxVexGOo3SlVwkFK5ET+TAVB0cDjZTnK6wWr+BBFwc7DBHEZkU5U
         GSE+nJmKvPcjqdt+E6nswqPVhknsKCXpWxwiSGWt5Ea8wb8VAGBfG7JBMbDyvY5clJSc
         lSm4coOVYVHttXRuJWbZh9FI/UN1MphS5FauE4wPGvzN5/eqbnNCqK/8R9aEKUGJShly
         uHTpuivjy2P5aWhkypWxFmI+d+zGMpe3w0B93pE74fV5kbwc7XLEKZFSiXZC8F5wqZsl
         809w==
X-Gm-Message-State: AOAM532ctYfBkUSWr79kbAc9tTFzV0Pid4levNaMTPItLf7irHP6yQzf
        KXhQSlvG0vgVvNOp0YAVJ18UqIv1o2sFYw==
X-Google-Smtp-Source: ABdhPJwm9g1ylNkmAAvgFmYM1SMBmBPeJGGoxzvNyWVJjLMwbpL8yppkdrdKPDdLoHu+AaiTqe3f3g==
X-Received: by 2002:a02:1081:: with SMTP id 123mr2038977jay.83.1632788205975;
        Mon, 27 Sep 2021 17:16:45 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id o3sm6244780iou.11.2021.09.27.17.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 17:16:45 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id b6so21387762ilv.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:16:45 -0700 (PDT)
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr2160620ilv.180.1632788204948;
 Mon, 27 Sep 2021 17:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210927074104.1.Ibf22f2a0b75287a5d636c0570c11498648bf61c6@changeid>
In-Reply-To: <20210927074104.1.Ibf22f2a0b75287a5d636c0570c11498648bf61c6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Sep 2021 17:16:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrAk087-ft3c5kYAkWSUGyrXGqT2YnyrDa9XmSDupiLQ@mail.gmail.com>
Message-ID: <CAD=FV=XrAk087-ft3c5kYAkWSUGyrXGqT2YnyrDa9XmSDupiLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Fix drm_edid_encode_panel_id() kerneldoc warning
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 27, 2021 at 7:41 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Due to a simple typo (apparently I can't count. It goes 0, 1, 2 and
> not 0, 2, 3) we were getting a kernel doc warning that looked like
> this:
>
> include/drm/drm_edid.h:530: warning:
>   Function parameter or member 'vend_chr_1' not described in 'drm_edid_encode_panel_id'
> include/drm/drm_edid.h:530: warning:
>   Excess function parameter 'vend_chr_3' description in 'drm_edid_encode_panel_id'
>
> Fix it.
>
> Fixes: 7d1be0a09fa6 ("drm/edid: Fix EDID quirk compile error on older compilers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  include/drm/drm_edid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed with Randy's Ack to drm-misc-next:

116e5947d7bf drm/edid: Fix drm_edid_encode_panel_id() kerneldoc warning
