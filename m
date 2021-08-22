Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9514A3F3F0F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhHVLfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhHVLfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:35:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E268C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:34:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b7so21524258edu.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxxcsR6YhVp6QlvBQZDAEVDiQCmjY1fJATkGN2YtSRU=;
        b=Q5BQfaxNbeMZhwWwpTWEk94SLpXIKawtN4Ih6LJIgeMLIgVSBTZ+cFU+oG+T8gmnrG
         9DVyKDviKHmsIwQWWWEHjafFfzHpzQ3nS5c8ArcpYeiRLqxRUIkUkThjx1hjgN3fyTFA
         xZnHFkpzTDcpwGxWStX2YN9VkscyFLougOOXwYDecCL2vd45ROuYmu0CR6NSLqg+s2kj
         BKADV7g70uoqOmoJmBzRWrzC3TSaOrMfXrbo1q/9NVHyWhEe2j4+vKnigPBoutMGHWu+
         Wmy9G/kWZS3UNSir8sVf6DF9WythirjiCYHJCWpJgY0fp4kgS1x8LlRdeeahtoWOVaCG
         gHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxxcsR6YhVp6QlvBQZDAEVDiQCmjY1fJATkGN2YtSRU=;
        b=Nj8VS0jJByB1mwpdmqD9S3psE9VRP1VtNrAIAFjh3R0qdBGgNVId1pQHg2JPVv8muM
         whQPE6PqltbZpYfztOq4TvKu5Rp1OhWMXv6g/dRwAXFwX6WxmiDZf1TJdFY4X96hT1hq
         VoauXYeo7+i4HU/ySYKUEPPoXcgt2Ki1KMYtx/BT83rzOtFujROVIv7lHP9cgnRIaPem
         6F3FrZQ5ueVV+19qilQoFd9gfvc37VxdTKhu83Ubd63IaWrzLIU2/IMCplJAT+nnRaj7
         mJCfkOf7l9N6VTnv84F2fh0VwhBz+pf1uM4+nfQ4AxK3O8xKQxiDxHLjjJgR72YlTHG0
         e8lQ==
X-Gm-Message-State: AOAM531iWstxQhG1+KpX74FLkY3Cn7UgkI7u0sLTcSHMZmAmW9ZPUWGO
        CqrnQhjNireQc/ViROlabW0=
X-Google-Smtp-Source: ABdhPJxsEZoUm121eYl7UGNCHdaeM7+k5bfj+wPTD839Uk7e/ChP9qKyKHE+r/h13DJvtNe7YhTZIA==
X-Received: by 2002:a05:6402:358d:: with SMTP id y13mr31992547edc.300.1629632074631;
        Sun, 22 Aug 2021 04:34:34 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id g10sm5610915ejj.44.2021.08.22.04.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 04:34:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
Date:   Sun, 22 Aug 2021 13:34:32 +0200
Message-ID: <3651682.Tin1GtIqIz@localhost.localdomain>
In-Reply-To: <2327383.5TodInGmHT@localhost.localdomain>
References: <cover.1629479152.git.paskripkin@gmail.com> <ae27d6a0-dc00-459f-7b36-acf7f4c08d72@gmail.com> <2327383.5TodInGmHT@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 12:59:13 PM CEST Fabio M. De Francesco wrote:

> It's up to the callers of _rtw_usb*() to check return values and then act
> accordingly.

Typo.

Replace "_rtw_usb*()" with "_rtw_read*()".

My fault. Sorry :(

Fabio


