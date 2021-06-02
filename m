Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B2B398361
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhFBHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:45:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45652 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhFBHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:45:16 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1loLXH-0002lw-8k
        for linux-kernel@vger.kernel.org; Wed, 02 Jun 2021 07:43:31 +0000
Received: by mail-ot1-f70.google.com with SMTP id h8-20020a9d6a480000b02902edb9406104so1157015otn.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JF/0aJKnxP013HBewIyjH6wIwwDGX25maQgUvSBVXZU=;
        b=SAhNdgxIRGmjddLoaJT+UKpJRPPp+XAEdJeCqljJxj02Ob193hhky2JpnAFysQ/iL+
         v6HFHi9glMS8mMMfDufGzY1n3O+6XWUO+7u93yeO+TsBBGaez+BeO5YxxjZB7cAEVqB9
         EsGNPVI8xjuXhyoQUXEoeAcwjaPEgfAXj4xl7rjoprQRUotxN7H8RibKHzYDU0hECAK2
         jD4v7N0VleDJA80v6GUdAoaM0oX8O1isvzYCp4anPPY6I0hCZsLj7wk32Gk6LRVjFo7N
         q2L6w3xtjTVuT+7O/7KcojwQn+6G7UBTL9SFqHrzZG1Gwc6m08BWIjtmdZL42x+PNUSo
         s5UA==
X-Gm-Message-State: AOAM532ToIKb5NSS/z2kDqCOr3a7FjxYu6hxmYFO4U5mj+BT/glx97Fm
        ncZ6uB58xkFFwOBqzMiQPb1NAVv8G9rukFgrUchrTGSbt7xqMwd0me/s/k50dHrRq+kxOtiE1yJ
        FqRdptpm8BPNJPzCrI3GuWIqIA1XMfcxXMHFRsgtONhVXVRkWDbpCuRcx/w==
X-Received: by 2002:aca:cf47:: with SMTP id f68mr2842034oig.86.1622619810250;
        Wed, 02 Jun 2021 00:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgGdF8/wHGPYH/agdxWCVNfW6hGk2ORA0n/5uvkYP5vmwxzKE6hE8zHdqvY6yoUIGRfZDJk26VVyD/KOLwbYA=
X-Received: by 2002:aca:cf47:: with SMTP id f68mr2842013oig.86.1622619809712;
 Wed, 02 Jun 2021 00:43:29 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 2 Jun 2021 15:43:19 +0800
Message-ID: <CABTNMG2Cu1GqqF7qr4uCS-xNXnygEqyog8wYfRezv-nOgwfNMQ@mail.gmail.com>
Subject: SD card fails to be detected on the second insertion
To:     arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
        ricky_wu@realtek.com, Bjorn Helgaas <bhelgaas@google.com>,
        vaibhavgupta40@gmail.com, rui_feng@realsil.com.cn,
        keitasuzuki.park@sslab.ics.keio.ac.jp, gordon.lack@dsl.pipex.com
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    We got the bug report https://bugs.launchpad.net/bugs/1929444
which said the SD card would not be detected correctly after
replugging. Please check the
https://bugs.launchpad.net/bugs/1929444/+attachment/5500291/+files/rtsx.info
for the dmesg of card insertion/removal. It fails at SD/MMC CMD2 at
replugging the SD card. We found that reverting commit 121e9c6b5c4
("misc: rtsx: modify and fix init_hw function") can get the SD card
back to work for each insertion (the dependent commit 38d98d73be9
"misc: rtsx: remove unused function" also need to be reverted). I
don't really know what goes wrong in that commit and I don't have that
pci interfaced card reader (10ec:5287). @Rui, can you help verify what
could possibly go wrong with that commit? Thanks

Chris
