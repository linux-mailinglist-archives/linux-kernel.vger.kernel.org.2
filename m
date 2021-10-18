Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC7430DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbhJRCsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 22:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbhJRCsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 22:48:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF021C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 19:46:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t16so64808053eds.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 19:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aPA6TEOiOecP1q/60zbo9eREgBgRcpJtcLJc0CzBGS0=;
        b=RmvEBT1Xwde4bQaDoADfZ1CZaUnYJzHptFf/RvIx7WWBRQxtaEeNTE8ALCeU6VtShY
         X1OADI6f9uuTgqeQeuHKTmkcN4H5ZDBnLBF/3wKvleSNcez8YP22vQbyx2eomJsDGqLU
         u0dLyLFqugqxul9Qn0aAmXpAZviptgjkvhInxawPxbU6bjnYn1v6AKVo45CrmtDWjmpF
         v5N6M50SzTthsC1DGWi6oaZMwiBMJyPVE6ml1ZHT9qrjlCaC7Aj463cr/jSG7gNPKQmr
         W6JlS+fBqUrcPVasFn4p6FkkPpzMZvH+o2HQ120ZMbuBZp0Nyc6pFVEgD+v8hgzeMbrG
         6k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aPA6TEOiOecP1q/60zbo9eREgBgRcpJtcLJc0CzBGS0=;
        b=b1FMb/NvcRBgBfcM66ZBHJ3LSUFBHTqegTX4cqkA2NWi5NP0yrMuy1o4yo34mcbMbM
         oCVHXYJxP4yFknJIRrkFckdKWsr6kcop6v7xlDviqczk9PDP5UJ4iuwpEYKcMT0Sai3N
         VROJSX6di20iKoiw6dqQytMviobJ8ugDcrnPYRXlE0qwzqthuQmKqZfqDNpNKrwmt+En
         C396EiOrI0Acom1Q9TTwuWlhHJm/bNFEPnBN7GPzrdBUL5wQDbYPF1QZ6eqp7Ks/9o9r
         OLgxUXGAMWFA9530/knyMWdI01+zB1OGcGyTHx6QQ5azAtFKEu19a8m/sZ6+lC7C6O3E
         0FPg==
X-Gm-Message-State: AOAM533uc1KHyUmy2cgzfQ5a46Ky9m+SipHoVA8s9cDBCjPpdD9EGHeA
        Avs6d87hCEJ9GAZS6gXDf8DPPVF8bXe1CDtgof8=
X-Google-Smtp-Source: ABdhPJxo65155GJd6Qk7RXQIxUlQaIUTxBu/4VSqLy4j3kGnZ3RE9gb71ybYi4y4kC3Yn3ZUgdfJ4fNOeNSAIyA/79Y=
X-Received: by 2002:a17:906:6a1d:: with SMTP id qw29mr25735905ejc.147.1634525163354;
 Sun, 17 Oct 2021 19:46:03 -0700 (PDT)
MIME-Version: 1.0
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 18 Oct 2021 10:45:37 +0800
Message-ID: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
Subject: Any tracing mechanism can track the executed instructions of a user
 process in the kernel?
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am writing to kindly ask one question: is there any tracing
mechanism in Linux kernel that can trace all the executed instructions
of a user process? If this user process is run on different
processors, traces of this process on different processors should be
also recorded.

Any comment is welcome.

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
