Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043493FB40B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhH3KqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:46:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50996 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbhH3Kpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BMnnJ+RALSv7JWUbrZC6uj3z90aTlaXyffKlpXlSWOs=;
        b=0PtbyljH3y05wa/xeNgl8JIei6cEaK9fZqNIvj8+ciqw1vcCbQ4E+lD+m+jQ139FwitkuK
        5rvTnWCVcAuv17eve1JOSzGLG2+d81+fsYh9c1aheOk5kaj81Bvba7y1BBlsBrS6tnYPAE
        04AJh6ySh98UTkxayN18bl58aL4+C5nIK6Y14XHoMCaJdtqbSK0bPjGdGi3LVP5arW8f4X
        QhllWOjdF0w32EmOsFTPONAuNPNRB1+/QuN2k6g1p6ZqYH+zcaPgRXcvTFbLNsurObZCpD
        9ptpUrMPn5Oh0lde61KOCZjI4x3uBGdVLz/6fVPpjcKg+HcOtcDfDATJhGJITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BMnnJ+RALSv7JWUbrZC6uj3z90aTlaXyffKlpXlSWOs=;
        b=NyrlN38hVAzmuYGpP/PKir9WtPFJzoNcn+cHnZxNUOPy9NUOqcXKnhqrWecVTINDkbmdhk
        K8Jq7v3lpOYD5DCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/irq for v5.15-rc1
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Message-ID: <163031993864.58256.5249475492261910047.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:49 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/irq branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2021-08-=
30

up to:  34739a2809e1: x86: Fix typo s/ECLR/ELCR/ for the PIC register


A set of updates to support port 0x22/0x23 based PCI configuration space
which can be found on various ALi chipsets and is also available on older
Intel systems which expose a PIRQ router. While the Intel support is more
or less nostalgia, the ALi chips are still in use on popular embedded
boards used for routers.

Thanks,

	tglx

------------------>
Maciej W. Rozycki (6):
      x86: Add support for 0x22/0x23 port I/O configuration space
      x86/PCI: Add support for the ALi M1487 (IBC) PIRQ router
      x86/PCI: Add support for the Intel 82374EB/82374SB (ESC) PIRQ router
      x86/PCI: Add support for the Intel 82426EX PIRQ router
      x86: Avoid magic number with ELCR register accesses
      x86: Fix typo s/ECLR/ELCR/ for the PIC register


 arch/x86/include/asm/i8259.h           |   2 +
 arch/x86/include/asm/pc-conf-reg.h     |  33 ++++
 arch/x86/include/asm/processor-cyrix.h |   8 +-
 arch/x86/kernel/acpi/boot.c            |  12 +-
 arch/x86/kernel/apic/apic.c            |   9 +-
 arch/x86/kernel/apic/io_apic.c         |   2 +-
 arch/x86/kernel/apic/vector.c          |   2 +-
 arch/x86/kernel/i8259.c                |   8 +-
 arch/x86/kernel/mpparse.c              |   3 +-
 arch/x86/kvm/i8259.c                   |  20 +--
 arch/x86/kvm/irq.h                     |   2 +-
 arch/x86/lib/Makefile                  |   1 +
 arch/x86/lib/pc-conf-reg.c             |  13 ++
 arch/x86/pci/irq.c                     | 279 +++++++++++++++++++++++++++++++=
+-
 include/linux/pci_ids.h                |   2 +
 15 files changed, 359 insertions(+), 37 deletions(-)
 create mode 100644 arch/x86/include/asm/pc-conf-reg.h
 create mode 100644 arch/x86/lib/pc-conf-reg.c

diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 89789e8c80f6..637fa1df3512 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -19,6 +19,8 @@ extern unsigned int cached_irq_mask;
 #define PIC_MASTER_OCW3		PIC_MASTER_ISR
 #define PIC_SLAVE_CMD		0xa0
 #define PIC_SLAVE_IMR		0xa1
+#define PIC_ELCR1		0x4d0
+#define PIC_ELCR2		0x4d1
=20
 /* i8259A PIC related value */
 #define PIC_CASCADE_IR		2
diff --git a/arch/x86/include/asm/pc-conf-reg.h b/arch/x86/include/asm/pc-con=
f-reg.h
new file mode 100644
index 000000000000..56bceceacf5f
--- /dev/null
+++ b/arch/x86/include/asm/pc-conf-reg.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Support for the configuration register space at port I/O locations
+ * 0x22 and 0x23 variously used by PC architectures, e.g. the MP Spec,
+ * Cyrix CPUs, numerous chipsets.
+ */
+#ifndef _ASM_X86_PC_CONF_REG_H
+#define _ASM_X86_PC_CONF_REG_H
+
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define PC_CONF_INDEX		0x22
+#define PC_CONF_DATA		0x23
+
+#define PC_CONF_MPS_IMCR	0x70
+
+extern raw_spinlock_t pc_conf_lock;
+
+static inline u8 pc_conf_get(u8 reg)
+{
+	outb(reg, PC_CONF_INDEX);
+	return inb(PC_CONF_DATA);
+}
+
+static inline void pc_conf_set(u8 reg, u8 data)
+{
+	outb(reg, PC_CONF_INDEX);
+	outb(data, PC_CONF_DATA);
+}
+
+#endif /* _ASM_X86_PC_CONF_REG_H */
diff --git a/arch/x86/include/asm/processor-cyrix.h b/arch/x86/include/asm/pr=
ocessor-cyrix.h
index df700a6cc869..efe3e46e454b 100644
--- a/arch/x86/include/asm/processor-cyrix.h
+++ b/arch/x86/include/asm/processor-cyrix.h
@@ -5,14 +5,14 @@
  * Access order is always 0x22 (=3Doffset), 0x23 (=3Dvalue)
  */
=20
+#include <asm/pc-conf-reg.h>
+
 static inline u8 getCx86(u8 reg)
 {
-	outb(reg, 0x22);
-	return inb(0x23);
+	return pc_conf_get(reg);
 }
=20
 static inline void setCx86(u8 reg, u8 data)
 {
-	outb(reg, 0x22);
-	outb(data, 0x23);
+	pc_conf_set(reg, data);
 }
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e55e0c1fad8c..14bcd59bcdee 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -558,10 +558,10 @@ acpi_parse_nmi_src(union acpi_subtable_headers * header=
, const unsigned long end
  * If a PIC-mode SCI is not recognized or gives spurious IRQ7's
  * it may require Edge Trigger -- use "acpi_sci=3Dedge"
  *
- * Port 0x4d0-4d1 are ECLR1 and ECLR2, the Edge/Level Control Registers
+ * Port 0x4d0-4d1 are ELCR1 and ELCR2, the Edge/Level Control Registers
  * for the 8259 PIC.  bit[n] =3D 1 means irq[n] is Level, otherwise Edge.
- * ECLR1 is IRQs 0-7 (IRQ 0, 1, 2 must be 0)
- * ECLR2 is IRQs 8-15 (IRQ 8, 13 must be 0)
+ * ELCR1 is IRQs 0-7 (IRQ 0, 1, 2 must be 0)
+ * ELCR2 is IRQs 8-15 (IRQ 8, 13 must be 0)
  */
=20
 void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger)
@@ -570,7 +570,7 @@ void __init acpi_pic_sci_set_trigger(unsigned int irq, u1=
6 trigger)
 	unsigned int old, new;
=20
 	/* Real old ELCR mask */
-	old =3D inb(0x4d0) | (inb(0x4d1) << 8);
+	old =3D inb(PIC_ELCR1) | (inb(PIC_ELCR2) << 8);
=20
 	/*
 	 * If we use ACPI to set PCI IRQs, then we should clear ELCR
@@ -596,8 +596,8 @@ void __init acpi_pic_sci_set_trigger(unsigned int irq, u1=
6 trigger)
 		return;
=20
 	pr_warn("setting ELCR to %04x (from %04x)\n", new, old);
-	outb(new, 0x4d0);
-	outb(new >> 8, 0x4d1);
+	outb(new, PIC_ELCR1);
+	outb(new >> 8, PIC_ELCR2);
 }
=20
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d262811ce14b..b70344bf6600 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -38,6 +38,7 @@
=20
 #include <asm/trace/irq_vectors.h>
 #include <asm/irq_remapping.h>
+#include <asm/pc-conf-reg.h>
 #include <asm/perf_event.h>
 #include <asm/x86_init.h>
 #include <linux/atomic.h>
@@ -132,18 +133,14 @@ static int enabled_via_apicbase __ro_after_init;
  */
 static inline void imcr_pic_to_apic(void)
 {
-	/* select IMCR register */
-	outb(0x70, 0x22);
 	/* NMI and 8259 INTR go through APIC */
-	outb(0x01, 0x23);
+	pc_conf_set(PC_CONF_MPS_IMCR, 0x01);
 }
=20
 static inline void imcr_apic_to_pic(void)
 {
-	/* select IMCR register */
-	outb(0x70, 0x22);
 	/* NMI and 8259 INTR go directly to BSP */
-	outb(0x00, 0x23);
+	pc_conf_set(PC_CONF_MPS_IMCR, 0x00);
 }
 #endif
=20
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index d5c691a3208b..7846499c54ec 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -764,7 +764,7 @@ static bool irq_active_low(int idx)
 static bool EISA_ELCR(unsigned int irq)
 {
 	if (irq < nr_legacy_irqs()) {
-		unsigned int port =3D 0x4d0 + (irq >> 3);
+		unsigned int port =3D PIC_ELCR1 + (irq >> 3);
 		return (inb(port) >> (irq & 7)) & 1;
 	}
 	apic_printk(APIC_VERBOSE, KERN_INFO
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fb67ed5e7e6a..c132daabe615 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1299,7 +1299,7 @@ static void __init print_PIC(void)
=20
 	pr_debug("... PIC  ISR: %04x\n", v);
=20
-	v =3D inb(0x4d1) << 8 | inb(0x4d0);
+	v =3D inb(PIC_ELCR2) << 8 | inb(PIC_ELCR1);
 	pr_debug("... PIC ELCR: %04x\n", v);
 }
=20
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 282b4ee1339f..15aefa3f3e18 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -235,15 +235,15 @@ static char irq_trigger[2];
  */
 static void restore_ELCR(char *trigger)
 {
-	outb(trigger[0], 0x4d0);
-	outb(trigger[1], 0x4d1);
+	outb(trigger[0], PIC_ELCR1);
+	outb(trigger[1], PIC_ELCR2);
 }
=20
 static void save_ELCR(char *trigger)
 {
 	/* IRQ 0,1,2,8,13 are marked as reserved */
-	trigger[0] =3D inb(0x4d0) & 0xF8;
-	trigger[1] =3D inb(0x4d1) & 0xDE;
+	trigger[0] =3D inb(PIC_ELCR1) & 0xF8;
+	trigger[1] =3D inb(PIC_ELCR2) & 0xDE;
 }
=20
 static void i8259A_resume(void)
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 8f06449aab27..fed721f90116 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/pci.h>
=20
+#include <asm/i8259.h>
 #include <asm/io_apic.h>
 #include <asm/acpi.h>
 #include <asm/irqdomain.h>
@@ -251,7 +252,7 @@ static int __init ELCR_trigger(unsigned int irq)
 {
 	unsigned int port;
=20
-	port =3D 0x4d0 + (irq >> 3);
+	port =3D PIC_ELCR1 + (irq >> 3);
 	return (inb(port) >> (irq & 7)) & 1;
 }
=20
diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 629a09ca9860..0b80263d46d8 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -541,17 +541,17 @@ static int picdev_slave_read(struct kvm_vcpu *vcpu, str=
uct kvm_io_device *dev,
 			    addr, len, val);
 }
=20
-static int picdev_eclr_write(struct kvm_vcpu *vcpu, struct kvm_io_device *de=
v,
+static int picdev_elcr_write(struct kvm_vcpu *vcpu, struct kvm_io_device *de=
v,
 			     gpa_t addr, int len, const void *val)
 {
-	return picdev_write(container_of(dev, struct kvm_pic, dev_eclr),
+	return picdev_write(container_of(dev, struct kvm_pic, dev_elcr),
 			    addr, len, val);
 }
=20
-static int picdev_eclr_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
+static int picdev_elcr_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 			    gpa_t addr, int len, void *val)
 {
-	return picdev_read(container_of(dev, struct kvm_pic, dev_eclr),
+	return picdev_read(container_of(dev, struct kvm_pic, dev_elcr),
 			    addr, len, val);
 }
=20
@@ -577,9 +577,9 @@ static const struct kvm_io_device_ops picdev_slave_ops =
=3D {
 	.write    =3D picdev_slave_write,
 };
=20
-static const struct kvm_io_device_ops picdev_eclr_ops =3D {
-	.read     =3D picdev_eclr_read,
-	.write    =3D picdev_eclr_write,
+static const struct kvm_io_device_ops picdev_elcr_ops =3D {
+	.read     =3D picdev_elcr_read,
+	.write    =3D picdev_elcr_write,
 };
=20
 int kvm_pic_init(struct kvm *kvm)
@@ -602,7 +602,7 @@ int kvm_pic_init(struct kvm *kvm)
 	 */
 	kvm_iodevice_init(&s->dev_master, &picdev_master_ops);
 	kvm_iodevice_init(&s->dev_slave, &picdev_slave_ops);
-	kvm_iodevice_init(&s->dev_eclr, &picdev_eclr_ops);
+	kvm_iodevice_init(&s->dev_elcr, &picdev_elcr_ops);
 	mutex_lock(&kvm->slots_lock);
 	ret =3D kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, 0x20, 2,
 				      &s->dev_master);
@@ -613,7 +613,7 @@ int kvm_pic_init(struct kvm *kvm)
 	if (ret < 0)
 		goto fail_unreg_2;
=20
-	ret =3D kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, 0x4d0, 2, &s->dev_eclr);
+	ret =3D kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, 0x4d0, 2, &s->dev_elcr);
 	if (ret < 0)
 		goto fail_unreg_1;
=20
@@ -647,7 +647,7 @@ void kvm_pic_destroy(struct kvm *kvm)
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_master);
 	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_slave);
-	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_eclr);
+	kvm_io_bus_unregister_dev(vpic->kvm, KVM_PIO_BUS, &vpic->dev_elcr);
 	mutex_unlock(&kvm->slots_lock);
=20
 	kvm->arch.vpic =3D NULL;
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 9b64abf9b3f1..650642b18d15 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -55,7 +55,7 @@ struct kvm_pic {
 	int output;		/* intr from master PIC */
 	struct kvm_io_device dev_master;
 	struct kvm_io_device dev_slave;
-	struct kvm_io_device dev_eclr;
+	struct kvm_io_device dev_elcr;
 	void (*ack_notifier)(void *opaque, int irq);
 	unsigned long irq_states[PIC_NUM_PINS];
 };
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index bad4dee4f0e4..c6506c6a7092 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SMP) +=3D msr-smp.o cache-smp.o
 lib-y :=3D delay.o misc.o cmdline.o cpu.o
 lib-y +=3D usercopy_$(BITS).o usercopy.o getuser.o putuser.o
 lib-y +=3D memcpy_$(BITS).o
+lib-y +=3D pc-conf-reg.o
 lib-$(CONFIG_ARCH_HAS_COPY_MC) +=3D copy_mc.o copy_mc_64.o
 lib-$(CONFIG_INSTRUCTION_DECODER) +=3D insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) +=3D kaslr.o
diff --git a/arch/x86/lib/pc-conf-reg.c b/arch/x86/lib/pc-conf-reg.c
new file mode 100644
index 000000000000..febb52749e8d
--- /dev/null
+++ b/arch/x86/lib/pc-conf-reg.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for the configuration register space at port I/O locations
+ * 0x22 and 0x23 variously used by PC architectures, e.g. the MP Spec,
+ * Cyrix CPUs, numerous chipsets.  As the space is indirectly addressed
+ * it may have to be protected with a spinlock, depending on the context.
+ */
+
+#include <linux/spinlock.h>
+
+#include <asm/pc-conf-reg.h>
+
+DEFINE_RAW_SPINLOCK(pc_conf_lock);
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index d3a73f9335e1..97b63e35e152 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -13,9 +13,13 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/smp.h>
+#include <linux/spinlock.h>
 #include <asm/io_apic.h>
 #include <linux/irq.h>
 #include <linux/acpi.h>
+
+#include <asm/i8259.h>
+#include <asm/pc-conf-reg.h>
 #include <asm/pci_x86.h>
=20
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
@@ -47,6 +51,8 @@ struct irq_router {
 	int (*get)(struct pci_dev *router, struct pci_dev *dev, int pirq);
 	int (*set)(struct pci_dev *router, struct pci_dev *dev, int pirq,
 		int new);
+	int (*lvl)(struct pci_dev *router, struct pci_dev *dev, int pirq,
+		int irq);
 };
=20
 struct irq_router_handler {
@@ -153,7 +159,7 @@ static void __init pirq_peer_trick(void)
 void elcr_set_level_irq(unsigned int irq)
 {
 	unsigned char mask =3D 1 << (irq & 7);
-	unsigned int port =3D 0x4d0 + (irq >> 3);
+	unsigned int port =3D PIC_ELCR1 + (irq >> 3);
 	unsigned char val;
 	static u16 elcr_irq_mask;
=20
@@ -169,6 +175,139 @@ void elcr_set_level_irq(unsigned int irq)
 	}
 }
=20
+/*
+ *	PIRQ routing for the M1487 ISA Bus Controller (IBC) ASIC used
+ *	with the ALi FinALi 486 chipset.  The IBC is not decoded in the
+ *	PCI configuration space, so we identify it by the accompanying
+ *	M1489 Cache-Memory PCI Controller (CMP) ASIC.
+ *
+ *	There are four 4-bit mappings provided, spread across two PCI
+ *	INTx Routing Table Mapping Registers, available in the port I/O
+ *	space accessible indirectly via the index/data register pair at
+ *	0x22/0x23, located at indices 0x42 and 0x43 for the INT1/INT2
+ *	and INT3/INT4 lines respectively.  The INT1/INT3 and INT2/INT4
+ *	lines are mapped in the low and the high 4-bit nibble of the
+ *	corresponding register as follows:
+ *
+ *	0000 : Disabled
+ *	0001 : IRQ9
+ *	0010 : IRQ3
+ *	0011 : IRQ10
+ *	0100 : IRQ4
+ *	0101 : IRQ5
+ *	0110 : IRQ7
+ *	0111 : IRQ6
+ *	1000 : Reserved
+ *	1001 : IRQ11
+ *	1010 : Reserved
+ *	1011 : IRQ12
+ *	1100 : Reserved
+ *	1101 : IRQ14
+ *	1110 : Reserved
+ *	1111 : IRQ15
+ *
+ *	In addition to the usual ELCR register pair there is a separate
+ *	PCI INTx Sensitivity Register at index 0x44 in the same port I/O
+ *	space, whose bits 3:0 select the trigger mode for INT[4:1] lines
+ *	respectively.  Any bit set to 1 causes interrupts coming on the
+ *	corresponding line to be passed to ISA as edge-triggered and
+ *	otherwise they are passed as level-triggered.  Manufacturer's
+ *	documentation says this register has to be set consistently with
+ *	the relevant ELCR register.
+ *
+ *	Accesses to the port I/O space concerned here need to be unlocked
+ *	by writing the value of 0xc5 to the Lock Register at index 0x03
+ *	beforehand.  Any other value written to said register prevents
+ *	further accesses from reaching the register file, except for the
+ *	Lock Register being written with 0xc5 again.
+ *
+ *	References:
+ *
+ *	"M1489/M1487: 486 PCI Chip Set", Version 1.2, Acer Laboratories
+ *	Inc., July 1997
+ */
+
+#define PC_CONF_FINALI_LOCK		0x03u
+#define PC_CONF_FINALI_PCI_INTX_RT1	0x42u
+#define PC_CONF_FINALI_PCI_INTX_RT2	0x43u
+#define PC_CONF_FINALI_PCI_INTX_SENS	0x44u
+
+#define PC_CONF_FINALI_LOCK_KEY		0xc5u
+
+static u8 read_pc_conf_nybble(u8 base, u8 index)
+{
+	u8 reg =3D base + (index >> 1);
+	u8 x;
+
+	x =3D pc_conf_get(reg);
+	return index & 1 ? x >> 4 : x & 0xf;
+}
+
+static void write_pc_conf_nybble(u8 base, u8 index, u8 val)
+{
+	u8 reg =3D base + (index >> 1);
+	u8 x;
+
+	x =3D pc_conf_get(reg);
+	x =3D index & 1 ? (x & 0x0f) | (val << 4) : (x & 0xf0) | val;
+	pc_conf_set(reg, x);
+}
+
+static int pirq_finali_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
+{
+	static const u8 irqmap[16] =3D {
+		0, 9, 3, 10, 4, 5, 7, 6, 0, 11, 0, 12, 0, 14, 0, 15
+	};
+	unsigned long flags;
+	u8 x;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
+	x =3D irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1)];
+	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return x;
+}
+
+static int pirq_finali_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
+{
+	static const u8 irqmap[16] =3D {
+		0, 0, 0, 2, 4, 5, 7, 6, 0, 1, 3, 9, 11, 0, 13, 15
+	};
+	u8 val =3D irqmap[irq];
+	unsigned long flags;
+
+	if (!val)
+		return 0;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
+	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1, val);
+	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return 1;
+}
+
+static int pirq_finali_lvl(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
+{
+	u8 mask =3D ~(1u << (pirq - 1));
+	unsigned long flags;
+	u8 trig;
+
+	elcr_set_level_irq(irq);
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
+	trig =3D pc_conf_get(PC_CONF_FINALI_PCI_INTX_SENS);
+	trig &=3D mask;
+	pc_conf_set(PC_CONF_FINALI_PCI_INTX_SENS, trig);
+	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return 1;
+}
+
 /*
  * Common IRQ routing practice: nibbles in config space,
  * offset by some magic constant.
@@ -219,6 +358,74 @@ static int pirq_ali_set(struct pci_dev *router, struct p=
ci_dev *dev, int pirq, i
 	return 0;
 }
=20
+/*
+ *	PIRQ routing for the 82374EB/82374SB EISA System Component (ESC)
+ *	ASIC used with the Intel 82420 and 82430 PCIsets.  The ESC is not
+ *	decoded in the PCI configuration space, so we identify it by the
+ *	accompanying 82375EB/82375SB PCI-EISA Bridge (PCEB) ASIC.
+ *
+ *	There are four PIRQ Route Control registers, available in the
+ *	port I/O space accessible indirectly via the index/data register
+ *	pair at 0x22/0x23, located at indices 0x60/0x61/0x62/0x63 for the
+ *	PIRQ0/1/2/3# lines respectively.  The semantics is the same as
+ *	with the PIIX router.
+ *
+ *	Accesses to the port I/O space concerned here need to be unlocked
+ *	by writing the value of 0x0f to the ESC ID Register at index 0x02
+ *	beforehand.  Any other value written to said register prevents
+ *	further accesses from reaching the register file, except for the
+ *	ESC ID Register being written with 0x0f again.
+ *
+ *	References:
+ *
+ *	"82374EB/82374SB EISA System Component (ESC)", Intel Corporation,
+ *	Order Number: 290476-004, March 1996
+ *
+ *	"82375EB/82375SB PCI-EISA Bridge (PCEB)", Intel Corporation, Order
+ *	Number: 290477-004, March 1996
+ */
+
+#define PC_CONF_I82374_ESC_ID			0x02u
+#define PC_CONF_I82374_PIRQ_ROUTE_CONTROL	0x60u
+
+#define PC_CONF_I82374_ESC_ID_KEY		0x0fu
+
+static int pirq_esc_get(struct pci_dev *router, struct pci_dev *dev, int pir=
q)
+{
+	unsigned long flags;
+	int reg;
+	u8 x;
+
+	reg =3D pirq;
+	if (reg >=3D 1 && reg <=3D 4)
+		reg +=3D PC_CONF_I82374_PIRQ_ROUTE_CONTROL - 1;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, PC_CONF_I82374_ESC_ID_KEY);
+	x =3D pc_conf_get(reg);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return (x < 16) ? x : 0;
+}
+
+static int pirq_esc_set(struct pci_dev *router, struct pci_dev *dev, int pir=
q,
+		       int irq)
+{
+	unsigned long flags;
+	int reg;
+
+	reg =3D pirq;
+	if (reg >=3D 1 && reg <=3D 4)
+		reg +=3D PC_CONF_I82374_PIRQ_ROUTE_CONTROL - 1;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, PC_CONF_I82374_ESC_ID_KEY);
+	pc_conf_set(reg, irq);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return 1;
+}
+
 /*
  * The Intel PIIX4 pirq rules are fairly simple: "pirq" is
  * just a pointer to the config space.
@@ -237,6 +444,50 @@ static int pirq_piix_set(struct pci_dev *router, struct =
pci_dev *dev, int pirq,
 	return 1;
 }
=20
+/*
+ *	PIRQ routing for the 82426EX ISA Bridge (IB) ASIC used with the
+ *	Intel 82420EX PCIset.
+ *
+ *	There are only two PIRQ Route Control registers, available in the
+ *	combined 82425EX/82426EX PCI configuration space, at 0x66 and 0x67
+ *	for the PIRQ0# and PIRQ1# lines respectively.  The semantics is
+ *	the same as with the PIIX router.
+ *
+ *	References:
+ *
+ *	"82420EX PCIset Data Sheet, 82425EX PCI System Controller (PSC)
+ *	and 82426EX ISA Bridge (IB)", Intel Corporation, Order Number:
+ *	290488-004, December 1995
+ */
+
+#define PCI_I82426EX_PIRQ_ROUTE_CONTROL	0x66u
+
+static int pirq_ib_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	int reg;
+	u8 x;
+
+	reg =3D pirq;
+	if (reg >=3D 1 && reg <=3D 2)
+		reg +=3D PCI_I82426EX_PIRQ_ROUTE_CONTROL - 1;
+
+	pci_read_config_byte(router, reg, &x);
+	return (x < 16) ? x : 0;
+}
+
+static int pirq_ib_set(struct pci_dev *router, struct pci_dev *dev, int pirq,
+		       int irq)
+{
+	int reg;
+
+	reg =3D pirq;
+	if (reg >=3D 1 && reg <=3D 2)
+		reg +=3D PCI_I82426EX_PIRQ_ROUTE_CONTROL - 1;
+
+	pci_write_config_byte(router, reg, irq);
+	return 1;
+}
+
 /*
  * The VIA pirq rules are nibble-based, like ALI,
  * but without the ugly irq number munging.
@@ -549,6 +800,11 @@ static __init int intel_router_probe(struct irq_router *=
r, struct pci_dev *route
 		return 0;
=20
 	switch (device) {
+	case PCI_DEVICE_ID_INTEL_82375:
+		r->name =3D "PCEB/ESC";
+		r->get =3D pirq_esc_get;
+		r->set =3D pirq_esc_set;
+		return 1;
 	case PCI_DEVICE_ID_INTEL_82371FB_0:
 	case PCI_DEVICE_ID_INTEL_82371SB_0:
 	case PCI_DEVICE_ID_INTEL_82371AB_0:
@@ -594,6 +850,11 @@ static __init int intel_router_probe(struct irq_router *=
r, struct pci_dev *route
 		r->get =3D pirq_piix_get;
 		r->set =3D pirq_piix_set;
 		return 1;
+	case PCI_DEVICE_ID_INTEL_82425:
+		r->name =3D "PSC/IB";
+		r->get =3D pirq_ib_get;
+		r->set =3D pirq_ib_set;
+		return 1;
 	}
=20
 	if ((device >=3D PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN &&=20
@@ -745,6 +1006,12 @@ static __init int ite_router_probe(struct irq_router *r=
, struct pci_dev *router,
 static __init int ali_router_probe(struct irq_router *r, struct pci_dev *rou=
ter, u16 device)
 {
 	switch (device) {
+	case PCI_DEVICE_ID_AL_M1489:
+		r->name =3D "FinALi";
+		r->get =3D pirq_finali_get;
+		r->set =3D pirq_finali_set;
+		r->lvl =3D pirq_finali_lvl;
+		return 1;
 	case PCI_DEVICE_ID_AL_M1533:
 	case PCI_DEVICE_ID_AL_M1563:
 		r->name =3D "ALI";
@@ -968,11 +1235,17 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int=
 assign)
 	} else if (r->get && (irq =3D r->get(pirq_router_dev, dev, pirq)) && \
 	((!(pci_probe & PCI_USE_PIRQ_MASK)) || ((1 << irq) & mask))) {
 		msg =3D "found";
-		elcr_set_level_irq(irq);
+		if (r->lvl)
+			r->lvl(pirq_router_dev, dev, pirq, irq);
+		else
+			elcr_set_level_irq(irq);
 	} else if (newirq && r->set &&
 		(dev->class >> 8) !=3D PCI_CLASS_DISPLAY_VGA) {
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
-			elcr_set_level_irq(newirq);
+			if (r->lvl)
+				r->lvl(pirq_router_dev, dev, pirq, newirq);
+			else
+				elcr_set_level_irq(newirq);
 			msg =3D "assigned";
 			irq =3D newirq;
 		}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4bac1831de80..60e2101a009d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1121,6 +1121,7 @@
 #define PCI_DEVICE_ID_3COM_3CR990SVR	0x990a
=20
 #define PCI_VENDOR_ID_AL		0x10b9
+#define PCI_DEVICE_ID_AL_M1489		0x1489
 #define PCI_DEVICE_ID_AL_M1533		0x1533
 #define PCI_DEVICE_ID_AL_M1535		0x1535
 #define PCI_DEVICE_ID_AL_M1541		0x1541
@@ -2643,6 +2644,7 @@
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483
 #define PCI_DEVICE_ID_INTEL_82378	0x0484
+#define PCI_DEVICE_ID_INTEL_82425	0x0486
 #define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
 #define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
 #define PCI_DEVICE_ID_INTEL_MFD_SD	0x0820

