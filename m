Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F22442A22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:15:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:15:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFF8B21763;
        Tue,  2 Nov 2021 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635844381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PL/CHUzCaTjVXcJ6tVaGk2chS8+euTk3CpkvBpMc1E=;
        b=tnDkhHB8HpGVgDR1SrPZw/qrxFyjlJL14XuHF2zh77KPNBa+CvnJXL4jNEg0Jv2ku8gadb
        y1NT2nOhGKQFtAt4J4wpeOo9fZsLzUq/SFrGObjIMD/0N8hT20NtBoWFlCuitplP4deH3h
        hSVomYViDsEpzt5a3a01w8N55tY48zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635844381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PL/CHUzCaTjVXcJ6tVaGk2chS8+euTk3CpkvBpMc1E=;
        b=A7hnLFj9n5cDyzOxFyetnMHdWMnOgTqnMyj9rbHzvG8zuEV+hY9UNe7lMMszOEfq2thGve
        tns2CTCRSicxqVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B814D13BAA;
        Tue,  2 Nov 2021 09:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zsqkHh0BgWEmewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 02 Nov 2021 09:13:01 +0000
Message-ID: <48ee2cec-ce4c-6f15-ad73-e1e4a6151d7a@suse.de>
Date:   Tue, 2 Nov 2021 10:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 1/2] drm/aperture: Move conflicting fbdev frame buffer
 removal to a helper
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20211025075756.3479157-1-javierm@redhat.com>
 <20211025075756.3479157-2-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20211025075756.3479157-2-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BtUEHiJ0AVXtJ6d4BYTqtngd"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BtUEHiJ0AVXtJ6d4BYTqtngd
Content-Type: multipart/mixed; boundary="------------rSYPXBdfaNRJIrL1blKCymJn";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Neal Gompa <ngompa13@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Message-ID: <48ee2cec-ce4c-6f15-ad73-e1e4a6151d7a@suse.de>
Subject: Re: [PATCH v2 1/2] drm/aperture: Move conflicting fbdev frame buffer
 removal to a helper
References: <20211025075756.3479157-1-javierm@redhat.com>
 <20211025075756.3479157-2-javierm@redhat.com>
In-Reply-To: <20211025075756.3479157-2-javierm@redhat.com>

--------------rSYPXBdfaNRJIrL1blKCymJn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDI1LjEwLjIxIHVtIDA5OjU3IHNjaHJpZWIgSmF2aWVyIE1hcnRpbmV6IENhbmls
bGFzOg0KPiBUaGUgbG9naWMgdG8gcmVtb3ZlIHRoZSBjb25mbGljdGluZyBmcmFtZSBidWZm
ZXJzIGZvciBmYmRldiBkZXZpY2VzIHRoYXQNCj4gdXNlIGEgZ2l2ZW4gbWVtb3J5IHJhbmdl
IGlzIG9ubHkgY29tcGlsZWQgaWYgQ09ORklHX0ZCIG9wdGlvbiBpcyBlbmFibGVkLg0KPiAN
Cj4gQnV0IGhhdmluZyBhbiBpZmRlZmVyeSBpbiBkcm1fYXBlcnR1cmVfcmVtb3ZlX2NvbmZs
aWN0aW5nX2ZyYW1lYnVmZmVycygpDQo+IG1ha2VzIHRoZSBmdW5jdGlvbiBoYXJkZXIgdG8g
ZXh0ZW5kLiBNb3ZlIHRoZSBsb2dpYyBpbnRvIGl0cyBvd24gaGVscGVyLg0KPiANCj4gU3Vn
Z2VzdGVkLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4g
U2lnbmVkLW9mZi1ieTogSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzIDxqYXZpZXJtQHJlZGhh
dC5jb20+DQoNCkFja2VkLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3Vz
ZS5kZT4NCg0KPiAtLS0NCj4gDQo+IChubyBjaGFuZ2VzIHNpbmNlIHYxKQ0KPiANCj4gICBk
cml2ZXJzL2dwdS9kcm0vZHJtX2FwZXJ0dXJlLmMgfCAzOSArKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyks
IDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9k
cm1fYXBlcnR1cmUuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXBlcnR1cmUuYw0KPiBpbmRl
eCA3NGJkNGE3NmIyNTMuLjFhOGVkMGM2MTZkNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2RybV9hcGVydHVyZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXBl
cnR1cmUuYw0KPiBAQCAtMjczLDYgKzI3MywzMCBAQCBzdGF0aWMgdm9pZCBkcm1fYXBlcnR1
cmVfZGV0YWNoX2RyaXZlcnMocmVzb3VyY2Vfc2l6ZV90IGJhc2UsIHJlc291cmNlX3NpemVf
dCBzaQ0KPiAgIAltdXRleF91bmxvY2soJmRybV9hcGVydHVyZXNfbG9jayk7DQo+ICAgfQ0K
PiAgIA0KPiArc3RhdGljIGludCBkcm1fYXBlcnR1cmVfcmVtb3ZlX2NvbmZsaWN0aW5nX2Zi
ZGV2X2ZyYW1lYnVmZmVycyhyZXNvdXJjZV9zaXplX3QgYmFzZSwNCj4gKwkJCQkJCQkgICAg
ICByZXNvdXJjZV9zaXplX3Qgc2l6ZSwgYm9vbCBwcmltYXJ5LA0KPiArCQkJCQkJCSAgICAg
IGNvbnN0IHN0cnVjdCBkcm1fZHJpdmVyICpyZXFfZHJpdmVyKQ0KPiArew0KPiArI2lmIElT
X1JFQUNIQUJMRShDT05GSUdfRkIpDQo+ICsJc3RydWN0IGFwZXJ0dXJlc19zdHJ1Y3QgKmE7
DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWEgPSBhbGxvY19hcGVydHVyZXMoMSk7DQo+ICsJ
aWYgKCFhKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCWEtPnJhbmdlc1swXS5i
YXNlID0gYmFzZTsNCj4gKwlhLT5yYW5nZXNbMF0uc2l6ZSA9IHNpemU7DQo+ICsNCj4gKwly
ZXQgPSByZW1vdmVfY29uZmxpY3RpbmdfZnJhbWVidWZmZXJzKGEsIHJlcV9kcml2ZXItPm5h
bWUsIHByaW1hcnkpOw0KPiArCWtmcmVlKGEpOw0KPiArDQo+ICsJaWYgKHJldCkNCj4gKwkJ
cmV0dXJuIHJldDsNCj4gKyNlbmRpZg0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAg
LyoqDQo+ICAgICogZHJtX2FwZXJ0dXJlX3JlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1ZmZl
cnMgLSByZW1vdmUgZXhpc3RpbmcgZnJhbWVidWZmZXJzIGluIHRoZSBnaXZlbiByYW5nZQ0K
PiAgICAqIEBiYXNlOiB0aGUgYXBlcnR1cmUncyBiYXNlIGFkZHJlc3MgaW4gcGh5c2ljYWwg
bWVtb3J5DQo+IEBAIC0yODksMjMgKzMxMywxMiBAQCBzdGF0aWMgdm9pZCBkcm1fYXBlcnR1
cmVfZGV0YWNoX2RyaXZlcnMocmVzb3VyY2Vfc2l6ZV90IGJhc2UsIHJlc291cmNlX3NpemVf
dCBzaQ0KPiAgIGludCBkcm1fYXBlcnR1cmVfcmVtb3ZlX2NvbmZsaWN0aW5nX2ZyYW1lYnVm
ZmVycyhyZXNvdXJjZV9zaXplX3QgYmFzZSwgcmVzb3VyY2Vfc2l6ZV90IHNpemUsDQo+ICAg
CQkJCQkJIGJvb2wgcHJpbWFyeSwgY29uc3Qgc3RydWN0IGRybV9kcml2ZXIgKnJlcV9kcml2
ZXIpDQo+ICAgew0KPiAtI2lmIElTX1JFQUNIQUJMRShDT05GSUdfRkIpDQo+IC0Jc3RydWN0
IGFwZXJ0dXJlc19zdHJ1Y3QgKmE7DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+IC0JYSA9IGFs
bG9jX2FwZXJ0dXJlcygxKTsNCj4gLQlpZiAoIWEpDQo+IC0JCXJldHVybiAtRU5PTUVNOw0K
PiAtDQo+IC0JYS0+cmFuZ2VzWzBdLmJhc2UgPSBiYXNlOw0KPiAtCWEtPnJhbmdlc1swXS5z
aXplID0gc2l6ZTsNCj4gLQ0KPiAtCXJldCA9IHJlbW92ZV9jb25mbGljdGluZ19mcmFtZWJ1
ZmZlcnMoYSwgcmVxX2RyaXZlci0+bmFtZSwgcHJpbWFyeSk7DQo+IC0Ja2ZyZWUoYSk7DQo+
IC0NCj4gKwlyZXQgPSBkcm1fYXBlcnR1cmVfcmVtb3ZlX2NvbmZsaWN0aW5nX2ZiZGV2X2Zy
YW1lYnVmZmVycyhiYXNlLCBzaXplLCBwcmltYXJ5LA0KPiArCQkJCQkJCQkgcmVxX2RyaXZl
cik7DQo+ICAgCWlmIChyZXQpDQo+ICAgCQlyZXR1cm4gcmV0Ow0KPiAtI2VuZGlmDQo+ICAg
DQo+ICAgCWRybV9hcGVydHVyZV9kZXRhY2hfZHJpdmVycyhiYXNlLCBzaXplKTsNCj4gICAN
Cj4gDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9w
ZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcp
DQpHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------rSYPXBdfaNRJIrL1blKCymJn--

--------------BtUEHiJ0AVXtJ6d4BYTqtngd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmGBARwFAwAAAAAACgkQlh/E3EQov+C9
jQ/+J5UR3cxu+5Dp5oWbjPSTW+TFsm5RNIcddy1hz/1B/1wkiyvhrbdXlGDd/UXq+YAUxIFp4xXR
jnE4MeTix7A8nqo6q90qs+CCfPb9xxHtRBpq+k4xak7k5XSPGyWRzUJgGGEs6km5CP1W8XXfCZvq
zXosazVq0bTvn+6w0Jb95SHAYJmuPhjLVcg9rzWGyZwaKeqHYrUUtSq15nmQgUNUPGjZUrstombK
Us4t/zh6+A4GLLPh6caLYsZ4IGNPcbJCLrTDrpPO55JK9Mbq5MQVQWUY9n70E2Bp1dIOTYgIIk0x
0YHZd67ZJSGdzY0G1Y4tdZgaJTfdwreQq9zRerkWfnqmqtrX2xMi2fcqyAy43Y7xQUzuMNxFFw+N
V7IXNfT2uDUaJq6hHs5b6gYMRZXB9Oj3nKdOaLEfbZ7sJ3+00nXKmVfugzbt0nDSOI0+8XfDt/q2
dofwPRBrUSMLkKxXH1Q2q3UQR86eArfGwormgdSO/SjvSVz8+cMhKTTXMw51qhUI7Rp0CyMpIXhv
n2m+JJBY2p+680lFiqx6uA9VYpat8Rr5N+wQcPkGCS2yVdciW5YpfAHIrjpY711lqHZEkZNf3Llx
0BrG7J2dGPVt+DW2KUEwtfcOVK1oSxdferfYHLvufut9ypZa3ySkMvNKSQd21yEkdlliqKTK3Ib5
iY4=
=kblq
-----END PGP SIGNATURE-----

--------------BtUEHiJ0AVXtJ6d4BYTqtngd--
