Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539B539C8E4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFENjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:39:19 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:54055 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFENjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:39:18 -0400
X-Greylist: delayed 1823 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jun 2021 09:39:18 EDT
Received: from [192.168.111.113] (p2e51393d.dip0.t-ipconnect.de [46.81.57.61])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 155D71qT027572
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Sat, 5 Jun 2021 15:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1622898422;
        bh=5iCazvx/4ncAfYJF/Fo3DbkYyFxv18FcykCRH/qf7eQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T9EwjCYPzXO/Mu8k2ghhJLYY+1mvJTJo4/p1VuCM9E+INpA2Glbk7kIVjx/V5lFHo
         7mSqi1HgzcwbTJyKytJoWt4vP5c80Sc2fSWPEfUhJsmzy9asesR0Au701tpDB/YO/u
         K+K+l4qDwDj5/UIaNpHC6dbjx7Lt0iIDKM3jlUI0=
Subject: Re: [PATCH v2] Updated locking documentation for journal_head
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
References: <9864e9792b56bce87b016582a8759890079f7766>
 <20210319104722.75467-1-alexander.lochmann@tu-dortmund.de>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Message-ID: <cf9b4f6b-baeb-3880-58e6-44cd02abf877@tu-dortmund.de>
Date:   Sat, 5 Jun 2021 15:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210319104722.75467-1-alexander.lochmann@tu-dortmund.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7usZggT0iTUB7iIZ6w1nTS1GW7NjxN3iN"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7usZggT0iTUB7iIZ6w1nTS1GW7NjxN3iN
Content-Type: multipart/mixed; boundary="nUNYuXLqwaCHfrfWvxw1KJXyx7kv1zaLj";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Message-ID: <cf9b4f6b-baeb-3880-58e6-44cd02abf877@tu-dortmund.de>
Subject: Re: [PATCH v2] Updated locking documentation for journal_head
References: <9864e9792b56bce87b016582a8759890079f7766>
 <20210319104722.75467-1-alexander.lochmann@tu-dortmund.de>
In-Reply-To: <20210319104722.75467-1-alexander.lochmann@tu-dortmund.de>

--nUNYuXLqwaCHfrfWvxw1KJXyx7kv1zaLj
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi folks,

Have you had the chance to review my patch?
Does is look good to you?
Jan already approved it.

Regards,
Alex


On 19.03.21 11:47, Alexander Lochmann wrote:
> LockDoc's results show that t_list_lock has been
> replaced by j_list_lock for b_next_transaction,
> b_tnext, and b_tprev.
> We, therefore, updated the documentation
> accordingly.
>=20
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>   include/linux/journal-head.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/journal-head.h b/include/linux/journal-head.=
h
> index 75bc56109031..d68ae72784eb 100644
> --- a/include/linux/journal-head.h
> +++ b/include/linux/journal-head.h
> @@ -80,13 +80,13 @@ struct journal_head {
>   	 * Pointer to the running compound transaction which is currently
>   	 * modifying the buffer's metadata, if there was already a transacti=
on
>   	 * committing it when the new transaction touched it.
> -	 * [t_list_lock] [b_state_lock]
> +	 * [j_list_lock] [b_state_lock]
>   	 */
>   	transaction_t *b_next_transaction;
>  =20
>   	/*
>   	 * Doubly-linked list of buffers on a transaction's data, metadata o=
r
> -	 * forget queue. [t_list_lock] [b_state_lock]
> +	 * forget queue. [j_list_lock] [b_state_lock]
>   	 */
>   	struct journal_head *b_tnext, *b_tprev;
>  =20
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--nUNYuXLqwaCHfrfWvxw1KJXyx7kv1zaLj--

--7usZggT0iTUB7iIZ6w1nTS1GW7NjxN3iN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmC7dvUFAwAAAAAACgkQWT7tBbw+9v0N
thAA1Byq6MyEt/uFtC4E3ETilB7TNSi/V1mh9Qohgh0fwzGxmqWjV6QaAyGDpUZcJZykS+/TSiA1
tlqjrcgvOwVCfYGPIiqXYDpe2QOlWnT4clbfM0cKJs74n09SjA6Pl16FZHCz7fU+gh7xexrUK95p
hphoG7CDIH8VQQ2fWpFw1lyPKcfupBVHkOYZq7sF9lXJP7o8qpTyfAkrgVVaor2JX7bhjIh8FFek
rjRHdLQlpwtdpSA13dLnjVZc2D6qthe8tIIHNtiKbYYIM7j8Ejn7PtB/RYMccYxuFtt+cOESHQOf
8n21Jjmyw6lIsH0jhuWqNTJIdf14xGiIurjfjgufXWG8TQmwwUEXXTIwxVcxfg834gdSIZ3abp0Z
ryRiNsizLluayNRljQXodAEMX1dv0K1O95Fpc8eZidqF5MuYM+FBNU+O8If8n0yT2q8gvxxxwFFT
Zse/WQj8KzmywV1TQGz5lFqxMyMMPXZ55nqrqjFyS1MQsurTIrUI5tn4LnBpxrFucSBgoD8Uy3nm
cbfEoD2gEgPLliscH7SzWm218Oozxgz9ae8tpM0XomXzWfA5duoEpzSfyLWmpZkYUOjn+LdqRtsy
2X0ksjoxzRFBlGb8u8G81hptm2PL4a3TajJWRw7IQn23vVSRkICZJbgNg4ef8hNNviMEnY+8tiG8
d9g=
=H+Zu
-----END PGP SIGNATURE-----

--7usZggT0iTUB7iIZ6w1nTS1GW7NjxN3iN--
