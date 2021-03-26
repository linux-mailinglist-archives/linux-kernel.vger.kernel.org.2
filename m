Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5515C34A618
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCZLF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:05:29 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52699 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhCZLFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:05:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 02718580AD5;
        Fri, 26 Mar 2021 07:05:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 26 Mar 2021 07:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=SzmHP+8GotsLvUQDWZjMNH1e8VZ
        PgDxQwrOVdSufO3A=; b=lCslRNplGihx0LQgcWlEJNZoZ3BTOMVBuC76O8dktD8
        sWnV56PT4t0u/M914mJcUNLP2X/B8LMr5jj1jnrjFMd7H+NcqXt8O9JI1MSzSHas
        PHIWw5OHR68vY4edhx5RVJgBUQKy+anlZOoeaNgZ0uM8l024oaMhwZIWAzAVor+R
        NUm9N7KMx8qnDVehz56U5ea1+efJLMI9sfORmSdBz4URpL/rPRmykPfUblLWTPcU
        hFvLAJfgikqz3gVVaIqs3+5R56wenxN9uq6M1ylX8kp+w7fLkZB1MnrFPSqdRIRb
        9N7aXDcEw99mylNRBm7eES7pqtKouYTGhgCj6KBDd+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SzmHP+
        8GotsLvUQDWZjMNH1e8VZPgDxQwrOVdSufO3A=; b=S35IoNPQ7hNaPZYIKN6hwZ
        JgUpsGQOWvPn1/l7IEjWoGc8bJjCJkeo3BpmPMRrDtddTyQ4AMaKY3SVuautAt1z
        XpZHevYJlYFMR31yuZ0RUzfhfjnTUzG26cxuzTH5CveFD7SrOOGdkD3r7LAk6nIX
        AzCWANJ2AqSEDrGmFVMVMYJ+rU8fdaWHcaRI9Rw1cTk+t0eu5ZEFnW5IUYQHDXPo
        Cvl7JqcfNXaPD0OdYDHVAesKaNXnRz8DhLapcMPRtr4z+nv7mfdWRxz/HwVhk9cG
        nlUrPcjHUtqmPExf6msiuBuLjAxFtriuZE9SlLxSiGCmPMC2wngsVEAVG61KbJQw
        ==
X-ME-Sender: <xms:5b9dYKoTIMIn8pcTqqlQOLrKFM5TJn5r6T_pk-upowJY-eaTeAzltg>
    <xme:5b9dYImcgG6goZzKN6eTn7aVyRmYVcn7-jxF2xu9PHjMwkM9O7bjycQSwGtjWi68o
    TN8j-FsQhEUwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:5b9dYMGx1lZtZyLrYbr9UTnkjX-D96v3XwQga6FD_mXnOWNPN3QCGQ>
    <xmx:5b9dYBoCtNqdP3K2MHB_OIL5EsGFF5mG_Z-7Cof_QQAygzZkggKjYA>
    <xmx:5b9dYI5Kf2PN_tou_RM7xc_0oHsVF2f3WWeEBEbgF30exIXi99UlLg>
    <xmx:5r9dYDU83kxtvBiL6xXBZtvrHb_wMzbodpGZ1gZMSFYb0NNTgJZ8Ug>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 20212240069;
        Fri, 26 Mar 2021 07:05:09 -0400 (EDT)
Date:   Fri, 26 Mar 2021 12:05:07 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF2/41K4xs3ZOQdV@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326103935.183934395@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:33:58AM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

No changelog text?  :(

> +/**
> + * debugfs_create_str - create a debugfs file that is used to read and write a string value
> + * @name: a pointer to a string containing the name of the file to create.
> + * @mode: the permission that the file should have
> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is %NULL, then the
> + *          file will be created in the root of the debugfs filesystem.
> + * @value: a pointer to the variable that the file should read to and write
> + *         from.
> + *
> + * This function creates a file in debugfs with the given name that
> + * contains the value of the variable @value.  If the @mode variable is so
> + * set, it can be read from, and written to.
> + *
> + * This function will return a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the debugfs_remove() function when the file is
> + * to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
> + * returned.
> + *
> + * NOTE: when writing is enabled it will replace the string, string lifetime is
> + * assumed to be RCU managed.
> + *
> + * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
> + * be returned.
> + */
> +struct dentry *debugfs_create_str(const char *name, umode_t mode,
> +				   struct dentry *parent, char **value)

Please have this return void, no need for me to have to clean up
afterward later on :)

thanks,

greg k-h
