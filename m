Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DB417F58
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbhIYC0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 22:26:05 -0400
Received: from mail-4324.protonmail.ch ([185.70.43.24]:54639 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343687AbhIYC0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 22:26:02 -0400
Date:   Sat, 25 Sep 2021 02:24:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1632536667;
        bh=DV8F1Jf7EBf3HE0dfQzQxsqQ6nT1sRzn8zHjolegFeM=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=VpPIReeCPjfz8t9kees+LdbmaGCXAK5qdpivX0MDE7qLkyR7Hh2sJ5rG+uUzndB4m
         +kSCK84znUo1afvVSwL075biijo9EXfRlJO5T9rG8I+Z4MTLl0l6B5NS2J0DRKUV1P
         8YNdmUZ8G4LAbiUun7tr/PNsYMBjSHHl3qQLzId4=
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] ASoC: wcd9335: Use correct version to initialize Class H
Message-ID: <20210925022339.786296-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The versioning scheme was changed in an earlier patch, which caused the ver=
sion
being used to initialize WCD9335 to be interpreted as if it was WCD937X, wh=
ich
changed code paths causing broken headphones output. Pass WCD9335 instead o=
f
WCD9335_VERSION_2_0 to wcd_clsh_ctrl_alloc to fix it.

Fixes: 19c5d1f6a0c3 ("ASoC: codecs: wcd-clsh: add new version support")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/codecs/wcd9335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index d885ced34f60..bc5d68c53e5a 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4859,7 +4859,7 @@ static int wcd9335_codec_probe(struct snd_soc_compone=
nt *component)
=20
 =09snd_soc_component_init_regmap(component, wcd->regmap);
 =09/* Class-H Init*/
-=09wcd->clsh_ctrl =3D wcd_clsh_ctrl_alloc(component, wcd->version);
+=09wcd->clsh_ctrl =3D wcd_clsh_ctrl_alloc(component, WCD9335);
 =09if (IS_ERR(wcd->clsh_ctrl))
 =09=09return PTR_ERR(wcd->clsh_ctrl);
=20
--=20
2.33.0


