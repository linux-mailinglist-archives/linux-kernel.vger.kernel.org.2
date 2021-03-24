Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF52D3471EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhCXGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhCXGyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:54:33 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97458C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:54:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m7so16829111qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4R/MGKyN4C47IKNV5TQKdwyHLk8O1Lq8WRqX8AYrH4=;
        b=lfyIEa2OhXSN5XPjKhJ2Nr6udYswvPAqWOuA+4u7n4Rm/uKnxaj8LAZjTu17ncNuwc
         789Exa8onpDlbxIBJ6JxNgvs9Cw2GRrum2JcyW0tY5vPrYwOhazpPL7p08NIx+EONF/E
         LymnT4k9WucJWvWg1McADIekt+9jlNumVoJq4ZDj06E34ZhxLjnayFEYLljZUHtvJ3rm
         hCv4bIsxbICJYC0Jx14kgzRc8jUGTa4ZELUj15gmUGpKeSD8BSijpBQarNA1RJ7KJbgr
         6I15ejsNaER/stVBf6JBTLNl6JLLw+pXvBpleTOo/MwpCcTkxOv21fs4C5HmbFYtYtiW
         H3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4R/MGKyN4C47IKNV5TQKdwyHLk8O1Lq8WRqX8AYrH4=;
        b=NhQXAhsgMbdYx3dc0P1MChs7MceYQgsjgGtkeJWQDSD3oeUolF5Ty869aqvCw3NqsG
         nhxrik8hr1MbWSlfIq6rVxi0f7JjqyBvxiCyczyS0ZfopBo9JpatXk+9yacXOZs/kfE3
         p10At/kBnqmDTwKwev0jUeQ93nBpB/CNW/q9w7HmlZKJyPF5Tzb7uc4AMuJYbYtKW6fq
         OVvgbIVIZlzU/zWVj1mwQ4bRZnyLJ77rXnfa5lNZuMl0C4n2SuuQkP5rvdGdGpyJkICm
         bMbq/9c1OKd5cR56hm+IwZCo6y2odhRbpPMv7IGHuZPhm1D/E5e8h8VdAO6VtXvUPfhG
         XXLQ==
X-Gm-Message-State: AOAM532DXjCwr/a0aOljNynPXxkIyWeaGnVtDVO0MqXttp65JLaQQwU3
        c+PsXE+X2YvZb3rVhqkdBKc=
X-Google-Smtp-Source: ABdhPJwN4YKz4zEJj/rZmEbgmjNbOJ19KhK30xYDe7erSOUVmllCe+LX9/n7UImLHVXAhGm+P5LaKQ==
X-Received: by 2002:ac8:4e51:: with SMTP id e17mr1735507qtw.204.1616568871952;
        Tue, 23 Mar 2021 23:54:31 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.37.194])
        by smtp.gmail.com with ESMTPSA id n6sm846413qtx.22.2021.03.23.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 23:54:31 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mirq-linux@rere.qmqm.pl, unixbhaskar@gmail.com, lars@metafoo.de,
        joe@perches.com, huawei@kernel.org, viro@zeniv.linux.org.uk,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ALSA: pcm: A typo fix
Date:   Wed, 24 Mar 2021 12:26:12 +0530
Message-Id: <20210324065612.31362-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/unconditonally/unconditionally/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/core/pcm_native.c | 80 ++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 17a85f4815d5..9884961bca7d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c

-	return 0; /* unconditonally stop all substreams */
+	return 0; /* unconditionally stop all substreams */
 }

--
2.30.1

