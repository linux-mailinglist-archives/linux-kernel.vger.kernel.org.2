Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F1337547
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhCKORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhCKORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:17:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87341C061574;
        Thu, 11 Mar 2021 06:17:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso12877360wmi.0;
        Thu, 11 Mar 2021 06:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cJnKwlLH8mf61Kjn3I5ayRTNQYAE2P9t3iD37An+Rxs=;
        b=BDFcJNRxipcR2u0Y7Gx3hpAAAT6kXY6uO1icLZ+K6m3rRYY3U5WYf+RQl34eGk1rLA
         iktSMghhForV0bk03hAj1mtz3yNLC8LNPHa4RIff5KoRrH93w2hjwnYuhlMguILbiXJX
         w2hvwMM2repabNa123X2q7S7NULrvMTb7jEQqC1ZKyPgO4IOOtnfl+jTG7LoZ9D/Vf+/
         iCChdADEhJWNRsXPW1N7lKW3py7f3bdkizVhacbJ5fyaIk45snXKSsl9I0Hr4j5qIN88
         6jcigCSamjLUzgikwq0OJCWpsYQ8nprOVizKsUZRRU6b5pgchI2cKn11u+5f6euGn8uc
         ixeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cJnKwlLH8mf61Kjn3I5ayRTNQYAE2P9t3iD37An+Rxs=;
        b=s/8oKP9/+LCorrPXw9PVNL9/gD+npB4jsCizjLa0HRgAV+FMzP8tYipO2G9RYgLy0z
         7wX4xoy8iFYJD/9Rbtnz8rXlhXUlsapG2PswtgtRhyLIv4DoPYDcz7TqYAciCuKHkZBt
         u5EYCqmE5vtv93iRw2ydNQOSrmqnEaqq9TJ9Nm3qsb3d/zMHg4DCe0fm1qwDwUNfZy7p
         kMuiuseZR9O5mbYNCeahQivYMlyNT601ZD2erPstI7RjiavE1uKSWsjwIWDy04Qz3+UA
         2pEt8dp0zg81v6QGLouQGGOcOG4vcugd7zSwLBOJa6/CsKRFzZ3Er9c3Pf/1FIGv3Xv4
         dnSA==
X-Gm-Message-State: AOAM532B/tOgyYZvsxE3zbHkV6Immmji5AU54eGGJkUxoUFA5jFgV2Ac
        6JsobK3GzDrZATqXvQRu88Q1SDxJ/rI=
X-Google-Smtp-Source: ABdhPJyRBT+peCBq0HMALni2WhboVohZEt4D1G2iLu2o5tXIakZ7N13pXyorZCtfVuMqCYwnprTfyQ==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr8450860wmg.87.1615472233358;
        Thu, 11 Mar 2021 06:17:13 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id i26sm4255555wmb.18.2021.03.11.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 06:17:12 -0800 (PST)
Date:   Thu, 11 Mar 2021 15:17:11 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: sensors-detect: Found unknown chip with ID 0x0404
Message-ID: <YEomZ1+Nk0m150lt@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have a server where sensors-detecte gives:
Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               Yes
Found unknown chip with ID 0x0404

I have tried to search on the motherboard but didnt find any visible NS nor ITE chip. (could it be embeded in chipset or BMC for example ?)
Furthermore, with another OS (a buildroot with more recent kernel), sensors-detect give that the ID is 0x0101.
Any hope there is a real hwmon chip behind ?

Regards
