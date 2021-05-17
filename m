Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85308382F53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbhEQOPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:15:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:50952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236862AbhEQOM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:12:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621260669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S44vK4RdOnJ04XbS2vkRaVaifdqAqJWbTuWTIISy/hw=;
        b=iR3+DbGvkyg7WQ8Z8cDFgxHoRSgvWIAeS4+DecIQb7fAJrKhgLBfc5ZSxuiHq2XmAhBmQR
        luVDcXvc2cLSQkLIAonFcQrRB/311xaPJMSYV7yGraVt/7uAQ3jJ8z8lfm7f3GQAxi1t5K
        7z9s9bPIyZSS3xPTHT1+bekE/mf2q0Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96EB6B231;
        Mon, 17 May 2021 14:11:09 +0000 (UTC)
Subject: Re: [PATCH 3/8] xen/blkfront: don't take local copy of a request from
 the ring page
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-4-jgross@suse.com>
 <4cbf7b7f-5f00-4aba-4d54-06aa73d1bc32@suse.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <278182af-044a-9445-bbdb-fdbb65d0da7c@suse.com>
Date:   Mon, 17 May 2021 16:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4cbf7b7f-5f00-4aba-4d54-06aa73d1bc32@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r1814kCXy88HKlk6GseNHQ5Jl1bQjvzK4"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r1814kCXy88HKlk6GseNHQ5Jl1bQjvzK4
Content-Type: multipart/mixed; boundary="3z0SaXV9bT9EMUHkBlogZ1gUM2CrDn6LJ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Message-ID: <278182af-044a-9445-bbdb-fdbb65d0da7c@suse.com>
Subject: Re: [PATCH 3/8] xen/blkfront: don't take local copy of a request from
 the ring page
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-4-jgross@suse.com>
 <4cbf7b7f-5f00-4aba-4d54-06aa73d1bc32@suse.com>
In-Reply-To: <4cbf7b7f-5f00-4aba-4d54-06aa73d1bc32@suse.com>

--3z0SaXV9bT9EMUHkBlogZ1gUM2CrDn6LJ
Content-Type: multipart/mixed;
 boundary="------------D884FEC9E12ABF923568C4A9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D884FEC9E12ABF923568C4A9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 17.05.21 16:01, Jan Beulich wrote:
> On 13.05.2021 12:02, Juergen Gross wrote:
>> In order to avoid a malicious backend being able to influence the loca=
l
>> copy of a request build the request locally first and then copy it to
>> the ring page instead of doing it the other way round as today.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>=20
> Reviewed-by: Jan Beulich <jbeulich@suse.com>
> with one remark/question:
>=20
>> @@ -703,6 +704,7 @@ static int blkif_queue_rw_req(struct request *req,=20
struct blkfront_ring_info *ri
>>   {
>>   	struct blkfront_info *info =3D rinfo->dev_info;
>>   	struct blkif_request *ring_req, *extra_ring_req =3D NULL;
>> +	struct blkif_request *final_ring_req, *final_extra_ring_req;
>=20
> Without setting final_extra_ring_req to NULL just like is done for
> extra_ring_req, ...
>=20
>> @@ -840,10 +845,10 @@ static int blkif_queue_rw_req(struct request *re=
q, struct blkfront_ring_info *ri
>>   	if (setup.segments)
>>   		kunmap_atomic(setup.segments);
>>  =20
>> -	/* Keep a private copy so we can reissue requests when recovering. *=
/
>> -	rinfo->shadow[id].req =3D *ring_req;
>> +	/* Copy request(s) to the ring page. */
>> +	*final_ring_req =3D *ring_req;
>>   	if (unlikely(require_extra_req))
>> -		rinfo->shadow[extra_id].req =3D *extra_ring_req;
>> +		*final_extra_ring_req =3D *extra_ring_req;
>=20
> ... are you sure all supported compilers will recognize the
> conditional use and not warn about use of a possibly uninitialized
> variable?

Hmm, probably better safe than sorry. Will change it.


Juergen

--------------D884FEC9E12ABF923568C4A9
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------D884FEC9E12ABF923568C4A9--

--3z0SaXV9bT9EMUHkBlogZ1gUM2CrDn6LJ--

--r1814kCXy88HKlk6GseNHQ5Jl1bQjvzK4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmCieXwFAwAAAAAACgkQsN6d1ii/Ey8E
nwf/b6Rnrwjrlv1zmZ3HhUue7Q9cl/SAVFjVfclytWJgqiZVWDpMOksl6hC1n93jfIItXpYQDtyn
9dvJ6u7gOKrKV+XFmJfhoxMevjfpznM68qdiEIxgbAf+nI/7EbyV6w2keI/FkR5SFcQcLgO8QhSv
beCxfIaVphAAvcCQo1Pd3QW0s9jqfyQY+GYuSjzLtrLggZFbwGhBwCCcyiofV6scsAwVYEmTF+Sg
zU/nVqZEM5FgpGj/ITxXCDK1LcIGkWwzTBub7lGK/0wPv9c5pIcLlWFOAApAPv6HL37e9f8Ul9Ot
VnCoqPVtM8ZgRnhNmleb5LNbGV/nn49CbDfyHuEyig==
=BHS7
-----END PGP SIGNATURE-----

--r1814kCXy88HKlk6GseNHQ5Jl1bQjvzK4--
