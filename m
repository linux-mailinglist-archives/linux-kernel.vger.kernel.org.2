Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA944088C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhJ3L1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJ3L1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:27:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67FC061570;
        Sat, 30 Oct 2021 04:24:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d5so5490092wrc.1;
        Sat, 30 Oct 2021 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7xavHv1Il8UdSsJGPMXxUxUi9idHdGLlQpzGC+6BG7I=;
        b=hr7KkC8xGfMEZ8hVd1t5IxeHNZVp9RZLUhCebOskkyoisoGoLEBTdBYbIaB2bku7YX
         EXSDtetmVn1YGnJTqG8zhVbM2z1upzOwj4YypN6Q4Y4clobJO3eks87o9M3mauXIvLNw
         AbuebhUb+Xa0iQ/3UfunJczUugyWTqz1hOwPBw46/vA+gTlsP8MWGLfY07YvBLInbjpc
         ig2HxpT5FPFZL2+Nu8hG9gIfRuHi1TkZ381uQwFBIBsfqFfMPKHgTsEH71Q2t//EjFhO
         k3ndC/Gay/2MsuYpUUVk+pU0b0YsfEnv62veABrCnw0ZF/WUuY9x4omjYEcRpTJLJmc9
         XhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7xavHv1Il8UdSsJGPMXxUxUi9idHdGLlQpzGC+6BG7I=;
        b=FO8RfMv28/kIG6MIUKlj/tG/R39sQoTD1wCv3WJF9yXM9Lv5GyuPL8VuLK/TvK48wF
         aqeZ3fC2mP2spDZNXhjinM6UFpeyFLS5DJyDCZ3htttEp6+vVs3dhgROsBisGs5hTUcS
         Bbea9Xw+t6VJsCLDCxMSXrlokc47K69zTYD+d3PMgXoyHuUVfqKp8fbSAwkhUuSv9+ZP
         hiGt7YX8XkdtMXf1ownZsd03SMY3cr+c8XplRt7R7WcoZrcwxih6zB/av5QwGBYtPu2U
         gjZwVs3abjqnCDewquqMjvup7Z4nPmXCoBUz3NU3Rlr1qunV7ZueafVloFJ2oLwYd7fS
         TjEQ==
X-Gm-Message-State: AOAM531k7BwhsV7/BvBSEo6mA189nZ7ELpjNPXXUigL5Z3xO8t+boVH6
        7hSuKe/7SSTHnb69OL82fYRetN0fUMA=
X-Google-Smtp-Source: ABdhPJzN/vxFueQGbYOGI9AfIwSporfCybicaxHpOWXFFBw13B+S26szI9Ge97ZLP4l7xugXt6di+A==
X-Received: by 2002:a5d:4909:: with SMTP id x9mr18042026wrq.313.1635593089918;
        Sat, 30 Oct 2021 04:24:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e069113f7f01122185925.dip0.t-ipconnect.de. [2003:c7:8f4e:691:13f7:f011:2218:5925])
        by smtp.gmail.com with ESMTPSA id f1sm7978237wrc.74.2021.10.30.04.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 04:24:49 -0700 (PDT)
Date:   Sat, 30 Oct 2021 13:24:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 0/3] Docs: usb: Example code updates from usb-skeleton
Message-ID: <cover.1635591623.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example code updates from usb-skeleton.c

v2: update patch #1
    - changed kernel message to be in one line
    - added missing "n\"    

Philipp Hortmann (3):
  Docs: usb: update err() to pr_err() and replace __FILE__
  Docs: usb: update comment and code near increment usage count
  Docs: usb: update writesize, copy_from_user, usb_fill_bulk_urb,
    usb_submit_urb

 .../driver-api/usb/writing_usb_driver.rst     | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

-- 
2.25.1

