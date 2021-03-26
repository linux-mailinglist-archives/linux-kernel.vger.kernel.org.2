Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7054334A679
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhCZLbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:31:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45099 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhCZLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:30:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 40919580BA3;
        Fri, 26 Mar 2021 07:30:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Mar 2021 07:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xx5y3xULQMyR4iFulCz0UbWRwje
        2k/OZeYQ+56KX3/Y=; b=R/szQ5HTaO3CxZDUnakFVbVhJyRnJC6Opms1GL0fyyM
        1XHRHtBPUBMFDd9V5no8Gy07yamxg16N03DZsV26MWDHGd8U8gFsq32O0LDDEkoB
        CYO+4ZQekNm5y3UsPIlXi0sPtwo4h77GfAeHv0lX86ZZpRmEv+rcctNd+nO+LvnV
        jNd0SFfcOEqy8oup0jP8+2IJnvW9RcfPhdRC94mgn1YpgOfJ4CaKDOxi7Ok7UhV3
        PFGcMYe7NByY3AdQFd8pyzlNIO9Jmc6I2ZzH1SCUyNIyvkbkuBhZJ4XbpFpaNFnt
        j9aoR9Bgb1xeoXuALwUowomDfQCAsZwkgC+3nQNXaAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xx5y3x
        ULQMyR4iFulCz0UbWRwje2k/OZeYQ+56KX3/Y=; b=tegfeFMNdbhU9sE8h3KaIK
        +6anmX3Kwi5UEamH3eoKT0K2r+23mSK8AnxxRHS84+JAfdILCrluD7F8qN2+SSVo
        OY5RMnOikVRpCV91PZAz2xDuNrVVI7fwis23I4oRTDTgl98WeKeCGxHq2n62G9Fi
        kfFh2d5si89LQcTBoHqz9fd5BVTsG8mZAXbGvcwsNGzMeB/xn8z/VsSOMWv5trnD
        642xePzwW7TayXCYfYkD8Qs3+YeLLgoPqeRWIbOlYV2HngGd+6WjmHzec1avZ0Na
        K+fY49kjq/38zOazqj+CYIN13cOXvgi6DnlK0W23E5Qoq2ZMwxdfvqVrLShxjmgA
        ==
X-ME-Sender: <xms:0sVdYEYg-4LupUI9nv4wS5h3VKNH2L5JdDsa0VtxJ1ikKNjE1toYsw>
    <xme:0sVdYPa9aSCNVeL7GoudGHuDd7ZAdkBOHwQc7OU_c8BSE94-hpdlMjz4YOsBM9DPS
    hTnTI4WSG4w8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:0sVdYO892Tdzu-mLaRD7G2C7S_c5DG2EUSytBDnT7re1FZGtEY6_5A>
    <xmx:0sVdYOqEW5RF0VkLqnr6hhxr-XmoMHyhmQsYBbdgmNviqW-kmZoA5A>
    <xmx:0sVdYPqXXRT4KBzPFA94J1Hr_7i-BmDGzgokTvh2T6XWJ7V5oPecCA>
    <xmx:1MVdYC20Y3k3SH40AbfEFmNN_JI1tyWmaGpDkyMV_3d5XLZdt6LfuA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 97F1924005D;
        Fri, 26 Mar 2021 07:30:26 -0400 (EDT)
Date:   Fri, 26 Mar 2021 12:30:24 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF3F0JbbEpeSGzW6@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:18:47PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 26, 2021 at 12:05:07PM +0100, Greg KH wrote:
> > On Fri, Mar 26, 2021 at 11:33:58AM +0100, Peter Zijlstra wrote:
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > No changelog text?  :(
> 
> Yeah, didn't really know what to say that the Subject didn't already do.
> 
> > > +/**
> > > + * debugfs_create_str - create a debugfs file that is used to read and write a string value
> > > + * @name: a pointer to a string containing the name of the file to create.
> > > + * @mode: the permission that the file should have
> > > + * @parent: a pointer to the parent dentry for this file.  This should be a
> > > + *          directory dentry if set.  If this parameter is %NULL, then the
> > > + *          file will be created in the root of the debugfs filesystem.
> > > + * @value: a pointer to the variable that the file should read to and write
> > > + *         from.
> > > + *
> > > + * This function creates a file in debugfs with the given name that
> > > + * contains the value of the variable @value.  If the @mode variable is so
> > > + * set, it can be read from, and written to.
> > > + *
> > > + * This function will return a pointer to a dentry if it succeeds.  This
> > > + * pointer must be passed to the debugfs_remove() function when the file is
> > > + * to be removed (no automatic cleanup happens if your module is unloaded,
> > > + * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
> > > + * returned.
> > > + *
> > > + * NOTE: when writing is enabled it will replace the string, string lifetime is
> > > + * assumed to be RCU managed.
> > > + *
> > > + * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
> > > + * be returned.
> > > + */
> > > +struct dentry *debugfs_create_str(const char *name, umode_t mode,
> > > +				   struct dentry *parent, char **value)
> > 
> > Please have this return void, no need for me to have to clean up
> > afterward later on :)
> 
> That would make it inconsistent with debugfs_create_{bool,blob}() from
> which I copiously 'borrowed'.

As mentioned on IRC, I am trying to get rid of the return value, those
are the only 2 holdouts given their current use in some of the cruftier
areas of the kernel at the moment :(

> Also, the return dentry might be useful with debugfs_create_symlink(),
> but you're right in that most other create_file wrappers return void.

Great, change that and limit the size of the string that can be written
and it looks good to me, thanks for adding this.

greg k-h
