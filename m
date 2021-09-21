Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB52412B39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbhIUCLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbhIUB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:57:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3516C0EFE5C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:23:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b20so15887807lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMUVr7DkvpmTXdSi2JZi7lCtvJpc0T3IJBPwa04G+8s=;
        b=JYtb5uTktSfe7uW6Wq47SPkUvNdKE4yiymISnkxWJP5nXo/AWtdXqY/uLca18Fx3ie
         QinU4bkyBG7t64eXElx+zOoTgQQLvAFkCZ/sGg26Ck3DAzR+5RzMG9QD5rarYx5OyXhT
         3mpSCEliq2RGi+yBaBeFlletzequb29CG4GZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMUVr7DkvpmTXdSi2JZi7lCtvJpc0T3IJBPwa04G+8s=;
        b=5JpdSPyFY+JMPXlHngCP5NXvPbcmUmNk1OTEDac3oFVtbyk7shVJNapBwR/qWtuSIS
         HV1kKLLjhiQVMa+IljPWUQvvQ64Y3PkVIrw9471/W3L+c14+IdE3n3b0uBee80Gq9AvR
         +cuYNoQhh0lbZx8kbdbEnRWfnjYsuo36myScVA9Uf3xCqo+zqGC1Awc/HmTAuXJJdTqv
         WUG1Icl7/agD60teBqp8/WMbIYZurNOri0No1XdYeIEVSNBT2duutDsmSH3kpYvhwlNN
         B/c9hTGpfoa1xlddko9dGtiLYVe7G44nFvrpbBZcxh0r7K2SG8o0hjUS3GDOExVTnOv7
         jueg==
X-Gm-Message-State: AOAM533UNh3wlrSH3Gpat9Kk4i+EXZ4+I/mjZQpNg+kq3nNv8TP3gvUT
        c4t3U8P7thfvQDcw8e8dUh7xSoq8eOkZ6ITiIKg=
X-Google-Smtp-Source: ABdhPJyilyD5iWyr3BAQJfwxzCN6uJDALfbzpuLx5hhJFy6hQwlF8L3+McXJHPcftBJ96ayRqZHUxg==
X-Received: by 2002:a19:750e:: with SMTP id y14mr20580226lfe.680.1632183837539;
        Mon, 20 Sep 2021 17:23:57 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p1sm1927927ljn.130.2021.09.20.17.23.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 17:23:55 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id e15so35689696lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:23:54 -0700 (PDT)
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr8879781lfv.655.1632183834712;
 Mon, 20 Sep 2021 17:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210907212347.1977686-1-minchan@kernel.org> <CAHk-=wh2_yEuAC5=9VWefK+0JD9pAKf8qL-vpSmS7MtLA8SZEA@mail.gmail.com>
 <YUkeOB3GfK6KO8KG@google.com>
In-Reply-To: <YUkeOB3GfK6KO8KG@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 17:23:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgr+xHSgita2Q-HD2CPx5dfgY2jhnLwjk7Gtuv+bOxipA@mail.gmail.com>
Message-ID: <CAHk-=wgr+xHSgita2Q-HD2CPx5dfgY2jhnLwjk7Gtuv+bOxipA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fs: invalidate bh_lrus for only cold path
To:     Minchan Kim <minchan@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     zhengjun.xing@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 4:50 PM Minchan Kim <minchan@kernel.org> wrote:
>
> I have no idea why I couldn't find the reply from lore.kernel.org/lkml/
> The message id was 89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com
> in the thread(https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/)

Hmm. That message-id isn't found anywhere.

Maybe it was sent just to you personally?

[ Goes off and looks ]

Nope, I can see it in my mails too, and yeah, I see

  To: Minchan Kim <minchan@kernel.org>, kernel test robot
<oliver.sang@intel.com>
  Cc: Linus Torvalds <torvalds@linux-foundation.org>, Chris
Goldsworthy <cgoldswo@codeaurora.org>, Laura Abbott
<labbott@kernel.org>, David Hildenbrand <david@redhat.com>, John Dias
<joaodias@google.com>, Matthew Wilcox <willy@infradead.org>, Michal
Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
<akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
lkp@lists.01.org, lkp@intel.com
  References: <20210520083144.GD14190@xsang-OptiPlex-9020>
<YKasEeXCr9R5yzCr@google.com>
  From: "Xing, Zhengjun" <zhengjun.xing@intel.com>
  Message-ID: <89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com>

but lore has no idea about it:

  https://lore.kernel.org/all/89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com/

just says "Message-ID <89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com>
not found".

Strange.

Something presumably caused the list to drop that email.

           Linus
