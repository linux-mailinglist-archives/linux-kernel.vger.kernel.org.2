Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9339E3282DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhCAPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:54:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:59152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236976AbhCAPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:54:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614614009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcjGeDJsaOlZSOonGO0gViD9xFKUF60zr38tbIGqMi8=;
        b=au6P4/4ZowAK4XuRO9GKvJh/qwj0SKJyt3phXIi0FnwMYKXpSh1MwWlP4yP/j3w3vqj+NX
        +91VfjZhENHGCVeqh4HxLWcbJxLE/EbWXo7KsBpugAZ5ObhAijRYJmcittGRNrz0j1vPKK
        81hZFfd2UD552n3/cvrHle7uOH97W5k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B416AF54;
        Mon,  1 Mar 2021 15:53:29 +0000 (UTC)
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mhocko@suse.com, Jonathan Corbet <corbet@lwn.net>
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
 <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
 <20210226181205.GZ2743@paulmck-ThinkPad-P72>
 <YDlirwTWMmZ3g0ts@hirez.programming.kicks-ass.net>
 <20210301000704.GF2696@paulmck-ThinkPad-P72>
 <YD0MI1Cye+YbOov3@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <6bc3d90d-f369-e91d-01f7-b83a48e9721d@suse.com>
Date:   Mon, 1 Mar 2021 16:53:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YD0MI1Cye+YbOov3@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IrTmO1r3scoj1XUriJDXLrx9PBJQkGD8q"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IrTmO1r3scoj1XUriJDXLrx9PBJQkGD8q
Content-Type: multipart/mixed; boundary="24nUpPKwB1EtvNEJdf1xnLF1mL3Euf0F8";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mhocko@suse.com,
 Jonathan Corbet <corbet@lwn.net>
Message-ID: <6bc3d90d-f369-e91d-01f7-b83a48e9721d@suse.com>
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
 <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
 <20210226181205.GZ2743@paulmck-ThinkPad-P72>
 <YDlirwTWMmZ3g0ts@hirez.programming.kicks-ass.net>
 <20210301000704.GF2696@paulmck-ThinkPad-P72>
 <YD0MI1Cye+YbOov3@hirez.programming.kicks-ass.net>
In-Reply-To: <YD0MI1Cye+YbOov3@hirez.programming.kicks-ass.net>

--24nUpPKwB1EtvNEJdf1xnLF1mL3Euf0F8
Content-Type: multipart/mixed;
 boundary="------------9EA8299CC1DFCE5F117CD5E0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9EA8299CC1DFCE5F117CD5E0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 01.03.21 16:45, Peter Zijlstra wrote:
> On Sun, Feb 28, 2021 at 04:07:04PM -0800, Paul E. McKenney wrote:
>> On Fri, Feb 26, 2021 at 10:05:51PM +0100, Peter Zijlstra wrote:
>>> On Fri, Feb 26, 2021 at 10:12:05AM -0800, Paul E. McKenney wrote:
>>>> On Fri, Feb 26, 2021 at 05:38:44PM +0100, Peter Zijlstra wrote:
>>>>>
>>>>> I hate all of this, but if this will finally catch the actual probl=
em,
>>>>> we can then revert all this, so sure.
>>>>
>>>> OK, I will bite...  What exactly do you hate about it?
>>>
>>> It's ugly and messy. We're basically commiting a debug session. Norma=
lly
>>> gunk like this is done in private trees, then we find the problem and=

>>> fix that and crap like this never sees the light of day.
>>
>> Is your hatred due to the presence of debug code at all, or a belief t=
hat
>> this code is unlikely to be useful in any subsequent IPI-related bug h=
unt?
>=20
> The clutter, mostly I think. There's a lot of debug sprinkled about.

I agree.

In case we are able to identify the root cause of the problem I think
it would be no problem to revert this patch and put a comment into smp.c
naming the commit-id of this patch and what it was good for. This will
enable future bug hunters to make use of the patch without spoiling the
code for others.


Juergen


--------------9EA8299CC1DFCE5F117CD5E0
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

--------------9EA8299CC1DFCE5F117CD5E0--

--24nUpPKwB1EtvNEJdf1xnLF1mL3Euf0F8--

--IrTmO1r3scoj1XUriJDXLrx9PBJQkGD8q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmA9DfcFAwAAAAAACgkQsN6d1ii/Ey8B
uAf/eU2Fj12h0CGjfpINuiLbz8YKvSkQG3F0KgW53USFYA/LEnrqQQ8+R9PS2ElqZiRi6zmNumuL
bgxRD/dPss/G6neN4w7W4fkdW2Fj/II+PstUBkj36bqYZ79oLHZOf2OjPnq/26h2v4NoPdctFgp2
1rWvt6IXzzrjI6L6i7umJAEHmrOHP+UVFgy2IM9lr7TOYwlxVilzIj6kWEGKc9Ad2vjoAP9ZVPTf
9XVvYq77r4VpabZ/qc59hv5I1R2/bSqdJd2Xfw/9PNk7/kPxBYKXNdwJuD0iToosy2Ibp504Xo6i
InK0Em8wUXgiQA8E6DoiHXQtxbWH6l405q3uQkCvUw==
=q/F+
-----END PGP SIGNATURE-----

--IrTmO1r3scoj1XUriJDXLrx9PBJQkGD8q--
