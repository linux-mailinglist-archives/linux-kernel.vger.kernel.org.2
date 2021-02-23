Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CEB32255C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhBWF1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230458AbhBWF1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614057973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JP8BZNEYe8HK8zjKUD5vM6SEeD44TdAOAL+tQOP8FIY=;
        b=TWcKU4S/2KST+PG3yMZeb0AN3eq0myI+Gbrbz+guxwvtM0JyuYJZcQcpQewQ0LQbhR9ZpU
        CmI3GD5cPtoXOne1ubwRXoNPkxJnbu2C84NuwwafrAq+VRgrE8Clez5QytSdR3UTxky4hb
        7rlurYc7lpbP25Vddw6lvudvEuII99I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-dj9-w5sWP8-4megHNxI78w-1; Tue, 23 Feb 2021 00:26:11 -0500
X-MC-Unique: dj9-w5sWP8-4megHNxI78w-1
Received: by mail-pl1-f199.google.com with SMTP id w10so9448393plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 21:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JP8BZNEYe8HK8zjKUD5vM6SEeD44TdAOAL+tQOP8FIY=;
        b=lKdBDM9igk/YSCBWdD2vrcK4uT3oTCXjkPUKAaS5ydFHQZ1HmiLCOJTm92vapIPwaP
         pCZRbscWKoYHEVkdn/s8qLN8nNrUoddYgyAJqplXQ6dSQpqUr/bXXwedlZj62X4vy3Wp
         tbijLdTLpTvDVh0ioyB0tg/YSz3Hn3UXz0HEDCvnf5a86gHqTnUUzc4eZc9OuY4dO35C
         QByoX+pjvmv2Nugceh5gdZhLyUzXtkqYNoHU6y06U7imr5yXxhnn33Uw513kwiD2bbs2
         h3y2rQnCBxqz161eT3M3lvj/zDZ/uwJgTTVcNxJgMaz1WbaPd/MrBYZyIrVx+XVCfys0
         p5Ug==
X-Gm-Message-State: AOAM5339+3351ufynel4Guwb+3OzrxBTngZZKCFQNbkoPM6fESX7s9Ny
        akcC4T7YL+iD1JFZN81HrktxoMe/1cs1CI1qvZWjoyRTD7QyQn6lrqTclLT+hTMfCqmBn7AEjBJ
        01mNcdnJbi+6ZAHb7uZTqUVaE
X-Received: by 2002:a17:90a:b016:: with SMTP id x22mr3207269pjq.161.1614057969936;
        Mon, 22 Feb 2021 21:26:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpnt3C/L6BzHK8iud/yFdLHTq9zLeWs7YlwD0343Bs/iKI/BS4iGOoGOYKvtl/84R4ksqqoQ==
X-Received: by 2002:a17:90a:b016:: with SMTP id x22mr3207238pjq.161.1614057969564;
        Mon, 22 Feb 2021 21:26:09 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o189sm21216324pfd.73.2021.02.22.21.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 21:26:08 -0800 (PST)
Date:   Tue, 23 Feb 2021 13:25:58 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH v2] erofs: support adjust lz4 history window size
Message-ID: <20210223052558.GC1225203@xiangao.remote.csb>
References: <20210223043634.36807-1-huangjianan@oppo.com>
 <20210223051926.GB1225203@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223051926.GB1225203@xiangao.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cont. the previous reply)

On Tue, Feb 23, 2021 at 01:19:26PM +0800, Gao Xiang wrote:

...

> > +	__le16 lz4_max_distance;	/* lz4 max distance */

unneeded comment.

> > +	__u8 reserved2[42];
> >  };
> >  
> >  /*
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 67a7ec945686..7457710a763a 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -70,6 +70,9 @@ struct erofs_sb_info {
> >  
> >  	/* pseudo inode to manage cached pages */
> >  	struct inode *managed_cache;
> > +
> > +	/* lz4 max distance pages */
> > +	u16 lz4_max_distance_pages;

useless comment as well... maybe we could add some descriptive
words, e.g.

/* # of pages needed for EROFS lz4 rolling decompression */

Thanks,
Gao Xiang

