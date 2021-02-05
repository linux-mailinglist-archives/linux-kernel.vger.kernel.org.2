Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87A131178B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhBFAAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhBENxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:53:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F1C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:52:32 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d85so6870725qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y8ywqrNIRNsV/WCSse4osZ5a836SkyCAgJhGHdnyxYU=;
        b=eVdNW0R+o8hTwRs0jlD8x9RbifEQSwRdrT3SnZShE4VF0wxyIfFQ1sGDdDNL+xc4mf
         y+3Xsa8jE0c20zdnNYEz1scHewL8jDtYAcf4vSKkddau4wmpDIL2zivvt7lxhDR4diNi
         SAZbpQZQgfDE7R4BViW3dyO1gwtrubpj4ui1Uo0feJXuop7P4VQJZ4uXAIY2XnOJD9gS
         YP62SsE3i1Y7H0LC9SeeyQX7CDxiifRsOKlMGI7pOJjbUvKpEo76fEJUzveXxaP3IFVr
         l+eXPiaj4hveXJAG3D6CWYP6U9ZDsX0Zs6o8liTVtIgpkNyaVe5rIZpAkTie+HLkOraS
         2Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Y8ywqrNIRNsV/WCSse4osZ5a836SkyCAgJhGHdnyxYU=;
        b=qOEH0iXdVPDAbQSr4jcMt3K96YWeonUOO8ete/P/vnbVa6RZApxM7dqYEVzFPYcTXu
         6toSp+h4hmkBz3FdyrOQLhr1KMDArqjWYf8xeMZno3MgKabUpyk+xuSfZ0RANjYdrfva
         n4YtW3fC0J0IkvHT/Lp4bDqh3MEUL0CJHnEytbq5lxmQxxP2Q5BBe7G473QCU+IuTZPO
         6coxGhPmOREZS2+Uws1iAu57zwHVMDsNEvwYmK+9hAgaee8RQMSJdK6Tb6QQWs3Q6LaS
         XBCA9hE4oE2k546Dvl4OIyk4SLhjBrmEScV5pBnl+BfX0Dg6vC/fAjqiuMyG9539O+eD
         9riQ==
X-Gm-Message-State: AOAM530g4HuOJM0UnUIVI5Vn54lhFnSvYb6SFzVSAqkoyYqRwp5Km2sN
        Ey8ZgUy0Jfr0b1a66E+W4DscLFDIrJrzAG2/
X-Google-Smtp-Source: ABdhPJzluogsW7CobFyQbM6KN4LrBuqIAEnj4fFqzRKZPeSLAVs7kNOzDryBUlYQs7HYZQfz/8LpAg==
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr4247131qkl.131.1612533152237;
        Fri, 05 Feb 2021 05:52:32 -0800 (PST)
Received: from ArchLinux ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id f7sm5939828qkh.45.2021.02.05.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:52:31 -0800 (PST)
Date:   Fri, 5 Feb 2021 19:22:22 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] drivers: mtd: Better word replace a not so good word in
 the file mtd_blkdevs.c
Message-ID: <YB1NlhOLQYQMR92b@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210205124151.1386271-1-unixbhaskar@gmail.com>
 <20210205142618.116852a0@xps13>
 <YB1J53adyW4BBK3g@ArchLinux>
 <1065601601.365300.1612532978692.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UbVbuy+EtEjeJ/Yy"
Content-Disposition: inline
In-Reply-To: <1065601601.365300.1612532978692.JavaMail.zimbra@nod.at>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UbVbuy+EtEjeJ/Yy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:49 Fri 05 Feb 2021, Richard Weinberger wrote:
>----- Urspr=C3=BCngliche Mail -----
>> Von: "Bhaskar Chowdhury" <unixbhaskar@gmail.com>
>> An: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> CC: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,=
 "linux-mtd" <linux-mtd@lists.infradead.org>,
>> "linux-kernel" <linux-kernel@vger.kernel.org>, "Randy Dunlap" <rdunlap@i=
nfradead.org>
>> Gesendet: Freitag, 5. Februar 2021 14:36:39
>> Betreff: Re: [PATCH] drivers: mtd: Better word replace a not so good wor=
d in the file mtd_blkdevs.c
>
>> On 14:26 Fri 05 Feb 2021, Miquel Raynal wrote:
>>>Hi Bhaskar,
>>>
>>>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote on Fri,  5 Feb 2021
>>>18:11:51 +0530:
>>>
>>>> s/fucking/invite/
>
>If you are afraid of "fucking", please replace it with "f*cking" or such.
>"invite" makes no sense.
>
I am NOT afraid of anything ,just replacing the bad words ..that's all
=2E..never bother to evaluate already bad sentences with correct word.

I know it is not make any sense ...still a better word ...
>Thanks,
>//richard

--UbVbuy+EtEjeJ/Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAdTZIACgkQsjqdtxFL
KRWjCAf+IfKyBykLxL7ODeRiwftX3kiSLsaxEeA5lx2nBqBTM4AU/ee8yJChDykP
P5pozQCOeXO57UTOXVuF+juT8zWPY93h5+o6nRS2zaCjOFlrMN93rLKuyfOj7/s1
TJl7RHpUuJPV+Hy93pXpd7kLUttO4j8WFA9ToCNd0IUZQ9g4oz9hI9t6rVnFaFP6
npQSeNJNn7Fyeb9jTur0B+j2lmi8y87hO6U02oEwCWmfx+KI0NajLI/6ljTGriwE
RrzVdtsgNl2dH3g1JotojV8X7OUWpaKh9FzHBSPJlxRWPbk/T4SOxqWp/tlKYTRJ
q/w7x+bz+5Ly8rtX2wxTjSh6oluEcg==
=bMZA
-----END PGP SIGNATURE-----

--UbVbuy+EtEjeJ/Yy--
