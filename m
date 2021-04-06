Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1A355135
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbhDFKu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhDFKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:50:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CDBC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:50:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u10so15950234lju.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mxjXIZD5cMpbeMxIQK6zoS+Nrxtcej01ukleZy3/104=;
        b=TvtBUrGZBuveLyuwoK28cpmMHuYCafy7qyDVB25cPH9Gvw0KcfcRo5WpUjzIVbJY4F
         Fe5cdO3RYYai4zH9V8b0jQ6L6kHsnlMCw+c4RkcYXCQ8OCCV2oHjp1eGn7CfR6+xulnD
         Hze3xgSDb1EFdgjo/uW5OL7aUNeCahZ6N5E/26ke7rugC/8OwDQ2KIcS/IsXbAqdmXAb
         +04g4rdFrpuyvpZcjQSD563IXazFwATT+/ce4LUTkKHpkGCKygJROxKJCno8R9rsbP/q
         GdkH4/1Pnj+5QjNxnI3MTJ3/99fDwgCwNWD+8UrrMYaRnj2EiLnSQouSuNnny+hDcTPD
         IgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mxjXIZD5cMpbeMxIQK6zoS+Nrxtcej01ukleZy3/104=;
        b=TKE9ThYiLspW1bzFtsj3947bvesTpP8i9Nq7YJ/F5PZMueVjr2dzjcbm2xzOVJeBDP
         RW/qND99b7xgxTHm5KYc08wcfEtXrIGuGiawoNPSpVpqd+MDk2z74KfrhIhuuS9GX/kG
         fp6tUFreuvZs1OKo9M4qxFbxKnT/QIat6lcEfYpblWLc+d1/T3YkTQLngn8PjnfJhs/f
         yCxZwRzSnjeytefIOtiUTA8v9IOp7rZiig+vMgegKJDSr946+nqRizW+GBU5Cq8MC2NY
         Spx5X91ZC3ya6tf1c+3H3JQcHVxNs6cbVN4cfwh+6fAuO8cRGm89bJFJv0McOUVm+Z5x
         I4AQ==
X-Gm-Message-State: AOAM530GtGlL6WtZtgupMI4UtJqRkjqeRO+tkWMELuuXIqfv7p56lJUg
        FJgmtLuhrff6182w4OcfO/E=
X-Google-Smtp-Source: ABdhPJwszNqJHkd6Wwj9WSqADVZBIUNJnW8kWai5GT27u9jt9CG4Q9QvyIkdfwzK8NxWrH0LuNtiHw==
X-Received: by 2002:a2e:b0d4:: with SMTP id g20mr18916639ljl.127.1617706245366;
        Tue, 06 Apr 2021 03:50:45 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id m16sm2117307lfo.17.2021.04.06.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:50:44 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:50:33 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 0/2] staging: rtl8712: rewrite comparisons and remove blank
 lines
Message-ID: <cover.1617705825.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces NULL comparisons with boolean negation and
removes extra blank lines after an open brace.

Zhansaya Bagdauletkyzy (2):
  staging: rtl8712: Rewrite NULL comparisons
  staging: rtl8712: Remove extra blank lines

 drivers/staging/rtl8712/rtl871x_io.h   |  1 -
 drivers/staging/rtl8712/rtl871x_mlme.h |  1 -
 drivers/staging/rtl8712/rtl871x_recv.h | 11 +++++------
 drivers/staging/rtl8712/sta_info.h     |  1 -
 4 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.25.1

