Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3D39ACEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFCVcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFCVcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:32:04 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05187C061760;
        Thu,  3 Jun 2021 14:30:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 0B2E1195;
        Thu,  3 Jun 2021 23:30:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DpzPcoUpX-CU; Thu,  3 Jun 2021 23:30:14 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id C468FC1;
        Thu,  3 Jun 2021 23:30:13 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1louup-00A80e-75; Thu, 03 Jun 2021 23:30:11 +0200
Date:   Thu, 3 Jun 2021 23:30:11 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     corbet@lwn.net, jani.nikula@linux.intel.com, gene@collinsnet.net,
        w.d.hubbs@gmail.com, steve.holmes88@gmail.com,
        speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: Convert the Speakup guide to rst
Message-ID: <20210603213011.k644jfjmtp2jtokn@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        corbet@lwn.net, jani.nikula@linux.intel.com, gene@collinsnet.net,
        w.d.hubbs@gmail.com, steve.holmes88@gmail.com,
        speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210603145953.10982-1-igormtorrente@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxppmhpajuw64fzw"
Content-Disposition: inline
In-Reply-To: <20210603145953.10982-1-igormtorrente@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: ----
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 0B2E1195
X-Spamd-Result: default: False [-4.60 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCPT_COUNT_TWELVE(0.00)[13];
         SIGNED_PGP(-2.00)[];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cxppmhpajuw64fzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Igor Matheus Andrade Torrente, le jeu. 03 juin 2021 11:59:53 -0300, a ecrit:
> [1] https://www.spinics.net/lists/linux-doc/msg97635.html
> [2] https://www.spinics.net/lists/linux-doc/msg97636.html

These are not really ACKs on the licence change, but here it is:

Yes, I agree with adding the GPLv2 alternative to the licensing of the
spkguide.

Samuel

--cxppmhpajuw64fzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE59DSENomQIYa2nfqRdTszGSEm3kFAmC5Sd0ACgkQRdTszGSE
m3mwtxAAmUa3gDWzBwAMwsM1sXsDJisIEpdi/qKCVRiNRbZBm1DdlcD3nDdq8cLp
PBGmAUgEbzmJoblT1vPXC+kIDAiooIOTbir8pmTkLgrDfPKy8x0K62QSvAvS0lpG
puObN7D3qWOgzZ1VvQWtKyARDjkVQTWdyn9g5jZTH2V9RqTi5Rw/e1cNkiE2nyK9
qStHZ8BtKkUDzAw/19AN1nx+3Ae8jc1R3ehnMkaaOJACyEXDEf8E7PWmcor6GBzJ
HcNDAEWpTIDBtiyKvIcRd6BBJmo04QZvd0MGLjCWSK/ztPpyoLuc9rQTL3gc0QIm
gBymrsNYFoH0KnK1MFVC1wDZ0ykaxYo6S92aDvZoX7gv7HuM6p3Gm35xHSRtnkgA
V4kTNekxYDbgtop5YQ1DiQMyfCR6TUdqqxXWMSqSjwU6J1aeYWgrvRKyd7bFnZlo
gL7JMFt+mQHAJu7OqVl5tsHl0HSRidU56CpvyVBxFBWhus/ot+3ZmUd7BMh2DqXv
Ff0bFkAIEZF9bWpjZu1yCbL9Xkan7Dhb7F28Fpb8q1e6DcJ/tCUgclWc5kmfVJ0u
oAc81DevxNBQvRG4uYHBxWM/4J7AzTcXGBaxXffZygHTJ8hJdw09L2zuh/k2SOsO
GwbhfHsKABB9EiR0pFywdOtoTbE8G18QaVmuq0evlhQKJKFgfKE=
=oFBy
-----END PGP SIGNATURE-----

--cxppmhpajuw64fzw--
