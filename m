Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85B7421A05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhJDWbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhJDWbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:31:07 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B1C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 15:29:17 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id y14so7536829vsm.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qPpOKzL1TojkFo7Tn+DkovguIN33cj/XmXhWx++uBk0=;
        b=fHt7+vxrTsuWelPcJjGyCr3kU69Kbp5HLvJvuNH1BJOsOKFF7SZfcl/mzJY4YPnEFV
         XA2+3jbAdxD+XdLC+uY1YDc74Z/elfYItiZBcrgaA682l/avtQ+MifVbouLe43UpujX1
         qxRIENz/m8oKrq4oFjUm3tT6cPM+llJYybdP4ljFBHiVm7n5i1A8aLCeHv6u9Cl+FMcx
         4Ni9KUCLxj0wzARsU8Fs5Csg549yM2utQp6LEKyfU/hk0ExpYmnGsPt0iWDwtOdwEKC+
         qOr63/K0NX5Uu4BabUj17pFMR2HAcdGFBXi5yMBChNy2/sEra+ZriBJp/jFnTuYPN/LF
         fW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qPpOKzL1TojkFo7Tn+DkovguIN33cj/XmXhWx++uBk0=;
        b=TeyAYkIEHSR9yFSrzyvcrWPnBH2AsMzwOitG6w7C550wvbvWK0wb/i2TuavyOEgHsZ
         Js79AC4sJWA1B7IWxwv5GbVUnwAXaWxF9ZDpZknVxT9T4TO7fUh57GgCyInIGw126ZTO
         p6UGqk1ws3oc9a/yivuqoLWcpBUAwGbdOdB48/D25omiNHVOgwdy0S+DOiYCl9wwk/jg
         XpqWRyoR+oi16vQTKVukA4/xwUVg8AZz2C282buzIMDY+OGEDiqdJ6x4KDmpX6Z7Nn/z
         6nv+ShecU877kov0dDrPC1wek7Im9qWHqPzhQJpQn2HcHI9Uuf7uWx0R9jrwTUFdUkFc
         yzRA==
X-Gm-Message-State: AOAM5338p63d5/3MaLkaTxlkUrCIlPq0Qe+00Zi/I2yoOXUmhU7s7nwH
        SAs2tjxChRNJWxbvYGGCWW07/yjho84smQ==
X-Google-Smtp-Source: ABdhPJyglSk64R+xeEROwSK0mJ5EbpmYhYCj7KnifLQjY0Pq173UmZYvJY0mEVYAHuI9z6b4hWJy8Q==
X-Received: by 2002:a67:e24f:: with SMTP id w15mr15742805vse.36.1633386557047;
        Mon, 04 Oct 2021 15:29:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a14sm7917897uak.8.2021.10.04.15.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 15:29:16 -0700 (PDT)
Date:   Mon, 04 Oct 2021 15:29:16 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 15:29:12 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20211005080926.2f624ea7@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-71823752-6ddd-4d08-8b18-a6924721e072@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Oct 2021 14:09:26 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   3042b3659ac5 ("riscv/vdso: Add support for time namespaces")
>
> is missing a Signed-off-by from its committer.

Sorry about that, it's fixed.
