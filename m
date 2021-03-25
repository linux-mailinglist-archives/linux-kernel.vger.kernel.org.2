Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47604349720
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCYQoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhCYQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:43:49 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1933FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:43:49 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id w2so2194389ilj.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zd+IsOavNCUB3RDkiixfR35fwyjwyYlctF6Wye7U1Rw=;
        b=z8nwVK7KTLGXlhTh29caKmGDPHyWZ+Hwy4smuIbtvvmPKGCe4F4fNOOcDrQSbBnmkv
         TX8YICMC7KqkA8zXeuADv5O660hqplSUdMT+CjMC83uCoZzCCUIOSqdIaOnFNwjWqyjD
         Tzc/RryizZzr/Ij8AeHRRWQOPbdKuGDJsSoC2KAIrHLxxsglB731j2F4MnTxjyot3QYw
         NDDb3SpUbOZ+QvDlf6f4dGPVWjZ99geBmc7OsV/3kqMOOwxeH5Xe3P0MUr7VwMSp0MiS
         HhJN3ExL4iAOk5z6K1TgC5L1Q+1MBVMDkyIvSPd/6Mde6euG+H3qG7HcuK1dlNWwNl+j
         sxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zd+IsOavNCUB3RDkiixfR35fwyjwyYlctF6Wye7U1Rw=;
        b=cDZqrHQh8vjm6qmjZR62eWZT8rtU0P+CSxRCmW4RKCfESwvlQkT4Li+WPkoTxyHVvP
         Bi5PrGnBp0QPTMCw2FAwkFZN99ufsuGqeydVnfU2J9s0dUfxqV8ovpEACOXkpqSsXNir
         SMBvCI+AbHuNsO6MD/BGgz0K2x2a+ZqyLxKSjaPj7sevOWwmC1OTD9Uq5gmG8jWTmSl6
         F8wQkZMZaMStDomslrCPeInDQBRI5RvTzA9t5vK7zeq2ue7NPPEw/4hVqNwvuuPhjKRX
         LgmkF4x6eGyrfTtKe2opAakSyPNpY7H13NE/uHlwz/GBJbJGJGOQKQ4xQ9EHJ3WNbGGo
         lw8A==
X-Gm-Message-State: AOAM532JfLvQxVS7eGJHQa+/ZqcDjcUjeZqA/+gDQp/FHYOy01tWbpPn
        9O8aMsgotfjUWQ67JO8kcLUewQ==
X-Google-Smtp-Source: ABdhPJxgDaNwKoXUuCDPPpYFGCrpVPZ13dHm//wX1tMJ485IcmkfeQg4Ez4fsCZ1xMdaXjoasgvbzQ==
X-Received: by 2002:a05:6e02:1bc2:: with SMTP id x2mr7101915ilv.205.1616690628478;
        Thu, 25 Mar 2021 09:43:48 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k12sm2990605ios.2.2021.03.25.09.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:43:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com, metze@samba.org
Subject: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
Date:   Thu, 25 Mar 2021 10:43:41 -0600
Message-Id: <20210325164343.807498-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stefan reports that attaching to a task with io_uring will leave gdb
very confused and just repeatedly attempting to attach to the IO threads,
even though it receives an -EPERM every time. This patchset proposes to
skip PF_IO_WORKER threads as same_thread_group(), except for accounting
purposes which we still desire.

We also skip listing the IO threads in /proc/<pid>/task/ so that gdb
doesn't think it should stop and attach to them. This makes us consistent
with earlier kernels, where these async threads were not related to the
ring owning task, and hence gdb (and others) ignored them anyway.

Seems to me that this is the right approach, but open to comments on if
others agree with this. Oleg, I did see your messages as well on SIGSTOP,
and as was discussed with Eric as well, this is something we most
certainly can revisit. I do think that the visibility of these threads
is a separate issue. Even with SIGSTOP implemented (which I did try as
well), we're never going to allow ptrace attach and hence gdb would still
be broken. Hence I'd rather treat them as separate issues to attack.

-- 
Jens Axboe


