Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1C3D15CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhGURVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:21:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57198 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhGURVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:21:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 861851FECF;
        Wed, 21 Jul 2021 18:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626890504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJ63EcW4Hbgp68Gd99XQUhWaKPwN5T386ppIfIJreek=;
        b=kBwZoF3QM62mvMz8RA6J42YAr9AoLzvGw+R0LPHTi6XilDUymx/KdFyeWldc5V81YncEHj
        YG/U/cyqn2IvvtnJFix9gpVGiGjUGu/43AqmvTO4K8Htjt+c5MyimbZgtBhVLL5B71z+Vv
        rE1CPGoEMFt4YSqHJ4wUi3nnWRzAnIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626890504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJ63EcW4Hbgp68Gd99XQUhWaKPwN5T386ppIfIJreek=;
        b=WIrqdDzWF2bn5eMEprhFQszvv2X2KFy3aDYNAvFBpFOIx/OjSDEPzkFJwX1ZhsBfQPcVks
        mK/zjJd8kVzzx7Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 652CF13C0E;
        Wed, 21 Jul 2021 18:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 9nUiFwhh+GDwWgAAGKfGzw
        (envelope-from <tzimmermann@suse.de>); Wed, 21 Jul 2021 18:01:44 +0000
Subject: Re: [drm-drm-misc:drm-misc-next 1/2] undefined reference to
 `screen_info'
To:     kernel test robot <lkp@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202107212028.p9mTHgcu-lkp@intel.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <daa6e212-9e66-e551-948f-0a3c59cafd9f@suse.de>
Date:   Wed, 21 Jul 2021 20:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107212028.p9mTHgcu-lkp@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3n4frsZv37RqdZTqtW2mkWkzXlNl6B2FG"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3n4frsZv37RqdZTqtW2mkWkzXlNl6B2FG
Content-Type: multipart/mixed; boundary="ufbYwqZJ75ejugB5ZskcaMWRgpnTJ6DYG";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kernel test robot <lkp@intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Message-ID: <daa6e212-9e66-e551-948f-0a3c59cafd9f@suse.de>
Subject: Re: [drm-drm-misc:drm-misc-next 1/2] undefined reference to
 `screen_info'
References: <202107212028.p9mTHgcu-lkp@intel.com>
In-Reply-To: <202107212028.p9mTHgcu-lkp@intel.com>

--ufbYwqZJ75ejugB5ZskcaMWRgpnTJ6DYG
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 21.07.21 um 14:44 schrieb kernel test robot:
> tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
> head:   8633ef82f101c040427b57d4df7b706261420b94
> commit: d391c58271072d0b0fad93c82018d495b2633448 [1/2] drivers/firmware=
: move x86 Generic System Framebuffers support
> config: parisc-randconfig-r025-20210720 (attached as .config)
> compiler: hppa64-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=3D1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git remote add drm-drm-misc git://anongit.freedesktop.org/drm/=
drm-misc
>          git fetch --no-tags drm-drm-misc drm-misc-next
>          git checkout d391c58271072d0b0fad93c82018d495b2633448
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-10.3.0 make.=
cross O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>     hppa64-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init'=
:
>>> (.init.text+0x8): undefined reference to `screen_info'
>>> hppa64-linux-ld: (.init.text+0xc): undefined reference to `screen_inf=
o'

This could be related to the recent rework of the system-framebuffer=20
code. I think the config has to be updated to select SYSFB and=20
SYSFB_SIMPLEFB. [1]

Best regards
Thomas

[1]=20
https://cgit.freedesktop.org/drm/drm-misc/diff/drivers/firmware/Kconfig?i=
d=3D8633ef82f101c040427b57d4df7b706261420b94

>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=FCrnberg, Germany
(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer


--ufbYwqZJ75ejugB5ZskcaMWRgpnTJ6DYG--

--3n4frsZv37RqdZTqtW2mkWkzXlNl6B2FG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmD4YQcFAwAAAAAACgkQlh/E3EQov+BW
Qg//YXQcJcbU5Wx/hSC03Q0QxHCWQYL8J0IoTQrvQY4yxdFiyCDUl8QtzM9qPbbp6D9CIAkiTGD8
R8SiNEzBaYM3krs2yXmOg37t2xQF54jzGTVT4HJSuoL1j88/696U4bO/5RG0FYwtLquPHeFaEPKU
OubPZNlfrbponV+lRT2XOZzHuvCWNQWM1F0ke00UMcm64WJnyhlUfa2kv/1p4IPfaXfj4DqOvaFC
8F3iJ+7n80UHZ956ZvXzt6vl23cEpyEsx1oEHl7NYh0U+dNcL6bihIuAKHUeUJ2RC5GbI1q0256F
q32VXj44O1P8IHbUTfdk7khdsgutA7lpaZsak1gSetPNGdVTtXRVhlU8FRgtYYUnyg3+prvyTHGH
Atw1PBrvBfNAEbhcRnw5H1n285wKhCU5sZF6E/ZprqG3beup64CAJFqpoc7yhBTyH77dRUOcqQi1
1n6/cGiI7X5K/q6ZKrZBol0m9rFFrVNruYzCi7DIv1/hdUGE9L2dv9VggRU6TVXtGI/7nWg710tx
rIfU3g7fCTm+zzubbhJjqL/tJZOZs3GTntGf2AywX+7UDIzAik/mXblR/hWi4KpaGzNfIt1zf/Lu
GruyYqqDhjDbRzqrZva2DuyPUCDpMgieLtdShOdZQGKrJat2AigmVYK0rcDOyeAN+QnLz1nofd2q
IpY=
=IYSn
-----END PGP SIGNATURE-----

--3n4frsZv37RqdZTqtW2mkWkzXlNl6B2FG--
