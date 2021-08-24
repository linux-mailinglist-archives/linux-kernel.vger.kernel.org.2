Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF03F6BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhHXWic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhHXWib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:38:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059BC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:37:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q3so10971110iot.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2KxnHa/5CXRSQusM6YnlNCt9dIjl+2phwzvOUDij4o=;
        b=Kv/F+w3zogYrf9JdN1LrLuzl5nxItyM8qeG/HMMw9o+i2vG9H2xfFJSQuIZNXsE87a
         8EiZC7wL/9jLYg0OOl/pglYwTsaCkvjnCVnsPiiHPC7D2Rl9mBCxTCz7k8xeHs8VH4Rd
         VYifVKaWpWMP0wxasf7327R0Jzs0rqN85faKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2KxnHa/5CXRSQusM6YnlNCt9dIjl+2phwzvOUDij4o=;
        b=TFmzBAIc4yRykxe1nOnrytkaszbdQkHL/IlsUOhUQM8ynhXzldxMPHDUXKjxjeFlEp
         FKHzxizNaURUMbjHC4rN+5IRXNpt/YIzfrd8UetldNapQobJlokSB1oiuOjaaFFs9rwu
         Mo1sTNuN14rsblPYig+aCmtfzRa/Tygp2zKLr0hJTybljGkRzNDjSgANPjesu3ksQShI
         Yr7WXjbECxBN3kvEXw+m9vU2GiPteNJqr0I8LvD9pWj/Mn34Z9pPaFemOtUd07SGG4mA
         L4YsRTvvPNQpD4KYpk2f2EygMKwiLDD7qfxeRxLyHZKGwmj8d2gXNRh4pt/Gr6EleBfP
         agnw==
X-Gm-Message-State: AOAM531XkUSmY4drQxcpJ06PaTXuksYq419p3/0VpH89RnYPU4zMlTa4
        dIR5KOrgJeXbBAyAojvEhqOe0woIq3XkUA==
X-Google-Smtp-Source: ABdhPJzbx3hPHxUtWTPODKZTSbR9gRZLygIzz7TDRv+6Hrbt/ecwpbpnQlPd0ziGxY9ZSJX9++rxEg==
X-Received: by 2002:a6b:6603:: with SMTP id a3mr34089427ioc.68.1629844666093;
        Tue, 24 Aug 2021 15:37:46 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id m13sm10177608ilh.43.2021.08.24.15.37.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 15:37:45 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id g9so28395476ioq.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:37:44 -0700 (PDT)
X-Received: by 2002:a5e:a813:: with SMTP id c19mr33362612ioa.199.1629844664506;
 Tue, 24 Aug 2021 15:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210820162201.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
In-Reply-To: <20210820162201.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Aug 2021 15:37:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W56FsUOzrRQ7Y5F4g7yBSXr-KJ45t32ghGSsNtFsNUMg@mail.gmail.com>
Message-ID: <CAD=FV=W56FsUOzrRQ7Y5F4g7yBSXr-KJ45t32ghGSsNtFsNUMg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Reorg the macros
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Philip Chen <philipchen@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 20, 2021 at 4:22 PM Philip Chen <philipchen@chromium.org> wrote:
>
> From: Philip Chen <philipchen@chromium.org>
>
> Reorg the macros as follows:
> (1) Group the registers on the same page together.
> (2) Group the register and its bit operation together while indenting
> the macros of the bit operation with one space.
>
> Also fix a misnomer for the number of mipi data lanes.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> Signed-off-by: Philip Chen <philipchen@google.com>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

This seems fine to me other than the slightly mixed up Signed-off-by
lines. I think that the git config from wherever you ran "git
send-email" had your @google.com address even if you authored the
patch with your @chomium.org address. Once that's fixed then I'm happy
to add my Reviewed-by and (unless someone objects) I'll plan to apply
this patch to drm-misc-next.

-Doug
