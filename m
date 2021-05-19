Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC361388F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353741AbhESNoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353732AbhESNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:44:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF16C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:42:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k15so9467659pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVZkSQGihBwShgl8HOq8FcajrTqG1qrxRHeRqHbeMSU=;
        b=SLKlqLGMLkBhmW5gMF03+rdrAx0M3nrAGIRv/iBBkmdArqbh+McSLRGuGrb5vwrp31
         DWtSZA0zNXOBWHGYNfwQHyB0JEkbngSqKKeYfq3TEDsIFz78qGMuixk+kXt9Ss6AXAkP
         MjNo4Ty1Ki7m2ZoHxqYRPy6KDSKZ7Ro6Lz5ij14jDJGlzYv99zQT0kQdkxHG+cmBh8Xy
         lnx3S1cKHRmRcGojDQNaNUthJfoQEEbltH5Hnv6nBSCfScULeOsgw6yMR5CGjLIl6qPc
         oSGhvgPYUblYr03G+Cj+tBs3lBJtCmFgGdo7Ic6Uu3P8vyo8s8TS+Id7xnhdXknkfmDD
         5G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVZkSQGihBwShgl8HOq8FcajrTqG1qrxRHeRqHbeMSU=;
        b=WClo39lkaRdoul2egoSDbA3I+YdnbaRCzGV66SjBQBHKy18kW5fjR/gt5zLkUOV11L
         IDfLIyGZAGL2v+2DJPZhAX9RH5zrygMHt6sHp4fJL/EEoIHqLuGLP03/x47uYFYujmNo
         qNkTcKRhPdIT2tuJ92mMpt3l2rHuBz3TAuAQLSab8Jz6v9iwgm/T1t0Y2ZWNFkZLKLc3
         qnVxwFVkLassH+lAhwrmxd8KeBLEQAN8tMVN75x4RxdUE/ZQeY5KfzcDj0tW7NVJD4xW
         rS4y6SdCqRIOiyQJH7DleJuYgFJDixhA5Gvt3WBkFa8mgBOSbrqckWJZUmZU/1iWQZqh
         eZKA==
X-Gm-Message-State: AOAM530hV5JcU5H7pQ3qk4bvxVfnuJGzlFEVRz/NGQRD6ZTnfJheicN8
        TNmcYOFMzD0cLppQfGLHtew=
X-Google-Smtp-Source: ABdhPJyyYycNawXUBSpqS2VP+cIaEk/TWkpmsGe8wDcN4X2qrAOe1ATcX3vn37nW8DMtlfhyOJjk0g==
X-Received: by 2002:a65:640c:: with SMTP id a12mr10973519pgv.229.1621431768522;
        Wed, 19 May 2021 06:42:48 -0700 (PDT)
Received: from novachrono.domain.name ([106.214.255.120])
        by smtp.gmail.com with ESMTPSA id q24sm15470387pgk.32.2021.05.19.06.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 06:42:47 -0700 (PDT)
From:   Rajat Asthana <thisisrast7@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Rajat Asthana <thisisrast7@gmail.com>
Subject: [PATCH v2] greybus: audio: Fix sparse warning.
Date:   Wed, 19 May 2021 19:11:19 +0530
Message-Id: <20210519134119.848055-1-thisisrast7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519102947.GU1955@kadam>
References: <20210519102947.GU1955@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complains that:
   warning: restricted send_ctl_elem_iface_t degrades to integer.

I have looked at this code, and the code is fine as-is. Normally we
would frown on using the __force directive to silence Sparse warnings
but in this case it's fine. Case statements can't be made into __bitwise
types. We also can't change the type of "ctl->iface" either because that
is part of the user space API.

So just add a (__force int) to make the warning go away.

Signed-off-by: Rajat Asthana <thisisrast7@gmail.com>
---
Changes in v2:
    - Update the commit message.

 drivers/staging/greybus/audio_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 1fc7727ab7be..1e613d42d823 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -676,7 +676,7 @@ static int gbaudio_tplg_create_kcontrol(struct gbaudio_module_info *gb,
 	struct gbaudio_ctl_pvt *ctldata;
 
 	switch (ctl->iface) {
-	case SNDRV_CTL_ELEM_IFACE_MIXER:
+	case (__force int)SNDRV_CTL_ELEM_IFACE_MIXER:
 		switch (ctl->info.type) {
 		case GB_AUDIO_CTL_ELEM_TYPE_ENUMERATED:
 			ret = gbaudio_tplg_create_enum_kctl(gb, kctl, ctl);
@@ -903,7 +903,7 @@ static int gbaudio_tplg_create_wcontrol(struct gbaudio_module_info *gb,
 	int ret;
 
 	switch (ctl->iface) {
-	case SNDRV_CTL_ELEM_IFACE_MIXER:
+	case (__force int)SNDRV_CTL_ELEM_IFACE_MIXER:
 		switch (ctl->info.type) {
 		case GB_AUDIO_CTL_ELEM_TYPE_ENUMERATED:
 			ret = gbaudio_tplg_create_enum_ctl(gb, kctl, ctl);
-- 
2.31.1

