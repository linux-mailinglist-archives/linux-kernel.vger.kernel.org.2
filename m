Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0C40EA85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbhIPTD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345720AbhIPTDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:03:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E99C0AF65D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:35:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g14so6797376pfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KmKz/oKKvyTAXz0Cud+ADkHJcZLLdaDQdhsrhOzh7Y8=;
        b=S1hCQ1gqH7tTeoSKb3urUcgEEyWyDk6pc8xfNQY0y3Ls/MdvNEri6/3gHFt/COJPaI
         lv72wuqi7Hfjk7beqOFWzoEyOGhWxb059bujhtFF/kDsIm+o+P4OxcNZKmdPFDq3hJjL
         sTDHOUOLRdOXGjAs7EhzTkA8KP+PThCn/GF/4LCFo2UmEiys7bpu4GJRir86Q9FcpeLS
         b6D7iYMVMprHpCmY9KFcaJQD7Zg7U0+cJ5HMUD/5UZi5/Fg2GttK/tifCGuZbc6zwRMe
         sZj0f7tJygaEyKlwAd9W9Z7aTh7FkL8fI0iTcxQYbRIdxAmHo9KKB42jO9O6KEs6dDo4
         rqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KmKz/oKKvyTAXz0Cud+ADkHJcZLLdaDQdhsrhOzh7Y8=;
        b=gfM3P4LcvW9BCXS3OAHozv4QofyRvQJ34CCKKMU3hiu0pEcrDEAjQOZdBKaKiCPbC9
         17SNGbBD+e3HZ1IjMtzRZOnlCi/6f4foRPd1pMOzP/g+POy7QYNCQoCvfjEnqnv0Yf00
         p0B3nUe/uvyfRLorhibuxbOHWNtFw5eXlaXxoNVUHn16zSl2anR4qJ9hbDO5S+5VxwdH
         b3HDC1xrYusHaXPiDnDgzQgIkM7MeJAxbX1z99/sui+6BMCxrkYKp58E0bQxyTXKkg3u
         PvJiQySY+9OpZ2Vow2BEUwM8+AJc9ymYp33NniS/5f/UcEnTQNdOeA3Bnga9H/hUqyqQ
         uzAA==
X-Gm-Message-State: AOAM530nL9CveH/OhSZ+73x8mGZ+goI8+nKnllalcNIZOZNI0DEGUBog
        6fcHa1O/jNCIxGLy6NG06W/+zg==
X-Google-Smtp-Source: ABdhPJwChbS/ly5G8J0Juxyfxa+sZ1KjB0vKVlICTLq8mRuXtIasctAIdmn9sJAOq488HaeMyze+jg==
X-Received: by 2002:a62:1ad6:0:b0:440:3aef:46b7 with SMTP id a205-20020a621ad6000000b004403aef46b7mr6386273pfa.86.1631817321559;
        Thu, 16 Sep 2021 11:35:21 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t2sm8430584pje.5.2021.09.16.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:35:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQwEA-001qpc-Lm; Thu, 16 Sep 2021 15:35:18 -0300
Date:   Thu, 16 Sep 2021 15:35:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
Message-ID: <20210916183518.GR3544071@ziepe.ca>
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
 <20210413133359.GG227011@ziepe.ca>
 <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
 <20210413134458.GI227011@ziepe.ca>
 <CACkBjsY-CNzO74XGo0uJrcaZTubC+Yw9Sg1bNNi+evUOGaZTCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsY-CNzO74XGo0uJrcaZTubC+Yw9Sg1bNNi+evUOGaZTCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:19:25PM +0800, Hao Sun wrote:
> Jason Gunthorpe <jgg@ziepe.ca> 于2021年4月13日周二 下午9:45写道：
> >
> > On Tue, Apr 13, 2021 at 09:42:43PM +0800, Hao Sun wrote:
> > > Jason Gunthorpe <jgg@ziepe.ca> 于2021年4月13日周二 下午9:34写道：
> > > >
> > > > On Tue, Apr 13, 2021 at 11:36:41AM +0800, Hao Sun wrote:
> > > > > Hi
> > > > >
> > > > > When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
> > > > > the Linux kernel, I found two use-after-free bugs which have been
> > > > > reported a long time ago by Syzbot.
> > > > > Although the corresponding patches have been merged into upstream,
> > > > > these two bugs can still be triggered easily.
> > > > > The original information about Syzbot report can be found here:
> > > > > https://syzkaller.appspot.com/bug?id=8dc0bcd9dd6ec915ba10b3354740eb420884acaa
> > > > > https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
> > > >
> > > > Then why hasn't syzbot seen this in a year's time? Seems strange
> > > >
> > >
> > > Seems strange to me too, but the fact is that the reproduction program
> > > in attachment can trigger these two bugs quickly.
> >
> > Do you have this in the C format?
> >
> 
> Just tried to use syz-prog2c to convert the repro-prog to C format.
> The repro program of  rdma_listen was successfully reproduced
> (uploaded in attachment), the other one failed. it looks like
> syz-prog2c may not be able to do the equivalent conversion.
> You can use syz-execprog to execute the reprogram directly, this
> method can reproduce both crashes, I have tried it.

Can you check this patch that should solve it?

https://patchwork.kernel.org/project/linux-rdma/patch/0-v1-9fbb33f5e201+2a-cma_listen_jgg@nvidia.com/

Thanks,
Jason
