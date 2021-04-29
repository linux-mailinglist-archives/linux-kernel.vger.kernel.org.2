Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2C36E508
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhD2Gr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Gr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:47:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E0FC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:46:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h15so13335744wre.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IV+kt1OmYS8Wh4LgfyrWEcjxrFRQO5oQ7Ew+3zidxDc=;
        b=es+83lp3/LR6GR2T2eLYDRVeF4oDs6iSKJLxJtY2sxDb30eUXhyJRQqFX8+YOg8DDS
         dYsjwilyCd2Ntj+qA73QUQGeJ27C7ootXjWqgKRtYZIhcwgHL15AoWXoQ/QBTlkiScZ6
         7w/rBDBMD9tKGWXncVqHjAgzQnLUXI3UlkG5QAB6ZXpomYhYLyR0AiqhtPfEvR3YvSsu
         O/4MV2XJIbrGDTsVaiqIb6TUHD2pAeWRqzO4vMyQ0KYOA6gdn4t9GxponM1bNrEzZU2Z
         sBBG9SyDQYgUhR7jmxB7Vy3MXgYqAoA/3kD5DBu92kZDUAXvKtIA/AkHpojY2E8/j5NS
         uP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IV+kt1OmYS8Wh4LgfyrWEcjxrFRQO5oQ7Ew+3zidxDc=;
        b=MmYIAj26Q5nl8rJ0DQW1FzDzToX+tbV5fub2XWq1qPuzWHJIerXqrZrOv3DPCGF5Qh
         275oUQUWMY9+HRLREmVp8dTXAN4TKuM+s5cnGM8ZMxK++1jnAdIJd50tp/3hx1JmA/SY
         xSuIGY+GVUdIO1NCKLaUhEMtd5kBbeGyp/v9NsU5l+q6h7XxBrIfKIlIsq2i4k3uIYK8
         NhkZN5vqnwkAg5C6M94LtfocUfqTD1dhw4jbcJwKAo/0PgZZ6QzL0jgUww4M2z7Odwm8
         swRCcYb+1GhF4fI1ZmIX8wJdx1LiWYGYMRtdlf3DSkv3a7v1WTDnaUMJp3dNXgsuOXxh
         SBfw==
X-Gm-Message-State: AOAM533pyBwBOUwMZZ8MSjivaz53Ap5vCpWNJN3Q96Rx1vCK3roe244S
        bejOxePDh722+J4NykXTI5o6v2+ZJS0aNw==
X-Google-Smtp-Source: ABdhPJzqt1Y/HsKtza3a0dJu5+8QS6g3WtmcFa6cE+FWtSX33js3yaynm/w1rKAf4hlJsBIvfXnEbw==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr8332988wrw.357.1619678799760;
        Wed, 28 Apr 2021 23:46:39 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:cd3e:54f2:98f5:2e97? (p200300ea8f384600cd3e54f298f52e97.dip0.t-ipconnect.de. [2003:ea:8f38:4600:cd3e:54f2:98f5:2e97])
        by smtp.googlemail.com with ESMTPSA id s6sm10725545wms.0.2021.04.28.23.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 23:46:39 -0700 (PDT)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: wait_for_initramfs warning from kernel_init_freeable()
Message-ID: <c197724b-3d16-45bd-d71b-0a016196ca40@gmail.com>
Date:   Thu, 29 Apr 2021 08:46:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 97f8172f9a98 ("init/initramfs.c: do unpacking asynchronously") I get
the following warning early in the boot process from umh:
"wait_for_initramfs() called before rootfs_initcalls"
Some debugging lead me to the following call chain:

kernel_init_freeable()
-> do_basic_setup()
   -> driver_init()
      -> platform_bus_init()
         -> bus_register()
            -> kset_register()
               -> kobject_uvent()
