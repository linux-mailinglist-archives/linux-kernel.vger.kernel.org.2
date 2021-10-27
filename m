Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645FA43D09D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbhJ0SXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbhJ0SW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:22:57 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81358C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:20:31 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bj31so3346041qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YdhI8fqzmWGcXeq1t4NkGBwtDfcAf+zoczP4+N0COBM=;
        b=UTMB/+zSl9YaXYKS5BIRPUFlja5Yb/zUUzpmDA3Q6nOQoKY09lCDDzzDyx8Pp/MWRP
         NUY2AUwhZ/rDft1ftVxAnklTJ7lhok4v77RoW45TjuaaJGHIoEXmpKp8FDFttj5rWdTY
         6djh9GLZu1HZceh0sS3yVz2gVbOwe8Lz3vaPVkQ1TV+UsBqd0ePw8IWfrLbX1uuQKEox
         f+6wFrOgLpK5fzd0FP8xD+/nZrYziatzpKvJ9ueINRtteSFGOb44Ym7W2YFl36zKQdrK
         XSusEVPjEfh104pL6Ct7uK580QctaqhsnpqQISSG9diA5WXNUMj3L3XUwIcOqaqbdDmm
         zX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=YdhI8fqzmWGcXeq1t4NkGBwtDfcAf+zoczP4+N0COBM=;
        b=QBL3+qcs4eaxJVFanNuMT1MDf5tIRClRWo8a/W2/MQS+9BSXCl1WdfN70j92BHxgio
         9y1qS2Fr5v2tXA7RJawXcccq9ffW3mpwmlqix++aQEnkPwymYYwwhrA8Frdr4sYP58pF
         M5blIn0orWkcF+bmJGUau0b6j/5aWc6V55Vc6J/wan/y83QkfAq7I7PRRiX2wHCFUa/1
         XLmq1yTKSTk04lKb8l+kMrrJcjq0Msd9XI938fl687DSgZkWPVCmDIBXyvDnHHOmO180
         QzAErSzs38JXP45hpPvolW0L5cb0IlnpAdTdMoNNgPSEGNRbwcwuBY5k7scbclNgh9eT
         pJvw==
X-Gm-Message-State: AOAM532XV2i7J4X7kLhIKDH3xPEh5XKJlQXcFIH2vcTetN6E343vGegj
        o4fkHATltPGwOg1J+UDPDQ==
X-Google-Smtp-Source: ABdhPJxHCbQ5fxTJTcJ15Ko66SwsXysTHrVqW3EAxaWenw0fZN9tHIVGY90nR6tCxWS2qsbTXO0tQQ==
X-Received: by 2002:a05:620a:28c9:: with SMTP id l9mr25620637qkp.360.1635358830392;
        Wed, 27 Oct 2021 11:20:30 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id v17sm468522qkl.123.2021.10.27.11.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:20:29 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ece2:c5c7:8266:ec0b])
        by serve.minyard.net (Postfix) with ESMTPSA id B6F531800B4;
        Wed, 27 Oct 2021 18:20:28 +0000 (UTC)
Date:   Wed, 27 Oct 2021 13:20:27 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Anton Lundin <glance@acc.umu.se>,
        openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <20211027182027.GG2744412@minyard.net>
Reply-To: minyard@acm.org
References: <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
 <20210917131916.GB545073@minyard.net>
 <20210917132648.GG108031@montezuma.acc.umu.se>
 <20210920113802.GC545073@minyard.net>
 <20210920141231.GH108031@montezuma.acc.umu.se>
 <20210920144146.GD545073@minyard.net>
 <YXmTbYhFvDJ0m5KX@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXmTbYhFvDJ0m5KX@sashalap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 01:59:09PM -0400, Sasha Levin wrote:
> On Mon, Sep 20, 2021 at 09:41:46AM -0500, Corey Minyard wrote:
> > On Mon, Sep 20, 2021 at 04:12:31PM +0200, Anton Lundin wrote:
> > > On 20 September, 2021 - Corey Minyard wrote:
> > > 
> > > > Well, that was dumb.  Fix follows...
> > > >
> > > > Thanks for working on this.  On your approval, I'll send this to Linus.
> > > 
> > > Winner winner chicken dinner!
> > > 
> > > This fixes the issue, and now panic timer works, and we get crashdumps
> > > to pstore.
> > > 
> > > Great job, I approve!
> > > 
> > > 
> > > Thanks for your help getting this fixed.
> > 
> > Thanks for reporting this.  I'll get the patch in.
> 
> Hey Corey,
> 
> Just checking in to see if this patch was lost; I haven't seen it in
> Linus's tree just yet.

I generally wait until the merge window for changes.  It's too late in
the process for a patch now unless it's really critical.

rc7 is out now, the merge window should be opening soon.

-corey
