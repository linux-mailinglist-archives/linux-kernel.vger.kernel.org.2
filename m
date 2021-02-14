Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3018E31B07B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 14:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBNNRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 08:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhBNNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 08:16:59 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE3C061756
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 05:16:18 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id m2so2712676pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UOKkIESa+1l6tDO7IwKvBCYjTQ2JXj8kdAURTiXPxqk=;
        b=s2QG+peNg54RW8TjZ2ocQPwXkt+lU6accdFnZISh1sEGOZw0GIrXL54BjozEt87CEx
         6MsJ0YwKOUTh7R7BprK0jBY7hnsWf5ejM7d8jxBWPbsTELzPjBQKrH1Ka6HvMjIp/R1x
         Pzsy8ry7Zg1Kr9AjqJOwgOqB9dVrZDPq/Zgn+gfYJBC/1Ukr3BWWhrtFB+4/oSkMsdsi
         7UQEu0xfHlR2t9v0/NEVhgrEKLlAgF6znd/mWf4V8OoLdiu6omRRw9a8JF5ski2dyZd+
         2N94S4JuQCa0cVHAUQgSrkht4RaKm8FcztMT36UPTsGpjn+5+oroUMmj34JxXGhdWJQ6
         rrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UOKkIESa+1l6tDO7IwKvBCYjTQ2JXj8kdAURTiXPxqk=;
        b=YUZuWr4SrGCmVIpN0jrntN2mseZvT45smzLdTS7KfcyYAxzgN1Pag0hJRQBWnU0SsF
         KIuHKJUkFFg0b311ZhccOSW07qBE5Rx1okLocRv3f5NsLu45MvoHcGxJwM6STsdEV8vu
         DpkbQlOS3YiWaDKDC534ymHm6MvjH7lEKYujtYBTS8rclte8ybqW+bWWtTKe+6Oy4mMO
         Se2Dk4yUeYW+hd0O/um4sPSJgC+gtRlKGt6YbB3PD8ERc+L555rHBj7tUUVvHmTv32hh
         mm7fuwcqJCY4F5fitRgcw3Z0JU9GPATk80yrcUcr4MFo5/lyxmFS241OdgJNxjqgWTqp
         nTMw==
X-Gm-Message-State: AOAM531fZLQdDro7MChC4DThuPWFzcwxehXQTTcM1a+FNP7q12VCAQLQ
        XmZcrGXAfEByoVmXUOkMO8WSd92uBdjCiUZ98cX3FQ==
X-Google-Smtp-Source: ABdhPJycqFS1bHAf7kwjytC57TzvGIgE2cXkwMSE5Iqx82KXRREJgJ5+AqpF5P+tR9B9sGl8KqvNyA==
X-Received: by 2002:a62:f942:0:b029:1c0:aed6:fd57 with SMTP id g2-20020a62f9420000b02901c0aed6fd57mr11733121pfm.70.1613308577942;
        Sun, 14 Feb 2021 05:16:17 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id c4sm15224625pfj.113.2021.02.14.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 05:16:17 -0800 (PST)
From:   Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To:     sam@ravnborg.org, thierry.reding@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: drm/panel: Add inx Himax8279d MIPI-DSI LCD panel
Date:   Sun, 14 Feb 2021 21:16:12 +0800
Message-Id: <20210214131612.30491-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210208162453.7319-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20210208162453.7319-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	
I am sorry that I am the first time to upload codes, and I mean to 
upload codes to kernel branch v4.19, Do we have to upload the code 
to upstream/master?

	zhengqiao

