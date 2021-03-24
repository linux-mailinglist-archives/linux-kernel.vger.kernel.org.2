Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698EE3475B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhCXKSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:18:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:43452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhCXKSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:18:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616581085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTvmyidz8Oj5Q62By7afuPNkzwrVbqlumoiFNf1u3Uw=;
        b=C9UVgowG5DBIafliMcKuEe/FBQVeZ1Gq6tb6P7wWrglC6yfp7l6ro7Zik3Sx9mU7WHtRr+
        iskNkrxFq1Yy+8RGGZAVWaD4vphaMfAD1uX9FrId5Ty5zUwwEHY7ssBORvYvgJ+bMPQg4H
        vJvyAu1mqDtoAHsWjHM13h1hZvVaMkc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DECDBAF75;
        Wed, 24 Mar 2021 10:18:04 +0000 (UTC)
To:     linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, mhocko@suse.com, peterz@infradead.org
References: <20210302062838.14267-1-jgross@suse.com>
 <20210302062838.14267-4-jgross@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH v3 3/4] kernel/smp: add more data to CSD lock debugging
Message-ID: <7babbca6-1325-7a3a-d1f0-13a8dbf8043f@suse.com>
Date:   Wed, 24 Mar 2021 11:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302062838.14267-4-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sWzupFFnal6izbAvQRtpxAFqGIVz3gNsp"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sWzupFFnal6izbAvQRtpxAFqGIVz3gNsp
Content-Type: multipart/mixed; boundary="brcUQ3dccFlmRrPy8quZ8Oacj17WZub5t";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org, mhocko@suse.com, peterz@infradead.org
Message-ID: <7babbca6-1325-7a3a-d1f0-13a8dbf8043f@suse.com>
Subject: Re: [PATCH v3 3/4] kernel/smp: add more data to CSD lock debugging
References: <20210302062838.14267-1-jgross@suse.com>
 <20210302062838.14267-4-jgross@suse.com>
In-Reply-To: <20210302062838.14267-4-jgross@suse.com>

--brcUQ3dccFlmRrPy8quZ8Oacj17WZub5t
Content-Type: multipart/mixed;
 boundary="------------380EB0ED0274093276BCBEDC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------380EB0ED0274093276BCBEDC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 02.03.21 07:28, Juergen Gross wrote:
> In order to help identifying problems with IPI handling and remote
> function execution add some more data to IPI debugging code.
>=20
> There have been multiple reports of cpus looping long times (many
> seconds) in smp_call_function_many() waiting for another cpu executing
> a function like tlb flushing. Most of these reports have been for
> cases where the kernel was running as a guest on top of KVM or Xen
> (there are rumours of that happening under VMWare, too, and even on
> bare metal).
>=20
> Finding the root cause hasn't been successful yet, even after more than=

> 2 years of chasing this bug by different developers.
>=20
> Commit 35feb60474bf4f7 ("kernel/smp: Provide CSD lock timeout
> diagnostics") tried to address this by adding some debug code and by
> issuing another IPI when a hang was detected. This helped mitigating
> the problem (the repeated IPI unlocks the hang), but the root cause is
> still unknown.
>=20
> Current available data suggests that either an IPI wasn't sent when it
> should have been, or that the IPI didn't result in the target cpu
> executing the queued function (due to the IPI not reaching the cpu,
> the IPI handler not being called, or the handler not seeing the queued
> request).
>=20
> Try to add more diagnostic data by introducing a global atomic counter
> which is being incremented when doing critical operations (before and
> after queueing a new request, when sending an IPI, and when dequeueing
> a request). The counter value is stored in percpu variables which can
> be printed out when a hang is detected.
>=20
> The data of the last event (consisting of sequence counter, source
> cpu, target cpu, and event type) is stored in a global variable. When
> a new event is to be traced, the data of the last event is stored in
> the event related percpu location and the global data is updated with
> the new event's data. This allows to track two events in one data
> location: one by the value of the event data (the event before the
> current one), and one by the location itself (the current event).
>=20
> A typical printout with a detected hang will look like this:
>=20
> csd: Detected non-responsive CSD lock (#1) on CPU#1, waiting 5000000003=
 ns for CPU#06 scf_handler_1+0x0/0x50(0xffffa2a881bb1410).
> 	csd: CSD lock (#1) handling prior scf_handler_1+0x0/0x50(0xffffa2a8813=
823c0) request.
>          csd: cnt(00008cc): ffff->0000 dequeue (src cpu 0 =3D=3D empty)=

>          csd: cnt(00008cd): ffff->0006 idle
>          csd: cnt(0003668): 0001->0006 queue
>          csd: cnt(0003669): 0001->0006 ipi
>          csd: cnt(0003e0f): 0007->000a queue
>          csd: cnt(0003e10): 0001->ffff ping
>          csd: cnt(0003e71): 0003->0000 ping
>          csd: cnt(0003e72): ffff->0006 gotipi
>          csd: cnt(0003e73): ffff->0006 handle
>          csd: cnt(0003e74): ffff->0006 dequeue (src cpu 0 =3D=3D empty)=

>          csd: cnt(0003e7f): 0004->0006 ping
>          csd: cnt(0003e80): 0001->ffff pinged
>          csd: cnt(0003eb2): 0005->0001 noipi
>          csd: cnt(0003eb3): 0001->0006 queue
>          csd: cnt(0003eb4): 0001->0006 noipi
>          csd: cnt now: 0003f00
>=20
> This example (being an artificial one, produced with a previous version=

> of this patch without the "hdlend" event), shows that cpu#6 started to
> handle an IPI (cnt 3e72-3e74), bit didn't start to handle another IPI
> (sent by cpu#4, cnt 3e7f). The next request from cpu#1 for cpu#6 was
> queued (3eb3), but no IPI was needed (cnt 3eb4, there was the event
> from cpu#4 in the queue already).
>=20
> The idea is to print only relevant entries. Those are all events which
> are associated with the hang (so sender side events for the source cpu
> of the hanging request, and receiver side events for the target cpu),
> and the related events just before those (for adding data needed to
> identify a possible race). Printing all available data would be
> possible, but this would add large amounts of data printed on larger
> configurations.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

Just an update regarding current status with debugging the underlying
issue:

On a customer's machine with a backport of this patch applied we've
seen another case of the hang. In the logs we've found:

smp: csd: Detected non-responsive CSD lock (#1) on CPU#18, waiting=20
5000000046 ns for CPU#06 do_flush_tlb_all+0x0/0x30(          (null)).
smp: 	csd: CSD lock (#1) unresponsive.
smp: 	csd: cnt(0000000): 0000->0000 queue
smp: 	csd: cnt(0000001): ffff->0006 idle
smp: 	csd: cnt(0025dba): 0012->0006 queue
smp: 	csd: cnt(0025dbb): 0012->0006 noipi
smp: 	csd: cnt(01d1333): 001a->0006 pinged
smp: 	csd: cnt(01d1334): ffff->0006 gotipi
smp: 	csd: cnt(01d1335): ffff->0006 handle
smp: 	csd: cnt(01d1336): ffff->0006 dequeue (src cpu 0 =3D=3D empty)
smp: 	csd: cnt(01d1337): ffff->0006 hdlend (src cpu 0 =3D=3D early)
smp: 	csd: cnt(01d16cb): 0012->0005 ipi
smp: 	csd: cnt(01d16cc): 0012->0006 queue
smp: 	csd: cnt(01d16cd): 0012->0006 ipi
smp: 	csd: cnt(01d16f3): 0012->001a ipi
smp: 	csd: cnt(01d16f4): 0012->ffff ping
smp: 	csd: cnt(01d1750): ffff->0018 hdlend (src cpu 0 =3D=3D early)
smp: 	csd: cnt(01d1751): 0012->ffff pinged
smp: 	csd: cnt now: 01d1769

So we see that cpu#18 (0012 hex) is waiting for cpu#06 (first line of=20
the data).

The next 4 lines of the csd actions are not really interesting, as they=20
are rather old.

Then we see that cpu 0006 did handle a request rather recently (cnt=20
01d1333 - 01d1337): cpu 001a pinged it via an IPI and it got the IPI,=20
entered the handler, dequeued a request, and handled it.

Nearly all of the rest shows the critical request: cpu 0012 did a loop=20
over probably all other cpus and queued the requests and marked them to=20
be IPI-ed (including cpu 0006, cnt 01d16cd). Then the cpus marked to=20
receive an IPI were pinged (cnt 01d16f4 and cnt 01d1751).

The entry cnt 01d1750 is not of interest here.

This data confirms that on sending side everything seems to be okay at=20
the level above the actual IPI sending. On receiver side there seems no=20
IPI to be seen, but there is no visible reason for a race either.

It seems as if we need more debugging in the deeper layers: is the IPI
really sent out, and is something being received on the destination cpu?
I'll have another try with even more debugging code, probably in private
on the customer machine first.


Juergen

--------------380EB0ED0274093276BCBEDC
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

--------------380EB0ED0274093276BCBEDC--

--brcUQ3dccFlmRrPy8quZ8Oacj17WZub5t--

--sWzupFFnal6izbAvQRtpxAFqGIVz3gNsp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmBbEdsFAwAAAAAACgkQsN6d1ii/Ey/h
SQf9EBFS5BB0JDhd3q5qq4IOG70BAyrj/IN+KyNWkkbARPYgVBdGGWRhmnC2D1kKWExlbBVulK1F
YzhuMOsT6m7rtqj0HKlh0NAOGIae9WRtZGqYo5sj2axlcsh7JJ48XD16niQEwPZN/b/Ce7pfMyvT
bdt4AJ2VOw+ENdYD+NGxLpM9Tsjju+lZeC9bV0KngDAcQ9gz5Ag3+w0CgX+cxsPTVnmqgcGiDiNW
SFgyFWIPaTC6K2QQ8u3NEPsce2pmcARAsRsiq1gzOkjQtdUJXJEmkBG0MQB9SG5NwCjlhv2RPaO6
0GM3yVs46ds3Z4ZDBS6DoA95M2U3bKeurFRuNTGulQ==
=kLpu
-----END PGP SIGNATURE-----

--sWzupFFnal6izbAvQRtpxAFqGIVz3gNsp--
