Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDE36141D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhDOV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhDOV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:28:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 14:27:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso13436117pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=drWG6gLa1ZmG69Bf/dCzVYRHQhXRC+T+Z0hEFI6MLLg=;
        b=Xyyk4OOugjuSzuE53yCAJdQpci5TujpnnDgW2gWttrTDCCEge4wnyXXJDObYPi5QMk
         7dC67O1Gij9bZhhvrseh/zQb5fAq9KaIVzoNYAA4zAkeh8lGXILOPECPpN0eHEkJco0K
         dK4DS3t0NyphXwf4zvqQN5zlmUhBpfYfSUvv5HEl7K9xNe99521KfNj4VxblmFWMcEhl
         FyYYGSaDS14117+P5+HHXM2owtyYjajbC8OSx+/n0GOm79P6LeqjvO2bpT+qLEAkwnOs
         6jVA6DD7vWTzyYUEPE2m0YVrMUE43uugwY2es0Xl8fPBQr4QjDntJOuDx5OKLL0SrIq7
         SqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=drWG6gLa1ZmG69Bf/dCzVYRHQhXRC+T+Z0hEFI6MLLg=;
        b=L5Y5n5S4eA5MCpXNh3p11WmsKdN2icjLAHuxtnQiLmQcXtxCQsTcsCcE2KlTH+qrsQ
         IA6sS8i5jGuzq2CoLM6PIBwPWIR7IzLBV+h54AkhbToCiWRxYrYtORnIjWJjeM/nJ2/m
         GjaU4/U4qUPjqkmamyPjNFyFnd+UCWmdOORgWD2I31SoIBb5x8HE4PUrBvNXclmx91ro
         0b23XDJxLqKS3EApi9hT4iI8WdP1p53emEi53H7PvFAePAg6Uh0AT8s7SJVcs2GbuH+V
         jy8xN5viTE6w/GQKLtDr6UjzMDs2qwaZv0Gs03d14YDJKTIjExrMpav+IBjl/q9pgeTY
         7w0g==
X-Gm-Message-State: AOAM532FHOI7c4JD8b3qmm9XWu1KR2DJ70g+Kc3KJWAHashijFbjnzHr
        oNiLS3WKePYF0JAdujYwhyHZWw==
X-Google-Smtp-Source: ABdhPJyAEcufAnyndGeTLg0yNjYeNOmRJY8VMmP8IoNCy6iQ6tyNjoJ99RHGQvDTl5FPZ3rAyJ/dNg==
X-Received: by 2002:a17:902:d488:b029:e9:9ecb:19f0 with SMTP id c8-20020a170902d488b02900e99ecb19f0mr5904843plg.26.1618522076888;
        Thu, 15 Apr 2021 14:27:56 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t3sm2927761pfg.176.2021.04.15.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:27:56 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:27:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] CoreSight configuration management; ETM strobing
Message-ID: <20210415212754.GF937505@xps15>
References: <20210414191903.18349-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414191903.18349-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> 
> Mike Leach (10):
>   coresight: syscfg: Initial coresight system configuration
>   coresight: syscfg: Add registration and feature loading for cs devices
>   coresight: config: Add configuration and feature generic functions
>   coresight: etm-perf: update to handle configuration selection
>   coresight: syscfg: Add API to activate and enable configurations
>   coresight: etm-perf: Update to activate selected configuration
>   coresight: etm4x: Add complex configuration handlers to etmv4
>   coresight: config: Add preloaded configurations
>   coresight: syscfg: Add initial configfs support
>   Documentation: coresight: Add documentation for CoreSight config
> 
>  .../trace/coresight/coresight-config.rst      | 244 ++++++
>  Documentation/trace/coresight/coresight.rst   |  16 +
>  drivers/hwtracing/coresight/Makefile          |   7 +-
>  .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
>  .../coresight/coresight-cfg-preload.c         |  31 +
>  .../coresight/coresight-cfg-preload.h         |  13 +
>  .../hwtracing/coresight/coresight-config.c    | 275 ++++++
>  .../hwtracing/coresight/coresight-config.h    | 253 ++++++
>  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
>  .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
>  .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
>  .../coresight/coresight-etm4x-core.c          |  38 +-
>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
>  .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
>  .../coresight/coresight-syscfg-configfs.h     |  45 +
>  .../hwtracing/coresight/coresight-syscfg.c    | 804 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
>  include/linux/coresight.h                     |   7 +
>  20 files changed, 2716 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/trace/coresight/coresight-config.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-config.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-config.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> 

I have added this set to next-ETE-TRBE where it will be rebased to v5.13-rc1
when it comes out.

Thanks,
Mathieu

> -- 
> 2.17.1
> 
