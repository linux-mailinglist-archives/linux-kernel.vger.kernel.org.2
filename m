Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E190B45330B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhKPNpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbhKPNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:43:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39226C061202
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:40:34 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id k23so15257991lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+FEq82V2Ati9BWafFEkvVC0O1aepuH40jBFeghk4akM=;
        b=hyDKJ9zoDbLblqG+fQWpSPWpvaTJB87oOi3tr6g18vG+LyrxJR5OFivVAV6X2oiAkw
         r6EoMqrFke1KGyuvXhjL4OPUFr+CAy4r1+AW+HseHXilRKaza1KGA8wueWIjC9mOO5H/
         XMTW6LfBl9Ewp5TmYkL+phXv6j6c3NCzyTMgDKn0fcspA/B7SJWKAlCUKirJ8lQxKNsv
         LE5eg86Rou9mNC/Dqkio+VclcbTWa0uluAFrUsx/NKWcq8oxbQs9JsrJBibRNvtkOzlD
         H9MyCnoK3dXOkoxJbM2mpAf+iuUHXYN9Ohq2W3aR4GV2/hA25QZ12kr39IeIs+B6Vyc3
         Azlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+FEq82V2Ati9BWafFEkvVC0O1aepuH40jBFeghk4akM=;
        b=GG6sZM1Km+YbYfZbKbznvYrZ+lc2e/OGoVlMEoZ28d2+ppXwc/IP8nIuZBbJC6WoJX
         u8rp7Gg19iiU4q0rg1mNzpTenjLcVLhf7bjv9BvObIPfnqbfAAioSekSQXOfYWhNQvjo
         mdk6vLdToumk7lZwMtdSvvA9Cn8rUFOCtuUHWsLVqcpUhItrLBZsEetd1K+XWaw8ZgnV
         5502asJd2a6K3l3ZkldAc9j7aWl/3P6utrJrZ6tTrHhIbUTMABJq9ntAbhNIiHrLFM13
         4l1O+4ZX3Ug3b57ZzRNmIePyog+WAygaFhpb+asVD41x7TgXZ+bcauAAXs2eyhNn2x21
         tcGw==
X-Gm-Message-State: AOAM531cQ9+ceRij6y3s5gNkpR+zeqEoSYSZNPryUZVDsSJ4RYWRokCJ
        DxjoqF6r9lT5DfnYUjQXWUY6d5YURT9XFtAd5Q8xWnwH
X-Google-Smtp-Source: ABdhPJxzSFRMCP4dxIgbsXaBMt+egBZHsy6bGL+1pBb7HNivUaebvG2JC/ji3SX6KlckqW3mgOBkSqhyOyUkaIlps1U=
X-Received: by 2002:a2e:9dc8:: with SMTP id x8mr7175519ljj.502.1637070032413;
 Tue, 16 Nov 2021 05:40:32 -0800 (PST)
MIME-Version: 1.0
References: <202111120534.jZEya5QR-lkp@intel.com> <CA+_ehUyjDVdEe=64WbBihqSQrHeKSHx_8C3pcHctgvWy4dvnJQ@mail.gmail.com>
 <20211116063058.GH27562@kadam> <CA+_ehUwbUYc6GBGx1VFfqknWrFTk=Xm7NmMUhbyxMSBE4KdnjQ@mail.gmail.com>
 <20211116133720.GI27562@kadam>
In-Reply-To: <20211116133720.GI27562@kadam>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Tue, 16 Nov 2021 14:40:21 +0100
Message-ID: <CA+_ehUxQrbMVMgH2wGt5GBAsutN3OWGgOUH_6BpC8_NnN-syKg@mail.gmail.com>
Subject: Re: drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error:
 testing array offset 'cpu_port_index' after use.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Tue, Nov 16, 2021 at 02:30:59PM +0100, Ansuel Smith wrote:
> > > On Mon, Nov 15, 2021 at 07:08:30PM +0100, Ansuel Smith wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
> > > > > head:   debe436e77c72fcee804fb867f275e6d31aa999c
> > > > > commit: 5654ec78dd7e64b1e04777b24007344329e6a63b net: dsa: qca8k: rework rgmii delay logic and scan for cpu port 6
> > > > > config: i386-randconfig-m021-20211025 (attached as .config)
> > > > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > >
> > > >
> > > > This should already be fixed by 06dd34a628ae5b6a839b757e746de165d6789ca8
> > > > Can you confirm this?
> > > >
> > >
> > > No, it doesn't fix the problem.  The check is either useless and should
> > > be removed or there is an out of bounds bug.  Checking for an out of
> > > bounds *after* you've already written to the memory is *never* useful.
> > >
> > > regards,
> > > dan carpenter
> > >
> >
> > Again sorry if I insist and I'm 99% missing something.
> > There was an out of bounds bug.
> > It was fixed by 06dd34a628ae5b6a839b757e746de165d6789ca8 by
> > starting the counter to -1.
> > The extra check is useless, yes.
>
> Then just delete it.  We don't want code which is illogical even if it
> has no effect on run time.
>
> regards,
> dan carpenter
>

Ok, will include this in the next series with your reported-by tag.
