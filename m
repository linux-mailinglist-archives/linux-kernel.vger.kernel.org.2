Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901253BA99C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGCRAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 13:00:07 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:39596 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGCRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 13:00:06 -0400
Received: by mail-io1-f52.google.com with SMTP id y76so15710977iof.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 09:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6lHywLk8e8ZkMny6eUW/z6wvfFZ8vT2gzj9AFlMJnA=;
        b=H222JtpVNMXI1BRlO+A1X7neDDoXlNHYmzpYmRkGnaaLMQMase5t1qr1e8i4Kzwdvc
         YECNXBycHvNgj7gqwos4k8oJZhYgUbshQBpDGo+9hcZ71dtLGRQT2BJAl8NYglmg1ia6
         //fL+DIqwnElg6wS8welLEDCRBJkDI53s2JjguLip6QHkiSpPEqYsWLnpnENFCTCByBT
         WQxRPcmuKxTS+Nh8HSnMmih7eE4rVRV0lkRImdvBqB8ujhzoVydytzhW9KD9wv62+2Na
         gPfCAj7sOFua3dZJuPu4cnLOd4MN929Fu58LRX0MnHBEzHMKaZMkk9/oKuIF1TQpy3mb
         8cDQ==
X-Gm-Message-State: AOAM532AKuhCi16Ca397wdL2NglNvG9veW6v9BOEWK+JMYCF5SA+6Yot
        EoWPl+rQuVQ9hWxsvtQaxn8=
X-Google-Smtp-Source: ABdhPJwhHhcj4JJjokzk5P7q5Iqr3l3KZQZr2baFkVVragIyyVeD9Zy9MqlBP6hg1lhakzXXXKzPJw==
X-Received: by 2002:a6b:f704:: with SMTP id k4mr4755459iog.191.1625331452666;
        Sat, 03 Jul 2021 09:57:32 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id h4sm869298ilr.58.2021.07.03.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 09:57:32 -0700 (PDT)
Date:   Sat, 3 Jul 2021 16:57:30 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: flush tlb after pcpu_depopulate_chunk()
Message-ID: <YOCW+pbXt5laJF8v@google.com>
References: <20210703051444.GA3786429@roeck-us.net>
 <YN/0rmO0p6IJcImj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN/0rmO0p6IJcImj@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2021 at 05:25:02AM +0000, Dennis Zhou wrote:
> On Fri, Jul 02, 2021 at 10:14:44PM -0700, Guenter Roeck wrote:
> > On Sat, Jul 03, 2021 at 04:04:49AM +0000, Dennis Zhou wrote:
> > > Prior to "percpu: implement partial chunk depopulation",
> > > pcpu_depopulate_chunk() was called only on the destruction path. This
> > > meant the virtual address range was on its way back to vmalloc which
> > > will handle flushing the tlbs for us.
> > > 
> > > However, now that we call pcpu_depopulate_chunk() during the active
> > > lifecycle of a chunk, we need to flush the tlb as well otherwise we can
> > > end up accessing the wrong page through an invalid tlb mapping.
> > > 
> > > This was reported in [1].
> > > 
> > > [1] https://lore.kernel.org/lkml/20210702191140.GA3166599@roeck-us.net/
> > > 
> > > Fixes: f183324133ea ("percpu: implement partial chunk depopulation")
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > 
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Thanks!
> > Guenter
> >
> 
> I updated the tag and have applied this to for-5.14-fixes so it can get
> some for-next exposure before I send a fix to Linus.
> 
> Thanks for setting up the super easy repro! It made debugging this
> significantly easier.
> 

I'm pulling this because I think I'll need to do some aggregation to
make this less expensive. I'll send some variant soon hopefully.

Thanks,
Dennis
