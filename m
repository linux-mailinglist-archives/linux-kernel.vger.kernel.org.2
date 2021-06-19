Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1582C3ADC1E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 01:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFSX5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 19:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFSX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 19:57:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DCFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 16:55:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso8674812pjx.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 16:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=44d1tWo9uoxKtqiMU5cRkfudx3SHPks/06nJLnMab5I=;
        b=BfREz8IH90dC2WDUAwrlakOxtazo/EgGp2omMj4RAUjyQm9Hm1l9N4+YzjAlmb49PJ
         ULLxckE3CNd7HufNGYH1OMZuaK4ipaoVInuFVwKq4pf9q8sHhftfnDvJu2QIxQM6oSkz
         rAAEr7Vpx+wtK6HK6Tnobe4FZqNCOcAxrvLXG2M0iGTIpOck853lE9QDRGLNn7mFYR64
         kujAPRHDtOyf+OVlUoKefvc5YmKx60E+LKPRIzIiaJkMdV+OzdvX8Q2Mw5r6o9Lo1eVg
         Q0teJPHA0CvFL+enmeMqked7EfWZWcoaB6vl36GXK1yZbDeelmYJ6wO3oAwtsLjOD+JX
         BwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=44d1tWo9uoxKtqiMU5cRkfudx3SHPks/06nJLnMab5I=;
        b=j6xp0CX4KoUfMisUCK/yi7bFzjyioXJcNdx56VsQriRl++AKsxEUMjSwNLWrt5J3s1
         XseTCCKb9UsvG/bsUVdwXBaLfbZqVwnOt/EitFjidqW0aLgmO6o4hskfJ/9LUZnEsWcS
         853ZGD9yf6m0U1kkF0OnqKIoCKodYZqfc4TsteO9NSt57+QvUQnfTn5N8HOp+N8sCLzX
         pbc3O89Xih8vy62hTqnXI1k7UEUCH84VvXWwMEvwBopIaRDZmFovyxOADjsboPR0Wq84
         n8gs3tASptDBUIy1P56N4n3CKep6c6RpJGmKi7pd5As5PbzFdfwt8JS6SBX4vXOobLN8
         PhJA==
X-Gm-Message-State: AOAM530jP1cJzn7XFEBxUPcIOwupTzHJR3TUXkz5lfVKaUHJmzwU1R+k
        wHvMaT0sc9ZVH6Glpso1ojxCNJUZ1RZSqJc+BLOEDNz91cM=
X-Google-Smtp-Source: ABdhPJy4BjHi3EfoA0PIAAi8iWliVdZFhRuIWwJ3dl5zP60s89P3SBan+FB+Lxt5F83E1+qh7TEI0XzCUWYT8NmiU/k=
X-Received: by 2002:a17:90a:bb97:: with SMTP id v23mr29917944pjr.146.1624146922296;
 Sat, 19 Jun 2021 16:55:22 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Sat, 19 Jun 2021 16:55:11 -0700
Message-ID: <CAGRSmLvaZ7av7ne-XKfZGrij1x9i5v1aH=t0ufL=Ad1193G0vA@mail.gmail.com>
Subject: LockDown that allows read of /dev/mem ?
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm finding that LockDown Integrity prevents blocks things like mdadm,
Xvesa, and a couple of my specialized tools.    There should be an
option to allow /dev/mem read access.  Is there?  There are no secrets
to the boot disk booted environment it's all root.

?
