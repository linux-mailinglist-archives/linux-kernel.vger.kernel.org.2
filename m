Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413E23305EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhCHCho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232272AbhCHChK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615171027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tv+IGQw5DDfzRJXz4JnZH5Nwua0J/9SIbyygH+7TcgA=;
        b=SS/9Eb/iXYZoJ/HMm7vTldQeR8KyIsqMea1xWrvWR9rGGw3/tETCYTNI32QqUyiw/2Oi3s
        sXk8UMnGGIrq3qcvHj5+KB8orGRjks+aI7Ox+6s/Dk8G+t4dELM5W03EDGdPNVb4V9DyUa
        I5+sGHnIFKNPUynICuJuNO7YePSo9iE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-A6j__CdJOyK8xq1nZhlSsw-1; Sun, 07 Mar 2021 21:37:03 -0500
X-MC-Unique: A6j__CdJOyK8xq1nZhlSsw-1
Received: by mail-pj1-f70.google.com with SMTP id p18so1462267pjo.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 18:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tv+IGQw5DDfzRJXz4JnZH5Nwua0J/9SIbyygH+7TcgA=;
        b=ALjjcz2wca3b9Z91JFdVCvYLDARxQCmeHWkLLZV78TS7qB+XgxynQvLbbkV6QyeaZs
         ZOTpiCi0F4ssnGjVX9pmnyxsZFbe97Nbd66UqGHTlt3/9X2b83xfPAss2kTvzYIFZ0ur
         LUeuz/g936LNBG45cHJO2p6D2zMo4dZIdgQ3DHV7+mjKJs+ZuPoBVCcO7NLGRmu1w0u9
         fL3f4L46Xp7i91wVt4xaT1OvDjuU2AQ+IAirWcg8QmUginVj8QgFe61HNsylYGHc2tKU
         Y2qzRc7dPxIAGxs1tSL1N6ZSv00muswFXIW3CpMOqW/8g0w3wQzoI+gQftflRcTPa66z
         9DkQ==
X-Gm-Message-State: AOAM533+HXLaoCkTYX/OFXf6BRqXvfMx4G5RTKw2nvD+kJXZxLT1PD+V
        1/CTnaIwzIldveqNeiW8xJI/PdMTl+qkSOnwEorGG2QiO6tBsUFCuQK2z1IY40d1HSdLtubjK5e
        s6e/+3oSEoBLwcmvFVTqpG6oB
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr22224083pjt.30.1615171022626;
        Sun, 07 Mar 2021 18:37:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxyWJ5ARLYHECViOuZrdjRWC3Z1BPEm2Fsc3JcmbqCl+3rC0+udhl+NJJDYr9X0RekLDHAFg==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr22224071pjt.30.1615171022471;
        Sun, 07 Mar 2021 18:37:02 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f20sm8594922pfa.10.2021.03.07.18.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 18:37:02 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:36:50 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        Martin DEVERA <devik@eaxlabs.cz>
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
Message-ID: <20210308023650.GA3537842@xiangao.remote.csb>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
 <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Mar 08, 2021 at 09:29:30AM +0800, Chao Yu wrote:
> On 2021/3/6 12:04, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > Martin reported an issue that directory read could be hung on the
> > latest -rc kernel with some certain image. The root cause is that
> > commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
> > vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
> > is set as actual allocated vector number rather than the requested
> > number now.
> > 
> > Let's avoid using .bi_max_vecs completely instead.
> > 
> > Reported-by: Martin DEVERA <devik@eaxlabs.cz>
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> 
> Looks good to me, btw, it needs to Cc stable mailing list?
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 

Thanks for your review. <= 5.11 kernels are not impacted.
For now, this only impacts 5.12-rc due to a bio behavior
change (see commit baa2c7c97153). So personally I think
just leave as it is is fine.

Thanks,
Gao Xiang

> Thanks,
> 

