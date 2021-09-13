Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067BF4083D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhIMFeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIMFeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:34:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:33:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z1so10503704ioh.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+zkHhEtGWnLB+Tj9aWbKyvIxrL0p9tjKOA7292g/xI0=;
        b=A+aflym3WI7Oof3tYmDXVHFfyuKkQbFqwfv5jtApZGYSnqWrs360yEo3SQcuyNpSoC
         rrajiCDzx6RextRekLabMnunvsqYNYdf/d7NayDAFi4PKFKxQXhF2UErKWMUQY6BwrTj
         8rUV4IkxkTsP1OFqrh7kz+OQcJEz5JR+mjL1XkTud29XMD1JIKjcrow/lsKfVjPzRE7L
         xkH8fICuNxrUyGl+UIUorf45GOLg0eYRO1uzJ00TRoNIW6qoL4c4Y7vwheuIUWXDwY+h
         G09cGVTeMfC1YWmcJakmzlWOP4HPH81aFrehI9za878KIs0ZRTS6UHjDbATh6RRa4qTW
         3KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+zkHhEtGWnLB+Tj9aWbKyvIxrL0p9tjKOA7292g/xI0=;
        b=bFCCoL6hQ0bwn7sx6mnpfiOC/nSmxGLId2ZLwklty6uZ3BjRxH4NF1wyMHN79COMeY
         WEdx+cc753rwcgoX5oT7A4bwJuF8NtNkE2ylhojgluqy8Xu36Ja9IDNtnHRAB6p68OI9
         vRot28wTtM5uqUSDFvOMXb10gDCsyAx8k4ytuRgDsBM5nIlTqh9GzBc9qL/1FXC4b150
         4n9De4pJy7dJjxw+foRgTl0W9UdFpBdArwgVNbTgV2qN1JvIDnyvNbyc14E/+Fce1RMG
         MUfP4PvlRSk6DVX4lWn9hK9xkHhRtMXBT+D1b6QbUQsiWzZpYEspDSieObb7mCRVA/Io
         HpUQ==
X-Gm-Message-State: AOAM533UrBo5lRbLP4390ZsgKQ6jDknKAlAmMlK1zwdEE7RTUmoG06pC
        iueTCuPExMsot9r2aPFSyk8y9SQnS5DAteia1BA=
X-Google-Smtp-Source: ABdhPJw6jkx3NNtn5ROK8c4w/CcB2H1wrh1WcEOUkBlWJIx7UyyRYuZALsqMrMOYyhiFbYCA5g0g/hdZ39Gm5Z/ezHQ=
X-Received: by 2002:a5d:9d01:: with SMTP id j1mr7788408ioj.27.1631511182529;
 Sun, 12 Sep 2021 22:33:02 -0700 (PDT)
MIME-Version: 1.0
From:   zhao xc <xinchao.zhao.kernelz@gmail.com>
Date:   Mon, 13 Sep 2021 13:32:51 +0800
Message-ID: <CAP7CzPfLu6mm6f2fon-zez3PW6rDACEH6ihF2aG+1Dc7Zc2WuQ@mail.gmail.com>
Subject: 
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, keescook@chromium.org, mingo@kernel.org,
        joe@perches.com, john.garry@huawei.com, song.bao.hua@hisilicon.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer:
        delete blank line between two enum definitions

Thanks!
