Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA93390BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhCLPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhCLPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:05:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA91C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:05:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso11184720pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ObJzRmXV28QegEpHbWHUYpaUj/eTnd2xztRA6RWiWY=;
        b=lQmPdvTsITc3nJAYY99MQ4a8K7uhDsWBDs1JdoKE4fSxCk1PygH+b7IP9218VqOP1r
         sOgppGDnVJB/UbEz/gqnmT86r4GRivqY4MXlUk7zYQLXd02JNBGursIXFIzL6G3tVh6m
         6yaWeK4bF0s8CBEcub7uOCLB8bSG792gRoYVyPZOA5LTFpRST1lbiBusb7dw8OehjqZS
         EHV7JBrOxJFgMSNK5dE/UisBOA7yDnMdYBYfmNI0RduP8Bs8zu3084IPrrG30rVmF4Zw
         RYvb68ofxBxjmfebv6LsV32oTUnSoAQZKT75MU6E0J0TSe8tOoS8puvLXnr2wET57iq8
         eW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ObJzRmXV28QegEpHbWHUYpaUj/eTnd2xztRA6RWiWY=;
        b=uJpu+zvFSrTGdthYpEBwomP7iQ0mG64acZRQy8lStn25Rt8V/unoQoOOGqOApBTHBZ
         ZGLaGfjcW7g+Uf2xVhH0Wk6ZHbzt2y9mA/3SH8NF3skahKy8ONDjPpiUKP3msGeea/je
         +pgT0SnP6HqJdocm8eRwHAt4CenaCa3qh0UKeKGfEuimLn1T3xIAAnonboexvu8wMtFT
         fkRYHCket9MlXOLBbmPJWeOoIQoYfnH1gFsUj871/RlTbG6nhgSgh2iwStW/oC36NZO3
         vpYnJLUo5vmX+fgakKIq3fdJY0t+xqJ6TkoAMDLJaj2gojg9swp1o58WDkV1XVFxwate
         wL9A==
X-Gm-Message-State: AOAM532qb4T9rjTcJRknJ6jafze962KVQqBNyHLcE4eyBUFTuCBq9f2B
        /GNPtlhBzIBkZYNJ5blduuo=
X-Google-Smtp-Source: ABdhPJwdNGCgm3OuUeI9FG6y6ovUh/iVmWevwCRRrIrLJCGhGPErkzX0H8fIec8l1ypjqvro9Er/9g==
X-Received: by 2002:a17:902:b206:b029:e3:f546:2f70 with SMTP id t6-20020a170902b206b02900e3f5462f70mr14071281plr.63.1615561551521;
        Fri, 12 Mar 2021 07:05:51 -0800 (PST)
Received: from ThinkCentre-M83.wg.ducheng.me ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id k5sm5923484pfg.215.2021.03.12.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:05:51 -0800 (PST)
From:   Du Cheng <ducheng2@gmail.com>
To:     h.shahbazi.git@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Du Cheng <ducheng2@gmail.com>
Subject: [PATCH] drivers: tty: vt: vt.c: fix NULL dereference crash
Date:   Fri, 12 Mar 2021 23:05:47 +0800
Message-Id: <20210312150547.5635-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210307105642.112572-1-h.shahbazi.git@gmail.com>
References: <20210307105642.112572-1-h.shahbazi.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hassan Shahbazi,

I also tested your patch locally with qemu, but it did not fix the crashing.

I sent test command to syzbot on upstream linux and am waiting for result.

Regards,
Du Cheng

