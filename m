Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D873B2D16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhFXK7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:59:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42860 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhFXK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:59:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AEBE31FD66;
        Thu, 24 Jun 2021 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624532242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aohsVJHp2dukzVgy3sPiqd3EnFTV33oF5VxC8G9YysI=;
        b=Jcp82zKzZ1UZdg/P7lzRA4469RSfb1U6pS4SWeFFfqvPfSrSj2zXc4G81N4pBhPCq7Vv3u
        poQDP2+j+VUAbvMGQyoDILDVqegTLoB+vD4SV3BSjtPAnYDLZsjBsZviIosn6xy4oc3iXm
        TmmbqIFywoqv5xJK8Vvw2ut/I4Wwj+o=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 59DC111A97;
        Thu, 24 Jun 2021 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624532242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aohsVJHp2dukzVgy3sPiqd3EnFTV33oF5VxC8G9YysI=;
        b=Jcp82zKzZ1UZdg/P7lzRA4469RSfb1U6pS4SWeFFfqvPfSrSj2zXc4G81N4pBhPCq7Vv3u
        poQDP2+j+VUAbvMGQyoDILDVqegTLoB+vD4SV3BSjtPAnYDLZsjBsZviIosn6xy4oc3iXm
        TmmbqIFywoqv5xJK8Vvw2ut/I4Wwj+o=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id W93QFBJl1GDFcgAALh3uQQ
        (envelope-from <jgross@suse.com>); Thu, 24 Jun 2021 10:57:22 +0000
Subject: Re: [PATCH v2 16/24] x86/xen: Make get_debugreg() noinstr
To:     Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
        rostedt@goodmis.org, dvyukov@google.com, elver@google.com
References: <20210624094059.886075998@infradead.org>
 <20210624095148.625523645@infradead.org>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <3da9f8b0-af99-769a-1898-df33a07aca0a@suse.com>
Date:   Thu, 24 Jun 2021 12:57:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210624095148.625523645@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J8bk5f2Q43YW8pMXEsHlIyXo6SpL79Nn5"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J8bk5f2Q43YW8pMXEsHlIyXo6SpL79Nn5
Content-Type: multipart/mixed; boundary="3IVDPmWs4EH0D2XPN194Tra35y1izLgN7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org,
 boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
 rostedt@goodmis.org, dvyukov@google.com, elver@google.com
Message-ID: <3da9f8b0-af99-769a-1898-df33a07aca0a@suse.com>
Subject: Re: [PATCH v2 16/24] x86/xen: Make get_debugreg() noinstr
References: <20210624094059.886075998@infradead.org>
 <20210624095148.625523645@infradead.org>
In-Reply-To: <20210624095148.625523645@infradead.org>

--3IVDPmWs4EH0D2XPN194Tra35y1izLgN7
Content-Type: multipart/mixed;
 boundary="------------B2ECC5B34A12B840F5C08541"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B2ECC5B34A12B840F5C08541
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 24.06.21 11:41, Peter Zijlstra wrote:
> vmlinux.o: warning: objtool: pv_ops[1]: xen_get_debugreg
> vmlinux.o: warning: objtool: pv_ops[1]: native_get_debugreg
> vmlinux.o: warning: objtool: exc_debug()+0x25: call to pv_ops[1]() leav=
es .noinstr.text section
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

--------------B2ECC5B34A12B840F5C08541
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

--------------B2ECC5B34A12B840F5C08541--

--3IVDPmWs4EH0D2XPN194Tra35y1izLgN7--

--J8bk5f2Q43YW8pMXEsHlIyXo6SpL79Nn5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmDUZREFAwAAAAAACgkQsN6d1ii/Ey8K
wQf+IwhEp3/KX3DiA5MwwoVaXqpnvmOLzFgoIBEL3/r6ykMan/aVBKoElZ2ePZew/JANsRJDJDWS
zwzGm3Uxt2UhGwFM/Tna/C7ULz5Lv4e2aZ2Qp99XFsX+BoKoFZ/es1frwTQg0Yl0yE5W/0O5FWow
0mROEoZKdtD7fKpVsA/aFW+zQRZNvt7n5TvDMRp5s1fU/80UXh8Cn0nTWnb5FawFUf+fw+JY/kbW
WJGeznqTwXPJrNhWNh50ZoL+jtDgcndqkxlvXGYdu3ECzmIzr/Xw9bx0Dgcqbs3HoAmSoL2Ymr/Q
DdIaQXTYsFZfBa0HMx6vQe4vMMx2nGLbxiMfj/6vfg==
=ds7y
-----END PGP SIGNATURE-----

--J8bk5f2Q43YW8pMXEsHlIyXo6SpL79Nn5--
