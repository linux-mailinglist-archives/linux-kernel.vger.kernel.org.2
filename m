Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1966A351289
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhDAJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233818AbhDAJkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:40:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5540D61057;
        Thu,  1 Apr 2021 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617270000;
        bh=Nq4/v62vTg2f6RpFiWf1fLuE4zBcVBoYR38LVtEOjrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXFFV7x4VKr0OE/FIE4ZXGoTpn5GHRpEbdA+wTUTQ3tiRcMQnXduEy8IbfNAlPDvC
         B1OIyFl1/PR7PDSxoSy1sBlYaqfGRgEbXC7E2+RP92zBJfGllJMJL8282AVO/E2bag
         0gnx6YBLxfZxuMsXcJtVMyTTO/vCAke2shAkaJiqAG55h4w3HU2WjBTCuQpGsZRcAo
         ZZA2soacdUIylJIZghY9vZGN+UeAmNqH7CKB8IhqTKX2T+P5T99J3R6Q7h+2/gCP5X
         mSbJbbeDv4boeM6As6rHumUKre+qU8OiK+Qejrn3ukeK7DQDwlnSxVzqmaKOTCdtib
         b/NhdGrviunNg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRtnx-0008Or-Ni; Thu, 01 Apr 2021 11:39:57 +0200
Date:   Thu, 1 Apr 2021 11:39:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, tony@atomide.com
Subject: Re: [PATCHv2] gnss: motmdm: Add support for Motorola Mapphone
 MDM6600 modem
Message-ID: <YGWU7U1fIkDmc3Mf@hovoldconsulting.com>
References: <20210107224530.GA23250@duo.ucw.cz>
 <20210129224254.GA28853@duo.ucw.cz>
 <20210228204601.GA20966@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fBJ0Cv7dtmHp92KM"
Content-Disposition: inline
In-Reply-To: <20210228204601.GA20966@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fBJ0Cv7dtmHp92KM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 28, 2021 at 09:46:01PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > Motorola is using a custom TS 27.010 based multiplexer protocol
> > for various devices on the modem. These devices can be accessed on
> > dedicated channels using Linux kernel serdev-ngsm driver.
> >=20
> > For the GNSS on these devices, we need to kick the GNSS device at a
> > desired rate. Otherwise the GNSS device stops sending data after a
> > few minutes. The rate we poll data defaults to 1000 ms, and can be
> > specified with a module option rate_ms between 1 to 16 seconds.
> >=20
> > [Tony Lindgren did most of the work here, I just converted it to be
> > normal serdev.]
>=20
> Could I get some comments on the gnss patch? It is fairly simple, and
> I believe it is ready for merge.

Let's get the mux driver in shape first.

> Here's new version of the serdev multiplexing patch for reference. And
> yes, I'd like you to review the design here, too. Yes,
> gsm_serdev_register_tty_port() needs to be cleaned up, but with ifdefs
> you can see alternative approach I tried to work around "controller
> busy" problem.

As I said before, if you're trying to work around the one
client-per-port assumption of serdev, you're doing it wrong. You still
have one client per *virtual* port.

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> Best regards,
> 								Pavel
>=20
> diff --git a/Documentation/devicetree/bindings/serdev/serdev-ngsm.yaml b/=
Documentation/devicetree/bindings/serdev/serdev-ngsm.yaml
> new file mode 100644
> index 000000000000..deec491ee821
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serdev/serdev-ngsm.yaml

> +  ttymask:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description: Mask of the TS 27.010 channel TTY interfaces to start (=
64 bit)

How is this intended to be used? Looks too Linux-specific for a binding.

> +examples:
> +  - |
> +    modem {
> +      compatible =3D "motorola,mapphone-mdm6600-serial";
> +      ttymask =3D <0 0x00001fee>;
> +      phys =3D <&fsusb1_phy>;
> +      phy-names =3D "usb";
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      gnss@4 {
> +         compatible =3D "motorola,mapphone-mdm6600-gnss";
> +         reg =3D <4>;
> +      };
> +    };

So is this is probably the issue: you're skipping one level of the
topology and do not describe the virtual ports.

This should instead be something like below; I'm including one level
above for the full picture:

	serial@nnn {
		compatible =3D "ns16550a";
		reg =3D <nnn>;

		modem {
			compatible =3D "ts27010-mux, motorola,mapphone-mdm6600-serial";

			serial@4 {
				reg =3D <4>

				gnss {
					compatible =3D "motorola,mapphone-mdm6600-gnss";
				};
			};
		};
	};

Here serial@nnn is a normal serial port, modem is the modem (TS 27.010
mux) connected to the serial port, serial@4 is virtual port number four
of the mux, and gnss is the gnss device connected to the virtual port.

You should probably just replace the ttymask property with explicit
nodes for the virtual ports to enable. With no client devices described
in devicetree, these will then show up as regular tty devices under
Linux.

If you add a compatible property for the virtual ports (e.g.
"ts27010-port") you might be able to just use of_platform_populate()
instead of walking the child nodes in gsm_serdev_register_tty_port().

> +int gsm_serdev_register_tty_port(struct gsm_serdev *gsd, int line)
> +{
> +	struct gsm_serdev_dlci_operations *ops;
> +	unsigned int base;
> +	int error;
> +	struct device *dev;
> +	struct device_node *node;
> +	struct device *dev2 =3D NULL;
> +	struct device *ndev;
> +	=09
> +	if (line < 1)
> +		return -EINVAL;
> +
> +	ops =3D kzalloc(sizeof(*ops), GFP_KERNEL);
> +	if (!ops)
> +		return -ENOMEM;
> +
> +	ops->line =3D line;
> +	ops->receive_buf =3D gsd_dlci_receive_buf;
> +
> +	error =3D gsm_serdev_register_dlci(gsd, ops);
> +	if (error)
> +		goto error;
> +
> +	base =3D mux_num_to_base(gsd->gsm);
> +	printk("register_tty_port: have port: %p, %d+%d\n", &gsd->gsm->dlci[lin=
e]->port, base, ops->line);
> +	dev =3D &gsd->serdev->dev;
> +
> +	for_each_available_child_of_node(dev->of_node, node) {
> +		struct platform_device_info devinfo =3D {};
> +		static int idx;
> +		struct platform_device *pdev;
> +		const char *c =3D of_get_property(node, "compatible", NULL);
> +		int reg;
> +	=09
> +		dev_info(dev, "register_tty: child -- %pOF -- compatible %s\n", node, =
c);
> +	=09
> +		if (!c)
> +			continue;
> +#ifdef OLD	=09
> +		if (strcmp(c, "gsmmux,port"))
> +			continue;
> +#endif
> +		if (of_property_read_u32(node, "reg", &reg)) {
> +			printk("no reg property\n");
> +			continue;
> +		}
> +
> +		if (reg !=3D line)
> +			continue;
> +
> +		printk("n_gsm: line %d reg is %d, compatible %s\n", line, reg, c);
> +		/* Hmm, gnss does not work now? */
> +		/* Should we pass the "master" serdev here? */
> +#ifndef OLD
> +		/* does not work, controller is "BUSY". We already have that in variab=
le "dev" */
> +		dev2 =3D dev;
> +#else
> +		devinfo.name =3D kasprintf(GFP_KERNEL, "gsm-mux-%d", idx++);
> +		devinfo.parent =3D dev;
> +
> +		/* Thanks to core.c: serdev_device_add */
> +		pdev =3D platform_device_register_full(&devinfo);
> +		pdev->dev.of_node =3D node;
> +
> +		dev2 =3D &pdev->dev;
> +		printk("device name is %s / %s\n", dev2->init_name, dev2->kobj.name);
> +#endif
> +		break;
> +	}
> +
> +	printk("n_gsm: Registering device at line %d, device is %p\n", line, de=
v2);
> +	ndev =3D tty_port_register_device_serdev(&gsd->gsm->dlci[line]->port,
> +					       gsm_tty_driver, base + ops->line, dev2);
> +	if (dev2)
> +		printk("device name is now %s / %s\n", dev2->init_name, dev2->kobj.nam=
e);
> +=09
> +	printk("register_tty_port: got %p\n", ndev);
> +	return 0;
> +error:
> +	kfree(ops);
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(gsm_serdev_register_tty_port);

Johan

--fBJ0Cv7dtmHp92KM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYGWU6AAKCRALxc3C7H1l
CCibAPwLN2unYtJaFr6tY+5eTB0E+C4MZZFqsTNCIaKDfH//MAD/TfoCn4gBAkZY
E9ppNbjzWhM/yssIvrS/OsGB2KSeyAI=
=5vV6
-----END PGP SIGNATURE-----

--fBJ0Cv7dtmHp92KM--
