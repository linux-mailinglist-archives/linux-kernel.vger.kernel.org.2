Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56AA309CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhAaOWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhAaNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:37:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6DBC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b2so19067810lfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqflsBkgFW1GG3B+tPVEsejdgHlD7KUnEEoS+UUye8w=;
        b=RsYhwga1+R2+qrtaF7h+9gFT0hxPD2dgV+lMbO7OHlR9e9i7hb/3AiKBhbAiZqDr5G
         jizO5jQAuVpCrlmxfli1rLcwx5ZCtWPOfK1eDBxbU8AOc0mq+y7c2u48bpd8RrXC784r
         SSsPivB5tKYbK5QAC3zOPChV7UpZ95vDjOBxIhVrjfmc6Yfp7ThE0r2z7rH3xbWElZ01
         N7HQqMCMXlyCuP/UYDh/irlAFMMXIZNSG0/ix7RNcY0OJtlIOV0ob0+xjPrFAtBzUiEn
         Qa89dWxptZYHiPlN57X7iVwiKs18IH1DrcV8DiCufcF9vD9b81ZUbZoxKzbAMJAiGc01
         ud2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqflsBkgFW1GG3B+tPVEsejdgHlD7KUnEEoS+UUye8w=;
        b=FAuIjFNbzKrfS9aWrOd4GAba3O6bNewIp8bDId1ivaUHkthlLyIJLZO4y+FAlxU7l4
         UhCzpg57c8QaCTmBFI0EpZ/QBJEGJbWdAUqRCGrkmi1i5ABVtbQ1aBUuPGCwf08wJwVE
         +YuRDtd/5ZOLsjrjG0G/9DUP0qxb6CvHGkXxwNm/3KFvGjqe9PBVWxktY3GPYyrbi4Jh
         ykU5u8vCwr4wlt7UmcI0ucPSHKXrOvxWndkit7j9LafMGVHfACqbBDWRlkMOTLnJzPvL
         f9mzXwj+pkDxbpVrAeCMaMXjPumXyiOYrMg/hQ/PZwgJU6xmhWcljd/cjSJq72wOBZ2B
         cJmA==
X-Gm-Message-State: AOAM533AfiOwBwM7LMfYQnd7CWtF6sRdSvuonpkvBAgZvF09w/1rEBjF
        ZutF0x/16u8GH2/vi2w7EdgD3/sebTo=
X-Google-Smtp-Source: ABdhPJzxhfSiWSdkbUFwCxKEwn3V5u4KaoY+Zl2ThVgi4ix2MdPhv6193UU/cHXwEBTLwtL8C6M/4g==
X-Received: by 2002:a19:ac08:: with SMTP id g8mr6168236lfc.48.1612100214536;
        Sun, 31 Jan 2021 05:36:54 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id m8sm3391216ljb.32.2021.01.31.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 05:36:53 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] drivers/mfd: Constify static attribute_group structs
Date:   Sun, 31 Jan 2021 14:36:41 +0100
Message-Id: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of the structs is to pass their address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make them const to allow the compiler
to put them in read-only memory.

Done with the help of coccinelle.

With these patches applied, all static attribute_group structs in
drivers/mfd are const.

Rikard Falkeborn (3):
  mfd: gateworks-gsc: Constify static struct attribute_group
  mfd: lm3533: Constify static struct attribute_group
  mfd: pcf50633: Constify static struct attribute_group

 drivers/mfd/gateworks-gsc.c | 2 +-
 drivers/mfd/lm3533-core.c   | 2 +-
 drivers/mfd/pcf50633-core.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.30.0

