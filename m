Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21B3B2CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhFXKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:53:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFXKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:53:39 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB50F1FD35;
        Thu, 24 Jun 2021 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624531879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WBngdM/kKGG4TeJhVtcyUyOfgd7Jqf8emZ2iaIQ6K0=;
        b=ElubG+IUqna8MUoq7Enb69A6Z2K9LoWe+sNVRmbfzhhvFSSYwZGD3VMH8Kfr3Zot21I+Hx
        QyLNk03evrCYlRX23wmJR5nhAIilVCY0qlguqBvcoL78ZclL2VO+4fQANJRVKozm0+9/po
        lAvTa9LQBwpl+ThoZDgdKnAspR68Uhs=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7C42911A97;
        Thu, 24 Jun 2021 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624531879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WBngdM/kKGG4TeJhVtcyUyOfgd7Jqf8emZ2iaIQ6K0=;
        b=ElubG+IUqna8MUoq7Enb69A6Z2K9LoWe+sNVRmbfzhhvFSSYwZGD3VMH8Kfr3Zot21I+Hx
        QyLNk03evrCYlRX23wmJR5nhAIilVCY0qlguqBvcoL78ZclL2VO+4fQANJRVKozm0+9/po
        lAvTa9LQBwpl+ThoZDgdKnAspR68Uhs=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id CHT2HKdj1GBVbwAALh3uQQ
        (envelope-from <jgross@suse.com>); Thu, 24 Jun 2021 10:51:19 +0000
Subject: Re: [PATCH v2 12/24] x86/paravirt: Mark arch_local_irq_*()
 __always_inline
To:     Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
        rostedt@goodmis.org, dvyukov@google.com, elver@google.com
References: <20210624094059.886075998@infradead.org>
 <20210624095148.373073648@infradead.org>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <20ec3a66-36fa-d839-844d-055ad13e7901@suse.com>
Date:   Thu, 24 Jun 2021 12:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210624095148.373073648@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JQ7ygop8GzWNIBhgNy4bG5knsXSz9WKsL"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JQ7ygop8GzWNIBhgNy4bG5knsXSz9WKsL
Content-Type: multipart/mixed; boundary="m4QxypbeP4k9BMrPivZozu9z5lAwl04Ev";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org,
 boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
 rostedt@goodmis.org, dvyukov@google.com, elver@google.com
Message-ID: <20ec3a66-36fa-d839-844d-055ad13e7901@suse.com>
Subject: Re: [PATCH v2 12/24] x86/paravirt: Mark arch_local_irq_*()
 __always_inline
References: <20210624094059.886075998@infradead.org>
 <20210624095148.373073648@infradead.org>
In-Reply-To: <20210624095148.373073648@infradead.org>

--m4QxypbeP4k9BMrPivZozu9z5lAwl04Ev
Content-Type: multipart/mixed;
 boundary="------------251CA5D933F6A3749EB5BFE4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------251CA5D933F6A3749EB5BFE4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 24.06.21 11:41, Peter Zijlstra wrote:
> vmlinux.o: warning: objtool: lockdep_hardirqs_on()+0x72: call to arch_l=
ocal_save_flags() leaves .noinstr.text section
> vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x73: call to arch_=
local_save_flags() leaves .noinstr.text section
> vmlinux.o: warning: objtool: match_held_lock()+0x11f: call to arch_loca=
l_save_flags() leaves .noinstr.text section
>=20
> vmlinux.o: warning: objtool: lock_is_held_type()+0x4e: call to arch_loc=
al_irq_save() leaves .noinstr.text section
>=20
> vmlinux.o: warning: objtool: lock_is_held_type()+0x65: call to arch_loc=
al_irq_disable() leaves .noinstr.text section
>=20
> vmlinux.o: warning: objtool: lock_is_held_type()+0xfe: call to arch_loc=
al_irq_enable() leaves .noinstr.text section
>=20
> It makes no sense to not inline these things.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

--------------251CA5D933F6A3749EB5BFE4
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

--------------251CA5D933F6A3749EB5BFE4--

--m4QxypbeP4k9BMrPivZozu9z5lAwl04Ev--

--JQ7ygop8GzWNIBhgNy4bG5knsXSz9WKsL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmDUY6YFAwAAAAAACgkQsN6d1ii/Ey+9
fQf/emnfCUFCvSK1MJ3Am2PWOS8SlMRoRJGY/+5gyP4LUApIpBdfnFpluVP4XGA/ym9wjzluq3aX
3VyZl1OIjwc4XT+nm3sd6WQ3GD0VT9diq1U5w7yO1V3GRyuq2mvjuteHXQrTnmZv3wOI/eXMhN4p
tik5ifHJoyGVS7ZT+tyGcSbJ3ZkuTeGlUIe0Y+a4p68esr48Y2LOAb73QS0OjtisrLZE6Zq4kxE9
iX2r1YFqL6GIzXG6SpjjueYrI5LnbxZgFfOxKzqFeqi8nDNpfgPk2Q+yL9IkP3g+DWuqPURuHkk2
8Ai8fZAe81+LYCKlKp070gB/jtGni1q2mZmKzimQIg==
=wigj
-----END PGP SIGNATURE-----

--JQ7ygop8GzWNIBhgNy4bG5knsXSz9WKsL--
