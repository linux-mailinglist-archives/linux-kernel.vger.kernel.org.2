Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA335EB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbhDNClh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbhDNCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:41:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:41:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so1839947plz.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=IWQ8kZIVlGhQD8+fDUl3Qr87vRGoEpJEhZ9a36cdmds=;
        b=GhUjZ2ZzTjpi1biirHOduFNr3NQBYkkJ5xRA/5xxo7UwrTjpe5gMi42KF/VcAgf9rB
         sucr6zJ0RA7Zb6zUP40T0031wV3wN2+mdQS9op63T/qR/NUQDJNAGnN/xi1AAXdsYlBO
         G62pKW/wz39ztJxtonQWrGCIbwKywdy2TXntM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=IWQ8kZIVlGhQD8+fDUl3Qr87vRGoEpJEhZ9a36cdmds=;
        b=IXNJOdOrXlKi/iQtqY/ScGN5Q4+lsiL8YeBrKOK/Wce2OoBG53ltnQslwGTZ3x2wW8
         isG60eFa7zOZKY6qrJvIYZnNmhZ04rFNUK73kA1CEXGzx0R6mhD9b8UI3z2Ci8WmCF+c
         c9mvhrMdgCazkEzlhJXIlTD3UckSW1Kqvpsz9r89gMUn/8nAtv/rq0JmnZJcpyKusOIs
         PK9KqkrE1mH4nKFEyBxPUz2Om8PZFzfoXO1cpm6dgH4NZ1FzGnB5rW6x1h4EKOY7e1aK
         Xqw5iSxFxZ2JtbrIqUREzqXg1M9CitROev3bldr1XyZd24nCWNcji5ET41ZN65UdKVL8
         l1aw==
X-Gm-Message-State: AOAM532pQGllFbB1FB452tDrO5qMQc4asffHNy9lP+zXg1hh4AzjzKNM
        WHOKXmSRAO0tmNdtv8+vG6+dHA==
X-Google-Smtp-Source: ABdhPJyWXs4uv20lp9C9gM9mn6ADAno63aDcQTRqZNWrgUoUHGkLTKU1PClRdBDVvX1u664CF+3CWw==
X-Received: by 2002:a17:90b:33c7:: with SMTP id lk7mr951786pjb.95.1618368067895;
        Tue, 13 Apr 2021 19:41:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:1d18:a339:7993:e548])
        by smtp.gmail.com with ESMTPSA id x125sm13272511pfd.124.2021.04.13.19.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 19:41:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618355470-5226-1-git-send-email-khsieh@codeaurora.org>
References: <1618355470-5226-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH v2 1/3] drm/msm/dp: check sink_count before update is_connected status
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Tue, 13 Apr 2021 19:41:05 -0700
Message-ID: <161836806593.3764895.3487656287937752851@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-13 16:11:10)
> Link status is different from display connected status in the case
> of something like an Apple dongle where the type-c plug can be
> connected, and therefore the link is connected, but no sink is
> connected until an HDMI cable is plugged into the dongle.
> The sink_count of DPCD of dongle will increase to 1 once an HDMI
> cable is plugged into the dongle so that display connected status
> will become true. This checking also apply at pm_resume.
>=20
> Fixes: 94e58e2d06e3 ("drm/msm/dp: reset dp controller only at boot up and=
 pm_resume")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
