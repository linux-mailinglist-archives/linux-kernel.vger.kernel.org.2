Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297C141679E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbhIWVnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbhIWVny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:43:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D90C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:42:22 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f129so7726506pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyYDxmDuTKY2lFXVhVB2ELOLfNUN9k8MQqqdBbe1fsU=;
        b=KCn+RIus6IoAP1X8IGB5+QqORKUYHiZhLK/h15vdz7nwgfVVFdnDeTUS6x5EfXNqEL
         vHkl1lsNcWgI2Al+3tUFeWxzv41dExhFvYTSHffU7w2mJqYg/X4iTVmV0gzEv6VATSbN
         GyrOI1pXzxSYSJQ2Su61Cky0Czb2vOefxnUSphokfU44py09/SjUTaxnIYLh7Be5ditG
         13BEmHxxYJ41ceEGMeAmeMf8/NrNBgazCyMlEf22xgNKPlhHw9XSI4GKbwvwi0qv0ovI
         KwZVg7eF6TaIoezX825StnyoRzKkWaAdbc7zT1oe51mmpWNq0/cltBhb4i62RbDpm+SV
         N0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyYDxmDuTKY2lFXVhVB2ELOLfNUN9k8MQqqdBbe1fsU=;
        b=OTvQndz1TciwDtqcPd02Nam23yeNmDBOdoY6I7bttUsP2QjscDbTBXQdP28YvhimaM
         VD0a94nHp9Tj3qKPpTHDAaAWHDWd2woCIMtf2+115sFu0dqQiecpCVDJkBINa6aXy/Ak
         GeRhaHwLit0PC2NUG8HAZ9IxzODVBx+UjoVCc3yu3YGScsXXDaipQjw2RxOxxBEW7als
         jlereVhXTYH/9syqxhJZVzYMpqqbK+9LEj8P4QSuFfZO1FRWyYOrFhLIVUmKN5A3DzeM
         Y1CXcQ4Um+ZwIzUAPeQMYYOJD2hJDDgcWGeroJdTcOwIKReVZkYcm8aCvmJcqUxlQcxM
         pCfA==
X-Gm-Message-State: AOAM5312JW21IRaYMhAmIc/UM8eSMyTwXe4UH2iBcV04+AbXnW5WGftA
        JNgHGK8I6s8+6yjSvtGuKouBiGjp1dfyp+FLZnuwhg==
X-Google-Smtp-Source: ABdhPJxkWk0rZvWEVajRy7qi3gMohR9kiAbp/zbww61b9hU8jzVgph1himNBBtHY9AvwIfwrqHDuZ1oo/UvxAInWtm8=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr6537475pfd.61.1632433342168; Thu, 23
 Sep 2021 14:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210914233132.3680546-1-jane.chu@oracle.com> <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com> <20210915161510.GA34830@magnolia>
 <324444b0-6121-d14c-a59f-7689bb206f58@oracle.com>
In-Reply-To: <324444b0-6121-d14c-a59f-7689bb206f58@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 23 Sep 2021 14:42:10 -0700
Message-ID: <CAPcyv4j8ro5rQKwbwknH+KTcc_8pGDsL8QwmJyi8fDUZE+G8JA@mail.gmail.com>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 1:56 PM Jane Chu <jane.chu@oracle.com> wrote:
[..]
> > This (AFAICT) has already been done for dax_zero_page_range, so I sense
> > that Dan is trying to save you a bunch of code plumbing work by nudging
> > you towards doing s/dax_clear_poison/dax_zero_page_range/ to this series
> > and then you only need patches 2-3.
>
> Thanks Darrick for the explanation!
> I don't mind to add DM layer support, it sounds straight forward.
> I also like your latest patch and am wondering if the clear_poison API
> is still of value.

No, the discussion about fallocate(...ZEROINIT...) has lead to a
better solution. Instead of making error clearing a silent /
opportunistic side-effect of writes, or trying to define new fallocate
mode, just add a new RWF_CLEAR_HWERROR flag to pwritev2(). This allows
for dax_direct_access() to map the page regardless of poison and
trigger pmem_copy_from_iter() to precisely handle sub-page poison.
