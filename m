Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33736D12B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 06:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhD1EPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 00:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1EPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 00:15:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C826BC061574;
        Tue, 27 Apr 2021 21:14:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l21so18593512iob.1;
        Tue, 27 Apr 2021 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KDHkVVYm6hBaMYBkXAgpTY990Od3VDPZXR1b+LSLQhs=;
        b=MOowmMYbDUTZkJIMiIiyFJQDwoM0MvifXfJ9UIQS56WaiI7rVfKcDPSAGxr4jR64nz
         vXplAyQma4c8Nj7rQWrhpv1zNZxC9q5ak0ng3DKupwJvJP4XTftAm0jdTFDcNUFHcgwU
         xnawjMr58La0AkcNxWE0bm4KGHLKBcem/uJhB6yCaw4hXFgN9JhXOQ/FBPXhb/V02vkq
         NOr+ogZ7UzYQDlKuOX+wIA9npB2aowT5pPHxqTYlmZECfgXhZstfdK1lsnGKNRVSn8ve
         9GZ6Py7fqfmBOkKYLSt50YCCyZgYjR6P950GEcb40zxUNGgQmhR7DKW3XghWM2OkEmfA
         r82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KDHkVVYm6hBaMYBkXAgpTY990Od3VDPZXR1b+LSLQhs=;
        b=tasJQhmKQKL0VohMEgJuWT5lF8SYn278XsQVLS17c+j6FQHwtVRESXyMObKtXg9YvD
         r2szmwu1MWFzqj+fCyAZ3xtqKX4GmgqGfQwb5IQ+V8xfoiMAxml/DleoySR+XTmprKp1
         0bcfq1yDKOKhMA1gUKoAIhozHZ/BxheDLEazfoBJrbjFuqhUI3wUvj+bljevisY7L/Xy
         uIgjuY/nQKHHSdJoc73H90QGEkhO4GbGDJGfRnta+GccxUXbkAdLDgbxwYMHNlvDhZgX
         GYbxpCQBHSQHM85TFPM9duM94XDNFzBU5dEXyGcyVW8I5EF6mgigY6MWVV48eoveuljr
         7a2Q==
X-Gm-Message-State: AOAM531iNY0nh2/2c/378yuGFwJPrVT+tkW8WJz4eZmJMdlAdSHqc2Sj
        GK+GCTQxz2KqEeJ2EnA4nXiOwWAbNMvG4dkZYWufE1OCOaQ=
X-Google-Smtp-Source: ABdhPJzFK5pECLSZt+y9EL4BdEG0TjzDlptbkrW7xj+Yi0w+J2WCxoZWB4HHJA9heFBOiZ7Ox6jVGcOYLnThaXOBm38=
X-Received: by 2002:a02:662b:: with SMTP id k43mr24443251jac.139.1619583275234;
 Tue, 27 Apr 2021 21:14:35 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 28 Apr 2021 06:14:24 +0200
Message-ID: <CAKXUXMz51GMRM6s7YqGYgfZwRhW=y0aCALM-C3APU0=GjZ+X_g@mail.gmail.com>
Subject: MAINTAINERS section RISC-V/MICROCHIP POLARFIRE SOC SUPPORT with
 invalid file references
To:     Atish Patra <atish.patra@wdc.com>, Conor.Dooley@microchip.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Patish, dear Conor, dear Palmer,

Commit df29598aaf5c ("MAINTAINERS: add microchip polarfire soc
support") adds the new section RISC-V/MICROCHIP POLARFIRE SOC SUPPORT,
but that section solely refers to files that do not exist in the
repository.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/soc/microchip/
  warning: no file matches    F:    include/soc/microchip/mpfs.h

The patch series, [PATCH v4 0/5] Add Microchip PolarFire Soc Support,
never adds those files, though. Are they coming through a different
patch series into Linus' tree or do you intend to refer to other files
instead?


Lukas
