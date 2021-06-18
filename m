Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378FA3AD533
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhFRWcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 18:32:09 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:41854 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFRWcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:32:08 -0400
Received: by mail-io1-f54.google.com with SMTP id p66so8668631iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=f97shf5kWXCqC+6MB815Nzrg6geWu2iQmfA9tG/EUP8=;
        b=cnKj4I/7zn5cHA/dRTGp1iLHsvdb57q1FiLeavjDlAGbGH8X08bvl9YZNL6Qo2ptWw
         IO8mQPg47qbpdRTMYbSgo7BRhIjC90tZP6pWvzLSeA4Fp+9AsXqFhd0ZGgGKLKz5y6z3
         wtnCIVA3EH++isJbylQ2IGDM4O1+PIKUIx8jl0YVmiP5peg3fiX/HWnyUtIoJfXQ06Ko
         9/WgLw6i5jGR4KFKfcUhkVST7VG0gIQE1kcWyuvYgf5+3RdVZ8P40Jh8euw+CP7Z8qCK
         +ZSDthquUhpwa+dESN6TwdgOjEkroY0Q4WArwl21XkEMkt6pYSlR6M50SHdFUGqWTMSg
         uj2w==
X-Gm-Message-State: AOAM531vmfIYxj6GeTft8DZ+S18p3G3kLF9Jsko1BH3wxoUTCDWOjqpk
        68JcPzG3Vulj+WmPBT81B2m9g4YMlBo=
X-Google-Smtp-Source: ABdhPJyYBNKaCkSwYpE8nWhUfgX7/5j4QKu57oq3a7eTM99+aRkJY8Y6ftM8wANPIpOiogZg/zP9tQ==
X-Received: by 2002:a6b:d113:: with SMTP id l19mr9537359iob.207.1624055397646;
        Fri, 18 Jun 2021 15:29:57 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id j12sm1858948ilk.26.2021.06.18.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:29:56 -0700 (PDT)
Date:   Fri, 18 Jun 2021 22:29:55 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [percpu] rerun aim9.sync_disk_rw.ops_per_sec request
Message-ID: <YM0eY2uyQg51zx/a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

Thanks again for your help previously with running the tests in [1].
There have been some other clean ups so I've rebased that patch [2] and
created a separate branch in percpu#depop-batching [3]. Could you please
run aim9.sync_disk_rw.ops_per_sec against percpu#depop-batching?

[1] https://lore.kernel.org/lkml/20210427073448.GD32408@xsang-OptiPlex-9020/
[2] https://lore.kernel.org/lkml/20210419225047.3415425-5-dennis@kernel.org/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=depop-batching

Thanks,
Dennis
