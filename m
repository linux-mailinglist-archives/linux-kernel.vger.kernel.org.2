Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C13839D4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFGGVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:21:23 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:34464 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:21:21 -0400
Received: by mail-yb1-f180.google.com with SMTP id i6so8691984ybm.1;
        Sun, 06 Jun 2021 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4kls79pFywfn957MkMI4qF5Ce9iUPw3f3CVSvySgq7I=;
        b=MdIqHKvSWmkKQafdTfky2JE5Ogzhwv8SyomS9uaA6vxWbz3tWjQFgXrXKIGlX5xgoM
         UlIcjkAlyAxg/beWo8c3TPi+f7FTRvY2wO4JMCEVCqfiPNXXsFdTUO+Z1c41tlmySU3L
         FSgkKk+G0zVZLQEewcVNar1F0B0vISGIQiOATaB4Fu8oczE7+7rpkq1PhKC7AUkeJS9T
         fQTw0TwOA1dCEuxYcdrBevV8gqA42RMYZ/a8VrguWK4A6vfa3e4YO+H/VVJMyZ0MN+pb
         eM0Gfi9qPpX+aZVZK/3LPPRqbseNNFwY5KE83mFPSz9v/zHf6kKjjrW+AkWO/IvI7aEO
         mQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4kls79pFywfn957MkMI4qF5Ce9iUPw3f3CVSvySgq7I=;
        b=aSpWlu+wwl6wJPkFF5sTEHC/0b0/g+EdTCAA/IoYjjJz3Bg2CmskqRrSBuYmQlHHCm
         m/xdARsZiSpz5C11CWmrePyzXHFP9+iNSTkaXvowgsZqDqYek+PX5Go4AJuWOwPwt7P8
         9Gt1FGVkMV6pUtkPp1U4ESBQcsrDJvGjJhXg8aAarFeHOlH6MLcdV8oCJdNgtwx9XcLW
         QkGdP2+cT8obAa2pNnB5fh6shG4CdcGER5ueCyu/qzTosaargHtAqFpU+FTOrqV+XLdS
         s0D6uat6WbAbV48HawCj5rTlsirmZwWRGzb8GRiuIFOaYIUAIZAQR4kuJgp0jGncqS+z
         ai7g==
X-Gm-Message-State: AOAM530/M2tVwVM7R4DnjeeRZCH/B6bbWDWjaY2FVGMKuMTMSZK0vUMC
        Tp3sYWlt9oU96Q9H8nD+7gNrfIcN5p9BiUVVmhXjpdvfxErNQQ==
X-Google-Smtp-Source: ABdhPJzM9RIkNUNhh1m2QFBjMo91Rj2sVgiNwlyFDpYhMH/Yocu0cMi9UwOJc7xufmj43Se/H7/8VEzKP2FGpKuxGmo=
X-Received: by 2002:a25:7cc6:: with SMTP id x189mr23106785ybc.371.1623046698963;
 Sun, 06 Jun 2021 23:18:18 -0700 (PDT)
MIME-Version: 1.0
From:   Grzegorz Zdanowski <grzegorz129@gmail.com>
Date:   Mon, 7 Jun 2021 01:18:08 -0500
Message-ID: <CAAoDVDD=aZiNvf1Ex2ssPOEC=tKw4iKsGkPGYq0wGC-kNsBEzw@mail.gmail.com>
Subject: [BUG?] scripts/extract-vmlinux doesn't produce correct images
To:     linux-kernel@vger.kernel.org, kernel-packagers@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

To avoid a XY problem, I will say upfront that I want to:
 1. unpack the x86_64 bzImage
 2. byte-patch it (as the full source is not available)
 3. recompress it back to bzImage to use w/GRUB

Neither the script, commit message
(#09d481270d445d98342d8ab872f05491b6d23f8b) nor LKML thread where the
script was discussed (https://lkml.org/lkml/2011/8/4/168) specified
which "vmlinux" is extracted. I compiled the kernel and ran some tests
after painstakingly analyzing Makefiles.
It looks like "scripts/extract-vmlinux arch/x86/boot/bzImage" extracts
an equivalent of arch/x86/boot/compressed/vmlinux.bin:
# file arch/x86/boot/compressed/vmlinux.bin test-extract
arch/x86/boot/compressed/vmlinux.bin: ELF 64-bit LSB executable,
x86-64, version 1 (SYSV), statically linked,
BuildID[sha1]=2cc29c8d102d8dac8a4cd29539f4364a334f88fd, stripped
test-extract:                         ELF 64-bit LSB executable,
x86-64, version 1 (SYSV), statically linked,
BuildID[sha1]=2cc29c8d102d8dac8a4cd29539f4364a334f88fd, stripped


However the extracted file doesn't match any other file I was able to
find analyzing compilation process. Even with the size of
vmlinux.relocs it will be significantly off.
# ls -1s ... | sort
  11144 arch/x86/boot/compressed/vmlinux.bin.lz4
  11148 arch/x86/boot/compressed/piggy.o
  11200 arch/x86/boot/vmlinux.bin
  11212 arch/x86/boot/compressed/vmlinux
  11416 arch/x86/boot/bzImage
  35752 arch/x86/boot/compressed/vmlinux.bin
  43968 test-extract
      4 arch/x86/boot/compressed/piggy.S
 760924 vmlinux


1. Did I found a problem with extract-vmlinux, or is that script
extracting something else?
2. Is there any other way to binary patch a kernel where only the
bzImage is available?

Apologies if my questions are very basic, I'm just dipping my toes in
the kernel space.

--
Grzegorz "Greg" Zdanowski
