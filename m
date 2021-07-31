Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D323DC3F7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhGaGaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhGaGaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:30:20 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F971C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:30:14 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v16so6640210vss.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KSUxTO+EOQGlkGcG4nqfPKO6I6SlgWbHF09kbFHtAVE=;
        b=c6TV1iL+G9a5WwTfCqHZF5os5GeQKwGIEV6xVODb8QGEfnd3AjvDgFg8iyjd7EyDYu
         7w4zFvzzWyAeAIStawXiRTJ4hWmwHfPabteJVEqfRwqpGKJDChFilHfL40OF2tSCgcWN
         6v10Wj79mhDKqid0Is7mZ70ROfajOq2ESBhLC3GddLJqgcTnzuUXRhRT37jRbKr0ps0F
         SvZIyKgTlHn6NMvCnkbfDzn0eyFAfUJH6MbEw7qVYWyrl8aPcZhJh4oksleX9vj2xCId
         N4Wt4G2SJmwtDfajyduh+oYc4mc6hyIdccoZuQN5jeP3Bj3Oe5RbLO5dvh4WuIDAZV9f
         B3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KSUxTO+EOQGlkGcG4nqfPKO6I6SlgWbHF09kbFHtAVE=;
        b=l27air1cjLJ+wWkY/hThDV5qxMHufkRnQYEuOiQwPkNbFVKQPIgxwtE5w9r8ayBG38
         8ntkO8nJQpz4E5pzGKIc66iNF6OBSQd76cCjrAK1syf73pdT9z4Yae5N1uCBN7jDAW7Y
         d5adgbfzYo8S/VCKZOiX9LvY2Kca1EoUGGl3T5FaafC5BieTWLNPk9rESFgxrQSL4XJ8
         Ilod/z1LHoBNeVpe92r1OqBsw0ZxJCPlUFQ9xHvZj8Z4OTMvfjzZhyjne3iWmWyJ9rYA
         sg2V2mZa0fCK5F98D6zpB9otrGEKhcPcU+sYt/yxYEl93cKnGfCusw2E6joB84C7OxMa
         i3MA==
X-Gm-Message-State: AOAM5328PqDsvaLKyfR14SmupSE2+elepJ43l47QJup2AH+PV79cOeI3
        u9SqwnRdOaK+uq2L2NBzuqT9eAEhpBPwBxfJPnyCgA==
X-Google-Smtp-Source: ABdhPJxAHjnkaAfL/jk7GH1uPRMouoCiImo6qY3+0+Y+gr7iMdyVnG4uF1dbKZ93BRVajYXitoagVnAYT6Wte1dVi4E=
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr392600vsg.50.1627713013454;
 Fri, 30 Jul 2021 23:30:13 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Fri, 30 Jul 2021 23:30:02 -0700
Message-ID: <CAPcxDJ6qnrkuckxm6KkoONZZh5Q-H3-CkFiWq627p5OF3GKJ4Q@mail.gmail.com>
Subject: RE: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, Jue Wang <juew@google.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Been busy with some other work.

After cherry picking patch 1 & 2, I saw the following with 2 UC errors injected
into the user space buffer passed into write(2), as expected:

[  287.994754] Kernel panic - not syncing: Machine checks to different
user pages

The kernel tested with has its x86/mce and mm/memory-failure aligned with
upstream till around 2020/11.

Is there any other patch that I have missed to the write syscall etc?

Thanks,
-Jue
