Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07883376A85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhEGTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:10:51 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:38441 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhEGTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:09:07 -0400
Received: by mail-io1-f46.google.com with SMTP id t3so8896182iol.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 12:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5E2YSP3NYcynyofXZdzGROLm20IiDiHBcvrV+16RiU=;
        b=UUrLjAlBbtwowDv1elXLAyUyw5gs13b6wFrjh8uIJXVrvRn+sop7Ez8akRViF+MoGS
         Uk6s3t6CfgY28JLdSEbz8LaFR224O6JMj502D+0OcxJ1/qJuvHW1W/t68tOXBL5kBtcG
         83deIhx8WXFDrfhD/ZAm5mqlEdRRC/IJ+3C87kfSVWbsAwkfhjU0JdXaXroj0TivtN8/
         OSJvGAOFSnXDS0AgRuLpdTDa82A6ybKU5UVqs9Mj9M/voTcSxhaA3tkSgCAy2AShTC7A
         96E5ZfJv89WD+vW7sQ1Zt08/UxuND2O9B7K/0EjeElPwwUpkCdoKZsGCJ/5JNJRV+v+C
         Z7og==
X-Gm-Message-State: AOAM532QnirtYiS/d3fWaUuc5+3DaazLcWUdxq4iaziNN7fyjFg/fbDP
        GdA3A9lOFz1rDYWjFlzcneQ=
X-Google-Smtp-Source: ABdhPJz/PEGgKCTtwBn+SohYZtyyyVYhK5giMROF3zHxpMnHV8j/Wf7A4ie8MiKlGcw5N/vYunFd9w==
X-Received: by 2002:a05:6602:1641:: with SMTP id y1mr8694414iow.54.1620414485520;
        Fri, 07 May 2021 12:08:05 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id f11sm2704647iov.9.2021.05.07.12.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 12:08:05 -0700 (PDT)
Date:   Fri, 7 May 2021 19:08:03 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>, Roman Gushchin <guro@fb.com>
Cc:     Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <YJWQE8AFjyYpsLYA@google.com>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
 <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 10:52:22AM -0700, Roman Gushchin wrote:
> On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> > hi Roman,
> >  
> > On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > > Ping
> > 
> > sorry for late.
> > 
> > the new patch makes the performance a little better but still has
> > 1.9% regression comparing to
> > f183324133 ("percpu: implement partial chunk depopulation")
> 
> Hi Oliver!
> 
> Thank you for testing it!
> 
> Btw, can you, please, confirm that the regression is coming specifically
> from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
> I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
> I can confirm it.
> 
> Thanks!

Thanks Oliver and Roman. If this is the case, I'll drop the final patch
and just merge up to f183324133 ("percpu: implement partial chunk
depopulation") into for-next as this is v5.14 anyway.

Oliver, is there a way to trigger the kernel test robot for a specific
test?

Thanks,
Dennis
