Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553E41677C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbhIWVbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243306AbhIWVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:31:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:29:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 81so4124921pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akDNRAsaTK+uQtKFIh1ydvOrMyhhLnx/OM5ln2Z5MNk=;
        b=G2zaNqchvtAWfw4Jj4sXEQH3Rxruj59sBcBHK26bUenW3LAHOm12rDMlvkvu/2+FcZ
         G6xVVmrEGQskoPPkhckLcf3G2+8mL1TXBchadNnRGz8TN0Fj7xOrO4aOP7b78n4g+Naf
         Hda0lx7r1brORiS5MkWU4K2OKdGe1Z5QABtAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akDNRAsaTK+uQtKFIh1ydvOrMyhhLnx/OM5ln2Z5MNk=;
        b=OxzVCcK4Ik/QyMnJy/EaGV3t3iKOIYCUsa9W8ztdOKPpPXwPVUqxKJnOj51kUjOFO8
         vBiIpk3JF1H1Lq1ZOLwfuki0L41gIn7sMyU8jVi3/v29B7t8MnLJVDfDRYoiwKlGJ6LB
         xljAkxQBV2P6a8XfjRUmMMiEOahM6lQy+VTqXg+mwu0KdwrWPTQyjKs/n31vod7S5aQJ
         QQ84ofMp/ILKXPM5tgEY0ViSNBZy9srIQRoYIrbOrR28hQC/aOnCio7nFnMZV+V0vPdt
         q2eqT+HoKPao7BIKkZEhn9Mm9Od59MKbYDbLYR0utiA+W19DoiNcxNbx0FgsOXa8nADh
         uvrQ==
X-Gm-Message-State: AOAM530aFV0i1XIE+GtWTNJf8alvQ2ISpYZZq+FXLrWZmseINBjIfv7n
        97Gj3PP5QT+ZZcPTMavSLXhAQw==
X-Google-Smtp-Source: ABdhPJxmeWGw+d3e+reNftFm9QVIN4uPJYjxAGxk/3gd+aiz8C78IF30myFtnICwLuQ1yF0ekbVCbw==
X-Received: by 2002:aa7:9e0f:0:b0:445:636b:3305 with SMTP id y15-20020aa79e0f000000b00445636b3305mr6442000pfq.38.1632432580235;
        Thu, 23 Sep 2021 14:29:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a4sm6422046pjd.48.2021.09.23.14.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:29:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ross Burton <ross.burton@arm.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
Date:   Thu, 23 Sep 2021 14:28:49 -0700
Message-Id: <163243252379.3933826.2645114887075876479.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210923152811.406516-1-ross.burton@arm.com>
References: <20210923152811.406516-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 16:28:11 +0100, Ross Burton wrote:
> The GCC plugins are built using HOSTCC, but the path to the GCC plugins
> headers is obtained using CC.  This can lead to interesting failures if
> the host compiler and cross compiler are different versions, and the
> host compiler uses the cross headers.

(I changed this from HOSTCC to HOSTCXX to match the other invocations.)

Applied to for-next/gcc-plugins, thanks!

[1/1] scripts/gcc-plugins: consistently use HOSTCC
      https://git.kernel.org/kees/c/ef5ecb129791

-- 
Kees Cook

