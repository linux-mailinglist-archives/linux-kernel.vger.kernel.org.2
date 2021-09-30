Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C591841DB63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbhI3NqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351562AbhI3NqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:46:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC84AC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:44:18 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so7330759otb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KFOGzThxdfkP+Ndb5IJbZDHMCxBTtvypxxrPx7Wmm1c=;
        b=m0rjVsWPgiX9Cid+5goBr8+8el7UNRK82Did3FlYzHVwa6PV5mv5gMsmFI/jOljSrY
         AaG0mUIsFu7s67q+8aeiDwkxlHU/XyKXw1Jo47q/aPyIl+TNNbTB8fFD667plDBvSoBX
         g+E5ZyGjI1IWCqwYFUOvpvx4DSv2NAfcc7lama2mL5KE93RE0VxNon2Q1KFQptosvR2P
         yjq29bnvoVm/uY0mY0NqoI+LBtEs11v/FrtY+Mk4J69DeNIxCWFdARE8yllcKhmZFQHp
         bMKKBZSCLwSUguDoLqek35CDDr7dDUJgM7/5fwWkPTIsm4jAiI/PV6Y8LI6ocOqTt3qj
         jjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KFOGzThxdfkP+Ndb5IJbZDHMCxBTtvypxxrPx7Wmm1c=;
        b=6Argz09G8pZfIkrM3a9HIuQtEn4jvwpnQYrUD4iaL3sJ+OVmDFiNu1ITGQk3lC8wLf
         PG0zHSkmRkDOMN3EmaWZnznRBuRqU4TJBwPgO3Nk9NcT3zj+ZO6uzycmdUK8jPpsxmHS
         QDdhKXpkeq68TA876F2aODllZAHKW2Pbw7qM7imNBDzxsrecxg5VxCIWCpH65r0xdqLj
         LH1jDfrFNR8hG226DbXxPLAO4Fwl4/wX9HD23DNTbBZvSpDShoK/kFTZyWE3fVWgpFF2
         DIsKwjTroH+ivbtWrovE5Oai2hE9FQu+49ceLq/FHrT2AJ1zIdwqeH4yGLxWZkv5gkil
         Vx4A==
X-Gm-Message-State: AOAM533ZYgvo7Y74fpndESbHDotHstHkz6oVu66a22F5YENHdXwieBWx
        KNcu7nQW/Nxau6O2CCBfDGrgQdHZMNk=
X-Google-Smtp-Source: ABdhPJy2/JqctqhGcWEdUUDeieAQUZeuBZ6Il8tr/RhqF4R8ObUyI1iESJ44EwLVVNj7JNQ6ONJhTg==
X-Received: by 2002:a9d:7f17:: with SMTP id j23mr5489914otq.25.1633009458344;
        Thu, 30 Sep 2021 06:44:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r4sm575081oiw.36.2021.09.30.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:44:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Sep 2021 06:44:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc1
Message-ID: <20210930134416.GB521118@roeck-us.net>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913035750.GA1196001@roeck-us.net>
 <20210928191714-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928191714-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 07:18:41PM -0400, Michael S. Tsirkin wrote:
> On Sun, Sep 12, 2021 at 08:57:50PM -0700, Guenter Roeck wrote:
> > The qemu runtime failure bisects to commit 694a1116b405 ("virtio: Bind
> > virtio device to device-tree node"), and reverting that commit fixes the
> > problem.  With that patch applied, the virtio block device does not
> > instantiate on sparc64. This results in a crash since that is where the
> > test is trying to boot from.
> > 
> > Good news is that I don't see any new runtime warnings.
> > 
> > Guenter
> 
> I think the fix is now merged by Linus - could you please try it out and
> confirm that it's ok?

Yes, it is.

Thanks,
Guenter
