Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DD35EC70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347487AbhDNFr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347492AbhDNFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:47:54 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43382C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 22:47:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 66so9762180vsk.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tVM5T7WD+9isttd9BfiogfhskbumHL+3BbGPYht13nQ=;
        b=jmASpZXaYtVDVAS0rSRFBxoRqNjXSAxuK/tHeNfdRXLkTUWuKy1PdBM5ZHS1vgrSZu
         DeXgCiGMZ0UvNtn6dMvT1DWS3CjwPTXC8XxNiK8MZW7gbPAMPmIskS2FzDH8crbCwWy8
         XUsy0kp97jP968CKK2VVloEbSqCDPZl0V9PesHT50Gn9PD22mZSf98gVwyFC9g/oTB1D
         VtFztYKAaacC4Cms9+3wBVoCNI57iNyhoQOYFHm0e8sLpzGFqixlG5g2YD3ZErz8pUqd
         CymziIRcoD/STAkwKH/hjtb6P38EZTsrCvwLuPFIiaOzNKuTWXWXPl16hYtuk1Z3o7Nd
         2KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tVM5T7WD+9isttd9BfiogfhskbumHL+3BbGPYht13nQ=;
        b=lN4mkTO+A7zeTI1/aw4edo2X0abXt+og34BvVA0dpLAHMWlGIQt4Tf8sCOZG41UPRn
         0bFPSzIJfIcnpqdF3lFeXh9J/LM5Hl8u52iX06wswO8nRCDZ/nkHKpne3cemcDjmfK0M
         lvx/8Sj9EjCt9YgEYLua4kUHloQXivs3vvbejqRoRCfvYuHvzinRoxPx4F8OgdmYyom3
         ongsiyn+0ozbZGe1WScOLay5jPqIKDpGea4tXNR6haF8cH/41Tgo+vcoyggPxCF6gmxc
         Bu98G9JxRiRPRG7cNsdLbo/mu+O1Y2gfXivRltN7MFnQoADOaTpOPIvXOyBMolo+zUJL
         +rsA==
X-Gm-Message-State: AOAM532kXlg/FJu1XYHI0NOqTVjLV6PTEO4NJisAQ4myALxuUOl5z8sY
        aLYZMOSc5jBgflcbUe5YQWxkVvvbdt48FoP76mOdJg==
X-Google-Smtp-Source: ABdhPJwUyuq5Fq6ZWADQ1wCKWabArk1S2Rv0hXbduq6NJ4GnWBcSmvdgqW11he9RBhqmVXU2OilGHXfwnHm+9ibrOYA=
X-Received: by 2002:a67:71c6:: with SMTP id m189mr25897205vsc.12.1618379252321;
 Tue, 13 Apr 2021 22:47:32 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Tue, 13 Apr 2021 22:47:21 -0700
Message-ID: <CAPcxDJ6xx00Gjn6DxoMpdJ7UjNeJUp2613jqGRm7ZZeuMNeSjQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        naoya.horiguchi@nec.com, tony.luck@intel.com, x86@kernel.org,
        yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 12:07:22 +0200, Petkov, Borislav wrote:

>> KVM apparently passes a machine check into the guest.

> Ah, there it is:

> static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
> {
>         send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
> }

This path is when EPT #PF finds accesses to a hwpoisoned page and
sends SIGBUS to user space (KVM exits into user space) with the same
semantic as if regular #PF found access to a hwpoisoned page.

The KVM_X86_SET_MCE ioctl actually injects a machine check into the guest.

We are in process to launch a product with MCE recovery capability in
a KVM based virtualization product and plan to expand the scope of the
application of it in the near future.

> So what I'm missing with all this fun is, yeah, sure, we have this
> facility out there but who's using it? Is anyone even using it at all?

The in-memory database and analytical domain are definitely using it.
A couple examples:
SAP HANA - as we've tested and planned to launch as a strategic
enterprise use case with MCE recovery capability in our product
SQL server - https://support.microsoft.com/en-us/help/2967651/inf-sql-server-may-display-memory-corruption-and-recovery-errors


Cheers,
-Jue
