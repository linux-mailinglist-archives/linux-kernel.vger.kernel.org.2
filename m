Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0DD3C2570
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhGIOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:01:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35720 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhGIOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:01:22 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 742A722180;
        Fri,  9 Jul 2021 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625839118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TP1/uoVP2wkmjJxosE1T60JaJRCCcXfD2nkG/A4nXMI=;
        b=c2FLhMJ8+yG3MTvCaSzH5E4acsH8MFSWwJ3O1uxntsY5+2FefFEGzc2l9qc1l305EysCBv
        0XzaKsaaGYVuYXjWWYCbkXYO0gyM5wdc3eoAl783b0AZhdfY9hmQRG6mgiCgz1+Y/LjuoE
        JF/qPVWOwYEk+aXuDVLSWumr7vw6BTI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3D7DD137F8;
        Fri,  9 Jul 2021 13:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id l3W+DQ5W6GCYeQAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 09 Jul 2021 13:58:38 +0000
Subject: Re: [PATCH v2 3/3] xen/blkfront: don't trust the backend response
 data blindly
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20210708124345.10173-1-jgross@suse.com>
 <20210708124345.10173-4-jgross@suse.com> <YOgZ/lzDIlzIxCZp@Air-de-Roger>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <4f460d31-c4da-8a58-8ee5-7735f5260f08@suse.com>
Date:   Fri, 9 Jul 2021 15:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOgZ/lzDIlzIxCZp@Air-de-Roger>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PtD6XltbThet5UCMvmi5pahWMOzO45Xvp"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PtD6XltbThet5UCMvmi5pahWMOzO45Xvp
Content-Type: multipart/mixed; boundary="S35JlfSQdS3KAz9fiFZDLgLQ5ZAlpJMxS";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>
Message-ID: <4f460d31-c4da-8a58-8ee5-7735f5260f08@suse.com>
Subject: Re: [PATCH v2 3/3] xen/blkfront: don't trust the backend response
 data blindly
References: <20210708124345.10173-1-jgross@suse.com>
 <20210708124345.10173-4-jgross@suse.com> <YOgZ/lzDIlzIxCZp@Air-de-Roger>
In-Reply-To: <YOgZ/lzDIlzIxCZp@Air-de-Roger>

--S35JlfSQdS3KAz9fiFZDLgLQ5ZAlpJMxS
Content-Type: multipart/mixed;
 boundary="------------15EFA2D45E58C234A1B0B486"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------15EFA2D45E58C234A1B0B486
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 09.07.21 11:42, Roger Pau Monn=C3=A9 wrote:
> On Thu, Jul 08, 2021 at 02:43:45PM +0200, Juergen Gross wrote:
>> Today blkfront will trust the backend to send only sane response data.=

>> In order to avoid privilege escalations or crashes in case of maliciou=
s
>> backends verify the data to be within expected limits. Especially make=

>> sure that the response always references an outstanding request.
>>
>> Introduce a new state of the ring BLKIF_STATE_ERROR which will be
>> switched to in case an inconsistency is being detected. Recovering fro=
m
>> this state is possible only via removing and adding the virtual device=

>> again (e.g. via a suspend/resume cycle).
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>=20
> Acked-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>

>> @@ -1555,11 +1561,17 @@ static irqreturn_t blkif_interrupt(int irq, vo=
id *dev_id)
>>  =20
>>   	spin_lock_irqsave(&rinfo->ring_lock, flags);
>>    again:
>> -	rp =3D rinfo->ring.sring->rsp_prod;
>> -	rmb(); /* Ensure we see queued responses up to 'rp'. */
>> +	rp =3D READ_ONCE(rinfo->ring.sring->rsp_prod);
>> +	virt_rmb(); /* Ensure we see queued responses up to 'rp'. */
>=20
> Is the READ_ONCE strictly needed? Doesn't the barrier prevent rp from
> not being loaded at this point?

I asked Jan the same and he didn't want to rule that out. Additionally
the READ_ONCE() helps against (rather improbable) load tearing of the
compiler.

>> +		op =3D rinfo->shadow[id].req.operation;
>> +		if (op =3D=3D BLKIF_OP_INDIRECT)
>> +			op =3D rinfo->shadow[id].req.u.indirect.indirect_op;
>> +		if (bret.operation !=3D op) {
>> +			pr_alert("%s: response has wrong operation (%u instead of %u)\n",
>> +				 info->gd->disk_name, bret.operation, op);
>=20
> You could also use op_name here, but I guess this could mask the
> operation as 'unknown' for any number out of the defined ones.

This case shouldn't happen normally, so having the numerical value is
enough and will help for hiding any undefined op.

>> @@ -1635,8 +1662,8 @@ static irqreturn_t blkif_interrupt(int irq, void=
 *dev_id)
>>   		case BLKIF_OP_READ:
>>   		case BLKIF_OP_WRITE:
>>   			if (unlikely(bret.status !=3D BLKIF_RSP_OKAY))
>> -				dev_dbg(&info->xbdev->dev, "Bad return from blkdev data "
>> -					"request: %x\n", bret.status);
>> +				dev_dbg_ratelimited(&info->xbdev->dev,
>> +					"Bad return from blkdev data request: %x\n", bret.status);
>=20
> Since you are touching the line, could you use %#x here? It's IMO not
> obvious from the context this status will be printed in hex base. Also
> bret.status parameter could be split into a newline.

Fine with me.


Juergen

--------------15EFA2D45E58C234A1B0B486
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

--------------15EFA2D45E58C234A1B0B486--

--S35JlfSQdS3KAz9fiFZDLgLQ5ZAlpJMxS--

--PtD6XltbThet5UCMvmi5pahWMOzO45Xvp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmDoVg0FAwAAAAAACgkQsN6d1ii/Ey8r
5Qf/fnwieeILe/0AWJq3TSZW//Hls69d7iMLWayHcIvKzJT/O0ycZLRSEwYdoxWuqQuqXI4kOoW+
cTsx5YLrkLc1qHWBhEwjV0SA+56z+w3U0FNaZ0URgGEXOqWeCil5RSGvXSPIVTSHQTRrL9sK2sct
s9FSsxQd13cN4qiYhclm0PGuCdNjXFZe8Da0S4CGNzZuQ8kG7djtPpTVjtgfHYo5aAdZIBoIkUT9
JNr43Q+wJfO/8GDGnkMWlimzTPuUtwYRxHAb3nDHPhlRaagY+xcldl70oOy9j7afzlcWzngRHFZo
Obl8YWBtkze41hp5T86JhzX8vonfsoE6e0ci8BVmsA==
=jZIg
-----END PGP SIGNATURE-----

--PtD6XltbThet5UCMvmi5pahWMOzO45Xvp--
