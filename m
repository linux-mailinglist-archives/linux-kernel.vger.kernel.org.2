Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD334DC12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhC2Wu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhC2Wuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:50:40 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30895C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:50:40 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id v29so3219319vsi.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=qJHAGTwEE5rE4W5xS0P/mcojpftwWdlgOu9cd+saWlo=;
        b=XqjoCGoXf6XiUpVcbl9ShVhxwno+LISBz1f3xDZ3KoJMPjHr3SFletkWuLvTURR24Z
         L2kwoO2IgsLjjd6R+DGHUxUN6prmMSiumK5ZdIVDIB0Thfv3RTAC9do9/X4oHzp+/VLS
         Wg8rA910U6JBnpek485w/8ucla6un3s4jXtV/WHP9qEWFn9HEelMcpMtDsA5caJ4cHPC
         mFvyHbn7C4vYob9OfDDu9d+QmgnLVaqSfIzp3PuZymRmTpmI6ULhLQ/tT9Spdx/mDPdz
         D1mrDCwBZgyLsuu4OAaRIHAMFGH+jczqwmZDgXa15xae82qb9E/2spN4hvLSaZxK6wBj
         RT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=qJHAGTwEE5rE4W5xS0P/mcojpftwWdlgOu9cd+saWlo=;
        b=NPn0jla1EOGkAsozO91qhDUdYA4t0r+a8VnzPllByyPTbJCEgGdR3B91pJlPWM+L7V
         frVZe+XyfbyMLslOV5SlsvCNPSqAgYUUDwb0PuYL06LAyyKfNWwAxgQEtbkBSpw87zMd
         tsVlN+6T3G8NfIoDanOQrP2l7iOVkiOXq3E8ICb5uVkYTQ+X5Jkb4FUOPTR5cxB3LJur
         ssTVUZ9gQe9RSNOhOxPmBqVJ0kk54dvMXVZm7X+9N4kieuPmwRxcWKXfy1jUMH4qVWpX
         ZSysGK82VUnBIUczeVPZk1MiZbUT50pN7m5wLULuXYy+A+GrR3+561RJspVAqjZNk+kd
         m+PA==
X-Gm-Message-State: AOAM5317OQHg8XbYS8LUKGxBITMlDbPVVEj+VDh2WWnJeMtteFkQnlr1
        EcRwJwwOdNcshi0GhV/w/bkkIKli1Q0gUD8O9Rg=
X-Google-Smtp-Source: ABdhPJyKt/iMkZqYr7EZDMdElHHfoMaEnj1RtY4N+7wggN0Tt9im+PZmm2f0xwHs/bAVr+8QumlSqyCqKfYB0mtJxh8=
X-Received: by 2002:a67:f3ce:: with SMTP id j14mr634939vsn.32.1617058239411;
 Mon, 29 Mar 2021 15:50:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: raydan12124@gmail.com
Sender: ralfrich12123@gmail.com
Received: by 2002:ab0:586:0:0:0:0:0 with HTTP; Mon, 29 Mar 2021 15:50:39 -0700 (PDT)
From:   RAY DANIELS <raydan12124@gmail.com>
Date:   Tue, 30 Mar 2021 01:50:39 +0300
X-Google-Sender-Auth: cK9BG8hnRksfndVU3LVtJJZfyQE
Message-ID: <CAACQYgC2KVOMriy0RPEtW27BLpn+ZkztHXpJ-03B5XYtzZqfsA@mail.gmail.com>
Subject: Good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good day.
Please forgive me for using this means to reach you but I can't think
of any other way of letting you know the urgent matter at hand. A
national of your country who happens to be a customer of our bank
where I work (Ecobank Ghana) was a victim of an auto crash in 2017 and
he left behind a huge sum of money with interest totaling $10.5
Million, in a dormant account. As his account manager, I have been
mandated to provide his next of kin if there is or the estate will
then revert to the government treasury as an unclaimed bill. I have
contacted you to assist in repatriating his fund valued at $10.5
Million dollars in our Bank. Ecobank is one of the commercial banks
licensed by the Bank of Ghana. I will furnish you with more details as
soon as I receive your positive response. No risk involved at all.
Yours faithfully,
Mr. Ray Daniels.
