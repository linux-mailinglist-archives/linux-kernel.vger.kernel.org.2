Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904B74002CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349843AbhICQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbhICQCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:02:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA825C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:01:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r26so7449720oij.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wIHakb/z40TgqCfkHWLx/iuOyOfFKwa+3WLrhG1oD2E=;
        b=TsRG8XqUXx38KRnvI9ZaECpk+MPUHrCrj9ZRco2d+NGsLn8kFexyN45+x1ZLIsiU5R
         VaEJX8h3pwPtb3V/HcLUWaO3LI4G6r5KukkY/LH4Trqsc3EZ7NeGAH1TXRZD5NAxpysL
         mUX98u8PR9xYR8OhBa3S6QzzSTNLdNzDy5o/WCRXZV23KmirdXxX1Lr9NxW9kH1YhWQ8
         ETTZkAGRcSdAcHJkcLE0b1udxZ5iBhRVMAAwexOc9hr4dvaYVL2OW/sJ04mpip4wcEni
         SJ7954XSzumr5f/L6v4VULslu3+FX4dvAFhTfJNiOXTciyAizsBaBADItXhnp1Ax8i4J
         oa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wIHakb/z40TgqCfkHWLx/iuOyOfFKwa+3WLrhG1oD2E=;
        b=I5l2AdHCmt0LU8SpJyEcOUmFch8/mFxDsgqLOFLxQfvk2AGv67gDrDMcLdVmTxBLYs
         3zaBhKOEKARLOVp9DzSC74iTk0BfG+ak9la1j93DocMFcGbvU09km04eHYZZU/DwdrFX
         GowxOAab2jxTa9ErMfGGWoPUUBrvDfnPKjgr13VNEsH20CcPAkY5iMtz8XBizoosWFq0
         vkEiRShLJ64XruXpyRPzdLXF9lhudGyubPc0TX4KjM0dNVXH96qzxV3M5igdQOj9EgxR
         Ap7Sg8Obnge4IlPgc85h3wGYorcT1OkG4asRUnUQI8zvQDFlPP+1yfprYOX42NE8tMA1
         8AyQ==
X-Gm-Message-State: AOAM533As3y2beiuxwGkNTmd59SBClCkehXBSVIpe5x10oF8L8/5M9B2
        lZngSIyw+05mtSpJdd/SpDUZoEV5H1U=
X-Google-Smtp-Source: ABdhPJzIFshziCTTcwCU4XgYa58iYhwOaHI1E37K/sBIn69ICVi67+NII0TNttKhEfU8TTOYL+lZnQ==
X-Received: by 2002:aca:31c1:: with SMTP id x184mr6602066oix.8.1630684885152;
        Fri, 03 Sep 2021 09:01:25 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id a11sm1087397oiw.36.2021.09.03.09.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 09:01:24 -0700 (PDT)
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: False positive EXPORT_SYMBOL warning with NS variants
Message-ID: <d63da2a8-1624-21a8-f8ca-f7477c20e56b@gmail.com>
Date:   Fri, 3 Sep 2021 11:01:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ cat foo.c
// SPDX-License-Identifier: GPL-2.0-only
void (*foo)(void);
EXPORT_SYMBOL_NS(foo, FOO);

$ scripts/checkpatch.pl -f foo.c
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#3: FILE: foo.c:3:
+EXPORT_SYMBOL_NS(foo, FOO);

The non-NS EXPORT_SYMBOL variants don't trigger this warning.

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
