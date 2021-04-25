Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8336A95F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhDYVHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhDYVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:07:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5BFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 14:06:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o5so28624792ljc.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rFL57X5dT8uq0jyTTi5e3CYAn19e6+moDRvcnmddWFs=;
        b=Aj/RYne21IRfrpILIZ5N042zx9+zCYXeHQhqCJK4BScfCFjs3Xcdu1wnNkbRi+Lc3T
         JYu3YHB0bEnjNI76MZEsWMfoZwbHVbS0XT9LFzA7Wgp9FdImW/33W1CV5qAdp4tWc903
         nd1sEC2xxBHiHSWiyxQVhSFXaxbAojX9Ej3QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rFL57X5dT8uq0jyTTi5e3CYAn19e6+moDRvcnmddWFs=;
        b=QTK1VK0qwQvMGf292DXBwEy/OmrBC0Bg/e07ion/ESAS1DKFncEYSEtVkyzsJcOcBk
         XK/dGzzjiCrMSUDVOCbfpdL7MG5fFh55Mia/d0/CoqKW4IDau/FAgjC8RE0NRmJdDkNM
         FaaaWdmM944DrDh3uMaORqWwthlPrJtm/WksWZs1FGMkWY2OlJGssHdKQM/J7odQI34h
         c+eAqOK89TbRp4+YFJpvNpDxEbyegWHUlzl4kxBcZ9q6I07jPFm45RSLCmtAzOBRb30A
         jpJeEwCvhd8yob7+IaNScv/tqctRDO6NqpJL6Hzqk3rjDRw+ywH3pBOVDfqmJHaGuhEw
         mHWQ==
X-Gm-Message-State: AOAM531NYtaZzRblQx9bZHklKVRP1/oj/GV9rd2PG22arJZA7kkwcDI/
        u6qgW2ZBvH7mNgtsyfDLyh053tC0u6IozrwY
X-Google-Smtp-Source: ABdhPJx0HF9rTGWL26JnlTuuzhns3Cba5L37e7TP9Lv7g8a/2QKq0AwNRVcyhpbELs+CPRV87v6YCg==
X-Received: by 2002:a2e:b819:: with SMTP id u25mr10401700ljo.105.1619384811425;
        Sun, 25 Apr 2021 14:06:51 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n8sm1199348lfe.285.2021.04.25.14.06.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 14:06:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id n138so85367589lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 14:06:50 -0700 (PDT)
X-Received: by 2002:ac2:43c5:: with SMTP id u5mr10050560lfl.40.1619384810680;
 Sun, 25 Apr 2021 14:06:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Apr 2021 14:06:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
Message-ID: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
Subject: Linux 5.12
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everybody who made last week very calm indeed, which just
makes me feel much happier about the final 5.12 release.

Both the shortlog (appended) and the diffstat are absolutely tiny, and
it's mainly just a random collection of small fixes in various areas:
arm64 devicetree files, some x86 perf event fixes (and a couple of
tooling ones), various minor driver fixes (amd and i915 gpu fixes
stand out, but honestly, that's not because they are big, but because
the rest is even smaller), a couple of small reverts, and a few
locking fixes (one kvm serialization fix, one memory ordering fix for
rwlocks).

Anyway, this obviously means that I'll start the merge window for 5.13
tomorrow. But I'd ask that even developers champing at the bit to get
their shiny new code merged please spend a bit of time running and
checking out 5.12.

Despite the extra week, this was actually a fairly small release
overall.  Judging by linux-next, 5.13 will be making up for it.

         Linus

---

Ali Saidi (1):
      locking/qrwlock: Fix ordering in queued_write_lock_slowpath()

Andre Przywara (1):
      arm64: dts: allwinner: Revert SD card CD GPIO for Pine64-LTS

Andy Shevchenko (1):
      pinctrl: core: Show pin numbers for the controllers with base =3D 0

Christian K=C3=B6nig (2):
      coda: fix reference counting in coda_file_mmap error path
      ovl: fix reference counting in ovl_mmap error path

Christoph Hellwig (1):
      block: return -EBUSY when there are open partitions in blkdev_reread_=
part

Eli Cohen (1):
      vdpa/mlx5: Set err =3D -ENOMEM in case dma_map_sg_attrs fails

Hugh Dickins (2):
      mm/filemap: fix find_lock_entries hang on 32-bit THP
      mm/filemap: fix mapping_seek_hole_data on THP & 32-bit

Imre Deak (1):
      drm/i915: Fix modesetting in case of unexpected AUX timeouts

James Bottomley (1):
      KEYS: trusted: Fix TPM reservation for seal/unseal

Jiansong Chen (1):
      drm/amdgpu: fix GCR_GENERAL_CNTL offset for dimgrey_cavefish

Jim Mattson (1):
      perf/x86/kvm: Fix Broadwell Xeon stepping in isolation_ucodes[]

Jon Hunter (2):
      arm64: tegra: Set fw_devlink=3Don for Jetson TX2
      arm64: tegra: Fix mmc0 alias for Jetson Xavier NX

Kan Liang (1):
      perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3

Leo Yan (1):
      perf auxtrace: Fix potential NULL pointer dereference

Linus Torvalds (3):
      Revert "gcov: clang: fix clang-11+ build"
      Revert "net/rds: Avoid potential use after free in
rds_send_remove_from_sock"
      Linux 5.12

Mike Galbraith (1):
      x86/crash: Fix crash_setup_memmap_entries() out-of-bounds access

Neil Armstrong (1):
      mmc: meson-gx: replace WARN_ONCE with dev_warn_once about
scatterlist size alignment in block mode

Philip Yang (1):
      drm/amdgpu: reserve fence slot to update page table

Qingqing Zhuo (1):
      drm/amd/display: Update modifier list for gfx10_3

Sameer Pujar (1):
      arm64: tegra: Move clocks from RT5658 endpoint to device node

Serge E. Hallyn (1):
      capabilities: require CAP_SETFCAP to map uid 0

Simon Ser (1):
      amd/display: allow non-linear multi-planar formats

Steven Rostedt (VMware) (1):
      tracing: Fix checking event hash pointer logic when tp_printk is enab=
led

Thierry Reding (1):
      arm64: tegra: Add unit-address for ACONNECT on Tegra186

Thomas Richter (1):
      perf ftrace: Fix access to pid in array when setting a pid filter

Tony Lindgren (1):
      gpio: omap: Save and restore sysconfig

Vasily Averin (1):
      tools/cgroup/slabinfo.py: updated to work on current kernel

Wanpeng Li (1):
      KVM: x86/xen: Take srcu lock when accessing kvm_memslots()

Xie Yongji (1):
      vhost-vdpa: protect concurrent access to vhost device iotlb

Yuanyuan Zhong (1):
      pinctrl: lewisburg: Update number of pins in community

Zhen Lei (2):
      perf data: Fix error return code in perf_data__create_dir()
      perf map: Fix error return code in maps__clone()

Zhenyu Wang (1):
      drm/i915/gvt: Fix BDW command parser regression

Zhouyi Zhou (1):
      preempt/dynamic: Fix typo in macro conditional statement
