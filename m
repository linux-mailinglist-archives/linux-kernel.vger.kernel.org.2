Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20DB380C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhENOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhENOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:53:55 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:52:43 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ez19so1173575qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zGZ82elK77/5kH34uv0rbc1Xa2C0OC28pMsSXnsj//w=;
        b=Ok05uO2u0+cLu0ko1F+90xVTqaJl2/nU431zQ+9kXHtTsRj33AtPMiUAedrckSs6T2
         mipFIXZpQasDOqRbSdWXKS2IwnPtcyKGlLAcDDwWmOG0GOy0qAKpUqjX4MgwbMiyPgN8
         rYkUFcmgHkHje7qV5U3iYBA/GYkTatcAFsxS1OdtjgCp3qS2NZzmquKHo0pNUfhw5IXD
         eddOJZSi3SdjDSva3qATlAJAp1XGP3IHf1JZ4Amu+sjBx6XLAVC2OR4fmyZlhIZl+R7l
         8HAxg0G5JjzxNZiZrq3jqHV1jQOODgQP9HpDjTjNB9COGBCPcpNx9MgiKy7be2Gsle80
         woEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zGZ82elK77/5kH34uv0rbc1Xa2C0OC28pMsSXnsj//w=;
        b=SxfuqqgGSpNI8H812Q10euM1fmI59+ypuDmZSrBTnVEbSVYb6FVbAMbaKfy9Rj9URX
         Roq4GJ5e3A6054Oq/mroKv1E68yhbmS/BztBR6dNmdoXgUoBq39Hk/iyA4prcWGXl2on
         xzyNewgbY+4FF7EeKE4ddyjd7ralR+kyCuiheEudpZ2ye/4t19qmdLGsCsGlewxjKA++
         affFdiU7RoExl0U+vYr29rxzJJFVV+5aC4cAMbnXjpIhc27Wn0lmBERnmZWtpsQnDex+
         0aYH8DLS2tYcjHkZjmLfei+eAsH92HZvl3ixer5NlD63+ShagYjMCq/X0Q8RJB1BhEEi
         9qqg==
X-Gm-Message-State: AOAM530W1ZA18ykOlq3g6D8mn/fP9ihilVJlNKC9dIYu4KMgCkbUcTyC
        nr9j+WznJK4iRPQlMFgod7nvdrmwA6o9TlqYh9DlAQ==
X-Google-Smtp-Source: ABdhPJzf99KR3hYW03as+Lr+ImfaQfpn3vZSvfZa5mnjBQTolGngYur6tk/B9ZkbpscxMeGoEUVK85ljRv/Odtfb20s=
X-Received: by 2002:a05:6214:126f:: with SMTP id r15mr12778024qvv.35.1621003962738;
 Fri, 14 May 2021 07:52:42 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 14 May 2021 10:52:31 -0400
Message-ID: <CAJWu+orW9PA7m_s5LHhQv-bEO0xFq7n+9-fznd79boKkmQUR6g@mail.gmail.com>
Subject: Silencing false lockdep warning related to seq lock
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boqun,
You might have worked on such issues so I thought you're a good person to ask.

After apply Laurent's SPF patchset [1] , we're facing a large number
of (seemingly false positive) lockdep reports which are related to
circular dependencies with seq locks.

 lock(A); write_seqcount(B)
  vs.
write_seqcount(B); lock(A)

This cannot deadlock obviously. My current strategy which I hate is to
make it a raw seqcount write which bypasses lockdep. That's horrible
for obvious reasons. Do you have any tricks/patches up your sleeve to
silence these?

I suppose we still want to catch lockdep issues of the form (which
peterz chatted to me about):

 lock(A); write_seqcount(B)
  vs.
read_seqcount(B); lock(A)

which seems like it can deadlock.

I would rather make lockdep useful to catch these and not miss out on
them. Let me know what you think?

Cheers,
-Joel

[1] https://lkml.org/lkml/2019/4/16/615
