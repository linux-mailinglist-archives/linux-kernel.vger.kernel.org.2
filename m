Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA88322579
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhBWFkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBWFj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:39:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96724C061786;
        Mon, 22 Feb 2021 21:39:18 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o22so1066961pjs.1;
        Mon, 22 Feb 2021 21:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+pgIkSmPacT7tK3z5RxW7X3unjBRZp2VB0qS+al2HOM=;
        b=txsM6ooGATBYuUkcmB84RsR3aIvzJGA7xLVJ7Jb6IeiNKTf/Z64J0hkpUSbGQy5hVi
         FdJ/JUSzeOI0HZsGreiO5tyqu5M+JupA+H7kYqvI6Z37ITAMKzTym83f6tXZtr0hgkdt
         +zYOVqSOLabsw7v0G1l9FoPanrYrDXBv3A4mrsOrgtfSF4zCnrgCjG0nBkljpNoz6Mpy
         zGS8BX4elEkCtXMj68hANRnlpma8j6XJ2zKwaZz+nv8zigC3bv8l4GFIFUSmzO4FRjvD
         QDBvGLTMXcE2F8xu6FJw8MQF2jqANwM+mMRf7CCuqpmufVkQHP38qFa6QG6d1EA3gtW/
         DhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pgIkSmPacT7tK3z5RxW7X3unjBRZp2VB0qS+al2HOM=;
        b=g19IQ6dPgEpY5/WPK81tBrKLMK0yQPUvaV4aYQ4mWSlfFSqaRGufo7RHxUedQqj2e+
         fKf6b5qsQMYhhnggoBS6ffS4FME+VeewjTcytHLYHCkNiHdSzdutb9dza269dpbirb7F
         ab4OBOaaSsTI5np26IlAu5/TlFx+uPb4gT1zt0y8MXoMxR9TqSO7FkR9BPARtFgyp+BO
         rENzSgIfBsZN5k3aWUVljU17b4q3KX/b+TcaXmBDkmzourM9NH4bVntwn3iMptCqGv1i
         khLktzsmA8YafA5gYiKnoH216zoEqBrJ3yd5HkJNWCeokC3plHdz0WWdvNtDS8qF75NA
         z71Q==
X-Gm-Message-State: AOAM532ldg3Rl5NXhoASCOSCssCXXWnUgvLCU084DTnrvd5BMB830tjl
        NGopq1PoNtUXrIWvojSwaYc=
X-Google-Smtp-Source: ABdhPJzlHIAGpaApCk7rh696nPwc1bFmhqCMXAm9kZle3hCKn9IpsO+gTy/dIXQToi0wy45HJrOFVA==
X-Received: by 2002:a17:90a:7e08:: with SMTP id i8mr26745711pjl.225.1614058757993;
        Mon, 22 Feb 2021 21:39:17 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc19:4f46:855:edfc])
        by smtp.gmail.com with ESMTPSA id 14sm21224346pfy.55.2021.02.22.21.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 21:39:17 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:39:14 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, swboyd@chromium.org,
        dianders@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: input: Create macros for cros-ec
 keymap
Message-ID: <YDSVAt9vxL5fYKhH@google.com>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 02:36:15PM -0800, Philip Chen wrote:
> In Chrome OS, the keyboard matrix can be split to two groups:
> 
> The keymap for the top row keys can be customized based on OEM
> preference, while the keymap for the other keys is generic/fixed
> across boards.
> 
> This patch creates marcos for the keymaps of these two groups, making
> it easier to reuse the generic portion of keymap when we override the
> keymap in the board-specific dts for custom top row design.
> 
> Signed-off-by: Philip Chen <philipchen@chromium.org>

Applied, thank you.

-- 
Dmitry
