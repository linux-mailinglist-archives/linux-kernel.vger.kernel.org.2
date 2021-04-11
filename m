Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7035B187
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 06:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhDKEeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 00:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKEeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 00:34:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF965C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:33:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f29so6832425pgm.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Fhx4bFoz4AMpMdIpkI4YdswXasRpyjIs7bwxZv1lokc=;
        b=naSRNKXl4+AVcsZ6V0ZzIrqr+ioCnJZtER7CZP6F5ddHLxFAFxbb6x/AeZyc8NaXhX
         O/+NKprUHBa98HXhjhjsyVe9xOSDDTEw/U3F4fXao3ObGki0df2ZbGHFCCb8iRE3CVe1
         K3FWwEy31KV7a0v/ZXz2JSkvMKZr/HTb9vu9bQz1/9nV6Ku0Qjr81B8xnprQ/tFAo/AO
         KXC0z+rEI41lOBi0kMM/Rl4Y6SOtbbfTOfnDK21R8t3F9ggYDQuEu5p7AgZ2brvFPp3L
         ZkR2xbsqI8+rqT60XJzBgklqcybOuwbhV4cDJYNSBA8Q71Bb+znxBmgT1H0W6K8Qtn7V
         ubxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Fhx4bFoz4AMpMdIpkI4YdswXasRpyjIs7bwxZv1lokc=;
        b=Bk2M1rZYWhGsh1Txl3eihUWPi+DCBfA/Iu1MU+m66UpLAFw9PJV/l0flzCLKljvEuq
         CPMWlASgCBkMd1KzNGGaBMTxn0AQX57UQdpftxbOrcdbwH2c4jFAvFW2i9w9ZMN7l/Ii
         lQMUJf761IkNAqfI0f8ZVJvSp/3l7w3zEOBR7n6Ps0FfClm59UtoStJNcHcofKNzzc2W
         ry+fDEcPPH4pFsS/NWQrRIu1rhXejxcDL5JCANlRTLG9lliOQtMq9xhG5ubejCd9Lw15
         MsJL94Ah6ucNyfpISmlLH20lQv6PbAkU9J3NQJ51EdoiV6mlVI4/4Zp4SmJ57+a8oYTO
         OKwA==
X-Gm-Message-State: AOAM531B4MxtwCSWJfHuGRHRlOFnij0nMZDwQluvnbZ+bSCFeDcPhAlk
        lQpNp5ivsHWaS49thzIUI1s=
X-Google-Smtp-Source: ABdhPJxd3xnYxhBFQMfSIVs0XvpyUtF+yS1cyow1AA1E1biddxprVFf4vqcLIsV29MfDawuQuVPWYg==
X-Received: by 2002:a63:d815:: with SMTP id b21mr20632938pgh.217.1618115628183;
        Sat, 10 Apr 2021 21:33:48 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id p22sm6570951pjg.39.2021.04.10.21.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 21:33:47 -0700 (PDT)
Date:   Sun, 11 Apr 2021 10:03:40 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 0/3] staging: rtl8192e: remove unnecessary parentheses
Message-ID: <cover.1618110617.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes style issues
Changes from v1:-
[Patch 1/3]:- Removed unnecessary parentheses around boolean expressions
[Patch 2/3]:- No changes
[Patch 3/3]:- No changes

Mitali Borkar (3):
  staging: rtl8192e: remove unnecessary parentheses
  staging: rtl8192e: remove unnecessary ftrace-like logging
  staging: rtl8192e: remove unncessary parentheses

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.30.2

