Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A09435C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhJUIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhJUIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:09:22 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74630C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:07:06 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f3so11592935uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no9cEcbIs5Y7LX0bbr/2ARsL8owG5qfnj1gxm7bjNJ8=;
        b=YH4Rd8xGVzs1lojatFcKEfHwJ1oeB3KZizRZEHvPbyvW40Nn/dS7lYtcfoMICAFvy1
         JjAvEFL7kHwo5ljQ/s1ogrloht++yqpAwtNTs1Jcmn2Rja83Jo+VMY5x6BT4e9qY6UwP
         mmmu6g3v7vdCi+eSOUfGi+P+JQb6ujkkNMrl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no9cEcbIs5Y7LX0bbr/2ARsL8owG5qfnj1gxm7bjNJ8=;
        b=r7r3YM3f/V8KJj45t6RS/civC9ZZHVfWxaXJN3pd3+otzpz9Jb3sTaIejMbxKUo+qf
         CgBQbX11KdansLIpTT4WCMPdZ/utiuHaLYudbvga8SZrJVgS/hH8C8c1P3YjfLrK9O3Y
         rgn7qSRsSC4X6qNR7JZei3etKv8COOksJWsFCfMtuR/7uFMxen7V9PlWQATGDY0XqB49
         Ur3F3HrRXqeNbSmVOJDzOswlJ5J8oi6cULJUhImeE1Owg/AaLvRHm6t/hQAvLXpvbnYG
         Ftp3RA7uAMMUmtHD7rHAtaeqGXJ+Uzy6pxwLMdRf/GDZ4DTgJhlT6jtDfSdw3fk03AUO
         f3OQ==
X-Gm-Message-State: AOAM530zWGrsMsMiOKu6QbaMOUYcPnNA4MRUS3Ph/oVlWNvRUPmRcr3I
        X4MR/L4AihUnL4GyerKf5sBqPtbZDucHZ6R1AkrSNQ==
X-Google-Smtp-Source: ABdhPJwOzrU1ve1DcUpTmbtyQFG/OPWr0caKKjsjHToUIfpZYxivocWHmeVwGTZ2iJudsXl2h0Vl+86kFC73/E7MV+Q=
X-Received: by 2002:ab0:5741:: with SMTP id t1mr4545300uac.72.1634803625576;
 Thu, 21 Oct 2021 01:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000354def05cc0185ab@google.com>
In-Reply-To: <000000000000354def05cc0185ab@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 21 Oct 2021 10:06:54 +0200
Message-ID: <CAJfpegskcCEZAX+EbnBZyva2NDyhJ9k97ZM_E9OBeXRjDsC_BQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in fuse_test_super
To:     syzbot <syzbot+74a15f02ccb51f398601@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
80019f1138324b6f35ae728b4f25eeb08899b452
