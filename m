Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1543804E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 00:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhJVWky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 18:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhJVWkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 18:40:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B933C061767
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q187so4580036pgq.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=miKkaKnwxzgg3C6dd9L/QtguzarKkK6TwUO49C5QKBM=;
        b=MHAC8+hDOOMAbyKiG68EXm85QnV0usZrjzMIwf8guh2QGC/e7fEnbO8B2JQKoeffv/
         D32ML33Y40rx5OGsSD9ufeKUsP2eDnBoxKtTeePvaC6YNuG9FPG4od0dtZgd7ZazLZij
         RTJscCRIctw2shL7okfYllllc2jP0QoZvUG98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=miKkaKnwxzgg3C6dd9L/QtguzarKkK6TwUO49C5QKBM=;
        b=yHRNK2wGOJyWmJXO+GHXdVb93z1oZAU/IF7RjqhBaIGObxldW3Rfz1eJcUl1hlCsIm
         2QCQvDV4tbOC8Lv5vB+9tfhQhsxtghq51z+jRKKABxHmkDegcyXrulOxC69rRxqsccHc
         JdoPH5OoDM8E2M671wwTfN/BTi9V8OnUbfVwXJ7c/ZbXBXnIk/SNVUWtqYgan+uk2cbw
         +mowSlNK83e58rWk1eIA6stPUuIMgmKFbQodrR8Fy1O3O/zyRyWO1ba5JLloS3F/nfNZ
         lDbMeA/8rD0O9QPFt6Y2XLxgSPgxjlc9tCa5xc3fACZykeOZE0sOwXNkA4yBN5UkTcQf
         9HtQ==
X-Gm-Message-State: AOAM533VUStMIkmJ7OcGr8FQCzuURUzVrXe61cB5HAfy+h80lAOg0xRt
        lxMwyhSGCqITbNY57szVV0OCbg==
X-Google-Smtp-Source: ABdhPJwRoongdv60Cafn06aP22vTK0PKsbo6MjG1PJQTEyuusnnfdlt7yWhuBCbM/1UtWweIqkP7yg==
X-Received: by 2002:a63:740e:: with SMTP id p14mr1896649pgc.329.1634942314934;
        Fri, 22 Oct 2021 15:38:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ip10sm10555664pjb.40.2021.10.22.15.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:38:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] lkdtm/bugs: Check that a per-task stack canary exists
Date:   Fri, 22 Oct 2021 15:38:24 -0700
Message-Id: <20211022223826.330653-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; h=from:subject; bh=AmtTDFE416bOnzEP4shIh6R7CaOVhj0S565/1wjTphY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhcz1hzWEbn4jVDkstel7Z8g0GFX+J1a2ZvpD5wjEX xqHBLOqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYXM9YQAKCRCJcvTf3G3AJlfJD/ 9SnIHLhM4ffgxebcLffDtztM1BzHoph5vLlpGalPedFmaOulLliESziV1vjSJvjpirSG8Bqn71vqLX 7KZpK/sMl1C8P3YOuu39Xs3Nt0YqjCvZFqximihZ/8GyOaAhjvazbyuY9k35a6hC6ZtK72eItSq+/0 oiQzg3uFNWVpWNKoJwzF1JmdiSlNe+uRS8nlbCyexqBdHqyDdu7e6XJTQ+H3uYIh3Mbmd04iqCYrdP Hwx7q6OWNSC2ChrK7cFcWkhEOEtqcG1kzGN7kNVglSeBnVJJwDy6lySK2zXENDgnETMozXcCD03rId IrXxRnW5cCkyAdUHURYj9Vl2qjNkZY2jznik0ulXhGW3Tdm7zsa9IEXCZlREQ9duR975U8ivysG7rJ OlAXK7fDMrRxC4XN9vfpqhMtmUnoCMF8xkHqzaox2cCqbBTEViE0nKpBh9B3anApPns4nsSHQoYykw W3dAxNiiMmq/LLPDn8vwi+Wr42V7MXUwl4elNiSgac8UZIorXSFwrlbHQD0OSHuYBqO6xjmjGE6dwa S8FZmOY/XojkB7I+1dp+7WyfDeLPg9mHZSMkjKXmTEQkF8SRsLYm7n3veUe01xrrKxwWTtW8dRf3QU IkWLbW6rbEt/87lvH8ic4g521/aDa8oAZ48MycKUIYeN+fUrCJyNhdimUdDw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds a test for per-task stack canaries to help verify the latest
work in this area for arm[1]. Most architectures already support this
under GCC, though there are some that are still lagging[2].

-Kees

[1] https://lore.kernel.org/r/20211021142516.1843042-1-ardb@kernel.org
[2] https://github.com/KSPP/linux/issues/29

Kees Cook (2):
  selftests/lkdtm: Add way to repeat a test
  lkdtm/bugs: Check that a per-task stack canary exists

 drivers/misc/lkdtm/bugs.c               | 77 +++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c               |  1 +
 drivers/misc/lkdtm/lkdtm.h              |  1 +
 tools/testing/selftests/lkdtm/config    |  1 +
 tools/testing/selftests/lkdtm/run.sh    | 10 +++-
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 6 files changed, 90 insertions(+), 1 deletion(-)

-- 
2.30.2

