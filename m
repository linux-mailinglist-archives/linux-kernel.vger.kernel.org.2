Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4864373DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhJVItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhJVItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:49:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DEC061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:47:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e19so261224edy.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KA9I3ku/yl5Ro/+/TKxhZayzdnwHZaosfiwgC6DMsY=;
        b=aH2p1upryD2RIC1dblX0fdrnz6rt+9HuDHOmQXeE5jbRMdE1MrHfovK9xh26/feB3X
         /pTHHyAk5O6X18d1qoY14Kx94vQKQ/Ud7AYQRws94n8Av/d9PuoxbXQDBdLnSdo1yp4y
         T54geFZrceVTxhgKv5ErUSXiaLsfQzqWmP70rHkXJTophKbLBEK9ljK319oGStcQWw6M
         v+x7ap56zPlD2DD6f9BHaqOSGybg11w9/9EBeKsmEVxKFQBHwJoXOe8o/YwFU9JV41zi
         GVgh4P5IeuptWpzOe1eIFw+L/yGmXgRP3vRUyNhGNmdxophd2iudyPHCEWlThP/xERVi
         jKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KA9I3ku/yl5Ro/+/TKxhZayzdnwHZaosfiwgC6DMsY=;
        b=AICxtogTDRK5fOF0yNq+D6L1AjX91t//v3VWKPqBbk89hRqOBpNIXwNTeTByeKX8nf
         QEMuCre1xy/pYoqoTEvlvp4zd2VNUpMLwN4wAxKemCXX20YOSnll88n19tSWjkfu6h/m
         bE+PKaGjPcbfz4tkyaNrDD/wPGNFFHj84lUBqLYeFqO6Zg1OOuul90/IdmRfVDpgHr/Y
         I+1THXsnrwqm907kFX9ULEtCCXZYx8FQAe8H0/5RFOXsjpNzlY7eTLy32DeHklwyPeec
         PMnHRPcukMlhzuSpeFqUmq+bEY1EXlvJpq00Py2wWwnrbh0Xt0XnXop2VwME6ZUbqFP7
         MC9w==
X-Gm-Message-State: AOAM5314zI+oFFhsfpjfBKELtYK4z4LSXh1sXpYF0lVJ100Tilai7gIA
        O9+IYYOY7NQ+m4QI/WFEp2Q=
X-Google-Smtp-Source: ABdhPJwkForZqW+Edg2xTX2DO37w/ItkWzyt/DO80GVnIPcVj21SpXHQ7SYFPSXQ85tafnE3i3VPwQ==
X-Received: by 2002:a50:d802:: with SMTP id o2mr14648994edj.331.1634892451768;
        Fri, 22 Oct 2021 01:47:31 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.pool80181.interbusiness.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id au26sm3446979ejc.53.2021.10.22.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:47:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/2] Remove unused semaphores 
Date:   Fri, 22 Oct 2021 10:47:25 +0200
Message-Id: <20211022084727.28035-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two unused semaphores.

Fabio M. De Francesco (2):
  staging: r8188eu: Remove initialized but unused semaphore
  staging: r8188eu: Remove unused semaphore "io_retevt"

 drivers/staging/r8188eu/core/rtw_xmit.c      | 1 -
 drivers/staging/r8188eu/include/osdep_intf.h | 1 -
 drivers/staging/r8188eu/include/rtw_xmit.h   | 1 -
 3 files changed, 3 deletions(-)

-- 
2.33.1

