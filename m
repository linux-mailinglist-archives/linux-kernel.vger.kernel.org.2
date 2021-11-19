Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5D457251
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhKSQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbhKSQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:06:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99DC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:03:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z6so7267135plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVl1y7dz5yzJ4ISPiOpYJmuusOkr3uxzfmH+anrgaX0=;
        b=lNLzz5grJcL0EywAhMja05SHW9eUygNXTKtZgQTXHqcNE3IcqDLr7U1Bc/rHf3k6Nk
         1mQ3kHTclvYs0jl3aSAbbDLNi6nu0sJX30vXpGyuO4zUJ+QE32QxlqFT6XWNep4MMz3W
         hX7TiTqGvoo24R7EPvxePcX71JCNKLq9DLI+G+pE7y7GACDF3kPbqfPgGeg6PTMk0Tl3
         r922k7X3j6boaoG3JHogizBD7db0bKuztYPCXmqGV3N77n8dkB14ZEuRVo6VSQzcsJfe
         uTbYjndK+PCGFaSP9fsT3WWSO1WEW/jkbuT4OaKIqs0DZCSIQLiOI7G/82vvUiNhqBiq
         IpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVl1y7dz5yzJ4ISPiOpYJmuusOkr3uxzfmH+anrgaX0=;
        b=Z4T1IjG9+TNmyK7T3L3EMe6sTIPcy+p+kP5D/L38Bqei+uTWHYXYL8pRqS5vb7wZgi
         BmkqQz4+7d1oGzxCD+Iu7vGTwz1JKUCJDb2F2/4cheSGYdzMGzQP1Nv5hVsexAI4RbeB
         b10Biv6zdIQp/ZUFDezyo2YnSO7tPUJ38siqldOi0IaWMv3b54WPqadbmI/PjIVljPMf
         26cwm6/00PMXXDiOdNwYIHhZn9vrEEjkfpP2WdaGMwvRDjL87rHVVxttUulla8S0+Jbu
         YmDJ6D71ZdeqeOhu9vpIAk0/k3wmDlfyXtUl/qq0OWWMIe35zpwgD6rHL4Z8G8cLPe2x
         611w==
X-Gm-Message-State: AOAM530WrIN3mDofcWzj3rLrMHodsOVCgkO8sixZ5Oy5XZyt9GsxOD7m
        uFeX3t/7xSe8RPR3cpxTQVyEDQ==
X-Google-Smtp-Source: ABdhPJy0I7OeJBwYUukJb+gm4HMPcsPZFQFz2Io92uNtCvJbhNfZYOtwBBIchHRWXe+X3HstC7hC4A==
X-Received: by 2002:a17:90b:3a83:: with SMTP id om3mr778565pjb.211.1637337831717;
        Fri, 19 Nov 2021 08:03:51 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id o4sm11067326pjq.23.2021.11.19.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:03:50 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [PATCH 6/6] coredump: Limit coredumps to a single thread group
Date:   Fri, 19 Nov 2021 08:03:48 -0800
Message-Id: <20211119160348.22409-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <87y27mvnke.fsf@disp2133>
References: <87y27mvnke.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Solve this by making a userspace visible change to only kill a single
> process/thread group. [...] With LinuxThreads long gone I don't
> expect anyone to have a notice this behavior change in practice.

FWIW rr's test suite does have an explicit test that we correctly record and 
replay the old behavior. We don't actually care what that behavior is though,
so we will update our tests.

- Kyle
