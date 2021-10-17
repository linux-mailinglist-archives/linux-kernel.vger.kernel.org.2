Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16342430A37
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbhJQPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242170AbhJQPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:34:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF03D60E74;
        Sun, 17 Oct 2021 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634484748;
        bh=FQ2C52uWsYrTnBdz5DRM1rNifGCmmzFajq3YqCREayE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7BAR9re4guIutpqLJG8nv77TlxxfKsQMgpx5AiWy0yRmGhx82DroeIfCwDMcDQXr
         VyIdfkOd5ZsfpriI5n+FIpGesu8zB0qppjLEKALyYaeOoa59FxPIz6PFWVjxVVTmVn
         VwgA01cULl4P5ApZjOHqsNxNd7WqLWDMtAkr8tKFvXXk0ANfZcLTsTFE4worJN6ML3
         0NKZN7+lU2e3wwJd/agu57XDWhyDoQDTFNpZL39McEgS3/O9GIRECV9H6PGX5OkWMA
         0HBQnE/xXR1XFnSaPLMZgEXm1+21XawKUGJWStaoUdjhnj3+HP/SxVZj+vYlXlitJj
         XTlZpb9wZuNFA==
Date:   Sun, 17 Oct 2021 23:32:05 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3 2/3] erofs: introduce the secondary compression head
Message-ID: <20211017153202.GA4054@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Chao Yu <chao@kernel.org>, Gao Xiang <xiang@kernel.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Yue Hu <zbestahu@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211008200839.24541-3-xiang@kernel.org>
 <20211009181209.23041-1-xiang@kernel.org>
 <c3ad3f92-6a35-acbb-923a-21611d232689@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3ad3f92-6a35-acbb-923a-21611d232689@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Sun, Oct 17, 2021 at 11:27:54PM +0800, Chao Yu wrote:
> On 2021/10/10 2:12, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
> > lcluster to indicate whether the whole pcluster is compressed or not.
> > 
> > In this patch, a new HEAD2 head type is introduced to specify another
> > compression algorithm other than the primary algorithm for each
> > compressed file, which can be used for upcoming LZMA compression and
> > LZ4 range dictionary compression for various data patterns.
> > 
> > It has been stayed in the EROFS roadmap for years. Complete it now!
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > v2: https://lore.kernel.org/r/20211008200839.24541-3-xiang@kernel.org
> > changes since v2:
> >   - simplify z_algorithmtype check suggested by Yue.
> > 
> >   fs/erofs/erofs_fs.h |  8 +++++---
> >   fs/erofs/zmap.c     | 38 ++++++++++++++++++++++++++------------
> >   2 files changed, 31 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index b0b23f41abc3..f579c8c78fff 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -21,11 +21,13 @@
> >   #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> >   #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
> >   #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> > +#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
> >   #define EROFS_ALL_FEATURE_INCOMPAT		\
> >   	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> >   	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> >   	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> > -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> > +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> > +	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
> >   #define EROFS_SB_EXTSLOT_SIZE	16
> > @@ -314,9 +316,9 @@ struct z_erofs_map_header {
> >    */
> >   enum {
> >   	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
> > -	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
> > +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
> >   	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
> > -	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
> > +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
> 
> It needs to update comments above as well.

okay, let me revise them now.

Thanks,
Gao XIang

> 
> Thanks,
