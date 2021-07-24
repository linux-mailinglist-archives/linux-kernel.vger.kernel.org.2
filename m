Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3BF3D4421
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhGXARo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 20:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhGXARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 20:17:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e5so3065343pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ixp2Efw04Zmd3ojpMMirglfvU4JyFrlYnefPbpvE9qQ=;
        b=l9EmVZ1b8261Fr7etjdogpbySpGIQb72E9mXlzLasGgTGWAJ8EtVZTKMd8zbqGSMJc
         7YIbBQh9V9p0HVnWd19DovMR24aEgea4rFtpb21KtqEp1fAJ1bQIsxr+Ro7Ca+XRbJti
         AaPBqClr83WbK38H6hMlj8Ux1ezhqf6w3PM1/0f/1tSq0cHWZb7pNMI5Q0ClyXlxf41X
         7rqvgNVh5C4wJEO0M59w2xU8cdceEWdq6sVIY+rrJMLcVFAAFqhc2pOn6gckWmsnB9a2
         zu+husRrFIUNK3nLfWZLOnroMNLehpEAurSlwX4ZzIJJ/GqkKknqJzQR2dJaVqeU/AQN
         5ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ixp2Efw04Zmd3ojpMMirglfvU4JyFrlYnefPbpvE9qQ=;
        b=nH8cslNIfpkOYQz9c1zRqWVj2q6zRrAatSMe/PMGQKZnnQnqtJreCygfnoDpDJczAT
         3Kr8LnTeFnZwtYiKlmw32JQlg5egNnk9V1ztP51CA9XEwCVza42yUTg5yWRcxPm//smn
         iuozNYuoiUYPsHSlbRNkDNMSUMvQhBjw/JtDsMiI6c2KlGj0ePJgp4HSC8GhiM+wiGdA
         jMohA3WOOJLL4rBJwev9jA1rEDP61s51vCRCg/oSQKRq2iKFRklh2y3wJevOebpMClFo
         AdzB1u44QFY2mUn+IWIuMLITYUcnh0ryf8cZ/FdQzl9HgGlWC2iaU5L05y9xUQ+RaSBR
         VTSg==
X-Gm-Message-State: AOAM532knKvq5REvTmgMBw4w/RqElZH4AVBTxvgWIDG01iRIXX5uYNuP
        mZoyneSel8ed/LKpj/p1KWl6AQ==
X-Google-Smtp-Source: ABdhPJxSoQnZ7ArDNB+xyZSWKkPLPV63ZJuP3n9jQ2eYDIVHIqFpcrorc0FpHDVXGSt+1cbT3m/aGA==
X-Received: by 2002:a17:902:dcd4:b029:12b:fd1:d95 with SMTP id t20-20020a170902dcd4b029012b0fd10d95mr5740043pll.13.1627088292770;
        Fri, 23 Jul 2021 17:58:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d3sm11434430pfj.17.2021.07.23.17.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:58:12 -0700 (PDT)
Date:   Fri, 23 Jul 2021 17:58:12 -0700 (PDT)
X-Google-Original-Date: Fri, 23 Jul 2021 17:51:10 PDT (-0700)
Subject:     Re: [PATCH 0/4] __asm_copy_to-from_user: Fixes
In-Reply-To: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, linux@roeck-us.net,
        geert@linux-m68k.org, aou@eecs.berkeley.edu,
        akira.tsukamoto@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akira.tsukamoto@gmail.com
Message-ID: <mhng-b80245ea-c042-4de9-8a2c-22b3e188434c@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 01:49:42 PDT (-0700), akira.tsukamoto@gmail.com wrote:
> These are series for the fix reported by Guenter, Geert and Qiu.
>
> One patch to fix overrun memory access, one patch to fix on rv32.
> And two more for clean up and typos.
>
> Have tested on qemu rv32, qemu rv64 and beaglev beta board.
>
> Thanks for the report and instructions to reproduce the error on rv32.
>
> Akira
>
> Akira Tsukamoto (4):
>   riscv: __asm_copy_to-from_user: Fix: overrun copy
>   riscv: __asm_copy_to-from_user: Fix: fail on RV32
>   riscv: __asm_copy_to-from_user: Remove unnecessary size check
>   riscv: __asm_copy_to-from_user: Fix: Typos in comments
>
>  arch/riscv/lib/uaccess.S | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Thanks, these are on fixes.
