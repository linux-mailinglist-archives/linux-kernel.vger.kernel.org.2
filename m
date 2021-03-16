Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5536933D59E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhCPOWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:22:08 -0400
Received: from mout02.posteo.de ([185.67.36.66]:41043 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236200AbhCPOV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:21:58 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 470512400FC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:21:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615904515; bh=0QLkTK+K/s8PC/k7Q9WUZuTjxqAUD07dW8Wvne7JiLs=;
        h=Date:From:To:Cc:Subject:From;
        b=d75/MVJfOtT0PbIco+glbpx133W8nQlNQMQnlGA9fUoAA+cgpvnZwqAsfKuAbGwnL
         Cv4vnxmamuaGc/SqnMdNIq4OOBJ1ycR3q4r9aQ/YPGVZNQGWA280Ch0/B1nxc52MT3
         H2wkeWZGeLBazupVuXsRGkHDi144MfJPQkI+gjR6CLodGHijsBgrG2eTR7pgAzzEip
         8ui+qT7IHgBTjb3YLkRpohqAEgCriiQcmgdqMwOqk3SK//h3g4wsYRNOq05a5c9RoV
         Rzs1J68MVDFePodbVNHhU3nJlZnPCE+1QiQsKhKV9ZBFwflAFaSr3E4XzwXc4yHh72
         c4IvQHs11aR3Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F0Fpn56t4z6tm8;
        Tue, 16 Mar 2021 15:21:53 +0100 (CET)
Date:   Tue, 16 Mar 2021 15:21:50 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: add support for critical values
Message-ID: <20210316152150.5a712927@monster.powergraphx.local>
In-Reply-To: <f7f2c932-8eac-4f5e-ab81-c59addec4aed@roeck-us.net>
References: <YE93HebFD0acwZIX@monster.powergraphx.local>
        <20214c50-5c58-0d3e-5de5-115ed022750e@roeck-us.net>
        <20210315175509.55672ee7@monster.powergraphx.local>
        <f7f2c932-8eac-4f5e-ab81-c59addec4aed@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 11:00:53 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 3/15/21 9:55 AM, Wilken Gottwalt wrote:
> > On Mon, 15 Mar 2021 08:53:25 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >=20
> >> On 3/15/21 8:02 AM, Wilken Gottwalt wrote:
> >>> Adds support for reading the critical values of the temperature senso=
rs
> >>> and the rail sensors (voltage and current) once and caches them. Upda=
tes
> >>> the naming of the constants following a more clear scheme. Also updat=
es
> >>> the documentation and fixes a typo.
> >>>
> >>> The new sensors output of a Corsair HX850i will look like this:
> >>> corsairpsu-hid-3-1
> >>> Adapter: HID adapter
> >>> v_in:        230.00 V
> >>> v_out +12v:   12.14 V  (crit min =3D  +8.41 V, crit max =3D +15.59 V)
> >>> v_out +5v:     5.03 V  (crit min =3D  +3.50 V, crit max =3D  +6.50 V)
> >>> v_out +3.3v:   3.30 V  (crit min =3D  +2.31 V, crit max =3D  +4.30 V)
> >>> psu fan:        0 RPM
> >>> vrm temp:     +46.2=C2=B0C  (crit =3D +70.0=C2=B0C)
> >>> case temp:    +39.8=C2=B0C  (crit =3D +70.0=C2=B0C)
> >>> power total: 152.00 W
> >>> power +12v:  108.00 W
> >>> power +5v:    41.00 W
> >>> power +3.3v:   5.00 W
> >>> curr in:          N/A
> >>
> >> What does that mean ? If it isn't supported by the power supply,
> >> should we drop that entirely ? Maybe drop it via the is_visible
> >> function if it is available for some variants, but always displaying
> >> N/A doesn't add value.
> >>
> >> This is a bit odd, though, since I would assume it translates
> >> to the PSU_CMD_IN_AMPS command. Any chance to track down what is
> >> happening here ?
> >=20
> > I have one of the earliest PSUs of this series, it is just not supporte=
d on
> > mine. I'm not sure if it would be worth the trouble to catch that and t=
urn
> > it off dynamically.
> >=20
>=20
> I think so, because otherwise we'll get complaints about it (people
> are really picky abut such things lately). Better not display it at all
> if it is not supported on a given PSU version. This should be relatively
> easy to catch in the is_visible function.

So do you have any idea how to do it? The PSU does not tell you what is
supported or not, you only find out by running the commands. I mean the
only thing I think of is like I did it for the critical values, but only
keeping the *_support bits. But if I do it that way, I actually should do
it for all the commands. This is the point which I ment with "worth the
trouble."

> Nice PS, anyway. Too bad it is so expensive (and large). Do you know
> if the HX750i uses the same protocol ?

All HX_num_i and RM_num_i PSUs support the same protocol. There are only
small differences in supported commands based on release version. What do
you mean by "large"? The size of the case? All HXi and RMi should have
the same size (standard ATX). Maybe you looked at one of the AXi series,
which are server grade (and are not supported - they use a full USB protoco=
l,
no USB HID) and really expensive (but they sensors there can do even more).

They are expansive because there is only new-old-stock available and they
have some impressive specs. They can deliver some really high currents,
something you need if you run a Threadripper like me or if you use a gfx
card with current spikes (like AMD Vega or NVidia GTX 970).

> [ ... ]
>=20
> >>> +static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
> >>> +{
> >>> +	long tmp;
> >>> +	int ret;
> >>> +	u8 rail;
> >>
> >> Side note: Using anything but sizeof(int) for index variables often re=
sults in more
> >> complex code because the compiler needs to mask index operations. This=
 doesn't
> >> typically apply to x86 because that architecure has byte operations, b=
ut to pretty
> >> much every other architecture.
> >=20
> > Yeah, I know what you mean. I thought I match it to the function parame=
ters.
>=20
> That doesn't really help if it makes the generated code more complex.
>=20
> > Though I would be more concerned about the "case 1 ... 3" stuff which is
> > definitly no liked by static code analysis or even "-pedantic", it's not
> > part of the C standards.
> >=20
>=20
> Hmm, which C standard are we talking about ? There are more than 1,800
> instances of this in the Linux kernel, but I don't recall any static
> analyzer or compiler complaints about it.
>=20
> [ ... ]
>=20
> >>> -static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_=
sensor_types type, u32
> >>> attr,
> >>> -				     int channel, long *val)
> >>> +static int corsairpsu_hwmon_temp(struct corsairpsu_data *priv, u32 a=
ttr, int channel, long
> >>> *val)
> >>
> >> Please make those functions _<type>_read, not just _<type>. It makes t=
he code easier
> >> to understand, and we won't have to change it if write functions are e=
ver added.
> >=20
> > You will laugh... I named the functions that way before, but then I was=
 unhappy
> > with hitting the 100 chars line length. ;-)
> >=20
>=20
> Making the code less readable to meet a line limit isn't really that desi=
rable.
> If you want to stick with one line, you could drop the "hwmon_" from func=
tion prefixes
> instead. Those don't really add any value.

I know I know, it's a personal taste. I really dislike splitting functions
headers about serveral lines, especially if indenting is tab based.

> Thanks,
> Guenter

