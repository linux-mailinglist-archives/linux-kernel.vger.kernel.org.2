Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9731EDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhBRSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:01:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:38652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230340AbhBRPWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:22:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CB24AD57;
        Thu, 18 Feb 2021 15:21:28 +0000 (UTC)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ef15869a-fe87-aef2-591d-2ca909a66217@suse.de>
 <20210218150746.GA18220@lst.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: Regression: 6eb0233ec2d0 ("usb: don't inherity DMA properties for
 USB devices")
Message-ID: <ef51698a-cd93-47b3-b79f-8c86a4c215fc@suse.de>
Date:   Thu, 18 Feb 2021 16:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218150746.GA18220@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VSWlDvtYdfOL7Tl8R4iE5C8FzFqKh6JnP"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VSWlDvtYdfOL7Tl8R4iE5C8FzFqKh6JnP
Content-Type: multipart/mixed; boundary="mJWIti817m0Z6jMfS36ap1UGHc6CI4WQi";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <ef51698a-cd93-47b3-b79f-8c86a4c215fc@suse.de>
Subject: Re: Regression: 6eb0233ec2d0 ("usb: don't inherity DMA properties for
 USB devices")
References: <ef15869a-fe87-aef2-591d-2ca909a66217@suse.de>
 <20210218150746.GA18220@lst.de>
In-Reply-To: <20210218150746.GA18220@lst.de>

--mJWIti817m0Z6jMfS36ap1UGHc6CI4WQi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.02.21 um 16:07 schrieb Christoph Hellwig:
> On Thu, Feb 18, 2021 at 03:56:00PM +0100, Thomas Zimmermann wrote:
>> I only have udl devices, but I expect that other DRM USB adapters are =
also
>> affected.
>=20
> Find where the driver calls dma_map_* itself instead of using the USB
> wrappers and fix that..
>=20

Sure, it's at [1]. For udl, the dmabuf would need to be in system=20
memory. The driver creates urbs from the framebuffer content and sends=20
them to the device for displaying.

My question is more: what's the best interface to do this? Is there=20
example code somewhere?

Best regards
Thomas

[1]=20
https://elixir.bootlin.com/linux/v5.11/source/drivers/gpu/drm/drm_prime.c=
#L630


--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--mJWIti817m0Z6jMfS36ap1UGHc6CI4WQi--

--VSWlDvtYdfOL7Tl8R4iE5C8FzFqKh6JnP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAuhfYFAwAAAAAACgkQlh/E3EQov+DA
6A//QdhPXebD7M+EzYUQ/FPnqUMNZAPP2uEP6VWwQQg1LkyhE45S3Cij4JD0ulGEvFZ63QMIAOz6
U+eHXkKSX8vum5Ns9lHXgaQLiF+30j+FeB47XKWNNyBGJwysN5lIe4RI63CA30fJC+PEZGsNGPnk
7wh1Fvp2mgo5SAe0OsZB/5D030s7sV48YQ2dU0z8vIdsNGWVseuRf12oq6jlB18KOW4Ypw5J6o0/
HSc+uMqAVhNyDDTUVNqkOQobgZ0uyjoaj0rdonUcCXOPQHDc6HeU2eeKMgAD87xrLw2h/Ghl2z+F
aQl8WTb7+NsE1sW8jjx0bhIBPj0K1A+v5HN2NdhycbUbnEHhaeVnzvO5sdn2hPVBc3rWfAl3+2Ax
pK/KtpSoqZv4dagLcLMVDwXbGOPKqCIGEizPXr58t2gKV7SrTTILb22FVQv9nTIu1foRKyyUaaSz
Y+djErr5PMrAf78kBAJ8UFFz6RZ5TxDypzkqSeifhZWziz9ZSf7MExV+ZHGQZ2lXonOp4RuK3+6p
89OHWkSdZL/SH0VcrbpZDiGh9Iyur1KMjo6kndylvXJPh31ZuBHEGglNSAPP6888XefHunWjlx/N
nw4l8F54ln8byP0IWJGJ7VVHRYWaxU6R+4FjhwWs/TJsoSZ/i4H/p7m5kFQRG8mqBMbRefVJtWfg
xQw=
=bR7v
-----END PGP SIGNATURE-----

--VSWlDvtYdfOL7Tl8R4iE5C8FzFqKh6JnP--
