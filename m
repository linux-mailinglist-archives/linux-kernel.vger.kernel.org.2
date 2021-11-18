Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6747B456098
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhKRQiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhKRQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:38:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:35:19 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v19so5705148plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kP0hx1OcM5O8o/kwtldiOzwNdk5DdGgp+8/2TcOqIyQ=;
        b=JGSflI+3rOTpA3oPDZxSyPUVosNxSit5rAG7OVZ2kkUpeSmxkeMzQnaGxILsTDhKOb
         pu9sz76ZKZq1kTy+bTECIa8jsvtnsIiEbDGXGdwLSLNDxe+1gzE8rN4moncjeLw8fZhG
         3w2p+vmVPrv1AA6y5gaL3i7o47+38iyc/Kuqy+nOav4MKtAtcpepS77bs/TNl/NL53ca
         jL3h5gVdcvWg3QVow4jcjlogvGrOcXnEI3yoBdcttM84Y6bJNNFNKmGmQpE5fYWF35H3
         /ZZhYoXiR0kPvf0o4suM5g4IRnIydFiIZGU64uuLxMHhs8BNjMCqTxDZPHBUKdjwVWZG
         zRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kP0hx1OcM5O8o/kwtldiOzwNdk5DdGgp+8/2TcOqIyQ=;
        b=hrMjnA4JUxjTovGfF25IH2pb+lk+pMMLn5xDDjoyNrI4Vk6NNHbmcIt6w3w1lybTVn
         4DPquyxXTtypZ3yWXAv6VGnTSnB5VgElOiMwL2kJmRpsbB3T/+2tZyDmiiZm+xq5gBJk
         oLyHydPE3pEwlt2OaVeVhHgACq43stTuT7tGCJfoDwjrIXi3vYa7MoygYa9OU1PiwkCb
         FM96VB+fV+89mplIjFOgs8Oul9z8Wn3KB8yAdnGDMQOnpIdepDD/OBmveMtzlXKvn7Bj
         Ji6q5LJwdP6Rp3AkCt3i1oqMKEaXYNFgRpjQi6f0DdkCxuEKxUNHtxMYJCLzuke6pjYG
         AkWg==
X-Gm-Message-State: AOAM533Q9XVpMJJVmRGuGk/amCJRK0KVrWtPja2w1NvSxPmZ4pxczPXl
        /L7T+4ZQvv1bSKu+eb+tqjc/1iVMQgwP5Q==
X-Google-Smtp-Source: ABdhPJxneOCmqVlNKk/4g5supBCkm42zgjxdzbS3ZjwYXhSiSZitgqppkOv+4+2+Pn8PETslcZRJsg==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr12164567pjh.121.1637253319308;
        Thu, 18 Nov 2021 08:35:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s15sm131622pjs.51.2021.11.18.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:35:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 18 Nov 2021 06:35:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZaAxQQ+7hckBLXb@slm.duckdns.org>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
 <YZSu/HiHDZxo9Wpa@google.com>
 <YZV4CtJnH+ngOcxi@slm.duckdns.org>
 <YZV+j5LivK+9Dt50@google.com>
 <YZWA+8B1xQOKCMnS@slm.duckdns.org>
 <YZWylT2SuN+N2Z2K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZWylT2SuN+N2Z2K@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:55:33PM -0800, Minchan Kim wrote:
> > Ah, right, kernfs_node doesn't point back to kernfs_root. I guess it can go
> > one of three ways:
> 
> Thanks for the suggestion, Tejun.
> 
> I found kernfs_root and it seems like to return kernfs_root from kernfs_node.
> If it's true all the case, we would put the rwsem in kernfs_root and change
> would be straightforward. Do you see any problem?

Ah, you're right. I forgot that directory kernfs_node always points to the
root so we need at most one walk up the tree to locate kernfs_root. Yeah,
that should definitely work.

Thanks.

-- 
tejun
