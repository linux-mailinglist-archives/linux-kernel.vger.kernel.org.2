Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3D3AA709
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhFPWxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:53:13 -0400
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:47333 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhFPWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1623883855; x=1655419855;
  h=mime-version:from:date:message-id:subject:to;
  bh=rlua6TfeeN2sXJkC8s+D5ALLnhCcNCnD/0D2Hh1jRcE=;
  b=C4EOUUNFLE6Y3DXq4G23lzX65DFrVoQRXWGBDuj8SzKKj04HQxg/dDgM
   mKLMUo7QxZeZe1/dQjLlKobaCh3cSX+eylVFQlfZVngwoWe+D7FHbEwg0
   kZSBIlUNpqpDEFM3AtEhksIMZHnDO2vgfd/FdLzoA99dZ+2YElLcyj6Qk
   WFbqgEF+Tjqg2nWntwmvvPRaruJGCWgmbmeep9/1U7ZUgbqWIVxCoCuy0
   qOz+XQYb+jwlR7zxRR77v4FrZ6H3tyRSNLAfH5lcH/gd9uxhDt0G2qhau
   goLtzQoSKsKbthNPY51vF4vgaNc2sEyS+pI1NJRks9JJgi4maPYXwWOhW
   Q==;
IronPort-SDR: 7qOQYGXuUfCMPO0O53Z+EDZmbe/oNJ7BfPdFlmliji0Nz924JL2SCb9jlXOIXjMVYa85pe4d5g
 T1EDST+LW1vKROhxHVLd/12hMDXdnyNtV1l0rzQLkYkWaTmrXXVy6lBEvmZ4MZq4Db0fqvoTYJ
 kd1voyp24K6a4Z8tiyyVAFWIut3j9LKkGq1oU6SM8CIu3jKDgWNjXEYqGVI2MrMfOxLIKIl/38
 vLQmqlyZIv5vZLimbVTz0gF4H4oWrx+EpSzU/SSax4aY3Esyy5hs3bo+f/3pQQ2yZDZDZPACDv
 ZXM=
X-IPAS-Result: =?us-ascii?q?A2EPAgA+f8pgh8bSVdFaHgEBCxIMQIFMC4N4bIRIlSkBm?=
 =?us-ascii?q?CWBfAIJAQEBD0EEAQGHPQIlNAkOAgQBAQEBAwIDAQEBAQUBAQYBAQEBAQEFB?=
 =?us-ascii?q?AEBAhABAQEBbIUvRoI4KQGEBREEeA8CJgIkEgEFASIBEiKCT4MImFiBBD2LM?=
 =?us-ascii?q?n8zgQGIFQEJDYFiEn4qhwmCZ4QhgimBS4I3dIdbgmQEgxwBehODdgEBAZAsj?=
 =?us-ascii?q?g6cZAEGAoMEHJ15K5RukH0BLZUppFMQI4ExghUzGiV/BmeBS1AZDo44jlUkL?=
 =?us-ascii?q?zgCBgoBAQMJiVEBAQ?=
IronPort-PHdr: A9a23:bDgygxA9xCiL9jF+BpplUyQU8kMY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZuaw8ygSTDM6Ku7ptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uyv/5DfeQtFiCS5bL99K
 Bi7rhjau9ULj4dlNqs/0AbCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3T
 bpDDDQ7KG81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjm58
 axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7WYNEUSndbXstJWCNPAo2yY
 YgSAeQfIelVtJX9q0cUoBeiGQWgGOHixzlVjXH2x6061OEhHBnE0wwhHtMOsGnUrNLoP6gRU
 eC61qjIxijEYvJW2Db96JLHchE9rf2QU799atfRxlU1Fw/fkFqftJHlMiqT2+8QvGeV8/BuW
 vizi247tQ5xuD6vy98th4TNm48Y1F7K+ytkzYsoJdO0VlN3bcCgHZdNtiyUOIl7T8w8T2xpp
 io3zqEKtJCncCUIxpor2hDSZuCDfoWG5B/oSeWfIS9giX57ZL6ygwy+/Eugx+HmSMW4zUpGo
 jBYntTItX0A0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZoTrFjDEjf2mEroi
 K+WcV0p+u2y5OTmZrXqv4ecN4Fphg3nPKQih8iyDOciPggBWGib/uu81Ln98kHjXLpKifg2n
 rHYsJDcO8sbura0DxFJ3osn8RqyDDer3M4GkXUaMF5JYg+LgozqNl3WJfD3F/a/g1CikDdxw
 PDGO6XsA5XML3jDirjhfKpx51JSxQco0NBQ+4hUBqsfL/3uR0/9rMbYAQMhMwyo3+bnD81w1
 ocfWWKJH6+YP7resVyW6eI1JemDeosVtS3jK/gq+fHul2U1mVwDcqmz25sYdnS4Eu5hI0WDb
 nq/yusGRG0RvQcxQ/fCklCOUTdPIX21WuZ0yjglCY7uJIbZQoGgyOiI3T2/H5BaTmRHDE2cV
 3blIcHMd/4KaS+WavFsjiAJT/D1R4Yn1ByqnAH01L5jaOHUrGlQuYjikdR4+eDXvRUz7iBvS
 cqH3myBQnp3gmQQATgs0+Q3p0tg1FqKzIB8gudEDppd/f5EXgohNoLb16p9Ed+2EgbAeMqZD
 VWrWNOrBRkvQd8rhdwDeUBwH5OllB+Q8TCtBuoklq6LGZt8wKLV3jClNtR9wneejPIJklI8B
 MZDKDv11eZE6wHPCtuRwA2inKGwePFZhXaVnFo=
IronPort-HdrOrdr: A9a23:l11I1ajTBf1hPPpx4+JOw9WtNXBQXtMji2hC6mlwRA09TyX4rb
 HIoB11726WtN98YhEdcLO7WZVoI0msl6KdiLN5VdyftWLdyQ6Vxe9ZnO/fKv7bdhEWNNQ26U
 6tScdD4RTLYTZHsfo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="48886286"
Received: from mail-pf1-f198.google.com ([209.85.210.198])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2021 15:50:52 -0700
Received: by mail-pf1-f198.google.com with SMTP id b8-20020a056a000a88b02902e97a71383dso2484109pfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 15:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W8sgVYgsWMdUE1wHeIEoHud9eQP11SIxXPuwjP87UZw=;
        b=kSZ24cUXF/xbiiLuqZ4nIoxI9q2qjnsE7G168/ibkTpT2K31zzVZN2+uV50FuUcyYV
         reBP0a+bCR0wc9CjHEKqFudiF1hldZhjbeIrjC9m+HM/xjIJvOZfMzEn/gUvBt4hYl+P
         K1p2owmu/n9PSrfeGk/UzaZwsXYHmrNZM6KyDSbn/HOFcSKBR/vpiLqLpSavX0Y3I+gu
         YM3P8HxrzSBxsXUABp+OLZWsFP7Q1RFwDILyz08LqZ9FNBwBC3UU+kNdVhBFat/+dIEG
         iMOiikphMqmfG/3vbov5zqi+KvlF3FcAK09FiKRa/YFUpYQy4Kn/Rn5o+9Kf6NYrjvnV
         ukWg==
X-Gm-Message-State: AOAM5309r0uObp/8v84IlJtnWnObEVvW6Gzvo3emLhsCrgQB++c9WPxi
        es8zfF1zZ6u4LamiZrVJXAbfx59raJ0XtIISmVzlX3bbNxuZJq/jtmrv1eC6XrripPr6da6kbal
        Llsh+PtcIsUgYFu/ysQhzY2p+1Z6oIhHF2Pd89iaKPg==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr2289209pju.144.1623883852351;
        Wed, 16 Jun 2021 15:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpBspB9QJdH+f58DOOAFndNmFeCe7X2gL2GM2hO1VVOXQa23XnJmXHTZeZxwy2XrHghuDEEc/1KtDqeJG9FZY=
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr2289201pju.144.1623883852186;
 Wed, 16 Jun 2021 15:50:52 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 16 Jun 2021 15:50:41 -0700
Message-ID: <CABvMjLTVZaU8vMW__2BDo6FnjFa_bsh2S-kEmg=KV4KTsFiUzA@mail.gmail.com>
Subject: [PATCH] drm/nouveau/core: fix the uninitialized use in nvkm_ioctl_map()
To:     bskeggs@redhat.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function nvkm_ioctl_map(), the variable "type" could be
uninitialized if "nvkm_object_map()" returns error code,
however, it does not check the return value and directly
use the "type" in the if statement, which is potentially
unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
index d777df5a64e6..7f2e8482f167 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
@@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
                ret = nvkm_object_map(object, data, size, &type,
                                      &args->v0.handle,
                                      &args->v0.length);
+               if (ret)
+                       return ret;
                if (type == NVKM_OBJECT_MAP_IO)
                        args->v0.type = NVIF_IOCTL_MAP_V0_IO;
                else
-- 
2.17.1
