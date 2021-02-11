Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF83193E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBKUFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230290AbhBKT6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:58:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C873D64E4A;
        Thu, 11 Feb 2021 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073483;
        bh=gdJkB01ryn3ahiqARBQ4twOtFVxB41q70nst3iPWaqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iuqqwQ/AHnw2w2qs6eS2AWS6eSc6fpTzXYAJReJ8yQVox+C7xaSxmZcbOHQCZ0JeZ
         AX3KavMRHHGkOJfes3WfDVeP1dA4M67E7+6w6cTBjpkLfw+WP77m3if/sOy7leLbdS
         tkjC4xcShn/GNm2iVsIOKVYQtu6CUb1NUVMx9c1GPoD1hYSGuqw/GkUhAPfrE8NfGP
         H8E1MAXZSLZNmwNdK1UeY5ZyOyIYS5pxSWTMKMvkEI6h2JAXLYCLG6kF9EqnStpOn7
         /MBV4c5Vu56C9V4XUZSb9I6w5oPWS3eKUEn0pnHJlKpOfyl52yQvK14hgHd1QpVpma
         gJ0jRaDIMo9ZA==
Date:   Thu, 11 Feb 2021 20:57:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [RFC PATCH] docs: Warn when auto xref to document fails
Message-ID: <20210211205759.2d61d16b@coco.lan>
In-Reply-To: <20210211181017.38016-1-nfraprado@protonmail.com>
References: <20210211181017.38016-1-nfraprado@protonmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 11 Feb 2021 18:10:36 +0000
N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:

> Print warning when automarkup fails to cross-reference to another
> document, so that it doesn't fail silently.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> ---
>=20
> This patch is marked as RFC because it causes a lot of new warnings curre=
ntly.
> So the patch should only be applied after we reduce this to zero. The war=
nings
> are listed at the end.

Maybe it could be enabled if W=3D2?

>=20
> From this list of warnings, a few are paths that are wrong either due to =
not
> starting with "Documentation/" or because the document was already conver=
ted
> from .txt to .rst but the path wasn't updated. These should be fixed.
>=20
> One question that I have about this though, is: would it be better to hav=
e a
> single commit fixing all of those documentation-wide or have a separate c=
ommit
> for the docs of each subsystem sent to that subsystem's maintainer?
>=20
> In any case, a lot of the warnings come from .txt files that aren't part =
of the
> documentation, and sometimes are only used as examples. This confirms the
> problem of trying to cross-reference to .txt files, as already discussed =
in [1].
>=20
> Looking for which .rst files include .txt files, I ended with the followi=
ng
> list:
>=20
> staging/index.rst:25:.. include:: ../atomic_t.txt
> staging/index.rst:39:.. include:: ../atomic_bitops.txt
> staging/index.rst:53:.. include:: ../memory-barriers.txt
> admin-guide/devices.rst:60:.. include:: devices.txt
> admin-guide/kernel-parameters.rst:208:.. include:: kernel-parameters.txt
> admin-guide/aoe/examples.rst:4: .. include:: udev.txt
> admin-guide/kdump/kdump.rst:544:.. include:: gdbmacros.txt
> translations/ko_KR/index.rst:22:.. include:: ./memory-barriers.txt
> netlabel/draft_ietf.rst:4: .. include:: draft-ietf-cipso-ipsecurity-01.txt
> sparc/oradax/oracle-dax.rst:444: .. include:: dax-hv-api.txt
>=20
> Since it is a quite short list, it seems that having a .txt file inside a=
 .rst
> is the exception rather than the norm. So, in order to continue to have l=
inks
> to, for example, kernel-parameters.txt pointing to kernel-parameters.rst =
without
> changing the documentation, I propose for us to have a mapping inside
> automarkup.py. This would map the .txt to the .rst files and link to them
> instead. If the .txt isn't present in the mapping, it would simply be ign=
ored,
> not even a warning would be printed.
>=20
> With this mapping, the links to these special .txt documents would contin=
ue to
> work without us trying to link to any other .txt file, which is great sin=
ce most
> of the time it doesn't make sense. And since these .txt files are there f=
or
> established purposes, I don't think new ones will be created, so there wo=
n't be
> a burden in maintaining this mapping updated.
>=20
> Thoughts?
>=20
> Thanks,
> N=C3=ADcolas
>=20
> [1] https://lore.kernel.org/linux-doc/C91700MG55NC.EQS8AQE2J1DB@ArchWay/
>=20
> Warnings generated:
>=20
> WARNING: PCI/pci-error-recovery: Failed to cross-reference to document po=
werpc/eeh-pci-error-recovery.txt
> WARNING: RCU/Design/Data-Structures/Data-Structures: Failed to cross-refe=
rence to document timers/NO_HZ.txt
> WARNING: RCU/rcu: Failed to cross-reference to document Documentation/RCU=
/RTFP.txt
> WARNING: RCU/rcu: Failed to cross-reference to document Documentation/RCU=
/RTFP.txt
> WARNING: RCU/rcu_dereference: Failed to cross-reference to document Docum=
entation/memory-barriers.txt
> WARNING: RCU/torture: Failed to cross-reference to document testid.txt
> WARNING: admin-guide/abi-stable: Failed to cross-reference to document sp=
kguide.txt
> WARNING: admin-guide/abi-testing: Failed to cross-reference to document D=
ocumentation/devicetree/bindings/mfd/bd9571mwv.txt
> WARNING: admin-guide/abi-testing: Failed to cross-reference to document D=
ocumentation/devicetree/bindings/leds/leds-trigger-pattern.txt
> WARNING: admin-guide/abi-testing: Failed to cross-reference to document d=
ocs/specs/fw_cfg.txt
> WARNING: admin-guide/aoe/aoe: Failed to cross-reference to document com/d=
ocuments/AoEr11.txt
> WARNING: admin-guide/aoe/aoe: Failed to cross-reference to document udev.=
txt
> WARNING: admin-guide/bug-hunting: Failed to cross-reference to document D=
ocumentation/admin-guide/kdump/gdbmacros.txt
> WARNING: admin-guide/cputopology: Failed to cross-reference to document c=
pu-hotplug.txt
> WARNING: admin-guide/cputopology: Failed to cross-reference to document c=
pu-hotplug.txt
> WARNING: admin-guide/ext4: Failed to cross-reference to document Document=
ation/filesystems/dax.txt
> WARNING: admin-guide/hw-vuln/l1tf: Failed to cross-reference to document =
org/doc/Documentation/admin-guide/cgroup-v1/cpusets.rst
> WARNING: admin-guide/hw-vuln/l1tf: Failed to cross-reference to document =
org/doc/Documentation/core-api/irq/irq-affinity.rst
> WARNING: admin-guide/java: Failed to cross-reference to document binfmt_m=
isc.txt
> WARNING: admin-guide/reporting-issues: Failed to cross-reference to docum=
ent admin-guide/bug-hunting.rst
> WARNING: admin-guide/sysctl/fs: Failed to cross-reference to document int=
ro.rst
> WARNING: admin-guide/unicode: Failed to cross-reference to document org/d=
ocs/unicode/admin-guide/unicode.rst
> WARNING: arm/keystone/knav-qmss: Failed to cross-reference to document Do=
cumentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
> WARNING: arm/keystone/overview: Failed to cross-reference to document Doc=
umentation/devicetree/bindings/arm/keystone/keystone.txt
> WARNING: arm/samsung-s3c24xx/overview: Failed to cross-reference to docum=
ent EB2410ITX.txt
> WARNING: arm/samsung-s3c24xx/overview: Failed to cross-reference to docum=
ent GPIO.txt
> WARNING: arm/samsung-s3c24xx/overview: Failed to cross-reference to docum=
ent Suspend.txt
> WARNING: core-api/circular-buffers: Failed to cross-reference to document=
 Documentation/memory-barriers.txt
> WARNING: core-api/debugging-via-ohci1394: Failed to cross-reference to do=
cument README.txt
> WARNING: core-api/dma-api-howto: Failed to cross-reference to document DM=
A-API.txt
> WARNING: core-api/kernel-api: Failed to cross-reference to document c.txt
> WARNING: core-api/kernel-api: Failed to cross-reference to document Docum=
entation/core-api/atomic_ops.rst
> WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to docume=
nt tools/memory-model/Documentation/explanation.txt
> WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to docume=
nt memory-barriers.txt
> WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to docume=
nt atomic_t.txt
> WARNING: core-api/refcount-vs-atomic: Failed to cross-reference to docume=
nt memory-barriers.txt
> WARNING: dev-tools/coccinelle: Failed to cross-reference to document com/=
coccinelle/coccinelle/blob/master/install.txt
> WARNING: devicetree/bindings/submitting-patches: Failed to cross-referenc=
e to document bindings/ABI.txt
> WARNING: devicetree/bindings/writing-bindings: Failed to cross-reference =
to document property-units.txt
> WARNING: driver-api/console: Failed to cross-reference to document fbcon.=
txt
> WARNING: driver-api/fpga/fpga-region: Failed to cross-reference to docume=
nt ../devicetree/bindings/fpga/fpga-region.txt
> WARNING: driver-api/gpio/board: Failed to cross-reference to document gpi=
o-legacy.txt
> WARNING: driver-api/gpio/consumer: Failed to cross-reference to document =
gpio-legacy.txt
> WARNING: driver-api/gpio/index: Failed to cross-reference to document Doc=
umentation/devicetree/bindings/gpio/gpio.txt
> WARNING: driver-api/gpio/index: Failed to cross-reference to document Doc=
umentation/devicetree/bindings/gpio/gpio.txt
> WARNING: driver-api/gpio/intro: Failed to cross-reference to document gpi=
o-legacy.txt
> WARNING: driver-api/gpio/intro: Failed to cross-reference to document gpi=
o-legacy.txt
> WARNING: driver-api/gpio/intro: Failed to cross-reference to document gpi=
o-legacy.txt
> WARNING: driver-api/gpio/legacy: Failed to cross-reference to document Do=
cumentation/devicetree/bindings/gpio/gpio.txt
> WARNING: driver-api/isapnp: Failed to cross-reference to document pnp.txt
> WARNING: driver-api/media/drivers/cx88-devel: Failed to cross-reference t=
o document edu/circuit_archive/text/ir_decode.txt
> WARNING: driver-api/media/drivers/dvb-usb: Failed to cross-reference to d=
ocument vp7041.txt
> WARNING: driver-api/miscellaneous: Failed to cross-reference to document =
Documentation/devicetree/bindings/serial/rs485.txt
> WARNING: driver-api/nvmem: Failed to cross-reference to document Document=
ation/devicetree/bindings/nvmem/nvmem.txt
> WARNING: driver-api/phy/phy: Failed to cross-reference to document Docume=
ntation/devicetree/bindings/phy/phy-bindings.txt
> WARNING: driver-api/pinctl: Failed to cross-reference to document Documen=
tation/devicetree/bindings/gpio/gpio.txt
> WARNING: driver-api/rfkill: Failed to cross-reference to document admin-g=
uide/kernel-parameters.rst
> WARNING: driver-api/serial/serial-rs485: Failed to cross-reference to doc=
ument Documentation/devicetree/bindings/serial/rs485.txt
> WARNING: fb/cmap_xfbdev: Failed to cross-reference to document rgb.txt
> WARNING: fb/framebuffer: Failed to cross-reference to document xc/program=
s/Xserver/hw/xfree86/doc/modeDB.txt
> WARNING: filesystems/ext2: Failed to cross-reference to document Document=
ation/filesystems/dax.txt
> WARNING: filesystems/nfs/rpc-server-gss: Failed to cross-reference to doc=
ument org/rfc/rfc2203.txt
> WARNING: filesystems/nfs/rpc-server-gss: Failed to cross-reference to doc=
ument org/rfc/rfc5403.txt
> WARNING: filesystems/nfs/rpc-server-gss: Failed to cross-reference to doc=
ument org/rfc/rfc7861.txt
> WARNING: filesystems/ramfs-rootfs-initramfs: Failed to cross-reference to=
 document buffer-format.txt
> WARNING: filesystems/sysfs: Failed to cross-reference to document /fuse.t=
xt
> WARNING: filesystems/ubifs-authentication: Failed to cross-reference to d=
ocument org/doc/Documentation/device-mapper/dm-integrity.rst
> WARNING: filesystems/ubifs-authentication: Failed to cross-reference to d=
ocument org/doc/Documentation/device-mapper/verity.rst
> WARNING: filesystems/vfat: Failed to cross-reference to document longfile=
name.txt
> WARNING: filesystems/vfat: Failed to cross-reference to document longfile=
.txt
> WARNING: filesystems/vfat: Failed to cross-reference to document longfile=
.txt
> WARNING: filesystems/vfat: Failed to cross-reference to document 1.txt
> WARNING: firmware-guide/acpi/dsd/graph: Failed to cross-reference to docu=
ment Documentation/devicetree/bindings/graph.txt
> WARNING: firmware-guide/acpi/dsd/leds: Failed to cross-reference to docum=
ent Documentation/devicetree/bindings/leds/common.txt
> WARNING: firmware-guide/acpi/dsd/leds: Failed to cross-reference to docum=
ent Documentation/devicetree/bindings/media/video-interfaces.txt
> WARNING: firmware-guide/acpi/gpio-properties: Failed to cross-reference t=
o document Documentation/devicetree/bindings/gpio/gpio.txt
> WARNING: firmware-guide/acpi/video_extension: Failed to cross-reference t=
o document admin-guide/kernel-parameters.rst
> WARNING: gpu/drm-kms-helpers: Failed to cross-reference to document Docum=
entation/devicetree/bindings/graph.txt
> WARNING: gpu/drm-kms-helpers: Failed to cross-reference to document Docum=
entation/devicetree/bindings/graph.txt
> WARNING: hwmon/g762: Failed to cross-reference to document Documentation/=
devicetree/bindings/hwmon/g762.txt
> WARNING: hwmon/ina2xx: Failed to cross-reference to document Documentatio=
n/devicetree/bindings/hwmon/ina2xx.txt
> WARNING: hwmon/scpi-hwmon: Failed to cross-reference to document scpi.txt
> WARNING: hwmon/vexpress: Failed to cross-reference to document Documentat=
ion/devicetree/bindings/hwmon/vexpress.txt
> WARNING: infiniband/ipoib: Failed to cross-reference to document org/rfc/=
rfc4391.txt
> WARNING: infiniband/ipoib: Failed to cross-reference to document org/rfc/=
rfc4392.txt
> WARNING: infiniband/ipoib: Failed to cross-reference to document org/rfc/=
rfc4755.txt
> WARNING: input/ff: Failed to cross-reference to document joystick.txt
> WARNING: input/ff: Failed to cross-reference to document joystick.txt
> WARNING: leds/leds-class-multicolor: Failed to cross-reference to documen=
t led-class.rst
> WARNING: locking/futex-requeue-pi: Failed to cross-reference to document =
rt-mutex-desgin.txt
> WARNING: locking/spinlocks: Failed to cross-reference to document Documen=
tation/memory-barriers.txt
> WARNING: misc-devices/xilinx_sdfec: Failed to cross-reference to document=
 sd-fec.txt
> WARNING: netlabel/cipso_ipv4: Failed to cross-reference to document draft=
-ietf-cipso-ipsecurity-01.txt
> WARNING: networking/device_drivers/ethernet/altera/altera_tse: Failed to =
cross-reference to document org/rfc/rfc2863.txt
> WARNING: networking/device_drivers/ethernet/altera/altera_tse: Failed to =
cross-reference to document org/rfc/rfc2819.txt
> WARNING: networking/device_drivers/ethernet/cirrus/cs89x0: Failed to cros=
s-reference to document readme.txt
> WARNING: networking/device_drivers/ethernet/freescale/dpaa2/overview: Fai=
led to cross-reference to document qoriq-mc.txt
> WARNING: networking/device_drivers/ethernet/intel/e100: Failed to cross-r=
eference to document /Documentation/networking/bonding.rst
> WARNING: networking/device_drivers/ethernet/intel/e1000: Failed to cross-=
reference to document networking/ip-sysctl.txt
> WARNING: networking/device_drivers/ethernet/intel/ixgb: Failed to cross-r=
eference to document /Documentation/networking/bonding.rst
> WARNING: networking/device_drivers/ethernet/intel/ixgb: Failed to cross-r=
eference to document networking/ip-sysctl.txt
> WARNING: networking/filter: Failed to cross-reference to document test_in=
.txt
> WARNING: networking/filter: Failed to cross-reference to document test_ou=
t.txt
> WARNING: networking/ip-sysctl: Failed to cross-reference to document org/=
id/draft-nishida-tsvwg-sctp-failover-05.txt
> WARNING: networking/kapi: Failed to cross-reference to document phy_drive=
r.txt
> WARNING: networking/mac80211-injection: Failed to cross-reference to docu=
ment /Documentation/networking/radiotap-headers.rst
> WARNING: networking/sctp: Failed to cross-reference to document org/rfc/r=
fc2960.txt
> WARNING: networking/timestamping: Failed to cross-reference to document D=
ocumentation/devicetree/bindings/ptp/timestamper.txt
> WARNING: networking/udplite: Failed to cross-reference to document uk/use=
rs/gerrit/udp-lite/files/UDP-Lite-HOWTO.txt
> WARNING: networking/udplite: Failed to cross-reference to document org/rf=
c/rfc3828.txt
> WARNING: power/power_supply_class: Failed to cross-reference to document =
Documentation/devicetree/bindings/power/supply/battery.txt
> WARNING: process/8.Conclusion: Failed to cross-reference to document proc=
ess/howto.rst
> WARNING: process/8.Conclusion: Failed to cross-reference to document proc=
ess/submitting-patches.rst
> WARNING: process/8.Conclusion: Failed to cross-reference to document proc=
ess/submitting-drivers.rst
> WARNING: process/coding-style: Failed to cross-reference to document proc=
ess/coding-style.rst
> WARNING: process/howto: Failed to cross-reference to document akpm/stuff/=
tpp.txt
> WARNING: process/howto: Failed to cross-reference to document akpm/stuff/=
tpp.txt
> WARNING: process/management-style: Failed to cross-reference to document =
process/coding-style.rst
> WARNING: process/submitting-patches: Failed to cross-reference to documen=
t akpm/stuff/tpp.txt
> WARNING: scheduler/sched-bwc: Failed to cross-reference to document Docum=
entation/admin-guide/cgroupv2.rst
> WARNING: scheduler/sched-capacity: Failed to cross-reference to document =
Documentation/devicetree/bindings/arm/cpu-capacity.txt
> WARNING: scsi/scsi-generic: Failed to cross-reference to document cz/sg/p=
/scsi-generic_long.txt
> WARNING: scsi/scsi-generic: Failed to cross-reference to document net/sg/=
p/original/SCSI-Programming-HOWTO.txt
> WARNING: security/tpm/xen-tpmfront: Failed to cross-reference to document=
 docs/misc/vtpm.txt
> WARNING: sound/alsa-configuration: Failed to cross-reference to document =
powersave.rst
> WARNING: sound/alsa-configuration: Failed to cross-reference to document =
hdspm.rst
> WARNING: sound/alsa-configuration: Failed to cross-reference to document =
MIXART.txt
> WARNING: sound/cards/bt87x: Failed to cross-reference to document btaudio=
.txt
> WARNING: sound/designs/procfile: Failed to cross-reference to document OS=
S-Emulation.txt
> WARNING: sound/hd-audio/controls: Failed to cross-reference to document H=
D-Audio.txt
> WARNING: sound/soc/platform: Failed to cross-reference to document DPCM.t=
xt
> WARNING: sparc/oradax/oracle-dax: Failed to cross-reference to document d=
ax-hv-api.txt
> WARNING: sparc/oradax/oracle-dax: Failed to cross-reference to document d=
ax-hv-api.txt
> WARNING: trace/coresight/coresight: Failed to cross-reference to document=
 Documentation/devicetree/bindings/arm/coresight.txt
> WARNING: trace/coresight/coresight-cpu-debug: Failed to cross-reference t=
o document Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> WARNING: trace/ftrace: Failed to cross-reference to document uprobetrace.=
txt
> WARNING: trace/kprobes: Failed to cross-reference to document tools/perf/=
Documentation/perf-probe.txt
> WARNING: translations/it_IT/process/1.Intro: Failed to cross-reference to=
 document Intro.rst
> WARNING: translations/it_IT/process/2.Process: Failed to cross-reference =
to document Process.rst
> WARNING: translations/it_IT/process/3.Early-stage: Failed to cross-refere=
nce to document Early-stage.rst
> WARNING: translations/it_IT/process/4.Coding: Failed to cross-reference t=
o document Coding.rst
> WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference =
to document Posting.rst
> WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference =
to document translations/it_IT/process/submitting-patches.rst
> WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference =
to document translations/it_IT/process/submitting-drivers.rst
> WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference =
to document translations/it_IT/process/submit-checklist.rst
> WARNING: translations/it_IT/process/5.Posting: Failed to cross-reference =
to document translations/it_IT/process/submitting-patches.rst
> WARNING: translations/it_IT/process/6.Followthrough: Failed to cross-refe=
rence to document Followthrough.rst
> WARNING: translations/it_IT/process/7.AdvancedTopics: Failed to cross-ref=
erence to document AdvancedTopics.rst
> WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-referen=
ce to document Conclusion.rst
> WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-referen=
ce to document process/howto.rst
> WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-referen=
ce to document process/submitting-patches.rst
> WARNING: translations/it_IT/process/8.Conclusion: Failed to cross-referen=
ce to document process/submitting-drivers.rst
> WARNING: translations/it_IT/process/coding-style: Failed to cross-referen=
ce to document process/coding-style.rst
> WARNING: translations/it_IT/process/howto: Failed to cross-reference to d=
ocument akpm/stuff/tpp.txt
> WARNING: translations/it_IT/process/howto: Failed to cross-reference to d=
ocument admin-guide/reporting-bugs.rst
> WARNING: translations/it_IT/process/howto: Failed to cross-reference to d=
ocument akpm/stuff/tpp.txt
> WARNING: translations/it_IT/process/management-style: Failed to cross-ref=
erence to document translations/it_IT/process/coding-style.rst
> WARNING: translations/it_IT/process/submitting-patches: Failed to cross-r=
eference to document akpm/stuff/tpp.txt
> WARNING: translations/ja_JP/howto: Failed to cross-reference to document =
akpm/stuff/tpp.txt
> WARNING: translations/ja_JP/howto: Failed to cross-reference to document =
admin-guide/reporting-bugs.rst
> WARNING: translations/ja_JP/howto: Failed to cross-reference to document =
akpm/stuff/tpp.txt
> WARNING: translations/ko_KR/howto: Failed to cross-reference to document =
akpm/stuff/tpp.txt
> WARNING: translations/ko_KR/howto: Failed to cross-reference to document =
akpm/stuff/tpp.txt
> WARNING: translations/zh_CN/filesystems/tmpfs: Failed to cross-reference =
to document =E8=AF=B7=E5=8F=82=E8=A7=81Documentation/admin-guide/cgroup-v1/=
cpusets.rst
> WARNING: translations/zh_CN/iio/iio_configfs: Failed to cross-reference t=
o document =E8=AF=B7=E6=9F=A5=E9=98=85Documentation/filesystems/configfs.rst
> WARNING: translations/zh_CN/process/1.Intro: Failed to cross-reference to=
 document Intro.rst
> WARNING: translations/zh_CN/process/2.Process: Failed to cross-reference =
to document Process.rst
> WARNING: translations/zh_CN/process/3.Early-stage: Failed to cross-refere=
nce to document Early-stage.rst
> WARNING: translations/zh_CN/process/4.Coding: Failed to cross-reference t=
o document Coding.rst
> WARNING: translations/zh_CN/process/5.Posting: Failed to cross-reference =
to document Posting.rst
> WARNING: translations/zh_CN/process/6.Followthrough: Failed to cross-refe=
rence to document Followthrough.rst
> WARNING: translations/zh_CN/process/7.AdvancedTopics: Failed to cross-ref=
erence to document AdvancedTopics.rst
> WARNING: translations/zh_CN/process/8.Conclusion: Failed to cross-referen=
ce to document Conclusion.rst
> WARNING: translations/zh_CN/process/8.Conclusion: Failed to cross-referen=
ce to document process/submitting-drivers.rst
> WARNING: translations/zh_CN/process/coding-style: Failed to cross-referen=
ce to document process/coding-style.rst
> WARNING: translations/zh_CN/process/howto: Failed to cross-reference to d=
ocument akpm/stuff/tpp.txt
> WARNING: translations/zh_CN/process/howto: Failed to cross-reference to d=
ocument admin-guide/reporting-bugs.rst
> WARNING: translations/zh_CN/process/howto: Failed to cross-reference to d=
ocument akpm/stuff/tpp.txt
> WARNING: translations/zh_CN/process/management-style: Failed to cross-ref=
erence to document process/coding-style.rst
> WARNING: translations/zh_CN/process/stable-kernel-rules: Failed to cross-=
reference to document =E5=BF=85=E9=A1=BB=E9=81=B5=E5=BE=AADocumentation/tra=
nslations/zh_CN/process/submitting-patches.rst
> WARNING: translations/zh_CN/process/submitting-patches: Failed to cross-r=
eference to document akpm/stuff/tpp.txt
> WARNING: userspace-api/media/v4l/ext-ctrls-camera: Failed to cross-refere=
nce to document video-interfaces.txt
> WARNING: virt/kvm/vcpu-requests: Failed to cross-reference to document Do=
cumentation/core-api/atomic_ops.rst
> WARNING: virt/kvm/vcpu-requests: Failed to cross-reference to document Do=
cumentation/memory-barriers.txt
> WARNING: vm/hwpoison: Failed to cross-reference to document sysctl.txt
> WARNING: w1/masters/omap-hdq: Failed to cross-reference to document Docum=
entation/devicetree/bindings/w1/omap-hdq.txt
> WARNING: w1/masters/w1-gpio: Failed to cross-reference to document Docume=
ntation/devicetree/bindings/w1/w1-gpio.txt
> WARNING: watchdog/hpwdt: Failed to cross-reference to document Documentat=
ion/IPMI.txt
> WARNING: x86/intel_txt: Failed to cross-reference to document SINIT-guide=
.txt
> WARNING: x86/orc-unwinder: Failed to cross-reference to document tools/ob=
jtool/Documentation/stack-validation.txt
> WARNING: x86/pti: Failed to cross-reference to document kernel-parameters=
.txt
>=20
>=20
>  Documentation/sphinx/automarkup.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/au=
tomarkup.py
> index acf5473002f3..5a03c5080ebe 100644
> --- a/Documentation/sphinx/automarkup.py
> +++ b/Documentation/sphinx/automarkup.py
> @@ -7,6 +7,7 @@
>  from docutils import nodes
>  import sphinx
>  from sphinx import addnodes
> +from sphinx.util import logging
>  if sphinx.version_info[0] < 2 or \
>     sphinx.version_info[0] =3D=3D 2 and sphinx.version_info[1] < 1:
>      from sphinx.environment import NoUri
> @@ -74,6 +75,8 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcnt=
l', 'mmap',
> =20
>  c_namespace =3D ''
> =20
> +logger =3D None
> +
>  def markup_refs(docname, app, node):
>      t =3D node.astext()
>      done =3D 0
> @@ -257,6 +260,8 @@ def markup_doc_ref(docname, app, match):
>      if xref:
>          return xref
>      else:
> +        logger.warning('{}: Failed to cross-reference to document '
> +                       '{}'.format(docname, match.group(0)))
>          return nodes.Text(match.group(0))
> =20
>  def get_c_namespace(app, docname):
> @@ -270,7 +275,9 @@ def get_c_namespace(app, docname):
> =20
>  def auto_markup(app, doctree, name):
>      global c_namespace
> +    global logger
>      c_namespace =3D get_c_namespace(app, name)
> +    logger =3D logging.getLogger(__name__)
>      #
>      # This loop could eventually be improved on.  Someday maybe we
>      # want a proper tree traversal with a lot of awareness of which



Thanks,
Mauro
