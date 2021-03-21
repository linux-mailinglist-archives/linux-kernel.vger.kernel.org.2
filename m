Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB993431BF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 09:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCUIcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 04:32:41 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:41198 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230105AbhCUIcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 04:32:21 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id NtVMlAZljtpGHNtVSlqmNB; Sun, 21 Mar 2021 09:32:19 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1616315539; bh=m7+hpBIhTRQffrauWC/6lWcMM7xEkn2kEXsVUG+UrKw=;
        h=From;
        b=JB16+7MQLmoHWT0UdN8XCTMkUhB2OY0sPrcjqV5eycvy2HqrBJmTOuxaozN6hP8Ja
         tZvxutQj96NtbcId+RS4d6SdzncCPQ7CoPm4Ixm/6dNH8jU/J+LG0D3h9zXFGax1Rf
         gIx4zej60rT4D1nhXc7vv1ezv1ifYj+wQLmAJ4+DtoreFvkFH4g9CK2yYV5ni7dMYF
         f12oNffCYMhvXBn7HuFKMT7UpWzNEZ/iDUqGwYLcJhWystHMIPT/kvsWX+ztBc9gwZ
         Ruc6JqeZeTIlte8W1bQUbDVonuNcinW2R52YPkrw6TAFJEHcYguER4voLSj+B71ktj
         VcIW2huQiwe1Q==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=60570493 cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=avqEcO1kaKR2PiVpUlAA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/3] drm/tilcdc: fix LCD pixel clock setting
Date:   Sun, 21 Mar 2021 09:31:50 +0100
Message-Id: <20210321083153.2810-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfIj4rJm5dms7RpqtK7r6MP7nj4gPez2Gizo+mtaRkNUvghzf3fBHnqPciI+V+HCV4M6uLW010j0FjnoCKzzdw4mIurEqqRYwa2mFEFqK2G9iD5ji90Ha
 EmxnWwkWR/NPa7mEArjJD39xlosjKRS1JOU8Bq+0yQ3fYCslMdjFjBY5foQNt/wZuExKN5JpBhcyKmD5NMkSeNyH04wlSlw7bq4w1KE5TyFkHhyqBAKaKuNQ
 fWoJ3r0et9fuD2xIENl7hCn+Vj/OpS9JIW4SiRULuSPYtEBZN6R6YqfKodrtEvQcMvEo2LN39eG4hCe8QwGw6GHb1IpZU4XslyHEe3NZ5ti/p7YYxOw4WLoV
 2nhvACNbpeC3yv2M77XxEGG+9BsG2rohmaNVaUpkTWnXn6tl8ZmOMI8R9ggi26u2fFTlFYtb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The series was born from a patch to fix the LCD pixel clock setting.
Two additional patches have been added to this. One renames a misleading
variable name that was probably the cause of the bug and the other fixes
a warning message.


Changes in v2:
- The patch has been added in version 2.
- Rename clk_div_rate to real_pclk_rate.
- Provide pixel clock rate to tilcdc_pclk_diff().
- The patch has been added in version 2.

Dario Binacchi (3):
  drm/tilcdc: rename req_rate to pclk_rate
  drm/tilcdc: fix LCD pixel clock setting
  drm/tilcdc: fix pixel clock setting warning message

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.17.1

