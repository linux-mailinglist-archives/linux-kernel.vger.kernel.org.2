Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7183FF54F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346558AbhIBVGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346194AbhIBVGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:06:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D39C061575;
        Thu,  2 Sep 2021 14:05:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so2429598pjx.5;
        Thu, 02 Sep 2021 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=767k+M+A1x1kdLgaTK6PFpHMV5G+KT+3ZYp7Me4sE7k=;
        b=YeiveY6OMoQOw5bqx+p0dWtjCKYLw7LQtKWci6h23HoSteAtCl7pazRwHZqk7ME11e
         TZSLfkY/xrjTCbp2Z9F5zXZz4eAO+WgzPNTfhlzadeGZnB2c+CdQrj9Oq1/Q0cxkeEpg
         cSEApySmy1cMX4QywLCne8OU5tZ7X6CuMxpA2Q2RM9QwIM9dz80X41xuE2wSaVgStZ5+
         W5gQgYHzyB330+E/sl8T31m0/UfRVRMnuy6f6Pcd+c1mf76/RRv001seefr2JzViEe6Y
         E622ERkg91unMGPYs9vlJstQgyKzYIy75y0wk9dMP40Re+SzqBSoCcGQGZLZvtTDBlx5
         jqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=767k+M+A1x1kdLgaTK6PFpHMV5G+KT+3ZYp7Me4sE7k=;
        b=k15y2xYbpSrj/PA9qLNIGhK3NccL9gyZ/OqL27FhvJzDG+xODrZsSZjQAQcCUlB34l
         6gNtE1/v5MSKUrobJtL7FdlVrtOrqvuRj9yHeZa32732oVs+ydXxu00Yghjq2Cdrxpxg
         Tl1hSi4+HKZ+Gdy9w0XQNQeeXBtIHL9TkodqWblAFp3J8np6Bw2bqE2gMtzRfngpic0M
         Y303p19K40UC0HL1W55g6/I7aMKR9/+pWaJOiRPryXehjXg3F4yozkIQ7JB+iDhkR15y
         qGztC2lns3kJDq+udCP6IWW/WaDpGTXYIMHBE1DkjQAnl5rV80nN3X7l9WOzTcxZYLMW
         +Ceg==
X-Gm-Message-State: AOAM532+PKT/IH/tMA7Gat4/atMxnAQ0xw7WBF66D0c35/nSi6gcXCj4
        yWLXFbUK27E3jMFvbWBlvYw=
X-Google-Smtp-Source: ABdhPJx0Rkelt6jZUhu5xShedfI10iXFBVHznlXL5sRuIB8ieluqJS2B7UgKLdAT92iF+/6bW/GX1w==
X-Received: by 2002:a17:90a:31b:: with SMTP id 27mr6187850pje.6.1630616749452;
        Thu, 02 Sep 2021 14:05:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f24sm3131284pjh.15.2021.09.02.14.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:05:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] ARM: dts: NSP: Fix MX64/MX65 eeprom node name
Date:   Thu,  2 Sep 2021 14:05:47 -0700
Message-Id: <20210902210547.3103078-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829223752.2748091-4-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com> <20210829223752.2748091-4-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 22:37:50 +0000, Matthew Hagan <mnhagan88@gmail.com> wrote:
> Running dtbs_check yields the following message when checking the
> MX64/MX65 devicetree:
> at24@50: $nodename:0: 'at24@50' does not match '^eeprom@[0-9a-f]{1,2}$'
> 
> This patch fixes the issue by renaming the at24 node appropriately.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
