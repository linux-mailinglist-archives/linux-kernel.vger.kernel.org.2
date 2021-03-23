Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC42F345631
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCWDZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCWDYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:24:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9337CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:24:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o11so10316631pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=hodATnKjKQUhE5+cuWqoiqtEQY4BaJr2OLA8v0fcrQ8=;
        b=Woqg7ffdwtVJhO9A1EbkRO1TS2BL2uMiyp1MfJVdCzkz8sIi14UbpOpAuy/p096EHV
         EcT5UvJu5TK5fVulp0NKDEY6zuub54j1ramn1RYwTLOGlCPjDtRfYrltZ74OujqduN0K
         gdL+ccqLFZAJ4xRZrI5x4Fe0pdfXST1p1wS8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=hodATnKjKQUhE5+cuWqoiqtEQY4BaJr2OLA8v0fcrQ8=;
        b=H8csw7rRO51tYg1teZT5rLmFY0qWmtYEbhrOifs1yTU+Zn8jlP31ukAkm8pmRhtg0+
         eXokP/h8gGgpMbX+5cq1YaylDv2hzgAbat9RQCLcCkjB6uD61UpuYrvoSMsrAmnw2WbX
         x3vmpFeWlH8Pcakds6/+jmOZ9dW6l3AuGcTDovFxDV8rl+gzK5x1KuvGJVffkguQHLWP
         VBnb1tW1qpv5W+CyR1w8OYzaImeBNe9qvWHUr0AZosBhW3F+8L9dTzCsJjDyzPqeHK4Y
         wj/SvHgTFzgnRw06CguhCBv/INZLUIiKsRl+Uw06rfF8ooAOmaPIgF9Mj0kiwyOoL51n
         S7bA==
X-Gm-Message-State: AOAM532EyBn+L2HfSrUKoTIhKhqOuvZDPkYndiI7cUtDrJJZc36RxnmY
        GZnCAi75KqgnITcIZkTT6KFwsg==
X-Google-Smtp-Source: ABdhPJwQuMfvnRVwix8vZq60PYLbsuTsaoSc+9YR/JehIv2GN8pbSU2ylDpgKbh2R38rU+4g5c9xSA==
X-Received: by 2002:a17:902:d694:b029:e6:bc94:4931 with SMTP id v20-20020a170902d694b02900e6bc944931mr3157077ply.6.1616469884216;
        Mon, 22 Mar 2021 20:24:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e90d:d453:87ae:2e10])
        by smtp.gmail.com with ESMTPSA id l19sm735913pjt.16.2021.03.22.20.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 20:24:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210318062650.19886-1-unixbhaskar@gmail.com>
References: <20210318062650.19886-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Fixed couple of typos
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rdunlap@infradead.org
To:     airlied@linux.ie, chandanu@codeaurora.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        khsieh@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        tanmay@codeaurora.org, unixbhaskar@gmail.com
Date:   Mon, 22 Mar 2021 20:24:42 -0700
Message-ID: <161646988202.3012082.5548408805057433167@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bhaskar Chowdhury (2021-03-17 23:26:50)
> s/modueles/modules/ ....two different places
>=20
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
