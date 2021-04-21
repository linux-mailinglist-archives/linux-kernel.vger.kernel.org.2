Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C300366CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbhDUNXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:23:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240344AbhDUNTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:19:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619011155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22fysY3UhdpwacMhZ5DHcGyhRdskrznzm1i7yV3Yo8U=;
        b=uPoOxyt/4L80g71G9OTcLCk2O08KW9+ETf0CckB5n9Py3N4hn7DGGi7JqAWdCbTfDSHPvM
        r46IGQj6BFw5KPFe6vSN3dJcLqJpJH5hI6hkw3xqeeoyPvGr1HXZ44YKRwAphokzKgxm8F
        WbC0CsvNdCdZtRmzKK/4KljQXhRLKSA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00085B2E9;
        Wed, 21 Apr 2021 13:19:14 +0000 (UTC)
Subject: Re: [PATCH 061/190] Revert "xen/grant-table: remove multiple BUG_ON
 on gnttab_interface"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-62-gregkh@linuxfoundation.org>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <9c52814a-7db1-1989-6fd2-e6d80f9a92ad@suse.com>
Date:   Wed, 21 Apr 2021 15:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-62-gregkh@linuxfoundation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zO9OllR5qV0XIGSRy0ZKxwKX0QJVYkoX9"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zO9OllR5qV0XIGSRy0ZKxwKX0QJVYkoX9
Content-Type: multipart/mixed; boundary="tVE3GSsSMz3Y7WcHaspzbc9WLm2EDq1uo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Aditya Pakki <pakki001@umn.edu>
Message-ID: <9c52814a-7db1-1989-6fd2-e6d80f9a92ad@suse.com>
Subject: Re: [PATCH 061/190] Revert "xen/grant-table: remove multiple BUG_ON
 on gnttab_interface"
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-62-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-62-gregkh@linuxfoundation.org>

--tVE3GSsSMz3Y7WcHaspzbc9WLm2EDq1uo
Content-Type: multipart/mixed;
 boundary="------------02886965422E945F4F704CA1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------02886965422E945F4F704CA1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 21.04.21 14:58, Greg Kroah-Hartman wrote:
> This reverts commit d6bd6cf9feb81737f9f64d2c1acf98fdaacebad1.
>=20
> Commits from @umn.edu addresses have been found to be submitted in "bad=

> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University=

> of Minnesota) and Kangjie Lu (University of Minnesota).
>=20
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove thi=
s
> change to ensure that no problems are being introduced into the
> codebase.
>=20
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The reverted patch didn't introduce any issue. I have verified that the
BUG_ON()s are really impossible to trigger, and even if they would have
been triggering, they'd be now replaced by NULL dereferences.

So I believe you can just drop this revert.


Juergen

> ---
>   drivers/xen/grant-table.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 3729bea0c989..5065d36c602e 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -663,6 +663,7 @@ static int grow_gnttab_list(unsigned int more_frame=
s)
>   	unsigned int nr_glist_frames, new_nr_glist_frames;
>   	unsigned int grefs_per_frame;
>  =20
> +	BUG_ON(gnttab_interface =3D=3D NULL);
>   	grefs_per_frame =3D gnttab_interface->grefs_per_grant_frame;
>  =20
>   	new_nr_grant_frames =3D nr_grant_frames + more_frames;
> @@ -1281,6 +1282,7 @@ EXPORT_SYMBOL_GPL(gnttab_unmap_refs_sync);
>  =20
>   static unsigned int nr_status_frames(unsigned int nr_grant_frames)
>   {
> +	BUG_ON(gnttab_interface =3D=3D NULL);
>   	return gnttab_frames(nr_grant_frames, SPP);
>   }
>  =20
> @@ -1508,6 +1510,7 @@ static int gnttab_expand(unsigned int req_entries=
)
>   	int rc;
>   	unsigned int cur, extra;
>  =20
> +	BUG_ON(gnttab_interface =3D=3D NULL);
>   	cur =3D nr_grant_frames;
>   	extra =3D ((req_entries + gnttab_interface->grefs_per_grant_frame - =
1) /
>   		 gnttab_interface->grefs_per_grant_frame);
> @@ -1542,6 +1545,7 @@ int gnttab_init(void)
>   	/* Determine the maximum number of frames required for the
>   	 * grant reference free list on the current hypervisor.
>   	 */
> +	BUG_ON(gnttab_interface =3D=3D NULL);
>   	max_nr_glist_frames =3D (max_nr_grant_frames *
>   			       gnttab_interface->grefs_per_grant_frame / RPP);
>  =20
>=20


--------------02886965422E945F4F704CA1
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

--------------02886965422E945F4F704CA1--

--tVE3GSsSMz3Y7WcHaspzbc9WLm2EDq1uo--

--zO9OllR5qV0XIGSRy0ZKxwKX0QJVYkoX9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmCAJlIFAwAAAAAACgkQsN6d1ii/Ey95
2Af/eVfzFmqn8gwkNxZXiXIapwFiupwLTrkcWtq0KKIzee5WLzFWRBod3sPT2EtYlOPVkcoYLeci
wX1muZiExDEp9XFbPohw25aKwXyFRXzYggZoHD5drQHYzyi/6l6NZyP4ey7/m4dhPL44hVjqa/MR
brfRtR8qGx/uz9HHrow7fFkm0Jx35zcjxWdkKfPoxBRQVocbpCWuPthvKL5sr2Pm+KWr/pVMwUbH
Vt9yYwhseZOBC2NVHWW2X03Zbh94/Od/sgBdJrNyY+ge8W12OEk630nmRtwdJndWbHWqMubMS/yN
AgCpsJkEPL79nrwQwrwnWj5oDspzE/FQ9cZTAyOo6w==
=SenP
-----END PGP SIGNATURE-----

--zO9OllR5qV0XIGSRy0ZKxwKX0QJVYkoX9--
