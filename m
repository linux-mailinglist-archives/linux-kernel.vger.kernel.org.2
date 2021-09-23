Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607F1415E56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbhIWM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhIWM3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:29:22 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E9BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:27:51 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b65so20970723qkc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=kEischmQPfFMnM+KWUi3YNV9XnpVqPEC7z2/a7+DlSQ=;
        b=BdNfAOvZdjrQIUVP4mtaHjraOJrZa9qE0rIQY0rrrNoB+cHpvg1ji9zwMxjZV/vcMw
         dX7WImLdvT8qmQuSJ55V0w+1l8A19o4JYkbKB1ZSsGCxo7mMFLPNkGptBob8ZWTlP/pm
         9hv60xNaWXekE2+GWizspeaEQr50N/3zUi7Fg9mfSsar1ri6nhnJGzS3Y2mQDfz8DSwd
         /ynSz5FFb1LI5NJM/tB579mx7lgQO5SiENKMetVWsxPqVmTtSaPssSUeph96woSNayfS
         V+xd4g+cvvMbu1lJvTTcUxF7F4xfACW+mvdotsbR3yN4eGRckM9kaVom42EB8uR/BVDz
         nCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=kEischmQPfFMnM+KWUi3YNV9XnpVqPEC7z2/a7+DlSQ=;
        b=xiQkqqrUIgTXBPf6QedcFyvj0RYShfJC0lpm+JanMEQFq8eis8lx2SL1vSME+5puob
         eSQQ7l+Uw+YIlWGDmXIypWLLWRNXBrR6L2RvYxvl5Gfqk0hlVCM8233pkUNxqvTW4uGb
         EeFstYF9mRY3GF4r/dB1/qcwY85Gx5o2rBv9fJ5+4XNoCWErfxODEsvteoIFAGwsj6iN
         t1GhZ50slXsMuikWrKuGKhrofdNi55MKcuFd0xaX9gVNqOL8jboUJxaXRGXXlDM3mUfQ
         iPjMuRhMHfR1sFIa9erS93BdHdcWTUy+0YqK0wnI7rQ71EUo5/rA4ieknfIr8SK9x3lv
         k0/A==
X-Gm-Message-State: AOAM530vCmMZ43KhejrcluNIfanBFAL/q68nb07OcQlooLMgsD7ZQVmG
        ee5ciB9X5WXiIUi5fM+yuY3nbG7WmPg=
X-Google-Smtp-Source: ABdhPJwiFVi6rD188hRdmDl95ySm0g8TiqpttxuneBaCzDE7ogB+nbqaBbkpLjb2O7+qyf3G89zhVA==
X-Received: by 2002:a37:aa46:: with SMTP id t67mr4320476qke.346.1632400070105;
        Thu, 23 Sep 2021 05:27:50 -0700 (PDT)
Received: from [192.168.0.4] (d60-196-191.col.wideopenwest.com. [65.60.191.196])
        by smtp.gmail.com with ESMTPSA id c4sm4035184qkf.122.2021.09.23.05.27.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 05:27:49 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Ken <kennethcelander@gmail.com>
Subject: Boot opens CD tray
Message-ID: <bbb0df1d-1e40-fbdf-d9aa-281ba77b4b6d@gmail.com>
Date:   Thu, 23 Sep 2021 07:27:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Mint 20.2.

Near the end of the boot up process, the CD/DVD tray will open, and 
immediately close.

This started with the kernel update 5.4.0-84.94, and now also with 
5.4.0-86.97.

Time shifted back to 5.4.0-81, with no CD tray opening problem.

    Thank You!

