Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26A3418420
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhIYTWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 15:22:12 -0400
Received: from mout.web.de ([217.72.192.78]:42987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhIYTWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 15:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632597626;
        bh=+8Ye/4nUqGrtZDMUDdru6A424ExVF2p9QROtN58GQ04=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=rkEo1c4ieOgZdSvIb2x1DSygb4EFbZOSpIsBMX6yMnFSg/7h4E+ypGsmEffHkWbKZ
         PgiIQCwWwZEUqyZe9x2jUBlFVJA2lKs4know9NRWTI912gPtCBPa1n+yWvvvfetXsi
         OxLfK8HMNnG+4nh6D5eICdw8u0/cCj4UScRuF8/U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from michael-LIFEBOOK-E751.fritz.box ([94.134.116.230]) by
 smtp.web.de (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M1rP8-1mS1MQ3Ej2-002hLf; Sat, 25 Sep 2021 21:20:26 +0200
From:   Michael Estner <michaelestner@web.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     michaelestner@web.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Remove uneccessary parantheas
Date:   Sat, 25 Sep 2021 21:20:15 +0200
Message-Id: <20210925192018.6745-1-michaelestner@web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vG3rfyHjdsA70oWYuIu0rZ6gKYxwFE9HXxaNP6AKJS9e4l5/FJ1
 /4LOaUhg927l0ZSjj0Uv5qE7ri01yQbf5rgwOAcZxU4RXUFr7PVzBzCXy6krGl544uJXB3Q
 Vsaij6O0aOPSsgkP7hZM74IcQ2x9d49K8NLOMaI0lbb0rtGiM+y+8g9af1iUU3cELSyWdRD
 aZOl+3w/ms/7DCdB8sJlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:idKFeNRLxDI=:lRENygGE4X9o/aInX3AM4g
 cKaFfG7KvjP1lAxF7k6/jlL22tQL7a2pNph5dwTwK2w+7zUQOB/B+NOGCoQLgcVF1dFMpyyqH
 lp7y7Z9bYDzI7m7ydVB07mUL+9v5kLEpyO9APUSHZGSVEiWDad0EpGcIKFtTtCyNY+DiDaFTC
 EFuo08MJZ8ZlT/XsJwL5raRaJ8nKNgdjfV5CVFrBtrA2vdmq25czPnI4nAdRQipVqgDx57NiN
 06KKNYMqX5FkPWK0rQkjCvmlSKkI/ZPdrGtDwAM/e7X1v+way/zTP6J44w5sbSUNZsJF55VDk
 vKg1itwvPH+Io/WQmsW64q9FH3tDWtCBbJN902Sre71mW9NOGj0JR1/R40h5ZxLb4aRSBFIFb
 X6Wpy3vFNYxUGSY7rqGfVv9l1WVHrbi3m8YFdToybAOPuE1h4Y9IvmFVlBbbw+xn4UWfjeXZc
 nz37YlnwfHgwNCl5+XicufX/iG9w5tJhaor6qsXOK5E40oGPwstJNxirzaqPWIoFS+PagcqPN
 hut5Pe+Kk4eq5gqMpjii1ob+muk3QiFK40bl633awvE/ICyn5pSdyeKJG+YLWdwZWtCqyoVG5
 9PEI5df17r7rQr02jeQgj16Mc/FWr4XMTeNhbBdjtCFwlXZ4/Jwr6XLyeZdKTIW+4pdmTcuSL
 VfTZPMOknB+Kn/NyOXDRmnaayz6HI/zu6PuUQDJiuQ7PrjH9xbuFNH89BOCrcT7F3YNTHjDip
 AeYze0j9IglOCVzWyiDZtiXsLOFr3SRK1RB32CwEGfGqwXMGVuiL3bpt6MjMVKtFfr3fR9f0E
 gPFkELWaFWYwtYfRplQU5bsIft6jPtKyu93Jjoivyhns0uyXzKCEDPkq4C0IaRYJE+YMC6TZG
 bYLeH46lBjASqA47fYy8d0//0c+yxGNuAPKpTvTxu9u61Y6fxP5nNmdzmix4RBRY0md1vvAqs
 yo0qFrK/ZRsvUxEmRFi7jgt2sWg9+LvZAngCHpIScNjZrgOBA40Rhv7myErLIbA7Ql1vql/dV
 3BgrYNCQYceUpi4sx2FilKuJZ9I74H6xVnq66C+e65E2FHIxxlDuJXf2NH+p5OrbMfk5Wpitx
 6K6aM0XQRWjGY8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to be conform with the checkpatch style requirements

Signed-off-by: Michael Estner <michaelestner@web.de>
=2D--
 drivers/staging/pi433/rf69.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 7d86bb8be245..980afa801e08 100644
=2D-- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -470,9 +470,9 @@ static int rf69_set_bandwidth_intern(struct spi_device=
 *spi, u8 reg,
 		return -EINVAL;
 	}

-	if ((mantisse !=3D mantisse16) &&
-	    (mantisse !=3D mantisse20) &&
-	    (mantisse !=3D mantisse24)) {
+	if (mantisse !=3D mantisse16 &&
+	    mantisse !=3D mantisse20 &&
+	    mantisse !=3D mantisse24) {
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
 	}
=2D-
2.25.1

