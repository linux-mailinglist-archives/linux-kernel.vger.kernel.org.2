Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF187344963
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhCVPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCVPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:36:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77105C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:36:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so16355932otr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oeh0vT/3kLIW0pyqjEcZobVLjR+/NSV8zmSmof/Ywbc=;
        b=Y73IDIb3k1oh7JZnYUp0iFdCjv0gzPXvvWqNYZFoRJtBadBP6y2vjkwBHaeLUljfh0
         JehVAASrtGJTsGAtZRoiElirPwJbiLAnUTipx48IehZZdJqwvWGRJoyBDSLeqKth1k4x
         wgJ0yU346IB2aD4fIQtoCInaQ9Sdxvdf6Bsya+spnkwpkKCbQzYahxSuTb7fhASPiSn1
         G66b2Q83Jr5atoPKBgEEvD0mc1QtOqCmMatXrPKQU8bWqyEV64whg9lCaP15L1o+g4PK
         Ykw7en1VFlHvaGCoDDNhNk32CjAQ0JwSORSB7ltWQjTyBHyn3GgannRolCb8hCZoD6aC
         KxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oeh0vT/3kLIW0pyqjEcZobVLjR+/NSV8zmSmof/Ywbc=;
        b=OZU5WcGDuv/vqQi/B1kC2D1TOkc+EJ6dMrYYGsZbiCFxBs5fAYaeKSFqXDyl2czeC1
         U15h/Yg1hbMdEjOIONX+7oWcmgwnBCbjdqtMocLbsB7Wx948s/9M6oOq9tph87mwZ2lv
         UPF9N8T8Vb7wI8t0NqcGLaBzfYbOrGs5oWdIj12F1SEei1DaW6VxvHqXo49SO6n7Y+FM
         1xgr5Mt9ZpyM/RJgWeKek7DVumXvue8FO3eNEf8H1xF1F7Dnx3jEYMGfCGa/DXaDPS+E
         1BdolGZ0Bb+DYLzKVaoiM4m+EXq+HIbEYsN07gkjaiIpQ6MyiktWytjvDB6wcolIzEyq
         SH4A==
X-Gm-Message-State: AOAM533lFuEsz/Ehyrv6v1gcR/0ciW8sr3wPHbZUMHxOoFny1frLV4PS
        XsrpD2qulmOrzJbDKyIYzKBeie43IdCX55wPDS1gSm2EFKw=
X-Google-Smtp-Source: ABdhPJyPtNPzexkd940bDQFvLs1aEKk0+h2mvUuK1x3uEMnaOxzvnYtDR2y/8fiJIV73wvbmeRFKMkkhYI0GGYs15xc=
X-Received: by 2002:a9d:5c8:: with SMTP id 66mr437184otd.39.1616427400710;
 Mon, 22 Mar 2021 08:36:40 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Mon, 22 Mar 2021 21:06:29 +0530
Message-ID: <CAHhAz+jC7kJfJRT6AB15xFBTSGpQs6VmufN8J9=gRZuwxZPpjA@mail.gmail.com>
Subject: kernel projects for students
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

What are some good Linux projects in kernel space for final year
computer.science engineering students?
Could someone help and share your ideas on this please.

-- 
Thanks,
Sekhar
