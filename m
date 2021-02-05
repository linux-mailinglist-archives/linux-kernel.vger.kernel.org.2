Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4AD3111ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhBESZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhBESYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:24:06 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D738C061788
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:05:50 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j4so4072027qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COIVkmLKVjBxWkNd3sXcovxZhEaGvx0vE0V8HNc6fkw=;
        b=MMKKfiqqZSmiiR7dwaMA2hEB2+eyZZcoiYb3co6cQsig958i/s3kiTTfJiJPvrubBJ
         dL2+N+3u2ZNmix9XN59xN8Csy7IB19VuE7dsvIPZxS9ukugAjRDvjyCD+fdo8E1GawAh
         Hkw/+vpjf7E8vxb00zu2JEB/BUmtEo+ydwXek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COIVkmLKVjBxWkNd3sXcovxZhEaGvx0vE0V8HNc6fkw=;
        b=tOnDuDNTT2oXu76csxCX1j7XUHbdNujsJapMBRHmSofMIFN1ALs/khqi9GZ3Jyhbiz
         rPhAO7Nui3Wk1ZUyM88yeR1lM2iQIMGwU9+dfY3mPkj9KmOvu46X67TauE3l1P5aBK0t
         BlUegnMLdDg7lvZuFDY25C9ZVKvBL8irUI6hrzHnLR57GRF5IPLkkHMilsWHbkg3v6vl
         4Ssqwp/0UQz8jEeD5x85C4DivSUFkd+j7P00PICxooO/f3VPItO5xDlfvL95G8z+fTGa
         mBZMEslDsTeY3W/sWfsFrzitk+13AAmihQaElh14SugVRaKSXknwQj7Lg+aHuN+I5XIU
         6xyQ==
X-Gm-Message-State: AOAM5317ERjBaJzcjEylPgYpYj1RNVcAOpXD00oVMqEIN1ckz6aYH/Zt
        m0IrMXiup4IuclgwbGk7Pek+8ZP/lW5ZOOZUOplerg==
X-Google-Smtp-Source: ABdhPJw9P4aHZiurZFpu2ywUm+vHxcCvBFwQC5Uv94xO+vrAOs73MGnhBXE4PYG6PuvNBCPFmecYPswJ0c8cTH96/UI=
X-Received: by 2002:a05:6214:18f0:: with SMTP id ep16mr5984767qvb.0.1612555549642;
 Fri, 05 Feb 2021 12:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20210205195113.20277-1-rajmohan.mani@intel.com> <20210205195113.20277-3-rajmohan.mani@intel.com>
In-Reply-To: <20210205195113.20277-3-rajmohan.mani@intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 5 Feb 2021 12:05:38 -0800
Message-ID: <CACeCKafY=mFBC-6VKsnOgZc6f0Y_FraQrdRnbKQ-k448OgExDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_types: Support disconnect
 events without partners
To:     Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raj,

On Fri, Feb 5, 2021 at 11:52 AM Rajmohan Mani <rajmohan.mani@intel.com> wrote:
>
> There are certain scenarios, where a disconnect event might
> occur on a Type-C port with no port partners. This is required
> to enable communication to Burnside Bridge USB4 retimers.
>
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
minor commit message nit (apologies for not spotting this earlier):

This patch alone doesn't add support for the "without partners" part
(that comes in the next patch).
This one purely adds support for disconnect events. So might be good
to update the commit message if possible.
But otherwise LGTM, so:

Reviewed-by: Prashant Malani <pmalani@chromium.org>
