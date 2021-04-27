Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947CB36CB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhD0Sun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236279AbhD0Sul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:50:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C24FA613CA;
        Tue, 27 Apr 2021 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619549397;
        bh=uO+NmuX7GQXASLg64EJyoWXBP27CsYq6GtZqXt+kt5E=;
        h=Date:From:To:Cc:Subject:From;
        b=YdNi7anau7YAfO3rnLcgIZpZeNtndbNDk1hA/tnMQtzPp6eE/wCpuODM31cT7tB0g
         b7ft2PNXljKGf5YFrtR6l5NFrCz0yhF173fXJ6HrmZAzVSdcZS59oay+FAN1yi1Sjo
         5z8wsaTbUxW5s5QBhMBrdjbxLbfp/NUKzygH5fSeWxCm5zbCGqzLeViqzkPL1vqpz7
         6vUpFRlsGCmaw8izkin3kCMlpb3+tyX50ztoKlKO5ZFUpSKmjHVpmo3JY0ddik2ntc
         Z82uqsV7lKmptFppUUi+B4yA9qi2KxVKANx3JwaNAFuUAMeFa6CC79+uBjWn1Kal9g
         nGrQrrkdAEXFw==
Received: by earth.universe (Postfix, from userid 1000)
        id F38D83C0C96; Tue, 27 Apr 2021 20:49:55 +0200 (CEST)
Date:   Tue, 27 Apr 2021 20:49:55 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-5.13
Message-ID: <20210427184955.trmszirmcqlv72te@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6fcnoobhaeczu2w"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6fcnoobhaeczu2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.13

for you to fetch changes up to 5c08b0f75575648032f309a6f58294453423ed93:

  HSI: core: fix resource leaks in hsi_add_client_from_dt() (2021-04-16 00:14:49 +0200)

----------------------------------------------------------------
HSI changes for the 5.13 series

* memory leak fix in hsi_add_client_from_dt() error path

----------------------------------------------------------------
Dan Carpenter (1):
      HSI: core: fix resource leaks in hsi_add_client_from_dt()

 drivers/hsi/hsi_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--f6fcnoobhaeczu2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCIXMwACgkQ2O7X88g7
+poXpA//QmJmha3VFiTU25EkN7tTBxr47czXJkD6RsLtdczDX95kVCXbTRgqdQ/K
MzcrcJ4Jd+ICn+LOHe+OKsb4q3HOgnXcLfAIioTH8IXYee/Qc+OYFR8EkJ8npH1F
PjwvEVXlSbp75Y+FDyv9nPmZN5OA4MYqpAa3u4O0lwmUsBi0CaCuMxNZn9i3qS28
/T2sfzrkvMMszAloaFZCNEhozt4H/Itb+NaY8QBOj5N619OXnBOXzsWWC+PBYb1C
VxE1OnN/Qpr3vRSX68ISoiiAa+ZNJnLZL8Q2a1IF9Lqe/77kJOZpW8bimkw4l6fk
m1sR4nD2rCgaaA3OqDEsUCVWGN1U/K/C5BsnejsF0ZklRJQ4C9fjR0o49vIWwI1L
eQUBXRRH7AEmyW34uJAaKJxZQ4SIMdjqNZyNzkwjVJ0K4ctSh8OoAMXaX5sWT+0T
KqF5KPYqC8cZpC4cf5amzXxuOUaxsNTk+A2tn9p8zhe/QapcEWiCoYhwJsie3dqA
9KzD0nJeK6B5clPifA+r3XD6phjO0Hb9rDadZgrVGBxRkpQiVpfIqDYJ0p7QxWdM
gkOOePx7iedur/YHRYyS3sp0li+botoNvW3LhMZHtMxidSD0QltBc57nqikNQjVh
3x6eC5XSPCeinb3kbSWzknGn0m97Iw1RDc9d8BxdoeR3rljP8jU=
=GN3j
-----END PGP SIGNATURE-----

--f6fcnoobhaeczu2w--
