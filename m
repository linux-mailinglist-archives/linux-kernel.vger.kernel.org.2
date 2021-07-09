Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE90A3C1F11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 07:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhGIFvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 01:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhGIFvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 01:51:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08173C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 22:48:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k32so2334723wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Iyq852OltEvdUGf0H79zDdEd3RNqdT+BPIXNrQsQcJE=;
        b=OCf1/gmiC5mm+ykJ0bqekK7x1uk9xDi/yheM4KjzlDXGSsllU4smWatzFPbxicxoob
         UzTq8URIzBygb663u+Qz+acrU1p8lDc8H41V4dPdJWsU7oBmwrPVShcH+IiGtcL+/QZG
         1S8DExNGazfbUNOK/Ho+eGtSqkujTyyw4rK3B3QIHduuv2B/7y/63uWLnyVVBrjZpf05
         OcKSQuOY9zDG0i0X0nuCwWxMWiBio+520fE4lz/5uIYuHuHbhjGzRDhUwak0HGRhtj53
         XA+GfmNorztT0upctwXTudzfvx9VTp9eRo5roPvE16N2JkYu6zYLoS+ATFO+e/m/unPz
         Csqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Iyq852OltEvdUGf0H79zDdEd3RNqdT+BPIXNrQsQcJE=;
        b=ghjR6JH05Ww0x4X0BBJlm8vIrlXkEDHTRP4BShOQRpfO9ox5Yk41PyhZ+BM0xQfoTq
         rvND76ypWCB0cwNfo1A/J0JDL8Kj2Ac0AY3CSBtuLjpEJLC1Zg+wT7rcMQ92G7V4r74x
         p1hvp0FD/DpuouScyXzFaTAej60m/YY0eKwYJJq7eEZdkHpNpd6iIFN/8Jk0hCLDcEDo
         FiFr/Qvq0RsZ8uVEtsO2S/atERZiEf7L1Lgg9GZkO4BfF3DP269RUebL0UJz68r6I/BE
         AS7uE+Mx1cFRtw0LRtnkZiqcJuYwIQ8HMuFookiywdlBDhiv/wFmzvWbSzZ4wXg0zWId
         V6SA==
X-Gm-Message-State: AOAM532k5YBeAS9bx76T7r9pfgOARvbXWeuwLq9lGfiAdR/c3jvNlcCM
        5wAp8xqNllXFKxCwSH9YnLnT5fJqBmd9ivu+0ER67gUI/Lc=
X-Google-Smtp-Source: ABdhPJzo57O5UM9KTSuIsJBIpCIgxTY0L/L5Yez+HoJoD0kp28X9guSFRME7Td1UIJOtiaVzjQSjFRuxa1TR88hqAkc=
X-Received: by 2002:a7b:cbc7:: with SMTP id n7mr37582291wmi.67.1625809696277;
 Thu, 08 Jul 2021 22:48:16 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 9 Jul 2021 00:48:00 -0500
Message-ID: <CAH2r5muOdHbLDQr_p15U0572qF+6MjPK+32JYAf4LUKPuvkLGA@mail.gmail.com>
Subject: how to request crypto_alloc_shash for GMAC
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <james.morris@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to add support for GMAC packet signing in the kernel
client (support for it, as an alternative to CMAC, has recently been
added to some SMB3.1.1 servers)

Presumably due to https://www.ietf.org/rfc/rfc4543.txt it is already
supported in the kernel ... but what is the name that it is exposed as
in the kernel crypto libraries?

When calling crypto_alloc_shash, I tried the obvious name:
         "gmac(aes)"
(similar to what was previously used "cmac(aes)" and "hmac(sha256")
but that didn't work.

Any idea what the algorithm name that is needed to be used for GMAC here?

In looking at drivers/crypto/ccp (not sure if that is the right
subdir) - the closest I see is ccp-crypto-aes-galois.c but using that
name I also got the same error (rc=-2) trying to request that as:
         "galois(aes)"

What is the correct name to use to request GMAC in crypto_alloc_shash?

Doing "git grep crypto_alloc_shash" there are no matches on:
       - "gcm" or "gmac" or "galois"
How is it named?
-- 
Thanks,

Steve
