Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76519445BCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 22:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhKDVsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 17:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhKDVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:48:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:45:21 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so9470700plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JWx9ct2MbjImA6H/WvO058+827HmSCDeJJGYWZ5NWKI=;
        b=B0nLjg/Un1RR8JO88l4pjO/r40QMXp2NKWLOT8gleROTy83KBOS+lF4w9BC+N5Ioq0
         M8bgTpM76+k0f6GHJDCplbtrZ8g8sQxnoKAkzpFVhEiz4SpSE8yvyy+bPNe9HOBo3xzV
         /Wz2WuZ1KL/kBkyWJd7mLDWnE9FE4GQyRtI4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JWx9ct2MbjImA6H/WvO058+827HmSCDeJJGYWZ5NWKI=;
        b=P4A8vnKedMgwkQUr7oCazUvmoXhVDvinucfQ658aa4hFsCK0zafEYM+7EQuCB3Fxaj
         Gtd7z91qY10ik8NdTgL+EqdaIjsW6LLZg/K8/jp9cGI3Db8Zm3cY1LbT0PN0vr377iuM
         Wy8QZ5x2PzMwJcu51rB0uGpGy/D0AcQtW6eV0tpQB8SVqIiSVFTwevlMOa9+ubaCc5pY
         7rgtyD9uKsYF7JC2CS3SyNp9IfumnbrxVFzliEpxIiXQc9w3/N8t6ZLqZ6YbvHsPUf5y
         Cui42lysYYqXq1RcooohyjpUD8s/QbRSs8oemLAMzrEm3iqiXva2SsK+rAirFvJvN6Qj
         g4eQ==
X-Gm-Message-State: AOAM531VMOOvVVEi3MHJp7K2OUQZbkZZW6AG8Lw3NzvrkcxZ1jqY+SyP
        1wYZ+XYUzOwtnreu4wX/8xTc8w==
X-Google-Smtp-Source: ABdhPJxqHMDw5YqGMlZwg7dpWo0+rcl7UStC/9wzlqsDbweCwI/3ZPYSoXpZo8EXmcankBbq9Sl1aA==
X-Received: by 2002:a17:90b:1c06:: with SMTP id oc6mr24886431pjb.126.1636062321332;
        Thu, 04 Nov 2021 14:45:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:49a7:f0ba:24b0:bc39])
        by smtp.gmail.com with ESMTPSA id e7sm4473408pgk.90.2021.11.04.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 14:45:20 -0700 (PDT)
Date:   Thu, 4 Nov 2021 14:45:18 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kbuild-all@lists.01.org, Andrzej Hajda <andrzej.hajda@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        linux-rockchip@lists.infradead.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>
Subject: Re: [PATCH 1/2] drm/input_helper: Add new input-handling helper
Message-ID: <YYRUbhWH1MlDvSsR@google.com>
References: <20211103164002.1.I09b516eff75ead160a6582dd557e7e7e900c9e8e@changeid>
 <202111041849.GKXf3qid-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111041849.GKXf3qid-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 06:47:34PM +0800, kernel test robot wrote:
> Hi Brian,

Hi robot!

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I'm not sure how to do that in a v2 patch -- one doesn't normally credit
"Reported-by" for every testing/review improvement on an in-development
patch series.

> All errors (new ones prefixed by >>):
> 
>    or1k-linux-ld: drivers/gpu/drm/drm_input_helper.o: in function `drm_input_disconnect':
> >> drm_input_helper.c:(.text+0x48): undefined reference to `input_close_device'

I've cooked a local change to separate the CONFIG_INPUT dependencies
under another Kconfig symbol which optionally builds this stuff into the
drm helper module, only when CONFIG_INPUT is present. That should fix
the build issues while still leaving DRM_KMS_HELPER workable with or
without CONFIG_INPUT.

I'll wait to see if there's any other feedback before spinning though.

Brian
