Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC97E36CB36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhD0Sit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238967AbhD0Siq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619548683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4VuZQSuryR31hzWJ615ODRd3rogZxavth8Va+pMZREE=;
        b=CrXbsrD8Ib3Xk4tIgE/aadxM693Do+ut9HblJF5kxnCdVGQUVJ9R/+q0GQU0Y3bXiwmpi1
        qfmDx2HkZLVb/tcfwrlnZkCvomtskiLvVpTAJLUJqZUhDfuSaMlLWB4a4jlp6hqDo5GHHw
        LNez5njxehAu+ph5WcxGHMzYIbhVPuU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-QFLIg_w7OGu7a8a61HVyEw-1; Tue, 27 Apr 2021 14:38:00 -0400
X-MC-Unique: QFLIg_w7OGu7a8a61HVyEw-1
Received: by mail-qt1-f200.google.com with SMTP id u16-20020ac86f700000b02901baa6e2dbfcso5001341qtv.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VuZQSuryR31hzWJ615ODRd3rogZxavth8Va+pMZREE=;
        b=aGJmHaNw7HGa6pRr/eZjci1gVpXuoTZMpVhDdXorl7lb//9XRKEQFn/XocX1Mnrsr9
         R37VzXr+j1zN3YjUV0D4R/FTVdH3DXHGpt2S4W5Q3CAHXf1Wy9UgCrgqivbKCUEXLlMK
         Pl5M5slEERiHxfmPcchctbHFBrXFHuOl5q1Jwgh+Rj1fikNJ8W9kw8OZxYns8ZUKpctd
         qPZyOTJ2itA/hRPl40gWaSxKdPAVoc0QtdoSgGATGxbuVZ6nxT/+4UsganxznBz/6cxu
         f1ZhmBnM+ajrFad8AdELvLLCVND+sVeaMDLbVj2BLUs9HosUsQR81UMZVfgYUP36boC8
         vEDg==
X-Gm-Message-State: AOAM533vsFY+eKoHN8aQswalauptaXEnOCnOtieFKThex1Iq8DALT0df
        Fs2C7qC4+lq5ZEaORkIK/s6/Jw1KHK76lyOVsfU50Kh7lZQIg595R2C0OT3OPPb9UZr1DldpZo4
        Nx3c9ExnP2UDWRm+RIrfdBrKs
X-Received: by 2002:a05:620a:14ba:: with SMTP id x26mr23398297qkj.457.1619548679881;
        Tue, 27 Apr 2021 11:37:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHmo+tFoQV0mUdGbTaCoTFEnkBuus13gSDjgfQyCZ3EXJ0VwKiP/wenE08m3y4BKI265nlZA==
X-Received: by 2002:a05:620a:14ba:: with SMTP id x26mr23398278qkj.457.1619548679727;
        Tue, 27 Apr 2021 11:37:59 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm478118qtl.37.2021.04.27.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 11:37:59 -0700 (PDT)
From:   trix@redhat.com
To:     mic@digikod.net, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] samples/landlock: fix path_list memory leak
Date:   Tue, 27 Apr 2021 11:37:55 -0700
Message-Id: <20210427183755.2790654-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

sandboxer.c:134:8: warning: Potential leak of memory
  pointed to by 'path_list'
        ret = 0;
              ^
path_list is allocated in parse_path() but never freed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 samples/landlock/sandboxer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 7a15910d2171..4629d011ed61 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -134,6 +134,8 @@ static int populate_ruleset(
 	ret = 0;
 
 out_free_name:
+	if (path_list)
+		free(path_list);
 	free(env_path_name);
 	return ret;
 }
-- 
2.26.3

