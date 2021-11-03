Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20F444194
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhKCMez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:34:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49364 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhKCMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:34:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9028212B8;
        Wed,  3 Nov 2021 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635942736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7t3NqlPAeIHhE9o0Rq3UU4B/b0/ayZJig+6W7UYbtSs=;
        b=Z3aeh8zb6/KAy+ap1XhvBgnPJGqsD5SOIlbj7N9erRvMt3cjdQuAE1BFAgCOO9y8FCF68l
        OtxAMRB0R8qyd2DDCjyiHC97N6nqeDcl6kERdFE9r2kZ6CvzGcwQ9e53/ezoOYvYmjmTcy
        WKNTAXSK5Jyjj+Xn9bRyXx01F07fO3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635942736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7t3NqlPAeIHhE9o0Rq3UU4B/b0/ayZJig+6W7UYbtSs=;
        b=Dj0dG155FeDxYjO5lgFAYMXMC1SPQ0rhafsGEyrlTtlPG1uBxg3Gr7pxYVa+2mv3eBXSxC
        5/OF4H4/XxFid7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF4A513DEB;
        Wed,  3 Nov 2021 12:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o+WZLVCBgmFXVgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 03 Nov 2021 12:32:16 +0000
Message-ID: <1dbc7d15-a314-677b-1870-276b0cca1705@suse.de>
Date:   Wed, 3 Nov 2021 13:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/5] drm: Move nomodeset kernel parameter handler to the
 DRM subsystem
Content-Language: en-US
To:     Neal Gompa <ngompa13@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <20211103104812.1022936-1-javierm@redhat.com>
 <20211103104812.1022936-3-javierm@redhat.com>
 <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Oct0720rCfKcZM0Bdx1176Dv"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Oct0720rCfKcZM0Bdx1176Dv
Content-Type: multipart/mixed; boundary="------------FosV0XO1j6G2WV4nyHvxZ0dW";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Neal Gompa <ngompa13@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <1dbc7d15-a314-677b-1870-276b0cca1705@suse.de>
Subject: Re: [PATCH 2/5] drm: Move nomodeset kernel parameter handler to the
 DRM subsystem
References: <20211103104812.1022936-1-javierm@redhat.com>
 <20211103104812.1022936-3-javierm@redhat.com>
 <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>
In-Reply-To: <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>

--------------FosV0XO1j6G2WV4nyHvxZ0dW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDMuMTEuMjEgdW0gMTI6MDUgc2NocmllYiBOZWFsIEdvbXBhOg0KPiBPbiBX
ZWQsIE5vdiAzLCAyMDIxIGF0IDY6NDggQU0gSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzDQo+
IDxqYXZpZXJtQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+IFRoZSAibm9tb2Rlc2V0IiBr
ZXJuZWwgY21kbGluZSBwYXJhbWV0ZXIgaXMgaGFuZGxlZCBieSB0aGUgdmdhY29uIGRyaXZl
cg0KPj4gYnV0IHRoZSBleHBvcnRlZCB2Z2Fjb25fdGV4dF9mb3JjZSgpIHN5bWJvbCBpcyBv
bmx5IHVzZWQgYnkgRFJNIGRyaXZlcnMuDQo+Pg0KPj4gSXQgbWFrZXMgbXVjaCBtb3JlIHNl
bnNlIGZvciB0aGUgcGFyYW1ldGVyIGxvZ2ljIHRvIGJlIGluIHRoZSBzdWJzeXN0ZW0NCj4+
IG9mIHRoZSBkcml2ZXJzIHRoYXQgYXJlIG1ha2luZyB1c2Ugb2YgaXQuIExldCdzIG1vdmUg
dGhhdCB0byBEUk0uDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWwudmV0dGVyQGZmd2xsLmNoPg0KPj4gU2lnbmVkLW9mZi1ieTogSmF2aWVyIE1hcnRpbmV6
IENhbmlsbGFzIDxqYXZpZXJtQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4gDQo+IFBsZWFzZSBu
bywgSSdkIG11Y2ggcmF0aGVyIGhhdmUgYSBiZXR0ZXIsIG1vcmUgbWVhbmluZ2Z1bCBvcHRp
b24NCj4gaW5zdGVhZCBvZiAibm9tb2Rlc2V0Ii4gSWYgYW55dGhpbmcsIEkgd291bGQgbGlr
ZSB0aGlzIG9wdGlvbiB0bw0KPiBldmVudHVhbGx5IGRvIG5vdGhpbmcgYW5kIHJlcGxhY2Ug
aXQgd2l0aCBhIGJldHRlciBuYW1lZCBvcHRpb24gdGhhdCdzDQo+IG5hbWVzcGFjZWQgYnkg
ZHJtIG9uIHRoZSBjb21tYW5kLWxpbmUuIFRoYXQgd2FzIHBhcnQgb2YgdGhlIGZlZWRiYWNr
IEkNCj4gZ2F2ZSBpbiB0aGUgb3JpZ2luYWwgcGF0Y2ggc2V0LCBhbmQgSSBzdGlsbCBzdGFu
ZCBieSB0aGF0Lg0KDQpUaGlzIHdhcyBuYWNrJ2VkIGZvciBub3cgZHVyaW5nIGlyYyBjaGF0
cyB3aXRoIG90aGVycy4gVGhlcmUgd2FzIG5vIA0KY2xlYXIgc2VtYW50aWNzIGZvciB0aGUg
bmV3IHBhcmFtZXRlciBhbmQgbm9tb2Rlc2V0IGlzIGdvb2QgZW5vdWdoIGZvciANCm5vdy4g
SSBhZ3JlZSB0aGF0IG5vbW9kZXNldCBpcyBiYWRseSBuYW1lZCwgdGhvdWdoLg0KDQpCZXN0
IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiANCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0K
R3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2Vy
bWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkNCihI
UkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNmw7xocmVyOiBJdm8gVG90ZXYN
Cg==

--------------FosV0XO1j6G2WV4nyHvxZ0dW--

--------------Oct0720rCfKcZM0Bdx1176Dv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmGCgVAFAwAAAAAACgkQlh/E3EQov+AK
VhAAki6P8cBCNmFoqne4TUG4Fdz2BFEyPJfrjNI6lOy8qAxXS87MrWvcTCMjTqS9UM0W/APylPhr
Zg+W9ZgSKFRkXvIJlP7JehQqSld8ZPqv/kCl/Bn5F9vMSeXoKU54CtebRcU1I8/AhD6P8YobHI58
ewiazZCj7oOkX6BgC4bhMoCJn9o61lOUekYDI9c+Q44SfOl/pAFYtlYrqrXHs9PeTefw/ueKq8Qd
eVoLLkDQYBujc6Dft2mDScd6RagnIrGAtYSdHJGcQ12pUJp1qi+HbFCeZTG2dKTmDWsxO3ZyinFf
oza+ABz8izrEWOHkf9CzmGuwI4I1qVullQ8gBisRvfnHI6OKKgnNxuH3a/PVINlMQDd1nocBnEOD
eK8XomFzXDaejJomo3HequOkcsYfiI0jBpAfWobkRER/DIUg2Tqrdh77J559KoMMzQwzZUKtGDPx
Y+BzoH3eYMfvk691W/9HTCpcbo56z1ZjiTbA2NylsMFRPYcfBN766Alx5/PoIN6kN732wexX1DTl
QjzlLmIzZcxoQboEIEjhID9YrPuiE59vpHPSiTB9IK+gWl1N437gjjh7VLAXDxXMEAMZbxOIcJry
rN0Z2I+Uvt7HyaV3WEomUPcPvsLm3NsCOzFMgpCE1ewA3uxbVaobhYkKi3k+axv8zomvZx6EgIL8
hvo=
=BHEd
-----END PGP SIGNATURE-----

--------------Oct0720rCfKcZM0Bdx1176Dv--
