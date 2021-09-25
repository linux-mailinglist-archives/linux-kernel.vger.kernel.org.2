Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12AC418447
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhIYUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:06:24 -0400
Received: from mout.web.de ([217.72.192.78]:35159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhIYUGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632600282;
        bh=xl2lRXURmfHekOv7JY05eAY/G+InvVeaZ+l+7Ga9/uE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MfWoNYN0GKO9PI47KaYZYu7wrtsY/4ZXWnSA7u3S5Nv0zEgXpwKdvtwYXzmUW/NYu
         /pMFVGYogzXmVc7T9YPIyZ4Y3rnUgghvKuawBD4S2hg9EkrjKmaj5FtCbfragD0+PK
         FI+dVotWYGmYGUOdvukMZ6yPaDTMH2uBTIoPxsew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from michael-LIFEBOOK-E751.fritz.box ([94.134.116.230]) by
 smtp.web.de (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MK1s1-1mSr0B1AG5-001TAp; Sat, 25 Sep 2021 22:04:42 +0200
From:   Michael Estner <michaelestner@web.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     michaelestner@web.de, Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] avoid crashing the kernel
Date:   Sat, 25 Sep 2021 22:04:30 +0200
Message-Id: <20210925200433.8329-1-michaelestner@web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8jhaTcO6SJ/aaZ1SCkfb4dQ6JRUmQznFIaqc2wc+ZIAaxoZUy2E
 x0S2rqNgDc+BNBEHXeJHbrBgqcv6yh0mXQhq1Bi2bSZwig6zzB44sR/YXOOGfIHiFd9AiiW
 V14xz1RdL32J0wMaRFRG5+AwCh5FzLMyEs8X04deuGZvE3W1xR3Igy7h1ipSnv78UNgsn6c
 l47wm+J98qtUv76CpsHPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JlkwreOf+E4=:cLDzPzUrEPwo1DZtlDU9RS
 dBhaFvQ+aXVauXUveUpX3tf1XG1CKGvagrEspfBSFD38jDf2fgcAC1aNIzUNZgk8EQw9JruYv
 e0q7mkcPQaWYzaqRxE0f2IK+GfSE5IX8msAQlcv7EgA7gYq7t7xrQtT7AZ4uibbnB5VnXqdLb
 7J+Xz2q7uFZL1FlLdbhhR6lZldAl3U9b7f9ivOz7NKIysfx6RmgfKdW4c4j/mYrIpEFtuhkQP
 ydGmZmluNrkrrQ2Ut6Gmv5QXk+XaSNKLKpKXNRwzbk7RzpoLu90V6GfLHpzzGg1CSUHiH1ulQ
 skG3zAv6abvtvkFU9WhHsNBKltY3N2yE+Af2N7aFyp4bXXebt33BxKugrDEe3sI760Qk4kMex
 36hVyKTT8yYguNRNQkSVF6zjX8k+fx4E2/KE1iiSlPHyAANyPvobXkTNJ6ahHBzk0fukjgfRl
 HvRyQXbHftnilpVOWtF7xn93haFmCuNyu9UUos8HS1hLn35JwcA6HpeP7tewtbYB8buFp1ept
 qaK3CR+OtB+YN52NuP842510hTXIHJ9KxEKgAiskXJJVxL/jRYXz+aTeXN89/X8zqeckD0bTe
 lqOUPI/KKObuSo5sHhovBxwzorTzj4e9aVWPSrl7AuNYuo44W4T44iXd23ExyVANNFf3QgLOs
 rW06dtKPhuMkF3uepwyDbSA3lj9tL4gEwcl7/q5IT1Wimkxf6Cfz7ebZzaznXBdj1497IlIfO
 DKhx3NDVnx/LfiXROV8djikv7rkMCkhbwYv65vW3iXtO8WnLaMfIPjuRsfNWQKfZzCKYkBTSP
 dWFvWYW8TLAbCfY3bNCWDbwPLNJUZHbcp9IWKo3PzAoQL0rF+2RT8zsQJVbw+WQcTtBsf9X6S
 SDGlagfQut88cHHyyOWBUIZpfaiwNfxXebgJ0ozTgenuenX14S8gAsgDYmZMymH2woAvwpA84
 tkh4eBwRawvqln7mrc6Dx6rgDvlJkn56Ut8k8b5PxxEyir7sWsHNGMaUJsxleXEgzJhoQKJ++
 Kt+e6DBPwvzwQ6kP/QK40jDy9TnsdJ0D0Nn5Mnp3rJXec2d1whuFBHkYyCLQXalp1uoQ9QXS6
 eX7Sjg6xmv4xEo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid chrashing the kernel I use WARN_ON instead.

Signed-off-by: Michael Estner <michaelestner@web.de>
=2D--
 drivers/staging/most/i2c/i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c=
.c
index 7042f10887bb..e1edd892f9fd 100644
=2D-- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -68,7 +68,7 @@ static int configure_channel(struct most_interface *most=
_iface,
 	struct hdm_i2c *dev =3D to_hdm(most_iface);
 	unsigned int delay, pr;

-	BUG_ON(ch_idx < 0 || ch_idx >=3D NUM_CHANNELS);
+	WARN_ON(ch_idx < 0 || ch_idx >=3D NUM_CHANNELS);

 	if (channel_config->data_type !=3D MOST_CH_CONTROL) {
 		pr_err("bad data type for channel %d\n", ch_idx);
@@ -122,7 +122,7 @@ static int enqueue(struct most_interface *most_iface,
 	struct hdm_i2c *dev =3D to_hdm(most_iface);
 	int ret;

-	BUG_ON(ch_idx < 0 || ch_idx >=3D NUM_CHANNELS);
+	WARN_ON(ch_idx < 0 || ch_idx >=3D NUM_CHANNELS);

 	if (ch_idx =3D=3D CH_RX) {
 		/* RX */
@@ -167,7 +167,7 @@ static int poison_channel(struct most_interface *most_=
iface,
 	struct hdm_i2c *dev =3D to_hdm(most_iface);
 	struct mbo *mbo;

-	BUG_ON(ch_idx < 0 || ch_idx >=3D NUM_CHANNELS);
+	WARN_ON(ch_idx < 0 || ch_idx >=3D NUM_CHANNELS);

 	if (ch_idx =3D=3D CH_RX) {
 		if (!polling_rate)
=2D-
2.25.1

