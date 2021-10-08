Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A676426D27
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbhJHPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:03:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJHPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:03:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A9D5F2013C;
        Fri,  8 Oct 2021 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633705268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTmJjwWYpgJRxKxqh+A0XL1gjrL3z4c9tzCY8gjWfVM=;
        b=PTWeldhvb48+0aWv5/SWZ7qPZd2WAdTM32s+LF/t2Sny8p8kycBf0uC7EZbCgkyl2QmwL6
        wXoD1HH//dBXFRO3i1aOx0+5QE6Y9JWNawfpoWzGMhVLjvJsiCYcFSSzTERc3Ms56BEBFv
        YdqWuOCo932rJuvonoMbl8Mkq1awwb4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7709E13F34;
        Fri,  8 Oct 2021 15:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UpzAGzRdYGEmFAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 08 Oct 2021 15:01:08 +0000
Subject: Re: [PATCH -next] xen-pciback: Fix return in pm_ctrl_init()
To:     YueHaibing <yuehaibing@huawei.com>, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20211008074417.8260-1-yuehaibing@huawei.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <6644d095-92da-261e-87aa-284dcfcde19a@suse.com>
Date:   Fri, 8 Oct 2021 17:01:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211008074417.8260-1-yuehaibing@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="74fWohrbqa2rr9qo8uGOPDLhy3Qyw7dN0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--74fWohrbqa2rr9qo8uGOPDLhy3Qyw7dN0
Content-Type: multipart/mixed; boundary="fLFGg4UaNIXRVnMEKAwtYSZl8DOEctpv5";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: YueHaibing <yuehaibing@huawei.com>, boris.ostrovsky@oracle.com,
 sstabellini@kernel.org
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <6644d095-92da-261e-87aa-284dcfcde19a@suse.com>
Subject: Re: [PATCH -next] xen-pciback: Fix return in pm_ctrl_init()
References: <20211008074417.8260-1-yuehaibing@huawei.com>
In-Reply-To: <20211008074417.8260-1-yuehaibing@huawei.com>

--fLFGg4UaNIXRVnMEKAwtYSZl8DOEctpv5
Content-Type: multipart/mixed;
 boundary="------------078EAB46C6BDE2629852734D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------078EAB46C6BDE2629852734D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 08.10.21 09:44, YueHaibing wrote:
> Return NULL instead of passing to ERR_PTR while err is zero,
> this fix smatch warnings:
> drivers/xen/xen-pciback/conf_space_capability.c:163
>   pm_ctrl_init() warn: passing zero to 'ERR_PTR'
>=20
> Fixes: a92336a1176b ("xen/pciback: Drop two backends, squash and cleanu=
p some code.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

--------------078EAB46C6BDE2629852734D
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

--------------078EAB46C6BDE2629852734D--

--fLFGg4UaNIXRVnMEKAwtYSZl8DOEctpv5--

--74fWohrbqa2rr9qo8uGOPDLhy3Qyw7dN0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmFgXTMFAwAAAAAACgkQsN6d1ii/Ey+v
2Af/Z/DOLq7EJ1rP9+8Y405lDW25db2lneFBlTO/v9OfAHJ4AwCB8NSv8cVrlHlwRO3a9ogNi0Al
IFclN+L8UndG0k/xX7iFcZwom6nHTO6NioqwR2jEj++QBSfBKY+KWM5vYMSZOQwPTfIQP3HGJd6d
ipqMHbcBHiteYNh+WYBBnhrBCnWhOCQKZzIN1NSGIBX9/Fv6JptWHDhjdlZF1d7eVVlMfcl151F3
7EQMORqsCkUOK1mfk+L6w++pBhJtqX+72AjlLni08kkL7WobCaiYNGqZBZmyLO1K/U1WwOXx9BFd
L0UpVPrp1cQCdtWOj4bz9fgi/oG1JB8AAVDKiVJAow==
=45gc
-----END PGP SIGNATURE-----

--74fWohrbqa2rr9qo8uGOPDLhy3Qyw7dN0--
