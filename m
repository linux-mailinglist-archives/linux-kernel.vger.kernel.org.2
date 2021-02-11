Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A85319228
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhBKSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:23:01 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:43822 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhBKSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:11:43 -0500
Date:   Thu, 11 Feb 2021 18:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613067047;
        bh=7i01fND7pW2lSH5IlJ0QOSKf3FNxvz8ihD0jasU/gcg=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=SQvY9u3mrXZSTQ7B8Nv24Rbx1zpNKKmp9CXMM8eV360ogmHfoUv16uspRvSmj6zIj
         3wr75g7cvGjD0yBqev5sLwkh9kr5/nAPXIPtz/budBSIsT0EZEweozv8z1yEcSXJUV
         j2Ouq+lWjY9MUYBOsKo3ISyem78mRkrKuhk2r2tE=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [RFC PATCH] docs: Warn when auto xref to document fails
Message-ID: <20210211181017.38016-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print warning when automarkup fails to cross-reference to another
document, so that it doesn't fail silently.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---

This patch is marked as RFC because it causes a lot of new warnings current=
ly.
So the patch should only be applied after we reduce this to zero. The warni=
ngs
are listed at the end.

From this list of warnings, a few are paths that are wrong either due to no=
t
starting with "Documentation/" or because the document was already converte=
d
from .txt to .rst but the path wasn't updated. These should be fixed.

One question that I have about this though, is: would it be better to have =
a
single commit fixing all of those documentation-wide or have a separate com=
mit
for the docs of each subsystem sent to that subsystem's maintainer?

In any case, a lot of the warnings come from .txt files that aren't part of=
 the
documentation, and sometimes are only used as examples. This confirms the
problem of trying to cross-reference to .txt files, as already discussed in=
 [1].

Looking for which .rst files include .txt files, I ended with the following
list:

staging/index.rst:25:.. include:: ../atomic_t.txt
staging/index.rst:39:.. include:: ../atomic_bitops.txt
staging/index.rst:53:.. include:: ../memory-barriers.txt
admin-guide/devices.rst:60:.. include:: devices.txt
admin-guide/kernel-parameters.rst:208:.. include:: kernel-parameters.txt
admin-guide/aoe/examples.rst:4: .. include:: udev.txt
admin-guide/kdump/kdump.rst:544:.. include:: gdbmacros.txt
translations/ko_KR/index.rst:22:.. include:: ./memory-barriers.txt
netlabel/draft_ietf.rst:4: .. include:: draft-ietf-cipso-ipsecurity-01.txt
sparc/oradax/oracle-dax.rst:444: .. include:: dax-hv-api.txt

Since it is a quite short list, it seems that having a .txt file inside a .=
rst
is the exception rather than the norm. So, in order to continue to have lin=
ks
to, for example, kernel-parameters.txt pointing to kernel-parameters.rst wi=
thout
changing the documentation, I propose for us to have a mapping inside
automarkup.py. This would map the .txt to the .rst files and link to them
instead. If the .txt isn't present in the mapping, it would simply be ignor=
ed,
not even a warning would be printed.

With this mapping, the links to these special .txt documents would continue=
 to
work without us trying to link to any other .txt file, which is great since=
 most
of the time it doesn't make sense. And since these .txt files are there for
established purposes, I don't think new ones will be created, so there won'=
t be
a burden in maintaining this mapping updated.

Thoughts?

Thanks,
N=C3=ADcolas

[1] https://lore.kernel.org/linux-doc/C91700MG55NC.EQS8AQE2J1DB@ArchWay/

Warnings generated:

WARNING: PCI/pci-error-recovery: Failed to cross-reference to document powe=
rpc/eeh-pci-error-recovery.txt
WARNING: RCU/Design/Data-Structures/Data-Structures: Failed to cross-refere=
nce to document timers/NO_HZ.txt
WARNING: RCU/rcu: Failed to cross-reference to document Documentation/RCU/R=
TFP.txt
WARNING: RCU/rcu: Failed to cross-reference to document Documentation/RCU/R=
TFP.txt
WARNING: RCU/rcu_dereference: Failed to cross-reference to document Documen=
tation/memory-barriers.txt
WARNING: RCU/torture: Failed to cross-reference to document testid.txt
WARNING: admin-guide/abi-stable: Failed to cross-reference to document spkg=
uide.txt
WARNING: admin-guide/abi-testing: Failed to cross-reference to document Doc=
umentation/devicetree/bindings/mfd/bd9571mwv.txt
WARNING: admin-guide/abi-testing: Failed to cross-reference to document Doc=
umentation/devicetree/bindings/leds/leds-trigger-pattern.txt
WARNING: admin-guide/abi-testing: Failed to cross-reference to document doc=
s/specs/fw_cfg.txt
WARNING: admin-guide/aoe/aoe: Failed to cross-reference to document com/doc=
uments/AoEr11.txt
WARNING: admin-guide/aoe/aoe: Failed to cross-reference to document udev.tx=
t
WARNING: admin-guide/bug-hunting: Failed to cross-reference to document Doc=
umentation/admin-guide/kdump/gdbmacros.txt
WARNING: admin-guide/cputopology: Failed to cross-reference to document cpu=
-hotplug.txt
WARNING: admin-guide/cputopology: Failed to cross-reference to document cpu=
-hotplug.txt
WARNING: admin-guide/ext4: Failed to cross-reference to document Documentat=
ion/filesystems/dax.txt
WARNING: admin-guide/hw-vuln/l1tf: Failed to cross-reference to document or=
g/doc/Documentation/admin-guide/cgroup-v1/cpusets.rst
WARNING: admin-guide/hw-vuln/l1tf: Failed to cross-reference to document or=
g/doc/Documentation/core-api/irq/irq-affinity.rst
WARNING: admin-guide/java: Failed to cross-reference to document binfmt_mis=
c.txt
WARNING: admin-guide/reporting-issues: Failed to cross-reference to documen=
t admin-guide/bug-hunting.rst
WARNING: admin-guide/sysctl/fs: Failed to cross-reference to document intro=
.rst
WARNING: admin-guide/unicode: Failed to cross-reference to document org/doc=
s/unicode/admin-guide/unicode.rst
WARNING: arm/keystone/knav-qmss: Failed to cross-reference to document Docu=
mentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
WARNING: arm/keystone/overview: Failed to cross-reference to document Docum=
entation/devicetree/bindings/arm/keystone/keystone.txt
WARNING: arm/samsung-s3c24xx/overview: Failed to cross-reference to documen=
t EB2410ITX.txt
WARNING: arm/samsung-s3c24xx/overview: Failed to cross-reference to documen=
t GPIO.txt
WARNING: arm/samsung-s3c24xx/overview: Failed to cross-reference to documen=
t Suspend.txt
WARNING: core-api/circular-buffers: Failed to cross-reference to document D=
ocumentation/memory-barriers.txt
WARNING: core-api/debugging-via-ohci1394: Failed to cross-reference to docu=
ment README.txt
WARNING: core-api/dma-api-howto: Failed to cross-reference to document DMA-=
API.txt
WARNING: core-api/kernel-api: Failed to cross-reference to document c.txt
WARNING: core-api/kernel-api: Failed to cross-reference to document Documen=
tation/core-api/atomic_ops.rst
WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to document=
 tools/memory-model/Documentation/explanation.txt
WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to document=
 memory-barriers.txt
WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to document=
 atomic_t.txt
WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to document=
 memory-barriers.txt
WARNING: dev-tools/coccinelle: Failed to cross-reference to document com/co=
ccinelle/coccinelle/blob/master/install.txt
WARNING: devicetree/bindings/submitting-patches: Failed to cross-reference =
to document bindings/ABI.txt
WARNING: devicetree/bindings/writing-bindings: Failed to cross-reference to=
 document property-units.txt
WARNING: driver-api/console: Failed to cross-reference to document fbcon.tx=
t
WARNING: driver-api/fpga/fpga-region: Failed to cross-reference to document=
 ../devicetree/bindings/fpga/fpga-region.txt
WARNING: driver-api/gpio/board: Failed to cross-reference to document gpio-=
legacy.txt
WARNING: driver-api/gpio/consumer: Failed to cross-reference to document gp=
io-legacy.txt
WARNING: driver-api/gpio/index: Failed to cross-reference to document Docum=
entation/devicetree/bindings/gpio/gpio.txt
WARNING: driver-api/gpio/index: Failed to cross-reference to document Docum=
entation/devicetree/bindings/gpio/gpio.txt
WARNING: driver-api/gpio/intro: Failed to cross-reference to document gpio-=
legacy.txt
WARNING: driver-api/gpio/intro: Failed to cross-reference to document gpio-=
legacy.txt
WARNING: driver-api/gpio/intro: Failed to cross-reference to document gpio-=
legacy.txt
WARNING: driver-api/gpio/legacy: Failed to cross-reference to document Docu=
mentation/devicetree/bindings/gpio/gpio.txt
WARNING: driver-api/isapnp: Failed to cross-reference to document pnp.txt
WARNING: driver-api/media/drivers/cx88-devel: Failed to cross-reference to =
document edu/circuit_archive/text/ir_decode.txt
WARNING: driver-api/media/drivers/dvb-usb: Failed to cross-reference to doc=
ument vp7041.txt
WARNING: driver-api/miscellaneous: Failed to cross-reference to document Do=
cumentation/devicetree/bindings/serial/rs485.txt
WARNING: driver-api/nvmem: Failed to cross-reference to document Documentat=
ion/devicetree/bindings/nvmem/nvmem.txt
WARNING: driver-api/phy/phy: Failed to cross-reference to document Document=
ation/devicetree/bindings/phy/phy-bindings.txt
WARNING: driver-api/pinctl: Failed to cross-reference to document Documenta=
tion/devicetree/bindings/gpio/gpio.txt
WARNING: driver-api/rfkill: Failed to cross-reference to document admin-gui=
de/kernel-parameters.rst
WARNING: driver-api/serial/serial-rs485: Failed to cross-reference to docum=
ent Documentation/devicetree/bindings/serial/rs485.txt
WARNING: fb/cmap_xfbdev: Failed to cross-reference to document rgb.txt
WARNING: fb/framebuffer: Failed to cross-reference to document xc/programs/=
Xserver/hw/xfree86/doc/modeDB.txt
WARNING: filesystems/ext2: Failed to cross-reference to document Documentat=
ion/filesystems/dax.txt
WARNING: filesystems/nfs/rpc-server-gss: Failed to cross-reference to docum=
ent org/rfc/rfc2203.txt
WARNING: filesystems/nfs/rpc-server-gss: Failed to cross-reference to docum=
ent org/rfc/rfc5403.txt
WARNING: filesystems/nfs/rpc-server-gss: Failed to cross-reference to docum=
ent org/rfc/rfc7861.txt
WARNING: filesystems/ramfs-rootfs-initramfs: Failed to cross-reference to d=
ocument buffer-format.txt
WARNING: filesystems/sysfs: Failed to cross-reference to document /fuse.txt
WARNING: filesystems/ubifs-authentication: Failed to cross-reference to doc=
ument org/doc/Documentation/device-mapper/dm-integrity.rst
WARNING: filesystems/ubifs-authentication: Failed to cross-reference to doc=
ument org/doc/Documentation/device-mapper/verity.rst
WARNING: filesystems/vfat: Failed to cross-reference to document longfilena=
me.txt
WARNING: filesystems/vfat: Failed to cross-reference to document longfile.t=
xt
WARNING: filesystems/vfat: Failed to cross-reference to document longfile.t=
xt
WARNING: filesystems/vfat: Failed to cross-reference to document 1.txt
WARNING: firmware-guide/acpi/dsd/graph: Failed to cross-reference to docume=
nt Documentation/devicetree/bindings/graph.txt
WARNING: firmware-guide/acpi/dsd/leds: Failed to cross-reference to documen=
t Documentation/devicetree/bindings/leds/common.txt
WARNING: firmware-guide/acpi/dsd/leds: Failed to cross-reference to documen=
t Documentation/devicetree/bindings/media/video-interfaces.txt
WARNING: firmware-guide/acpi/gpio-properties: Failed to cross-reference to =
document Documentation/devicetree/bindings/gpio/gpio.txt
WARNING: firmware-guide/acpi/video_extension: Failed to cross-reference to =
document admin-guide/kernel-parameters.rst
WARNING: gpu/drm-kms-helpers: Failed to cross-reference to document Documen=
tation/devicetree/bindings/graph.txt
WARNING: gpu/drm-kms-helpers: Failed to cross-reference to document Documen=
tation/devicetree/bindings/graph.txt
WARNING: hwmon/g762: Failed to cross-reference to document Documentation/de=
vicetree/bindings/hwmon/g762.txt
WARNING: hwmon/ina2xx: Failed to cross-reference to document Documentation/=
devicetree/bindings/hwmon/ina2xx.txt
WARNING: hwmon/scpi-hwmon: Failed to cross-reference to document scpi.txt
WARNING: hwmon/vexpress: Failed to cross-reference to document Documentatio=
n/devicetree/bindings/hwmon/vexpress.txt
WARNING: infiniband/ipoib: Failed to cross-reference to document org/rfc/rf=
c4391.txt
WARNING: infiniband/ipoib: Failed to cross-reference to document org/rfc/rf=
c4392.txt
WARNING: infiniband/ipoib: Failed to cross-reference to document org/rfc/rf=
c4755.txt
WARNING: input/ff: Failed to cross-reference to document joystick.txt
WARNING: input/ff: Failed to cross-reference to document joystick.txt
WARNING: leds/leds-class-multicolor: Failed to cross-reference to document =
led-class.rst
WARNING: locking/futex-requeue-pi: Failed to cross-reference to document rt=
-mutex-desgin.txt
WARNING: locking/spinlocks: Failed to cross-reference to document Documenta=
tion/memory-barriers.txt
WARNING: misc-devices/xilinx_sdfec: Failed to cross-reference to document s=
d-fec.txt
WARNING: netlabel/cipso_ipv4: Failed to cross-reference to document draft-i=
etf-cipso-ipsecurity-01.txt
WARNING: networking/device_drivers/ethernet/altera/altera_tse: Failed to cr=
oss-reference to document org/rfc/rfc2863.txt
WARNING: networking/device_drivers/ethernet/altera/altera_tse: Failed to cr=
oss-reference to document org/rfc/rfc2819.txt
WARNING: networking/device_drivers/ethernet/cirrus/cs89x0: Failed to cross-=
reference to document readme.txt
WARNING: networking/device_drivers/ethernet/freescale/dpaa2/overview: Faile=
d to cross-reference to document qoriq-mc.txt
WARNING: networking/device_drivers/ethernet/intel/e100: Failed to cross-ref=
erence to document /Documentation/networking/bonding.rst
WARNING: networking/device_drivers/ethernet/intel/e1000: Failed to cross-re=
ference to document networking/ip-sysctl.txt
WARNING: networking/device_drivers/ethernet/intel/ixgb: Failed to cross-ref=
erence to document /Documentation/networking/bonding.rst
WARNING: networking/device_drivers/ethernet/intel/ixgb: Failed to cross-ref=
erence to document networking/ip-sysctl.txt
WARNING: networking/filter: Failed to cross-reference to document test_in.t=
xt
WARNING: networking/filter: Failed to cross-reference to document test_out.=
txt
WARNING: networking/ip-sysctl: Failed to cross-reference to document org/id=
/draft-nishida-tsvwg-sctp-failover-05.txt
WARNING: networking/kapi: Failed to cross-reference to document phy_driver.=
txt
WARNING: networking/mac80211-injection: Failed to cross-reference to docume=
nt /Documentation/networking/radiotap-headers.rst
WARNING: networking/sctp: Failed to cross-reference to document org/rfc/rfc=
2960.txt
WARNING: networking/timestamping: Failed to cross-reference to document Doc=
umentation/devicetree/bindings/ptp/timestamper.txt
WARNING: networking/udplite: Failed to cross-reference to document uk/users=
/gerrit/udp-lite/files/UDP-Lite-HOWTO.txt
WARNING: networking/udplite: Failed to cross-reference to document org/rfc/=
rfc3828.txt
WARNING: power/power_supply_class: Failed to cross-reference to document Do=
cumentation/devicetree/bindings/power/supply/battery.txt
WARNING: process/8.Conclusion: Failed to cross-reference to document proces=
s/howto.rst
WARNING: process/8.Conclusion: Failed to cross-reference to document proces=
s/submitting-patches.rst
WARNING: process/8.Conclusion: Failed to cross-reference to document proces=
s/submitting-drivers.rst
WARNING: process/coding-style: Failed to cross-reference to document proces=
s/coding-style.rst
WARNING: process/howto: Failed to cross-reference to document akpm/stuff/tp=
p.txt
WARNING: process/howto: Failed to cross-reference to document akpm/stuff/tp=
p.txt
WARNING: process/management-style: Failed to cross-reference to document pr=
ocess/coding-style.rst
WARNING: process/submitting-patches: Failed to cross-reference to document =
akpm/stuff/tpp.txt
WARNING: scheduler/sched-bwc: Failed to cross-reference to document Documen=
tation/admin-guide/cgroupv2.rst
WARNING: scheduler/sched-capacity: Failed to cross-reference to document Do=
cumentation/devicetree/bindings/arm/cpu-capacity.txt
WARNING: scsi/scsi-generic: Failed to cross-reference to document cz/sg/p/s=
csi-generic_long.txt
WARNING: scsi/scsi-generic: Failed to cross-reference to document net/sg/p/=
original/SCSI-Programming-HOWTO.txt
WARNING: security/tpm/xen-tpmfront: Failed to cross-reference to document d=
ocs/misc/vtpm.txt
WARNING: sound/alsa-configuration: Failed to cross-reference to document po=
wersave.rst
WARNING: sound/alsa-configuration: Failed to cross-reference to document hd=
spm.rst
WARNING: sound/alsa-configuration: Failed to cross-reference to document MI=
XART.txt
WARNING: sound/cards/bt87x: Failed to cross-reference to document btaudio.t=
xt
WARNING: sound/designs/procfile: Failed to cross-reference to document OSS-=
Emulation.txt
WARNING: sound/hd-audio/controls: Failed to cross-reference to document HD-=
Audio.txt
WARNING: sound/soc/platform: Failed to cross-reference to document DPCM.txt
WARNING: sparc/oradax/oracle-dax: Failed to cross-reference to document dax=
-hv-api.txt
WARNING: sparc/oradax/oracle-dax: Failed to cross-reference to document dax=
-hv-api.txt
WARNING: trace/coresight/coresight: Failed to cross-reference to document D=
ocumentation/devicetree/bindings/arm/coresight.txt
WARNING: trace/coresight/coresight-cpu-debug: Failed to cross-reference to =
document Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
WARNING: trace/ftrace: Failed to cross-reference to document uprobetrace.tx=
t
WARNING: trace/kprobes: Failed to cross-reference to document tools/perf/Do=
cumentation/perf-probe.txt
WARNING: translations/it_IT/process/1.Intro: Failed to cross-reference to d=
ocument Intro.rst
WARNING: translations/it_IT/process/2.Process: Failed to cross-reference to=
 document Process.rst
WARNING: translations/it_IT/process/3.Early-stage: Failed to cross-referenc=
e to document Early-stage.rst
WARNING: translations/it_IT/process/4.Coding: Failed to cross-reference to =
document Coding.rst
WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference to=
 document Posting.rst
WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference to=
 document translations/it_IT/process/submitting-patches.rst
WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference to=
 document translations/it_IT/process/submitting-drivers.rst
WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference to=
 document translations/it_IT/process/submit-checklist.rst
WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference to=
 document translations/it_IT/process/submitting-patches.rst
WARNING: translations/it_IT/process/6.Followthrough: Failed to cross-refere=
nce to document Followthrough.rst
WARNING: translations/it_IT/process/7.AdvancedTopics: Failed to cross-refer=
ence to document AdvancedTopics.rst
WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-reference=
 to document Conclusion.rst
WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-reference=
 to document process/howto.rst
WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-reference=
 to document process/submitting-patches.rst
WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-reference=
 to document process/submitting-drivers.rst
WARNING: translations/it_IT/process/coding-style: Failed to cross-reference=
 to document process/coding-style.rst
WARNING: translations/it_IT/process/howto: Failed to cross-reference to doc=
ument akpm/stuff/tpp.txt
WARNING: translations/it_IT/process/howto: Failed to cross-reference to doc=
ument admin-guide/reporting-bugs.rst
WARNING: translations/it_IT/process/howto: Failed to cross-reference to doc=
ument akpm/stuff/tpp.txt
WARNING: translations/it_IT/process/management-style: Failed to cross-refer=
ence to document translations/it_IT/process/coding-style.rst
WARNING: translations/it_IT/process/submitting-patches: Failed to cross-ref=
erence to document akpm/stuff/tpp.txt
WARNING: translations/ja_JP/howto: Failed to cross-reference to document ak=
pm/stuff/tpp.txt
WARNING: translations/ja_JP/howto: Failed to cross-reference to document ad=
min-guide/reporting-bugs.rst
WARNING: translations/ja_JP/howto: Failed to cross-reference to document ak=
pm/stuff/tpp.txt
WARNING: translations/ko_KR/howto: Failed to cross-reference to document ak=
pm/stuff/tpp.txt
WARNING: translations/ko_KR/howto: Failed to cross-reference to document ak=
pm/stuff/tpp.txt
WARNING: translations/zh_CN/filesystems/tmpfs: Failed to cross-reference to=
 document =E8=AF=B7=E5=8F=82=E8=A7=81Documentation/admin-guide/cgroup-v1/cp=
usets.rst
WARNING: translations/zh_CN/iio/iio_configfs: Failed to cross-reference to =
document =E8=AF=B7=E6=9F=A5=E9=98=85Documentation/filesystems/configfs.rst
WARNING: translations/zh_CN/process/1.Intro: Failed to cross-reference to d=
ocument Intro.rst
WARNING: translations/zh_CN/process/2.Process: Failed to cross-reference to=
 document Process.rst
WARNING: translations/zh_CN/process/3.Early-stage: Failed to cross-referenc=
e to document Early-stage.rst
WARNING: translations/zh_CN/process/4.Coding: Failed to cross-reference to =
document Coding.rst
WARNING: translations/zh_CN/process/5.Posting: Failed to cross-reference to=
 document Posting.rst
WARNING: translations/zh_CN/process/6.Followthrough: Failed to cross-refere=
nce to document Followthrough.rst
WARNING: translations/zh_CN/process/7.AdvancedTopics: Failed to cross-refer=
ence to document AdvancedTopics.rst
WARNING: translations/zh_CN/process/8.Conclusion: Failed to cross-reference=
 to document Conclusion.rst
WARNING: translations/zh_CN/process/8.Conclusion: Failed to cross-reference=
 to document process/submitting-drivers.rst
WARNING: translations/zh_CN/process/coding-style: Failed to cross-reference=
 to document process/coding-style.rst
WARNING: translations/zh_CN/process/howto: Failed to cross-reference to doc=
ument akpm/stuff/tpp.txt
WARNING: translations/zh_CN/process/howto: Failed to cross-reference to doc=
ument admin-guide/reporting-bugs.rst
WARNING: translations/zh_CN/process/howto: Failed to cross-reference to doc=
ument akpm/stuff/tpp.txt
WARNING: translations/zh_CN/process/management-style: Failed to cross-refer=
ence to document process/coding-style.rst
WARNING: translations/zh_CN/process/stable-kernel-rules: Failed to cross-re=
ference to document =E5=BF=85=E9=A1=BB=E9=81=B5=E5=BE=AADocumentation/trans=
lations/zh_CN/process/submitting-patches.rst
WARNING: translations/zh_CN/process/submitting-patches: Failed to cross-ref=
erence to document akpm/stuff/tpp.txt
WARNING: userspace-api/media/v4l/ext-ctrls-camera: Failed to cross-referenc=
e to document video-interfaces.txt
WARNING: virt/kvm/vcpu-requests: Failed to cross-reference to document Docu=
mentation/core-api/atomic_ops.rst
WARNING: virt/kvm/vcpu-requests: Failed to cross-reference to document Docu=
mentation/memory-barriers.txt
WARNING: vm/hwpoison: Failed to cross-reference to document sysctl.txt
WARNING: w1/masters/omap-hdq: Failed to cross-reference to document Documen=
tation/devicetree/bindings/w1/omap-hdq.txt
WARNING: w1/masters/w1-gpio: Failed to cross-reference to document Document=
ation/devicetree/bindings/w1/w1-gpio.txt
WARNING: watchdog/hpwdt: Failed to cross-reference to document Documentatio=
n/IPMI.txt
WARNING: x86/intel_txt: Failed to cross-reference to document SINIT-guide.t=
xt
WARNING: x86/orc-unwinder: Failed to cross-reference to document tools/objt=
ool/Documentation/stack-validation.txt
WARNING: x86/pti: Failed to cross-reference to document kernel-parameters.t=
xt


 Documentation/sphinx/automarkup.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index acf5473002f3..5a03c5080ebe 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -7,6 +7,7 @@
 from docutils import nodes
 import sphinx
 from sphinx import addnodes
+from sphinx.util import logging
 if sphinx.version_info[0] < 2 or \
    sphinx.version_info[0] =3D=3D 2 and sphinx.version_info[1] < 1:
     from sphinx.environment import NoUri
@@ -74,6 +75,8 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcntl'=
, 'mmap',
=20
 c_namespace =3D ''
=20
+logger =3D None
+
 def markup_refs(docname, app, node):
     t =3D node.astext()
     done =3D 0
@@ -257,6 +260,8 @@ def markup_doc_ref(docname, app, match):
     if xref:
         return xref
     else:
+        logger.warning('{}: Failed to cross-reference to document '
+                       '{}'.format(docname, match.group(0)))
         return nodes.Text(match.group(0))
=20
 def get_c_namespace(app, docname):
@@ -270,7 +275,9 @@ def get_c_namespace(app, docname):
=20
 def auto_markup(app, doctree, name):
     global c_namespace
+    global logger
     c_namespace =3D get_c_namespace(app, name)
+    logger =3D logging.getLogger(__name__)
     #
     # This loop could eventually be improved on.  Someday maybe we
     # want a proper tree traversal with a lot of awareness of which
--=20
2.30.1


