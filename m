Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE544BABA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhKJD4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJDz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:55:57 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179AC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:53:10 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r28so1059926pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 19:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=DJvmLdmo/QsjbigPPBxHtWgwGgMJBOxr0MFUDSCxEX8=;
        b=76ZMudVLjJQBaj19L1P/pZwr0kHtbO+nd8GiaTZsJvDfxmykLf2hJJ5pMbYfgZqjFU
         rhraDTeV0ZW4mR9axV0QHk7QgsmkQ2p8O0nFw2FOj18Ae0OctN9mrn32Yuf9pkH6xh7s
         AHoW6zGesQ7RZ6WgKHkqzNaJ/EKs8X/2MFhDCWwXQ/DQk6tE0gsA8JwoJutUdMRdWRK0
         IGMugJBRURdHmkPdq4uCdU4aiktzklCi05s4eHWP/3zF4zIcQN25bmhkCMRVtOoVf8DR
         EidSKgUxmx4pw3+5GUVzAbMh6o8au0PkU0hsQXoshIgLAY3Hz2ZnhvWYhTSoCmLFS5mG
         cCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=DJvmLdmo/QsjbigPPBxHtWgwGgMJBOxr0MFUDSCxEX8=;
        b=MJKmwF2aNp2OfABg+Ta75h2Pj5Wd401UlflR6NcBD3ZhNJ2A7Pa9k8pHL8ZctWla0a
         zevXb4HHqAxvS5GxXFqROyvFqWUmq7b8zuV1enc6zNgNyWJEvTEccA5ZzEfZzC8kLTJy
         x1pxX+xvFEcdYQx0UmWWsETEfEZhQmn4qcUNPlpM9xJNCFgfgVc3ozFWZAZ+VfsDgM5R
         fBh0sdkj87A0+6AXSYbI3vIG61k3ma1gwUtmA4ijwrWx27+BW3ONpwJdPnEu9TqlWiMX
         ZMAtWOMqlteJ6zMTlkUQYAHnEr+L7QG+LcGpdA4gDAbthZlRjLBFrSbFRhM3otdJ9NYf
         0xRg==
X-Gm-Message-State: AOAM532fURsetb7X92ocEIszxs7mYod+o9+u02Qg1La3tkY+6P7oildH
        723pzYxLSykd+bc+DWc5Khmf3g==
X-Google-Smtp-Source: ABdhPJzHyus0/UhcHErgMOCkk+p9kAA+I4rlOE1o8icS2YgyQtSp1k7xG9yBU2QiSo8JZTsaGnIjDQ==
X-Received: by 2002:a63:6747:: with SMTP id b68mr9607653pgc.371.1636516390125;
        Tue, 09 Nov 2021 19:53:10 -0800 (PST)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id t15sm9034308pfl.186.2021.11.09.19.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 19:53:09 -0800 (PST)
Date:   Tue, 9 Nov 2021 19:53:07 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     sashal@kernel.org
Cc:     linux-kernel@vger.kernel.org, bvanassche@acm.org,
        gregkh@linuxfoundation.org
Subject: Is tools/lib/lockdep dead?
Message-ID: <20211109195307.532354f9@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tried building tools/lib/lockdep and it appears to be unbuildable
for quite a while.

   - last real commit was in 2019

   - still has Sasha's old email in MAINTAINERS

