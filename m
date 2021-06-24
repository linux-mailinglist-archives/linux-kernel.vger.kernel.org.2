Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6093B2EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFXMPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:15:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:15:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0D91B1FD40;
        Thu, 24 Jun 2021 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624536772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ceNBH4iwUVdGLF5YmYvlu0i067REAsaq+P6HLfQ3Ius=;
        b=dLxWru8uW6d1Zk0r+/29xONj1EpcOv5qrJBEGm8tDlax5ZbLYI4sDbR0ak3a0jFn+TU39+
        rsxeVVQdGJx0J3YjBcMBnhuBy40agVGyBemrEwQ3absriMcWNchvJeYrmDPxZdPp13o4q7
        pAY41HitAILJ+93RJiQqDrk8y74ZiWc=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A025D11A97;
        Thu, 24 Jun 2021 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624536772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ceNBH4iwUVdGLF5YmYvlu0i067REAsaq+P6HLfQ3Ius=;
        b=dLxWru8uW6d1Zk0r+/29xONj1EpcOv5qrJBEGm8tDlax5ZbLYI4sDbR0ak3a0jFn+TU39+
        rsxeVVQdGJx0J3YjBcMBnhuBy40agVGyBemrEwQ3absriMcWNchvJeYrmDPxZdPp13o4q7
        pAY41HitAILJ+93RJiQqDrk8y74ZiWc=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id kWwjJcN21GBHNAAALh3uQQ
        (envelope-from <jgross@suse.com>); Thu, 24 Jun 2021 12:12:51 +0000
To:     Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
        rostedt@goodmis.org, dvyukov@google.com, elver@google.com
References: <20210624094059.886075998@infradead.org>
 <20210624095149.057262522@infradead.org>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 23/24] x86/xen: Rework the xen_{cpu,irq,mmu}_ops[]
 arrays
Message-ID: <78d6b193-f248-559c-b153-9af571daa0d7@suse.com>
Date:   Thu, 24 Jun 2021 14:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210624095149.057262522@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DIhsxjjywGPez3IwGnDFCwmh49S1BGylk"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DIhsxjjywGPez3IwGnDFCwmh49S1BGylk
Content-Type: multipart/mixed; boundary="dGxjdl1rXG0oMoq3MxBIDf0axIRHsEVER";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org,
 boris.ostrovsky@oracle.com, x86@kernel.org, mbenes@suse.com,
 rostedt@goodmis.org, dvyukov@google.com, elver@google.com
Message-ID: <78d6b193-f248-559c-b153-9af571daa0d7@suse.com>
Subject: Re: [PATCH v2 23/24] x86/xen: Rework the xen_{cpu,irq,mmu}_ops[]
 arrays
References: <20210624094059.886075998@infradead.org>
 <20210624095149.057262522@infradead.org>
In-Reply-To: <20210624095149.057262522@infradead.org>

--dGxjdl1rXG0oMoq3MxBIDf0axIRHsEVER
Content-Type: multipart/mixed;
 boundary="------------CEEC1E169E98944C35B13CAB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CEEC1E169E98944C35B13CAB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 24.06.21 11:41, Peter Zijlstra wrote:
> In order to allow objtool to make sense of all the various paravirt
> functions, it needs to either parse whole pv_ops[] tables, or observe
> individual assignments in the form:
>=20
>    bf87:       48 c7 05 00 00 00 00 00 00 00 00        movq   $0x0,0x0(=
%rip)
>      bf92 <xen_init_spinlocks+0x5f>
>      bf8a: R_X86_64_PC32     pv_ops+0x268
>=20
> As is, xen_cpu_ops[] is at offset +0 in pv_ops[] and could thus be
> parsed as a 'normal' pv_ops[] table, however xen_irq_ops[] and
> xen_mmu_ops[] are not.
>=20
> Worse, both the latter two are compiled into the individual assignment
> for by current GCC, but that's not something one can rely on.
>=20
> Therefore, convert all three into full pv_ops[] tables. This has the
> benefit of not needing to teach objtool about the offsets and
> resulting in more conservative code-gen.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

First I was worried by the additional memory consumption, but as the
modified tables are all tagged to be __init I don't think this matters.

So:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

--------------CEEC1E169E98944C35B13CAB
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

--------------CEEC1E169E98944C35B13CAB--

--dGxjdl1rXG0oMoq3MxBIDf0axIRHsEVER--

--DIhsxjjywGPez3IwGnDFCwmh49S1BGylk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmDUdsMFAwAAAAAACgkQsN6d1ii/Ey/y
YQf/e6cDHVUhti9aP1mCzpKWEg2wqN3JGH6h1/9X6WLYifRnSNJCszJ3t/q5JfiSAWgKLfo/MRTX
xVWDD8fWbaNvP9ZQy5E5rqZwbCvuCyWZV7Sk1q3aBO4ieQPsaQt027h3kFXnwds62Y6OvXhAskqY
6WGM/A2gC0oGkbim8sEW5wdOaI9gIN/F6xLYW1qsEMvHJ36qZHTrslyt/V2O71dDOSmY4JqqbJFX
KoywPbwNHa16+SO9AOII3j1WgciugWKAR7ZmO3mOLqNVuykM0PI5ws3FAGEELwf6IaVIxMjBeva2
VDeT67s99f9nzn9shBRmyH0rzSOutTwQmuDjAiPizQ==
=PadN
-----END PGP SIGNATURE-----

--DIhsxjjywGPez3IwGnDFCwmh49S1BGylk--
