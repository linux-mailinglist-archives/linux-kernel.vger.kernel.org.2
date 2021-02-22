Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC92632228E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhBVXLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBVXLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:11:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C030C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:10:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id e7so8509019lft.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=htMgZbviUWPJfHpdvErYulOZUuVUyLrfs/6w9xy28ag=;
        b=ClwOBQrwLYSl4rhcoxRQ/DM5JJD+v+bODw1s4lJtLIZLpR9EdecXQ0HTHBzAaHl4Ws
         2SlZ7n9BfUorVsr4NXXysklod2KJtdWt0UU+mjXez2pbalJK1kXFrsJZsDPZ4+RDmbTr
         xpZRt9pamMdqv04Mlhknx2b0AXqapL1LxFQSZkN8UParBtLWg31UV9q6+L5DLB5eX8hW
         a1QCTeyuoncaoYnxdFmkzUEzbag4c24ITH1i2Fn3K+mvUYpss/c1sQxA2EWOZ/DvQlyl
         SKQx70LDQenui6v1rV+TJ0R6HdULMgTpC7ORwZ3Ppl/wg48R6e7g0HqawlYa9BkX1TqS
         zmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=htMgZbviUWPJfHpdvErYulOZUuVUyLrfs/6w9xy28ag=;
        b=i2PMWtCfG4WCnUhH5VBQW5Dfxqewb6QV8ugBRj3M1CDM71tBX+b/QIl0/ENcwkOYin
         Dp8CdfPpazfjl0vaMSajuKaJ/+J6l23eI+n1HtJNX4JCCgnu2HrxX5lhBy6zYREEVTH/
         0euKdgPk7mTuGAXZl9myXXLK8ZxPYhoxq8vtR4+M+9mJ2K/KaVJorZrbMv4L9S8ej1GR
         rq1eIGetr2Fj0uGgQYMupNMM0I7s8Kx86vt785P1xFRhKreB2fJQnQCSxSwSCvFH8lOT
         tCn5SNkxn9rg2AiIqoiB1eLA5z6+ttCT7GsFapzwtnKZ9UNC3ahJuWdeAXMV781gP/Qt
         46zw==
X-Gm-Message-State: AOAM532kMHCq+ZQpr2FdBMXPwjavXFQtUaGlm4VRR7ActgooJLUOlr8+
        +XMBsCc5488Kde8HQpi1RIDw0VexGNquBVyvSfbZtA==
X-Google-Smtp-Source: ABdhPJwpRsRyerHjiRnE+ThB+csI+gODmDp0QyaJFsIStJfWMTBWcuWoOsE3BMvF8l/UbVnYJqknooqnxdHP02t5lpU=
X-Received: by 2002:ac2:5de4:: with SMTP id z4mr3297329lfq.535.1614035434936;
 Mon, 22 Feb 2021 15:10:34 -0800 (PST)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Feb 2021 15:10:22 -0800
Message-ID: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
Subject: [REGRESSION] "add a disk_uevent helper" breaks booting Andorid w/
 dynamic partitions
To:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>
Cc:     linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
  After updating to Linus' HEAD today I found my db845c board wouldn't
boot to android with the error below.

I was able to bisect the boot regression down to "block: add a
disk_uevent helper":
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc359d03c7ec1bf3b86d03bafaf6bbb21e6414fd

And have validated that reverting that change seems to get things working again.

I don't really know the dynamic partition DM details well, so any tips
as to what might be going wrong here would be appreciated!

thanks
-john

[   25.782268] init: [libfs_mgr]Skipping mounting '/dev/block/dm-0'
[   25.788373] init: [libfs_mgr]Failed to open '/dev/block/dm-0': No
such file or directory
[   25.796579] init:
[libfs_mgr]__mount(source=/dev/block/dm-0(missing),target=/system,type=ext4)=-1:
No such file or directory
[   25.807978] init: Failed to mount /system: No such file or directory
[   25.814466] init: Failed to mount required partitions early ...
[   25.820757] init: InitFatalReboot: signal 6
[   25.833635] init: #00 pc 00000000003936a8  /init
(UnwindStackCurrent::UnwindFromContext(unsigned long, void*)+96)
[   25.844001] init: #01 pc 00000000002f1df0  /init
(android::init::InitFatalReboot(int)+208)
[   25.852340] init: #02 pc 00000000002f21d8  /init
(android::init::InstallRebootSignalHandlers()::$_22::__invoke(int)+32)
[   25.863211] init: #03 pc 000000000000053c  [vdso:0000007f97c34000]
[   25.869449] init: #04 pc 000000000045ffb0  /init (abort+176)
[   25.875163] init: #05 pc 00000000002f714c  /init
(android::init::InitAborter(char const*)+44)
[   25.883760] init: #06 pc 000000000034dc98  /init
(android::base::SetAborter(std::__1::function<void (char
const*)>&&)::$_3::__invoke(char const*)+80)
[   25.897241] init: #07 pc 000000000034d840  /init
(android::base::LogMessage::~LogMessage()+360)
[   25.906002] init: #08 pc 00000000002e93a8  /init
(android::init::FirstStageMain(int, char**)+6648)
[   25.915039] init: #09 pc 000000000045ee58  /init
(__real_libc_init(void*, void (*)(), int (*)(int, char**, char**),
structors_array_t const*, bionic_tc)
[   25.929411] init: Reboot ending, jumping to kernel
