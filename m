Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AD0440358
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2TmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ2TmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:42:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF0C061570;
        Fri, 29 Oct 2021 12:39:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b12so13691151wrh.4;
        Fri, 29 Oct 2021 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7mQAaVooZ+3/w5FzxHsOnPcYhmbD/cVybvP2/CtUJ9Y=;
        b=pFeBkeQ5Io5H0fQMaF718IZeXwGdhlcPdKSiYc5BbAHodfDwdWeT+ZrYizU2ubRXgR
         t/4L0wo68Fk5Qdgvfclfa6+Kfd7yzHJex11kclUZd9uTlUJ6zJMHNVzMzpfmKqZob6f7
         M0lhapFfpvwCHH4hqb7tPFzC4WtqhrHRO+IOyb0u2DUF24CtKEOubax6vIPEW/OzJ9i6
         lX32ASUqP/l1o0sZV1bIKnacUYlmh2a+3NZ9d6F6aWxcYnc5QV33duf42Mdhe69on394
         kYuhZsrVdDRodHdByzgSVjAYzBfcC0b0RJmxzLW+uH4BUz9ZtFVQMBQlygG1HwMNlmsp
         JSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7mQAaVooZ+3/w5FzxHsOnPcYhmbD/cVybvP2/CtUJ9Y=;
        b=7hX8qi703UK67R8mJBdBVWdH84GOlcsLszgEK5rFBXemzgoQn5gID/FiC4nf+RB2JS
         4z9VmXd2UA6urZAHWTJ0QzQaEmbH7VEipAwbMvNJdnpJ4Xz0c1fHOFIayEuXz+CDxnNU
         5ShcmsMop1+2sZPGYbIvrZU2g3TtFoRbwQ2y3mvF1cso76qLWRMfRN8YLkKqsBK7YsFe
         gDvHU/Ih65gwlxep3aPfclxbkroRWsCYZeePJmo8XuBM8sB0zXThdIIPs/GVdKWKcM+Q
         EJX89sMGbvJusFPB7ZKOfm1p4+eLyvbpbosY/aZPK2YA11zS5V10+ltQzdzuOo4d4PId
         Tymw==
X-Gm-Message-State: AOAM532cscZZaq/2UIPiT9fQMJOIhnggOypf3u5rYQeO7VMuSLbio3v/
        ZPMw6vzolGyfB/tHFgjUGaotlStIZ2c=
X-Google-Smtp-Source: ABdhPJx+LNpstYOnaWPOhUu6gnSFdGizO9fuaNFGQ4VcCSfk/K64RzpqUn5EsATBvGnJK0ITX56aIA==
X-Received: by 2002:adf:a209:: with SMTP id p9mr16681163wra.70.1635536388587;
        Fri, 29 Oct 2021 12:39:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06341d0f9ebdf4bbe019.dip0.t-ipconnect.de. [2003:c7:8f4e:634:1d0f:9ebd:f4bb:e019])
        by smtp.gmail.com with ESMTPSA id m34sm5142710wms.25.2021.10.29.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:39:48 -0700 (PDT)
Date:   Fri, 29 Oct 2021 21:39:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 0/3] Docs: usb: Example code updates from usb-skeleton
Message-ID: <cover.1635533924.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example code updates from usb-skeleton.c

Philipp Hortmann (3):
  Docs: usb: update err() to pr_err() and replace __FILE__
  Docs: usb: update comment and code near increment usage count
  Docs: usb: update writesize, copy_from_user, usb_fill_bulk_urb,
    usb_submit_urb

 .../driver-api/usb/writing_usb_driver.rst     | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

-- 
2.25.1

