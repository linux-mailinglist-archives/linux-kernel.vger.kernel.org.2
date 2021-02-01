Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD730ACB5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBAQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhBAQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:34:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188DC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:34:03 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so23619624lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sTjaV842e3lQQ0QyQx1MRefCi3psMAfvcNsMB4upxRU=;
        b=XHwHl+aCytpgITGPXjPcD3MEGGf9pUL11XwiSrKTWIQU5bpB0XH9/40g7y5iItD4Tx
         MKbKoe4lfV0hQeBJoaN3HP3RMbnB63qMBOMWErgoyZ9y17WKFJESYBC+xRfiXd0XiBXN
         /NI3gDJhrC60EIjfvYsvYwdULQZkuOlJNQZ7QM35Ri7VCEb10nuv/ZLMsLBNI6kcu+p+
         f/inB7pfzQYITrcxHs69hM+8P99gRuFKjZBRkqOBR9wsW669FPuR2DjELW/MpDB2fSS5
         vjVsmqpyNpR6XgiFa9WA0o0PCGD8dJvLTHuIicArktCF5kIniwjzm0M6gFGj4e+YR/ip
         r5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sTjaV842e3lQQ0QyQx1MRefCi3psMAfvcNsMB4upxRU=;
        b=mWlRe+YIgZX+fwhzgKPHIumJU1TZdtljiVKaNTCr+4Q4uMw2d8GIpc2/cUUHj5qiRP
         d0FmsePdJqIxMahxb7z4QB5C3zgDXPN5pIBz2AsZ0dYSESNGHPLwIBdKEopw/53GZejJ
         B0au0nhYZttchZtn0H/ln13Pt01u0Oau97a2/8JmH1rPymdMMON+TW99MbdE5qXEurxN
         NvjiUUOHconj3L/aot7YSW1t13YnP3FuVMLcBhdGQ6jEkdq4DKFo0KXLJrFf3snQ5WcJ
         xvPFj9VrpOdd6EC5HyB6LSb1kJ4esftYDty5LmwERuEsIPedUjXxhEDiMe4BTwvuxR+p
         3hag==
X-Gm-Message-State: AOAM530DGsDGttvLA9gfbtL7a99AkJvmEcExamd9YuA6XE2JADo4lg2x
        7ObyyXq6+yQVBTaPFnJ76wh0PZlL0ijI2DFoJh5RXJcECFZcOHo0
X-Google-Smtp-Source: ABdhPJwFbmiYLyfj98WwXePFDVTifmSXWyvUKQ5JYfG/iLSGNia7UWB8T6rEOai0cF+VDbxXY0nluvzPVc3iWI8vPuE=
X-Received: by 2002:a05:6512:3748:: with SMTP id a8mr8694093lfs.31.1612197242078;
 Mon, 01 Feb 2021 08:34:02 -0800 (PST)
MIME-Version: 1.0
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 1 Feb 2021 22:04:01 +0530
Message-ID: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
Subject: Patches from the future - can checkpatch help?
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
on linux-next,
$ git log --pretty=format:"%h%x09%ad" | awk '$6>2021 {print $1}'
gives:
4a2d78822fdf
12ca45fea91c
09f2724a786f

These are patches from the year 2085, 2037 and 2030 respectively.

Would a checkpatch rule be helpful for these or are they too
isolated to waste runtime on?

Thanks!
Dwaipayan.
