Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB0F34A97D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCZOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:20:30 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44653 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229839AbhCZOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:19:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6FDC8580560;
        Fri, 26 Mar 2021 10:19:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 26 Mar 2021 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Ojyp1WLM5o/GK+X//HQizJc2Rdy
        xFCPxoEAB+T3B2kc=; b=tWNPWeszwKpN+kV+gQCIySeaNis4yOSEGjtvrYnVJ++
        uFs2hFd6PrUEOdqfjOc3KcXC02BrWZZSYqivpbSH6Kenu0Dr9ZZOxalz7YTYUUuJ
        4sW87ZnoPFRYvXQMR9lH6wTHq8xrd1tKnYDIu/PskB+zJVGnPfdpNPFeAgcAdlEi
        ztSAW2yKl//aVaQKCi7KehfSo/bTGM5AnUCFpZHYCjL28BaWK/SKcPIRwp18RVS3
        yrMK1+XMgWM/q5BlaoM+N1ssDLNiVzbPVAaiIo5n2qXWZo2vS1XOoVW9XjmaYqlO
        xLHzvvbdY0/x4tFHkFIpj3GrFesZFXBRW8+PmgaNMrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Ojyp1W
        LM5o/GK+X//HQizJc2RdyxFCPxoEAB+T3B2kc=; b=CiGBGrSHVGHt4ThY+H2cwn
        70AWIx+UnaDKqhpAI+88JKzO5d0ypqgaqr8RPbo2GLot8eBWVQRp6H3c/1MIYtbO
        IQyXmxqQltgv7Rd3sowuzHnK5zpnk4g+Aonz5YsP2ER6Mitt/AtllW0wPlZbi2KW
        iGOlS86nKs6Ed1DzCwCsGwnwnpKF5+oB1IoBjlF98ydZIxIAaYvORBTtfs0xEr2u
        I661DjODtQbvBwO+s010JAXX0BJoLolKZiWWY9Mt50B3bJveYo/5jpKgWRGeUJMV
        lOvej4TJNpecKjun9D8Y7VlL7EZeI6rhYfHTin/jbx28WkQWbfbwZWBlG3y66DSg
        ==
X-ME-Sender: <xms:g-1dYACyRZdEs-M18JJViPH800Ihdy_X2HkPNmNigGAKbXrVv5d1SQ>
    <xme:g-1dYGy_vb9hR6GQPRcAvmfi3_aE0ZFsfxAVb6Y8u3LATn_OuN9Jnbgw6SI4oFXO_
    wyKDfyJY99abQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:g-1dYOl1AP-eUpYtrF7SonXLrBwyx8lI8JTJi18JbEqNfXUJ6Gifgg>
    <xmx:g-1dYLGT7MzQttymsIAQC1MK9-kUv1iFRdmP4oGjw37N7Xp38vQZ0w>
    <xmx:g-1dYOWHK0v87OawNdTP14OT8ACqcfq6WAox6XiawbzOslB_CAak4g>
    <xmx:hO1dYJZr1650SUESLzeTolxS1JGgz2XaP-r3DeOZLuipNvE-aE4zkA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id C6607240057;
        Fri, 26 Mar 2021 10:19:46 -0400 (EDT)
Date:   Fri, 26 Mar 2021 15:19:43 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF3tfxJsJIyGQBD2@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
 <YF3aSJ7OYiCpWsl8@kroah.com>
 <1da9e61c-6973-2e0e-d898-7bf92ac5b1c4@rasmusvillemoes.dk>
 <20210326141235.GI4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326141235.GI4746@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 03:12:35PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 26, 2021 at 02:10:41PM +0100, Rasmus Villemoes wrote:
> > On 26/03/2021 13.57, Greg KH wrote:
> > > On Fri, Mar 26, 2021 at 01:53:59PM +0100, Rasmus Villemoes wrote:
> > >> On 26/03/2021 12.38, Peter Zijlstra wrote:
> > >>
> > >>> Implement debugfs_create_str() to easily display names and such in
> > >>> debugfs.
> > >>
> > >> Patches 7-9 don't seem to add any users of this. What's it for precisely?
> > > 
> > > It's used in patch 7, look close :)
> > 
> > Ah, macrology. But the write capability doesn't seem used, and I (still)
> > fail to see how that could be useful.
> 
> Correct, it isn't used. But I didn't think it would be acceptible to
> not implement the write side. OTOH, if Greg would be okay with it, I can
> change it to:
> 
> ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
>                                size_t count, loff_t *ppos)
> {
>         /* This is really only for read-only strings */
>         return -EINVAL;
> }
> EXPORT_SYMBOL_GPL(debugfs_write_file_str);
> 
> That's certianly simpler.

Fine with me.  Might as well make it static and not exported as well if
you are touching it :)
