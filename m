Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6913DA02F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhG2JS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhG2JS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:18:56 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38024C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:18:53 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id t25so478929uar.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=K/lXyeXMePgg9Tg9pFQn8T3gDDjXBGK+r9eruIO3A3k=;
        b=V9lCMCLjHRIYx0GxMpDYyc6OF1mEzYVmjtUdeNSgEYPRRyHT3BK0ldEsqHF6YLr5sJ
         BHYR6/jearmR+tu9epFF61n7fqmg3Ed55sSthVD9vXyI3oLejWOZ2DwO5ZTJCu2dnK8r
         5ZBvq2cVhFXSoPwbU7kiFe6J8EypDCl69Nil8NxviZd9Ns4NOeOJhySBb1NHCZ5sFbz/
         yA818yyUzJi2qq2DCjRa8EFOQ8/55P62bJATBkwCPGae55Gq2xykbgBzsyb3NWlLfT/R
         fII1aOpdi3QUvLVLiJledch4C6DbfxEonZUL7fF91DGhtCDOrQKwzvOJAVqq2Zk1CsDc
         M4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K/lXyeXMePgg9Tg9pFQn8T3gDDjXBGK+r9eruIO3A3k=;
        b=BQ3UmgzIVQ1iUEwMwavB2tDVM2/MQQ3jfyLa64lqvE/7Mb4QlrYbPh266PU9oguzjX
         Wj0g2E/R/kbcDfnRlgpbWnDC//9Sp60uSvQ63JQLC+TzfSPEshtVAB55tCkUKQJLKXo3
         NWp4PMrCbtBoJJxiWSITOageLuGq2xJMb4RIMr+waA96VFOQGH6+OijyD5InJO9mKHCB
         qfot4gabgeh10UPw7arH8E9Ex63hbymz0x1rnq2ApMbW+PhSJ27upFcgpm3eCK+smiwH
         V5m2WOJmzKrOyC1ZxpC731n8yTJkGnbB79YBZcXbozxFHzHm3vTJgdXPQ1VOm5s6O3zm
         d7fQ==
X-Gm-Message-State: AOAM5331rLEIsA6MzKZztUjAY6/Q3eDbNQmBg7mCDsgXnNra3DOwiPLA
        dPML+Jp5+lX28QY7C/JsclXglKRY5sk5SR8lpK9WmYBirSd+Huu0
X-Google-Smtp-Source: ABdhPJzQT+IAJNav+2Rbcop5K3d9qAyL74sYzE6S8RjR5Xbvl392DwaXWd3bca67o4dErLuMDuV5YkkLiinYkUoKwfM=
X-Received: by 2002:ab0:1d81:: with SMTP id l1mr3389110uak.133.1627550331987;
 Thu, 29 Jul 2021 02:18:51 -0700 (PDT)
MIME-Version: 1.0
From:   koos vriezen <koos.vriezen@gmail.com>
Date:   Thu, 29 Jul 2021 11:18:41 +0200
Message-ID: <CAGCbPWR7dk7fWxMGQW2ygSEbgPLbfaQiiVb2J6Tczdt_oOCheg@mail.gmail.com>
Subject: bisected: 5befc7c26e nvme impl non-mdts gives smartd error log entries
To:     linux-kernel@vger.kernel.org, eith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my XPS 13 9380 I get local mails with content

"
The following warning/error was logged by the smartd daemon:

Device: /dev/nvme0, number of Error Log entries increased from 28 to 29

Device info:
PM981 NVMe Samsung 512GB, S/N:S3ZHNF0KB11472, FW:EXA74D1Q, 512 GB
"

after boot and increasing numbers after resume. Git bisect report:

git bisect start
# good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
# bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect bad 62fb9874f5da54fdb243003b386128037319b219
# bad: [85f3f17b5db2dd9f8a094a0ddc665555135afd22] Merge branch
'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/
md into block-5.13
git bisect bad 85f3f17b5db2dd9f8a094a0ddc665555135afd22
# good: [ca62e9090d229926f43f20291bb44d67897baab7] Merge tag
'regulator-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/br
oonie/regulator
git bisect good ca62e9090d229926f43f20291bb44d67897baab7
# good: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag
'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
git bisect good 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
# bad: [be18cd1fcae2ed7db58d92d20733dfa8aa0a5173] Merge tag
'mmc-v5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad be18cd1fcae2ed7db58d92d20733dfa8aa0a5173
# bad: [fc0586062816559defb14c947319ef8c4c326fb3] Merge tag
'for-5.13/drivers-2021-04-27' of git://git.kernel.dk/linux-block
git bisect bad fc0586062816559defb14c947319ef8c4c326fb3
# good: [42dec9a936e7696bea1f27d3c5a0068cd9aa95fd] Merge tag
'perf-core-2021-04-28' of git://git.kernel.org/pub/scm/linux/kernel/g
it/tip/tip
git bisect good 42dec9a936e7696bea1f27d3c5a0068cd9aa95fd
# bad: [2958a995edc94654df690318df7b9b49e5a3ef88] block/rnbd-clt:
Support polling mode for IO latency optimization
git bisect bad 2958a995edc94654df690318df7b9b49e5a3ef88
# bad: [b60b270b3db617811e593db5d5920ed98e67ce49] swim3: support highmem
git bisect bad b60b270b3db617811e593db5d5920ed98e67ce49
# good: [de5878048e11f1ec44164ebb8994de132074367a] nvmet: remove
unnecessary ctrl parameter
git bisect good de5878048e11f1ec44164ebb8994de132074367a
# bad: [5befc7c26e5a98cd49789fb1beb52c62bd472dba] nvme: implement
non-mdts command limits
git bisect bad 5befc7c26e5a98cd49789fb1beb52c62bd472dba
# good: [d8e7b462f5b8b93920c6c6a191be887b32306e6b] nvmet-tcp: enable
optional queue idle period tracking
git bisect good d8e7b462f5b8b93920c6c6a191be887b32306e6b
# good: [25a64e4e7ef6da605a86ec1bff18d2c3c6ed5329] nvme: remove
superfluous else in nvme_ctrl_loss_tmo_store
git bisect good 25a64e4e7ef6da605a86ec1bff18d2c3c6ed5329
# good: [dd8f7fa908f66dd44abcd83cbb50410524b9f8ef] nvme: retrigger ANA
log update if group descriptor isn't found
git bisect good dd8f7fa908f66dd44abcd83cbb50410524b9f8ef
# good: [c881a23fb6f7eb901155d25ba8dd1af0b8c7923b] nvme: disallow
passthru cmd from targeting a nsid != nsid of the block dev
git bisect good c881a23fb6f7eb901155d25ba8dd1af0b8c7923b
# first bad commit: [5befc7c26e5a98cd49789fb1beb52c62bd472dba] nvme:
implement non-mdts command limits

Reverted 5befc7c26e (first 8609c63fce nvme: fix handling of large MDTS
values) on 5.13.6 I don't see the error anymore.


Best regards,

Koos Vriezen
