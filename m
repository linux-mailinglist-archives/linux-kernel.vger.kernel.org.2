Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEE6354EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbhDFItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhDFItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:49:50 -0400
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9DC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 01:49:42 -0700 (PDT)
Received: (qmail 10825 invoked from network); 6 Apr 2021 08:47:46 -0000
Received: from p548c78d7.dip0.t-ipconnect.de ([::ffff:84.140.120.215]:53768 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.37dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <linux-parisc@vger.kernel.org>; Tue, 06 Apr 2021 10:47:46 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Gao Xiang <xiang@kernel.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] parisc: avoid a warning on u8 cast for cmpxchg on u8 pointers
Date:   Tue, 06 Apr 2021 10:49:29 +0200
Message-ID: <11726853.O9o76ZdvQC@daneel.sf-tec.de>
In-Reply-To: <20210406045929.30331-1-xiang@kernel.org>
References: <20210406045929.30331-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5451194.DvuYhMxLoT"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5451194.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 6. April 2021, 06:59:29 CEST schrieb Gao Xiang:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> commit b344d6a83d01 ("parisc: add support for cmpxchg on u8 pointers")
> can generate a sparse warningi ("cast truncates bits from constant
                               ^
> value"), which has been reported several times [1] [2] [3].


--nextPart5451194.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYGwgmQAKCRBcpIk+abn8
Tj+uAJ9iY5gMCVZrNhoKd7YvJtn1n51IBgCfWsFvKmIuIzSjPF1yfwQDy/4NoJM=
=xD+F
-----END PGP SIGNATURE-----

--nextPart5451194.DvuYhMxLoT--



