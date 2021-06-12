Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043D3A4C5B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFLDNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:13:07 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:40736 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFLDNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:13:06 -0400
Received: by mail-qk1-f172.google.com with SMTP id u30so33086529qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YHbD/mqCuSEzcC4RtK8XYrrBs5SxDQZwxPGKgUy8SlM=;
        b=rpinneijh7hd0eRqrHUCVKLm7oZHpwZB0G+4hgQ8j8yaa6WTiRsRY7o6T+YMvPqrra
         ejTlsWMIz86dBpbLlaSzfXLMF1i1CU67t9sJaBXloBEdnuYJ8vdZt/2ursU1NrvxTAE8
         vMzLDoSaWtzDzQpF7NJVYbrm9ZkF5cDyhQQg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YHbD/mqCuSEzcC4RtK8XYrrBs5SxDQZwxPGKgUy8SlM=;
        b=MOhfdvOtyE8jHL51WFnFz+bOAFUPIrUldxeXOXkCb+sTri1hBogojkV3kXqOk8/MD1
         fXEjD4YgrYhmnhdIUydvaFPDvSeichIvsavnNgqXzlLFLhKFau3cJHYAfMWhJkvgxL6m
         F/zbbcElgnTHUmOBJIUuVWabHSfuatOOcDMtn8oDU3n2cQ36qyq/vsZAP7VylO8pcnQJ
         F6rDbQHgOF4bAOuWdFcyCsnAXz1UMrpfU91eDJQu5xvfKdf+KmA7naE0p72dnOZiq4Le
         X2pdZeAQIj6AwOUDEyWHzBrIOL7wC498TLiNjN6vXhHvOP05f2YrElXL3tTIIj3KRBbD
         HNRw==
X-Gm-Message-State: AOAM533XQHYFCQ+l2s3luxYpOK6/lp8k0alqvPkOxkjQf/mKne3wzCdf
        arPEjxxtMWkfzyBUMxGRik3toF6G1jPwpfVBYuR/tA==
X-Google-Smtp-Source: ABdhPJxuioRL5IHEdYVJvdAATuTZJJREI76GNFQ6UykbwmNwyly3PJZuJdWcqHaduWqlSNmreaAtSxscYYu0md6s6xw=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr7094529qki.159.1623467407535;
 Fri, 11 Jun 2021 20:10:07 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 12 Jun 2021 12:09:56 +0900
Message-ID: <CAFr9PXkMSDvks+DeCNJ6iKf6zDH0VaOL6msirR3g2K7BNL8YkQ@mail.gmail.com>
Subject: [GIT PULL] ARM: mstar for v5.14
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, SoC Team <soc@kernel.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

This is my first time doing this so apologies in advance if I've messed this up.
Anyhow, we have two very small patches for 5.14.

- Romain has stepped up to clean up some of the ~300 patch backlog for
MStar and he added support for earlyprintk in the process.
- In an effort to do things properly I've moved work on the MStar
stuff from my personal github account to one for this project. So
people can find it I've added a link in MAINTAINERS.

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

 Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

 https://github.com/linux-chenxing/linux.git tags/mstar-5.14

for you to fetch changes up to 06d09c789e2a78852adc99c54945457870247b09:

 MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree
(2021-06-12 11:40:49 +0900)

----------------------------------------------------------------
Daniel Palmer (1):
     MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree

Romain Perier (1):
     ARM: debug: add UART early console support for MSTAR SoCs

MAINTAINERS            |  1 +
arch/arm/Kconfig.debug | 11 +++++++++++
2 files changed, 12 insertions(+)
