Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6939EA8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFHAHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:07:05 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42826 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFHAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:07:03 -0400
Received: by mail-lf1-f42.google.com with SMTP id j2so1549911lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVKbiDIN2MfekWjoHre79gWLQRZhwkyxE2UhNz45/7I=;
        b=KnKO4m+BddcWC0wrvU/X+NoUd3QKXopDULOk5wAGHrRFESYeMk3V5lDVL8lf5L4kqh
         hXX7Rf+Q6NDaRTut2ZMD13GgJJBe7yoHIjTYWw0ZbWWyktxHNptIjhEmKexkZfmJnROh
         ilKxZXzeg2u2O78bANi5mXNK9sVdx2iYfOGVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVKbiDIN2MfekWjoHre79gWLQRZhwkyxE2UhNz45/7I=;
        b=PlcAHbIRXJ+r36YocfjsxM/YheNyyN6LKbIlwlj5B+WLa8Em6EShfqMMzORSa3RZD4
         /g/su/Psc2XXglnzb8FA6YdVszKUd6SAnQF3edE8EH9vr/QjBJx0E/fsIujolqDuAVK0
         tbJxeC3PQafSVfd/a/oOz1wKi2i3JSX6vo8oGcRVu/5wQGgCBXRVFxVhmJIGxO3hj3o7
         nCMlYfoSUBwgu1fZkAbPicaIcaSL8xaklKTGGmzzsiPcVmOLVnr8nWGRJ58oESXMd4tk
         sNOYk8kCn6dENUCWqPISRCgN2RmBwvUnVpFlp2kuSxkQaFFjzs2MHmKVU42ipSKqvp1+
         ACrg==
X-Gm-Message-State: AOAM53355kGI+D8z73NOUm9mhrS8lQw9T9MQm5dhxelr3jNWoRN9FuVH
        bGREw7+sHx3yye3BV0twnHEfvM129+u0NxZEYdw=
X-Google-Smtp-Source: ABdhPJzZBzUP/LvJQPXIFIUKjbnLAV7vqkNBHZEpMOjy33j4bUBjteCgDdoHDF9X06PVFtx026XwdA==
X-Received: by 2002:a05:6512:234c:: with SMTP id p12mr13213974lfu.240.1623110650094;
        Mon, 07 Jun 2021 17:04:10 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r9sm1482748lfm.158.2021.06.07.17.04.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 17:04:09 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n12so22147742lft.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 17:04:09 -0700 (PDT)
X-Received: by 2002:a05:6512:987:: with SMTP id w7mr13363285lft.41.1623110649005;
 Mon, 07 Jun 2021 17:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210525031636.GB7744@xsang-OptiPlex-9020> <CAHk-=whTEC_GVYu=WfvUagNvHdoTALEDg8uqK3V6aMDwg2KMRA@mail.gmail.com>
 <20210604070411.GA8221@shbuild999.sh.intel.com> <20210604075220.GA40621@shbuild999.sh.intel.com>
 <CAHk-=wg=LX1WKioiA_Cn-5hp6Hce_kTZg23uksSjNWgV_Ofj1Q@mail.gmail.com>
 <20210606101623.GA48020@shbuild999.sh.intel.com> <CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com>
 <20210607060551.GB48020@shbuild999.sh.intel.com>
In-Reply-To: <20210607060551.GB48020@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jun 2021 17:03:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbjjqHtyd1O7uEGKg5nZCGQwOBxNmWpuWJ8h04FELLpQ@mail.gmail.com>
Message-ID: <CAHk-=wjbjjqHtyd1O7uEGKg5nZCGQwOBxNmWpuWJ8h04FELLpQ@mail.gmail.com>
Subject: Re: [mm/gup] 57efa1fe59: will-it-scale.per_thread_ops -9.2% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 11:06 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Please review the updated patch, thanks

Looks good to me. Thanks,

               Linus
