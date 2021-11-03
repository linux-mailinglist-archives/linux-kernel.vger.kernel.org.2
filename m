Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620284441AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhKCMkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:40:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44896 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhKCMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:40:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CADDB1FD39;
        Wed,  3 Nov 2021 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635943055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BHs7RVvovWyLtThqa33Uhau1Rx1LvBX2OAdUCxBozuE=;
        b=iWXXDx4dj/i9CtJTNJI3dwa3iLLk3e2hOdgXhkMvnVroMzfUNSUG4vtrEKno5GC24pwMu6
        jsaG/DzPv8PYYqWC3g8IphnwgWOhXX/rNRQHo3sPgAkozfSX6FTnZcyA2ZPrOU9U9tpsLM
        a6PQHOyyWpt0nwDOkkpCMNhcgo+h15U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635943055;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BHs7RVvovWyLtThqa33Uhau1Rx1LvBX2OAdUCxBozuE=;
        b=IKMnf8WX97TCEYaTXF6+8vn48MYeyWNi3nI879lwMKD0fUEnY5ArzN3GP7JrkXLopP63xc
        SuwHzWgk9Q/UmgCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0D4813DEB;
        Wed,  3 Nov 2021 12:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k91HJo+CgmEMWQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 03 Nov 2021 12:37:35 +0000
Message-ID: <787cc49f-bcba-e58e-9b20-f16f42b45c73@suse.de>
Date:   Wed, 3 Nov 2021 13:37:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/5] Cleanups for the nomodeset kernel command line
 parameter logic
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <20211103104812.1022936-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20211103104812.1022936-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AlEHwhh0wcKbmvmvzT3CFryE"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AlEHwhh0wcKbmvmvzT3CFryE
Content-Type: multipart/mixed; boundary="------------82iAhmPC0OQhVC6P4n0LDpO0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Neal Gompa <ngompa13@gmail.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <787cc49f-bcba-e58e-9b20-f16f42b45c73@suse.de>
Subject: Re: [PATCH 0/5] Cleanups for the nomodeset kernel command line
 parameter logic
References: <20211103104812.1022936-1-javierm@redhat.com>
In-Reply-To: <20211103104812.1022936-1-javierm@redhat.com>

--------------82iAhmPC0OQhVC6P4n0LDpO0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCmRyaS1kZXZlbCBpcyBtaXNzaW5nLiBQbGVhc2UgcmVzdWJtaXQgd2l0aCBkcmkt
ZGV2ZWwgaW4gY2MuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCkFtIDAzLjExLjIxIHVt
IDExOjQ4IHNjaHJpZWIgSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzOg0KPiBUaGVyZSBpcyBh
IGxvdCBvZiBoaXN0b3JpY2FsIGJhZ2dhZ2Ugb24gdGhpcyBwYXJhbWV0ZXIuIEl0J3MgZGVm
aW5lZCBpbg0KPiB0aGUgdmdhY29uIGRyaXZlciBhcyBhICJub21vZGVzZXQiIHBhcmFtZXRl
ciwgYnV0IGl0J3MgaGFuZGxlciBmdW5jdGlvbiBpcw0KPiBjYWxsZWQgdGV4dF9tb2RlKCkg
dGhhdCBzZXRzIGEgdmFyaWFibGUgbmFtZWQgdmdhY29uX3RleHRfbW9kZV9mb3JjZSB3aG9z
ZQ0KPiB2YWx1ZSBpcyBxdWVyaWVkIHdpdGggYSBmdW5jdGlvbiBuYW1lZCB2Z2Fjb25fdGV4
dF9mb3JjZSgpLg0KPiANCj4gQWxsIHRoaXMgaW1wbGllcyB0aGF0IGl0J3MgYWJvdXQgZm9y
Y2luZyB0ZXh0IG1vZGUgZm9yIFZHQSwgeWV0IGl0IGlzIG5vdA0KPiB1c2VkIGluIG5laXRo
ZXIgdmdhY29uIG5vciBvdGhlciBjb25zb2xlIGRyaXZlci4gVGhlIG9ubHkgdXNlcnMgZm9y
IHRoZXNlDQo+IGFyZSBEUk0gZHJpdmVycywgdGhhdCBjaGVjayBmb3IgdGhlIHZnYWNvbl90
ZXh0X2ZvcmNlKCkgcmV0dXJuIHZhbHVlIHRvDQo+IGRldGVybWluZSB3aGV0aGVyIHRoZSBk
cml2ZXIgY291bGQgYmUgbG9hZGVkIG9yIG5vdC4NCj4gDQo+IFRoYXQgbWFrZXMgaXQgcXVp
dGUgY29uZnVzaW5nIHRvIHJlYWQgdGhlIGNvZGUsIGJlY2F1c2UgdGhlIHZhcmlhYmxlcyBh
bmQNCj4gZnVuY3Rpb24gbmFtZXMgZG9uJ3QgcmVmbGVjdCB3aGF0IHRoZXkgYWN0dWFsbHkg
ZG8gYW5kIGFsc28gYXJlIG5vdCBpbiB0aGUNCj4gc2FtZSBzdWJzeXN0ZW0gYXMgdGhlIGRy
aXZlcnMgdGhhdCBtYWtlIHVzZSBvZiB0aGVtLg0KPiANCj4gVGhpcyBwYXRjaC1zZXQgYXR0
ZW1wdHMgdG8gY2xlYW51cCB0aGUgY29kZSBieSBtb3ZpbmcgdGhlIG5vbW9kc2VzZXQgcGFy
YW0NCj4gdG8gdGhlIERSTSBzdWJzeXN0ZW0gYW5kIGRvIHNvbWUgcmVuYW1pbmcgdG8gbWFr
ZSB0aGVpciBpbnRlbnRpb24gY2xlYXJlci4NCj4gDQo+IFRoZXJlIGlzIGFsc28gYW5vdGhl
ciBhc3BlY3QgdGhhdCBjb3VsZCBiZSBpbXByb3ZlZCwgYW5kIGlzIHRoZSBmYWN0IHRoYXQN
Cj4gZHJpdmVycyBhcmUgY2hlY2tpbmcgZm9yIHRoZSBub21vZGVzZXQgYmVpbmcgc2V0IGFz
IGFuIGluZGljYXRpb24gaWYgaGF2ZQ0KPiB0byBiZSBsb2FkZWQuDQo+IA0KPiBCdXQgdGhl
cmUgbWF5IGJlIG90aGVyIHJlYXNvbnMgd2h5IHRoaXMgY291bGQgYmUgdGhlIGNhc2UsIHNv
IGl0IGlzIGJldHRlcg0KPiB0byBlbmNhcHN1bGF0ZSB0aGUgbG9naWMgaW4gYSBzZXBhcmF0
ZSBmdW5jdGlvbiB0byBtYWtlIGNsZWFyIHdoYXQncyBhYm91dC4NCj4gDQo+IFBhdGNoICMx
IGlzIGp1c3QgYSB0cml2aWFsIGZpeCBmb3IgYSBjb21tZW50IHRoYXQgaXNuJ3QgcmVmZXJy
aW5nIHRvIHRoZQ0KPiBjb3JyZWN0IGtlcm5lbCBwYXJhbWV0ZXIuDQo+IA0KPiBQYXRjaCAj
MiBtb3ZlcyB0aGUgbm9tb2Rlc2V0IGxvZ2ljIHRvIHRoZSBEUk0gc3Vic3lzdGVtLg0KPiAN
Cj4gUGF0Y2ggIzMgcmVuYW1lcyB0aGUgdmdhY29uX3RleHRfZm9yY2UoKSBmdW5jdGlvbiBh
bmQgYWNjb21wYW5pbmcgbG9naWMgYXMNCj4gZHJtX21vZGVzZXRfZGlzYWJsZWQoKSwgd2hp
Y2ggaXMgd2hhdCB0aGlzIGZ1bmN0aW9uIGlzIHJlYWxseSBhYm91dC4NCj4gDQo+IFBhdGNo
ICM0IGFkZHMgYSBkcm1fZHJ2X2VuYWJsZWQoKSBmdW5jdGlvbiB0aGF0IGNvdWxkIGJlIHVz
ZWQgYnkgZHJpdmVycw0KPiB0byBjaGVjayBpZiBjb3VsZCBiZSBlbmFibGVkLg0KPiANCj4g
UGF0Y2ggIzUgdXNlcyB0aGUgZHJtX2Rydl9lbmFibGVkKCkgZnVuY3Rpb24gdG8gY2hlY2sg
dGhpcyBpbnN0ZWFkIG9mIGp1c3QNCj4gY2hlY2tpbmcgaWYgbm9tb2Rlc2V0IGhhcyBiZWVu
IHNldC4NCj4gDQo+IA0KPiBKYXZpZXIgTWFydGluZXogQ2FuaWxsYXMgKDUpOg0KPiAgICBk
cm0vaTkxNTogRml4IGNvbW1lbnQgYWJvdXQgbW9kZXNldCBwYXJhbWV0ZXJzDQo+ICAgIGRy
bTogTW92ZSBub21vZGVzZXQga2VybmVsIHBhcmFtZXRlciBoYW5kbGVyIHRvIHRoZSBEUk0g
c3Vic3lzdGVtDQo+ICAgIGRybTogUmVuYW1lIHZnYWNvbl90ZXh0X2ZvcmNlKCkgZnVuY3Rp
b24gdG8gZHJtX21vZGVzZXRfZGlzYWJsZWQoKQ0KPiAgICBkcm06IEFkZCBhIGRybV9kcnZf
ZW5hYmxlZCgpIGhlbHBlciBmdW5jdGlvbg0KPiAgICBkcm06IFVzZSBkcm1fZHJ2X2VuYWJs
ZWQoKSBpbnN0ZWFkIG9mIGRybV9tb2Rlc2V0X2Rpc2FibGVkKCkNCj4gDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgIDIgKysNCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAgNSArKy0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hc3QvYXN0X2Rydi5jICAgICAgICAgICB8ICAzICstLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9kcm1fZHJ2LmMgICAgICAgICAgICAgICB8IDIxICsrKysrKysrKysrKysr
KysrKysrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9ub21vZGVzZXQuYyAgICAgICAgIHwg
MjYgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1
L2k5MTVfbW9kdWxlLmMgICAgICB8IDEwICsrKysrLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vbWdhZzIwMC9tZ2FnMjAwX2Rydi5jICAgfCAgMyArLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vbm91dmVhdS9ub3V2ZWF1X2RybS5jICAgfCAgMyArLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vcXhsL3F4bF9kcnYuYyAgICAgICAgICAgfCAgMyArLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kcnYuYyAgICAgfCAgMyArLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vdGlueS9ib2Nocy5jICAgICAgICAgICAgfCAgMyArLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vdGlueS9jaXJydXMuYyAgICAgICAgICAgfCAgMyArLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vdmJveHZpZGVvL3Zib3hfZHJ2LmMgICAgfCAgNSArLS0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuYyAgICB8ICAzICstLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jICAgICB8ICAzICstLQ0KPiAgIGRyaXZlcnMvdmlk
ZW8vY29uc29sZS92Z2Fjb24uYyAgICAgICAgICB8IDIxIC0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAgaW5jbHVkZS9kcm0vZHJtX2Rydi5oICAgICAgICAgICAgICAgICAgIHwgIDEgKw0K
PiAgIGluY2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZpZy5oICAgICAgICAgICB8ICA2ICsrKysr
Kw0KPiAgIGluY2x1ZGUvbGludXgvY29uc29sZS5oICAgICAgICAgICAgICAgICB8ICA2IC0t
LS0tLQ0KPiAgIDE5IGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKyksIDU3IGRlbGV0
aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vZHJtX25v
bW9kZXNldC5jDQo+IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2
ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1h
eGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcg
TsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------82iAhmPC0OQhVC6P4n0LDpO0--

--------------AlEHwhh0wcKbmvmvzT3CFryE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmGCgo8FAwAAAAAACgkQlh/E3EQov+Cf
jg/8DG8b53em2P7dl+wFPLUhkb6EsleGo/hAoRwdUpjtJ/T7nrHI12GKOn+yl6TPfg2Gk2CUy8nu
+nivevwAgzbtDJSxP4yRXMp9UoN7RGU22yARyJco/6rDpXYR+XuX5rYvCI9nIk++fKGOsw4LJcXD
VhIjqWQ0peC/HzQNdT5O8v04V9RfjbP/O2j+SVb3CTBmFldS8w//hmfhALjyggN971qjfhGdU4BY
u+yXAkqbRUM/9lI4qDjakBzQf+vHSK/wHxMGZ/zHIVITA9YDaCozk8N/+4G8m0h3XwHg5vnZGu05
LyrPDNx+2Y/tQiyevd45YnazH5uJdjQ5JJd/0oHvNIJSaIiB5WgYDnBjd5jYHgGf1Qt/q+6cniai
2JqLjRmYGB8jLa2zclnZII5F1cmMjo9uUap6Y90E4jRcbvfVEJjqgZ9WH7pHcJAYEZmrJyIFRWak
T1HBH+GZC295wBB3SzO739oQiEBxqnoQINb/TxGcSMLW6gCg7XMusT8ApM8Q/YNCzTs0DjODvf/Y
tn6IMVI4xzTmoY+DW8KIqb3bE0Ic0M99MxR9I8Aj7Uj/lX/QTUhlmPCxi8pwYjmcy8nb2ftttrVx
ofHdiGhQif+RveflR3kTJEdClTNBKj57WSzJscMY3Cm3dYedUHdUtBq0ufMTgO+phzz8hVITqFWk
glE=
=EFnJ
-----END PGP SIGNATURE-----

--------------AlEHwhh0wcKbmvmvzT3CFryE--
