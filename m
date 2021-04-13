Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993B835E45A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346912AbhDMQwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:52:06 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:37457 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346900AbhDMQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:51:59 -0400
Received: by mail-pg1-f181.google.com with SMTP id k8so12361187pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFDrWXEKLxNMOAxHhnP6TPJVdIjMSe8nWkdUzoS8xaQ=;
        b=imQjXo/bdZYNFo/cxx/yYhAOZFIDjg+RDhuEzdp184w4BlFUyRoiL6a9vXDw8nd0FX
         Tyto49WWmKKWB3FtHa/xsqtJIgvLgQebTYUOvswjhHzALpyPxFWMmaTcecfAt/qWcBJQ
         kYsgukth3uIpqwRI9ni8lsFBqaJ8TZLaO/OEipZONpNhhmKrQNJDWz+7OO+eI4RmdJzP
         01GukOht2El1Q1aD6FiEhuj9wqBmQjpwyW4t7gV/doKp3Hcye3X+AeLafChpkigFbxqU
         S30ZBFl5L2pBGRoGIQCI7iEvXS779uPYJK5Cnx3wPv+LLVD6Gm23b7+nQ6zHsHfLjJwR
         VHVw==
X-Gm-Message-State: AOAM530szcOMSmZ+fpdCc3oOvfCPzZqk1NZZINXGZ8Ts/yeP6IKP5gRW
        VfLDygeM1WGdOKfvwyAtrF8=
X-Google-Smtp-Source: ABdhPJwDqSc2j9xT3BG422gcsUWcZqd+rNoThwPOjm9IG/Plzgy6wpxqFo4qGysLcHOkfi5qN2r8vg==
X-Received: by 2002:a63:d815:: with SMTP id b21mr33173566pgh.217.1618332699569;
        Tue, 13 Apr 2021 09:51:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id bx2sm2974228pjb.32.2021.04.13.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:51:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0EF6440402; Tue, 13 Apr 2021 16:51:38 +0000 (UTC)
Date:   Tue, 13 Apr 2021 16:51:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
Message-ID: <20210413165138.GI4332@42.do-not-panic.com>
References: <20210413104242.31564-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413104242.31564-1-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:12:42PM +0530, Anirudh Rayabharam wrote:
> The use-after-free happens when a fw_priv object has been freed but
> hasn't been removed from the pending list (pending_fw_head). The next
> time fw_load_sysfs_fallback tries to insert into the list, it ends up
> accessing the pending_list member of the previoiusly freed fw_priv.
> 
> In commit bcfbd3523f3c ("firmware: fix a double abort case with
> fw_load_sysfs_fallback"), fw_load_abort() is skipped if
> fw_sysfs_wait_timeout() returns -ENOENT. This causes the fw_priv to
> not be removed from the pending list.
> 
> To fix this, delete the fw_priv from the pending list when retval
> is -ENOENT instead of skipping the entire block.
> 
> Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>

Thanks for your patch Anirudh, but please also see this reply to the
issue:

http://lkml.kernel.org/r/20210403013143.GV4332@42.do-not-panic.com

The way you patched the issue is just a band-aid, meaning we keep on
moving the issue further and it seems that's just the wrong approach.

Can you try the patch in that thread, to verify if the UAF goes away?
