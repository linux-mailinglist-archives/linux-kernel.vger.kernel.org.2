Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7028E3C2746
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhGIQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhGIQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:08:01 -0400
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD4C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 09:05:17 -0700 (PDT)
Received: (qmail 5818 invoked from network); 9 Jul 2021 16:02:17 -0000
Received: from p548c7b0a.dip0.t-ipconnect.de ([::ffff:84.140.123.10]:37102 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <james.bottomley@hansenpartnership.com>; Fri, 09 Jul 2021 18:02:17 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     James.Bottomley@hansenpartnership.com,
        Carlos Bilbao <bilbao@vt.edu>
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: parisc: Update iosapic driver with proper printks
Date:   Fri, 09 Jul 2021 18:05:05 +0200
Message-ID: <7261873.EvYhyI6sBW@daneel.sf-tec.de>
In-Reply-To: <5760611.lOV4Wx5bFT@iron-maiden>
References: <5760611.lOV4Wx5bFT@iron-maiden>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3608610.kQq0lBPeGt"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3608610.kQq0lBPeGt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 9. Juli 2021, 15:38:44 CEST schrieb Carlos Bilbao:
> The code from the old I/O Sapic Driver is outdated when it comes to printks.
> Fix applying proper indentation and using dev_dbg() instead of printk on
> debugging blocks. Also add a KERN_<LEVEL> where it is missing.

Have you actually tried building this? I bet not:

> +#define DBG(x...) dev_dbg(x)

> +	DBG("io_sapic_info at %p\n", isi);
> +	DBG("\t\tisi_hpa:       %lx\n", isi->isi_hpa);
> +	DBG("\t\tisi_status:    %x\n", isi->isi_status);
> +	DBG("\t\tisi_version:   %x\n", isi->isi_version);
> +	DBG("\t\tisi_vector:    %p\n", isi->isi_vector);
>  }
>  #endif /* DEBUG_IOSAPIC */

You are not passing a struct device here, so this will not work.

Eike
--nextPart3608610.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYOhzsQAKCRBcpIk+abn8
TpaCAJ9mOyggOWP67DN4nfSxWms8582CewCfb47IkLCOfV43CQ9Q4Y4qoMnAqhE=
=a80g
-----END PGP SIGNATURE-----

--nextPart3608610.kQq0lBPeGt--



