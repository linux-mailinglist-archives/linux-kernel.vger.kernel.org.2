Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6313979B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhFASH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhFASH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:07:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5661C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:05:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5so167701pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFi+0ZXy3DnUaNTWR7lHK+Jvu+Euee8I+krnOUNTIo8=;
        b=uOhIrF0skcVRYvW/sWyGzJPs4UT01Htakzfx7vc3yQzsMjnKVxV0Wfce9cVPXmlC/s
         z99yd7kpG6/139ktjuDyzt1OHgvrhKn3qsLaVNrdVeBJTH9HNcb6fsV1GuOGc0wtLz1M
         EB79TwLnP4jUMIpAvnHG68rQk0JYYaKPri9zyS9W880HpvcGMYjppN9ooy3hffkEic0B
         odDc9ifCiGlr7scq7BxPOMACHhf0LcEYs3MLh/NL9XBpluljMRzvQaPkF0vD9dxJ9YNq
         80Fs3QV0QhKvkJA/2AzWHtDrweSk6RtCqwgHplNbaBJjDdD7b2JIdOgVKE5i/xVybiyx
         l2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFi+0ZXy3DnUaNTWR7lHK+Jvu+Euee8I+krnOUNTIo8=;
        b=Ki7dAPnX34pp1djKMqVjupykeQRHIlIqL4RffJ6b2f1ZRdgnBlHgVOB2Ghz+7VrZtC
         8f4VaA09XZvEyDy07WB0n0Xst8gX7ba+pE0Q5EX4LOb60UUcujBRsPSA5egXPuzaxYjX
         J4sTQJ4ak/DE6xtyht70IzbiAzCBmFOFxE55fpaZi7SaQ+WkONWNdmPSudekvxpcivHl
         zBNRgZefv+14LnZ68KImaEBbVs/9aIxxASWxxLk6gcadVHM45Jzywxt/zhP4uX9Ruxa9
         Nfd1bDK5jDacEMiPG+3q73TNmwDPwW64+XkutAam/OFiPSso2L3R2JNo0vOBisrQslFK
         h/AA==
X-Gm-Message-State: AOAM5335q0tFSqI/cV7hh4530+1x4AtU6viPV8hf7/mUy5PqC01FvxiX
        oPGbsFfhIvspqxl/gNYviDBS5v1+Zwp5k8G62N41jw==
X-Google-Smtp-Source: ABdhPJwSvmFlvlvBNl2uR19/9PrU1TWWKo+7aepgOx3AgZNM8LBx5JAocjwfD9LASD/WwCHDZM24bSiyHNHt8DTyzRU=
X-Received: by 2002:a17:902:e5ca:b029:109:8857:af7e with SMTP id
 u10-20020a170902e5cab02901098857af7emr1793368plf.82.1622570745134; Tue, 01
 Jun 2021 11:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210528005029.88088-1-almasrymina@google.com>
 <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
 <CAHS8izMCb4Ws46X3xXGcmrvV6J36qsAPTVCA_gdcH65FU0OeUg@mail.gmail.com>
 <20210531173652.c21404a16a8f8542ce40afa8@linux-foundation.org>
 <CAHS8izO_3QivHuGdmY79Jb_-LqOGc5j-_-1C-tf84hXoKdBDTQ@mail.gmail.com>
 <83617ae4-90a1-24d0-a79c-4e259a928e04@oracle.com> <CAHS8izMA-YLz_wMyP15PV45tErN+bCHJ1x_q1vfQTMbkK-=MhA@mail.gmail.com>
In-Reply-To: <CAHS8izMA-YLz_wMyP15PV45tErN+bCHJ1x_q1vfQTMbkK-=MhA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 1 Jun 2021 11:05:34 -0700
Message-ID: <CAHS8izO0br4O=v4g-0yiD0opei7+thmxyDNVQjqVif1rtjVyTg@mail.gmail.com>
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Mina, does this patch depend on changes to restore_reserve_on_error()?
> >
>
> Yes, this patch (and only this patch) depends on your changes for
> complete and correct functionality. I'm not sure what's the impact

...of missing your changes aside from the underflow. The userfaultfd
tests still pass.
