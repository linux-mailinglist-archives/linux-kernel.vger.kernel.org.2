Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8473134E311
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhC3IWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhC3IWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:22:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52620C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:22:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m12so22470977lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0qSy1MVbTFfSGRDPmoKRiOph5YqV5xL5GvGDM8LZE/k=;
        b=XYNxb8bjIXQEiworr1609zQd16eadlj0gAF1chjtfPOiFBme8JeFUlRcIXjDxyrfND
         gv5FZneuoNsUBwWM9uYiDWqOIqEvxX93EkVbTxGI79oRHhCcmPp2R7DzuiGS7RRw2V5q
         kbf31yl3dzceedNPgrLajMyF8AJG8gpI/N6FkabpZ+zNXCk68/cpEy5/0+X9yBYGXG4F
         eAKjXQqt7lK0JY0neJPFfoemD6jwy8m3nvEc75gqlh/OYQQD0Wte4WddyzgPZAnhmWPO
         1fk9lg6SaU/CmX42M9RP2IdDu+Fta7reSJwsxFu1oPSF3d81WaRx9FFWwtSWFxyfaJtM
         HcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0qSy1MVbTFfSGRDPmoKRiOph5YqV5xL5GvGDM8LZE/k=;
        b=Rt+Jolsr8ApqIAdhrENSKcBJXFW3N0ibQb8Vrf2Hck1HzyVMBq/csErx+Tk2uFQrj1
         FW/adU1PWCtS4nvEv8lEOTBLKTfW9M8x8V0hO0k/xsglVXPtiVi/bpJJkI5XQc8wHCvd
         FePUUaf+dU5YhLK1Fj0QIrGdlVbd9ge59ZebFH23Sb0qfGD6wlvDzz6RVIsHyaVb3nLb
         DK313i028hRNDik3enmWT488vG4DbOxwn4suSUWZYJffR6j2Ipxk5L5mP3e7DigVg0iU
         6QHNIq1L62kGs6cdjcLZzYDTqSCTT39J/vVDCzHaFZMG+eLtrc48qA5uonCeaC5ViWrC
         Uedg==
X-Gm-Message-State: AOAM530yZHXnQrXVl+va4wLCqNUU44u3r1xx6Xn/ljJXWA1gTeK5IE9p
        BbnMcOC5/kPTDKJwlcR7n8h7Lg==
X-Google-Smtp-Source: ABdhPJzIl4hLL8Krt5oiEyybF+iTwH8dmHrf/cbfUkYsI71XvGAAZYvLMPiz20B6oFT9GtQNOmFUTg==
X-Received: by 2002:a05:6512:304c:: with SMTP id b12mr1038631lfb.3.1617092530844;
        Tue, 30 Mar 2021 01:22:10 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id 192sm2701813ljj.95.2021.03.30.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:22:10 -0700 (PDT)
Date:   Tue, 30 Mar 2021 10:22:08 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [GIT PULL] OP-TEE tracepoints fix for v5.13
Message-ID: <20210330082208.GA965793@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

The previous pull request for OP-TEE tracepoints introduced a build
error when building whithout O=..., apparently many regression builds
uses that option.

Please pull this small fix for the build error.

Thanks,
Jens

The following changes since commit 0101947dbcc3204f08fb5b69a21dbd4b1535cad6:

  tee: optee: add invoke_fn tracepoints (2021-03-15 12:04:01 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-tracepoints-fix-for-v5.13

for you to fetch changes up to 7ccdcaace80810175bd20b2ece856b42edd43991:

  tee: optee: fix build error caused by recent optee tracepoints feature (2021-03-30 09:33:33 +0200)

----------------------------------------------------------------
Fixes build error for recently added OP-TEE tracepoints

----------------------------------------------------------------
Jisheng Zhang (1):
      tee: optee: fix build error caused by recent optee tracepoints feature

 drivers/tee/optee/Makefile | 3 +++
 1 file changed, 3 insertions(+)
