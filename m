Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E734C4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhC2HYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:24:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC2HYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:24:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617002647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fW7kfOE/p2R8a+wpdjmOIjK4yzLS0Wgi3hjUq2YWuoI=;
        b=P8Vbr4RcnlDtTKqfjkwruCJ5xSvi7yDGmcD2O0EZkvfllddiwWWoNemf/rJagJZSxeqxuW
        jJL3mw4OMxvxMkadNazMAhi0qIA+VFCdoAJti992UZkks4A54O+2ON0r9rsHeKRj16l19R
        5Cga6xu/WZPnKmpfCBH6tln18lPBxUg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D351FB331;
        Mon, 29 Mar 2021 07:24:06 +0000 (UTC)
Subject: Re: [PATCH] xen/pciback: Fix incorrect type warnings
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com,
        dan.carpenter@oracle.com
References: <20210326181442.GA1735905@LEGION>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <c619fb6c-6957-5b87-b0a1-6be96f8771db@suse.com>
Date:   Mon, 29 Mar 2021 09:24:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210326181442.GA1735905@LEGION>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zDwD3vRcZHWEDpgn1mD1x7LjBqmgFkwmR"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zDwD3vRcZHWEDpgn1mD1x7LjBqmgFkwmR
Content-Type: multipart/mixed; boundary="RCllf4ZADu7Gy7ashMgetdyJxPJ4bWqZo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Muhammad Usama Anjum <musamaanjum@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>,
 open list <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 colin.king@canonical.com, dan.carpenter@oracle.com
Message-ID: <c619fb6c-6957-5b87-b0a1-6be96f8771db@suse.com>
Subject: Re: [PATCH] xen/pciback: Fix incorrect type warnings
References: <20210326181442.GA1735905@LEGION>
In-Reply-To: <20210326181442.GA1735905@LEGION>

--RCllf4ZADu7Gy7ashMgetdyJxPJ4bWqZo
Content-Type: multipart/mixed;
 boundary="------------130E490ED841A55D5DFA7DD7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------130E490ED841A55D5DFA7DD7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 26.03.21 19:14, Muhammad Usama Anjum wrote:
> Correct enum pci_channel_io_normal should be used instead of putting
> integer value 1.
>=20
> Fix following smatch warnings:
> drivers/xen/xen-pciback/pci_stub.c:805:40: warning: incorrect type in a=
rgument 2 (different base types)
> drivers/xen/xen-pciback/pci_stub.c:805:40:    expected restricted pci_c=
hannel_state_t [usertype] state
> drivers/xen/xen-pciback/pci_stub.c:805:40:    got int
> drivers/xen/xen-pciback/pci_stub.c:862:40: warning: incorrect type in a=
rgument 2 (different base types)
> drivers/xen/xen-pciback/pci_stub.c:862:40:    expected restricted pci_c=
hannel_state_t [usertype] state
> drivers/xen/xen-pciback/pci_stub.c:862:40:    got int
> drivers/xen/xen-pciback/pci_stub.c:973:31: warning: incorrect type in a=
rgument 2 (different base types)
> drivers/xen/xen-pciback/pci_stub.c:973:31:    expected restricted pci_c=
hannel_state_t [usertype] state
> drivers/xen/xen-pciback/pci_stub.c:973:31:    got int
>=20
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

--------------130E490ED841A55D5DFA7DD7
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
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

--------------130E490ED841A55D5DFA7DD7--

--RCllf4ZADu7Gy7ashMgetdyJxPJ4bWqZo--

--zDwD3vRcZHWEDpgn1mD1x7LjBqmgFkwmR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmBhgJUFAwAAAAAACgkQsN6d1ii/Ey/w
Mwf8DoQ9GdcZMfTUu3dq5cdV/Wuo16UhK1ovEcanG1TikziyQipetP6A1LtuJtvchJfphXSktXJy
RFKdJiDuv6PlXZUyngs3PIJTChHqT2Xx+NOfKUGDFXQ6cwOYlM96Ug1+yd15gD/pBFWXPj8yeDwk
Ak7JeAMVI8p7oUO5qs6ophSm4BFLQGV43Xa8nLd0Nk6kbkGse1JZiRjk52f3K+wupi0EXBXem/vW
IOskkV0SeY+s0vYMHh1lwng9a6aqUWnAlANRF9FuyJNZTrhtguOVFMX5hxsoOekTLJW5pIN9LDXm
sZeqMQWtYoKoTsFfSXkCD4fGEF9EOhWZYRQn60s2Aw==
=/lIM
-----END PGP SIGNATURE-----

--zDwD3vRcZHWEDpgn1mD1x7LjBqmgFkwmR--
