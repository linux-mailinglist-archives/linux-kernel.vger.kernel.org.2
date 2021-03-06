Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8CC32F797
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 02:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCFBym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCFBya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:54:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC7C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 17:54:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p21so7411066lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=N/OU4qR+EybjOpV+lvQVqrtHWETZCYZNFS4jFGSSLpQ=;
        b=Xk8jCsZfjE3hSOJJBk+JsNWYTMoS2W0VR5bEw9EpnXj50vV7ncNXxcAHd4e6Czk/pA
         xC9Mj4j4S2T1ezi+80nwpzdDFtXsON/mNLVWUrmHUuXeMKeRGtiRi+BClgnDWyU80GC8
         YmgpNJO/cd8jVjVA3zJ1DzahjlHgm/dYhBtwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=N/OU4qR+EybjOpV+lvQVqrtHWETZCYZNFS4jFGSSLpQ=;
        b=N4xKTbkinlimRzYGAzGgSDNDgqhBH66Mle2po0bRoGx5GyQMeO62yUfLUFOz2Npbwr
         9LY0bO2EglEkfyNKY0wPdOWIoI8NebrL+cXWjbXYkQ83TFB2eBH3ZPl/gI8PnA80pAg3
         OOh/MdduTeUluLINuFxAomSQhLQ4sxVD8gNch3trzhG1xuRbGx6iXrqkzj3ZewVsWATF
         FJR8PLsvhYotfwGPa1W4GJ4AmU8UC450qDiRmV0EmNBk4mDTrVKh5vg2sp1puytP74h+
         KMMvbmdDBh6PK6x0PYwvmRVGagtKXnQZ87Fqiys9NVe5WbukjyT887n9u8XJttrqp1j3
         ethA==
X-Gm-Message-State: AOAM5302GitlLkrpfJ70i2Yuoj6fatMUbSrDL3FdaEbE0GP+BKtAsSCY
        u5ZrnPOlMmW3pjYcyFOORvq2ler67D562A==
X-Google-Smtp-Source: ABdhPJxY0x/RcTtbTYVhrQSeAWrmMsgWGBfFbrm3RGqlRqeMBlru85S+o647lypAPkmICaaPIkFkaw==
X-Received: by 2002:a05:6512:1195:: with SMTP id g21mr7068362lfr.512.1614995667261;
        Fri, 05 Mar 2021 17:54:27 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q16sm508211lfu.153.2021.03.05.17.54.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 17:54:26 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id x4so761140lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:54:26 -0800 (PST)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr3181022lfb.421.1614995665799;
 Fri, 05 Mar 2021 17:54:25 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Mar 2021 17:54:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whH-stL2zLCf02HZaOeQgS4oGa7eEiHeYZGj-orK-PX0g@mail.gmail.com>
Message-ID: <CAHk-=whH-stL2zLCf02HZaOeQgS4oGa7eEiHeYZGj-orK-PX0g@mail.gmail.com>
Subject: Linux 5.12-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so this is a couple of days early, but rc1 had the nasty swapfile
issue, so I'm just accelerating rc2 a bit.

Outside of the swapfile IO offset fix, the only other thing that
stands out is some io_uring thread handling re-organization, which not
only solved a few fundamental issues, but actually made the code
smaller and simpler too.

Other than that it all looks pretty normal: drivers dominate (with
sound being most notable, with the ASoC Intel SOF support being split
up sanely). But there's some btrfs work, kvm, iscsi, etc. A few random
things all over.

Shortlog appended for your viewing pleasure, and I sincerely hope (and
believe) that rc2 is in a lot better shape than rc1 was.

              Linus

---

Aaron Lewis (1):
      selftests: kvm: Mmap the entire vcpu mmap area

Alex Deucher (4):
      drm/amdgpu: Only check for S0ix if AMD_PMC is configured
      drm/amdgpu/pm: make unsupported power profile messages debug
      drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg for disable
      drm/amdgpu: enable BACO runpm by default on sienna cichlid and
navy flounder

Andrea Fagiani (1):
      ALSA: usb-audio: use Corsair Virtuoso mapping for Corsair Virtuoso SE

Andrey Ryabinin (1):
      iommu/amd: Fix sleeping in atomic in increase_address_space()

Andy Shevchenko (1):
      ACPI: bus: Constify is_acpi_node() and friends (part 2)

Arnd Bergmann (1):
      ASoC: SOF: ACPI: avoid reverse module dependency

Asher.Song (1):
      drm/amdgpu:disable VCN for Navi12 SKU

Babu Moger (1):
      KVM: SVM: Clear the CR4 register on reset

Ben Skeggs (1):
      drm/nouveau/fifo/gk104-gp1xx: fix creation of sw class

Bob Pearson (3):
      RDMA/rxe: Fix missed IB reference counting in loopback
      RDMA/rxe: Fix extra deref in rxe_rcv_mcast_pkt()
      RDMA/rxe: Fix errant WARN_ONCE in rxe_completer()

Boris Burkov (1):
      btrfs: fix spurious free_space_tree remount warning

Chen Jun (1):
      ftrace: Have recordmcount use w8 to read relp->r_info in
arm64_is_fake_mcount

Chenyi Qiang (1):
      KVM: Documentation: rectify rst markup in kvm_run->flags

Chris Chiu (1):
      ALSA: hda/realtek: Enable headset mic of Acer SWIFT with ALC256

Chris Leech (2):
      scsi: iscsi: Ensure sysfs attributes are limited to PAGE_SIZE
      scsi: iscsi: Verify lengths on passthrough PDUs

Colin Ian King (2):
      ALSA: ctxfi: cthw20k2: fix mask on conf to allow 4 bits
      drm/amd/display: fix the return of the uninitialized value in ret

Damien Le Moal (1):
      block: revert "block: fix bd_size_lock use"

Dan Carpenter (2):
      btrfs: validate qgroup inherit for SNAP_CREATE_V2 ioctl
      rsxx: Return -EFAULT if copy_to_user() fails

Daniel Lezcano (2):
      powercap/drivers/dtpm: Fix root node initialization
      powercap/drivers/dtpm: Add the experimental label to the option
description

Daniel Wagner (1):
      nvme-hwmon: Return error code when registration fails

David Woodhouse (2):
      KVM: x86/xen: Fix return code when clearing vcpu_info and vcpu_time_i=
nfo
      KVM: x86/xen: Add support for vCPU runstate information

Dmitry Osipenko (1):
      pstore/ram: Rate-limit "uncorrectable error in header" message

Dongli Zhang (1):
      KVM: x86: remove misplaced comment on active_mmu_pages

Eckhart Mohr (1):
      ALSA: hda/realtek: Add quirk for Clevo NH55RZQ

Evan Quan (1):
      drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register address

Filipe Manana (5):
      btrfs: avoid checking for RO block group twice during nocow writeback
      btrfs: fix race between writes to swap files and scrub
      btrfs: fix race between swap file activation and snapshot creation
      btrfs: fix stale data exposure after cloning a hole with NO_HOLES ena=
bled
      btrfs: fix warning when creating a directory with smack enabled

Hui Wang (1):
      ALSA: hda/hdmi: let new platforms assign the pcm slot dynamically

Ira Weiny (7):
      mm/highmem: Lift memcpy_[to|from]_page to core
      mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
      mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page(=
)
      mm/highmem: Add VM_BUG_ON() to mem*_page() calls
      btrfs: fix raid6 qstripe kmap
      btrfs: use memcpy_[to|from]_page() and kmap_local_page()
      btrfs: use copy_highpage() instead of 2 kmaps()

Jan Beulich (2):
      Xen/gnttab: handle p2m update errors on a per-slot basis
      xen-netback: respect gnttab_map_refs()'s return value

Jarkko Sakkinen (2):
      tpm, tpm_tis: Decorate tpm_get_timeouts() with request_locality()
      tpm: Remove unintentional dump_stack() call

Jason Yan (2):
      gcc-plugins: structleak: remove unneeded variable 'ret'
      gcc-plugins: latent_entropy: remove unneeded semicolon

Jean Delvare (1):
      block: Drop leftover references to RQF_SORTED

Jens Axboe (29):
      io-wq: wait for worker startup when forking a new one
      ia64: don't call handle_signal() unless there's actually a signal que=
ued
      swap: fix swapfile read/write offset
      io-wq: have manager wait for all workers to exit
      io-wq: don't ask for a new worker if we're exiting
      io-wq: rename wq->done completion to wq->started
      io-wq: wait for manager exit on wq destroy
      io-wq: fix double put of 'wq' in error path
      io_uring: SQPOLL stop error handling fixes
      io_uring: don't use complete_all() on SQPOLL thread exit
      io-wq: provide an io_wq_put_and_exit() helper
      io_uring: fix race condition in task_work add and clear
      io_uring: remove unused argument 'tsk' from io_req_caches_free()
      io_uring: kill unnecessary REQ_F_WORK_INITIALIZED checks
      io_uring: move cred assignment into io_issue_sqe()
      io_uring: kill unnecessary io_run_ctx_fallback() in io_ring_exit_work=
()
      io_uring: kill io_uring_flush()
      io_uring: ensure that SQPOLL thread is started for exit
      io_uring: ignore double poll add on the same waitqueue head
      io-wq: fix error path leak of buffered write hash map
      io_uring: fix -EAGAIN retry with IOPOLL
      io_uring: ensure that threads freeze on suspend
      io-wq: ensure all pending work is canceled on exit
      kernel: provide create_io_thread() helper
      io_uring: move to using create_io_thread()
      io_uring: don't keep looping for more events if we can't flush overfl=
ow
      io_uring: clear IOCB_WAITQ for non -EIOCBQUEUED return
      io-wq: kill hashed waitqueue before manager exits
      io_uring: make SQPOLL thread parking saner

Johannes Thumshirn (1):
      btrfs: zoned: fix deadlock on log sync

Josef Bacik (2):
      btrfs: tree-checker: do not error out if extent ref hash doesn't matc=
h
      btrfs: avoid double put of block group when emptying cluster

Joseph Qi (1):
      block/bfq: update comments and default value in docs for fifo_expire

Juergen Gross (1):
      xen: fix p2m size in dom0 for disabled memory hotplug case

Julian Braha (1):
      RDMA/rxe: Fix missing kconfig dependency on CRYPTO

Julian Einwag (1):
      nvme-pci: mark Seagate Nytro XM1440 as QUIRK_NO_NS_DESC_LIST.

Kai Huang (1):
      KVM: Documentation: Fix index for KVM_CAP_PPC_DAWR1

Kevin Wang (1):
      drm/amdgpu: fix parameter error of RREG32_PCIE() in amdgpu_regs_pcie

Lee Duncan (1):
      scsi: iscsi: Restrict sessions and handles to admin capabilities

Leon Romanovsky (2):
      RDMA/mlx5: Set correct kernel-doc identifier
      RDMA/uverbs: Fix kernel-doc warning of _uverbs_alloc

Linus Torvalds (1):
      Linux 5.12-rc2

Lu Baolu (1):
      iommu: Don't use lazy flush for untrusted device

Lukasz Majczak (1):
      tpm, tpm_tis: Decorate tpm_tis_gen_interrupt() with request_locality(=
)

Martin George (1):
      nvme-fabrics: fix kato initialization

Max Gurtovoy (1):
      nvmet: model_number must be immutable once set

Maxime Ripard (1):
      dt-bindings: bcm2711-hdmi: Fix broken schema

Michal Kubecek (1):
      dts: drop dangling c6x symlink

Mikulas Patocka (1):
      dm bufio: subtract the number of initial sectors in
dm_bufio_get_device_size

Milan Broz (1):
      dm verity: fix FEC for RS roots unaligned to block size

Naohiro Aota (2):
      btrfs: zoned: use sector_t for zone sectors
      btrfs: zoned: do not account freed region of read-only block
group as zone_unusable

Nicolas MURE (1):
      ALSA: usb-audio: Fix Pioneer DJM devices URB_CONTROL request
direction to set samplerate

Nicolin Chen (1):
      iommu/tegra-smmu: Fix mc errors on tegra124-nyan

Nikolay Borisov (5):
      btrfs: fix race between extent freeing/allocation when using bitmaps
      btrfs: unlock extents in btrfs_zero_range in case of quota
reservation errors
      btrfs: free correct amount of space in
btrfs_delayed_inode_reserve_metadata
      btrfs: export and rename qgroup_reserve_meta
      btrfs: don't flush from btrfs_delayed_inode_reserve_metadata

Paolo Bonzini (3):
      Documentation: kvm: fix messy conversion from .txt to .rst
      KVM: xen: flush deferred static key before checking it
      KVM: x86: allow compiling out the Xen hypercall interface

Pascal Terjan (1):
      nvme-pci: add quirks for Lexar 256GB SSD

Pavel Begunkov (14):
      io_uring: run fallback on cancellation
      io_uring: warn on not destroyed io-wq
      io_uring: destroy io-wq on exec
      io_uring: fix __tctx_task_work() ctx race
      io_uring: replace cmpxchg in fallback with xchg
      io_uring: kill sqo_dead and sqo submission halting
      io_uring: remove sqo_task
      io_uring: choose right tctx->io_wq for try cancel
      io_uring: inline io_req_clean_work()
      io_uring: inline __io_queue_async_work()
      io_uring: remove extra in_idle wake up
      io_uring: cancel-match based on flags
      io_uring: reliably cancel linked timeouts
      io_uring: don't restrict issue_flags for io_openat

Pierre-Louis Bossart (8):
      ALSA: hda: fix kernel-doc warnings
      ALSA: hda: intel-nhlt: verify config type
      ASoC: soc-acpi: allow for partial match in parent name
      ASoC: SOF: pci: split PCI into different drivers
      ASoC: SOF: pci: move DSP_CONFIG use to platform-specific drivers
      ASoC: SOF: Intel: SoundWire: simplify Kconfig
      ALSA: hda: move Intel SoundWire ACPI scan to dedicated module
      ALSA: hda: intel-sdw-acpi: add missing include files

Qu Wenruo (3):
      btrfs: make btrfs_submit_compressed_read() subpage compatible
      btrfs: make check_compressed_csum() to be subpage compatible
      btrfs: subpage: fix the false data csum mismatch error

Rafael J. Wysocki (1):
      PM: runtime: Update device status before letting suppliers suspend

Randy Dunlap (1):
      btrfs: ref-verify: use 'inline void' keyword ordering

Rob Herring (1):
      dt-bindings: media: Use graph and video-interfaces schemas, round 2

Rolf Eike Beer (1):
      tracing: Fix help text of TRACEPOINT_BENCHMARK in Kconfig

Saeed Mahameed (1):
      RDMA/cm: Fix IRQ restore in ib_send_cm_sidr_rep

Sean Christopherson (1):
      KVM: x86/mmu: Set SPTE_AD_WRPROT_ONLY_MASK if and only if PML is enab=
led

Steven Rostedt (VMware) (4):
      ring-buffer: Force before_stamp and write_stamp to be different on di=
scard
      ring-buffer: Add a little more information and a WARN when time
stamp going backwards is detected
      tracing: Skip selftests if tracing is disabled
      tracing: Fix comment about the trace_event_call flags

Takashi Iwai (4):
      ALSA: usb-audio: Don't abort even if the clock rate differs
      ALSA: usb-audio: Drop bogus dB range in too low level
      ALSA: usb-audio: Allow modifying parameters with succeeding
hw_params calls
      ALSA: hda/realtek: Apply dual codec quirks for MSI Godlike X570 board

Tetsuo Handa (1):
      pstore: Fix warning in pstore_kill_sb()

Tian Tao (1):
      rsxx: remove unused including <linux/version.h>

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leak in __create_synth_event()

Wanpeng Li (1):
      KVM: x86: hyper-v: Fix Hyper-V context null-ptr-deref

Wei Yongjun (1):
      ALSA: n64: Fix return value check in n64audio_probe()

Werner Sembach (1):
      ALSA: hda/realtek: Add quirk for Intel NUC 10

Yordan Karadzhov (VMware) (1):
      tracing: Remove duplicate declaration from trace.h

YueHaibing (1):
      IB/mlx5: Add missing error code

Zenghui Yu (1):
      iommu/vt-d: Fix status code for Allocate/Free PASID command

Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi (1):
      nvme-pci: mark Kingston SKC2000 as not supporting the deepest power s=
tate
