Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0003451D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCVVeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:34:25 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:50868 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229467AbhCVVdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:33:49 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id OSB9lKwj3tpGHOSBElyOi1; Mon, 22 Mar 2021 22:33:47 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1616448827; bh=P157cUPErI7dIQlm2N4AO0ObF6xkwf+djK5WsXbfGFs=;
        h=From;
        b=z52SLEVJcTuIZxwDJyaSTEv7Nzqzq5UjmEA9y4uVAiv2MzeoYsOo8ycEq98j51y5W
         d2bty9f5FE/AJUrfkuRYbz+uO5DpDTrOGXTfKfr+tI+vWeyQ4wdFl3SMR2R5R/GOKB
         ZjTuu4x9OgoHQz1RQeSJFxN4cd8bAw7Yhs6IYk9ABdWEO5wr0UnW6pZZ79F4zpHQv/
         EdipKzp/CEsrxrXmO0DzY0YULGbrGYwp1hu4XgK/tvHJoOh5rxN6U2ixcGbLnFLMAZ
         7Mhqhy8yKY/qFQOtw8q+8vYRwC3r6/Vwmr9Qgn9QLMyUNi5QlhYBbUt3vjvlpUnB7/
         yQH5e7ak65Hfw==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=60590d3b cx=a_exe
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
Subject: [PATCH v3 0/3] drm/tilcdc: fix LCD pixel clock setting
Date:   Mon, 22 Mar 2021 22:33:34 +0100
Message-Id: <20210322213337.26667-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfA0fpS3Le705qB1u6/CBmKnXBW6dgQPIptIRdTsE08Zio8RdtDgWrgkvh0btIFLNVm9DUNUlYrYvc6/re4gjr9OeV5Z4mkTaupXKAD8Q7v23zg5kS3uf
 Gl94t7sX2hwE8lIImbdbckj1mg6TAa+LpbxoWz7N6u61A/G3roNepdbCEmPLSlZsskYkgIPh+3RpWRqhBQ6BinNfTDZlpOUYn4de7N6c6P2PxOVf7Fytoyvm
 q8THQJ4f1evWCO6IsKnEZRVvQIl2w2JhXh8H9kem5eFSQ76/c1IFfAKwousHr3rvNJFKa6kvj9R0Jy3R9upyVhuOfpqExdQpL8lNvkXfT96V/8a+gzre//gT
 jIsiwnIMUhTnPFtYzi8QTRw9ZlEigJhpFXs9JMwtph4MOl7i2XTDUIHCcqCwYg4Tzdqdq9UX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The series was born from a patch to fix the LCD pixel clock setting.
Two additional patches have been added to this. One renames a misleading
variable name that was probably the cause of the bug and the other fixes
a warning message.


Changes in v3:
- Replace calculated with requested in the warning message.
- Swap the positions of the real_pclk_rate, and pclk_rate parameters
  in the warning message.

Changes in v2:
- The patch has been added in version 2.
- Rename clk_div_rate to real_pclk_rate.
- Provide pixel clock rate to tilcdc_pclk_diff().
- The patch has been added in version 2.

Dario Binacchi (3):
  drm/tilcdc: rename req_rate to pclk_rate
  drm/tilcdc: fix LCD pixel clock setting
  drm/tilcdc: fix pixel clock setting warning message

 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.17.1

