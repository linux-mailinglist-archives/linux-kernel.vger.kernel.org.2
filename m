Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE23576C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhDGV04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhDGV0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:26:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FAC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:26:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i9so138965qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YmJWVZVCE0nBAIyztMwblyzhG8DMCv0lWyvf1G3l0f8=;
        b=tXbIacZhePHp5cOIGIkAz0vDSH59OEMujhAtK+p39NvO0tijLukHQfj07YbwuWf7wW
         Ba3ofjdrbYEsgWq4jeHj8gC6ao7Sh0/Zig+K9/5C7WVqJFE3GjYRFU0PpFqaAYo+y+pV
         F1hIb6wvBc69dwwxk83PhR8cawOjUtz4mCxue4SgAypbQtWH8Ivoa9i2iDs703Ir6UoL
         Gdyf+YNwRMJNRaZdBRoU1j9HfnxYYes0vgw5KGETJPFHas+VOdjCEo9BezhqSmlLtk4L
         x036LpCazyXua/pk5SciE1KBJwE5Fq9wrhUivzerAnUNXBUMgYfz/smDZcG6Sbb6Iet7
         5g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YmJWVZVCE0nBAIyztMwblyzhG8DMCv0lWyvf1G3l0f8=;
        b=P9yZjr/craR93VsSIH0v3FXti5QwuUFmrIh4j6U7PljJqspsCGRD6isIgjjbb3oAJ3
         +FoaM+6QLdnwwMvNvvSkBhhjyYxJyzURFpqpj7enqRNAyCUiAt9R0kXNdZ+R3NccHFjs
         TX7OAcFYT4r2lqGowLlnQGEn3I20oEcHJCL1GL1eXnFLUfALCvpKtTjQkqoN++kT38xA
         J1ytPAuTKK2UjSbG+bb5ID2/sL8fMFkuiFC47r/tufQ0ND36ImC9Hta3bzi6y/AeB5up
         /eMiKMT5y58oxyUe4/SzvoZ0g3jhfEjJIq+ODMVUkB3Dx1PVLkmXVmCluV2TgC7l9S/f
         vMVg==
X-Gm-Message-State: AOAM530sIMn7GpP/Qh918OTrE6eqy9qtf6U8N6EJxCViPhU57yGLFm6w
        87QjBmxy5ryomamNdCQHgv3E/+lnWSDQp9Q2
X-Google-Smtp-Source: ABdhPJyTOs5yeM5Gs/3O78S66x+F9OUD3cSYHCOFubhe/hcOv/0Vw50Ul4NBt9XWhiqUd/DiLT9t2A==
X-Received: by 2002:a37:acd:: with SMTP id 196mr5474432qkk.219.1617830802641;
        Wed, 07 Apr 2021 14:26:42 -0700 (PDT)
Received: from focaruja ([2001:1284:f013:b099:91d8:678f:6a0a:466d])
        by smtp.gmail.com with ESMTPSA id b1sm19858992qkk.117.2021.04.07.14.26.41
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 07 Apr 2021 14:26:42 -0700 (PDT)
Date:   Wed, 7 Apr 2021 18:26:40 -0300
From:   Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, alinesantanacordeiro@gmail.com
Subject: [Outreachy kernel][PATCH 0/2] staging: media: hantro: Align line
 break to the open parenthesis
Message-ID: <cover.1617829497.git.alinesantanacordeiro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligns line break with the remaining function arguments
to the open parenthesis. Issue found by checkpatch.

Aline Santana Cordeiro (2):
  [PATCH 1/2] staging: media: hantro: Align line break to the open parenthesis
  [PATCH 2/2] staging: media: hantro: Align line break to the open parenthesis

 drivers/staging/media/hantro/hantro_hw.h    | 2 +-
 drivers/staging/media/hantro/hantro_mpeg2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

