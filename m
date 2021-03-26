Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347A234A7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCZM5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:57:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55481 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhCZM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:57:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4DC1D5804CA;
        Fri, 26 Mar 2021 08:57:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 26 Mar 2021 08:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=tDYuafVYEzotN+2vMul5COe5EcS
        87TpGB9aummOXYV8=; b=h2oKxvgr9laxdc6WSUEZGupC6smSNtj8vkG+62cTxMC
        PYP5RwYS+JX62aqsS0Uwl+KDsBZ6N7WpJ3Vjgx1sW5ga7EOruaG9ME0DotQT0kQA
        6MO+Z9n14QXTibo03Uzb7NH2JyZKizzaVR9zkscRK4vyZlmDuXylsweRJOSxR/qV
        7LHiJF/K3jV7xHWJEigYXPClD+4Z5jZoDIM25XzmedjRBFOYVqxEPHdIoBxEkaBW
        ZCIn3Db9G+W0Gx9CimxUpg1R9yn9fCBVU0w2L5qIAlTK/NimSMplh+tB2091fS+0
        jSGNI+lxBvae0WZjmP9GaA65d/5qzHAIcH8YAk5hg9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tDYuaf
        VYEzotN+2vMul5COe5EcS87TpGB9aummOXYV8=; b=bmhi/2oGUO0sBs5evczbrb
        ZUpXQJ/LS7i63jECJ6HMeJnguaS1flH3wsynEY9KpFvrrh3ZMbs2ANh8EsW9fFFY
        LTTV4mLRelk8NC/Z36plMScrOPIIiG8SZ5q+HOE5Wn6I46JD+Y3pHoULewIQ8IFp
        n1P8lqLIIy2F7Ca1yeLBlUg0G7iyNNShoys3lLz5v0tYDdSEKcqw/9Ueot1bhl/y
        lgor+riovM1V9r9s+i6KiovB+17380DxalSzkjKB+x0j9tmnLEpsP6kjzPYaEeBY
        0qSk1rHAYBTGHCoc6vWIPEA3Oc64XCSVWa0ouYH7PElsO+lKGUbumbN8N5I1Vd/Q
        ==
X-ME-Sender: <xms:S9pdYFoJxj24l_lI-f_nkhFeHEROIkWvi9zpHF5VdjWmz7WzZ6KJAw>
    <xme:S9pdYPQyi1gvDraMNTiFFU3Alngo80nEVdB8PTkQLgogdgi6iT9tXSNas0kzC7o5i
    Y8x2XsaeVGqsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:S9pdYP3kZOJqgVU1itULwhkwloqyOVDLyciM5IM0Bgq6Gx6Rrsiw2w>
    <xmx:S9pdYLCLeR1BherHoFdkFHe-bBOm8OzNFGKnDMcDvgHI6iMw7rx-TA>
    <xmx:S9pdYLi3aZsuLTErWxPYpjTKy8RNVKm5vPIH1TrhJciwD55H93JoEw>
    <xmx:TdpdYN9K4VlrubDVQiM8PpB13qWWiq_1gKeK42i_s3Pewzlthl6weA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5531124005D;
        Fri, 26 Mar 2021 08:57:47 -0400 (EDT)
Date:   Fri, 26 Mar 2021 13:57:44 +0100
From:   Greg KH <greg@kroah.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF3aSJ7OYiCpWsl8@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
 <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
 <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70594935-18e6-0791-52f9-0448adf37155@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:53:59PM +0100, Rasmus Villemoes wrote:
> On 26/03/2021 12.38, Peter Zijlstra wrote:
> 
> > Implement debugfs_create_str() to easily display names and such in
> > debugfs.
> 
> Patches 7-9 don't seem to add any users of this. What's it for precisely?

It's used in patch 7, look close :)


> 
> > +
> > +again:
> > +	rcu_read_lock();
> > +	str = rcu_dereference(*(char **)file->private_data);
> > +	len = strlen(str) + 1;
> > +
> > +	if (!copy || copy_len < len) {
> > +		rcu_read_unlock();
> > +		kfree(copy);
> > +		copy = kmalloc(len + 1, GFP_KERNEL);
> > +		if (!copy) {
> > +			debugfs_file_put(dentry);
> > +			return -ENOMEM;
> > +		}
> > +		copy_len = len;
> > +		goto again;
> > +	}
> > +
> > +	strncpy(copy, str, len);
> > +	copy[len] = '\n';
> > +	copy[len+1] = '\0';
> > +	rcu_read_unlock();
> 
> As noted (accidentally off-list), this is broken. I think you want this
> on top
> 
> - len = strlen(str) + 1;
> + len = strlen(str);
> 
> - strncpy(copy, str, len);
> + memcpy(copy, str, len);
>   copy[len] = '\n';
> - copy[len+1] = '\0';
> 
> > +EXPORT_SYMBOL_GPL(debugfs_read_file_str);
> 
> Why?

Because there is a user of it?  Yes, it's not in a module, but to make
it easy, might as well export it now.

thanks,

greg k-h
