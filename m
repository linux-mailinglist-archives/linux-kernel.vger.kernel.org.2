Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95B3B096D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhFVPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhFVPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:45:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:43:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c8so2872803pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LoQtGRnS4puxPnFhKxX8jHe1QQLmZQfS0jR1L1rxUVo=;
        b=cJjj6LSi+E8mFG4qs9d/cO7dNTaxtF8sqU9DhiMsI8VBVWVRASW2a1hiSueV8qJMoj
         xOpZ9FaqGRJUHREVxB3ROy188A4szawDsvpzi0GXo+t5MO7n5bRu4w3vu3LvkgwC4i39
         8x2wLCWyhDnIog6o42ukKkJ5dVWI9+qdFB99aLLl+kGEUuMHfzALS4mCKVvOgI25Vp0l
         FDwdqsbJX6B5/pyfF9LMTrmAP6p9PMVwq0tZKHAqzP4hnV8sKj7pGT8AB6wY1JQNUGgx
         dfC6cC/qZ1Ogn9XBWIK0OWqLe85YMojazkudal8XCgxJlvxCpTurteyg9vEhka2haGzR
         LOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LoQtGRnS4puxPnFhKxX8jHe1QQLmZQfS0jR1L1rxUVo=;
        b=VHvjGeA5xGWujgOqRoUpKFXYM0jvyEpR6gyd5NsxQqFMLxMC4I1h9uorgyKzpQp6mf
         UsThjZZSIDlhL82DTYkY0OnjhI0bd57YgOWa+ep+q6GMY3+Rud3k/2czZUgp5f3xOXmJ
         OI6aIiAQZFtrOQbPV+WcdG7pPCuJlEs/LSojAEbd/FozuUOsiUZYCoTsyMa3VXuwuz2V
         MMsRdYuQyzV0U05gwBN5vFy+rsYy2qiCZpGVXpPK9prS/3Hk2BCep2+GYsER6Kv4ZDdj
         XIhWBH9bBs05Xju8hAYAdaEfTCKfRzb2RfdGV7ZwKJ9aLHdDeFINaHjXIJICijLY5Z61
         7MIQ==
X-Gm-Message-State: AOAM532RxLiBBRPFoBzrGzM1YitWWO8Pn0wDgR3rweAaCs6KhxlkMccd
        LEk/vAcihrGaVyG3LqRB1wsOzPuBF/lUCYbSO/s3Z/aY3LE=
X-Google-Smtp-Source: ABdhPJyFKgy+/+Jm7Tmhc02BDYPKVthoyZfAR0CXS1Ou9K7GwlwKI55h5Ud97QvKbW5tTr3k+Ww2Zf9rIhuZK+Tugus=
X-Received: by 2002:a62:68c7:0:b029:305:324:17ae with SMTP id
 d190-20020a6268c70000b0290305032417aemr4310047pfc.28.1624376611875; Tue, 22
 Jun 2021 08:43:31 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Tue, 22 Jun 2021 08:43:20 -0700
Message-ID: <CAGRSmLu2znMPdECspDYmupHUjH17qeiJeFdCjPykhnOKHU0QoA@mail.gmail.com>
Subject: How do you determine if in secure boot mode from a static driver/module?
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Subject says it all.  Given a static driver linked in to the kernel,
what is the best way for it to determine if the system has booted with
secure boot enabled?   It looks like if I could access the bootparams
struct there is a "secure_boot" member set on kernel startup from EFI
handover.

Thanks.
