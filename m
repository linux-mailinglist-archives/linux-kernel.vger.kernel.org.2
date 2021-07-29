Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27933DA5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhG2OIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238537AbhG2OBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2DFD60F4B;
        Thu, 29 Jul 2021 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627567237;
        bh=zpaHIP0trcuo0pKfQIns0Olh+uBBj4ssUvGd0sEYq6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MklJTt6j1cy+MWLSeVkjK9Vb753BQLTmRSsDJ+cjTnpXHvcuApz+YoHMS9RTO+kdI
         6LdQ6G60UnCRL6SolGgwnIr30H0URTxF3xtYIOkDSYkyX1ZQiWbFbiqQjURYWnb/w/
         TEszwDmuPsyvhlwJPhnl6EEDbtwkOs1Bbo/QZwZc=
Date:   Thu, 29 Jul 2021 15:59:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     qiaoyanbo_310 <qiaoyanbo_310@163.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] kobject: kobject_add_internal cleanup
Message-ID: <YQK0JuI1w1zsEHeC@kroah.com>
References: <20210727143212.39142-1-qiaoyanbo_310@163.com>
 <YQEtJkPFDWMSAd/C@kroah.com>
 <3be7ce57.62f6.17af280a47f.Coremail.qiaoyanbo_310@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3be7ce57.62f6.17af280a47f.Coremail.qiaoyanbo_310@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jul 29, 2021 at 09:42:34PM +0800, qiaoyanbo_310 wrote:
> Hi Greg k-h,
> 
> 
> First at all, there is my mistake about From line different with Sign off line. They all should be "Qiao Yanbo".

Great, please fix that up.

> Secondly, the problem this patch wants to solve is： In this function, the parent variable is first called "kobject_get (kobj->parent) " assignment. When the parent is not null, the just obtained parent is assigned back to "kobj - > parent", which is meaningless. Actually, "kobj->kset->kobj" will be assigned to "kobj->parent" only when the parent is NULL. So this patch solves the problem of meaningless assignment.

Why is this a problem?  What bug is this solving?  Is the code somehow
now faster or smaller that can be measured?

> Finally , I tested this patch and didn't see any additional problems in my environment.
> 
> 
> Here is the original code snippet. I hope you can understand my idea.
> ======================================================= 
>        parent = kobject_get(kobj->parent);
> 
> 
>         /* join kset if set, use it as parent if we do not already have one */
>         if (kobj->kset) {
>                 if (!parent)
>                         parent = kobject_get(&kobj->kset->kobj);
>                 kobj_kset_join(kobj);
>                 kobj->parent = parent;

I do not see a bug with this code, what is wrong with it?

thanks,

greg k-h
