Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A58327479
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 21:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhB1UrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 15:47:07 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:43572 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhB1UrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 15:47:03 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 199751C0B82; Sun, 28 Feb 2021 21:46:02 +0100 (CET)
Date:   Sun, 28 Feb 2021 21:46:01 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     johan@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: Re: [PATCHv2] gnss: motmdm: Add support for Motorola Mapphone
 MDM6600 modem
Message-ID: <20210228204601.GA20966@duo.ucw.cz>
References: <20210107224530.GA23250@duo.ucw.cz>
 <20210129224254.GA28853@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20210129224254.GA28853@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Motorola is using a custom TS 27.010 based multiplexer protocol
> for various devices on the modem. These devices can be accessed on
> dedicated channels using Linux kernel serdev-ngsm driver.
>=20
> For the GNSS on these devices, we need to kick the GNSS device at a
> desired rate. Otherwise the GNSS device stops sending data after a
> few minutes. The rate we poll data defaults to 1000 ms, and can be
> specified with a module option rate_ms between 1 to 16 seconds.
>=20
> [Tony Lindgren did most of the work here, I just converted it to be
> normal serdev.]

Could I get some comments on the gnss patch? It is fairly simple, and
I believe it is ready for merge.

Here's new version of the serdev multiplexing patch for reference. And
yes, I'd like you to review the design here, too. Yes,
gsm_serdev_register_tty_port() needs to be cleaned up, but with ifdefs
you can see alternative approach I tried to work around "controller
busy" problem.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

Best regards,
								Pavel

diff --git a/Documentation/devicetree/bindings/serdev/serdev-ngsm.yaml b/Do=
cumentation/devicetree/bindings/serdev/serdev-ngsm.yaml
new file mode 100644
index 000000000000..deec491ee821
--- /dev/null
+++ b/Documentation/devicetree/bindings/serdev/serdev-ngsm.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serdev/serdev-ngsm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic serdev-ngsm TS 27.010 driver
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+properties:
+  compatible:
+    enum:
+      - etsi,3gpp-ts27010-adaption1
+      - motorola,mapphone-mdm6600-serial
+
+  ttymask:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: Mask of the TS 27.010 channel TTY interfaces to start (64=
 bit)
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: motorola,mapphone-mdm6600-serial
+    then:
+      properties:
+        phys:
+          $ref: /schemas/types.yaml#/definitions/phandle-array
+          description: USB PHY needed for shared GPIO PM wake-up pins
+          maxItems: 1
+
+        phy-names:
+          description: Name of the USB PHY
+          const: usb
+
+        compatible:
+          description: GNSS receiver
+          const: motorola,mapphone-mdm6600-gnss
+
+      required:
+        - phys
+        - phy-names
+
+required:
+  - compatible
+  - ttymask
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    modem {
+      compatible =3D "motorola,mapphone-mdm6600-serial";
+      ttymask =3D <0 0x00001fee>;
+      phys =3D <&fsusb1_phy>;
+      phy-names =3D "usb";
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      gnss@4 {
+         compatible =3D "motorola,mapphone-mdm6600-gnss";
+         reg =3D <4>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab03521..c4792d06c30c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -341,6 +341,8 @@ patternProperties:
     description: Espressif Systems Co. Ltd.
   "^est,.*":
     description: ESTeem Wireless Modems
+  "^etsi,.*":
+    description: ETSI
   "^ettus,.*":
     description: NI Ettus Research
   "^eukrea,.*":
diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index bd12e3d57baa..9fac72eba726 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -13,6 +13,14 @@ menuconfig GNSS
=20
 if GNSS
=20
+config GNSS_MOTMDM
+	tristate "Motorola Modem TS 27.010 serdev GNSS receiver support"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here if you have a Motorola modem using TS 27.010
+	  multiplexer protocol for GNSS such as a Motorola Mapphone
+	  series device like Droid 4.
+
 config GNSS_SERIAL
 	tristate
=20
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 451f11401ecc..f5afc2c22a3b 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -6,6 +6,9 @@
 obj-$(CONFIG_GNSS)			+=3D gnss.o
 gnss-y :=3D core.o
=20
+obj-$(CONFIG_GNSS_MOTMDM)		+=3D gnss-motmdm.o
+gnss-motmdm-y :=3D motmdm.o
+
 obj-$(CONFIG_GNSS_SERIAL)		+=3D gnss-serial.o
 gnss-serial-y :=3D serial.o
=20
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 35cf12147e39..7cea101ba8ba 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -39,6 +39,7 @@
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/serdev.h>
 #include <linux/timer.h>
 #include <linux/tty_flip.h>
 #include <linux/tty_driver.h>
@@ -50,14 +51,18 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/gsmmux.h>
+#include <linux/serdev-gsm.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
=20
-static int debug;
+static int debug =3D 8; /* 13 is also useful */
 module_param(debug, int, 0600);
=20
 /* Defaults: these are from the specification */
=20
-#define T1	10		/* 100mS */
-#define T2	34		/* 333mS */
+#define T1	10		/* 100ms */
+#define T2	34		/* 333ms */
 #define N2	3		/* Retry 3 times */
=20
 /* Use long timers for testing at low speed with debug on */
@@ -150,6 +155,7 @@ struct gsm_dlci {
 	/* Data handling callback */
 	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
+	struct gsm_serdev_dlci_operations *ops; /* serdev dlci ops, if used */
 	struct net_device *net; /* network interface, if created */
 };
=20
@@ -198,6 +204,7 @@ enum gsm_mux_state {
  */
=20
 struct gsm_mux {
+	struct gsm_serdev *gsd;		/* Serial device bus data */
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
 	spinlock_t lock;
 	struct mutex mutex;
@@ -587,7 +594,8 @@ static void gsm_send(struct gsm_mux *gsm, int addr, int=
 cr, int control)
 		WARN_ON(1);
 		return;
 	}
-	gsm->output(gsm, cbuf, len);
+	if (gsm->output)
+		gsm->output(gsm, cbuf, len);
 	gsm_print_packet("-->", addr, cr, control, NULL, 0);
 }
=20
@@ -687,7 +695,7 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct g=
sm_dlci *dlci)
 			print_hex_dump_bytes("gsm_data_kick: ",
 					     DUMP_PREFIX_OFFSET,
 					     gsm->txframe, len);
-		if (gsm->output(gsm, gsm->txframe, len) < 0)
+		if (gsm->output && gsm->output(gsm, gsm->txframe, len) < 0)
 			break;
 		/* FIXME: Can eliminate one SOF in many more cases */
 		gsm->tx_bytes -=3D msg->len;
@@ -1015,7 +1023,7 @@ static void gsm_control_reply(struct gsm_mux *gsm, in=
t cmd, const u8 *data,
 static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlc=
i,
 							u32 modem, int clen)
 {
-	int  mlines =3D 0;
+	int mlines =3D 0;
 	u8 brk =3D 0;
 	int fc;
=20
@@ -2339,6 +2347,415 @@ static int gsm_config(struct gsm_mux *gsm, struct g=
sm_config *c)
 	return 0;
 }
=20
+#ifdef CONFIG_SERIAL_DEV_BUS
+/**
+ * gsm_serdev_set_config - set ts 27.010 config
+ * @gsd:	serdev-gsm instance
+ * @c:		ts 27.010 config data
+ */
+int gsm_serdev_set_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	struct gsm_mux *gsm;
+
+	if (!gsd || !gsd->serdev || !gsd->gsm)
+		return -ENODEV;
+
+	gsm =3D gsd->gsm;
+
+	if (!c)
+		return -EINVAL;
+
+	return gsm_config(gsm, c);
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_set_config);
+
+static struct gsm_dlci *gsd_dlci_get(struct gsm_serdev *gsd, int line,
+				     bool allocate)
+{
+	struct gsm_mux *gsm;
+	struct gsm_dlci *dlci;
+
+	if (!gsd || !gsd->gsm)
+		return ERR_PTR(-ENODEV);
+
+	gsm =3D gsd->gsm;
+
+	if (line < 1 || line >=3D 62)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&gsm->mutex);
+
+	if (gsm->dlci[line]) {
+		dlci =3D gsm->dlci[line];
+		goto unlock;
+	} else if (!allocate) {
+		dlci =3D ERR_PTR(-ENODEV);
+		goto unlock;
+	}
+
+	dlci =3D gsm_dlci_alloc(gsm, line);
+	if (!dlci) {
+		dlci =3D ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
+
+	gsm->dlci[line] =3D dlci;
+
+unlock:
+	mutex_unlock(&gsm->mutex);
+
+	return dlci;
+}
+
+static int gsd_dlci_receive_buf(struct gsm_serdev_dlci_operations *ops,
+				const unsigned char *buf,
+				size_t len)
+{
+	struct gsm_serdev *gsd =3D ops->gsd;
+	struct gsm_dlci *dlci;
+	struct tty_port *port;
+
+	dlci =3D gsd_dlci_get(gsd, ops->line, false);
+	if (IS_ERR(dlci))
+		return PTR_ERR(dlci);
+
+	port =3D &dlci->port;
+	tty_insert_flip_string(port, buf, len);
+	tty_flip_buffer_push(port);
+
+	return len;
+}
+
+static void gsd_dlci_data(struct gsm_dlci *dlci, const u8 *buf, int len)
+{
+	struct gsm_mux *gsm =3D dlci->gsm;
+	struct gsm_serdev *gsd =3D gsm->gsd;
+
+	if (!gsd || !dlci->ops)
+		return;
+
+	switch (dlci->adaption) {
+	case 0:
+	case 1:
+		if (dlci->ops->receive_buf)
+			dlci->ops->receive_buf(dlci->ops, buf, len);
+		break;
+	default:
+		pr_warn("dlci%i adaption %i not yet implemented\n",
+			dlci->addr, dlci->adaption);
+		break;
+	}
+}
+
+/**
+ * gsm_serdev_data_kick - indicate more data can be transmitted
+ * @gsd:	serdev-gsm instance
+ *
+ * See gsm_data_kick() for more information.
+ */
+void gsm_serdev_data_kick(struct gsm_serdev *gsd)
+{
+	struct gsm_mux *gsm;
+	unsigned long flags;
+
+	if (!gsd || !gsd->gsm)
+		return;
+
+	gsm =3D gsd->gsm;
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	gsm_data_kick(gsm, NULL);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_data_kick);
+
+/**
+ * gsm_serdev_register_dlci - register a ts 27.010 channel
+ * @gsd:	serdev-gsm instance
+ * @ops:	channel ops
+ */
+int gsm_serdev_register_dlci(struct gsm_serdev *gsd,
+			     struct gsm_serdev_dlci_operations *ops)
+{
+	struct gsm_dlci *dlci;
+	struct gsm_mux *gsm;
+	int retries;
+
+	if (!gsd || !gsd->gsm || !gsd->serdev)
+		return -ENODEV;
+
+	gsm =3D gsd->gsm;
+
+	if (!ops || !ops->line)
+		return -EINVAL;
+
+	dlci =3D gsd_dlci_get(gsd, ops->line, true);
+	if (IS_ERR(dlci))
+		return PTR_ERR(dlci);
+
+	if (dlci->state =3D=3D DLCI_OPENING || dlci->state =3D=3D DLCI_OPEN ||
+	    dlci->state =3D=3D DLCI_CLOSING)
+		return -EBUSY;
+
+	mutex_lock(&dlci->mutex);
+	ops->gsd =3D gsd;
+	dlci->ops =3D ops;
+	dlci->modem_rx =3D 0;
+	dlci->prev_data =3D dlci->data;
+	dlci->data =3D gsd_dlci_data; /* FIXME: do we want this? */
+	mutex_unlock(&dlci->mutex);
+
+	gsm_dlci_begin_open(dlci);
+
+	/*
+	 * Allow some time for dlci to move to DLCI_OPEN state. Otherwise
+	 * the serdev consumer driver can start sending data too early during
+	 * the setup, and the response will be missed by gms_queue() if we
+	 * still have DLCI_CLOSED state.
+	 */
+	for (retries =3D 10; retries > 0; retries--) {
+		if (dlci->state =3D=3D DLCI_OPEN)
+			break;
+		msleep(100);
+	}
+
+	if (!retries)
+		dev_dbg(&gsd->serdev->dev, "dlci%i not currently active\n",
+			dlci->addr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_register_dlci);
+
+/**
+ * gsm_serdev_unregister_dlci - unregister a ts 27.010 channel
+ * @gsd:	serdev-gsm instance
+ * @ops:	channel ops
+ */
+void gsm_serdev_unregister_dlci(struct gsm_serdev *gsd,
+				struct gsm_serdev_dlci_operations *ops)
+{
+	struct gsm_mux *gsm;
+	struct gsm_dlci *dlci;
+
+	if (!gsd || !gsd->gsm || !gsd->serdev)
+		return;
+
+	gsm =3D gsd->gsm;
+
+	if (!ops || !ops->line)
+		return;
+
+	dlci =3D gsd_dlci_get(gsd, ops->line, false);
+	if (IS_ERR(dlci))
+		return;
+
+	mutex_lock(&dlci->mutex);
+	gsm_destroy_network(dlci);
+	dlci->data =3D dlci->prev_data;
+	dlci->ops->gsd =3D NULL;
+	dlci->ops =3D NULL;
+	mutex_unlock(&dlci->mutex);
+
+	gsm_dlci_begin_close(dlci);
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_unregister_dlci);
+
+static int gsm_serdev_output(struct gsm_mux *gsm, u8 *data, int len)
+{
+	struct serdev_device *serdev =3D gsm->gsd->serdev;
+
+	if (gsm->gsd->output)
+		return gsm->gsd->output(gsm->gsd, data, len);
+	else
+		return serdev_device_write_buf(serdev, data, len);
+}
+
+static int gsd_receive_buf(struct serdev_device *serdev, const u8 *data,
+			   size_t count)
+{
+	struct gsm_serdev *gsd =3D serdev_device_get_drvdata(serdev);
+	struct gsm_mux *gsm;
+	const unsigned char *dp;
+	int i;
+
+	if (WARN_ON(!gsd))
+		return 0;
+
+	gsm =3D gsd->gsm;
+
+	if (debug & 4)
+		print_hex_dump_bytes("gsd_receive_buf: ",
+				     DUMP_PREFIX_OFFSET,
+				     data, count);
+
+	for (i =3D count, dp =3D data; i; i--, dp++)
+		gsm->receive(gsm, *dp);
+
+	return count;
+}
+
+static void gsd_write_wakeup(struct serdev_device *serdev)
+{
+	serdev_device_write_wakeup(serdev);
+}
+
+static struct serdev_device_ops gsd_client_ops =3D {
+	.receive_buf =3D gsd_receive_buf,
+	.write_wakeup =3D gsd_write_wakeup,
+};
+
+extern int motmdm_gnss_attach(struct device *dev, int line);
+
+int gsm_serdev_register_tty_port(struct gsm_serdev *gsd, int line)
+{
+	struct gsm_serdev_dlci_operations *ops;
+	unsigned int base;
+	int error;
+	struct device *dev;
+	struct device_node *node;
+	struct device *dev2 =3D NULL;
+	struct device *ndev;
+	=09
+	if (line < 1)
+		return -EINVAL;
+
+	ops =3D kzalloc(sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	ops->line =3D line;
+	ops->receive_buf =3D gsd_dlci_receive_buf;
+
+	error =3D gsm_serdev_register_dlci(gsd, ops);
+	if (error)
+		goto error;
+
+	base =3D mux_num_to_base(gsd->gsm);
+	printk("register_tty_port: have port: %p, %d+%d\n", &gsd->gsm->dlci[line]=
->port, base, ops->line);
+	dev =3D &gsd->serdev->dev;
+
+	for_each_available_child_of_node(dev->of_node, node) {
+		struct platform_device_info devinfo =3D {};
+		static int idx;
+		struct platform_device *pdev;
+		const char *c =3D of_get_property(node, "compatible", NULL);
+		int reg;
+	=09
+		dev_info(dev, "register_tty: child -- %pOF -- compatible %s\n", node, c);
+	=09
+		if (!c)
+			continue;
+#ifdef OLD	=09
+		if (strcmp(c, "gsmmux,port"))
+			continue;
+#endif
+		if (of_property_read_u32(node, "reg", &reg)) {
+			printk("no reg property\n");
+			continue;
+		}
+
+		if (reg !=3D line)
+			continue;
+
+		printk("n_gsm: line %d reg is %d, compatible %s\n", line, reg, c);
+		/* Hmm, gnss does not work now? */
+		/* Should we pass the "master" serdev here? */
+#ifndef OLD
+		/* does not work, controller is "BUSY". We already have that in variable=
 "dev" */
+		dev2 =3D dev;
+#else
+		devinfo.name =3D kasprintf(GFP_KERNEL, "gsm-mux-%d", idx++);
+		devinfo.parent =3D dev;
+
+		/* Thanks to core.c: serdev_device_add */
+		pdev =3D platform_device_register_full(&devinfo);
+		pdev->dev.of_node =3D node;
+
+		dev2 =3D &pdev->dev;
+		printk("device name is %s / %s\n", dev2->init_name, dev2->kobj.name);
+#endif
+		break;
+	}
+
+	printk("n_gsm: Registering device at line %d, device is %p\n", line, dev2=
);
+	ndev =3D tty_port_register_device_serdev(&gsd->gsm->dlci[line]->port,
+					       gsm_tty_driver, base + ops->line, dev2);
+	if (dev2)
+		printk("device name is now %s / %s\n", dev2->init_name, dev2->kobj.name);
+=09
+	printk("register_tty_port: got %p\n", ndev);
+	return 0;
+error:
+	kfree(ops);
+	return error;
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_register_tty_port);
+
+void gsm_serdev_unregister_tty_port(struct gsm_serdev *gsd, int line)
+{
+	struct gsm_dlci *dlci;
+	unsigned int base;
+
+	if (line < 1)
+		return;
+
+	dlci =3D gsd_dlci_get(gsd, line, false);
+	if (IS_ERR(dlci))
+		return;
+
+	printk("unregister_tty_port: line %d\n", line);
+
+	base =3D mux_num_to_base(gsd->gsm);
+	tty_port_unregister_device(&gsd->gsm->dlci[line]->port, gsm_tty_driver, b=
ase + line);
+	gsm_serdev_unregister_dlci(gsd, dlci->ops);
+	kfree(dlci->ops);
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_unregister_tty_port);
+
+int gsm_serdev_register_device(struct gsm_serdev *gsd)
+{
+	struct gsm_mux *gsm;
+	int error;
+
+	if (WARN(!gsd || !gsd->serdev,
+		 "serdev must be initialized\n"))
+		return -EINVAL;
+
+	serdev_device_set_client_ops(gsd->serdev, &gsd_client_ops);
+
+	gsm =3D gsm_alloc_mux();
+	if (!gsm)
+		return -ENOMEM;
+
+	gsm->encoding =3D 1;
+	gsm->tty =3D NULL;
+	gsm->gsd =3D gsd;
+	gsm->output =3D gsm_serdev_output;
+	gsd->gsm =3D gsm;
+	mux_get(gsd->gsm);
+
+	error =3D gsm_activate_mux(gsd->gsm);
+	if (error) {
+		gsm_cleanup_mux(gsd->gsm);
+		mux_put(gsd->gsm);
+
+		return error;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_register_device);
+
+void gsm_serdev_unregister_device(struct gsm_serdev *gsd)
+{
+	gsm_cleanup_mux(gsd->gsm);
+	mux_put(gsd->gsm);
+	gsd->gsm =3D NULL;
+}
+EXPORT_SYMBOL_GPL(gsm_serdev_unregister_device);
+#endif	/* CONFIG_SERIAL_DEV_BUS */
+
 /**
  *	gsmld_output		-	write to link
  *	@gsm: our mux
@@ -3193,7 +3610,7 @@ static int gsmtty_break_ctl(struct tty_struct *tty, i=
nt state)
 				    properly */
 		encode =3D 0x0F;
 	else if (state > 0) {
-		encode =3D state / 200;	/* mS to encoding */
+		encode =3D state / 200;	/* ms to encoding */
 		if (encode > 0x0F)
 			encode =3D 0x0F;	/* Best effort */
 	}
diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index 46ae732bfc68..ee77c3b7329b 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -22,4 +22,14 @@ config SERIAL_DEV_CTRL_TTYPORT
 	depends on SERIAL_DEV_BUS !=3D m
 	default y
=20
+config SERIAL_DEV_N_GSM
+	tristate "Serial device TS 27.010 support"
+	depends on N_GSM
+	depends on SERIAL_DEV_CTRL_TTYPORT
+	help
+	  Select this if you want to use the TS 27.010 with a serial port with
+	  devices such as modems and GNSS devices.
+
+	  If unsure, say N.
+
 endif
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 078417e5b068..b44889dc2bc5 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -4,3 +4,4 @@ serdev-objs :=3D core.o
 obj-$(CONFIG_SERIAL_DEV_BUS) +=3D serdev.o
=20
 obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) +=3D serdev-ttyport.o
+obj-$(CONFIG_SERIAL_DEV_N_GSM) +=3D serdev-ngsm.o
diff --git a/drivers/tty/serdev/serdev-ngsm.c b/drivers/tty/serdev/serdev-n=
gsm.c
new file mode 100644
index 000000000000..488dd504ca23
--- /dev/null
+++ b/drivers/tty/serdev/serdev-ngsm.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic TS 27.010 serial line discipline serdev driver
+ * Copyright (C) 2020 Tony Lindgren <tony@atomide.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/serdev.h>
+#include <linux/serdev-gsm.h>
+
+#include <linux/phy/phy.h>
+
+#include <uapi/linux/gsmmux.h>
+
+#define TS27010_C_N2		3	/* TS 27.010 default value */
+#define TS27010_RESERVED_DLCI	(BIT_ULL(63) | BIT_ULL(62) | BIT_ULL(0))
+
+struct serdev_ngsm_cfg {
+	const struct gsm_config *gsm;
+	unsigned int init_retry_quirk:1;
+	unsigned int needs_usb_phy:1;
+	unsigned int aggressive_pm:1;
+	int (*init)(struct serdev_device *serdev); /* for device quirks */
+};
+
+struct serdev_ngsm {
+	struct device *dev;
+	struct gsm_serdev gsd;
+	struct phy *phy;
+	u32 baudrate;
+	DECLARE_BITMAP(ttymask, 64);
+	const struct serdev_ngsm_cfg *cfg;
+};
+
+static int serdev_ngsm_tty_init(struct serdev_ngsm *ddata)
+{
+	struct gsm_serdev *gsd =3D &ddata->gsd;
+	struct device *dev =3D ddata->dev;
+	int bit, err;
+
+#if 0
+	for_each_set_bit(bit, ddata->ttymask, 64) {
+		if (bit !=3D 4) continue;
+		if (BIT_ULL(bit) & TS27010_RESERVED_DLCI)
+			continue;
+#endif
+	=09
+	bit =3D 4;
+	{
+		printk("Registering port %d\n", bit);
+		err =3D gsm_serdev_register_tty_port(gsd, bit);
+		if (err) {
+			/* FIXME: unregister already registered ports? */
+			dev_err(dev, "ngsm tty init failed for dlci%i: %i\n",
+				bit, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static void serdev_ngsm_tty_exit(struct serdev_ngsm *ddata)
+{
+	struct gsm_serdev *gsd =3D &ddata->gsd;
+	int bit;
+
+#if 0
+	for_each_set_bit(bit, ddata->ttymask, 64) {
+		if (BIT_ULL(bit) & TS27010_RESERVED_DLCI)
+			continue;
+#endif
+	=09
+	bit =3D 4;
+	{
+		printk("Unregistering port %d\n", bit);
+		gsm_serdev_unregister_tty_port(gsd, bit);
+	}
+}
+
+static int serdev_ngsm_set_config(struct device *dev)
+{
+	struct serdev_ngsm *ddata =3D gsm_serdev_get_drvdata(dev);
+	struct gsm_serdev *gsd =3D &ddata->gsd;
+	struct gsm_config c;
+	int err, n2;
+
+	memcpy(&c, ddata->cfg->gsm, sizeof(c));
+
+	if (ddata->cfg->init_retry_quirk) {
+		n2 =3D c.n2;
+		c.n2 *=3D 10;
+		err =3D gsm_serdev_set_config(gsd, &c);
+		if (err)
+			return err;
+
+		msleep(5000);
+		c.n2 =3D n2;
+	}
+
+	err =3D gsm_serdev_set_config(gsd, &c);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+#if 1
+static int serdev_ngsm_output(struct gsm_serdev *gsd, u8 *data, int len)
+{
+	struct serdev_device *serdev =3D gsd->serdev;
+	struct device *dev =3D &serdev->dev;
+	int err;
+
+	err =3D pm_runtime_get(dev);
+	if ((err !=3D -EINPROGRESS) && err < 0) {
+		pm_runtime_put_noidle(dev);
+
+		return err;
+	}
+
+	serdev_device_write_buf(serdev, data, len);
+
+	pm_runtime_put(dev);
+
+	return len;
+}
+#endif
+
+static int serdev_ngsm_runtime_suspend(struct device *dev)
+{
+	struct serdev_ngsm *ddata =3D gsm_serdev_get_drvdata(dev);
+	int err;
+
+	if (ddata->cfg->needs_usb_phy) {
+		err =3D phy_pm_runtime_put(ddata->phy);
+		if (err < 0) {
+			dev_warn(dev, "%s: phy_pm_runtime_put: %i\n",
+				 __func__, err);
+
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int serdev_ngsm_runtime_resume(struct device *dev)
+{
+	struct serdev_ngsm *ddata =3D gsm_serdev_get_drvdata(dev);
+	int err;
+
+	if (ddata->cfg->needs_usb_phy) {
+		err =3D phy_pm_runtime_get_sync(ddata->phy);
+		if (err < 0) {
+			dev_warn(dev, "%s: phy_pm_runtime_get: %i\n",
+				 __func__, err);
+
+			return err;
+		}
+	}
+
+	gsm_serdev_data_kick(&ddata->gsd);
+
+	return 0;
+}
+
+static const struct dev_pm_ops serdev_ngsm_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(serdev_ngsm_runtime_suspend,
+			   serdev_ngsm_runtime_resume,
+			   NULL)
+};
+/*
+ * At least Motorola MDM6600 devices have GPIO wake pins shared between the
+ * USB PHY and the TS 27.010 interface. So for PM, we need to use the calls
+ * for phy_pm_runtime. Otherwise the modem won't respond to anything on the
+ * UART and will never idle either.
+ */
+static int serdev_ngsm_phy_init(struct device *dev)
+{
+	struct serdev_ngsm *ddata =3D gsm_serdev_get_drvdata(dev);
+	int err;
+
+	if (!ddata->cfg->needs_usb_phy)
+		return 0;
+
+	ddata->phy =3D devm_of_phy_get(dev, dev->of_node, NULL);
+	if (IS_ERR(ddata->phy)) {
+		err =3D PTR_ERR(ddata->phy);
+		if (err !=3D -EPROBE_DEFER)
+			dev_err(dev, "%s: phy error: %i\n", __func__, err);
+
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * Configure SoC 8250 device for 700 ms autosuspend delay, Values around 6=
00 ms
+ * and shorter cause spurious wake-up events at least on Droid 4. Also kee=
p the
+ * SoC 8250 device active during use because of the OOB GPIO wake-up signa=
ling
+ * shared with USB PHY.
+ */
+static int motmdm_init(struct serdev_device *serdev)
+{
+	pm_runtime_set_autosuspend_delay(serdev->ctrl->dev.parent, 700);
+	pm_suspend_ignore_children(&serdev->ctrl->dev, false);
+
+	return 0;
+}
+
+static const struct gsm_config adaption1 =3D {
+	.i =3D 1,			/* 1 =3D UIH, 2 =3D UI */
+	.initiator =3D 1,
+	.encapsulation =3D 0,	/* basic mode */
+	.adaption =3D 1,
+	.mru =3D 1024,		/* from android TS 27010 driver */
+	.mtu =3D 1024,		/* from android TS 27010 driver */
+	.t1 =3D 10,		/* ack timer, default 10ms */
+	.t2 =3D 34,		/* response timer, default 34 */
+	.n2 =3D 3,		/* retransmissions, default 3 */
+};
+
+static const struct serdev_ngsm_cfg adaption1_cfg =3D {
+	.gsm =3D &adaption1,
+};
+
+static const struct serdev_ngsm_cfg motmdm_cfg =3D {
+	.gsm =3D &adaption1,
+	.init_retry_quirk =3D 1,
+	.needs_usb_phy =3D 1,
+	.aggressive_pm =3D 1,
+	.init =3D motmdm_init,
+};
+
+static const struct of_device_id serdev_ngsm_id_table[] =3D {
+	{
+		.compatible =3D "etsi,3gpp-ts27010-adaption1",
+		.data =3D &adaption1_cfg,
+	},
+	{
+		.compatible =3D "motorola,mapphone-mdm6600-serial",
+		.data =3D &motmdm_cfg,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, serdev_ngsm_id_table);
+
+static int serdev_ngsm_probe(struct serdev_device *serdev)
+{
+	struct device *dev =3D &serdev->dev;
+	const struct of_device_id *match;
+	struct gsm_serdev *gsd;
+	struct serdev_ngsm *ddata;
+	u64 ttymask;
+	int err;
+
+	printk("serdev-ngsm: probe\n");
+=09
+	match =3D of_match_device(of_match_ptr(serdev_ngsm_id_table), dev);
+	if (!match)
+		return -ENODEV;
+
+	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+	printk("serdev-ngsm: probe 2\n");
+
+	ddata->dev =3D dev;
+	ddata->cfg =3D match->data;
+
+	gsd =3D &ddata->gsd;
+	gsd->serdev =3D serdev;
+	gsd->output =3D serdev_ngsm_output; /* This is real-serial line to gsm di=
rection;=20
+					     we want to keep it */
+	serdev_device_set_drvdata(serdev, gsd);
+	gsm_serdev_set_drvdata(dev, ddata);
+
+	err =3D serdev_ngsm_phy_init(dev);
+	if (err)
+		return err;
+
+	err =3D of_property_read_u64(dev->of_node, "ttymask", &ttymask);
+	if (err) {
+		dev_err(dev, "invalid or missing ttymask: %i\n", err);
+
+		return err;
+	}
+
+	printk("serdev-ngsm: probe 3\n");
+
+	bitmap_from_u64(ddata->ttymask, ttymask);
+
+	pm_runtime_set_autosuspend_delay(dev, 200);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+	err =3D pm_runtime_get_sync(dev);
+	if (err < 0) {
+		pm_runtime_put_noidle(dev);
+
+		return err;
+	}
+	printk("serdev-ngsm: probe 4\n");
+
+	err =3D gsm_serdev_register_device(gsd);
+	if (err)
+		goto err_disable;
+
+	err =3D serdev_device_open(gsd->serdev);
+	if (err)
+		goto err_disable;
+
+	/* Optional serial port configuration */
+	of_property_read_u32(dev->of_node->parent, "current-speed",
+			     &ddata->baudrate);
+	if (ddata->baudrate)
+		serdev_device_set_baudrate(gsd->serdev, ddata->baudrate);
+
+	if (of_get_property(dev->of_node->parent, "uart-has-rtscts", NULL)) {
+		serdev_device_set_rts(gsd->serdev, true);
+		serdev_device_set_flow_control(gsd->serdev, true);
+	}
+
+	err =3D serdev_ngsm_set_config(dev);
+	if (err)
+		goto err_close;
+
+	printk("serdev-ngsm: probe 5\n");
+=09
+
+	err =3D serdev_ngsm_tty_init(ddata);
+	if (err)
+		goto err_tty;
+
+	if (ddata->cfg->init) {
+		err =3D ddata->cfg->init(serdev);
+		if (err)
+			goto err_tty;
+	}
+
+	err =3D of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (err)
+		goto err_tty;
+
+	/* Allow parent serdev device to idle when open, balanced in remove */
+	if (ddata->cfg->aggressive_pm)
+		pm_runtime_put(&serdev->ctrl->dev);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_tty:
+	serdev_ngsm_tty_exit(ddata);
+
+err_close:
+	serdev_device_close(serdev);
+
+err_disable:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	gsm_serdev_unregister_device(gsd);
+
+	return err;
+}
+
+static void serdev_ngsm_remove(struct serdev_device *serdev)
+{
+	struct gsm_serdev *gsd =3D serdev_device_get_drvdata(serdev);
+	struct device *dev =3D &serdev->dev;
+	struct serdev_ngsm *ddata;
+	int err;
+
+	ddata =3D gsm_serdev_get_drvdata(dev);
+
+	/* Balance the put done in probe for UART */
+	if (ddata->cfg->aggressive_pm)
+		pm_runtime_get(&serdev->ctrl->dev);
+
+	err =3D pm_runtime_get_sync(dev);
+	if (err < 0)
+		dev_warn(dev, "%s: PM runtime: %i\n", __func__, err);
+
+	of_platform_depopulate(dev);
+	serdev_ngsm_tty_exit(ddata);
+	serdev_device_close(serdev);
+	gsm_serdev_unregister_device(gsd);
+
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+static struct serdev_device_driver serdev_ngsm_driver =3D {
+	.driver =3D {
+		.name =3D "serdev_ngsm",
+		.of_match_table =3D of_match_ptr(serdev_ngsm_id_table),
+		.pm =3D &serdev_ngsm_pm_ops,
+	},
+	.probe =3D serdev_ngsm_probe,
+	.remove =3D serdev_ngsm_remove,
+};
+
+module_serdev_device_driver(serdev_ngsm_driver);
+
+MODULE_DESCRIPTION("serdev n_gsm driver");
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 34c1a7be3e01..ab5ea4b6011d 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -572,6 +572,13 @@ extern int hex_dump_to_buffer(const void *buf, size_t =
len, int rowsize,
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
 			   const void *buf, size_t len, bool ascii);
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
+	dynamic_hex_dump(prefix_str, prefix_type, 16, 1, buf, len, true)
+#else
+extern void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
+				 const void *buf, size_t len);
+#endif /* defined(CONFIG_DYNAMIC_DEBUG) */
 #else
 static inline void print_hex_dump(const char *level, const char *prefix_st=
r,
 				  int prefix_type, int rowsize, int groupsize,
@@ -604,19 +611,4 @@ static inline void print_hex_dump_debug(const char *pr=
efix_str, int prefix_type,
 }
 #endif
=20
-/**
- * print_hex_dump_bytes - shorthand form of print_hex_dump() with default =
params
- * @prefix_str: string to prefix each line with;
- *  caller supplies trailing spaces for alignment if desired
- * @prefix_type: controls whether prefix of an offset, address, or none
- *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NO=
NE)
- * @buf: data blob to dump
- * @len: number of bytes in the @buf
- *
- * Calls print_hex_dump(), with log level of KERN_DEBUG,
- * rowsize of 16, groupsize of 1, and ASCII output included.
- */
-#define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
-	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
-
 #endif
diff --git a/include/linux/serdev-gsm.h b/include/linux/serdev-gsm.h
new file mode 100644
index 000000000000..5bdc8143b7df
--- /dev/null
+++ b/include/linux/serdev-gsm.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_SERDEV_GSM_H
+#define _LINUX_SERDEV_GSM_H
+
+#include <linux/device.h>
+#include <linux/serdev.h>
+#include <linux/types.h>
+
+struct gsm_serdev_dlci_operations;
+struct gsm_config;
+
+/**
+ * struct gsm_serdev - serdev-gsm instance
+ * @serdev:		serdev instance
+ * @gsm:		ts 27.010 n_gsm instance
+ * @drvdata:		serdev-gsm consumer driver data
+ * @output:		read data from ts 27.010 channel
+ *
+ * Currently only serdev and output must be initialized, the rest are
+ * are initialized by gsm_serdev_register_dlci().
+ */
+struct gsm_serdev {
+	struct serdev_device *serdev;
+	struct gsm_mux *gsm;
+	void *drvdata;
+	int (*output)(struct gsm_serdev *gsd, u8 *data, int len);
+};
+
+/**
+ * struct gsm_serdev_dlci_operations - serdev-gsm ts 27.010 channel data
+ * @gsd:		serdev-gsm instance
+ * @line:		ts 27.010 channel, control channel 0 is not available
+ * @receive_buf:	function to handle data received for the channel
+ * @drvdata:		dlci specific consumer driver data
+ */
+struct gsm_serdev_dlci_operations {
+	struct gsm_serdev *gsd;
+	int line;
+	int (*receive_buf)(struct gsm_serdev_dlci_operations *ops,
+			   const unsigned char *buf,
+			   size_t len);
+	void *drvdata;
+};
+
+#if IS_ENABLED(CONFIG_N_GSM) && IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
+
+/* TS 27.010 channel specific functions for consumer drivers */
+#if IS_ENABLED(CONFIG_SERIAL_DEV_N_GSM)
+extern int
+serdev_ngsm_register_dlci(struct device *dev, struct gsm_serdev_dlci_opera=
tions *dlci);
+extern void serdev_ngsm_unregister_dlci(struct device *dev,
+					struct gsm_serdev_dlci_operations *dlci);
+extern int serdev_ngsm_write(struct device *dev, struct gsm_serdev_dlci_op=
erations *ops,
+			     const u8 *buf, int len);
+extern struct gsm_serdev_dlci_operations *
+serdev_ngsm_get_dlci(struct device *dev, int line);
+#endif
+
+/* Interface for_gsm serdev support */
+extern int gsm_serdev_register_device(struct gsm_serdev *gsd);
+extern void gsm_serdev_unregister_device(struct gsm_serdev *gsd);
+extern int gsm_serdev_register_tty_port(struct gsm_serdev *gsd, int line);
+extern void gsm_serdev_unregister_tty_port(struct gsm_serdev *gsd, int lin=
e);
+extern struct gsm_serdev_dlci_operations *
+gsm_serdev_tty_port_get_dlci(struct gsm_serdev *gsd, int line);
+
+static inline void *gsm_serdev_get_drvdata(struct device *dev)
+{
+	struct serdev_device *serdev =3D to_serdev_device(dev);
+	struct gsm_serdev *gsd =3D serdev_device_get_drvdata(serdev);
+
+	if (gsd)
+		return gsd->drvdata;
+
+	return NULL;
+}
+
+static inline void gsm_serdev_set_drvdata(struct device *dev, void *drvdat=
a)
+{
+	struct serdev_device *serdev =3D to_serdev_device(dev);
+	struct gsm_serdev *gsd =3D serdev_device_get_drvdata(serdev);
+
+	if (gsd)
+		gsd->drvdata =3D drvdata;
+}
+
+extern int gsm_serdev_get_config(struct gsm_serdev *gsd, struct gsm_config=
 *c);
+extern int gsm_serdev_set_config(struct gsm_serdev *gsd, struct gsm_config=
 *c);
+extern int
+gsm_serdev_register_dlci(struct gsm_serdev *gsd, struct gsm_serdev_dlci_op=
erations *ops);
+extern void
+gsm_serdev_unregister_dlci(struct gsm_serdev *gsd, struct gsm_serdev_dlci_=
operations *ops);
+extern int gsm_serdev_write(struct gsm_serdev *gsd, struct gsm_serdev_dlci=
_operations *ops,
+			    const u8 *buf, int len);
+extern void gsm_serdev_data_kick(struct gsm_serdev *gsd);
+
+#else	/* CONFIG_SERIAL_DEV_BUS */
+
+static inline
+int gsm_serdev_register_device(struct gsm_serdev *gsd)
+{
+	return -ENODEV;
+}
+
+static inline void gsm_serdev_unregister_device(struct gsm_serdev *gsd)
+{
+}
+
+static inline int
+gsm_serdev_register_tty_port(struct gsm_serdev *gsd, int line)
+{
+	return -ENODEV;
+}
+
+static inline
+void gsm_serdev_unregister_tty_port(struct gsm_serdev *gsd, int line)
+{
+}
+
+static inline struct gsm_serdev_dlci_operations *
+gsm_serdev_tty_port_get_dlci(struct gsm_serdev *gsd, int line)
+{
+	return NULL;
+}
+
+static inline void *gsm_serdev_get_drvdata(struct device *dev)
+{
+	return NULL;
+}
+
+static inline
+void gsm_serdev_set_drvdata(struct device *dev, void *drvdata)
+{
+}
+
+static inline
+int gsm_serdev_get_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	return -ENODEV;
+}
+
+static inline
+int gsm_serdev_set_config(struct gsm_serdev *gsd, struct gsm_config *c)
+{
+	return -ENODEV;
+}
+
+static inline
+int gsm_serdev_register_dlci(struct gsm_serdev *gsd,
+			     struct gsm_serdev_dlci_operations *ops)
+{
+	return -ENODEV;
+}
+
+static inline
+void gsm_serdev_unregister_dlci(struct gsm_serdev *gsd,
+				struct gsm_serdev_dlci_operations *ops)
+{
+}
+
+static inline
+int gsm_serdev_write(struct gsm_serdev *gsd, struct gsm_serdev_dlci_operat=
ions *ops,
+		     const u8 *buf, int len)
+{
+	return -ENODEV;
+}
+
+static inline
+void gsm_serdev_data_kick(struct gsm_serdev *gsd)
+{
+}
+
+#endif	/* CONFIG_N_GSM && CONFIG_SERIAL_DEV_BUS */
+#endif	/* _LINUX_SERDEV_GSM_H */
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 147133f8eb2f..b1d55b669ae2 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -270,4 +270,25 @@ void print_hex_dump(const char *level, const char *pre=
fix_str, int prefix_type,
 }
 EXPORT_SYMBOL(print_hex_dump);
=20
+#if !defined(CONFIG_DYNAMIC_DEBUG)
+/**
+ * print_hex_dump_bytes - shorthand form of print_hex_dump() with default =
params
+ * @prefix_str: string to prefix each line with;
+ *  caller supplies trailing spaces for alignment if desired
+ * @prefix_type: controls whether prefix of an offset, address, or none
+ *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NO=
NE)
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ *
+ * Calls print_hex_dump(), with log level of KERN_DEBUG,
+ * rowsize of 16, groupsize of 1, and ASCII output included.
+ */
+void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
+			  const void *buf, size_t len)
+{
+	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, 16, 1,
+		       buf, len, true);
+}
+EXPORT_SYMBOL(print_hex_dump_bytes);
+#endif /* !defined(CONFIG_DYNAMIC_DEBUG) */
 #endif /* defined(CONFIG_PRINTK) */


--=20
http://www.livejournal.com/~pavelmachek

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYDwBCQAKCRAw5/Bqldv6
8hmIAJ9U2+TCcyUgvWTtENm9RsnPUX0SXQCfQOckgzhFmIrLQU/3EoON2H++Hgw=
=9gJM
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
