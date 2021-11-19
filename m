Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92C7456783
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhKSBmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 20:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKSBms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:42:48 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8FC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:39:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y26so35345405lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=uNjtySMfoo4Kvq8+xNCmjmnlrvwx+yukyy3H7k31688=;
        b=Z6oznX2xGp7x6R3XXK8SNx5XXuWhJzsBGi9G2Vzd3BRqVrjMmLHvFzGVs8AQe8Y6RO
         Xx02puuKiN6ekLwDvBTa1pPytWCw6rUyXT0hHa+BqwvxsFF9lFyrznO8otPF4IhSf5Wv
         pdeNdiKVHrCYOunXTTQgcGsbe+P9wag6yHefsW8LGpI+3/2r4hneV39C4CqItf4XKkdk
         MAezst1oMC/ZLDLjrnlggitapn9XoMRPUImpfozBAXEKLqiFCvv+xJQ5OM1GNkeUSlBU
         BaErvAKYa+ighTWowc3VgSCNSg2Z6UAcIw/UaSFRnTJVkAA0q/fkWqMuVs2gaIKEfWbK
         dQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=uNjtySMfoo4Kvq8+xNCmjmnlrvwx+yukyy3H7k31688=;
        b=l2/BNvg6NuoCyLoLmbncM/C3wLjVM0mNB2RnA4d+I1ftsavyYdkuqPI+4TR2pSHbGU
         3aUkJynnOomKaC3mZvYJSJijih0TJ8gSBJujF501RDbkDDkBkNYEfUfq7u1yDuilfMj6
         g77m/CIVLgfy8QA7ZN5DswB+P1agie/tpiRSCfy0NubK0sVNkymEqLdPogfNhI7jXSh3
         Pot90iRrnlnVtUUjUMH0o9G5XInYrhsXwPR4e0dVs4PcUmAQnCJC0R1U6jpz2Wu8/bXx
         9gRf48parLNaza+f0xltYMaEGBDVNchZEVirwnx7whC7Ve3i6lk4I+iXFNYpeME8WE8f
         /0Og==
X-Gm-Message-State: AOAM532o6MUSdE43w1WDFpKnQYw1gg5yXEEk4FV/PQHtQI8yumHuburv
        p6OMAFQAjsXV3dnOZWeZ6owtz16bD7tcZVRy4iU=
X-Google-Smtp-Source: ABdhPJwJ+WNQ9W6Yk4JtiBHETNGW8B8PbOYskqfgAG3Q0mKQpbM9nGh7K7xfuzqts9pRwcAWo4rFeyAIJSGFmjw2o40=
X-Received: by 2002:a2e:9f51:: with SMTP id v17mr21897282ljk.287.1637285985768;
 Thu, 18 Nov 2021 17:39:45 -0800 (PST)
MIME-Version: 1.0
Sender: fayeeladji0@gmail.com
Received: by 2002:a9a:6ac2:0:b0:14f:31bb:e528 with HTTP; Thu, 18 Nov 2021
 17:39:45 -0800 (PST)
From:   Jane Newu <janelifenewu@gmail.com>
Date:   Fri, 19 Nov 2021 01:39:45 +0000
X-Google-Sender-Auth: upIDaM30kUwwJxARmWvJscO4BUI
Message-ID: <CAKRnWJKii3WtGirMD52NMxKVrMGekiecdJNe=NwF1Z0e+ua6sw@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you doing today?
