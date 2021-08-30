Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51A53FB477
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhH3LWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhH3LWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:22:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BFFC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:21:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq28so30460460lfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endian-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BBg9bJPAKsPXjH24q/caKv/SOb7ax9p2YE/h3kXz+jQ=;
        b=dZfQwxsYdV4KLMNWS9wu8HLRwZchYs2zAIMWHU8QRPdjnodVc4BDoiAVN4CbHpGlOj
         lrHDG79dVFhQC9mVgL8yz9wQYqYjGEDH6giGOTcjBTSCwFFONHTPAaMMeRPSxzWjf94R
         4f2ZWd09Iv5l8aF1wFn6iuSb8hdf7C+U9LyNszg154HzztXkdA1UnrRzY2w79PHTNuI6
         kUVCtGShlrzc3VwS7vNgWH8dP62ViHOIU2W49K98gYFsZjLGXTgjZMkLQAoOJcSy1L6A
         ZuwFM/akSVAmipqP2taKg88tpJK2rDeZ3sPZ8Fw1T/dvNhl5BnbYBMR0CzW9SCRe71gD
         Hxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BBg9bJPAKsPXjH24q/caKv/SOb7ax9p2YE/h3kXz+jQ=;
        b=lnxkCXgRHlJi6M4tqiCDhCaFlpxeIQnnNNt4nnjNHAS0UNYnjXmOVFXhJhp41rjbCw
         kfXRDAavGomF/Irb50RngHg3ziPlmW07JSznsbsOIWhgwf1MCdOBAjwaQCRn+WZiwi3B
         /CGE5WpuRLI7ziOwPsYHgUoDd6rWuR68TkIdYi3fsgz46NfJgxCA3royVPbE4dhEDCsf
         vi2g6e9EBjmrryt8U5rEg8zNl9D4duvcLI9XH0UD0x6e0YLa/uvr8JXF5902hS58xDhz
         z0naRXWTYoltXBj6NzKQtho+wBRh9QjLjU6NqbTKymCoRwQxYBsmEb2lYIweYgZZAfR6
         GGLQ==
X-Gm-Message-State: AOAM531Gbc/C6Q5ltFc/8knPHI8y5/avGZ3etzHGkDCxEkAtWcqMRJOD
        xFCo84xoQ6+bbrHAVni436zD+A==
X-Google-Smtp-Source: ABdhPJyf2qHIgOQh9TwRKYBKsF2jcobQWWQtrZyYMJEXLEG+MHFGQAtlKGgZtR413ZXXO18/sj2Z9A==
X-Received: by 2002:a05:6512:3593:: with SMTP id m19mr16577137lfr.624.1630322499594;
        Mon, 30 Aug 2021 04:21:39 -0700 (PDT)
Received: from gmail.com ([185.213.154.232])
        by smtp.gmail.com with ESMTPSA id s4sm1792085ljp.115.2021.08.30.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 04:21:39 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:21:32 +0200
From:   Fredrik Yhlen <fredrik.yhlen@endian.se>
To:     horia.geanta@nxp.com
Cc:     aymen.sghaier@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com
Subject: HRNG in CAAM isn't working properly on IMX6 SoloX
Message-ID: <YSy/PFrem+a7npBy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We're having problems with hwrng on a board with imx6sx (soloX) running Linux
5.10.x. mainline, and I have tracked it down to this commit
'358ba762d9f1d4ba99ab31ef12bc28014b22f4c9' as being the culprit.

The caam_jr driver spits out lots of messages when attempting to read from /dev/hwrng:
```
[29717.629041] hwrng: no data available
[29727.859008] caam_jr 2101000.jr: 20003c5b: CCB: desc idx 60: RNG: Hardware error
```

```
caam_jr 2101000.jr0: 2000025b: CCB: desc idx 2: RNG: Hardware error.
caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error.
```

This also happens on Boundary's Nitrogen6_soloX board when running the same
kernel, and likewise with their latest Yocto release that uses 5.4.100 linux-imx kernel.

```
root@nitrogen6sx:~# dd if=/dev/hwrng of=/tmp/random bs=256 count=10
[  113.940735] caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error
dd: /dev/hwrng: Invalid argument
root@nitrogen6sx:~# rm /tmp/random
root@nitrogen6sx:~# dd if=/dev/hwrng of=/tmp/random bs=256 count=10
[  125.300823] caam_jr 2101000.jr0: 20003c5b: CCB: desc idx 60: RNG: Hardware error
dd: /dev/hwrng: Invalid argument
root@nitrogen6sx:~# du -hs /tmp/random
0       /tmp/random
root@nitrogen6sx:~# ls -l /tmp/random
-rw-r--r--    1 root     root             0 Dec 16 17:27 /tmp/random
root@nitrogen6sx:~#
```

And then no data is available from /dev/hwrng.

The problem occurs when adding OP_ALG_PR_ON(prediction resistance) when setting up
job descriptor for reading new random data in caamrng.c. There are also
some confusing parts about this commit that I'm not too sure about.

1. It's adding a conditional variable named 'pr_support', but I guess this only
indicates if the MC(Management Complex) supports prediction resistance,
since the following check can be bypassed when 'pr_support' is false.

    /*
     * If SEC has RNG version >= 4 and RNG state handle has not been
     * already instantiated, do RNG instantiation
     * In case of SoCs with Management Complex, RNG is managed by MC f/w.
     */
    if (!(ctrlpriv->mc_en && pr_support) && rng_vid >= 4) {


This will eventually lead to the following chain call: caam_probe() -> instantiate_rng() ->
build_instantiation_desc(), where OP_ALG_PR_ON will be used through DECO.

static void build_instantiation_desc(u32 *desc, int handle, int do_sk)
{
    u32 *jump_cmd, op_flags;

    init_job_desc(desc, 0);

    op_flags = OP_TYPE_CLASS1_ALG | OP_ALG_ALGSEL_RNG |
            (handle << OP_ALG_AAI_SHIFT) | OP_ALG_AS_INIT |
            OP_ALG_PR_ON;
    ...
    ...
    ...

Shouldn't it be named 'mc_pr_support' instead, or something similar?

2. PR is unconditionally used in caamrng.c(caam_jr module) when
reading new RNG data. Should this be the case?

Removing OP_ALG_PR_ON in caam_init_desc() from drivers/crypto/caam/caamrng.c
seems to fix the problem we're experiencing, here's an example:
```
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 77d048dfe5d0..f085a80b1b3c 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -67,8 +67,7 @@ static u32 *caam_init_desc(u32 *desc, dma_addr_t dst_dma)
 {
        init_job_desc(desc, 0); /* + 1 cmd_sz */
        /* Generate random bytes: + 1 cmd_sz */
-       append_operation(desc, OP_ALG_ALGSEL_RNG | OP_TYPE_CLASS1_ALG |
-                        OP_ALG_PR_ON);
+       append_operation(desc, OP_ALG_ALGSEL_RNG | OP_TYPE_CLASS1_ALG);
        /* Store bytes: + 1 cmd_sz + caam_ptr_sz  */
        append_fifo_store(desc, dst_dma,
                          CAAM_RNG_MAX_FIFO_STORE_SIZE, FIFOST_TYPE_RNGSTORE);
```

Best regards,
Fredrik
