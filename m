Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FEF35B685
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 20:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhDKSKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 14:10:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233822AbhDKSKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 14:10:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3ED53AFCD;
        Sun, 11 Apr 2021 18:10:37 +0000 (UTC)
Subject: Re: [syzbot] general protection fault in drm_client_buffer_vunmap
To:     syzbot <syzbot+10328e8428a896b65119@syzkaller.appspotmail.com>,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        igormtorrente@gmail.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com, ztong0001@gmail.com
References: <000000000000c4cba105bfb126a1@google.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <b6d0039a-d605-2a91-ac00-2966291cfc16@suse.de>
Date:   Sun, 11 Apr 2021 20:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000c4cba105bfb126a1@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ii1uA8SbKGnacI9yJQ5vuK86BGgASN8G0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ii1uA8SbKGnacI9yJQ5vuK86BGgASN8G0
Content-Type: multipart/mixed; boundary="SsLLBMZChnh4BSylHImKZ5477u4oaUgdk";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: syzbot <syzbot+10328e8428a896b65119@syzkaller.appspotmail.com>,
 airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 igormtorrente@gmail.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 syzkaller-bugs@googlegroups.com, ztong0001@gmail.com
Message-ID: <b6d0039a-d605-2a91-ac00-2966291cfc16@suse.de>
Subject: Re: [syzbot] general protection fault in drm_client_buffer_vunmap
References: <000000000000c4cba105bfb126a1@google.com>
In-Reply-To: <000000000000c4cba105bfb126a1@google.com>

--SsLLBMZChnh4BSylHImKZ5477u4oaUgdk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

#syz fix: drm/fb-helper: only unmap if buffer not null

Am 11.04.21 um 14:01 schrieb syzbot:
> #syz fix: drm/fb-helper: only unmap if buffer not null

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--SsLLBMZChnh4BSylHImKZ5477u4oaUgdk--

--ii1uA8SbKGnacI9yJQ5vuK86BGgASN8G0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmBzO5sFAwAAAAAACgkQlh/E3EQov+Do
iA/6A63OiUqCl0TY+rWCEkigqR95XHyj5rG/PhluHcPBYkV4tOj55HGHdVYazKCSH0qI43rcFW/e
JTMPpee1SwNXCcVlyl8W8b2rEJfI6hSl4FY9h8Qewy/MlLNv+HoMabhcfu/qEFwJ2OtBtyz82QJx
z3sCMthyEDWp0TgQ8t5eOKW3/6dkrtaQYWxpGxiqLtQXakZI+4WY+Fak0frWSscWI+NGNBnbV0xP
N2SxZZlInefPrspDKzgkcxhVmF2gozCU31PSRTgy3Iw7gXfb7S3QrzVyCJYfeqqL2QAu5pb9o+oz
5IPL6T2xZIkFUJmvEyPNijOJvA8NPWQnoLN0NOknOoqNumyD6lCJ0Ra04tmy40l15dTUbrxTNnMV
vJKGz68OtWCoyvvqhxHD72tvQI8zXXOlsFHf5tPjRTHYiiO2Bfs34WjrxiyV2NLZ0XcgUvUD9tcO
lrs296P5ZXQ6j+/jCuKqCRNR+2DwgZNSMiSKb6dAiJW6uIVVW2sWQu17BO7xVGWvv+zIZCP6BbFG
4m95zNEZ3E2Ajt/OtMvDRivh6PEsA2/HIDEfH4Nrl5DgSzieu6jAxhMYa2TtLbW7qsrB7gkaF8cx
xzuJGfbhX1xx9Kx+aForK2IJWfwBdS4qNBDl+hzVREJwxKLEuhqEgKAifupBtJ9ZW1+cbrGVw9HP
aVA=
=r+LL
-----END PGP SIGNATURE-----

--ii1uA8SbKGnacI9yJQ5vuK86BGgASN8G0--
