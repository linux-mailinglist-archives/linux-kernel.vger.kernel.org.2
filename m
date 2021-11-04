Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE874459BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhKDScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhKDScA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:32:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38D0361212;
        Thu,  4 Nov 2021 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636050562;
        bh=+sUX0vKdyz/6vLwFQjYYhPpyde5Rlw0gj3GAvCupec8=;
        h=Date:From:To:Cc:Subject:From;
        b=k7RSrzW9iSNOCQ/t9t2ra9kkCeNYAtYpl45T2yxh8PLVjXNYMEjcR7jioxBM9wMyU
         lf8vFZOaPHTE1b4+FS1mbCqrznRgnkwzSyc7pIAB607qcv9osh5i0Xv99OJTA/sVyK
         Yaqe51LkTI4ewhtxT8TWvbEN4cNQhxRe1DfBM+8ZeDw3+RsipUmuzALmQESZf17gfE
         e88If9zKFQ30Boez1e3spKyIrm9xFHd2VLKs7j4Yq5eo9qfRy6S3IBN1AFXYX/xIIh
         Q8RNWbLCFkd4g+QCmN/bRroEW6CjaVq9I41QVQDVE/oiyo6/7I/pxrulFxnFHSkAlF
         nOD/WaY5RG8Sg==
Received: by earth.universe (Postfix, from userid 1000)
        id 930663C0F96; Thu,  4 Nov 2021 19:29:20 +0100 (CET)
Date:   Thu, 4 Nov 2021 19:29:20 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-5.16
Message-ID: <20211104182920.tku5e6ri2qwz77er@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrlg36e7jm5fveky"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jrlg36e7jm5fveky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.16

for you to fetch changes up to 4ef69e17eb567a3b276fcc3cb3452dcf89d8b063:

  HSI: cmt_speech: unmark comments as kernel-doc (2021-10-02 15:40:50 +0200)

----------------------------------------------------------------
HSI changes for the 5.16 series

* cmt_speech: unmark comments as kernel-doc

----------------------------------------------------------------
Randy Dunlap (1):
      HSI: cmt_speech: unmark comments as kernel-doc

 drivers/hsi/clients/cmt_speech.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--jrlg36e7jm5fveky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGEJoAACgkQ2O7X88g7
+pqGYA/+Lq8+zOuV8EYJ4VYwQmF/17jisKmqDlZZB03wH0AUopxy0gY6TsRk0Nvt
TomBNMT+codDUOk5qDnWgzIUD7WlQW39A9r7v4UmXYCLiFhJozQCYTcwYzs+DGb6
T4Gzk9r6Un2tDBOdKxCSTnJxO5VGfTQ5KuiBFegcGlt9e0n2rGxAyhKBZJ3r0qQK
zjjHs17bppBMDqTYGvzFh9bL14hN5hKAVK84scAm8nJ87HPwCA4jzQqeqNIiR2zG
oymuW7TLrkExcxHBDK7+mXdAV3/T0FlixwCIb8VkFUdfejKK/V/rNrtTazmGbwEn
flWbqoSlF6EXULyPiVYHE6JzS8BtEs/Biq398jKw5eBc5ui5Sq9ZSXZU42MiR+Jk
3Vb1INP1JQCj01IJGuwQwTc5NP2ZBW83lJERw8I1mpKBZw+aiYSbcwiS0f23w0bf
99tQ3Yhcof5SFpooYYKXXrGx7Omdx61VyYKEfweBHinCoyK9Hd96WC3FlDXTMlzu
tNeq4Shie6FO7Axin3W4rDyrMcfYBSTY9atvfltx4eTQv9tTPU49DxLQ8DyUsrH7
jhWWLb1s7+rOnIKTiozNIRxJh5OWEErGD5p89Zi2Ow+STRPz4mxi62VjkyuQ8rnD
ltFdOscLaiT2db47wfT0hH9pbbTQvwqfbIrx9UAaHv/s0qWILGA=
=P37M
-----END PGP SIGNATURE-----

--jrlg36e7jm5fveky--
