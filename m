Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9175C35AA40
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhDJCM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:12:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88074C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 19:12:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t23so3758820pjy.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hbVf4wVfNxnKZxFZJSlPx/JJraXw3lheZgCYNdZrqqk=;
        b=lOYTBpnhtHMJ+6GMN0ThIPlxCD/e4HCWnsMR4Dcd1BxZ0UNCjmAZu4EUCDAVPOfcI0
         0QV8/GiuXZ+nGbLOxRUptkSwDmwb3iKzNuS15pDZtp8HKIJNGsGt5E3kibZtMDMtEu0P
         5s713UzUcpIN7JYQnm+eOHdv6EzeACJBi7I1ET0YeKkfn1oP4wPOQBU/oLc8udgC8aSQ
         u0d9LIv/jJeh57b897fxDpm22+CNFUMv02TuKYayNqqgY/7IrxYHFxKduijD5V7YAnOE
         e47ImFrcn2JUfsld0N7m0B4CuT9FvX2J3qsw7D1IJrJA4RyTrlr2kTmZPfXByK41iRi3
         GEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hbVf4wVfNxnKZxFZJSlPx/JJraXw3lheZgCYNdZrqqk=;
        b=uT35wa4Gg859StUTcnUa++b12gmiueVApbMMXA0DD07fzA3gKSqPkaWtqZFowFwvt9
         /mtP2+EWuX20roZDwkloV9ZzIrOc92QSumhctKSqpO5NvxBe+Xm6O67GMgcFifQhAhmZ
         zHpi3MxDe0nufTniztw0LbWqKc/eB3XZqEfVR1aroOaunOPwaBxCjzIJRncaZscs66Q4
         60+Ntlf/rFWfN7QegVfYiL6aRyNckG2il94AMGy4kxW9m6XeFhcT2hletNwVY0Kf4B7n
         wZkUemdNZhaCfEA57/VVyQM+ve1VRVWWks6eRsXtZc7qP8rzqI8ZyfqFqvEH2TFIuXto
         uxUw==
X-Gm-Message-State: AOAM530kwbnMMbaUEQAuviwdduyx+tVrxOWOJIeGdGEy9dooqdLA2pGu
        xaUt0wGYWnOSDOyBBchI7v0=
X-Google-Smtp-Source: ABdhPJwJB6ivjOBcNbWw7+jzcWHtaUcg6VB2TwA5G+81NUFgSFyq4cP5dU6bxiBGchpYzVGKjfW+tA==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr16336354pjq.94.1618020761057;
        Fri, 09 Apr 2021 19:12:41 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id x13sm3523524pgf.13.2021.04.09.19.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:12:40 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:42:34 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 0/3] staging: rtl8192e: cleanup patchset for style issues
Message-ID: <YHEJkknTdEwID9X+@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix the cleanup style issues identified by checkpatch

Mitali Borkar (3):
  staging: rtl8192e: replace comparison to NULL by boolean expression
  staging: rtl8192e: remove unnecessary ftrace-like logging
  staging: rtl8192e: remove unncessary parentheses

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 26 ++++++++++-------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
2.30.2

