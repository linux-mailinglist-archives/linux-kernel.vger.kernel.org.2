Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBED40151C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 04:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhIFC5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 22:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbhIFC5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 22:57:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39DDC061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 19:56:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bt14so10515981ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xydTELVR03F9tNIX3znu9/l3opgVjN88wKbMkJ2pBWc=;
        b=mc7XwRV4yCqZumKavNPxeFi83P8NsgpgvvJDzVTcs9Z5yXGO/Vw1sVK4ZJtvDRyj7T
         fQhfqT3vmOy/ZhUZyNk16b756D71A0XikEhgNYbCNJ0NpwhV2cUmZ6jHIzcljk2D/Lco
         j/Vp9xSzttiCMrrnLPxl+a65f9Ff+pMRV/50ahiGHlL9oWz+BkFWEk0VgrralmKUfv5p
         dCpMGPWvjRUQPLtHCIpbCmh49wW/lQlFEItmC/HhxNG6JawQfkdh7xkdjyyXBI8+L42F
         h8X/mlZ2rq/WdUM6tF0kWcr9UeamosVqFn4ZG35WYHqY29aMoeMAyYU1NXWYuSeCTt3H
         Txgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xydTELVR03F9tNIX3znu9/l3opgVjN88wKbMkJ2pBWc=;
        b=YWENxEd8WaEOaTdi1k/U2yCgViXNPmH0k6K49A2p6gTXbvX1sqRVngmkrTpE8AGsww
         C9/ZodsW/82kS9tXyxto1idKIdE2KoZLBHclx01MRNpOnwI9kffEVql0dXI3BU41MTyI
         DWqm2Har79BHqmyPPqOwYVRkklxNsdMbbDctyCct4F3eHc/sM3CFgeb7AqY/q5RIAnod
         ZtD272OMo+SJlg6JUYirN+vvlxArfRh2DzyX6Revf7YEwebDjdnf4UbtpPGnBlY8J09Y
         lSdMn+Yi2BMgd2U+VlXhNGPpjiB6COyUCPtwWj6C7L5Y9K3d7nPGZcYsCNQAeXThk924
         LTNg==
X-Gm-Message-State: AOAM531JHthg0jEliGeKJHRe3xeonvCO8thvqzwoKOtTVos1OPAi7AFR
        11kXnSRqMF5YOBY43h6JtEY5MmEKSpIYv6K+HNSD
X-Google-Smtp-Source: ABdhPJw9x3aDTVS//sOMbtlZpo1q7ugoS/hhYsH1jXghmXtpak3tQCvrftpkW10JUbbk5PmlDcqgWKP0//lRo1giuOE=
X-Received: by 2002:a17:906:cecd:: with SMTP id si13mr11577549ejb.93.1630896972285;
 Sun, 05 Sep 2021 19:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210906122806.2ca7e715@canb.auug.org.au>
In-Reply-To: <20210906122806.2ca7e715@canb.auug.org.au>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 6 Sep 2021 10:56:01 +0800
Message-ID: <CACycT3viMCxcsg1GXDA1kmcv3n56nDj3a3OpHb3sF40SD9tSEg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vhost tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 10:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the vhost tree got a conflict in:
>
>   fs/eventfd.c
>
> between commit:
>
>   b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
>
> from Linus' tree and commit:
>
>   0afdb2abbff3 ("eventfd: Export eventfd_wake_count to modules")
>
> from the vhost tree.
>
> I fixed it up (I removed eventfd_wake_count as I could not see any added
> use for it) and can carry the fix as necessary. This is now fixed as
> far as linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.
>

Yes, I think we can safely remove the commit 0afdb2abbff3 ("eventfd:
Export eventfd_wake_count to modules") after the commit b542e383d8c0
applied.

Thanks,
Yongji
