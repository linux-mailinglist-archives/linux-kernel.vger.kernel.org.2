Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0F33AB15F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFQKcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:32:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39274 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQKcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:32:50 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43EA121B07;
        Thu, 17 Jun 2021 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623925841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APrhnlbR6CPajc97zKcQcAIuVfRUr6SkhcSylryamRA=;
        b=WdKGZ/zZavFYbJ3yRBWYM8m+C0Yxu0X3sZawTKA/saRhf2LlUYFkW4/YYcFyFHuBlJ5zhI
        PDDL6K72W8BgtpNM6iJmkjM9HjsTZQ0OWeLDD42yrmXj02ztQXwamvcgyL3GS64PRsuam9
        hSrj7/y52jzX3HeBp7OsX3OmLPDrfws=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 17BC1118DD;
        Thu, 17 Jun 2021 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623925841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APrhnlbR6CPajc97zKcQcAIuVfRUr6SkhcSylryamRA=;
        b=WdKGZ/zZavFYbJ3yRBWYM8m+C0Yxu0X3sZawTKA/saRhf2LlUYFkW4/YYcFyFHuBlJ5zhI
        PDDL6K72W8BgtpNM6iJmkjM9HjsTZQ0OWeLDD42yrmXj02ztQXwamvcgyL3GS64PRsuam9
        hSrj7/y52jzX3HeBp7OsX3OmLPDrfws=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id yAmWBFEky2ByZQAALh3uQQ
        (envelope-from <jgross@suse.com>); Thu, 17 Jun 2021 10:30:41 +0000
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Linux 5.13-rc6 regression to 5.12.x: kernel OOM and panic during
 kernel boot in low memory Xen VM's (256MB assigned memory).
Message-ID: <6bcd447e-fd49-0519-a59e-478f84e9120f@suse.com>
Date:   Thu, 17 Jun 2021 12:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tc8GhS0WamFES6vdNMQyDXzLS0xnkwFuC"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tc8GhS0WamFES6vdNMQyDXzLS0xnkwFuC
Content-Type: multipart/mixed; boundary="oMJ6vYp76QKfRvdShaqUSUociYnrR3bDR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Sander Eikelenboom <linux@eikelenboom.it>,
 linux-kernel <linux-kernel@vger.kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <6bcd447e-fd49-0519-a59e-478f84e9120f@suse.com>
Subject: Re: Linux 5.13-rc6 regression to 5.12.x: kernel OOM and panic during
 kernel boot in low memory Xen VM's (256MB assigned memory).
References: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
In-Reply-To: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>

--oMJ6vYp76QKfRvdShaqUSUociYnrR3bDR
Content-Type: multipart/mixed;
 boundary="------------DDDAFBAD2DD8943AE90EF9C4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DDDAFBAD2DD8943AE90EF9C4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 17.06.21 11:26, Sander Eikelenboom wrote:
> L.S.,
>=20
> I just tried to upgrade and test the linux kernel going from the 5.12=20
> kernel series to 5.13-rc6 on my homeserver with Xen, but ran in some=20
> trouble.
>=20
> Some VM's boot fine (with more than 256MB memory assigned), but the=20
> smaller (memory wise) PVH ones crash during kernel boot due to OOM.
> Booting VM's with 5.12(.9) kernel still works fine, also when dom0 is=20
> running 5.13-rc6 (but it has more memory assigned, so that is not=20
> unexpected).
>=20
> The 5.13-rc6'ish kernel is a pull of today, tried both with and without=20

> last AKPM's patches, but that
> makes no difference.
>=20
> Below are stacktraces from a few of the crashing VM's.
>=20
> Attached is the kernel .config
>=20
> Any pointers ?

Did you compare memory usage with a bootable guest between kernel 5.12
and 5.13-rc6?

Any chance you could bisect?


Juergen

--------------DDDAFBAD2DD8943AE90EF9C4
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

--------------DDDAFBAD2DD8943AE90EF9C4--

--oMJ6vYp76QKfRvdShaqUSUociYnrR3bDR--

--Tc8GhS0WamFES6vdNMQyDXzLS0xnkwFuC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmDLJFAFAwAAAAAACgkQsN6d1ii/Ey//
+gf+N8kA12LDZZFA9C+AAo0/gsLkNV6l6YDuK/eI4nDGquKZYOKzF875l7wk117al6jIqZ1gOSIY
bhfiQdfi/KsEopT4o4ZVZzrqC8ifvY5esulkHVnLcSKSdQUjZnRuZ1zkKuMJDR8mm1D2j8k9A2QV
wgs98roioyYw68FG1MeTI1tp/mUUKCj3TYa1dEtN3tfNT6JhcrafhzCKweJMFAV9SlGdcSlPmG7H
xdRtuA7wRqin7ABrhMKFr6Wyk7uGDU4VUQIaQ63wp72zGYtCWbP5k2W8xQohfcU3DwJ8p0yvMJtu
D4h7g7W5wT+1yk1TXeudFHsBZJ6SNbiE79CXtBAmww==
=fNLs
-----END PGP SIGNATURE-----

--Tc8GhS0WamFES6vdNMQyDXzLS0xnkwFuC--
