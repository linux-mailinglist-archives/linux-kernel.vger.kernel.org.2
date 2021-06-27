Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9843B55A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 00:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhF0Wsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 18:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhF0Wse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 18:48:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45899C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 15:46:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q4so13959835ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FP4GHevXLc7+sHWGv3LiuwwfoofeUDyrdmRtLEq0Vls=;
        b=VD6EdDGAG0MJZcQxRB/5jF5gUF+DLvok10jCIkBcne4iMzd4zQrp+QqB/5lRh53QYk
         lU1rhs6AHfoNLqynHEOXBjfowk3WYaph2Os2qzipFu3rXL1zse0E6gsb/BGmiD5GAJgr
         1clIF5JQVv69QP+TvO47ttiTVR4Xjjh1H+XFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FP4GHevXLc7+sHWGv3LiuwwfoofeUDyrdmRtLEq0Vls=;
        b=I0ilBi9NtJ/gbWfJ+T6y3Xm6oOcds0x41bNH6Iy2kRD/skE+afwXlr4XEKpjcw3Anu
         58PZLoWPImcFCgS+RuxBvxwUov/Rm+ZohieZ3fws2yTaB6D7mzv0E7BHVY2srOixg2X6
         eqcHU3MJCNO7sGOPVMOwXv/KBWgqvqAVtiesWDzaukc5RS1b9ra0xm4ZqTJi5iDQYYQH
         JYfH5mvDCp79HXE83ql0IHNkUAOwCbG72V14DRNo6it4kCsnueGwFmYdlsjqHx0Qfcl/
         Nccju7uziyKdPgtOeItUJqWU3If90zabV6tMJzgilapv9v2HuzzmyqZ+WQZAfVk3Zw/s
         vE9Q==
X-Gm-Message-State: AOAM533myY3jzwRZwrse2ACd9UlYDQ/vHiSklXAKn35CvHrdu+/uMVCP
        4puDEmaTgLSi82X+xxpGsf2no8J6iZtKcudY
X-Google-Smtp-Source: ABdhPJyJfmUBk9RT2HiPv6MzpCdEq7OKjjD8z6ORPhHJ/zoQ0j7BEB4KBV14wOr3Kngvy1mCDkky0w==
X-Received: by 2002:a2e:4b11:: with SMTP id y17mr17269210lja.105.1624833967290;
        Sun, 27 Jun 2021 15:46:07 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k21sm1324758lji.107.2021.06.27.15.46.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 15:46:06 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r16so22292265ljk.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 15:46:06 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr1833841ljp.251.1624833966495;
 Sun, 27 Jun 2021 15:46:06 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Jun 2021 15:45:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7E9iTGHbqfgtaTAM09WrVzwXjda2_D59MT8D_1=54Rg@mail.gmail.com>
Message-ID: <CAHk-=wj7E9iTGHbqfgtaTAM09WrVzwXjda2_D59MT8D_1=54Rg@mail.gmail.com>
Subject: Linux 5.13
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we had quite the calm week since rc7, and I see no reason to delay
5.13. The shortlog for the week is tiny, with just 88 non-merge
commits (and a few of those are just reverts).  It's a fairly random
mix of fixes, and being so small I'd just suggest people scan the
appended shortlog for what happened.

Of course, if the last week was small and calm, 5.13 overall is
actually fairly large. In fact, it's one of the bigger 5.x releases,
with over 16k commits (over 17k if you count merges), from over 2k
developers. But it's a "big all over" kind of thing, not something
particular that stands out as particularly unusual. Some of the extra
size might just be because 5.12 had that extra rc week.

And with 5.13 out the door, that obviously means that the merge window
for 5.14 will be starting tomorrow. I already have a few pull requests
for it pending, but as usual, I'd ask people to give the final 5.13 at
least a quick test before moving on to the exciting new pending
stuff..

               Linus

---

Aili Yao (1):
      mm,hwpoison: return -EHWPOISON to denote that the page has
already been poisoned

Andreas Hecht (1):
      i2c: dev: Add __user annotation

Andy Shevchenko (1):
      pinctrl: microchip-sgpio: Put fwnode in error case during ->probe()

Arnd Bergmann (1):
      ARM: 9081/1: fix gcc-10 thumb2-kernel regression

Bumyong Lee (1):
      swiotlb: manipulate orig_addr when tlb_addr has offset

Christian K=C3=B6nig (4):
      drm/nouveau: wait for moving fence after pinning v2
      drm/radeon: wait for moving fence after pinning
      drm/amdgpu: wait for moving fence after pinning
      drm/nouveau: fix dma_address check for CPU/GPU sync

Christoph Hellwig (1):
      scsi: sd: Call sd_revalidate_disk() for ioctl(BLKRRPART)

Claudio Imbrenda (2):
      mm/vmalloc: add vmalloc_no_huge
      KVM: s390: prepare for hugepage vmalloc

Dan Carpenter (1):
      i2c: cp2615: check for allocation failure in cp2615_i2c_recv()

Dan Sneddon (2):
      drm: atmel_hlcdc: Enable the crtc vblank prior to crtc usage.
      drm/atmel-hlcdc: Allow async page flips

Daniel Axtens (1):
      mm/vmalloc: unbreak kasan vmalloc support

Daniel Vetter (1):
      Revert "drm: add a locked version of drm_is_current_master"

David Howells (1):
      afs: Fix afs_write_end() to handle short writes

Desmond Cheong Zhi Xi (1):
      drm: add a locked version of drm_is_current_master

Fabien Dessenne (1):
      pinctrl: stm32: fix the reported number of GPIO lines per bank

Gabriel Knezek (1):
      gpiolib: cdev: zero padding during conversion to gpioline_info_change=
d

Gleb Fotengauer-Malinovskiy (1):
      userfaultfd: uapi: fix UFFDIO_CONTINUE ioctl request definition

Haibo Chen (1):
      spi: spi-nxp-fspi: move the register operation after the clock enable

Heikki Krogerus (1):
      software node: Handle software node injection to an existing
device properly

Heiko Carstens (1):
      s390/stack: fix possible register corruption with stack switch helper

Heiner Kallweit (1):
      i2c: i801: Ensure that SMBHSTSTS_INUSE_STS is cleared when
leaving i801_access

Hugh Dickins (11):
      mm: page_vma_mapped_walk(): use page for pvmw->page
      mm: page_vma_mapped_walk(): settle PageHuge on entry
      mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd
      mm: page_vma_mapped_walk(): prettify PVMW_MIGRATION block
      mm: page_vma_mapped_walk(): crossing page table boundary
      mm: page_vma_mapped_walk(): add a level of indentation
      mm: page_vma_mapped_walk(): use goto instead of while (1)
      mm: page_vma_mapped_walk(): get vma_address_end() earlier
      mm/thp: fix page_vma_mapped_walk() if THP mapped by ptes
      mm/thp: another PVMW_SYNC fix in page_vma_mapped_walk()
      mm, futex: fix shared futex pgoff on shmem huge page

Ilya Dryomov (2):
      libceph: don't pass result into ac->ops->handle_reply()
      libceph: set global_id as soon as we get an auth ticket

Jeff Layton (3):
      netfs: fix test for whether we can skip read when writing beyond EOF
      ceph: must hold snap_rwsem when filling inode for async create
      ceph: fix error handling in ceph_atomic_open and ceph_lookup

Johan Hovold (1):
      i2c: robotfuzz-osif: fix control-request directions

Johannes Berg (1):
      gpio: AMD8111 and TQMX86 require HAS_IOPORT_MAP

Jon Hunter (1):
      spi: tegra20-slink: Ensure SPI controller reset is deasserted

Juergen Gross (1):
      xen/events: reset active flag for lateeoi events later

Krzysztof Kozlowski (1):
      drm/panel: ld9040: reference spi_device_id table

Linus Torvalds (2):
      Revert "signal: Allow tasks to cache one sigqueue struct"
      Linux 5.13

Loic Poulain (1):
      gpio: mxc: Fix disabled interrupt wake-up support

ManYi Li (1):
      scsi: sr: Return appropriate error code when disk is ejected

Marek Beh=C3=BAn (2):
      MAINTAINERS: fix Marek's identity again
      mailmap: add Marek's other e-mail address and identity without diacri=
tics

Mark Brown (1):
      ASoC: rt5645: Avoid upgrading static warnings to errors

Maxime Ripard (2):
      drm/vc4: hdmi: Move the HSM clock enable to runtime_pm
      drm/vc4: hdmi: Make sure the controller is powered in detect

Mel Gorman (1):
      mm/page_alloc: do bulk array bounds check after checking
populated elements

Michel D=C3=A4nzer (1):
      drm/amdgpu: Call drm_framebuffer_init last for framebuffer init

Mimi Zohar (1):
      module: limit enabling module.sig_enforce

Naoya Horiguchi (1):
      mm/hwpoison: do not lock page again when me_huge_page()
successfully recovers

Neil Armstrong (1):
      mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk

Nicholas Piggin (1):
      KVM: do not allow mapping valid but non-reference-counted pages

Pavel Skripkin (1):
      nilfs2: fix memory leak in nilfs_sysfs_delete_device_group

Peter Zijlstra (6):
      objtool/x86: Ignore __x86_indirect_alt_* symbols
      x86/entry: Fix noinstr fail in __do_fast_syscall_32()
      x86/xen: Fix noinstr fail in xen_pv_evtchn_do_upcall()
      x86/xen: Fix noinstr fail in exc_xen_unknown_trap()
      x86: Always inline task_size_max()
      locking/lockdep: Improve noinstr vs errors

Petr Mladek (2):
      kthread_worker: split code for canceling the delayed work timer
      kthread: prevent deadlock when kthread_mod_delayed_work() races
with kthread_cancel_delayed_work_sync()

Rafael J. Wysocki (1):
      Revert "PCI: PM: Do not read power state in pci_enable_device_flags()=
"

Rasmus Villemoes (1):
      mm/page_alloc: __alloc_pages_bulk(): do bounds check before
accessing array

Rik van Riel (1):
      sched/fair: Ensure that the CFS parent is added after unthrottling

Sven Schnelle (3):
      s390: fix system call restart with multiple signals
      s390: clear pt_regs::flags on irq entry
      s390/topology: clear thread/group maps for offline cpus

Thomas Gleixner (4):
      x86/fpu: Preserve supervisor states in sanitize_restored_user_xstate(=
)
      x86/fpu: Make init_fpstate correct with optimized XSAVE
      signal: Prevent sigqueue caching after task got released
      perf/x86/intel/lbr: Zero the xstate buffer on allocation

Timur Tabi (1):
      MAINTAINERS: remove Timur Tabi from Freescale SOC sound drivers

Tony Krowiak (1):
      s390/vfio-ap: clean up mdev resources when remove callback invoked

Tony Luck (1):
      mm/memory-failure: use a mutex to avoid memory_failure() races

Yifan Zhang (2):
      Revert "drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to
cover full doorbell."
      Revert "drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue.=
"

Zenghui Yu (1):
      KVM: selftests: Fix mapping length truncation in m{,un}map()

Zhen Lei (1):
      drm/kmb: Fix error return code in kmb_hw_init()
