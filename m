Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BB83F4DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhHWPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhHWPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:42:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ABDC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 08:42:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso18875195pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wba/Vd7Mr+gKjN+T6LlO1n9InijBDgXzejrbqJFDnsY=;
        b=VcdGY4x1yOJjbob50PA33J2QzUqQB1sc/JpAszkZplYAd1QSNGrENkm+Jh8ndk58O6
         6HPHsG1qZJnvXcfGRZ5TEueMo9Jrz5lOKQ/ltzJP4vlsUHX96829cRdCpW/O6uS1uWXA
         YEKxToiBgtOPbny5BT6cUU7xtrrHsG99UywVb5UFNYDq71gj8F3NinPZSa209f+mHZZl
         OuELy/qxkl1uXh/sQbo83yRoBpgmQ5U5uEsyWCG49okd4bG9C6ZLYeXhjsWE7tv/jv7p
         guhdsEG4Am7skl0x8EWOTyxSt+Ve/aozCazygrnIJxgcrzgZk1/+yCVxNdGeuHB452am
         WVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wba/Vd7Mr+gKjN+T6LlO1n9InijBDgXzejrbqJFDnsY=;
        b=LVFK552nEO3zzrSKgZUjTEG9h39jt/2pdwoW/zqT4FR8jQa0dItOMRbmZS20r6FQw0
         R2OzTUfIfb9W4FY8s9/OEdstXWWi4dkA3FY7WtzYGtmKYvxpjoOjpVLKlNNmoFpRbxMH
         lKDgb0NPBbzOYy9ZMn6ZqZfTjovg5PIGjG67DCeK/yhgqx8BHOgPPB4Z2MQPpP2SbtzY
         UPDouhncaIDAaoDz37PDH89UiKIf29Q8Jh3SNOFAAwqQeYizMdHOPuG6BxAEjZWTzWmm
         3hMfd3YrxIRJZu5GLCCLMlOwke0nrFdJ+atxyAzuJzziofuTHPrb6MrYx91LKXvQyw9g
         Kftw==
X-Gm-Message-State: AOAM531rP1lP9AvgS7xV6PR26wX+7PHOmAW+R2dwjthOE4kVK3ARQb6l
        NooCHT3mXI4dmIb7b04s9at5Zg==
X-Google-Smtp-Source: ABdhPJxvJV/9sUu0fkCkTpOEHKfq67WatqlTsHOLVBCZsRX95rrTO58yIEVFPdqmqxts7j0+sawrOA==
X-Received: by 2002:a17:90a:f2d2:: with SMTP id gt18mr19064612pjb.187.1629733330679;
        Mon, 23 Aug 2021 08:42:10 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:bc5a:af6a:3f08:a084])
        by smtp.gmail.com with ESMTPSA id x2sm19608025pjq.35.2021.08.23.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 08:42:10 -0700 (PDT)
Date:   Mon, 23 Aug 2021 23:42:07 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: sound/soc/codecs/rt1015.c:724:2: warning: Value stored to
 'bclk_ms' is never read [clang-analyzer-deadcode.DeadStores]
Message-ID: <YSPBz0CzuAvVcHJy@google.com>
References: <202108231809.NOi9qOEj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108231809.NOi9qOEj-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 06:39:13PM +0800, kernel test robot wrote:
> >> sound/soc/codecs/rt1015.c:724:2: warning: Value stored to 'bclk_ms' is never read [clang-analyzer-deadcode.DeadStores]
>            bclk_ms = frame_size > 32;
>            ^         ~~~~~~~~~~~~~~~
>    sound/soc/codecs/rt1015.c:724:2: note: Value stored to 'bclk_ms' is never read
>            bclk_ms = frame_size > 32;
>            ^         ~~~~~~~~~~~~~~~
Proposed a fix (https://patchwork.kernel.org/project/alsa-devel/list/?series=535979) for the warning.
