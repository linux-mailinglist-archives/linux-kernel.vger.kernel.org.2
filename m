Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060F2391CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhEZQRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEZQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 12:17:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:16:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id k19so1292196qta.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jYNRg1GwIA2Rxdl8Zes8M188bB2u7RUg8i/4EX7B4yQ=;
        b=KDxB8Jr14ykcOGOG+aWj/pn+Xm6i1yUJde1D4jIFbHXeqR0kUrFDnwMWIHkL3b41T8
         HsSA/U3ynS1oVy4LyFs1TwpmYH0YbZ+OA9E3Zl4jZ8A3xqAwWc1va4h92bV3UOo/EZwR
         1BcA64FxwNvAsclkVYjhjOoXGYkzCKF5XAYw9ZE6smfHbNxNz/b4YbpXfc3FCvG0/IUU
         ud+08HXjlq5kpQTAtiux2KgZEsPtsGzja/koHlvAWZp1d3ZMEYcBUP2VVWy7R+DIzRZi
         Iju5P5f/hijzoLM3H4XFOUASLrSvpTMDP8/KiDMhs3bViY/o83UiLaZ2lPA8cK5X5TrH
         vJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jYNRg1GwIA2Rxdl8Zes8M188bB2u7RUg8i/4EX7B4yQ=;
        b=FjjWgl/aeNJ9m/k+TzQphJhvepcKFSgXzVjHYz4XGG4rZmp69qD1+6chP3rVaogr01
         ALrJZ5P8X9JEyM1HsVeiJKOO3tuMyrT4XqvilI0XLJvhkKqHLn9T3RPgamiEVMk1eFxs
         BVJd7c2rQM3rAKkYtxM5RW6yI+DihreDAKveT+47iPvubBBsC7Rl7zL8ZAHEWTkp4Ljt
         ueR2LKMrIITyMiTZOO3YSqJYPjMyDzGElu3erW/c+L8tOssPWBBAWF7PgkVxniPQs8/M
         H5KpTPwDdZvmYTfsR1JjfXnDBXQb9+tsi4mCLNhEVOWpAuvWCsfyLQR0YB9XImP+ouwv
         i6pg==
X-Gm-Message-State: AOAM5336fP9+/Pn70ti23M6e5BeofJiP9BhI/TPlExXnB94yITrW+bYd
        4X38f0XaEcxe75iP+V89ymoB6Q==
X-Google-Smtp-Source: ABdhPJzx2Ro9C2OTjzb1OPWCtbYPJDXDYha8XrqUduhJfu9BXD8jlj0oTzR1n2HbJlO1azOq931TGQ==
X-Received: by 2002:ac8:4e21:: with SMTP id d1mr37218963qtw.290.1622045768063;
        Wed, 26 May 2021 09:16:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c20sm1793485qtm.52.2021.05.26.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:16:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1llwCU-00FDYi-BH; Wed, 26 May 2021 13:16:06 -0300
Date:   Wed, 26 May 2021 13:16:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v3 8/8] IB/cm: Protect cm_dev, cm_ports and
 mad_agent with kref and lock
Message-ID: <20210526161606.GC1096940@ziepe.ca>
References: <cover.1620720467.git.leonro@nvidia.com>
 <7ca9e316890a3755abadefdd7fe3fc1dc4a1e79f.1620720467.git.leonro@nvidia.com>
 <20210525200057.GA3469742@nvidia.com>
 <3bea531d-ab6d-3990-2014-02c7a4a1679c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bea531d-ab6d-3990-2014-02c7a4a1679c@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:46:47AM +0800, Mark Zhang wrote:
> On 5/26/2021 4:00 AM, Jason Gunthorpe wrote:
> > On Tue, May 11, 2021 at 11:22:12AM +0300, Leon Romanovsky wrote:
> > > @@ -2139,6 +2197,8 @@ static int cm_req_handler(struct cm_work *work)
> > >   		sa_path_set_dmac(&work->path[0],
> > >   				 cm_id_priv->av.ah_attr.roce.dmac);
> > >   	work->path[0].hop_limit = grh->hop_limit;
> > > +
> > > +	cm_destroy_av(&cm_id_priv->av);
> > >   	ret = cm_init_av_by_path(&work->path[0], gid_attr, &cm_id_priv->av);
> > >   	if (ret) {
> > >   		int err;
> > 
> > Why add cm_destroy_av() here? The cm_id_priv was freshly created at
> > the top of this function and hasn't left the stack frame yet?
> > 
> Because it was initialized by cm_init_av_for_response() previously, so
> destroy it here as cm_init_av_by_path() will re-initialize it.

Oh.. ouch, I once tried to re-order this so it wasn't doing such crazy
stuff, but it was too hard.

Please just add a comment the destroy is for the
cm_init_av_for_response

Jason
