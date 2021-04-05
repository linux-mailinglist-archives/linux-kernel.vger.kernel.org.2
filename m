Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A934353C33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhDEHhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:37:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:47230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhDEHhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:37:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617608261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpRGOs5Yl0oVZqKcPpAWqbMxi7Hw0k/Dl6stNDK25OA=;
        b=Y/3RbibAF1uTD2PDvR0Ehhuh4WnRsdHh+I054foAss3h10Vc1BX/kGMRiGcjJKnPRNYiZm
        GYAG1PSIUhpVXVTUlpI5RroDhBRKM6pTmAFdFNddFQk3BcARyq2vmlzzt8UtNUblZKTyPS
        G2v2ogaKWVkfvVBW3uaH82lphtMCgp8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0317BB12A;
        Mon,  5 Apr 2021 07:37:41 +0000 (UTC)
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, peterz@infradead.org
References: <20210302062838.14267-1-jgross@suse.com>
 <20210302062838.14267-4-jgross@suse.com>
 <7babbca6-1325-7a3a-d1f0-13a8dbf8043f@suse.com>
 <20210330173344.GX2696@paulmck-ThinkPad-P72>
 <5881c48a-0429-199c-8669-5fbceda0a283@suse.com>
 <20210402161105.GS2696@paulmck-ThinkPad-P72>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 3/4] kernel/smp: add more data to CSD lock debugging
Message-ID: <e2e75e97-b4ec-670d-1632-3d6cd529ae8c@suse.com>
Date:   Mon, 5 Apr 2021 09:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210402161105.GS2696@paulmck-ThinkPad-P72>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Sp3PkDpFznHyPnnsKOlrFrCD3fvVXJwL2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sp3PkDpFznHyPnnsKOlrFrCD3fvVXJwL2
Content-Type: multipart/mixed; boundary="wlJO9IeEmbLxOsC0LIwbEL2EYHhIeIRn3";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.com, peterz@infradead.org
Message-ID: <e2e75e97-b4ec-670d-1632-3d6cd529ae8c@suse.com>
Subject: Re: [PATCH v3 3/4] kernel/smp: add more data to CSD lock debugging
References: <20210302062838.14267-1-jgross@suse.com>
 <20210302062838.14267-4-jgross@suse.com>
 <7babbca6-1325-7a3a-d1f0-13a8dbf8043f@suse.com>
 <20210330173344.GX2696@paulmck-ThinkPad-P72>
 <5881c48a-0429-199c-8669-5fbceda0a283@suse.com>
 <20210402161105.GS2696@paulmck-ThinkPad-P72>
In-Reply-To: <20210402161105.GS2696@paulmck-ThinkPad-P72>

--wlJO9IeEmbLxOsC0LIwbEL2EYHhIeIRn3
Content-Type: multipart/mixed;
 boundary="------------4754E5CB2C40B4A5D6940D8A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4754E5CB2C40B4A5D6940D8A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 02.04.21 18:11, Paul E. McKenney wrote:
> On Fri, Apr 02, 2021 at 05:46:52PM +0200, Juergen Gross wrote:
>> On 30.03.21 19:33, Paul E. McKenney wrote:
>>> On Wed, Mar 24, 2021 at 11:18:03AM +0100, J=C3=BCrgen Gro=C3=9F wrote=
:
>>>> On 02.03.21 07:28, Juergen Gross wrote:
>>>>> In order to help identifying problems with IPI handling and remote
>>>>> function execution add some more data to IPI debugging code.
>>>>>
>>>>> There have been multiple reports of cpus looping long times (many
>>>>> seconds) in smp_call_function_many() waiting for another cpu execut=
ing
>>>>> a function like tlb flushing. Most of these reports have been for
>>>>> cases where the kernel was running as a guest on top of KVM or Xen
>>>>> (there are rumours of that happening under VMWare, too, and even on=

>>>>> bare metal).
>>>>>
>>>>> Finding the root cause hasn't been successful yet, even after more =
than
>>>>> 2 years of chasing this bug by different developers.
>>>>>
>>>>> Commit 35feb60474bf4f7 ("kernel/smp: Provide CSD lock timeout
>>>>> diagnostics") tried to address this by adding some debug code and b=
y
>>>>> issuing another IPI when a hang was detected. This helped mitigatin=
g
>>>>> the problem (the repeated IPI unlocks the hang), but the root cause=
 is
>>>>> still unknown.
>>>>>
>>>>> Current available data suggests that either an IPI wasn't sent when=
 it
>>>>> should have been, or that the IPI didn't result in the target cpu
>>>>> executing the queued function (due to the IPI not reaching the cpu,=

>>>>> the IPI handler not being called, or the handler not seeing the que=
ued
>>>>> request).
>>>>>
>>>>> Try to add more diagnostic data by introducing a global atomic coun=
ter
>>>>> which is being incremented when doing critical operations (before a=
nd
>>>>> after queueing a new request, when sending an IPI, and when dequeue=
ing
>>>>> a request). The counter value is stored in percpu variables which c=
an
>>>>> be printed out when a hang is detected.
>>>>>
>>>>> The data of the last event (consisting of sequence counter, source
>>>>> cpu, target cpu, and event type) is stored in a global variable. Wh=
en
>>>>> a new event is to be traced, the data of the last event is stored i=
n
>>>>> the event related percpu location and the global data is updated wi=
th
>>>>> the new event's data. This allows to track two events in one data
>>>>> location: one by the value of the event data (the event before the
>>>>> current one), and one by the location itself (the current event).
>>>>>
>>>>> A typical printout with a detected hang will look like this:
>>>>>
>>>>> csd: Detected non-responsive CSD lock (#1) on CPU#1, waiting 500000=
0003 ns for CPU#06 scf_handler_1+0x0/0x50(0xffffa2a881bb1410).
>>>>> 	csd: CSD lock (#1) handling prior scf_handler_1+0x0/0x50(0xffffa2a=
8813823c0) request.
>>>>>            csd: cnt(00008cc): ffff->0000 dequeue (src cpu 0 =3D=3D =
empty)
>>>>>            csd: cnt(00008cd): ffff->0006 idle
>>>>>            csd: cnt(0003668): 0001->0006 queue
>>>>>            csd: cnt(0003669): 0001->0006 ipi
>>>>>            csd: cnt(0003e0f): 0007->000a queue
>>>>>            csd: cnt(0003e10): 0001->ffff ping
>>>>>            csd: cnt(0003e71): 0003->0000 ping
>>>>>            csd: cnt(0003e72): ffff->0006 gotipi
>>>>>            csd: cnt(0003e73): ffff->0006 handle
>>>>>            csd: cnt(0003e74): ffff->0006 dequeue (src cpu 0 =3D=3D =
empty)
>>>>>            csd: cnt(0003e7f): 0004->0006 ping
>>>>>            csd: cnt(0003e80): 0001->ffff pinged
>>>>>            csd: cnt(0003eb2): 0005->0001 noipi
>>>>>            csd: cnt(0003eb3): 0001->0006 queue
>>>>>            csd: cnt(0003eb4): 0001->0006 noipi
>>>>>            csd: cnt now: 0003f00
>>>>>
>>>>> This example (being an artificial one, produced with a previous ver=
sion
>>>>> of this patch without the "hdlend" event), shows that cpu#6 started=
 to
>>>>> handle an IPI (cnt 3e72-3e74), bit didn't start to handle another I=
PI
>>>>> (sent by cpu#4, cnt 3e7f). The next request from cpu#1 for cpu#6 wa=
s
>>>>> queued (3eb3), but no IPI was needed (cnt 3eb4, there was the event=

>>>>> from cpu#4 in the queue already).
>>>>>
>>>>> The idea is to print only relevant entries. Those are all events wh=
ich
>>>>> are associated with the hang (so sender side events for the source =
cpu
>>>>> of the hanging request, and receiver side events for the target cpu=
),
>>>>> and the related events just before those (for adding data needed to=

>>>>> identify a possible race). Printing all available data would be
>>>>> possible, but this would add large amounts of data printed on large=
r
>>>>> configurations.
>>>>>
>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
>>>>
>>>> Just an update regarding current status with debugging the underlyin=
g
>>>> issue:
>>>>
>>>> On a customer's machine with a backport of this patch applied we've
>>>> seen another case of the hang. In the logs we've found:
>>>>
>>>> smp: csd: Detected non-responsive CSD lock (#1) on CPU#18, waiting
>>>> 5000000046 ns for CPU#06 do_flush_tlb_all+0x0/0x30(          (null))=
=2E
>>>> smp: 	csd: CSD lock (#1) unresponsive.
>>>> smp: 	csd: cnt(0000000): 0000->0000 queue
>>>> smp: 	csd: cnt(0000001): ffff->0006 idle
>>>> smp: 	csd: cnt(0025dba): 0012->0006 queue
>>>> smp: 	csd: cnt(0025dbb): 0012->0006 noipi
>>>> smp: 	csd: cnt(01d1333): 001a->0006 pinged
>>>> smp: 	csd: cnt(01d1334): ffff->0006 gotipi
>>>> smp: 	csd: cnt(01d1335): ffff->0006 handle
>>>> smp: 	csd: cnt(01d1336): ffff->0006 dequeue (src cpu 0 =3D=3D empty)=

>>>> smp: 	csd: cnt(01d1337): ffff->0006 hdlend (src cpu 0 =3D=3D early)
>>>> smp: 	csd: cnt(01d16cb): 0012->0005 ipi
>>>> smp: 	csd: cnt(01d16cc): 0012->0006 queue
>>>> smp: 	csd: cnt(01d16cd): 0012->0006 ipi
>>>> smp: 	csd: cnt(01d16f3): 0012->001a ipi
>>>> smp: 	csd: cnt(01d16f4): 0012->ffff ping
>>>> smp: 	csd: cnt(01d1750): ffff->0018 hdlend (src cpu 0 =3D=3D early)
>>>> smp: 	csd: cnt(01d1751): 0012->ffff pinged
>>>> smp: 	csd: cnt now: 01d1769
>>>>
>>>> So we see that cpu#18 (0012 hex) is waiting for cpu#06 (first line o=
f the
>>>> data).
>>>>
>>>> The next 4 lines of the csd actions are not really interesting, as t=
hey are
>>>> rather old.
>>>>
>>>> Then we see that cpu 0006 did handle a request rather recently (cnt =
01d1333
>>>> - 01d1337): cpu 001a pinged it via an IPI and it got the IPI, entere=
d the
>>>> handler, dequeued a request, and handled it.
>>>>
>>>> Nearly all of the rest shows the critical request: cpu 0012 did a lo=
op over
>>>> probably all other cpus and queued the requests and marked them to b=
e IPI-ed
>>>> (including cpu 0006, cnt 01d16cd). Then the cpus marked to receive a=
n IPI
>>>> were pinged (cnt 01d16f4 and cnt 01d1751).
>>>>
>>>> The entry cnt 01d1750 is not of interest here.
>>>>
>>>> This data confirms that on sending side everything seems to be okay =
at the
>>>> level above the actual IPI sending. On receiver side there seems no =
IPI to
>>>> be seen, but there is no visible reason for a race either.
>>>>
>>>> It seems as if we need more debugging in the deeper layers: is the I=
PI
>>>> really sent out, and is something being received on the destination =
cpu?
>>>> I'll have another try with even more debugging code, probably in pri=
vate
>>>> on the customer machine first.
>>>
>>> Apologies for the late reply, was out last week.
>>>
>>> Excellent news, and thank you!
>>>
>>> For my part, I have put together a rough prototype script that allows=

>>> me to run scftorture on larger groups of systems and started running =
it,
>>> though I am hoping that 1,000 is far more than will be required.
>>>
>>> Your diagnosis of a lost IPI matches what we have been able to glean
>>> from the occasional occurrences in the wild on our systems, for whate=
ver
>>> that might be worth.  The hope is to get something that reproduces mo=
re
>>> quickly, which would allow deeper debugging at this end as well.
>>
>> Sometimes one is lucky.
>>
>> I've found a reproducer while hunting another bug. The test on that
>> machine will trigger the csd_lock timeout about once a day.
>=20
> Nice!!!  You are way ahead of me!
>=20
>> I've used my new debug kernel and found that the IPI is really sent
>> out (more precise: the hypervisor has been requested to do so, and
>> it didn't report an error). On the target cpu there was no interrupt
>> received after that, so the IPI has not been swallowed on the target
>> cpu by the Linux kernel.
>>
>> Will now try to instrument the hypervisor to get more data.
>=20
> I am increasing the number and types of systems and the test duration.
> Ijust started running three different systems with IPI workloads in bot=
h
> guests and within host over the weekend.

Maybe you can try my kind of workload:

I have a guest with 16 vcpus and 8 GB of memory running 8 instances of

sysbench --test=3Dfileio --file-test-mode=3Drndrw --rand-seed=3D0=20
--max-time=3D300 --max-requests=3D0 run

on disjunct nfs mounts. Those have been created with:

mount -t nfs -o=20
rw,proto=3Dtcp,nolock,nfsvers=3D3,rsize=3D65536,wsize=3D65536,nosharetran=
sport=20
server:/share[1-8] /mount[1-8]

with the server running on the host system of the guest and the shares
located in a ramdisk.

The host has 72 cpus and 48 GB of RAM.

A csd lock timeout happens about once per day on the host.


Juergen

--------------4754E5CB2C40B4A5D6940D8A
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

--------------4754E5CB2C40B4A5D6940D8A--

--wlJO9IeEmbLxOsC0LIwbEL2EYHhIeIRn3--

--Sp3PkDpFznHyPnnsKOlrFrCD3fvVXJwL2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmBqvkQFAwAAAAAACgkQsN6d1ii/Ey/w
iggAhNiHnRqDNWZNqjrLyepQdwkk+pn2Dk39+tlyC5CqH7Ai8zVgniqYgUM5M4Z7hyIGV/xuZA+O
LG+W3IvDKbO7DF5AA5rmnz4Lo2RgEeWS++j8EH5/ANr7ywEbonQJ3JkDGsXrF+s5HhAZa7M9cI+Y
WN8nG7mK+B/sajdyz6JVyh3JBXVzK3wveMTFDuW90HH0w7tTD6lSLbuAJt620LfFwzYKXzE8vxk0
QnGVaKxcl05Laomfnyzx1MRe/vyXLnpAUoP9Z1CSy4mEucHHflkcgA6iReN/iDhLgGZ4mWjRNCfX
jts7XcAkB14inFnMm0tGRWzzcOmXa/K+ufrrOn9WYQ==
=k/K1
-----END PGP SIGNATURE-----

--Sp3PkDpFznHyPnnsKOlrFrCD3fvVXJwL2--
