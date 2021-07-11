Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD003C3D72
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhGKOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhGKOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:53:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9010C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 07:51:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso10539294pjz.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vpgaPPFyrg9nlDBUNWdH0dfzxJn7NXxIxEVudtT+sg=;
        b=aB+cdnh1bFq39V7aUK8l3DRBos92jtsdOczZOk1m/pH90O4rjC95MhxfWIxSKOGrl7
         tV/rRqAWXCG4eYPMssKCCLQ5O+Im2eqbGot1ttIoo3bDcS24w0kua4MzbHO9HlnKG65P
         3IlcAMwhqsCCXlY9MrZl+m2r5UyOtOjUP2uVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vpgaPPFyrg9nlDBUNWdH0dfzxJn7NXxIxEVudtT+sg=;
        b=pScF6aQ3NTUDhymDkGiRfg0FLi7I30qJeT7BUsOL9bI4UUIqdzSh/XmtIS4l93w9fa
         3aMWFbW62dgzCAhoaasBdqfXuuqAOcz9KRqS2CPwTF2VB+wZq+R4ERo3L2/wSvbkwbFE
         dzlzX0s7AYVOjrDRiU/Nh6afTCz/G59LXpJtV9AqtFQGiQGxfQn+hyuJrH8g08O0O70g
         4kpz2W52aNrmYFrCz1Nn4OR98tQLwP81cu3LR8myyiLPrf0yzpalXOos8By81nRQB5qQ
         1BLyP8YZPrT6BWxSM8/6ibd5Zd0XL5J2Em3XwcrebFJEyyIslev3hITZLrWWHbCqsj+e
         +pQw==
X-Gm-Message-State: AOAM5320UBWG4ayJZqwju353msKyeZO3PbeyVIUSVb7HDW0T3QP/hNgC
        1TMtjCQj6/1At1ORLK9+oiiq6w==
X-Google-Smtp-Source: ABdhPJzLLi5PPahoH/aqG1DhTVyY9bDlpg0jHiTx0WpgyLjBZIgabPuuySFimf/VDdou/O30SWyzTw==
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr3536213pjo.97.1626015065445;
        Sun, 11 Jul 2021 07:51:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w16sm9990929pgi.41.2021.07.11.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 07:51:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] media: atomisp: Perform a single memset() for union
Date:   Sun, 11 Jul 2021 07:51:01 -0700
Message-Id: <20210711145101.1434065-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; h=from:subject; bh=ZYOr/7quVv3PTWRowMkP6bGJ9jsJBYx1pOuir518dfs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg6wVUe9y/ux8ndFvNwvWGdgeEiOYMeKHWK2ih9JpS iRa93cCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYOsFVAAKCRCJcvTf3G3AJsaVD/ 9jndF94KICIw6tf5JvSWups/Rnaxy5DkmX8sBcE34k8cqZ6+8trMGvH5ujG4KUIW7ZY3vbZYc5GEmq aW+w12zDZH0uq86YNoVNWQfTskt4XelszEM6kjo/iCwiBW0CwAk1dssNJW4z3WOT070f9h5XWef1pi +cEtgAH8ciYGPbh4jIqIEUXvem6VJGhLILf4n9oRNt2SV9YgLEDpPOfNDAgRuulDePw70Ug06GejKH onSsk9ZshQb+5MvqzzXPPiYLuRsSd5WdTclIRwKQxrLuCHQ1N/LGZNtCa2O+YmD0EjzzXqlXsGQR9D jv+M/6EaqvvIfGGZj7wySLt1k81mWTPcCxW+cDDbrvUEpqD39d7TYC/U9kdM7rhrfk0IYUHZuraghG Hln2AXd/lTuYMz3CXxH3q0sdKQQIS8O85ZUlpSysb6seZzEFbuGIj70mLg86KmpyrriaPKTLdvTKiV WJX3r4Bz19XEF57RvjVz5wJoC51fijGxnn83KjwiG5VrNBxWiw+hImacjw+z0/ZWLRezFB/S8mrero dMgF7Jwhg8vyvvE/hi4zNiZea6tW0N5esydPDtnWsR47S8Zdj8C5P5eWfOwp7Ty1yR86F7mfLj9Ypi T+OtHvNH5YRCKdcj4BNbNyVXykfp3Oka9/O38uI21GQtoFi93ah2VFrKgmlQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to memset() both dvs_grid_info and dvs_stat_grid_info
separately: they are part of the same union. Instead, just zero the
union itself. This additionally avoids a false positive (due to a
gcc optimization bug[1]) when building with the coming FORTIFY_SOURCE
improvements:

In function 'fortify_memset_chk',
    inlined from 'sh_css_pipe_get_grid_info' at drivers/staging/media/atomisp/pci/sh_css.c:5186:3,
    inlined from 'ia_css_stream_create' at drivers/staging/media/atomisp/pci/sh_css.c:9442:10:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field();
      |    ^~~~~~~~~~~~~~~~~~~~~~~~

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101419

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index d26b1301eeb7..ffa7f8a88a70 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -5181,10 +5181,7 @@ sh_css_pipe_get_grid_info(struct ia_css_pipe *pipe,
 		ia_css_binary_dvs_grid_info(binary, info, pipe);
 		ia_css_binary_dvs_stat_grid_info(binary, info, pipe);
 	} else {
-		memset(&info->dvs_grid.dvs_grid_info, 0,
-		       sizeof(info->dvs_grid.dvs_grid_info));
-		memset(&info->dvs_grid.dvs_stat_grid_info, 0,
-		       sizeof(info->dvs_grid.dvs_stat_grid_info));
+		memset(&info->dvs_grid, 0, sizeof(info->dvs_grid));
 	}
 
 	if (binary) {
-- 
2.30.2

