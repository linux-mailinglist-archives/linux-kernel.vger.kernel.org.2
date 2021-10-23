Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569224383D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhJWNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 09:40:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:37239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhJWNkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 09:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634996251;
        bh=0snAbR+RTsxpxdGfwdwOXrtKFHackJ4hSG4/lx4fgao=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jSllfxO2usZ2VZuhxWg/nbFpth9UxujBC9iexjCfxhgMgjNvjomlqMQuNB3N0JLhL
         nCS9akI8Y6kBQzBpp2YCJWbA7qVUC6K7hgb6p+CrbdOs4E0c0ajsR/paogqVeHc/Jf
         Ptj0xYaqoDDLyXbnTYkv3KrEHja6oHWQlW6tuQyM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7R1T-1mkI0k1M2n-017oKG; Sat, 23
 Oct 2021 15:37:31 +0200
Date:   Sat, 23 Oct 2021 15:37:20 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Convert platform driver to
 use dev_groups
Message-ID: <20211023133720.GA2105@titan>
References: <20211003091949.7339-1-len.baker@gmx.com>
 <cad3c7dc-cfba-6032-4951-7c2061797b7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad3c7dc-cfba-6032-4951-7c2061797b7b@redhat.com>
X-Provags-ID: V03:K1:nP3fxdafxyhsbrhRo/qTOK4UbsU4gCsW7C3ECS8AIqLnoSvs0qO
 7vmJAJ2Vg5N7V4s51lOCNXBeUxD6EB5oB2M5/0EIMIsJD5g2CozC5KJP/c/srISpj8Xopaf
 afnNQIBMZF4YVl0vq8ABo6lUhKjQxiySZAXUTCGo6UVnhXQ9naSC+PlKb8n/w/ZkSywlBdV
 2ltfD6l6Es7Z+G5G429fQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hN52ZWy8jk4=:lPP7OIsyStdjkbkPMRf+J+
 G5iZXQq68RTNMF2HZLPoniYZjGp2q+6NuLRNP+elsBEw1dV+hr4wpSgTHQ1onE43keChOmUyD
 Au3IA2WKXzRQBJdzP2KwlTmpRd7iX5dQDbrufLmwKV25WcuAej6ZKmr+vhJetz7cPJvn4PdwF
 v1eZ+SRbZlFWOJIdaDovDbfqoWxITu7guBdp84CXrinrAu3o3vQstbWU7MIthUX3vKFuHzeud
 jEgkEIIz3TEtKz40pWOAXUz2QthozMBKExoqWgeuq4CT+zT3bWIu69YHozgn9yHggnJ9PG72R
 tpE++WXv5HBtq5YKEcv4QxTEkjz9W4OyG6HWAs9Y+LOiKc41UcIFFmEYcujql1cH64mnaznLu
 C+94zGDjr3NI+hMPzm10gC88+SjN1A8/EhkzVZKYkfCjJkSaCDsy85E6ygVjvk4EJD1cnXtad
 t6JXEpJrrKMuILZi5N0qD+w5hmoTHIUubDsOSWvok6Q2l2bw3Pr8z3fV37gzB4RySUBeaRELQ
 mv1+LY5cIjVHL+FBzElFnedT3fWUEDpORZ5ZqTz1HGbCRH8f9memhw3akfgLnaYLieq9dZ/AD
 T3BSCgZrt8hguHbx7bAHnOizt/lwBBTCDHO+5zv5EA7/2ZVpQaBTHZAbNnVWgwkPavqZOmOJ+
 g0FA8nUIDXblBEAmP0tOiT/MOCyfDk9DE4K6iqQ+sX3X2b4IhhQvXHptwMGvdiyG3qk198nzg
 OLahT6hVsWw8V07pqM3M8Nv4e2agrfv9OfYlehnm7/DaLEVZPJk91en6yhAuzTCDb31z8E2Vb
 9Dn4UVNCpNXix0DqI6GtddWZPXtBwB1V/KrJSs2n7jPeOgQe67z/9P5LSNlZX1fImAhioVvin
 zcJ4KYrOMJFNUusLsF11Xia7+lbLCHVJ4qgEBtRH6a+pp6gBTVVKiIa3FOo7UHLKu/EbuTgo+
 txWQapMVucWBlRoK1TwlnRI3RE+C3EFCYFoHAd7Jwm2tmrQBHblqe9s6YsCgbvITmzvZgTloZ
 Dm0KqV4jZEcv7/cQr91ETU68vCLcIi8eM9QgFL2sC4yTgS8SazvfxyUgegB2J8sSDWZeL3DE3
 LVoywujkO3haZ8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

first of all, thanks for the review. More below.

On Tue, Oct 19, 2021 at 11:41:30AM +0200, Hans de Goede wrote:
> Hi Len,
>
> On 10/3/21 11:19, Len Baker wrote:
> > Platform drivers have the option of having the platform core create an=
d
> > remove any needed sysfs attribute files. So take advantage of that and
> > refactor the attributes management to avoid to register them "by hand"=
.
> >
> > Also, due to some attributes are optionals, refactor the code and move
> > the logic inside the "is_visible" callbacks of the attribute_group
> > structures.
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> Thank you for the patch, this indeed results in a nice improvement.
>
> Unfortunately I cannot take this as is (because it will trigger
> a BUG_ON). See my inline remarks, if you can do a v2 with those
> fixed that would be great.

Ok, no problem.

> > [...]
> >
> > +static umode_t fan_attr_is_visible(struct kobject *kobj, struct attri=
bute *attr,
> > +				   int n)
> > +{
> > +	if (fan_status_access_mode !=3D TPACPI_FAN_NONE ||
> > +	    fan_control_access_mode !=3D TPACPI_FAN_WR_NONE) {
> > +		if (attr =3D=3D &dev_attr_fan2_input.attr) {
> > +			if (!tp_features.second_fan)
> > +				return 0;
> > +		}
> > +
> > +		return attr->mode;
> > +	}
>
>
> Can you refactor this one to not have nested if-s and put the
> "return attr->mode;" at the end like the other is_visible
> functions please ?

Ok, I will work on it for the next version.

> > [...]
> >
> > -static struct ibm_struct proxsensor_driver_data =3D {
> > -	.name =3D "proximity-sensor",
> > -	.exit =3D proxsensor_exit,
> > -};
> > -
>
> So when I came here during the review I decided a v2 was necessary.
>
> The way the sub-drivers inside thinkpad_acpi work is they must have a
> struct ibm_struct associated with them, even if it is just for the name
> field.
>
> This is enforced rather harshly (something to fix in another patch)
> by this bit of code:
>
> ```
> static int __init ibm_init(struct ibm_init_struct *iibm)
> {
>         int ret;
>         struct ibm_struct *ibm =3D iibm->data;
>         struct proc_dir_entry *entry;
>
>         BUG_ON(ibm =3D=3D NULL);
> ```
>
> The name is used in various places and the struct is also used to
> store various house-keeping flags.
>
> So for v2 please keep the proxsensor_driver_data struct here, as well
> as for dprc_driver_data.

Ok, I will fix it for the v2 version.

> > [...]
> >
> > -static int tpacpi_kbdlang_init(struct ibm_init_struct *iibm)
> > +static umode_t kbdlang_attr_is_visible(struct kobject *kobj,
> > +				       struct attribute *attr, int n)
> >  {
> >  	int err, output;
> >
> >  	err =3D get_keyboard_lang(&output);
> > -	/*
> > -	 * If support isn't available (ENODEV) then don't return an error
> > -	 * just don't create the sysfs group.
> > -	 */
> > -	if (err =3D=3D -ENODEV)
> > -		return 0;
> > -
> > -	if (err)
> > -		return err;
> > -
> > -	/* Platform supports this feature - create the sysfs file */
> > -	return sysfs_create_group(&tpacpi_pdev->dev.kobj, &kbdlang_attr_grou=
p);
> > +	return err ? 0 : attr->mode;
> >  }
>
> get_keyboard_lang() consists of 2 not cheap ACPI calls, one of
> which involves talking to the embedded-controller over some slow bus.
>
> Please keep kbdlang_init() and make it set a flag to use inside
> kbdlang_attr_is_visible().

Understood, thanks.

> > [...]
> >
> > -static struct ibm_struct dprc_driver_data =3D {
> > -	.name =3D "dprc",
> > -	.exit =3D dprc_exit,
>
> As mentioned above this struct needs to be kept around,
> with just the name set.

No problem.

Again, thanks for the review,
Len
